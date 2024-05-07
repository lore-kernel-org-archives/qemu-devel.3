Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ADFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ea0-0003PF-QI; Tue, 07 May 2024 02:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZz-0003OX-5k
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZx-00064G-FY
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064333; x=1746600333;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cYvBAeX/uBwyCnQDxeXOBKmDJDyEp69Jn47l2XHzo/0=;
 b=hTrG+I/ALZnlV7aTs2/MoWQWCm2Vy0y2yZMgYC4P67Se8DYhtfKXg9Je
 qgz2ZjwXpj7zclE7KdVAiLOZkcB1MCdvObnIq//bOg4stOVfrRfbGZtSS
 3kHNqOgOt+vFAQh3M/KiffqW8LQna5w8/bA5o58rmXLZmvvMj92JwFCuG
 tDogifSfNnRR8EK10vAQA+Ij8PEJ5d4oNiUNHWs1dUu9GEa2FnIioGHJu
 Va/tC4iG2AX0wYkQ3d91ikzISVgXdwVX4MXTh985vMSQsDloBXXL0ajA5
 L/eKQ/B8oUOgZ2uymcH/ExaTrMTGybojW9Dt/Pv9JiGwUQPtFtoN0nCJr w==;
X-CSE-ConnectionGUID: CyfBaMmhTcSK3PJpgo6ORw==
X-CSE-MsgGUID: /nOCcclNSregmn+74jGXtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240266"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:32 -0700
X-CSE-ConnectionGUID: P06yk2QcTaSkJVA5GRJyUw==
X-CSE-MsgGUID: 6/APm0E3QyuAxnh29+dGqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407538"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 08/11] vfio/container: Make vfio_get_device() return bool
Date: Tue,  7 May 2024 14:42:49 +0800
Message-Id: <20240507064252.457884-9-zhenzhong.duan@intel.com>
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
 hw/vfio/container.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5fb4bee082..b02583ea16 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -800,8 +800,8 @@ static void vfio_put_group(VFIOGroup *group)
     g_free(group);
 }
 
-static int vfio_get_device(VFIOGroup *group, const char *name,
-                           VFIODevice *vbasedev, Error **errp)
+static bool vfio_get_device(VFIOGroup *group, const char *name,
+                            VFIODevice *vbasedev, Error **errp)
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
@@ -813,14 +813,14 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
         error_append_hint(errp,
                       "Verify all devices in group %d are bound to vfio-<bus> "
                       "or pci-stub and not already in use\n", group->groupid);
-        return fd;
+        return false;
     }
 
     info = vfio_get_device_info(fd);
     if (!info) {
         error_setg_errno(errp, errno, "error getting device info");
         close(fd);
-        return -1;
+        return false;
     }
 
     /*
@@ -835,7 +835,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
             error_setg(errp, "Inconsistent setting of support for discarding "
                        "RAM (e.g., balloon) within group");
             close(fd);
-            return -1;
+            return false;
         }
 
         if (!group->ram_block_discard_allowed) {
@@ -856,7 +856,7 @@ static int vfio_get_device(VFIOGroup *group, const char *name,
 
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
-    return 0;
+    return true;
 }
 
 static void vfio_put_base_device(VFIODevice *vbasedev)
@@ -909,7 +909,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     VFIODevice *vbasedev_iter;
     VFIOGroup *group;
     VFIOContainerBase *bcontainer;
-    int ret;
 
     if (groupid < 0) {
         return false;
@@ -929,8 +928,7 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
             return false;
         }
     }
-    ret = vfio_get_device(group, name, vbasedev, errp);
-    if (ret) {
+    if (!vfio_get_device(group, name, vbasedev, errp)) {
         vfio_put_group(group);
         return false;
     }
-- 
2.34.1


