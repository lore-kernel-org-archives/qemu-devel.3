Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24420C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0xM-0005F5-Hh; Mon, 03 Jun 2024 02:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xF-00053t-Fz
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:02 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xD-0000xv-Je
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395240; x=1748931240;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dAKZSk5QgrnUIjill0jO2g0zyj3Uf0goHqo6GXW+pBI=;
 b=JNZyTkqyMZR7BFjewvP5//hYXZD9QqOhAuLQ8CT3jzwTX/VcGkryaQW1
 LMnLY3yvtNHDt2/2lvUK3Wc2XFc4QUjgh8LObV+nTnfRftDbCFCEw3Y/J
 nIUBqrBR4y3OYUcUxbwjoaldQnGEf/ZJ1NRuzozRjBV2PRAUuf3MRz5in
 pReHVznRNaa9/4cOrfz7lQZzG0SdQXu5fbTzuZHB2NIK5iHq0sFCG10Gg
 7PCL07UW51zr1y/BZ6sHyXc0Z6IoaJzyZD6btEwXuezzqJ/W4++XZFdgD
 ZllEV3sbFolHJJD3+bFRL8UtER9VOpr+DsOnRtKkoLfk9QLrpaFTRKj5S w==;
X-CSE-ConnectionGUID: 1XJypS3MQyeDLhQ0ghUzHQ==
X-CSE-MsgGUID: f4nTW8e9QdGQyXEaZINfFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277707"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277707"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:58 -0700
X-CSE-ConnectionGUID: 4+04TMNbRk2ZzHKqVINCGA==
X-CSE-MsgGUID: v2BwHxoRQPW0LnWSjTnFTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855934"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::get_cap() handler
Date: Mon,  3 Jun 2024 14:10:15 +0800
Message-Id: <20240603061023.269738-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/iommufd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index c7e969d6f7..f2f7a762a0 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -230,6 +230,28 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
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
@@ -246,6 +268,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
 };
-- 
2.34.1


