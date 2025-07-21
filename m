Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB83C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKB-00010b-Lr; Mon, 21 Jul 2025 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIz-0005JB-6I
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIv-0001Zj-TF
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZbQlkH2kV33T/Osdjmait2KYKih6VX6OQ5Yd5M/d8MU=;
 b=h4WMZ5nof5HEmhiDPYRVIa29mi7UHEPlxX1+BwpKj0Z1+HnhQ0IFBBAcB69N52lEcz9Imt
 XZu0puF2rIEpPP0KZhollFLB7W8Jaw3TTV9xDnT4cuTxptWL5IwrqCOFrogowbfCptQNXU
 TAVJ8T0ZzVxm9EQpf54y0SwSiOD/760=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-gVFe9pniMJmp4aLv9qewGw-1; Mon,
 21 Jul 2025 12:23:51 -0400
X-MC-Unique: gVFe9pniMJmp4aLv9qewGw-1
X-Mimecast-MFC-AGG-ID: gVFe9pniMJmp4aLv9qewGw_1753115029
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D45AD18002B6; Mon, 21 Jul 2025 16:23:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A04CA195608D; Mon, 21 Jul 2025 16:23:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/50] ppc/xive2: Implement "Ack OS IRQ to even report line"
 TIMA op
Date: Mon, 21 Jul 2025 18:22:08 +0200
Message-ID: <20250721162233.686837-26-clg@redhat.com>
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

Booting AIX in a PowerVM partition requires the use of the "Acknowledge
O/S Interrupt to even O/S reporting line" special operation provided by
the IBM XIVE interrupt controller. This operation is invoked by writing
a byte (data is irrelevant) to offset 0xC10 of the Thread Interrupt
Management Area (TIMA). It can be used by software to notify the XIVE
logic that the interrupt was received.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-26-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h  |  1 +
 include/hw/ppc/xive2.h |  3 ++-
 hw/intc/xive.c         |  8 ++++---
 hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 28f0f1b79ad7..46d05d74fbfb 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -561,6 +561,7 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
 
 /*
  * KVM XIVE device helpers
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 760b94a962e7..ff02ce254984 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -142,5 +142,6 @@ void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, uint64_t value, unsigned size);
-
+void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
+                        hwaddr offset, uint64_t value, unsigned size);
 #endif /* PPC_XIVE2_H */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d65394651650..8b705727ae2d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -80,7 +80,7 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
         }
 }
 
-static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
     uint8_t nsr = regs[TM_NSR];
@@ -340,14 +340,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
 
 static const uint8_t xive_tm_hw_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
-    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
     0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
 };
 
 static const uint8_t xive_tm_hv_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
-    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
     0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
 };
@@ -718,6 +718,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
                                                      NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 1f4713dabeb1..e7e364c13e7d 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1009,6 +1009,56 @@ static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
     return 0;
 }
 
+static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
+                                 uint8_t ring, uint8_t cl_ring)
+{
+    uint64_t rd;
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvp_blk, nvp_idx, xive2_cfg;
+    Xive2Nvp nvp;
+    uint64_t phys_addr;
+    uint8_t OGen = 0;
+
+    xive2_tctx_get_nvp_indexes(tctx, cl_ring, &nvp_blk, &nvp_idx);
+
+    if (xive2_router_get_nvp(xrtr, (uint8_t)nvp_blk, nvp_idx, &nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+    if (!xive2_nvp_is_valid(&nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+
+    rd = xive_tctx_accept(tctx, ring);
+
+    if (ring == TM_QW1_OS) {
+        OGen = tctx->regs[ring + TM_OGEN];
+    }
+    xive2_cfg = xive2_router_get_config(xrtr);
+    phys_addr = xive2_nvp_reporting_addr(&nvp);
+    uint8_t report_data[REPORT_LINE_GEN1_SIZE];
+    memset(report_data, 0xff, sizeof(report_data));
+    if ((OGen == 1) || (xive2_cfg & XIVE2_GEN1_TIMA_OS)) {
+        report_data[8] = (rd >> 8) & 0xff;
+        report_data[9] = rd & 0xff;
+    } else {
+        report_data[0] = (rd >> 8) & 0xff;
+        report_data[1] = rd & 0xff;
+    }
+    cpu_physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_SIZE);
+}
+
+void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
+                        hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
+}
+
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
-- 
2.50.1


