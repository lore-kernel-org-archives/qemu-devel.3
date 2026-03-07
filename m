Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2908CFC9EC3
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 03:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyi4f-0004sP-Cy; Fri, 06 Mar 2026 22:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyi4d-0004s5-Ei
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:11:27 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vyi4b-0000ol-UR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 22:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772853086; x=1804389086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ndxcgores0l2qC+gItZqykbKhchBgLacTV55nno2J1c=;
 b=BadbmyPqGq3G8vWat2gnMaI3HgvVYw4tYrJ3/5ks6RTgcE0UuhWsNPkx
 njxAPNbOrLsZH8lroH3nOsKy7YvFE//XvLnKkzoM7ZC1KJSC/AWle1d7P
 DIJmWzkEDpvVeerTCggvpInNSzwHWjpp5nCPafj1cEb8w67+1m1WB8+W7
 Lj2NHfwflsthRtgZ+tEk2j2vnBWXgadTJb+t0qJ48L1EIi6uFwLyTmg7m
 NXMndZrAeR8vt2Qk08zBC+rNAYE0n0i7/nzjphPFQwakRHLKbia29qeiu
 ysNdp2Dyxxoa6i9xq2Ui4KhnlhMWY6DFua28U7jJ2mfgJZ8xBwtqKlrT1 Q==;
X-CSE-ConnectionGUID: c3IX8VxWRvWxiAfeJhOLRQ==
X-CSE-MsgGUID: j4KNE3e3QnGyX74pDqhqag==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="99434046"
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; d="scan'208";a="99434046"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 19:11:01 -0800
X-CSE-ConnectionGUID: iMwvIcS8QKuxAkdpMYa6cw==
X-CSE-MsgGUID: BKFhtA3IQfqR3HOQSDmcsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,106,1770624000"; d="scan'208";a="215813786"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2026 19:11:01 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v10 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Date: Fri,  6 Mar 2026 19:05:59 -0800
Message-ID: <20260307030812.1224392-11-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
References: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_NONE=0.001,
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
 hw/display/virtio-gpu-dmabuf.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index 0a6b54fde5..55e3f60b60 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -148,9 +148,22 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
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
+            if (res->dmabuf_fd < 0 ||
+                !vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &pdata,
+                                         res->blob_size, &local_err)) {
+                virtio_gpu_destroy_dmabuf(res);
+                res->dmabuf_fd = -1;
+            }
         } else if (res->dmabuf_fd < 0 ||
                    !virtio_gpu_remap_dmabuf(res, &pdata, &local_err)) {
             virtio_gpu_destroy_dmabuf(res);
-- 
2.53.0


