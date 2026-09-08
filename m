Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2C2C79FA0
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3p5E-000252-H0; Tue, 08 Sep 2026 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p5A-00021s-Lw; Tue, 08 Sep 2026 02:13:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x3p58-0000jl-D0; Tue, 08 Sep 2026 02:13:24 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6886CG93048190
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 8 Sep 2026 15:12:27 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Wqg411X6kLRW/EQGXIl4BhhjQoaxFpEtuNgHQ08Dk4g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1788847948; v=1;
 b=ikMatKFpJn6XnDxZpl+aiAhSMKI/n4pWLbkkJTfVcqOGebXxtJMx8HWKZme2EH57
 wzNXQVhVoLR/nq9BBnMbZXqd5nzvek+4ap7CqPOePd7gQdWV29MHuqZeSyeoBjI8
 5/QuEt330tZp3ont1e+YgSt+WUW4MesfOgwVPNNTSW+gq/k3C5eKKHDx7j1vRXcM
 EjsB9CLNnTFBiS6+/Gkl71pDVynO+Pvg63tbWPajobTdnMtpppcag9ZnnW3U4osn
 jk18KGZDynMEYkaZ1vIWG+LP91sG4GPZfqzQr1E5bCtezzPkRZyFUDfyzBBM8jdR
 2C7HrIA2FI/GDiBbj2nPZQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 08 Sep 2026 15:11:23 +0900
Subject: [PATCH v3 6/9] hw/display/virtio-gpu: Fix fenced blob unmapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-gpu-v3-6-25332a85f909@rsg.ci.i.u-tokyo.ac.jp>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4919;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=KwQmvw0JJoVOJJ/W9yoKcRvQA9ko2naUvEzs+b3T/Co=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9b85W5Pbnm9K2l8Orfmfsdc4cfJVjnzpV5/+TlZ8/avx
 KOJPP72HaUsDGJcDLJiiiwpRbu5NaJrPxUmxLfAzGFlAhnCwMUpABMpcWD4xcTBvt/8y6kDs71d
 naJUPqY9yY3rO8gRFfHT7+uXNyalSxgZjrME6Djm2k7afLxp7741n9emz7l0etNHvt2LuD4ulyl
 R5AAA
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

Blob unmapping may be suspended because of remaining uses of the
mapping. virtio_gpu_process_cmdq() uses the following condition to
detect a suspended command:

    !cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)

However, the guest may set VIRTIO_GPU_FLAG_FENCE for a command that
performs blob unmapping. Such a command will be incorrectly assumed
as not being suspended. Add a dedicated flag for the suspended state
to avoid overloading VIRTIO_GPU_FLAG_FENCE.

Fixes: 640f9149c3dc ("virtio-gpu: Support suspension of commands processing")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/hw/virtio/virtio-gpu.h |  1 +
 hw/display/virtio-gpu-virgl.c  | 17 +++++++----------
 hw/display/virtio-gpu.c        |  5 ++---
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 9404e488208a..3eccc4bc39c3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -141,6 +141,7 @@ struct virtio_gpu_ctrl_command {
     struct virtio_gpu_ctrl_hdr cmd_hdr;
     uint32_t error;
     bool finished;
+    bool suspended;
     QTAILQ_ENTRY(virtio_gpu_ctrl_command) next;
 };
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9bda572426b2..c37df91e3ed1 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -440,8 +440,7 @@ virtio_gpu_virgl_resource_unref(VirtIOGPU *g,
 }
 
 static void virgl_cmd_resource_unref(VirtIOGPU *g,
-                                     struct virtio_gpu_ctrl_command *cmd,
-                                     bool *cmd_suspended)
+                                     struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_resource_unref unref;
     struct virtio_gpu_virgl_resource *res;
@@ -457,7 +456,7 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         return;
     }
 
-    virtio_gpu_virgl_resource_unref(g, res, cmd_suspended);
+    virtio_gpu_virgl_resource_unref(g, res, &cmd->suspended);
 }
 
 void virtio_gpu_virgl_resource_destroy(VirtIOGPU *g,
@@ -946,8 +945,7 @@ static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
 }
 
 static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
-                                          struct virtio_gpu_ctrl_command *cmd,
-                                          bool *cmd_suspended)
+                                          struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_resource_unmap_blob ublob;
     struct virtio_gpu_virgl_resource *res;
@@ -964,7 +962,7 @@ static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
         return;
     }
 
-    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
+    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, &cmd->suspended);
     if (ret) {
         cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
         return;
@@ -1036,7 +1034,6 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
-    bool cmd_suspended = false;
     int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
@@ -1080,7 +1077,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_flush(g, cmd);
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNREF:
-        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
+        virgl_cmd_resource_unref(g, cmd);
         break;
     case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
         /* TODO add security */
@@ -1110,7 +1107,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_map_blob(g, cmd);
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
-        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
+        virgl_cmd_resource_unmap_blob(g, cmd);
         break;
     case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
         virgl_cmd_set_scanout_blob(g, cmd);
@@ -1121,7 +1118,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     }
 
-    if (cmd_suspended || cmd->finished) {
+    if (cmd->suspended || cmd->finished) {
         return;
     }
     if (cmd->error) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index d520f69e6453..dd6c09d1ddcf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1193,11 +1193,10 @@ void virtio_gpu_process_cmdq(VirtIOGPU *g)
             break;
         }
 
-        /* process command */
+        cmd->suspended = false;
         vgc->process_cmd(g, cmd);
 
-        /* command suspended */
-        if (!cmd->finished && !(cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_FENCE)) {
+        if (cmd->suspended) {
             trace_virtio_gpu_cmd_suspended(cmd->cmd_hdr.type);
             break;
         }

-- 
2.55.0


