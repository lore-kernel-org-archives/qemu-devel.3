Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90746C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rma6B-0004Q2-Iy; Tue, 19 Mar 2024 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma67-0004PQ-C9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rma65-0008NV-Tt
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710857145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=psQLqUsTh68XjulWEvqdNd/ZYkzRdTMVoBlpRemrBz8=;
 b=WibiUe5urgs2bLKWNSzCDf/cU0dCMA2bEj1QkYlzR5aXsuN6sBDWDOaNBIOgkwe5dVkQ9I
 0vbp9zeRP3ZZVLYY8quOonqwbNiBH9E2TqEhJ7uJCjo/kTRyM5WEmm0cDX2K/ZtJzVbxUw
 uvx+k+sqqALiNc3msHCiaEx/ZidrW34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-81on02_uM8qZEN0NMznQdQ-1; Tue, 19 Mar 2024 10:05:40 -0400
X-MC-Unique: 81on02_uM8qZEN0NMznQdQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D49B8007A4;
 Tue, 19 Mar 2024 14:05:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2268A3C20;
 Tue, 19 Mar 2024 14:05:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PULL 1/3] vfio/iommufd: Fix memory leak
Date: Tue, 19 Mar 2024 15:05:14 +0100
Message-ID: <20240319140516.392542-2-clg@redhat.com>
In-Reply-To: <20240319140516.392542-1-clg@redhat.com>
References: <20240319140516.392542-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Coverity reported a memory leak on variable 'contents' in routine
iommufd_cdev_getfd(). Use g_autofree variables to simplify the exit
path and get rid of g_free() calls.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>
Fixes: CID 1540007
Fixes: 5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend")
Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/iommufd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bafddb8f5a9433a3af6a1ce7f5c5a26428da48ea..8827ffe636e2aba1551ba794bf666a7a214590b7 100644
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


