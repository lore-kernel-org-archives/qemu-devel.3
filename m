Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B52CCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHnB-0005AP-4Q; Wed, 27 Aug 2025 11:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkx-0000JI-67; Wed, 27 Aug 2025 11:08:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHkp-0005of-Ad; Wed, 27 Aug 2025 11:08:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E234614C55B;
 Wed, 27 Aug 2025 18:02:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D0909269862;
 Wed, 27 Aug 2025 18:03:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Alan Adamson <alan.adamson@oracle.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 50/59] hw/nvme: revert CMIC behavior
Date: Wed, 27 Aug 2025 18:02:55 +0300
Message-ID: <20250827150323.2694101-50-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit cd59f50ab017 ("hw/nvme: always initialize a subsystem") causes
the controller to always set the CMIC.MCTRS ("Multiple Controllers")
bit. While spec-compliant, this is a deviation from the previous
behavior where this was only set if an nvme-subsys device was explicitly
created (to configure a subsystem with multiple controllers/namespaces).

Revert the behavior to only set CMIC.MCTRS if an nvme-subsys device is
created explicitly.

Reported-by: Alan Adamson <alan.adamson@oracle.com>
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
Tested-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit bc0c24fdb157b014932a5012fe4ccbeba7617f17)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 669fff41c7..f34bd68c04 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8780,7 +8780,7 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     uint8_t *pci_conf = pci_dev->config;
     uint64_t cap = ldq_le_p(&n->bar.cap);
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
-    uint32_t ctratt;
+    uint32_t ctratt = le32_to_cpu(id->ctratt);
     uint16_t oacs;
 
     memcpy(n->cse.acs, nvme_cse_acs_default, sizeof(n->cse.acs));
@@ -8798,10 +8798,11 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
 
     id->oaes = cpu_to_le32(NVME_OAES_NS_ATTR);
 
-    ctratt = NVME_CTRATT_ELBAS;
+    ctratt |= NVME_CTRATT_ELBAS;
     if (n->params.ctratt.mem) {
         ctratt |= NVME_CTRATT_MEM;
     }
+    id->ctratt = cpu_to_le32(ctratt);
 
     id->rab = 6;
 
@@ -8884,17 +8885,6 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->psd[0].enlat = cpu_to_le32(0x10);
     id->psd[0].exlat = cpu_to_le32(0x4);
 
-    id->cmic |= NVME_CMIC_MULTI_CTRL;
-    ctratt |= NVME_CTRATT_ENDGRPS;
-
-    id->endgidmax = cpu_to_le16(0x1);
-
-    if (n->subsys->endgrp.fdp.enabled) {
-        ctratt |= NVME_CTRATT_FDPS;
-    }
-
-    id->ctratt = cpu_to_le32(ctratt);
-
     NVME_CAP_SET_MQES(cap, n->params.mqes);
     NVME_CAP_SET_CQR(cap, 1);
     NVME_CAP_SET_TO(cap, 0xf);
@@ -8927,6 +8917,20 @@ static int nvme_init_subsys(NvmeCtrl *n, Error **errp)
         }
 
         n->subsys = NVME_SUBSYS(dev);
+    } else {
+        NvmeIdCtrl *id = &n->id_ctrl;
+        uint32_t ctratt = le32_to_cpu(id->ctratt);
+
+        id->cmic |= NVME_CMIC_MULTI_CTRL;
+        ctratt |= NVME_CTRATT_ENDGRPS;
+
+        id->endgidmax = cpu_to_le16(0x1);
+
+        if (n->subsys->endgrp.fdp.enabled) {
+            ctratt |= NVME_CTRATT_FDPS;
+        }
+
+        id->ctratt = cpu_to_le32(ctratt);
     }
 
     cntlid = nvme_subsys_register_ctrl(n, errp);
-- 
2.47.2


