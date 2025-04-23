Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8D9C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uat-0006xu-LR; Wed, 23 Apr 2025 03:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uag-0006iT-G1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:19 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uae-0002Yx-Iu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393537; x=1776929537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NlpEfLjZRJq34lAeg6e2Aev6egagW09MJafNDS8LbUI=;
 b=jwOcLvKcYvaqgEj9iNQTRyKbwqMBAp88ak8hIdB2FoEViH5qREV17FcH
 0hvRtixmau3YYjsmu8B3T/yo9yix0msYIHsRTz+bO2Y4/Jwq/W5dV7OaB
 Q/OX4MVoTUFNQkwdlXq2bCOoxsA3lfpCP8WF9tblILCNcVvYGC+Tgc41f
 6iV7g/vwGPPYycrmZd2y8NylWylykyhRiG3GRzaZ+IC/4zuUgstrbFzG1
 wzx9M1JKT0a99IEApPLBuS6eilWe60uT/qFencWCEcGIixk2899Az7VGY
 5lQdR2gUcT54KbbMGqSXrGbLQaxbIia+yz5hLNJgBP4HmDqZbP6Z77CV9 w==;
X-CSE-ConnectionGUID: vij/yuK0RoWP+yiGlH2/9A==
X-CSE-MsgGUID: it7/7SGPR+SJZv1zN8TL7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959264"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959264"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:16 -0700
X-CSE-ConnectionGUID: HY/oIUeIRyW9eDi7hseZTQ==
X-CSE-MsgGUID: z16Ttga6RKS/TjrN9qsyxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025376"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Donald Dutile <ddutile@redhat.com>
Subject: [PATCH v2 3/5] vfio/container: Move realize() after attachment
Date: Wed, 23 Apr 2025 15:28:22 +0800
Message-Id: <20250423072824.3647952-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

To match the change for IOMMUFD backend, move realize() after attachment
for legacy backend too.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Donald Dutile <ddutile@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 23a3373470..1bb8e2de6c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -883,10 +883,6 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
 
     trace_vfio_device_attach(vbasedev->name, groupid);
 
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        return false;
-    }
-
     group = vfio_group_get(groupid, as, errp);
     if (!group) {
         return false;
@@ -895,13 +891,15 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
             error_setg(errp, "device is already attached");
-            vfio_group_put(group);
-            return false;
+            goto group_put_exit;
         }
     }
     if (!vfio_device_get(group, name, vbasedev, errp)) {
-        vfio_group_put(group);
-        return false;
+        goto group_put_exit;
+    }
+
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        goto device_put_exit;
     }
 
     bcontainer = &group->container->bcontainer;
@@ -910,6 +908,12 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return true;
+
+device_put_exit:
+    vfio_device_put(vbasedev);
+group_put_exit:
+    vfio_group_put(group);
+    return false;
 }
 
 static void vfio_legacy_detach_device(VFIODevice *vbasedev)
-- 
2.34.1


