Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB030EEF30F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 07:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy2gl-0003Y9-BE; Thu, 05 Mar 2026 02:00:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vy2ga-0003XN-Qg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:59:56 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vy2gZ-0007qy-49
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 01:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772693991; x=1804229991;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YUNbrp4edfd3cukBdHdjKpuhqQeo/bSB3kVXDpXzORs=;
 b=FV6XvX1CUqiI4TZEVo7ORLLrEfdOEreYdrto9glck7YarH6xJoyQBL6S
 W7dL43PHgE+N69AD6MKLM/vtFCyIwmTuzYj8VZD3JqhMQQcCspnUdDexP
 7EjZDfMaJMIy+QeKZ+/uFrauoJwZ9XPziuVDF+1qQMPn5Lbnj+wLwqbfG
 xDlJCyfnTSS/FXd5Ftx054GJVsQ1f6/h7UywdpTSO79CjPnTgDAbz772S
 0BV2SM8Y30994UI3j/SbUyoMfK8RXHy/e8qMVaoFEVhS6oN9VG0H9R2uD
 uSxBuA8pcPRCofEFPA6chfzy+g9i54sGXkYBOD5gOrVZbqCW2Tdb7Av07 A==;
X-CSE-ConnectionGUID: C4DO4CS9Q36LkuioUa3cPQ==
X-CSE-MsgGUID: s7fl8r8WTZ2JiqvD0k7keA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91343534"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="91343534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 22:59:31 -0800
X-CSE-ConnectionGUID: HWbDSD/iSSmgj15nBe49cQ==
X-CSE-MsgGUID: bQ1+LUWzSNebDaM/tGvd2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="218725688"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 22:59:31 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v9 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Wed,  4 Mar 2026 22:54:41 -0800
Message-ID: <20260305065700.1155146-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
References: <20260305065700.1155146-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
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

Note that, for mmapping the dmabuf, we directly call mmap() if the
dmabuf fd was created via virtio_gpu_create_udmabuf() since we know
that the udmabuf driver supports mmap(). However, if the dmabuf was
created via vfio_device_create_dmabuf_fd(), we use the
vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index dd64fbbc2d..7f4c399416 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -136,7 +136,7 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    Error *local_err = NULL;
+    Error *local_err = NULL, *vfio_err = NULL;
     void *pdata = NULL;
     int ret;
 
@@ -155,10 +155,24 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         }
 
         if (ret == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Cannot create dmabuf: incompatible memory\n");
-            error_free(local_err);
-            return;
+            ret = vfio_device_create_dmabuf_fd(res->iov, res->iov_cnt,
+                                               &vfio_err);
+            if (ret > 0) {
+                if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &pdata,
+                                            res->blob_size, &vfio_err)) {
+                    error_free(local_err);
+                    goto out;
+                }
+            }
+
+            if (ret == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Cannot create dmabuf: incompatible memory\n");
+                error_free(vfio_err);
+                error_free(local_err);
+                return;
+            }
+            error_report_err(vfio_err);
         }
         error_report_err(local_err);
         return;
-- 
2.53.0


