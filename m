Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2105DCD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQmm-0006La-U5; Wed, 10 Apr 2024 01:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQm9-0005B4-8I; Wed, 10 Apr 2024 01:45:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlz-0001dy-Lt; Wed, 10 Apr 2024 01:45:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E1B85D4E6;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5162AB014D;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182043 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 14/41] hw/nvme: clean up confusing use of
 errp/local_err
Date: Wed, 10 Apr 2024 08:43:35 +0300
Message-Id: <20240410054416.4181891-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Remove an unnecessary local Error value in nvme_realize(). In the
process, change nvme_check_constraints() to return a bool.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 784fd35387e9e6b42e3f365ddf44263eb25de8f7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: needed for v8.2.0-2319-gfa905f65c5
 "hw/nvme: add machine compatibility parameter to enable msix exclusive bar")

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a87f79296c..75180823a6 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6980,7 +6980,7 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
-static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
+static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 {
     NvmeParams *params = &n->params;
 
@@ -6994,38 +6994,38 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
     if (n->namespace.blkconf.blk && n->subsys) {
         error_setg(errp, "subsystem support is unavailable with legacy "
                    "namespace ('drive' property)");
-        return;
+        return false;
     }
 
     if (params->max_ioqpairs < 1 ||
         params->max_ioqpairs > NVME_MAX_IOQPAIRS) {
         error_setg(errp, "max_ioqpairs must be between 1 and %d",
                    NVME_MAX_IOQPAIRS);
-        return;
+        return false;
     }
 
     if (params->msix_qsize < 1 ||
         params->msix_qsize > PCI_MSIX_FLAGS_QSIZE + 1) {
         error_setg(errp, "msix_qsize must be between 1 and %d",
                    PCI_MSIX_FLAGS_QSIZE + 1);
-        return;
+        return false;
     }
 
     if (!params->serial) {
         error_setg(errp, "serial property not set");
-        return;
+        return false;
     }
 
     if (n->pmr.dev) {
         if (host_memory_backend_is_mapped(n->pmr.dev)) {
             error_setg(errp, "can't use already busy memdev: %s",
                        object_get_canonical_path_component(OBJECT(n->pmr.dev)));
-            return;
+            return false;
         }
 
         if (!is_power_of_2(n->pmr.dev->size)) {
             error_setg(errp, "pmr backend size needs to be power of 2 in size");
-            return;
+            return false;
         }
 
         host_memory_backend_set_mapped(n->pmr.dev, true);
@@ -7034,64 +7034,64 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
     if (n->params.zasl > n->params.mdts) {
         error_setg(errp, "zoned.zasl (Zone Append Size Limit) must be less "
                    "than or equal to mdts (Maximum Data Transfer Size)");
-        return;
+        return false;
     }
 
     if (!n->params.vsl) {
         error_setg(errp, "vsl must be non-zero");
-        return;
+        return false;
     }
 
     if (params->sriov_max_vfs) {
         if (!n->subsys) {
             error_setg(errp, "subsystem is required for the use of SR-IOV");
-            return;
+            return false;
         }
 
         if (params->sriov_max_vfs > NVME_MAX_VFS) {
             error_setg(errp, "sriov_max_vfs must be between 0 and %d",
                        NVME_MAX_VFS);
-            return;
+            return false;
         }
 
         if (params->cmb_size_mb) {
             error_setg(errp, "CMB is not supported with SR-IOV");
-            return;
+            return false;
         }
 
         if (n->pmr.dev) {
             error_setg(errp, "PMR is not supported with SR-IOV");
-            return;
+            return false;
         }
 
         if (!params->sriov_vq_flexible || !params->sriov_vi_flexible) {
             error_setg(errp, "both sriov_vq_flexible and sriov_vi_flexible"
                        " must be set for the use of SR-IOV");
-            return;
+            return false;
         }
 
         if (params->sriov_vq_flexible < params->sriov_max_vfs * 2) {
             error_setg(errp, "sriov_vq_flexible must be greater than or equal"
                        " to %d (sriov_max_vfs * 2)", params->sriov_max_vfs * 2);
-            return;
+            return false;
         }
 
         if (params->max_ioqpairs < params->sriov_vq_flexible + 2) {
             error_setg(errp, "(max_ioqpairs - sriov_vq_flexible) must be"
                        " greater than or equal to 2");
-            return;
+            return false;
         }
 
         if (params->sriov_vi_flexible < params->sriov_max_vfs) {
             error_setg(errp, "sriov_vi_flexible must be greater than or equal"
                        " to %d (sriov_max_vfs)", params->sriov_max_vfs);
-            return;
+            return false;
         }
 
         if (params->msix_qsize < params->sriov_vi_flexible + 1) {
             error_setg(errp, "(msix_qsize - sriov_vi_flexible) must be"
                        " greater than or equal to 1");
-            return;
+            return false;
         }
 
         if (params->sriov_max_vi_per_vf &&
@@ -7099,7 +7099,7 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
             error_setg(errp, "sriov_max_vi_per_vf must meet:"
                        " (sriov_max_vi_per_vf - 1) %% %d == 0 and"
                        " sriov_max_vi_per_vf >= 1", NVME_VF_RES_GRANULARITY);
-            return;
+            return false;
         }
 
         if (params->sriov_max_vq_per_vf &&
@@ -7108,9 +7108,11 @@ static void nvme_check_constraints(NvmeCtrl *n, Error **errp)
             error_setg(errp, "sriov_max_vq_per_vf must meet:"
                        " (sriov_max_vq_per_vf - 1) %% %d == 0 and"
                        " sriov_max_vq_per_vf >= 2", NVME_VF_RES_GRANULARITY);
-            return;
+            return false;
         }
     }
+
+    return true;
 }
 
 static void nvme_init_state(NvmeCtrl *n)
@@ -7509,7 +7511,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
     NvmeNamespace *ns;
-    Error *local_err = NULL;
     NvmeCtrl *pn = NVME(pcie_sriov_get_pf(pci_dev));
 
     if (pci_is_vf(pci_dev)) {
@@ -7521,9 +7522,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         n->subsys = pn->subsys;
     }
 
-    nvme_check_constraints(n, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!nvme_check_params(n, errp)) {
         return;
     }
 
@@ -7531,7 +7530,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
               &pci_dev->qdev, n->parent_obj.qdev.id);
 
     if (nvme_init_subsys(n, errp)) {
-        error_propagate(errp, local_err);
         return;
     }
     nvme_init_state(n);
-- 
2.39.2


