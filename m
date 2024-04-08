Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01A7C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtkeG-0001kC-6m; Mon, 08 Apr 2024 04:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkeE-0001dI-7q
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:38 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtkeC-0004Mu-HO
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712565996; x=1744101996;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=flRYI8hlBU+mW5grayHqfg01LbC404dPjtoArd2qk8s=;
 b=MLm2ZQpzn5AZ6YIo0iyiPHmfBim7YxyFVB/LcQqqotQ6k8cbXPW6CX9V
 Jd9ys9CYrp46sTCBf4BUHmZAyevIIfMiw83toh8sGImfzuZOcdjLmwUzt
 Kp+HRIAfPBDIdX1D5VBr99Uf2lxgSVM5hXXnZ7cCEoPNl5GQDBhW2yuu5
 ysiPEJp11mxDeV9Kc8kpH4YV4ak+XjfZ0/y2O3o/yoIfu8VilZlu2AOJU
 umfhwm5Vmcg0Y7+z3CgTjNIyEJpe+g41xRc4v6kc76aYUn4+TdzW4VVy8
 Z5bvrxoGP7QLT1n2NmmGHvUUGMQ8su0uAxfAtf9sFLK8hKToTLT+Derp4 Q==;
X-CSE-ConnectionGUID: N7pLhJR4TPSVGcT+mRXhNA==
X-CSE-MsgGUID: qqwbGFKySNiT6mWwqHGHwg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19269471"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19269471"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:35 -0700
X-CSE-ConnectionGUID: hQvSYEWOTAmiXTZQgt6MmA==
X-CSE-MsgGUID: kRLFz5DtQKqCmRNbavtyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="42985899"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:46:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 4/5] intel_iommu: Check for compatibility with legacy device
Date: Mon,  8 Apr 2024 16:44:03 +0800
Message-Id: <20240408084404.1111628-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Currently only stage-2 translation is supported which is backed by
shadow page table on host side. So we don't need exact matching of
each bit of cap/ecap between vIOMMU and host. However, we can still
ensure compatibility of host and vIOMMU's address width at least,
i.e., vIOMMU's aw-bits <= host IOMMU aw-bits, which is missed before.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a49b587c73..d2cd186df0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3824,6 +3824,21 @@ static int vtd_check_legacy_hdev(IntelIOMMUState *s,
                                  HostIOMMUDevice *hiod,
                                  Error **errp)
 {
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
+    HIOD_LEGACY_INFO info;
+    int ret;
+
+    ret = hiodc->get_host_iommu_info(hiod, &info, sizeof(info), errp);
+    if (ret) {
+        return ret;
+    }
+
+    if (s->aw_bits > info.aw_bits) {
+        error_setg(errp, "aw-bits %d > host aw-bits %d",
+                   s->aw_bits, info.aw_bits);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
-- 
2.34.1


