Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E16FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbvZ-0006bI-6A; Fri, 04 Jul 2025 04:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvX-0006ZN-0V
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvV-0004NS-6O
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDx2m2jSEIYmvII7OglgnRLwRDtp3j0JRhj53e5bOqA=;
 b=Do7NQ0MFsAK5M5WbQVFuX4rijA9Ekl3frAnHNtogZj4v9QQb7W0oxBtGqUuuEO3jGh5GkW
 eSgBPhlu1omM8N4EDLF0X35hViy1ZmhzgQDqpUKB8zHazrpNT0s+4h1Kk1nIGROQNXY8bc
 R5ZrEzFfosNMLbZ+EZBI0OuEk1RP8oY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-d4Ho866YPYyWUEPW9IJP9w-1; Fri,
 04 Jul 2025 04:37:42 -0400
X-MC-Unique: d4Ho866YPYyWUEPW9IJP9w-1
X-Mimecast-MFC-AGG-ID: d4Ho866YPYyWUEPW9IJP9w_1751618261
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FA181944A82; Fri,  4 Jul 2025 08:37:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D96DD180045B; Fri,  4 Jul 2025 08:37:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tan Siewert <tan@siewert.io>, Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/11] hw/misc/aspeed_scu: Handle AST2600 protection key
 registers correctly
Date: Fri,  4 Jul 2025 10:37:17 +0200
Message-ID: <20250704083723.1410455-6-clg@redhat.com>
In-Reply-To: <20250704083723.1410455-1-clg@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tan Siewert <tan@siewert.io>

The AST2600 SCU has two protection key registers (0x00 and 0x10) that
both need to be unlocked. (Un-)locking 0x00 modifies both protection key
registers, while modifying 0x10 only modifies itself.

This commit updates the SCU write logic to reject writes unless both
protection key registers are unlocked, matching the behaviour of
real hardware.

Signed-off-by: Tan Siewert <tan@siewert.io>
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20250619085329.42125-1-tan@siewert.io
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 11d073910882..a0ab5eed8f17 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -91,6 +91,7 @@
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
 #define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_PROT_KEY2         TO_REG(0x10)
 #define AST2600_SILICON_REV       TO_REG(0x04)
 #define AST2600_SILICON_REV2      TO_REG(0x14)
 #define AST2600_SYS_RST_CTRL      TO_REG(0x40)
@@ -723,6 +724,8 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
+    bool prot_data_state = data == ASPEED_SCU_PROT_KEY;
+    bool unlocked = s->regs[AST2600_PROT_KEY] && s->regs[AST2600_PROT_KEY2];
 
     if (reg >= ASPEED_AST2600_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -731,15 +734,24 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
     }
 
-    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+    if ((reg != AST2600_PROT_KEY && reg != AST2600_PROT_KEY2) && !unlocked) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+        return;
     }
 
     trace_aspeed_scu_write(offset, size, data);
 
     switch (reg) {
     case AST2600_PROT_KEY:
-        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        /*
+         * Writing a value to SCU000 will modify both protection
+         * registers to each protection register individually.
+         */
+        s->regs[AST2600_PROT_KEY] = prot_data_state;
+        s->regs[AST2600_PROT_KEY2] = prot_data_state;
+        return;
+    case AST2600_PROT_KEY2:
+        s->regs[AST2600_PROT_KEY2] = prot_data_state;
         return;
     case AST2600_HW_STRAP1:
     case AST2600_HW_STRAP2:
-- 
2.50.0


