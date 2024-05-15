Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D306BC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vw-0002Da-1e; Wed, 15 May 2024 04:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vo-00028n-P9
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:13 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vn-00078x-1h
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761451; x=1747297451;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BUGi0U9N5ZD36HyQ6NXb96H8zb9zwlvSMAPDhI+SDCg=;
 b=Dj3k9H+BkuwGwBvLoUYnFtdGxq/GZzGaz7PgQPUebwU2imfXe5DnfAjM
 OVzATAJefBMcdcFi05YbcEUyzvPkqqIzCrFjktaHvmaQPACYyrypSXFkS
 2J2N+zbhGwXZejKBXtJnpUin2VQPQMoQSMdcBL6V+TqR/QDIfVF45yYCL
 moETIQKC58K+Yxw8i+TV2XnCxBwBaSBMSV/oRX80ljXBalJMNbmon9QLZ
 +67v8NKIosCxXwxxFF+h8Q68Lllnr90DvLRyPmWs2L6NY6NNcWGmqUNw4
 MgkB59LQ78QdIfqgqKnfTJ79OGrqYSe9Otl2/sUPDlAQ9CTuyAbeTNzHd A==;
X-CSE-ConnectionGUID: KtluAC4pQjCiMUgzsDlhcg==
X-CSE-MsgGUID: CxbYKvU4RDGZ/KsEyZb6lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961561"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961561"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:09 -0700
X-CSE-ConnectionGUID: RaSaG/jxTsKNhli0dVN48Q==
X-CSE-MsgGUID: lwECR40SQ+muPHhO3QG5sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396358"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 11/16] vfio/pci: Make vfio_intx_enable() return bool
Date: Wed, 15 May 2024 16:20:36 +0800
Message-Id: <20240515082041.556571-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c091d21adf..e2ca4507f8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -261,7 +261,7 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
     vfio_intx_update(vdev, &vdev->intx.route);
 }
 
-static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
@@ -270,7 +270,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 
 
     if (!pin) {
-        return 0;
+        return true;
     }
 
     vfio_disable_interrupts(vdev);
@@ -292,7 +292,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     ret = event_notifier_init(&vdev->intx.interrupt, 0);
     if (ret) {
         error_setg_errno(errp, -ret, "event_notifier_init failed");
-        return ret;
+        return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
@@ -301,7 +301,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         event_notifier_cleanup(&vdev->intx.interrupt);
-        return -errno;
+        return false;
     }
 
     if (!vfio_intx_enable_kvm(vdev, &err)) {
@@ -311,7 +311,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     vdev->interrupt = VFIO_INT_INTx;
 
     trace_vfio_intx_enable(vdev->vbasedev.name);
-    return 0;
+    return true;
 }
 
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
@@ -836,8 +836,7 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
     vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
 
     vfio_msi_disable_common(vdev);
-    vfio_intx_enable(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -2450,8 +2449,7 @@ void vfio_pci_post_reset(VFIOPCIDevice *vdev)
     Error *err = NULL;
     int nr;
 
-    vfio_intx_enable(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -3197,8 +3195,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        ret = vfio_intx_enable(vdev, errp);
-        if (ret) {
+        if (!vfio_intx_enable(vdev, errp)) {
             goto out_deregister;
         }
     }
-- 
2.34.1


