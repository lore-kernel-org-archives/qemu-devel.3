Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC50BCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9bh-0002UT-ED; Sat, 17 Oct 2026 14:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9ba-0002Qr-Qw; Sat, 17 Oct 2026 14:58:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9bY-0003nm-Tu; Sat, 17 Oct 2026 14:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263387; bh=L+QCPRUOaXiTORFTDWEsFsIdaajPtAzQJChxuKteEQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s6dMz2mtdjANmECP3d/jzRtvtW49esTO2I9JUhTQBMP728xd90W1x9P9y17LB4HZM
 eYO/Rmx2vuHAkolAQm3aUuecLAFU1cqEMIy0Qq7Wf7M0XWd9mfOZ3g/+wX4GnRqgtO
 L4yQMjuXidabJI+v6FW/S7JZvQRgcBY66T6qPYE9HBdd+x2t5eSwbqbSsE4hsrwIql
 7LvyW5l13wCgTVVjnkZjraTcVK+W18r5D6G/ZICBPch6zpx40dvOaxgvn2YDFrywI3
 FWMTTTWX81FQFHVVLRJW7cY0ct2WNEmtQoN6y0Tg11zsoV3cWNNhfkEMnBs9sa7avc
 KZK52zrorLlBA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA7511DE6BA;
 Sat, 17 Oct 2026 21:56:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1D22D443385;
 Sat, 17 Oct 2026 21:56:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Paziyski <danielpaziyski@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 26/63] hw/nvme: fix assertion failure on sr-iov
 capable nvme controller removal
Date: Sat, 17 Oct 2026 21:54:42 +0300
Message-ID: <20261017185528.722197-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Daniel Paziyski <danielpaziyski@gmail.com>

In a nvme subsystem, the ctrls array maps controller IDs to nvme controllers.
The value of the array elements can either be NULL (no controller present for
this ID), SUBSYS_SLOT_RSVD, or any other value, representing a pointer to the
nvme controller structure.

The SUBSYS_SLOT_RSVD value is special: when a nvme controller physical function
is being created and is reserving the controller IDs for its virtual functions,
it indicates that the slot is soon going to be filled by its corresponding
virtual function when it is realized, and on virtual function removal, it means
that its controller has been removed.

When the physical function is being removed, it goes through its list of
secondary controllers (virtual functions), ensures that their slots have the
SUBSYS_SLOT_RSVD values, and then frees up the controller IDs by setting the
NULL value. This traversal occurs before the virtual functions are destroyed,
causing an assertion failure because the slots contain as values the pointers to
the secondary controllers.

Destroy the virtual functions (and therefore, the secondary controllers) after
they are offlined in the nvme_ctrl_reset call of the physical function, but
before releasing the controller IDs of the secondary controllers in
nvme_subsys_unregister_ctrl.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../hw/nvme/subsys.c:49: nvme_subsys_unreserve_cntlids: Assertion `subsys->ctrls[cntlid] == SUBSYS_SLOT_RSVD' failed.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 90fcba23c526f3417953429832d0a97be4389fdb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index cc6d3bc1a7..f5719372f9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9082,6 +9082,10 @@ static void nvme_exit(PCIDevice *pci_dev)
         }
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        pcie_sriov_pf_exit(pci_dev);
+    }
+
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
     g_free(n->cq);
@@ -9101,10 +9105,6 @@ static void nvme_exit(PCIDevice *pci_dev)
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        pcie_sriov_pf_exit(pci_dev);
-    }
-
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
         msix_uninit_exclusive_bar(pci_dev);
     } else {
-- 
2.47.3


