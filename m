Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A283CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEY2C-0004ip-5J; Wed, 07 Oct 2026 16:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1c-0004ac-Fe
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:06 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xEY1a-0002As-Ky
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 16:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791404043; x=1822940043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z+oIk+G77ffAyvDt2gk8Rm+x+U8QdE6+d1lK3skZEJg=;
 b=d314cDy59YADPAcmh/iJ0MzGMIzlHMYBOQ5iZ6NrXDPRbLTa+TWuYhR3
 ltbUdrzJj9Gmr/8Y9/sxXZjDn5qxM/Ij6JwduX1Z6vLib05TZfTh5mzjD
 2fm+wtKr6MVzaJZb2lfQPUF0VrZgzO22V0XPpafV/PXd79sV5xTIxyFWr
 6CSjBuvosOO8L18SNZIMFVOBeAtClTLz/uLX/hImb1GqgSw5F31gpShAE
 RKtK1Fk/+n4W04qiO6dHTZGdLx/ZkqvC6H8Nhy93BN2ear4v0/SxfW5Fn
 4BSCucRV0P6B9PnJgO5qfqR2trM7NcTmC3BGB8drjRYyS0yrI6lZXmvcb w==;
X-CSE-ConnectionGUID: gS6jm915SVeEVK3Sq9L3GA==
X-CSE-MsgGUID: E2qwUCr4Qmy1m7i7eym2BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="178492"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="178492"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:49 -0700
X-CSE-ConnectionGUID: M6jGtRfrRyOJijW7ih1Kmg==
X-CSE-MsgGUID: wa+m2lQaTuGS/KknShBJbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="1564976"
Received: from vkasired-desk1.fm.intel.com ([10.121.64.242])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 13:13:48 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs associated
 with VFIO devices
Date: Wed,  7 Oct 2026 13:09:28 -0700
Message-ID: <20261007201222.648687-10-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007201222.648687-1-vivek.kasireddy@intel.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
 hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c9de8e9ba3..f59a5e76ff 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -153,9 +153,25 @@ bool virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
         if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
             error_free_or_abort(&local_err);
 
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Cannot create dmabuf: incompatible memory\n");
-            return false;
+            res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
+                                                          res->iov_cnt,
+                                                          &local_err);
+            if (res->dmabuf_fd == VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
+                error_free_or_abort(&local_err);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Cannot create dmabuf: incompatible memory\n");
+                return false;
+            }
+
+            if (res->dmabuf_fd >= 0) {
+                pdata = vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
+                                                &local_err);
+                if (!pdata) {
+                    virtio_gpu_fini_dmabuf(res);
+                }
+            } else {
+                res->dmabuf_fd = -1;
+            }
         } else if (res->dmabuf_fd >= 0) {
             pdata = virtio_gpu_remap_dmabuf(res, &local_err);
             if (!pdata) {
-- 
2.53.0


