Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69BCC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 12:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh59s-0006qC-CE; Tue, 07 Jul 2026 08:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59o-0006ea-GM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wh59m-0005Ep-Sl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 08:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783428250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqxLaaRHIKjCdlZzhirT0UJUcgmElGDpq0GdCrkOR8o=;
 b=iC5l3at6sH1hxAF1BdSruO04MqIe0nJcjzYopXngjxceVDUp5+UeooJ0QOpbsEJ9T9/MQq
 iWPpBW3/5NMFRgUUVfEirVcV3tkdgT0ZA17ZR6aPYD9SF4Wf0IUdgPO6myv+/q2Jy2Vx33
 oJG2hmwljU82B+PYp9xBzHd7ZJ134EM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-X5MfJubePPeixCxQinMQbQ-1; Tue,
 07 Jul 2026 08:44:07 -0400
X-MC-Unique: X5MfJubePPeixCxQinMQbQ-1
X-Mimecast-MFC-AGG-ID: X5MfJubePPeixCxQinMQbQ_1783428246
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B2B81806CB1; Tue,  7 Jul 2026 12:44:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C24013691B; Tue,  7 Jul 2026 12:44:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 6/8] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data
 registers
Date: Tue,  7 Jul 2026 14:43:47 +0200
Message-ID: <20260707124349.662198-7-clg@redhat.com>
In-Reply-To: <20260707124349.662198-1-clg@redhat.com>
References: <20260707124349.662198-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Implement basic behavior for RNG_CTRL and RNG_DATA:

- RNG_CTRL allows guest to enable/disable the RNG via the DIS bit.
  Only bits [0:3] and bit 5 are writable; other bits are masked.
- The VLD bit (bit 31) is updated by the model to reflect the RNG
  enable state, and is not writable by the guest.
- When RNG is enabled, reads from RNG_DATA return a newly generated
  random value.
- When RNG is disabled, RNG_DATA return 0.

This provides a minimal functional model of the RNG sufficient for
software that expects readable random data without modeling full
hardware behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260706052701.1141740-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index ed7f5e648d44..5dbf81c0cec9 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -160,6 +160,11 @@
 #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)
 #define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)
 
+#define AST2700_SCUIO_RNG_CTRL          TO_REG(0xF0)
+#define AST2700_SCUIO_RNG_CTRL_MASK     0x2F
+#define AST2700_SCUIO_RNG_CTRL_DIS      BIT(0)
+#define AST2700_SCUIO_RNG_CTRL_VLD      BIT(31)
+#define AST2700_SCUIO_RNG_DATA          TO_REG(0xF4)
 #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)
 #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)
 #define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)
@@ -954,6 +959,14 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque, hwaddr offset,
         return 0;
     }
 
+    switch (reg) {
+    case AST2700_SCUIO_RNG_DATA:
+        if (!(s->regs[AST2700_SCUIO_RNG_CTRL] & AST2700_SCUIO_RNG_CTRL_DIS)) {
+            s->regs[AST2700_SCUIO_RNG_DATA] = aspeed_scu_get_random();
+        }
+        break;
+    }
+
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);
     return s->regs[reg];
 }
@@ -977,6 +990,18 @@ static void aspeed_ast2700_scuio_write(void *opaque, hwaddr offset,
     trace_aspeed_ast2700_scuio_write(offset, size, data);
 
     switch (reg) {
+    case AST2700_SCUIO_RNG_CTRL:
+        data &= AST2700_SCUIO_RNG_CTRL_MASK;
+        if (data & AST2700_SCUIO_RNG_CTRL_DIS) {
+            data &= ~AST2700_SCUIO_RNG_CTRL_VLD;
+            s->regs[AST2700_SCUIO_RNG_DATA] = 0;
+        } else {
+            s->regs[AST2700_SCUIO_RNG_DATA] = aspeed_scu_get_random();
+            data |= AST2700_SCUIO_RNG_CTRL_VLD;
+        }
+        s->regs[reg] = data;
+        updated = true;
+        break;
     case AST2700_SCUIO_CLK_STOP_CTL_1:
     case AST2700_SCUIO_CLK_STOP_CTL_2:
         s->regs[reg] |= data;
-- 
2.54.0


