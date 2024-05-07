Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B9FC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H4N-0002is-7A; Tue, 07 May 2024 05:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H36-0000YQ-71
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:50 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H34-0000Bi-Ex
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073826; x=1746609826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vcn4z54CYhuDnDqnnNzxWO4HL3LLksv+uGFsOTEebxg=;
 b=TeZhT5kkNZHBzRXSi6ML5iu5zkcuFPZ3j0u/Y/eEqw1uCycmw4RjgPG8
 5vJ04olWm/rQASxuREnFFhaBpNaZFEirn8FPA6r7OqBAaKYV7ziJoaqQn
 JB8NegWpaDrfJehD1gRhy1ljrQpmH3Qs10ibqi9xoqEMv2qFM1OSRhlUA
 hGuhcNtBQg7cmHz4jh1kGGUcF5DrB6NNlq06AKQDLel5CkiiK/vGRmSTt
 lYyMGL0WH27PR09UJjZL4p5uOxnFN2vg8AqqOGWkDi4q231OvZ8riGz1f
 /BwAz9C4/WgenzEWJdB4gMqk5X8EG/PiTDCkSUo2mVRntcrSgHSA0eO3F g==;
X-CSE-ConnectionGUID: 4vvZqPY/TeelqgUHwSVA+Q==
X-CSE-MsgGUID: 1lSJEf1lRHm9jRpVY9wZtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785268"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785268"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:45 -0700
X-CSE-ConnectionGUID: UtySz7hjQWScEHKC+xsOiQ==
X-CSE-MsgGUID: hLm0HuXcTQSs7qGqD6XEhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553436"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Date: Tue,  7 May 2024 17:20:35 +0800
Message-Id: <20240507092043.1172717-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/iommufd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 06bf20fd05..7c332bd167 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -229,6 +229,28 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
+static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
+        return caps->type;
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return caps->aw_bits;
+    default:
+        error_setg(errp, "Not support get cap %x", cap);
+        return -EINVAL;
+    }
+}
+
+static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->get_cap = hiod_iommufd_get_cap;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
@@ -245,6 +267,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
 };
-- 
2.34.1


