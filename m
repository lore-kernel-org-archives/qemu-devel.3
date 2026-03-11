Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2EFFD88E1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09ks-0000WH-4t; Tue, 10 Mar 2026 22:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kp-0000W4-Jw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:59 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w09kn-00063p-T3
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773197817; x=1804733817;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LGIT8biqr2S39Qalf39HjBW+U6DvHy+wk0C5eQqWqx8=;
 b=MTxQumbhx6cGHCS5YRhWsnjVvgP92Ywm8ZhqQNhWW75Xhft7/oprPyHy
 U/NpXP74o5A6YknY9Z9VtIMimkgHeCf6FpBJDAKQ3gjJDDHoijqHyC8Ep
 QxQS01EPvpGFjuMN+TyWVjsIqJgINN1EhjS26B+XgWB1MwRqZmNQxLFGG
 4m0g9JyUXd+5in3qLPe4WSolYv1CydQ0GRPXUn/BUaOQW5swz2zCe+kCm
 nKbbK8AMfQtV+gLeOfw0OlVfUc0rpxhAoeVawg39oM4SxJAFcCGej5xyp
 BUlLYt/5yc98JlI8yJwuRie4P5Amtkz70tKYCxzIx8mapNxqWjYeBM5lX g==;
X-CSE-ConnectionGUID: Ta2hpsnaSJq0VVQPDBdEmg==
X-CSE-MsgGUID: WhYQtP0/RS6p1eRRFUb51g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="76867933"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="76867933"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
X-CSE-ConnectionGUID: c2As29jfS0KNXlOyZINnIA==
X-CSE-MsgGUID: GkdOP+YIRvyhoHJzVj9utw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; d="scan'208";a="215611459"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2026 19:56:29 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Tue, 10 Mar 2026 19:50:52 -0700
Message-ID: <20260311025340.1335673-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index eddf398a43..ccb9c82a6f 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -147,9 +147,25 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
             error_free_or_abort(&local_err);
 
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Cannot create dmabuf: incompatible memory\n");
-            return;
+            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
+                                                          res->iov_cnt,
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


