Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E83C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJP-0006Cc-4Z; Mon, 21 Jul 2025 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIv-0004sK-1t
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIp-0001XX-OE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd1iNcZC0N9VKbrwXqHYfPlyCqr8C4u9TzFB9ZV+KSY=;
 b=iR1ZYa8RkBlMt+I9L0a4Gt+U1Qejo8sWXL86WPUFfqe0Dtn2yPSd6aRx1Y2932ijdqO5xh
 ggIZWkJfdCTSs7dZbR4Eir7dJ1ZfYyZ9bXgexRjz56Akux/51n9PYO0L824KGK+xRaV4N5
 J6ziS9fosDQJl+EYQNLWIpJswl5buBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-wAz6JxDTM-6YUVFDguNR4A-1; Mon,
 21 Jul 2025 12:23:40 -0400
X-MC-Unique: wAz6JxDTM-6YUVFDguNR4A-1
X-Mimecast-MFC-AGG-ID: wAz6JxDTM-6YUVFDguNR4A_1753115019
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E52531800C2F; Mon, 21 Jul 2025 16:23:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0C3B195608D; Mon, 21 Jul 2025 16:23:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/50] ppc/xive2: add interrupt priority configuration flags
Date: Mon, 21 Jul 2025 18:22:04 +0200
Message-ID: <20250721162233.686837-22-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Adds support for extracting additional configuration flags from
the XIVE configuration register that are needed for redistribution
of group interrupts.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-22-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/pnv_xive2_regs.h |  1 +
 include/hw/ppc/xive2.h   |  8 +++++---
 hw/intc/pnv_xive2.c      | 16 ++++++++++++----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index e8b87b3d2c13..d53300f709b0 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -66,6 +66,7 @@
 #define    CQ_XIVE_CFG_GEN1_TIMA_HYP_BLK0       PPC_BIT(26) /* 0 if bit[25]=0 */
 #define    CQ_XIVE_CFG_GEN1_TIMA_CROWD_DIS      PPC_BIT(27) /* 0 if bit[25]=0 */
 #define    CQ_XIVE_CFG_GEN1_END_ESX             PPC_BIT(28)
+#define    CQ_XIVE_CFG_EN_VP_GRP_PRIORITY       PPC_BIT(32) /* 0 if bit[25]=1 */
 #define    CQ_XIVE_CFG_EN_VP_SAVE_RESTORE       PPC_BIT(38) /* 0 if bit[25]=1 */
 #define    CQ_XIVE_CFG_EN_VP_SAVE_REST_STRICT   PPC_BIT(39) /* 0 if bit[25]=1 */
 
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 2436ddb5e53c..760b94a962e7 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -29,9 +29,11 @@ OBJECT_DECLARE_TYPE(Xive2Router, Xive2RouterClass, XIVE2_ROUTER);
  * Configuration flags
  */
 
-#define XIVE2_GEN1_TIMA_OS      0x00000001
-#define XIVE2_VP_SAVE_RESTORE   0x00000002
-#define XIVE2_THREADID_8BITS    0x00000004
+#define XIVE2_GEN1_TIMA_OS          0x00000001
+#define XIVE2_VP_SAVE_RESTORE       0x00000002
+#define XIVE2_THREADID_8BITS        0x00000004
+#define XIVE2_EN_VP_GRP_PRIORITY    0x00000008
+#define XIVE2_VP_INT_PRIO           0x00000030
 
 typedef struct Xive2RouterClass {
     SysBusDeviceClass parent;
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 386175a68b29..7b4a33228e05 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -605,20 +605,28 @@ static uint32_t pnv_xive2_get_config(Xive2Router *xrtr)
 {
     PnvXive2 *xive = PNV_XIVE2(xrtr);
     uint32_t cfg = 0;
+    uint64_t reg = xive->cq_regs[CQ_XIVE_CFG >> 3];
 
-    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
+    if (reg & CQ_XIVE_CFG_GEN1_TIMA_OS) {
         cfg |= XIVE2_GEN1_TIMA_OS;
     }
 
-    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
+    if (reg & CQ_XIVE_CFG_EN_VP_SAVE_RESTORE) {
         cfg |= XIVE2_VP_SAVE_RESTORE;
     }
 
-    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE,
-              xive->cq_regs[CQ_XIVE_CFG >> 3]) == CQ_XIVE_CFG_THREADID_8BITS) {
+    if (GETFIELD(CQ_XIVE_CFG_HYP_HARD_RANGE, reg) ==
+                      CQ_XIVE_CFG_THREADID_8BITS) {
         cfg |= XIVE2_THREADID_8BITS;
     }
 
+    if (reg & CQ_XIVE_CFG_EN_VP_GRP_PRIORITY) {
+        cfg |= XIVE2_EN_VP_GRP_PRIORITY;
+    }
+
+    cfg = SETFIELD(XIVE2_VP_INT_PRIO, cfg,
+                   GETFIELD(CQ_XIVE_CFG_VP_INT_PRIO, reg));
+
     return cfg;
 }
 
-- 
2.50.1


