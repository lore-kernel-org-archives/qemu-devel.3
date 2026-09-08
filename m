Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66861C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5L-00029F-Km; Tue, 08 Sep 2026 02:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5K-00028m-Qi; Tue, 08 Sep 2026 02:13:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5I-0000ks-KJ; Tue, 08 Sep 2026 02:13:34 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG91048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GEjSVZsK/FjZl4C3KzdrtPbRyBxOF2Mp5btvoSNkpkE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847947; v=1;
 b=njgzEUZnE6whcZp+1yPa9Gt0wOblbYhf7DdAvDOzxVdysPl/0EO4NzqGawRZm8mR
 DlmKS6822KAaO/wjrHAuSw8vIxXt8Mmw64O1nzr1ZS1JA5BrMo74c93jZj5rCC2H
 1hPJlmOOFxXL9dMcaDLIvzDqXeJvijgnllY6Yj9Kwmoo4zk7eqxhj5HsoxGkXhcg
 if1UwsYlHSnRAbQ2b85OFcR69MhYohGER4heuIuPENrub2JBkrOiRl6bmawDL1zi
 nxT9WueOVo9fI3z338yQsKvkU97wIG/oWKPEnD61iPJaY3hd+BikaqOzgX1KugSS
 cVSFO3jPQjZtQXRuuQ2KEQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:21 +0900
Subject: [PATCH v3 4/9] hw/display/virtio-gpu-rutabaga: Reset Rutabaga
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-4-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=eOizTvjkS4G5bwGn4YWNrYtc01Yd3FSoWh8aiXPTZIM=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85S4cyUc/11YJ2n02du5+qVSpW/HiqLfSwbUZJpNft
 +6f0yrYUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMJHnJxn+VygFzPZ78+fLUkER
 9ZYdKxOSOc9b3N/A1K0uHsOW0sVhy8iwlqfGjY+jYu6aLUkZh6OjDDql71dwtJy9lPqodZPx2aX
 cAA==
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

Properly reset Rutabaga so that Rutabaga will not continue to interact
with guest memory, for example.

Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h   |  1 +
 hw/display/virtio-gpu-rutabaga.c | 16 ++++++++++++++++
 hw/display/virtio-gpu.c          |  4 ++++
 3 files changed, 21 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 69b5ee2e382f..acae2b4778b3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -226,6 +226,7 @@ struct VirtIOGPU {
 struct VirtIOGPUClass {
     VirtIOGPUBaseClass parent;
 
+    void (*reset)(VirtIOGPU *g);
     void (*handle_ctrl)(VirtIODevice *vdev, VirtQueue *vq);
     void (*process_cmd)(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd);
     void (*update_cursor_data)(VirtIOGPU *g,
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 041216a10d04..7bdeeeb5c023 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1074,6 +1074,21 @@ virtio_gpu_rutabaga_get_num_capsets(VirtIOGPU *g, uint32_t *num_capsets, Error *
     return true;
 }
 
+static void virtio_gpu_rutabaga_reset(VirtIOGPU *g)
+{
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+    Error *local_err = NULL;
+
+    if (vr->rutabaga) {
+        rutabaga_finish(&vr->rutabaga);
+    }
+
+    if (!virtio_gpu_rutabaga_init(g, &local_err)) {
+        virtio_error(VIRTIO_DEVICE(g), "%s", error_get_pretty(local_err));
+        error_free(local_err);
+    }
+}
+
 static void virtio_gpu_rutabaga_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOGPU *g = VIRTIO_GPU(vdev);
@@ -1156,6 +1171,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, const void *data)
     VirtIOGPUClass *vgc = VIRTIO_GPU_CLASS(klass);
 
     vbc->gl_flushed = virtio_gpu_rutabaga_gl_flushed;
+    vgc->reset = virtio_gpu_rutabaga_reset;
     vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
     vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
     vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 55a1c7f80fb8..b57f07bd26c8 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1761,6 +1761,10 @@ static void virtio_gpu_reset_bh(void *opaque)
         qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
     }
 
+    if (vgc->reset) {
+        vgc->reset(g);
+    }
+
     g->reset_finished = true;
     qemu_cond_signal(&g->reset_cond);
 }

-- 
2.55.0


