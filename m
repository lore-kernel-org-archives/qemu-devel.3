Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE5DC79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p9u-0006pm-Mh; Tue, 08 Sep 2026 02:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p9t-0006ot-6R; Tue, 08 Sep 2026 02:18:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p9r-0001DX-EL; Tue, 08 Sep 2026 02:18:16 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG90048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=tFQOTT0vVoGpyKhlv+GFyvs8ySiv1kBFovWP8aSdHK0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847947; v=1;
 b=mC5SzKV3rVrDTInHC1RgoxviyYBWNA1Rw2gSwUeqDpd6ajmZrPHLFg7KVen4azQU
 lRy30uG5SeiO0U08Uhcqe8ZornzvHSESvMLqpXoHT0IzCe/ttm86N1gJbSOZ1Xz1
 RfPZzwadXqhQXljE1FlrqT5pn9aB2ntbswgoUK4xW1MBpdgkKeeAummdlivNhuYU
 FOQf/Is9cMZnwskJJ7LMxIj744pi4sUzFCkxRzKSUWAkUJ+AHmZNxxRHlICOHRV6
 XI+yHm74va1yphlVrg8qkUm97k+D5MEM4XlubwPahOEt7WMmZf820/xbaydwcNAl
 d9tx7h+Nsq9my511OgTZkw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:20 +0900
Subject: [PATCH v3 3/9] virtio: Preserve an error during reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-3-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=4JML88kJB9+WpvjlOWtBhAD3Qc8A4Re1hSts14MdJs8=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85S4sbq8FnxoFZvZzHL2mtD/AUt/mx54D019cCz7N5
 vlPsaqro5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCI+Ygz/1Ps3f99pJ7/616yZ
 AWpXhBYYi2SG65tGXrp17/j9EIM5dxn+V9nsfWpiJxq0ewtDo7AnJydjwIrVOxNKH692WHikNfo
 DEwA=
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

A virtio device that had an error during reset will be marked as broken
and will not report reset completion to the guest.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/virtio/virtio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index ed43c8bcb0bd..0b245f73f9d1 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3443,6 +3443,7 @@ void virtio_reset(VirtIODevice *vdev)
         }
     }
 
+    vdev->broken = false;
     k->reset(vdev);
 }
 
@@ -3454,11 +3455,14 @@ void virtio_complete_reset(VirtIODevice *vdev)
 
     vdev->start_on_kick = false;
     vdev->started = false;
-    vdev->broken = false;
     virtio_features_clear(features);
     virtio_set_features_nocheck(vdev, features);
     vdev->queue_sel = 0;
-    vdev->status = 0;
+
+    if (!vdev->broken) {
+        vdev->status = 0;
+    }
+
     vdev->disabled = false;
     qatomic_set(&vdev->isr, 0);
     vdev->config_vector = VIRTIO_NO_VECTOR;

-- 
2.55.0


