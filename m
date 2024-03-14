Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42532C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 08:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkgMg-0005t2-CR; Thu, 14 Mar 2024 04:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sBtw=KU=redhat.com=clg@ozlabs.org>)
 id 1rkgMd-0005lt-0u
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:22:59 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sBtw=KU=redhat.com=clg@ozlabs.org>)
 id 1rkgMa-0004z2-CU
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 04:22:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TwL3W2SYPz4wyR;
 Thu, 14 Mar 2024 19:22:47 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TwL3S0ZGdz4wc9;
 Thu, 14 Mar 2024 19:22:43 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2] vfio/iommufd: Fix memory leak
Date: Thu, 14 Mar 2024 09:22:38 +0100
Message-ID: <20240314082238.844370-1-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=sBtw=KU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Coverity reported a memory leak on variable 'contents' in routine
iommufd_cdev_getfd(). Use g_autofree variables to simplify the exit
path and get rid of g_free() calls.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Fixes: CID 1540007
Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a75a785e90c64cdcc4d10c88d217801b3f536cdb..b9c7efb3ef11e49e189103ae6fb9011a631b60da 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -118,10 +118,12 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 {
     ERRP_GUARD();
     long int ret = -ENOTTY;
-    char *path, *vfio_dev_path = NULL, *vfio_path = NULL;
+    g_autofree char *path = NULL;
+    g_autofree char *vfio_dev_path = NULL;
+    g_autofree char *vfio_path = NULL;
     DIR *dir = NULL;
     struct dirent *dent;
-    gchar *contents;
+    g_autofree gchar *contents = NULL;
     gsize length;
     int major, minor;
     dev_t vfio_devt;
@@ -130,7 +132,7 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     dir = opendir(path);
     if (!dir) {
         error_setg_errno(errp, errno, "couldn't open directory %s", path);
-        goto out_free_path;
+        goto out;
     }
 
     while ((dent = readdir(dir))) {
@@ -147,14 +149,13 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
 
     if (!g_file_get_contents(vfio_dev_path, &contents, &length, NULL)) {
         error_setg(errp, "failed to load \"%s\"", vfio_dev_path);
-        goto out_free_dev_path;
+        goto out_close_dir;
     }
 
     if (sscanf(contents, "%d:%d", &major, &minor) != 2) {
         error_setg(errp, "failed to get major:minor for \"%s\"", vfio_dev_path);
-        goto out_free_dev_path;
+        goto out_close_dir;
     }
-    g_free(contents);
     vfio_devt = makedev(major, minor);
 
     vfio_path = g_strdup_printf("/dev/vfio/devices/%s", dent->d_name);
@@ -164,17 +165,13 @@ static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
     }
 
     trace_iommufd_cdev_getfd(vfio_path, ret);
-    g_free(vfio_path);
 
-out_free_dev_path:
-    g_free(vfio_dev_path);
 out_close_dir:
     closedir(dir);
-out_free_path:
+out:
     if (*errp) {
         error_prepend(errp, VFIO_MSG_PREFIX, path);
     }
-    g_free(path);
 
     return ret;
 }
-- 
2.44.0


