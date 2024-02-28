Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8143C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB8Z-0005Xc-TW; Tue, 27 Feb 2024 23:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8W-0005Wu-IH
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:41 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB8R-0000uR-LS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092896; x=1740628896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=InINaFpruLMkFpCTED2dU+8i3KHEDP/YmQBNqrbqvAo=;
 b=LfS3/Agd5V9j3E2yha7wL9MzV+wLNfcsn6m1kQm1e2BIGHlPRR2w8Ap9
 Fh2vZpwhm8JhNTVnm7cRyNc/dCwUZEdv0Md3df3+kTO7TdRhmLNvnBElp
 piLMjmUqkUzVgJWo+dj9Qm+MK7aQoTAKLiu19A6kw8GErJ+selmzQ3xsS
 34SQ/MTsmCc8psSUlsO+d6dFftg/+wuA6IB9Wua8hbUHcH4s/Ayp/Ueun
 Lquat+6hUNoemZrdc3DygJizsoXY6hDoP+qjNcK762XdTl9T2vJ7KfjAS
 l+Rjb0iDbCv50IFMXlQsdXH1cIILAHYv4WhMp61cAc2+sEU7sy4Tun5Uz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342455"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917202"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:21 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 04/11] vfio: Add HostIOMMUDevice handle into VFIODevice
Date: Wed, 28 Feb 2024 11:58:53 +0800
Message-Id: <20240228035900.1085727-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This handle points to either IOMMULegacyDevice or IOMMUFDDevice variant,
neither both.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8bfb9cbe94..b6676c9f79 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -130,6 +130,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    HostIOMMUDevice *base_hdev;
     int devid;
     IOMMUFDBackend *iommufd;
 } VFIODevice;
-- 
2.34.1


