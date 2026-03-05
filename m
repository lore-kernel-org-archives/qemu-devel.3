Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D8F47CA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCxe-0008As-D8; Thu, 05 Mar 2026 12:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxJ-0007XA-Tz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxH-0003ZD-KS
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47an3b/PQ2lQdrCnKgF9UWsrwpElW+uBBwdjpJ1uWKY=;
 b=He1DmxtiesdRN00S8ZkIneJ9/UnASvB4poLhQ05WAqntw+ETNiuNM6e84lMuTopYMu85+s
 jGH4D1AZPWHVa1x7vLPXirAqQ4fWYRUXlPrIGq2FW6IoMLZa9icf3WSxdQFpQDh6obSxn+
 v9G7Q0LyFkhovgsl4UJaEGnD4q6Yq7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-IxElKDkyP-a__0Od9lPJhg-1; Thu,
 05 Mar 2026 12:57:42 -0500
X-MC-Unique: IxElKDkyP-a__0Od9lPJhg-1
X-Mimecast-MFC-AGG-ID: IxElKDkyP-a__0Od9lPJhg_1772733459
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFB301800365; Thu,  5 Mar 2026 17:57:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EE903003E9E; Thu,  5 Mar 2026 17:57:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Joe Komlodi <komlodi@google.com>,
 Patrick Venture <venture@google.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/38] hw/i3c/aspeed_i3c: Add register RO field masks
Date: Thu,  5 Mar 2026 18:56:42 +0100
Message-ID: <20260305175711.1119025-10-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Adds read-only register masks for the Aspeed I3C controller registers.

Signed-off-by: Joe Komlodi <komlodi@google.com>
Reviewed-by: Patrick Venture <venture@google.com>
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i3c/aspeed_i3c.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/i3c/aspeed_i3c.c b/hw/i3c/aspeed_i3c.c
index a21570028887..2700c5f4cdeb 100644
--- a/hw/i3c/aspeed_i3c.c
+++ b/hw/i3c/aspeed_i3c.c
@@ -74,6 +74,21 @@ REG32(I3C6_REG1, 0x64)
     FIELD(I3C6_REG1, SA_EN,         15, 1)
     FIELD(I3C6_REG1, INST_ID,       16, 4)
 
+static const uint32_t ast2600_i3c_controller_ro[ASPEED_I3C_NR_REGS] = {
+    [R_I3C1_REG0]                   = 0xcc000000,
+    [R_I3C1_REG1]                   = 0xfff00000,
+    [R_I3C2_REG0]                   = 0xcc000000,
+    [R_I3C2_REG1]                   = 0xfff00000,
+    [R_I3C3_REG0]                   = 0xcc000000,
+    [R_I3C3_REG1]                   = 0xfff00000,
+    [R_I3C4_REG0]                   = 0xcc000000,
+    [R_I3C4_REG1]                   = 0xfff00000,
+    [R_I3C5_REG0]                   = 0xcc000000,
+    [R_I3C5_REG1]                   = 0xfff00000,
+    [R_I3C6_REG0]                   = 0xcc000000,
+    [R_I3C6_REG1]                   = 0xfff00000,
+};
+
 static uint64_t aspeed_i3c_read(void *opaque, hwaddr addr, unsigned int size)
 {
     AspeedI3CState *s = ASPEED_I3C(opaque);
@@ -97,6 +112,7 @@ static void aspeed_i3c_write(void *opaque,
 
     addr >>= 2;
 
+    data &= ~ast2600_i3c_controller_ro[addr];
     /* I3C controller register */
     switch (addr) {
     case R_I3C1_REG1:
-- 
2.53.0


