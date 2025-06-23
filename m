Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EBAC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNu-0005yp-CK; Mon, 23 Jun 2025 06:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNs-0005y5-88
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:40 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNn-0000lQ-6u
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674395; x=1782210395;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MxMVveEJ4lElsNDpu96M/mDOZpSh974jvh00HM5eCIM=;
 b=VOpiQPwiX071fM34lm7n/zOFV5MGjeOUzwcPuGALAzUCoUy34z3tah5N
 tPEll98v8XYGqDq7qfrdbV5mrJeN4wYDImfD46YXkGaZNBpLp4pPLbdKw
 ccKWIjqZwTv8iMdhAv0BiVqHETBThS+jnRyPFcKzyQutvzuSKJ/O72279
 B13tSHptG/6XyqjqDJO9xT8vx1OzEKonS6r+XPskg/xRyVxs+FMvyGCh+
 yiF1xcOEH+w9cnNFsR9WpcvqgZhPLNmmcMRx8v0Y9rRLMo4ndgcKIxZL5
 UGVrlMEvTbnqomKhqaUO1+JTbV53U58GRGO6p76yO+2z9iJ8A+tbEmW30 w==;
X-CSE-ConnectionGUID: VusGftHmS5u41vyfalMqjg==
X-CSE-MsgGUID: FGP9y6ZuQ7i0SRSrqfybUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63565460"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63565460"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:33 -0700
X-CSE-ConnectionGUID: QMyG46dgTWeX31r7d2ukVw==
X-CSE-MsgGUID: 8BfRjpIASwuSv2yFwOOBWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182427947"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/4] vfio/container: fails mdev hotplug if add migration
 blocker failed
Date: Mon, 23 Jun 2025 18:22:33 +0800
Message-Id: <20250623102235.94877-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623102235.94877-1-zhenzhong.duan@intel.com>
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

It's aggressive to abort a running QEMU process when hotplug a mdev
and it fails migration blocker adding.

Fix by just failing mdev hotplug itself.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2853f6f08b..68b4fdb401 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -992,12 +992,16 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
     if (vbasedev->mdev) {
         error_setg(&vbasedev->cpr.mdev_blocker,
                    "CPR does not support vfio mdev %s", vbasedev->name);
-        migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, &error_fatal,
-                                  MIG_MODE_CPR_TRANSFER, -1);
+        if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
+                                      MIG_MODE_CPR_TRANSFER, -1)) {
+            goto hiod_unref_exit;
+        }
     }
 
     return true;
 
+hiod_unref_exit:
+    object_unref(vbasedev->hiod);
 device_put_exit:
     vfio_device_put(vbasedev);
 group_put_exit:
-- 
2.34.1


