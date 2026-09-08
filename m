Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9581BC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p9v-0006qL-P3; Tue, 08 Sep 2026 02:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p9u-0006pS-5D; Tue, 08 Sep 2026 02:18:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p9r-0001DZ-W5; Tue, 08 Sep 2026 02:18:17 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG8w048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=PfThLMXMOnZD0mjWkMNDhNJanggFECOZPez/M5J8CL4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847946; v=1;
 b=cUn+YvBCPlPWcuo/OunnCQ2AEgAW7S+yxKMQsYsDpbJmT2mVsjudQGoHVgJhUJLi
 s3J3I51k26nEMwoAlgfvpzFAT6G1doCbGPX/u66PQk3PH7JD0aBi4zrJn24X2Dbo
 NCtIk3F3SsONIUS4sbt+9mrbTW3on6Ofc2Gsn0P40jrbBaVxDPItqjZ3bZTSX+eY
 IKKQhmdXcuijLoyEk04m0kAPiNOmjWHwVvM9WyTyiO6vfHA/sbtFbg6maeLfZ8hP
 uOQj9Vto/lAIIzqY6gp5wxErkzoe0kjg1zXSszNl/YjT6d8P/cfKdRozej1sh2T3
 3EqN+GFIdD4w+luGzzkOGQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:18 +0900
Subject: [PATCH v3 1/9] virtio: Introduce virtio_complete_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-1-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=ZtPhPKyLB8ZrkcttM4/prLmUISESYFMU9XrRM0nzL6I=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85U5b6z2ZFawXu514GLDlxcUNGscrfhc/7/+zjF1uF
 //mcB+/jlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIlEajD8lXY7yr0tRmb/8stx
 8o07Ly6b2CRdXstZ177M0HvRPIbJOowMX7Vy721jU9SombNMq2vFLNVtpZ9XVgW4LQvPyXG6scC
 TGwA=
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

Introduce virtio_complete_reset() as preparation to allow asynchronous
reset. It is unconditionally called in virtio_reset(), but a follow-up
change moves the call to each device implementation.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio.h |  1 +
 hw/virtio/virtio.c         | 14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c99cb19d8865..1431be1389f2 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -507,6 +507,7 @@ int virtio_queue_set_host_notifier_mr(VirtIODevice *vdev, int n,
                                       MemoryRegion *mr, bool assign);
 int virtio_set_status(VirtIODevice *vdev, uint8_t val);
 void virtio_reset(VirtIODevice *vdev);
+void virtio_complete_reset(VirtIODevice *vdev);
 void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
 void virtio_update_irq(VirtIODevice *vdev);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607338c9..8d5f58a02df6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3423,11 +3423,10 @@ int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
 void virtio_reset(VirtIODevice *vdev)
 {
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    VirtioSharedMemory *shmem;
-    uint64_t features[VIRTIO_FEATURES_NU64S];
-    int i;
 
     virtio_set_status(vdev, 0);
+    vdev->status = VIRTIO_CONFIG_S_FAILED;
+
     if (current_cpu) {
         /* Guest initiated reset */
         vdev->device_endian = virtio_current_cpu_endian();
@@ -3448,6 +3447,15 @@ void virtio_reset(VirtIODevice *vdev)
         k->reset(vdev);
     }
 
+    virtio_complete_reset(vdev);
+}
+
+void virtio_complete_reset(VirtIODevice *vdev)
+{
+    VirtioSharedMemory *shmem;
+    uint64_t features[VIRTIO_FEATURES_NU64S];
+    int i;
+
     vdev->start_on_kick = false;
     vdev->started = false;
     vdev->broken = false;

-- 
2.55.0


