Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C809C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doj-0001Uu-44; Wed, 22 May 2024 00:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dog-0001TY-1j
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:06 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doe-0005u5-Bc
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352985; x=1747888985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=05IaDSHKAn5N1DlE7YBOtpaIa7wa9rMM7eRtIlNK04w=;
 b=l0mXmcVxzCKcN92aChKH7SZj7LcafBIuhznewOkA2yzqkz0VKIOsskVU
 8QClJoKUCIrFc2iirFWLQvPxcUurYe5hmolhWUiuqOdZxRN71kDWYwOg0
 kaJOyKGG0vEwqMiA8Xa8RvPfKQ8x40dLkuc0hekFDId0IaG9j/3kTDkbi
 lsZYpBYj1AJeZXjUK2GVpBlUm1Cw+UrDZiRbZHhm7F+ql2eGtADX3dSyA
 EGrMdgwex4Frs3YamDg6SQEzLZtrdOSFSpHOA0ZztyBHFuXowHzpJ9T0q
 JZgGZLqom7D734GnjORNoHlTbCZTAqoeCiI61XY0AnyqpAsoJqE2oPTYW Q==;
X-CSE-ConnectionGUID: ZhXxuquXSraSNGfmDdbyoQ==
X-CSE-MsgGUID: sgKjiuDpRG+uaL6e2YBvcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994169"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994169"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:04 -0700
X-CSE-ConnectionGUID: Fh4UKSxtSByNbuWFq4pgJg==
X-CSE-MsgGUID: +BkCBCpPTm63xyPwM9JeBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683742"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:02 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 11/20] vfio/pci: Make vfio_intx_enable() return bool
Date: Wed, 22 May 2024 12:40:06 +0800
Message-Id: <20240522044015.412951-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 46d3c61859..7f35cb8a29 100644
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
 
@@ -3194,8 +3192,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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


