Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4B6C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMm-0007IZ-Lr; Mon, 21 Jul 2025 12:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJn-00086x-CY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJj-0001mE-N1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8QInPeFo3Ev22hIbUsAozyIHN3IzM2Yz7Z8Umcgpl2s=;
 b=ZTuqJlhV+JrcXn25pJpSDXtUjs9BFaf0vw1V5E2wS8TbjuTtFp0YWvg5+Mn4jL1EQsasuK
 4EnyoGF1pKeMuKhFu9kDfYvyHt9d1onHwLoRsoxs+dLRdLUtj9CWE6dTe6SY90hm614AlQ
 LtSYJTzk5LLojMwwmNTru6mx0A5gp2g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-Kp-LSHdrNc-AzQ30At6UNQ-1; Mon,
 21 Jul 2025 12:24:40 -0400
X-MC-Unique: Kp-LSHdrNc-AzQ30At6UNQ-1
X-Mimecast-MFC-AGG-ID: Kp-LSHdrNc-AzQ30At6UNQ_1753115079
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85178195608B; Mon, 21 Jul 2025 16:24:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51CD219560AD; Mon, 21 Jul 2025 16:24:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 43/50] ppc/xive: Check TIMA operations validity
Date: Mon, 21 Jul 2025 18:22:26 +0200
Message-ID: <20250721162233.686837-44-clg@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

Certain TIMA operations should only be performed when a ring is valid,
others when the ring is invalid, and they are considered undefined if
used incorrectly. Add checks for this condition.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-44-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h |   1 +
 hw/intc/xive.c        | 196 +++++++++++++++++++++++++-----------------
 2 files changed, 116 insertions(+), 81 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 2372d1014bd2..b7ca8544e431 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -365,6 +365,7 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
     return *((uint32_t *) &ring[TM_WORD2]);
 }
 
+bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring);
 bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
 bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
 uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 50a38bbf2ef9..6589c0a523c9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -25,6 +25,19 @@
 /*
  * XIVE Thread Interrupt Management context
  */
+bool xive_ring_valid(XiveTCTX *tctx, uint8_t ring)
+{
+    uint8_t cur_ring;
+
+    for (cur_ring = ring; cur_ring <= TM_QW3_HV_PHYS;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        if (!(tctx->regs[cur_ring + TM_WORD2] & 0x80)) {
+            return false;
+        }
+    }
+    return true;
+}
+
 bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
 {
     switch (ring) {
@@ -663,6 +676,8 @@ typedef struct XiveTmOp {
     uint8_t  page_offset;
     uint32_t op_offset;
     unsigned size;
+    bool     hw_ok;
+    bool     sw_ok;
     void     (*write_handler)(XivePresenter *xptr, XiveTCTX *tctx,
                               hwaddr offset,
                               uint64_t value, unsigned size);
@@ -675,34 +690,34 @@ static const XiveTmOp xive_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
-                                                     xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
+      xive_tm_set_os_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
+      xive_tm_push_os_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
+      xive_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, false, true,
+      xive_tm_vt_push, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
+      NULL, xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                     xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
-                                                     xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
-                                                     xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
-                                                     xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive_tm_pull_phys_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
+      NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
+      xive_tm_set_os_pending, NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
+      NULL, xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
+      NULL, xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
+      NULL, xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
+      NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
+      NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
+      NULL, xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -710,52 +725,48 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
-                                                     NULL },
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cppr,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
-                                                     xive_tm_vt_poll },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
-                                                     NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, true, true,
+      xive2_tm_set_os_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, true, true,
+      xive2_tm_push_os_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, true, true,
+      xive2_tm_push_os_ctx, NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
+      xive_tm_set_os_lgs, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
+      xive2_tm_set_hv_cppr, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
+      NULL, xive_tm_vt_poll },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, true, true,
+      xive2_tm_set_hv_target, NULL },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                   xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
-                                                     xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
-                                                     xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive2_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
-                                                     NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
-                                                     xive2_tm_pull_phys_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive2_tm_pull_phys_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
-                                                     NULL },
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
-                                                     NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
+      NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, true, false,
+      NULL, xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, true, false,
+      NULL, xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, true, false,
+      NULL, xive2_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, true, false,
+      xive2_tm_pull_os_ctx_ol, NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, true, false,
+      NULL, xive2_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, true, false,
+      NULL, xive2_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, true, false,
+      xive2_tm_pull_phys_ctx_ol, NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, true, false,
+      xive2_tm_ack_os_el, NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
@@ -797,18 +808,28 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                         uint64_t value, unsigned size)
 {
     const XiveTmOp *xto;
+    uint8_t ring = offset & TM_RING_OFFSET;
+    bool is_valid = xive_ring_valid(tctx, ring);
+    bool hw_owned = is_valid;
 
     trace_xive_tctx_tm_write(tctx->cs->cpu_index, offset, size, value);
 
-    /*
-     * TODO: check V bit in Q[0-3]W2
-     */
-
     /*
      * First, check for special operations in the 2K region
      */
+    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
+    if (xto) {
+        if (hw_owned && !xto->hw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+        if (!hw_owned && !xto->sw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to SW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+    }
+
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(tctx->xptr, offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
                           "@%"HWADDR_PRIx" size %d\n", offset, size);
@@ -821,7 +842,6 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(tctx->xptr, offset, size, true);
     if (xto) {
         xto->write_handler(xptr, tctx, offset, value, size);
         return;
@@ -830,6 +850,11 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Finish with raw access to the register values
      */
+    if (hw_owned) {
+        /* Store context operations are dangerous when context is valid */
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined write to HW TIMA "
+                      "@%"HWADDR_PRIx" size %d\n", offset, size);
+    }
     xive_tm_raw_write(tctx, offset, value, size);
 }
 
@@ -837,17 +862,27 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            unsigned size)
 {
     const XiveTmOp *xto;
+    uint8_t ring = offset & TM_RING_OFFSET;
+    bool is_valid = xive_ring_valid(tctx, ring);
+    bool hw_owned = is_valid;
     uint64_t ret;
 
-    /*
-     * TODO: check V bit in Q[0-3]W2
-     */
+    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
+    if (xto) {
+        if (hw_owned && !xto->hw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to HW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+        if (!hw_owned && !xto->sw_ok) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: undefined read to SW TIMA "
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
+        }
+    }
 
     /*
      * First, check for special operations in the 2K region
      */
     if (offset & TM_SPECIAL_OP) {
-        xto = xive_tm_find_op(tctx->xptr, offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
                           "@%"HWADDR_PRIx" size %d\n", offset, size);
@@ -860,7 +895,6 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * Then, for special operations in the region below 2K.
      */
-    xto = xive_tm_find_op(tctx->xptr, offset, size, false);
     if (xto) {
         ret = xto->read_handler(xptr, tctx, offset, size);
         goto out;
-- 
2.50.1


