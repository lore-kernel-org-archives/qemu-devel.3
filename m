Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA87EC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EaS-0003ol-G2; Tue, 07 May 2024 02:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4Ea3-0003Pd-60
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4Ea1-00064G-GA
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064337; x=1746600337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3kz+HnMU3OELL9Qs0ND9eLNaakr4SnZrzRGavmQaJdM=;
 b=hciNUrFNNt/XrSuk0o3V46h+MmHK+IXtoFnzRib9BbK9TVHLf7tB0Kei
 7mXfSfKOpVfrxDyUuUwl4xyr7XTsMw28dEQ5usBlYmEZCG6YWdEMSOrce
 2e5nokDJw8kL+QAcYjRKNPcoVfi1N6GRXvG2Q4RgFakt/j1WrDU7L8Q5o
 i2m34o+e/0Oc614Pt0QcyPAewUmUdhX6qwHzzPWqEiXGCvTZlVf20jJes
 3mNFV8YHx9LuapdxPiQwVoMKilHlNLjwsywPnTGsseyzVYuFkYKNOY5aZ
 6zAJYFLlLu3kPZegt4qdQ3Njad5SA0lHKPc2ezoN2BkZVl6bYDbt+hu/g w==;
X-CSE-ConnectionGUID: RnEC3rbWQHKECvWgZGng+Q==
X-CSE-MsgGUID: 7UL7lI7GQqWXo+8AqAp9Jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240272"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240272"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:36 -0700
X-CSE-ConnectionGUID: DlwC+QZFTuy/X3WwkaPPxA==
X-CSE-MsgGUID: 6l7kCiThRtWj2aIdmPEEKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407545"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 10/11] vfio/cpr: Make vfio_cpr_register_container() return
 bool
Date: Tue,  7 May 2024 14:42:51 +0800
Message-Id: <20240507064252.457884-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/container.c           | 3 +--
 hw/vfio/cpr.c                 | 4 ++--
 hw/vfio/iommufd.c             | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a7b6fc8f46..e4c60374fa 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -205,7 +205,7 @@ void vfio_detach_device(VFIODevice *vbasedev);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
-int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
+bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
 
 extern const MemoryRegionOps vfio_region_ops;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b02583ea16..86266f3b83 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -616,8 +616,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
-    ret = vfio_cpr_register_container(bcontainer, errp);
-    if (ret) {
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto free_container_exit;
     }
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 392c2dd95d..87e51fcee1 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -25,12 +25,12 @@ static int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
-int vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
+bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp)
 {
     migration_add_notifier_mode(&bcontainer->cpr_reboot_notifier,
                                 vfio_cpr_reboot_notifier,
                                 MIG_MODE_CPR_REBOOT);
-    return 0;
+    return true;
 }
 
 void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 84c86b970e..6a446b16dc 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -396,8 +396,7 @@ found_container:
         goto err_listener_register;
     }
 
-    ret = vfio_cpr_register_container(bcontainer, errp);
-    if (ret) {
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
         goto err_listener_register;
     }
 
-- 
2.34.1


