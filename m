Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218DEC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EaT-0003yv-R1; Tue, 07 May 2024 02:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EaF-0003TP-7h
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:56 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4Ea4-0006Fm-Dt
 for qemu-devel@nongnu.org; Tue, 07 May 2024 02:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064340; x=1746600340;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rF9oBa+R0BwJduQ/QAasFeC7MzXwWFAzTS3CIvFpW0Y=;
 b=HmE1DIv9AK++njcnK8qM7fh4V/MexgAjVzqLpHth4jnskyqsy404KQYM
 x2j/lbZzDjS3KOvPOdl7RAuZKHPYVQNnl/1Y0aU1SwaCBvJ+NWj1z8m1o
 ySm2hlgtaUXxbBCKWkH1xFGgHTKFDWzZwzlDwVmhT+I+2lnJfVXHEXKXa
 antxpi0QFrC4YYD+NmvFEdqDdtgldOlswqB9LA5qiB6xNZU17UGz8rm5b
 OVkUoZS9F+CeawII1ixlK6Ugvw2kjgcnJTAcCqolzPAZDYHXIqILt0m8a
 Yyxtk7AZfIinE0J/KXi+EfatMdQ617KiKlYGKuVv3AmljctJzf3Y+HWDN A==;
X-CSE-ConnectionGUID: kSM5jSlZTRujTil8MSlz5Q==
X-CSE-MsgGUID: JVOd62ofQeCyKlU9B2pdsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240276"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240276"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:39 -0700
X-CSE-ConnectionGUID: YTxkEJVMQXid0kFclLTVGw==
X-CSE-MsgGUID: GFu1zj/bTnqUO3MtIZqhkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407548"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 11/11] backends/iommufd: Make iommufd_backend_*() return
 bool
Date: Tue,  7 May 2024 14:42:52 +0800
Message-Id: <20240507064252.457884-12-zhenzhong.duan@intel.com>
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

The changed functions include:

iommufd_backend_connect
iommufd_backend_alloc_ioas

By this chance, simplify the functions a bit by avoiding duplicate
recordings, e.g., log through either error interface or trace, not
both.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  6 +++---
 backends/iommufd.c       | 29 +++++++++++++----------------
 hw/vfio/iommufd.c        |  5 ++---
 backends/trace-events    |  4 ++--
 4 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6c..293bfbe967 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -23,11 +23,11 @@ struct IOMMUFDBackend {
     /*< public >*/
 };
 
-int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
+bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp);
 void iommufd_backend_disconnect(IOMMUFDBackend *be);
 
-int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
-                               Error **errp);
+bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                                Error **errp);
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id);
 int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 76a0204852..c506afbdac 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -72,24 +72,22 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
 }
 
-int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
+bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
 {
-    int fd, ret = 0;
+    int fd;
 
     if (be->owned && !be->users) {
         fd = qemu_open_old("/dev/iommu", O_RDWR);
         if (fd < 0) {
             error_setg_errno(errp, errno, "/dev/iommu opening failed");
-            ret = fd;
-            goto out;
+            return false;
         }
         be->fd = fd;
     }
     be->users++;
-out:
-    trace_iommufd_backend_connect(be->fd, be->owned,
-                                  be->users, ret);
-    return ret;
+
+    trace_iommufd_backend_connect(be->fd, be->owned, be->users);
+    return true;
 }
 
 void iommufd_backend_disconnect(IOMMUFDBackend *be)
@@ -106,25 +104,24 @@ out:
     trace_iommufd_backend_disconnect(be->fd, be->users);
 }
 
-int iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
-                               Error **errp)
+bool iommufd_backend_alloc_ioas(IOMMUFDBackend *be, uint32_t *ioas_id,
+                                Error **errp)
 {
-    int ret, fd = be->fd;
+    int fd = be->fd;
     struct iommu_ioas_alloc alloc_data  = {
         .size = sizeof(alloc_data),
         .flags = 0,
     };
 
-    ret = ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data);
-    if (ret) {
+    if (ioctl(fd, IOMMU_IOAS_ALLOC, &alloc_data)) {
         error_setg_errno(errp, errno, "Failed to allocate ioas");
-        return ret;
+        return false;
     }
 
     *ioas_id = alloc_data.out_ioas_id;
-    trace_iommufd_backend_alloc_ioas(fd, *ioas_id, ret);
+    trace_iommufd_backend_alloc_ioas(fd, *ioas_id);
 
-    return ret;
+    return true;
 }
 
 void iommufd_backend_free_id(IOMMUFDBackend *be, uint32_t id)
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6a446b16dc..554f9a6292 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -71,7 +71,7 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
         .flags = 0,
     };
 
-    if (iommufd_backend_connect(iommufd, errp)) {
+    if (!iommufd_backend_connect(iommufd, errp)) {
         return false;
     }
 
@@ -346,8 +346,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
     }
 
     /* Need to allocate a new dedicated container */
-    ret = iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp);
-    if (ret < 0) {
+    if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
         goto err_alloc_ioas;
     }
 
diff --git a/backends/trace-events b/backends/trace-events
index d45c6e31a6..211e6f374a 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -7,11 +7,11 @@ dbus_vmstate_loading(const char *id) "id: %s"
 dbus_vmstate_saving(const char *id) "id: %s"
 
 # iommufd.c
-iommufd_backend_connect(int fd, bool owned, uint32_t users, int ret) "fd=%d owned=%d users=%d (%d)"
+iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
 iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
 iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
 iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, void *vaddr, bool readonly, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" addr=%p readonly=%d (%d)"
 iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
-iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
+iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
-- 
2.34.1


