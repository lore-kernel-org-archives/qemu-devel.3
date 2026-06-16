Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C103ECD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAW-0007Es-Rc; Tue, 16 Jun 2026 15:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZS-Mh
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ87-00010o-Oi
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-461a15bb819so939187f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636834; x=1782241634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m4Z8534aNzEYzyGhBE2zpgXQN+xhbZIG8IL744vqSUI=;
 b=MVIBgNHNMsrkpgDUHmEOjcbspbzKIxm6l1YZEjIWSayqzSAWu+IH8PVvA5VPXVPT31
 hqpfGYNWT7lXQO6H464Dcbpb6EQUnAFLtJwgTxtcf6FrfL4U+9DRDLfshp/M2LROT3+F
 Lf+Z4hperJEZKrAureQhytb1nrddKTWn4+mc9vGHJMGxNT+IL1TCfLyeYFdzuGM826Ej
 fOy0yP8KR8qX/aTIzIrSwQ6xFmR9Ps6h6kXaCfpXwwZ/RshfsHl44NLrjSCh6KcKIs9O
 l3JykZML5bMVTq4imowJ3g9xDW+mdjCQZa53VgjAzCFA2d7e4FVHfqGFEaggic+5aO5N
 uJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636834; x=1782241634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m4Z8534aNzEYzyGhBE2zpgXQN+xhbZIG8IL744vqSUI=;
 b=gGhXsxKhoKQB9BaLQCn79SzMze/mMqU2D1kwrMYYwqXjlrbI+9Wo7706/YRNuk8I9B
 /ndS5GTDFsyqO85+BoW8xYg619N5TIDs+n/67ljF0IAr/EZx3fuNZBCAm953WbiMZJ5C
 qAqQeivNv5qFEbVIRLgpKW2tviMlI/X4lLLFGQC/yebEFFOXkSLusPW08OM3OgU5QihK
 bJMAjxoRtcNHkFd+rsRsg9owe4K7pnMsT8uzoflJLIBuSXPRWLvJ0Eh4JrN+kYNgEQG9
 sW/+NTv7CBWXaNkZHsJtRU+WIAwghkhAA12hdypPJq6iRBOMLJb1SiyLcE1ioaKamjF+
 Fq8Q==
X-Gm-Message-State: AOJu0YyMVOZWTk+gpjidecAB9M7M2hQpYwQSF2fms0BQGe8oMDoN1kJv
 sWGFUnTMG4XxKuhAaVY1cnN054fFRxUtJKbjZ77v84gVe+uA58JvFhcKHrRONMbW/QworCa84vl
 /rId4
X-Gm-Gg: Acq92OHrYqrtk2BsEDx9jo1eYO8StmTHHi/SkZyM3A6pU9hroCKz4W9ERCIw1BGtBCG
 P20B8hRkWdejL5vq6J2tjVbGU7+NalVtCqoEoZYvEGzDqXRZo2lP4Wqp6Ayu4Y1LuhEo/Idl2Gg
 gPrneV4jap78aYcd5sSLUlrAn8uxX5kA7SWJxpWyWbhKNozDYY6NQVPUuPsD7PYNjbWbpNdqFGF
 bcjDw9fsqWIGvqdz3NMabAu+JuPnn5NjJJUPOIHGvlcrkon93iGRIHmNvBt0Puzzylz2/K625ds
 V7dDbQ8u4Vx321pWQRrhlAwNZEWP2GVoFKlSOiwv7iEQ9ie4cAhoh/gfAV5IbigUASR8isOI41w
 XOFWPdJuTsrxtcyf7FaK6zSlily/d1DuaXxEL1EpYvK7lJ6PYHptz1gCJtfwAW1BaHlSnwVTHFV
 iazYOumgfEtHbN2N6Mz0SFohKeVHH+g2odrvXs4xzdVZgvkLyi6bumXYajDNAN56kwS7c2JkjSr
 rbhee3t56KfVlxBUL3s19b5f/n7epA+
X-Received: by 2002:a05:6000:22c4:b0:45e:fb69:f02b with SMTP id
 ffacd0b85a97d-4623f2e7641mr941982f8f.1.1781636833814; 
 Tue, 16 Jun 2026 12:07:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/61] hw/arm/tegra241-cmdqv: Allocate HW VCMDQs once configured
Date: Tue, 16 Jun 2026 20:06:05 +0100
Message-ID: <20260616190639.3462006-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Add support for allocating IOMMUFD hardware queues when the guest
programs the VCMDQ BASE registers.

VCMDQ_EN lives in VCMDQ_CONFIG, which is on the VINTF Page0 region
that a later patch installs into guest MMIO — so QEMU won't trap its
writes. Allocate the hardware queue instead once all of these are
set: BASE programmed, CMDQ_ALLOC_MAP.ALLOC, and CMDQV / VINTF
enabled. Each precondition write retries the allocation, so the
guest may program them in any order.

iommufd_backend_alloc_hw_queue() needs the guest physical address of
the VCMDQ ring buffer, so allocation is deferred until the guest has
populated BASE.

If a hardware queue was previously allocated for the same VCMDQ,
free it before reallocation. All allocated VCMDQs are freed when
CMDQV or VINTF is disabled, when the ALLOC bit is cleared, or on reset.

On allocation failure, set CMDQ_INIT_ERR and clear CMDQ_EN_OK in the
cache so trapped guest reads see the failure rather than a queue
that looks live. Clear them on a later successful allocation. A guest
CMDQ_EN write then sets CMDQ_EN_OK only if CMDQ_INIT_ERR is clear.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-19-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 171 +++++++++++++++++++++++++++++++++++++---
 hw/arm/tegra241-cmdqv.h |  11 +++
 2 files changed, 171 insertions(+), 11 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 1f3d883cfe..8cb39e87c4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -16,6 +16,96 @@
 #include "tegra241-cmdqv.h"
 #include "trace.h"
 
+static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+    IOMMUFDHWqueue *vcmdq = cmdqv->vcmdq[index];
+
+    if (!vcmdq) {
+        return;
+    }
+    iommufd_backend_free_id(viommu->iommufd, vcmdq->hw_queue_id);
+    g_free(vcmdq);
+    cmdqv->vcmdq[index] = NULL;
+}
+
+/*
+ * A VCMDQ's HW queue can be allocated once the guest has programmed:
+ *  - VCMDQ_BASE (ring buffer GPA and size). This only checks that BASE is
+ *    non-zero, not that both the _L and _H halves have been written; a
+ *    half-written BASE may pass here, but the write of the second half
+ *    re-runs setup and reallocates with the complete address.
+ *  - the VINTF mapping (CMDQ_ALLOC_MAP.ALLOC).
+ *  - both the CMDQV global enable and the VINTF enable.
+ */
+static bool tegra241_cmdqv_vcmdq_ready_to_alloc(Tegra241CMDQV *cmdqv, int index)
+{
+    return cmdqv->vcmdq_base[index] &&
+           (cmdqv->cmdq_alloc_map[index] & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK) &&
+           tegra241_cmdqv_enabled(cmdqv) && tegra241_vintf_enabled(cmdqv);
+}
+
+/*
+ * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
+ * No-op (returns true) until the VCMDQ is ready to be allocated.
+ */
+static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
+                                       Error **errp)
+{
+    SMMUv3AccelState *accel = cmdqv->s_accel;
+    uint64_t base_mask = (uint64_t)R_VCMDQ0_BASE_L_ADDR_MASK |
+                         (uint64_t)R_VCMDQ0_BASE_H_ADDR_MASK << 32;
+    uint64_t addr = cmdqv->vcmdq_base[index] & base_mask;
+    uint64_t log2 = cmdqv->vcmdq_base[index] & R_VCMDQ0_BASE_L_LOG2SIZE_MASK;
+    uint64_t size = 1ULL << (log2 + 4);
+    IOMMUFDViommu *viommu = accel->viommu;
+    IOMMUFDHWqueue *hw_queue;
+    uint32_t hw_queue_id;
+
+    if (!tegra241_cmdqv_vcmdq_ready_to_alloc(cmdqv, index)) {
+        return true;
+    }
+
+    tegra241_cmdqv_free_vcmdq(cmdqv, index);
+
+    if (!iommufd_backend_alloc_hw_queue(viommu->iommufd, viommu->viommu_id,
+                                        IOMMU_HW_QUEUE_TYPE_TEGRA241_CMDQV,
+                                        index, addr, size, &hw_queue_id,
+                                        errp)) {
+        /* Record the failure in the cache. */
+        cmdqv->vcmdq_gerror[index] |= R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
+        cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        return false;
+    }
+    hw_queue = g_new(IOMMUFDHWqueue, 1);
+    hw_queue->hw_queue_id = hw_queue_id;
+    hw_queue->viommu = viommu;
+    cmdqv->vcmdq[index] = hw_queue;
+
+    cmdqv->vcmdq_gerror[index] &= ~R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK;
+    cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+
+    return true;
+}
+
+static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
+{
+    /* uapi/linux/iommufd.h: hw_queue destroy must be in descending @index. */
+    for (int i = (TEGRA241_CMDQV_MAX_CMDQ - 1); i >= 0; i--) {
+        tegra241_cmdqv_free_vcmdq(cmdqv, i);
+    }
+}
+
+static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
+                                           Error **errp)
+{
+    for (int i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
+        if (!tegra241_cmdqv_setup_vcmdq(cmdqv, i, errp)) {
+            return;
+        }
+    }
+}
+
 /*
  * Read a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
  *
@@ -143,7 +233,12 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
         break;
     case A_VCMDQ0_CONFIG:
         if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
-            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            /* Report init error if any. */
+            if (!(cmdqv->vcmdq_gerror[index] &
+                  R_VCMDQ0_GERROR_CMDQ_INIT_ERR_MASK)) {
+                cmdqv->vcmdq_status[index] |=
+                    R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+            }
         } else {
             cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
         }
@@ -167,16 +262,19 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
-                                             uint32_t value, bool direct)
+                                             uint32_t value, bool direct,
+                                             Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_BASE_H:
         cmdqv->vcmdq_base[index] =
             deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] =
@@ -200,11 +298,13 @@ static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
  */
 static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index,
-                                                uint64_t value, bool direct)
+                                                uint64_t value, bool direct,
+                                                Error **errp)
 {
     switch (offset0) {
     case A_VCMDQ0_BASE_L:
         cmdqv->vcmdq_base[index] = value;
+        tegra241_cmdqv_setup_vcmdq(cmdqv, index, errp);
         break;
     case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
         cmdqv->vcmdq_cons_indx_base[index] = value;
@@ -219,7 +319,8 @@ static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
 }
 
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
-                                              hwaddr offset, uint64_t value)
+                                              hwaddr offset, uint64_t value,
+                                              Error **errp)
 {
     int i;
 
@@ -235,7 +336,13 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
             cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+            /*
+             * VCMDQs whose BASE was programmed before VINTF was
+             * enabled need their hw_queue allocated now.
+             */
+            tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -341,6 +448,7 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -348,18 +456,39 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         cmdqv->config = value;
         if (value & R_CONFIG_CMDQV_EN_MASK) {
             cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+            /*
+             * VCMDQs whose BASE was programmed before CMDQV was enabled
+             * need their hw_queue allocated now.
+             */
+            tegra241_cmdqv_setup_all_vcmdq(cmdqv, &local_err);
         } else {
+            tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
         }
         break;
     case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
         cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
         break;
-    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
-        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1: {
+        int idx = (offset - A_CMDQ_ALLOC_MAP_0) / 4;
+        bool was_alloc = cmdqv->cmdq_alloc_map[idx] &
+                         R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
+        bool now_alloc = value & R_CMDQ_ALLOC_MAP_0_ALLOC_MASK;
+
+        cmdqv->cmdq_alloc_map[idx] = value;
+        /*
+         * If the VCMDQ was already programmed (BASE) before mapping, fire
+         * setup on the ALLOC 0->1 transition; tear down on 1->0.
+         */
+        if (!was_alloc && now_alloc) {
+            tegra241_cmdqv_setup_vcmdq(cmdqv, idx, &local_err);
+        } else if (was_alloc && !now_alloc) {
+            tegra241_cmdqv_free_vcmdq(cmdqv, idx);
+        }
         break;
+    }
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /*
@@ -387,17 +516,23 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
+                &local_err);
         break;
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
+                &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 /*
@@ -407,6 +542,7 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
+    Error *local_err = NULL;
     int index;
 
     switch (offset) {
@@ -419,18 +555,24 @@ static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
         offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false,
+                &local_err);
         break;
     case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
         index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
         tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
-                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true,
+                &local_err);
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
@@ -535,6 +677,13 @@ free_viommu:
 
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
+    Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
+
+    if (!cmdqv) {
+        return;
+    }
+
+    tegra241_cmdqv_free_all_vcmdq(cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index c4d327a9a5..84499b840d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -47,6 +47,7 @@ typedef struct Tegra241CMDQV {
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
+    IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
 
     /* CMDQ-V Config page register cache */
@@ -364,6 +365,16 @@ SMMU_CMDQV_VI_VCMDQi_BASE_H_(1)
 SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_L_(1)
 SMMU_CMDQV_VI_VCMDQi_CONS_INDX_BASE_DRAM_H_(1)
 
+static inline bool tegra241_cmdqv_enabled(Tegra241CMDQV *cmdqv)
+{
+    return cmdqv->status & R_STATUS_CMDQV_ENABLED_MASK;
+}
+
+static inline bool tegra241_vintf_enabled(Tegra241CMDQV *cmdqv)
+{
+    return cmdqv->vintf_status & R_VINTF0_STATUS_ENABLE_OK_MASK;
+}
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
-- 
2.43.0


