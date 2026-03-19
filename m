Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9702103E185
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35r2-0004qP-Ba; Thu, 19 Mar 2026 01:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qz-0004p6-CI
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:30 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qx-0007uV-PC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897808; x=1805433808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KCFgBlN8mCcR94ix8/h5CS5TPnxC4sjVKFQ7+WqdNrM=;
 b=HW6avqIuJk/DJOyhR2YByAVE4iqxR0PNER87Q/Va7XigS6TEmwPXrqF+
 2zO3EJBXMm2BBkC5idJRg6Np6mKGfgW8ezvEPniDB/zQBSsULCYINOhJM
 UAUFqv83qH3j+L+J/VR5kBMlkTT8w3XvO9X565BofrZ0BcXXWoIidS7KU
 QVpdKr7SlcsrbJU8QIvSfSXz0tAFlSI92kQv24LVqHoh1zyUuFaJNDNAE
 SsGkG9B94lT4P8nYjdE0fzhR3o6LbuOIP7mxNDiJaTeqiYBWJ4CDCUH/5
 3Vb+5adZUvgRn5gO5rT402XoTlFRB7qEIioJNFpeNmhJbuMhKQGsS+J4R A==;
X-CSE-ConnectionGUID: JKHVmEzoSP+OGxCnP3ifYg==
X-CSE-MsgGUID: SDKS4TRuQ1Cxwx/6xROR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660402"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660402"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:07 -0700
X-CSE-ConnectionGUID: WsQatj3kQDyw1ZRgc6OE6w==
X-CSE-MsgGUID: 2zZ1xpVBRCS53YsBjKuoEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355539"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:04 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Wed, 18 Mar 2026 22:15:59 -0700
Message-ID: <20260319052023.2088685-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 89aa487654..f953db0fbe 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -147,9 +147,26 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
             error_free_or_abort(&local_err);
 
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Cannot create dmabuf: incompatible memory\n");
-            return;
+            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
+                                                          res->iov_cnt,
+                                                          res->blob_size,
+                                                          &local_err);
+            if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+                error_free_or_abort(&local_err);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Cannot create dmabuf: incompatible memory\n");
+                return;
+            }
+
+            if (res->dmabuf_fd >= 0) {
+                pdata = vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
+                                                res->blob_size, &local_err);
+                if (!pdata) {
+                    virtio_gpu_destroy_dmabuf(res);
+                }
+            } else {
+                res->dmabuf_fd = -1;
+            }
         } else if (res->dmabuf_fd >= 0) {
             pdata = virtio_gpu_remap_dmabuf(res, &local_err);
             if (!pdata) {
-- 
2.53.0


