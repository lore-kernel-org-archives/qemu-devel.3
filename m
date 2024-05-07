Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951FCC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZx-0003Nr-HD; Tue, 07 May 2024 02:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZv-0003N0-2I
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:31 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZt-0005qh-B4
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064329; x=1746600329;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gUo9UnxPu2YspFGKVJBIbNBdn4MV8we3p89WumCBSx0=;
 b=bKLdJzvgk6IP/mOk3XG2vIMrniri4AmCAQsvBnnp2mNeaiJNYfEdg/vZ
 TWnCiCDQr1oU/xg8whD0OcavmkETS5AVDlal90StSXi+0ki1yxZWbiYjq
 JaNsGuYkut7pgJLUScl9WSZy3znn5KeiSEKWV4a2DlcJsBnVzRf7xM7FR
 cmeSGICbQxjr/KHhnbKW9E6GEgRttfsKUokPR94U38w05wmEW0SDM7eFB
 6ogpH3c8SLPVpikXZh+010G4f2DRZONpzNz+I6APN/VVpXycIsqBzSxyD
 ZRlhksVqorTePCHP9FnvZl2g6wI/bM8Ss2QRhXwU9cN3pxhU4oGVr2T+7 g==;
X-CSE-ConnectionGUID: hL/w8o9PQ+KlRyU2DSb9qg==
X-CSE-MsgGUID: OYjOV0DhQmS7dGgC1/FfDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240256"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240256"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:27 -0700
X-CSE-ConnectionGUID: waK3lt3FRuur++r3cRc0sA==
X-CSE-MsgGUID: TspUgYM+RYeh0SuUNOnFCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407529"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:26 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 06/11] vfio/container: Make vfio_connect_container() return
 bool
Date: Tue,  7 May 2024 14:42:47 +0800
Message-Id: <20240507064252.457884-7-zhenzhong.duan@intel.com>
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
 hw/vfio/container.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 85a8a369dc..0a7edfcc43 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -534,8 +534,8 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     return true;
 }
 
-static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
-                                  Error **errp)
+static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
+                                   Error **errp)
 {
     VFIOContainer *container;
     VFIOContainerBase *bcontainer;
@@ -587,19 +587,18 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                     error_report("vfio: error disconnecting group %d from"
                                  " container", group->groupid);
                 }
-                return ret;
+                return false;
             }
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
             vfio_kvm_device_add_group(group);
-            return 0;
+            return true;
         }
     }
 
     fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
-        ret = -errno;
         goto put_space_exit;
     }
 
@@ -607,7 +606,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     if (ret != VFIO_API_VERSION) {
         error_setg(errp, "supported vfio version: %d, "
                    "reported version: %d", VFIO_API_VERSION, ret);
-        ret = -EINVAL;
         goto close_fd_exit;
     }
 
@@ -634,7 +632,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     assert(bcontainer->ops->setup);
 
     if (!bcontainer->ops->setup(bcontainer, errp)) {
-        ret = -EINVAL;
         goto enable_discards_exit;
     }
 
@@ -650,7 +647,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
 
     if (bcontainer->error) {
-        ret = -1;
         error_propagate_prepend(errp, bcontainer->error,
             "memory listener initialization failed: ");
         goto listener_release_exit;
@@ -658,7 +654,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     bcontainer->initialized = true;
 
-    return 0;
+    return true;
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     QLIST_REMOVE(bcontainer, next);
@@ -683,7 +679,7 @@ close_fd_exit:
 put_space_exit:
     vfio_put_address_space(space);
 
-    return ret;
+    return false;
 }
 
 static void vfio_disconnect_container(VFIOGroup *group)
@@ -770,7 +766,7 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group->groupid = groupid;
     QLIST_INIT(&group->device_list);
 
-    if (vfio_connect_container(group, as, errp)) {
+    if (!vfio_connect_container(group, as, errp)) {
         error_prepend(errp, "failed to setup container for group %d: ",
                       groupid);
         goto close_fd_exit;
-- 
2.34.1


