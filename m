Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0483EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vq-00028h-7u; Wed, 15 May 2024 04:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vj-00027U-PC
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vg-00077f-HH
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761444; x=1747297444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cBfce4notNHYUMmAQiEeB90TnixUBjEhqnkhKjUAII4=;
 b=IC3UMrdtmLQcCaot0OBhJEqB9Yf31ruunNrlQy3sDGKiJ512gsaJG9HH
 WKPlMVwPrgtRSi2ObeZPyzCWzYG7oJ/3//nAVvBSxGdMtbCs9pq/6oy83
 Hf2qsxiq2sA9wnGky9uQWXBTgvoevNHbK3vyL2fsyWrWcR3UjTkJQsx9+
 EZMXqCn9i44mIVf1i/7/M5bGIfQTB7dDFS9TflqTrlcCOe2IDGqISpzBA
 bRnBwIgHP3Gm1uGiqvJxPBuFl9P7RHZMkD21RqFZMymyzZccNmlZH8skY
 0RbpgBb91I51ibY5zAEByFr4oujmOMNOAWgn0SnYcp8/kTFRI314mP3TE w==;
X-CSE-ConnectionGUID: j2u8Q1KrRU6zkkztCE7SqA==
X-CSE-MsgGUID: UOuX/IsdTTukapVzJbzFTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961552"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961552"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:03 -0700
X-CSE-ConnectionGUID: u4GGzq+WSnad5naacd16Lw==
X-CSE-MsgGUID: M5SzkOMKSsyOe9LK+3xjrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396322"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 08/16] vfio/pci: Make vfio_intx_enable_kvm() return a bool
Date: Wed, 15 May 2024 16:20:33 +0800
Message-Id: <20240515082041.556571-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Since vfio_intx_enable_kvm() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index aad012c348..12fb534d79 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -116,7 +116,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
     vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
-static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -124,7 +124,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
-        return;
+        return true;
     }
 
     /* Get to a known interrupt state */
@@ -161,7 +161,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
 
-    return;
+    return true;
 
 fail_vfio:
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
@@ -171,6 +171,9 @@ fail_irqfd:
 fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
+    return false;
+#else
+    return true;
 #endif
 }
 
@@ -226,8 +229,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
@@ -302,8 +304,7 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return -errno;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
-    if (err) {
+    if (!vfio_intx_enable_kvm(vdev, &err)) {
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
-- 
2.34.1


