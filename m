Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB37C44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkdCw-0005EI-DE; Fri, 17 Jul 2026 03:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkdCt-0005E3-LS
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 03:42:03 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wkdCq-0004HQ-Io
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 03:42:03 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66H7fkJj089243
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 17 Jul 2026 16:41:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZODLIP9A+LAFSuMRKF5I0NuFrPYZiB7m/gHRK+K5gdQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784274109; v=1;
 b=gYWjoiO8PpvHgpKrRzha8vH6mhknX7rqvJRP1x91Bhh6/tg3zQPlXJISOPP/M0+v
 jm34+9R3LMOq/bDzflv38d0DM3TlZb0mNlm+Saay3XiPI5OkFiU2PMtH5RKT7njh
 dLNA0j68xIVebEQBmXaG5V07AsHZ0+aIrCzoQIYG0ZC6RLKg2xLKIXFb+V2Hen9s
 me4+pu7ebvRcEauWXhE66L6GZXYQTRvTKhMMgFBbnx28ACjRHySONGXLg4AInJJX
 e6sGG7WSXBzmKYLSarVOuh1Ts7wc8BF8WYHPf5zMzMMak+QinnckWC74VGridK9O
 0cxSoysa54RjwfdxC2YLUA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 17 Jul 2026 16:41:36 +0900
Subject: [PATCH] hw/display/virtio-gpu: reject strides exceeding INT_MAX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-int-v1-1-8aa05e1791a0@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0Mz3cy8El2zZEuTFGMjC3PTJEMloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0A/9RUMGcAAAA=
X-Change-ID: 20260716-int-6c94d32875b1
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2334;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=LRYiGF8nmlyNFDCyQGEc1wkrV5DUvEphJACAvYD47nk=;
 b=kA0DAAoWKJ19aUZYEjEByyZiAGpZ3LuiRaN12kNOrcTXLL1DlIwZ0fParADdf78ACMihONk8E
 oh1BAAWCgAdFiEEZHK7CyhbffJxYF+EKJ19aUZYEjEFAmpZ3LsACgkQKJ19aUZYEjG7yQD7BDZR
 5gkNtyZrsAaRpXT9VRI8vsFkVol3bJCVDzvVbOIA+gOH/JyVJANK+C5rRVAsCckXnJZBoU2IhTJ
 AmHTbAbwM
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

VIRTIO_GPU_CMD_SET_SCANOUT_BLOB supplies a guest-controlled uint32_t
stride, but some downstream consumers take it as int. They may interpret
a value greater than INT_MAX as negative and cause issues:

- pixman_image_create_bits() takes the stride as int, and Pixman may
  later access memory before the blob buffer.

- eglCreateImageKHR() also takes the stride as EGLint when importing the
  DMA-BUF, and Mesa rejects it.

Reject such strides before scanout.

The check in virtio_gpu_scanout_blob_to_fb() rejects unsupported blob
configurations early. The check added in virtio_gpu_do_set_scanout()
covers migration post_load.

Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout")
---
 hw/display/virtio-gpu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e00fb6effa50..9b54207feb37 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -654,6 +654,14 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        *error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return false;
+    }
+
     g->parent_obj.enable = 1;
 
     if (res->blob) {
@@ -769,6 +777,13 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
         return false;
     }
 
+    if (fb->stride > INT_MAX) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: stride is %" PRIu32
+                      ", larger than the supported maximum (%d)\n",
+                      __func__, fb->stride, INT_MAX);
+        return false;
+    }
+
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;

---
base-commit: d25b8018680d762145d55ceed4fa7a3a47ac646e
change-id: 20260716-int-6c94d32875b1

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


