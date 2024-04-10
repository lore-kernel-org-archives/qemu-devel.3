Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B267CD1297
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQmc-0005jK-GG; Wed, 10 Apr 2024 01:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlv-00053y-Cl; Wed, 10 Apr 2024 01:45:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlt-0001hI-PT; Wed, 10 Apr 2024 01:45:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D3225D4E7;
 Wed, 10 Apr 2024 08:46:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 63452B014E;
 Wed, 10 Apr 2024 08:44:17 +0300 (MSK)
Received: (nullmailer pid 4182046 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 15/41] hw/nvme: cleanup error reporting in
 nvme_init_pci()
Date: Wed, 10 Apr 2024 08:43:36 +0300
Message-Id: <20240410054416.4181891-15-mjt@tls.msk.ru>
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

Replace the local Error variable with errp and ERRP_GUARD() and change
the return value to bool.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 973f76cf7743545a5d8a0a8bfdfe2cd02aa3e238)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: needed for v8.2.0-2319-gfa905f65c5
 "hw/nvme: add machine compatibility parameter to enable msix exclusive bar")

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 75180823a6..f2b308f5fa 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7288,15 +7288,14 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     return 0;
 }
 
-static int nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
+static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
+    ERRP_GUARD();
     uint8_t *pci_conf = pci_dev->config;
     uint64_t bar_size;
     unsigned msix_table_offset, msix_pba_offset;
     int ret;
 
-    Error *err = NULL;
-
     pci_conf[PCI_INTERRUPT_PIN] = 1;
     pci_config_set_prog_interface(pci_conf, 0x2);
 
@@ -7333,14 +7332,14 @@ static int nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     }
     ret = msix_init(pci_dev, n->params.msix_qsize,
                     &n->bar0, 0, msix_table_offset,
-                    &n->bar0, 0, msix_pba_offset, 0, &err);
-    if (ret < 0) {
-        if (ret == -ENOTSUP) {
-            warn_report_err(err);
-        } else {
-            error_propagate(errp, err);
-            return ret;
-        }
+                    &n->bar0, 0, msix_pba_offset, 0, errp);
+    if (ret == -ENOTSUP) {
+        /* report that msix is not supported, but do not error out */
+        warn_report_err(*errp);
+        *errp = NULL;
+    } else if (ret < 0) {
+        /* propagate error to caller */
+        return false;
     }
 
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
@@ -7357,7 +7356,7 @@ static int nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_sriov(n, pci_dev, 0x120);
     }
 
-    return 0;
+    return true;
 }
 
 static void nvme_init_subnqn(NvmeCtrl *n)
@@ -7533,7 +7532,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
         return;
     }
     nvme_init_state(n);
-    if (nvme_init_pci(n, pci_dev, errp)) {
+    if (!nvme_init_pci(n, pci_dev, errp)) {
         return;
     }
     nvme_init_ctrl(n, pci_dev);
-- 
2.39.2


