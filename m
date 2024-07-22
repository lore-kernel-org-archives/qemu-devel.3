Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06F9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnBu-00049x-He; Mon, 22 Jul 2024 03:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnBG-0001kR-2d; Mon, 22 Jul 2024 03:09:59 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVnBD-0007xL-IX; Mon, 22 Jul 2024 03:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721632195; x=1753168195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GR8DquOYnpIKBHfRCqyHBKcsVC//Ilyvb+EFGW2rF/M=;
 b=V1c9e25XWo8ZRPiJv6esaFiXG3A4azJ+tgK8SKjq40RzRNpuWbNvEbUO
 xnvj3A7ACXLk+Xlm1huAdYkG8+l7rAxgT/7GVX+wZO04u8hLtEvnTLJH5
 pGGhKO17OAc6ERUcpWDvZOEzJDqrKMfdK+fBiIoC8XmE+e2erWTYI1NeU
 cmrMp+IAbD/tzHCSq4GLb7Jqhluwi8BaBpdjlxt866soVdWnEy8+/hKIO
 oLWbm711hRRCTEfXYe7NV0WFYA1aAXe6G+KxQNVD8r5Rn3Mgk+EGwAuV0
 9HRVOVXMZHezZCu0jcN85F7eivVSlklqFrv4irNlcJC0V2NNChh7kF4Zq Q==;
X-CSE-ConnectionGUID: SkTwdVWmRpqCRYZWisyOPw==
X-CSE-MsgGUID: zD9pu7yNRuGMcoMFxz2w8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19332619"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19332619"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:54 -0700
X-CSE-ConnectionGUID: 5rgVRUeaRSCgkxR4fT682Q==
X-CSE-MsgGUID: 62WzRfYbT2muZYSZBuCspg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82808742"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 00:09:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH 2/2] vfio/ccw: Don't initialize HOST_IOMMU_DEVICE with mdev
Date: Mon, 22 Jul 2024 15:07:13 +0800
Message-Id: <20240722070713.1342711-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
References: <20240722070713.1342711-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

mdevs aren't "physical" devices and when asking for backing IOMMU info,
it fails the entire provisioning of the guest. Fix that by setting
vbasedev->mdev true so skipping HostIOMMUDevice initialization in the
presence of mdevs.

Fixes: 930589520128 ("vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1f8e1272c7..70934b01d5 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -675,6 +675,9 @@ static void vfio_ccw_instance_init(Object *obj)
     VFIOCCWDevice *vcdev = VFIO_CCW(obj);
     VFIODevice *vbasedev = &vcdev->vdev;
 
+    /* CCW device is mdev type device */
+    vbasedev->mdev = true;
+
     /*
      * All vfio-ccw devices are believed to operate in a way compatible with
      * discarding of memory in RAM blocks, ie. pages pinned in the host are
-- 
2.34.1


