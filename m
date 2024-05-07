Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23C2C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZo-00038m-JK; Tue, 07 May 2024 02:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZg-000365-RS
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:17 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZf-000550-3m
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064315; x=1746600315;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bFd4oSxT+3OuxTU6241PGfq4mw6h6aaCpEOi35TjN4M=;
 b=eT3xpiBQJe4DpwgQ25U8sF5RU3NCRwGlIJ+LKF6fVQH9z6goEfFAVOVl
 i3u7aQ3ItXk5j8+33h45pFZkv/619KtaOCQ2v9xBGlCJpDGcA1zNNHsgE
 oYFuPTTYIJcL6EQYm4I0DSfbkxbxkzkl/RR98m68qzYSh7MNHd9jq7E0a
 oBY+A7WXikFzOQZ562y14llf5/GBW0YZ7Tj/HWbR2Z3219+ZsfeBuZFe/
 F/kolaDJoUpundul1FqVbK9s7FyCiXu1e1LRmHCZvgCfP1dzDqJ65wnQa
 +WuLuAi67Hu1wvSFVYIiAud1lcYEKsSVeQDVqX80yAP0b12bbezy7toX6 Q==;
X-CSE-ConnectionGUID: QnpaZsFLSZiKsLgN9sbEhg==
X-CSE-MsgGUID: N+Vi9G9jT2SVMcJWiCJuTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240215"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240215"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:13 -0700
X-CSE-ConnectionGUID: DpczNi9WRzyxRpESV0KdSQ==
X-CSE-MsgGUID: klhrWXTZQ5qjIi74yUkZZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407506"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 01/11] vfio/pci: Use g_autofree in vfio_realize
Date: Tue,  7 May 2024 14:42:42 +0800
Message-Id: <20240507064252.457884-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Local pointer name is allocated before vfio_attach_device() call
and freed after the call.

Same for tmp when calling realpath().

Use 'g_autofree' to avoid the g_free() calls.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..576b21e2bb 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2946,12 +2946,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     ERRP_GUARD();
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
-    char *tmp, *subsys;
+    char *subsys;
     Error *err = NULL;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
-    char *name;
+    g_autofree char *name = NULL;
+    g_autofree char *tmp = NULL;
 
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
@@ -2982,7 +2983,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
      */
     tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
     subsys = realpath(tmp, NULL);
-    g_free(tmp);
     is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
     free(subsys);
 
@@ -3003,7 +3003,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     ret = vfio_attach_device(name, vbasedev,
                              pci_device_iommu_address_space(pdev), errp);
-    g_free(name);
     if (ret) {
         goto error;
     }
-- 
2.34.1


