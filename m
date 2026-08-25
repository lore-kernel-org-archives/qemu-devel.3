Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9084BC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylbx-0005K1-Qc; Tue, 25 Aug 2026 03:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbu-0005HZ-Oc
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:18 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wylbq-00026s-Dh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:30:18 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67P7TsR8057787
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 16:30:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Ey//3aZEUk1CHNP0liGSL2vNkzrBp48N4daGv/uWJLU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1787643003; v=1;
 b=WeYW7aFE4frLezdR7eH7VJD0PW5wpkSwsmD8BDD22cimVRR7GfK/5dQfMvqf/ElF
 yaOwM1vxlBNMIQL3z1HGTyOeick48citcHFoh01dL8yGrHcKl6J/Qso7hey1DcuI
 JJU6xdfLGVOuf9ibCq3ZFphW0fiHjHzHwxFdew8WTL3+MEIQB+PPFlGXYNT7fXeR
 XdkwIOGR+dK4VWUkCushwXY2rVCeE+jE9UWgJP8/eXeBtGG9/dVc9tiD4AG3slqJ
 Z+kN7cvZFacjjPabzg7P+1cWtfNAJl54sLgoLuEpfv89IBJWNIDa0+hfX/y9eh8a
 EQsfDmshN9zg52O4sZPotw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Aug 2026 16:28:51 +0900
Subject: [PATCH v2 5/5] hw/display/virtio-gpu: Validate resource per
 command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-dmabuf-v2-5-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
References: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825-dmabuf-v2-0-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=6562;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=XLOWap4IH1BFMIQ4K12ZuKog1w1EqIoUjH+qNTIahxA=;
 b=kA0DAAoWKJ19aUZYEjEByyZiAGqNRHmh7T5CZ5kOxsqXSHKZ2EReQdA1i+i1VXGvZ54aPQcOD
 oh1BAAWCgAdFiEEZHK7CyhbffJxYF+EKJ19aUZYEjEFAmqNRHkACgkQKJ19aUZYEjHs0AD/R2/T
 IzvijtvV0J/62bKtteUlQJp1UdbsmMs+0aidN04A/RwgoJhO5lFHupYzTP3AHDyQRsATLdNJGWR
 omDcl8qEM
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

virtio_gpu_find_check_resource() checks if the resource has backing
storage if require_backing is true, but the condition conflates backing
storage attachment with host representation; it checks
!res->iov || (!res->image && !res->blob), but !res->iov is sufficient.

Furthermore, its callers passing true as require_backing have different
requirements:

- virtio_gpu_transfer_to_host_2d() requires a non-blob with
  backing storage.
- virtio_gpu_set_scanout() requires a non-blob but does not require
  backing storage.
- virtio_gpu_set_scanout_blob() requires a blob with backing storage.
- virtio_gpu_resource_detach_backing() accepts any resource.

Remove the require_backing parameter and open-code checks appropriate
for each function instead.

Fixes: 25c001a40346 ("virtio-gpu: Add virtio_gpu_find_check_resource")
Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 66 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 996b77829511..d9305fd5af5f 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -37,7 +37,6 @@
 
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
-                               bool require_backing,
                                const char *caller, uint32_t *error);
 
 static void virtio_gpu_reset_bh(void *opaque);
@@ -50,8 +49,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
     uint32_t pixels;
     void *data;
 
-    res = virtio_gpu_find_check_resource(g, resource_id, false,
-                                         __func__, NULL);
+    res = virtio_gpu_find_check_resource(g, resource_id, __func__, NULL);
     if (!res) {
         return;
     }
@@ -128,7 +126,6 @@ virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
 
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
-                               bool require_backing,
                                const char *caller, uint32_t *error)
 {
     struct virtio_gpu_simple_resource *res;
@@ -143,17 +140,6 @@ virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
         return NULL;
     }
 
-    if (require_backing) {
-        if (!res->iov || (!res->image && !res->blob)) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: no backing storage %d\n",
-                          caller, resource_id);
-            if (error) {
-                *error = VIRTIO_GPU_RESP_ERR_UNSPEC;
-            }
-            return NULL;
-        }
-    }
-
     return res;
 }
 
@@ -474,9 +460,24 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
     virtio_gpu_t2d_bswap(&t2d);
     trace_virtio_gpu_cmd_res_xfer_toh_2d(t2d.resource_id);
 
-    res = virtio_gpu_find_check_resource(g, t2d.resource_id, true,
+    res = virtio_gpu_find_check_resource(g, t2d.resource_id,
                                          __func__, &cmd->error);
-    if (!res || res->blob) {
+    if (!res) {
+        return;
+    }
+
+    if (!res->image) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d is a blob\n",
+                      __func__, t2d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    if (!res->iov) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: resource %d has no backing storage\n",
+                      __func__, t2d.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
     }
 
@@ -533,7 +534,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
     trace_virtio_gpu_cmd_res_flush(rf.resource_id,
                                    rf.r.width, rf.r.height, rf.r.x, rf.r.y);
 
-    res = virtio_gpu_find_check_resource(g, rf.resource_id, false,
+    res = virtio_gpu_find_check_resource(g, rf.resource_id,
                                          __func__, &cmd->error);
     if (!res) {
         return;
@@ -771,12 +772,19 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
         return;
     }
 
-    res = virtio_gpu_find_check_resource(g, ss.resource_id, true,
+    res = virtio_gpu_find_check_resource(g, ss.resource_id,
                                          __func__, &cmd->error);
     if (!res) {
         return;
     }
 
+    if (!res->image) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d is a blob\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     fb.format = pixman_image_get_format(res->image);
     bytes_pp = virtio_gpu_format_bytes_pp(fb.format);
     fb.width  = pixman_image_get_width(res->image);
@@ -866,12 +874,28 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU *g,
         return;
     }
 
-    res = virtio_gpu_find_check_resource(g, ss.resource_id, true,
+    res = virtio_gpu_find_check_resource(g, ss.resource_id,
                                          __func__, &cmd->error);
     if (!res) {
         return;
     }
 
+    if (res->image) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: resource %d is not a blob\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    if (!res->iov) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: resource %d has no backing storage\n",
+                      __func__, ss.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
     if (!virtio_gpu_scanout_blob_to_fb(&fb, &ss, res->blob_size)) {
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
         return;
@@ -1047,7 +1071,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     virtio_gpu_bswap_32(&detach, sizeof(detach));
     trace_virtio_gpu_cmd_res_back_detach(detach.resource_id);
 
-    res = virtio_gpu_find_check_resource(g, detach.resource_id, true,
+    res = virtio_gpu_find_check_resource(g, detach.resource_id,
                                          __func__, &cmd->error);
     if (!res) {
         return;

-- 
2.55.0


