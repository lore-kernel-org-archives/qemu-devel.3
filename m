Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518DAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0xN-0005LC-MH; Mon, 03 Jun 2024 02:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xG-00055M-DZ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:02 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xB-0000xl-2n
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395237; x=1748931237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aGQbaAJ8Mo1eAYh7VSQnzPpxX2caqE6yUjp/Zueg3F4=;
 b=moH0ZAbw2jiW89ya0/7UWT2N/vhZrZfDwoYPHgwdO5653YDQQZysj4a5
 yzNToJg17Vrt1OyYlAxxcNkM7KBtxwhdmmPYAnJpau9U3CmlLK1VgjhSS
 cOgyfsBGY/IVXCOnk7uNVytCjBCrX0gcWidS9WzJcXOTqusp13h/x+Mq1
 UouX12en+VzXABFoM6MFQeIw5h7qb3UVkBE65F6RqJ8KYvpMCxCorcKe6
 wby5BtKBa9f2aWDZVJTIqjgoiC4PIrjTwxHKsQUd3Y1u6BuvUpfHDyvIX
 HjTK15A1xRpoGuorft3OhHpFhJykKP8txzQ7rO/hB6+/MGKGamW6JJX7q w==;
X-CSE-ConnectionGUID: X9wCeZ3pS4Gixc/45qP7KQ==
X-CSE-MsgGUID: 6KA9cXb0S3uuyW5RV0lNcw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277699"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277699"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:54 -0700
X-CSE-ConnectionGUID: gIILgM3FTxa/FTbp/Isd2g==
X-CSE-MsgGUID: gt7Hk+SvQ8KWvvImT67D3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855914"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 10/19] vfio/container: Implement
 HostIOMMUDeviceClass::get_cap() handler
Date: Mon,  3 Jun 2024 14:10:14 +0800
Message-Id: <20240603061023.269738-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 hw/vfio/container.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 48800fe92f..a46c275a88 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1154,11 +1154,26 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
+                                    Error **errp)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return caps->aw_bits;
+    default:
+        error_setg(errp, "Not support get cap %x", cap);
+        return -EINVAL;
+    }
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->realize = hiod_legacy_vfio_realize;
+    hioc->get_cap = hiod_legacy_vfio_get_cap;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


