Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2753CC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtLb-0004z7-Qx; Mon, 21 Jul 2025 12:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIv-0004sL-1t
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIr-0001VC-37
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4P91xUOwhTWKJ4gGibaAj8HR9uDmnK4QlXLqudLjOJQ=;
 b=Z7QjF4eA5k3Jh1PsCejMrIY0BQ+rslTNtp2VDXWepgxqMY7Hh0ijDYJTxFq70/Z2U1rZfA
 RQBuJqImBmZRhkPu45dsTqI2ghFEVafi0IpRedqAWuhbJMtnw7OvgE4kYY6LyvVA15tISI
 RMzerLoXA9zMMRURhUiKNgeL+wqBig4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-o-Aj0uhTPC6ubbnMVIS8XA-1; Mon,
 21 Jul 2025 12:23:25 -0400
X-MC-Unique: o-Aj0uhTPC6ubbnMVIS8XA-1
X-Mimecast-MFC-AGG-ID: o-Aj0uhTPC6ubbnMVIS8XA_1753115004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49894195FD02; Mon, 21 Jul 2025 16:23:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFAFB195608D; Mon, 21 Jul 2025 16:23:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/50] ppc/xive: Fix pulling pool and phys contexts
Date: Mon, 21 Jul 2025 18:21:59 +0200
Message-ID: <20250721162233.686837-17-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

This improves the implementation of pulling pool and phys contexts in
XIVE1, by following closer the OS pulling code.

In particular, the old ring data is returned rather than the modified,
and irq signals are reset on pull.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-17-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c | 66 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8537cad27b2a..5483a815ef07 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -241,25 +241,75 @@ static uint64_t xive_tm_ack_hv_reg(XivePresenter *xptr, XiveTCTX *tctx,
     return xive_tctx_accept(tctx, TM_QW3_HV_PHYS);
 }
 
+static void xive_pool_cam_decode(uint32_t cam, uint8_t *nvt_blk,
+                                 uint32_t *nvt_idx, bool *vp)
+{
+    if (nvt_blk) {
+        *nvt_blk = xive_nvt_blk(cam);
+    }
+    if (nvt_idx) {
+        *nvt_idx = xive_nvt_idx(cam);
+    }
+    if (vp) {
+        *vp = !!(cam & TM_QW2W2_VP);
+    }
+}
+
+static uint32_t xive_tctx_get_pool_cam(XiveTCTX *tctx, uint8_t *nvt_blk,
+                                       uint32_t *nvt_idx, bool *vp)
+{
+    uint32_t qw2w2 = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
+    uint32_t cam = be32_to_cpu(qw2w2);
+
+    xive_pool_cam_decode(cam, nvt_blk, nvt_idx, vp);
+    return qw2w2;
+}
+
+static void xive_tctx_set_pool_cam(XiveTCTX *tctx, uint32_t qw2w2)
+{
+    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
+}
+
 static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                       hwaddr offset, unsigned size)
 {
-    uint32_t qw2w2_prev = xive_tctx_word2(&tctx->regs[TM_QW2_HV_POOL]);
     uint32_t qw2w2;
+    uint32_t qw2w2_new;
+    uint8_t nvt_blk;
+    uint32_t nvt_idx;
+    bool vp;
 
-    qw2w2 = xive_set_field32(TM_QW2W2_VP, qw2w2_prev, 0);
-    memcpy(&tctx->regs[TM_QW2_HV_POOL + TM_WORD2], &qw2w2, 4);
+    qw2w2 = xive_tctx_get_pool_cam(tctx, &nvt_blk, &nvt_idx, &vp);
+
+    if (!vp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid POOL NVT %x/%x !?\n",
+                      nvt_blk, nvt_idx);
+    }
+
+    /* Invalidate CAM line */
+    qw2w2_new = xive_set_field32(TM_QW2W2_VP, qw2w2, 0);
+    xive_tctx_set_pool_cam(tctx, qw2w2_new);
+
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
+    xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
     return qw2w2;
 }
 
 static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                       hwaddr offset, unsigned size)
 {
-    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
-    uint8_t qw3b8;
+    uint8_t qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    uint8_t qw3b8_new;
+
+    qw3b8 = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    if (!(qw3b8 & TM_QW3B8_VT)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid PHYS thread!?\n");
+    }
+    qw3b8_new = qw3b8 & ~TM_QW3B8_VT;
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8_new;
 
-    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
-    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
+    xive_tctx_reset_signal(tctx, TM_QW3_HV_PHYS);
     return qw3b8;
 }
 
@@ -489,7 +539,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     qw1w2 = xive_tctx_get_os_cam(tctx, &nvt_blk, &nvt_idx, &vo);
 
     if (!vo) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVT %x/%x !?\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pull invalid OS NVT %x/%x !?\n",
                       nvt_blk, nvt_idx);
     }
 
-- 
2.50.1


