Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD04C25B7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dob-0001SF-KV; Wed, 22 May 2024 00:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doZ-0001QU-VR
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:59 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doY-0005uB-8g
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352978; x=1747888978;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C/A9yvMH2CsXWTC4vyEkxTbhyKMCw2D1NBbb5lb7oFU=;
 b=BgSi0bnqgi+45P+BmBV/5lXIGyqVrFU4CmeySPMj1hH2mwhTwu0zCNJC
 U7sEfrvXbV2g7YNyJigJAYuemZzbY5L2QZjdq3eu+6hMbB7PUHHtO+T6M
 h0TToA5rODOpt2cXdWfZ+S7GVkqH/2WOTHklRwL5Z5AtXCfAbSR4ZgwIB
 clsCsSOVavD56DZ5OEPBsZlLDXo1dSnW+a9Sf55w3ipvHL7UbEofCTD06
 D9dVkbqFAWRoy7qspimchoLyERzlBbyePn9wLRrKDTWTqlwXo+YRfZs2H
 ObGg4HFmGEoZ7JukkKRwJ7iyBgc16mWgxcWX+UIIA34BeyTFcZMZq0eCZ w==;
X-CSE-ConnectionGUID: //6rTQtGRRmZzVoeW3SBmA==
X-CSE-MsgGUID: 67fNhA3zT8+qcQX6v3EeEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994145"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994145"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:57 -0700
X-CSE-ConnectionGUID: wl2+Ngo5QI25EXNkwXfBbw==
X-CSE-MsgGUID: V49bwSJ2TeK/DS9z+wCTWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683717"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:42:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 08/20] vfio/pci: Make vfio_intx_enable_kvm() return a bool
Date: Wed, 22 May 2024 12:40:03 +0800
Message-Id: <20240522044015.412951-9-zhenzhong.duan@intel.com>
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

Since vfio_intx_enable_kvm() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


