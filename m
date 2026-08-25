Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2D8C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wypMj-0005ln-Md; Tue, 25 Aug 2026 07:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMJ-0005ZQ-2j
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wypMH-0006UN-C3
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 07:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787657423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RU+E0PxmQDtUNb+74H9rVkxLJkFU1YhVf4BZGlMGbH4=;
 b=PyZ7xOB6VzDGX6zCpf7fmLlZtT8lvwSjJi84qhqzdaVlVgbaOmIb6aXidD1tJ1WQYJbaVz
 txt8rdw2dCOW94CI2CX5hE0GD85/n2b4SR6EDHkEX8zXxPwf8JbTXHXbiPuxxBvUTwcqJv
 YYphPI1zcOE2qjqwvtlDqfH9I2B+ASY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-0bdtCheSNVOiDSNquvM6Qg-1; Tue,
 25 Aug 2026 07:30:20 -0400
X-MC-Unique: 0bdtCheSNVOiDSNquvM6Qg-1
X-Mimecast-MFC-AGG-ID: 0bdtCheSNVOiDSNquvM6Qg_1787657419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17C791955DDF; Tue, 25 Aug 2026 11:30:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1D1C30002F0; Tue, 25 Aug 2026 11:30:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 15:21:07 +0400
Subject: [GIT PULL 17/19] hw/display/virtio-gpu: Validate resource per command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-fixes-v1-17-c59e8a620836@redhat.com>
References: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
In-Reply-To: <20260825-fixes-v1-0-c59e8a620836@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6715;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=b8AGFms1qm0EUGpts3LUCRJqtr768B/5CA4S3QHib+4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjXrVHwzBflEgVPgR5I0aYMXHUt9hifoxdt57A
 HheXUWV1BSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao161QAKCRDa6OEJdZac
 5a2DD/9//7iVSCMEOTQrNZtd1E7i4xUcH4oRh2a1rA9qHvzGRhHl0XKEGaW38/DVgDknXOsJ0wN
 oiwnQsBIfJ3voz75u1lvm+OrFSD/6TrRjEtmZJHHy1uV3pkHB0Fb56Be6+QcZ+j2RncdKPFPh69
 LEH0zmy4GW3kAU3PSnuq0yLzlPkSPNILVr/YH8eIkovJGqqwMNZhI/RlzvcN8S+EU0b8Mn64yBt
 t4f6d+A+KZ8whHk0F38QvKiUTGSCW/OTiAJReifBNFzXd68eRlnQKR+eYU3DjmhyK6SvYB9XM5F
 Wu1lZwiWHcCn5uUuWbYtWUP8Ukdmz8toQNogCpJK1twrHlm6BqIFzsM+UctTc7sFm35UUp3pgl+
 VU+BiFbHq72Thnw7kQkwyESoN++rb9K08g3366Y9S8SXLbRU/rD+aZQVISMRK+kQmAFwOIe8De+
 7DE1qIX0aFpdBN7TRh1aGILcIsAK/T3HvLwQ+mSg8OJphV5iCA7k+R7U/R/850OLt1rB9NVM7le
 A2CmLcc/yJi4vMvYh2ezqMWjmjtBVys+GmSTl6Qrz55tUmFURl2RLbpVuqbPyZcf/myfSV3egho
 /oqp4XCNtSXf8p3+nH8D7UYUXTeB4q/m1lmmi4HxozHX5mZiIfm7ZZ8rwWIF4gvXFfjJNW9LNa9
 4yEmnN8qJQ4jq8A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825-dmabuf-v2-5-b3d64d3b9a0e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 66 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 21 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 01549d29d8a2..55a1c7f80fb8 100644
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
@@ -1067,7 +1091,7 @@ virtio_gpu_resource_detach_backing(VirtIOGPU *g,
     virtio_gpu_bswap_32(&detach, sizeof(detach));
     trace_virtio_gpu_cmd_res_back_detach(detach.resource_id);
 
-    res = virtio_gpu_find_check_resource(g, detach.resource_id, true,
+    res = virtio_gpu_find_check_resource(g, detach.resource_id,
                                          __func__, &cmd->error);
     if (!res) {
         return;

-- 
2.55.0.543.g5ebe2ebe4ea8


