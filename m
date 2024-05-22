Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98979C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dp2-0001ZH-Kw; Wed, 22 May 2024 00:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dox-0001XW-6K
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:23 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dov-0005wQ-M3
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353002; x=1747889002;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=V8yxZZ1IG6SB5qSxhKY8vL9VI3CH904ht7jW/ItgoVk=;
 b=Apstu+d/h5xItkNPoZ+NVEKnEvxJifZc1lP03TUoqOn87MdoX9MvT8IV
 C/LAi6rforeLvXn9lSbrwn7ppsbJ3igL+RK0WttoSxUGx27lMwg6yV8Rl
 nuZ6rYuFWMZep7CfXJt4TttTMGtJ+sIm3fm98Ez9Pch6G6DjImcd2WJAW
 D2aoRLf/9aye0v8ON8e3TVRmEJhuEGRZwxm4Zn/jplE/EEvUZ79SyFu6F
 h06vFH5bQvsfikxQKG8BYXJtVscu0xstpB1Rwiu9HqM/ck/ERDybi9evQ
 Rpb1BWeZh+aamj3xSwBMJKa4BHf9vJnq035MD7j58Ejo3+zVbGp88f6CZ A==;
X-CSE-ConnectionGUID: QtSbz11nT2qwv7bwT39sww==
X-CSE-MsgGUID: upAY3MoVQPadDPrv7dT+vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994188"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994188"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:11 -0700
X-CSE-ConnectionGUID: xARcH7zPQoeERv2BGp0WSw==
X-CSE-MsgGUID: 1gz4UMVrQuaYBo1QiKy+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683765"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:09 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 14/20] vfio/pci: Use g_autofree for vfio_region_info pointer
Date: Wed, 22 May 2024 12:40:09 +0800
Message-Id: <20240522044015.412951-15-zhenzhong.duan@intel.com>
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

Pointer opregion is freed after vfio_pci_igd_opregion_init().
Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c3323912dd..8379d2284a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3143,7 +3143,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        struct vfio_region_info *opregion;
+        g_autofree struct vfio_region_info *opregion = NULL;
 
         if (vdev->pdev.qdev.hotplugged) {
             error_setg(errp,
@@ -3162,7 +3162,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         }
 
         ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
-        g_free(opregion);
         if (ret) {
             goto out_teardown;
         }
-- 
2.34.1


