Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78BBC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuH-00029R-4t; Mon, 29 Apr 2024 02:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktr-0001zR-57
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:10 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktp-0007m1-7i
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373645; x=1745909645;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XvxTrdUSmOcQ1SIn9l9XAOCQmhY8mC7uYkRA11su954=;
 b=WxGQvkzIZcNA8lNJXrQXGdduhZhr82qm7cJC8YbRR/EVF5ypZ8sJJ/LX
 yV5OCzi5bo8Xg23CntwOB1gzOkvHtfydVlYp16gIEGv4GMD7CWw3EPKVv
 kF+MLInWyDnhW+vlxlyKQ6uWEdXl12xdTFfNy0ADPj4Drmj7oRy/Eis+2
 WAOhfEoBID4QCRKBXOpGiR8omac9YUV9XqkWjD9CydXMQTpLdx8GaqK0w
 5njgy9kGHFQ8vfXNiWToxwU+FUVe3s+2j/XBQbnpt9Ja5ZwIQFXnz9l08
 SyJhQyRr8hEXlzYpECR7YCtKIsqSdWgHA6GciApbEXNLZCM0AIcTSQmJH w==;
X-CSE-ConnectionGUID: Vy8PhULvTmymrHO+3y+u9A==
X-CSE-MsgGUID: NevZM0W1RVan/DTo0TOaAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560725"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:05 -0700
X-CSE-ConnectionGUID: uCRjNM4ETrOBFlLyg3vs8w==
X-CSE-MsgGUID: c7qiEA1bSnOUbVz8tp70fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488156"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Date: Mon, 29 Apr 2024 14:50:38 +0800
Message-Id: <20240429065046.3688701-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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
 backends/iommufd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index d61209788a..28faec528e 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -233,6 +233,23 @@ int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return ret;
 }
 
+static int hiod_iommufd_check_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
+{
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_IOMMUFD:
+        return 1;
+    default:
+        return host_iommu_device_check_cap_common(hiod, cap, errp);
+    }
+}
+
+static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->check_cap = hiod_iommufd_check_cap;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
@@ -251,6 +268,7 @@ static const TypeInfo types[] = {
         .parent = TYPE_HOST_IOMMU_DEVICE,
         .instance_size = sizeof(HostIOMMUDeviceIOMMUFD),
         .class_size = sizeof(HostIOMMUDeviceIOMMUFDClass),
+        .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
 };
-- 
2.34.1


