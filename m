Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446B5C3DA50
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 08:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTGju-0003BE-HL; Mon, 15 Jul 2024 04:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGjr-0002zt-Ve; Mon, 15 Jul 2024 04:07:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sTGje-00047o-F9; Mon, 15 Jul 2024 04:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721030823; x=1752566823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RoxEAFvBU5+co7FmGTVK5jcrRDDIG8H4tO5qqtRbR/E=;
 b=Wk4H1Pqx70/XgCfcrto4U/fja5o1M/wpFRHgNkb8g6Pa0l5AHzkNIvxY
 NmUZrZdiu9+H0unYWIZTOzDNgfWCZCNEdlZcr90v1GCyDM7FGmosCF4M9
 7KbvVpV+qKT8DkjtNZDA+/i5jrgYHR/F4leSKiV9KdYaIVqYWPxoqRFEy
 ouTjnuSEdVJzn4CFrPFivRRL5EyyD90uFsiBmzu1vhj5ihcheTbqOQevo
 kIkwZ+z6cIwYvWoIVyTYZdEx9yVqVDMBC+35wF4J1QXoKm/XnT69wotiF
 hjV8iAB/xqkKMhj2S0etHOp54q92ra2AX1Z+zkvgKV8gBKH9RP25aKwfX g==;
X-CSE-ConnectionGUID: W52Pe4r3ToGkiUy6A62JXw==
X-CSE-MsgGUID: ofT8bXUYTmC9rXXgdWs32Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35935662"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="35935662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 01:06:41 -0700
X-CSE-ConnectionGUID: tGq/A5TPS++20uYbEXwzJQ==
X-CSE-MsgGUID: EeHdx6fcQkKDznH5VelWjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; d="scan'208";a="49512588"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 01:06:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/7] hw/vfio/container: Get rid of qemu_open_old()
Date: Mon, 15 Jul 2024 16:21:52 +0800
Message-Id: <20240715082155.28771-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715082155.28771-1-zhao1.liu@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open().

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Cédric Le Goater" <clg@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/vfio/container.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 425db1a14c07..38a9df34964a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -600,9 +600,8 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         }
     }
 
-    fd = qemu_open_old("/dev/vfio/vfio", O_RDWR);
+    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
     if (fd < 0) {
-        error_setg_errno(errp, errno, "failed to open /dev/vfio/vfio");
         goto put_space_exit;
     }
 
@@ -743,9 +742,8 @@ static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
     group = g_malloc0(sizeof(*group));
 
     snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
-    group->fd = qemu_open_old(path, O_RDWR);
+    group->fd = qemu_open(path, O_RDWR, errp);
     if (group->fd < 0) {
-        error_setg_errno(errp, errno, "failed to open %s", path);
         goto free_group_exit;
     }
 
-- 
2.34.1


