Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D07C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5G-00026K-8F; Tue, 08 Sep 2026 02:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5C-00023J-7D; Tue, 08 Sep 2026 02:13:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p58-0000jh-4b; Tue, 08 Sep 2026 02:13:25 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG8x048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=p/bFNnvJf2EbYTmRiqw4Np3Yp00f3812P2yY6Of3u/A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847946; v=1;
 b=kH7oJ+kNDd5r4asSiZtJY4LLQ71lXbkURe8okKfYRRn+/4ePMGNsMEe8wGBx48iU
 +ECOAwHiKIlCzsyeFoLx2bpOs60dESGc05JY1Z+Xh6D0DKTZMHjmvGYHNmYRY0vE
 3Y9x3q/mEp9QGDtrfxiHlJUhVeHAQKlaAYsAnCmYpd0moDX8X9QrePTkplk2kPDv
 V2F8NiX60i7EfAiXfFS3PeRAzd8ceDr+Esf5IF2key7W1Zqk7ZzKccDSE1oCz/rT
 ecOatet1SrXuj6jFiMezhzXPygRVeOJCOWee2+JnFtmltIT0VyaefYWE0MJbldJ1
 70Z8HcJI6659f4vyEqGpxw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:19 +0900
Subject: [PATCH v3 2/9] virtio: Move the virtio_complete_reset() call
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-2-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
References: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@kernel.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, qemu-block@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=7026;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=SKZChTReagvxsA+8q0QnbP2HUjuxNQQF62u58PZaAUc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85c5RCsonuRJqb+t61PxJrNGtCv+b9eFJwMx+3zPfN
 2pdkFPpKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMhxfkaGh3PlDrR3RVpxly/a
 +DI5if1TSmqXv5zLXdW1Pr3Xr4rZMfyzT88K9/j+/Kpzk+/c4rMPxW56GK88zNJYcabIbWrYw2W
 MAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

Move the virtio_complete_reset() call to VirtioDeviceClass::reset
implementations to allow changing the completion timing.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/9pfs/virtio-9p-device.c   | 1 +
 hw/audio/virtio-snd.c        | 2 ++
 hw/block/vhost-user-blk.c    | 1 +
 hw/block/virtio-blk.c        | 1 +
 hw/char/virtio-serial-bus.c  | 1 +
 hw/display/vhost-user-gpu.c  | 3 +--
 hw/display/virtio-gpu-base.c | 2 ++
 hw/input/virtio-input.c      | 2 ++
 hw/net/virtio-net.c          | 1 +
 hw/scsi/vhost-user-scsi.c    | 1 +
 hw/scsi/virtio-scsi.c        | 2 ++
 hw/virtio/virtio-balloon.c   | 1 +
 hw/virtio/virtio-crypto.c    | 2 ++
 hw/virtio/virtio.c           | 7 ++-----
 14 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 2774fc2290a8..c9de102d39c1 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -115,6 +115,7 @@ static void virtio_9p_reset(VirtIODevice *vdev)
     V9fsVirtioState *v = (V9fsVirtioState *)vdev;
 
     v9fs_reset(&v->state);
+    virtio_complete_reset(vdev);
 }
 
 static ssize_t coroutine_fn
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 694bcebb60f6..40bae0cb9c82 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -1383,6 +1383,8 @@ static void virtio_snd_reset(VirtIODevice *vdev)
             virtio_snd_ctrl_cmd_free(cmd);
         }
     }
+
+    virtio_complete_reset(vdev);
 }
 
 static void virtio_snd_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 2e5b3ae1b14b..09e52745b31c 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -348,6 +348,7 @@ static void vhost_user_blk_reset(VirtIODevice *vdev)
     VHostUserBlk *s = VHOST_USER_BLK(vdev);
 
     vhost_dev_free_inflight(s->inflight);
+    virtio_complete_reset(vdev);
 }
 
 static int vhost_user_blk_connect(DeviceState *dev, Error **errp)
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 6b92066aff4c..a8ae8294fa47 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1168,6 +1168,7 @@ static void virtio_blk_reset(VirtIODevice *vdev)
     }
 
     blk_set_enable_write_cache(s->blk, s->original_wce);
+    virtio_complete_reset(vdev);
 }
 
 /* coalesce internal state, copy to pci i/o region 0
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c1973f0248fc..5efca2505990 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -638,6 +638,7 @@ static void vser_reset(VirtIODevice *vdev)
 
     vser = VIRTIO_SERIAL(vdev);
     guest_reset(vser);
+    virtio_complete_reset(vdev);
 }
 
 static void virtio_serial_save_device(VirtIODevice *vdev, QEMUFile *f)
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index cd684d63639e..f8d640557c28 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -640,9 +640,8 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
 {
     VhostUserGPU *g = VHOST_USER_GPU(vdev);
 
-    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
-
     vhost_user_backend_stop(g->vhost);
+    virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
 }
 
 static int
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 270fbaae1029..d7032ac1def2 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -36,6 +36,8 @@ virtio_gpu_base_reset(VirtIOGPUBase *g)
         g->scanout[i].y = 0;
         g->scanout[i].ds = NULL;
     }
+
+    virtio_complete_reset(VIRTIO_DEVICE(g));
 }
 
 void
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 6494cfbbe82d..0a533a6fff6e 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -216,6 +216,8 @@ static void virtio_input_reset(VirtIODevice *vdev)
             vic->change_active(vinput);
         }
     }
+
+    virtio_complete_reset(vdev);
 }
 
 static int virtio_input_post_load(void *opaque, int version_id)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d20..bd12780076f4 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -4151,6 +4151,7 @@ static void virtio_net_reset(VirtIODevice *vdev)
     }
 
     virtio_net_disable_rss(n);
+    virtio_complete_reset(vdev);
 }
 
 static void virtio_net_instance_init(Object *obj)
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 5070178dc28b..6f525268f93a 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -371,6 +371,7 @@ static void vhost_user_scsi_reset(VirtIODevice *vdev)
     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
 
     vhost_dev_free_inflight(vsc->inflight);
+    virtio_complete_reset(vdev);
 }
 
 static struct vhost_dev *vhost_user_scsi_get_vhost(VirtIODevice *vdev)
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index bf64d1231a81..c70cef7ba122 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1028,6 +1028,8 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
     WITH_QEMU_LOCK_GUARD(&s->event_lock) {
         s->events_dropped = false;
     }
+
+    virtio_complete_reset(vdev);
 }
 
 typedef struct {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 4c5f486ba238..e3a8545fa612 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -954,6 +954,7 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
     }
 
     s->poison_val = 0;
+    virtio_complete_reset(vdev);
 }
 
 static int virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
index 79e2acb56cc4..bab09f6f8714 100644
--- a/hw/virtio/virtio-crypto.c
+++ b/hw/virtio/virtio-crypto.c
@@ -1015,6 +1015,8 @@ static void virtio_crypto_reset(VirtIODevice *vdev)
     } else {
         vcrypto->status |= VIRTIO_CRYPTO_S_HW_READY;
     }
+
+    virtio_complete_reset(vdev);
 }
 
 static uint32_t virtio_crypto_init_services(uint32_t qservices)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 8d5f58a02df6..ed43c8bcb0bd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3443,11 +3443,7 @@ void virtio_reset(VirtIODevice *vdev)
         }
     }
 
-    if (k->reset) {
-        k->reset(vdev);
-    }
-
-    virtio_complete_reset(vdev);
+    k->reset(vdev);
 }
 
 void virtio_complete_reset(VirtIODevice *vdev)
@@ -4483,6 +4479,7 @@ static void virtio_device_class_init(ObjectClass *klass, const void *data)
     dc->unrealize = virtio_device_unrealize;
     dc->bus_type = TYPE_VIRTIO_BUS;
     device_class_set_props(dc, virtio_properties);
+    vdc->reset = virtio_complete_reset;
     vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 

-- 
2.55.0


