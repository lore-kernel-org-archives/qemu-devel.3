Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8105DC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79w7-0002Gd-0G; Wed, 15 May 2024 04:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79w5-0002F6-Er
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:29 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79w3-0007B1-SG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761467; x=1747297467;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DTf3l3gNL+/MEzKemJXwdZjfqVeaFHkkSy2ozo0sBso=;
 b=EjSrBYibYu2+Z5kwUxMJahvutqIt3BQ5umI6qzk0i1v0/ZjA0w8pQTq7
 DpgdrEtT3OMyLGutSuFEc5LScJVGUcbodaoRv+90kWS/4loXgtwlHBQFT
 LMRlSIFIPDTrE9nP6/x4/sHjkaNTXiB1Ud9g2s6RDPI4hVMXQetY0OH6g
 YRcl5hqOfDxiMFemRvc/ajOeRvOo49crMe666LJbxrLLMwwwbFHHsZoyV
 PxwTiHNR7tSxNWDWS48DEZXgr7IbjMYSxkV0UuwNRdj/fJ4YDS+5dr0av
 vkgqrm5QYsjsMIzfbQG8QFde62iocxYq/EfbSuhBGcRcDS2VRj77TkVis Q==;
X-CSE-ConnectionGUID: AFsgf+UEQbGM3J2xhpHW+A==
X-CSE-MsgGUID: jR9IM7AcQ0G3cHK4FQ9LFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961569"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961569"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:16 -0700
X-CSE-ConnectionGUID: UCGlrDnUSgmk7QB8BHZCRg==
X-CSE-MsgGUID: uxRQkFMZS/2N97n2PuWkTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396374"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 14/16] vfio/pci: Use g_autofree for vfio_region_info pointer
Date: Wed, 15 May 2024 16:20:39 +0800
Message-Id: <20240515082041.556571-15-zhenzhong.duan@intel.com>
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

Pointer opregion is freed after vfio_pci_igd_opregion_init().
Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ecfbb9619f..be87478716 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3146,7 +3146,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        struct vfio_region_info *opregion;
+        g_autofree struct vfio_region_info *opregion = NULL;
 
         if (vdev->pdev.qdev.hotplugged) {
             error_setg(errp,
@@ -3165,7 +3165,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
 
         ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
-        g_free(opregion);
         if (ret) {
             goto out_teardown;
         }
-- 
2.34.1


