Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ED9103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Bu-0006Kk-Jm; Fri, 27 Feb 2026 17:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bs-0006Jp-2F
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:20:08 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bp-0007ml-Qu
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772230806; x=1803766806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vEc4G49rjF034O9S3kVdRpVeSAKAdnxFYmbWIJROkr0=;
 b=i2YfuSvb9o7fZuajRMW8hjkppoTZTzwXKztZXDLCk4LKVmxo6oL1SGdj
 3GvgXXC1gDRfGaIZtSLnFau233AwRshIXWLJm3A3dspcPP2qBzuXdQnj7
 /wdkbkJjth3DLIiEz6izjoOVP39Hf+q/cTkeDGZv7fq/AMcJXSHJpV0UT
 HFSBt7BxOCBgn1Ql1O2ZkJKrkxWUULa01Qp6ZOgsMs0hFKnD21/GSywlr
 /Q0Z5zn5gn/vIxG4zNvqYNuL5GKcrNVrAPY2pDQ3y5Pc6NnGv4eSfk6LK
 grX81Mhzmo/12xpdSnyE34MHKm+v7X5hbIbHsryHQGbEhpgiOoBW3dWaG Q==;
X-CSE-ConnectionGUID: b6H6vepSSBOpdo9qxq6oSQ==
X-CSE-MsgGUID: E78l4Cd1QMSzrnWzAPpGYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73509370"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="73509370"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:41 -0800
X-CSE-ConnectionGUID: DJQDI38kTI+Pb01bV93Bdw==
X-CSE-MsgGUID: PQaJmZo1SXKWXjn8N7hgyw==
X-ExtLoop1: 1
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Fri, 27 Feb 2026 14:13:56 -0800
Message-ID: <20260227221632.827046-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227221632.827046-1-vivek.kasireddy@intel.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In addition to memfd, a blob resource can also have its backing
storage in a VFIO device region. Since, there is no effective way
to determine where the backing storage is located, we first try to
create a dmabuf assuming it is in memfd. If that fails, we try to
create a dmabuf assuming it is in VFIO device region.

So, we first call virtio_gpu_create_udmabuf() to check if the blob's
backing storage is located in a memfd or not. If it is not, we invoke
the vfio_device_create_dmabuf_fd() API which identifies the right
VFIO device and eventually creates a dmabuf fd.

Note that in virtio_gpu_remap_dmabuf(), we first try to test if
the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
fall back to the vfio_device_mmap_dmabuf() API to get a mapping
created for the dmabuf.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 35 +++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index b2badfc1bd..533d3d601c 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -74,13 +74,21 @@ static int virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
 static bool virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res,
                                     Error **errp)
 {
+    Error *mmap_err = NULL;
     void *map;
 
     map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res->dmabuf_fd, 0);
     if (map == MAP_FAILED) {
-        error_setg_errno(errp, errno, "dmabuf mmap failed");
+        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
         res->remapped = NULL;
-        return false;
+
+        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
+                                     res->blob_size, errp)) {
+            error_report_err(mmap_err);
+            return false;
+        }
+        error_free(mmap_err);
+        mmap_err = NULL;
     }
     res->remapped = map;
     return true;
@@ -137,7 +145,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    Error *local_err = NULL;
+    Error *local_err = NULL, *vfio_err = NULL;
     void *pdata = NULL;
     int ret;
 
@@ -151,15 +159,28 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
             error_prepend(&local_err, "Cannot create dmabuf: ");
 
             if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "Cannot create dmabuf: incompatible memory\n");
-                error_free(local_err);
-                return;
+                ret = vfio_device_create_dmabuf_fd(res->iov, res->iov_cnt,
+                                                   &vfio_err);
+                if (ret > 0) {
+                    error_free(local_err);
+                    local_err = NULL;
+                    goto out;
+                }
+
+                if (ret == VFIO_DMABUF_CREATE_GUEST_ERROR) {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "Cannot create dmabuf: incompatible memory\n");
+                    error_free(vfio_err);
+                    error_free(local_err);
+                    return;
+                }
+                error_report_err(vfio_err);
             }
             error_report_err(local_err);
             return;
         }
 
+out:
         res->dmabuf_fd = ret;
         if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
             error_report_err(local_err);
-- 
2.53.0


