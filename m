Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62C9606A9AE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U7DwgthP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhIS-0005sJ-NR; Tue, 10 Nov 2026 03:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhIC-0005Vo-58
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xQhIA-0003PT-84
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 03:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794299601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvYLEn6swAp2cYlML3Of34lA0JyEtQfOMP1ccxl+zUk=;
 b=U7DwgthPQ/SLcjXXN5UUbRcQVAM1HpL5ANxgCPBCo/YfmUupsmCJs1ikYmabdYaxLrHr4e
 KvUGu368gEl6rDZ6beOJJK0Jmwo/+H6dKmzGu+C6fOMbBV7/b2D+klGXQkunQ6V2Bxsw9v
 b6FSqbd+1Fm3POHtDtJvNsf9K0f5tns=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44--z8GGeGMOhakinWrdhEsvA-1; Tue,
 10 Nov 2026 03:33:16 -0500
X-MC-Unique: -z8GGeGMOhakinWrdhEsvA-1
X-Mimecast-MFC-AGG-ID: -z8GGeGMOhakinWrdhEsvA_1794299595
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4435E180055C; Tue, 10 Nov 2026 08:33:15 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 760A018004E9; Tue, 10 Nov 2026 08:33:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Nov 2026 12:31:14 +0400
Subject: [PATCH 4/4] contrib/vhost-user-gpu: reject non-32bpp cursor resources
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261110-master-v1-4-7a0505d6c259@redhat.com>
References: <20261110-master-v1-0-7a0505d6c259@redhat.com>
In-Reply-To: <20261110-master-v1-0-7a0505d6c259@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Gurchetan Singh <gurchetan.singh.foss@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5821;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Qn0htwnuIGFJEZcglJ8juElzhMKoQ+aGUuk4x1FH/+4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq8ta3/8U7RNo6p8xi0N69oZ7wBUJGn+eMZC+FS
 SaBTz+Ee/iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavLWtwAKCRDa6OEJdZac
 5ao9D/9Ojtz40OEUjmunIa6dcsry05SD4ePNuxQ923X220d82IlKdzKAL/XMB4iAyy05pLvhVTZ
 EP/laMNa/tMLaMH8Bg4oOg/YCT5kd7uIv6VOTHofBmyuJcP2eYAO27kgVUQXy0VSGChdtkiETZB
 t67eYDfp/W3QAEsb8xow1f7j+p0GQm8iNTrwcggvI2EhFHpeZD/c2XVUotebaxEihPzSeG8XYz2
 fzmG5L46hBhMnR5RsojjxfSCLCLjFDNRm4+yfU7GsMZPckmwEVsEpcx3nQ2OrdCvSvMeNdkMJua
 XxxsY6Dja2VsbwEZUhdnZMI9KLCr1duprb3+itnrKdVD9j9jPnDrXO+1HMiuF4I1UR59LjiedZU
 p5FE2SGMBLyBe8oWaFIJpNW/YzJzRQrnNkGQSMu4fLZHdVGQ3H+of0MBqlZ5f67mkKjEwYniPhk
 /OKGj7DLI/GMp4mrloSGyj6USkjJpNpnQxPtCPWvdHjoOE83cU/SmRz1nkXBMV9+xVvuNuBxDX3
 iklIqwUUaRHnh3BopN+cm4gcH9OC38K/LzGkYKjjP2AYraSilg/UQ8FX6zQANmXnmoZoM7B4SLo
 d6rs4yDWqbsyib5moZnjwNwAMKJLkT31LemTWlkV7apjeKC/PnpG5Yyxz6s5rxog26iUqtntpkk
 Cy3L3WlzLcwIAwA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cursor pixel data is copied as 32bpp, but the resource format is never
checked. virgl_renderer_get_cursor_data() sizes its buffer for the
resource's own format, while vg_virgl_update_cursor_data() copies
64 * 64 * 4 bytes from it: a 64x64 R8_UNORM resource gives a 4096 byte
buffer, so 12 KiB past its end is read and handed to the display
backend as cursor pixels.

Look up the resource format and refuse anything that is not 32bpp,
matching the virtio-gpu backends.

While at it, let g_autofree release the buffer: the 64x64 check returned
before it was freed, letting a guest grow the backend's memory with
repeated UPDATE_CURSOR.

Fixes: CVE-2026-122027
Fixes: d52c454aadcd ("contrib: add vhost-user-gpu")
Reported-by: Fernando Bortotti <https://gitlab.com/fernando.bortotti>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/vhost-user-gpu.c | 31 ++++++++++++++++++++-----------
 contrib/vhost-user-gpu/virgl.c          | 25 ++++++++++++++++++-------
 contrib/vhost-user-gpu/virgl.h          |  2 +-
 3 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index f70b34c179f3..b34a1e013b8b 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -949,19 +949,22 @@ vg_handle_ctrl(VuDev *dev, int qidx)
     }
 }
 
-static void
+static bool
 update_cursor_data_simple(VuGpu *g, uint32_t resource_id, gpointer data)
 {
     struct virtio_gpu_simple_resource *res;
 
     res = virtio_gpu_find_resource(g, resource_id);
-    g_return_if_fail(res != NULL);
-    g_return_if_fail(pixman_image_get_width(res->image) == 64);
-    g_return_if_fail(pixman_image_get_height(res->image) == 64);
-    g_return_if_fail(
-        PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) == 32);
+    if (!res || !res->image ||
+        pixman_image_get_width(res->image) != 64 ||
+        pixman_image_get_height(res->image) != 64 ||
+        PIXMAN_FORMAT_BPP(pixman_image_get_format(res->image)) != 32) {
+        g_debug("%s: invalid cursor resource %u", G_STRFUNC, resource_id);
+        return false;
+    }
 
     memcpy(data, pixman_image_get_data(res->image), 64 * 64 * sizeof(uint32_t));
+    return true;
 }
 
 static void
@@ -984,6 +987,7 @@ vg_process_cursor_cmd(VuGpu *g, struct virtio_gpu_update_cursor *cursor)
         break;
     }
     case VIRTIO_GPU_CMD_UPDATE_CURSOR: {
+        bool ok = true;
         VhostUserGpuMsg msg = {
             .request = VHOST_USER_GPU_CURSOR_UPDATE,
             .size = sizeof(VhostUserGpuCursorUpdate),
@@ -998,12 +1002,17 @@ vg_process_cursor_cmd(VuGpu *g, struct virtio_gpu_update_cursor *cursor)
             }
         };
         g_debug("%s: update", G_STRFUNC);
-        if (g->virgl) {
-            vg_virgl_update_cursor_data(g, cursor->resource_id,
-                                        msg.payload.cursor_update.data);
+        if (!cursor->resource_id) {
+            /* no resource: send a transparent cursor */
+        } else if (g->virgl) {
+            ok = vg_virgl_update_cursor_data(g, cursor->resource_id,
+                                             msg.payload.cursor_update.data);
         } else {
-            update_cursor_data_simple(g, cursor->resource_id,
-                                      msg.payload.cursor_update.data);
+            ok = update_cursor_data_simple(g, cursor->resource_id,
+                                           msg.payload.cursor_update.data);
+        }
+        if (!ok) {
+            break;
         }
         vg_send_msg(g, &msg, -1);
         break;
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 0ef4b9d8c903..8af5a456ee5b 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -14,24 +14,35 @@
 
 #include "qemu/osdep.h"
 #include <virglrenderer.h>
+#include "hw/virtio/virtio-gpu-pixman.h"
 #include "virgl.h"
 
 #include <epoxy/gl.h>
 
-void
+bool
 vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
                             gpointer data)
 {
-    uint32_t width, height;
-    uint32_t *cursor;
+    struct virgl_renderer_resource_info info = { 0 };
+    g_autofree uint32_t *cursor = NULL;
+    uint32_t width = 0, height = 0;
+
+    virgl_renderer_force_ctx_0();
+    if (virgl_renderer_resource_get_info(resource_id, &info) != 0 ||
+        !virtio_gpu_format_is_cursor_capable(info.virgl_format)) {
+        g_debug("%s: invalid cursor resource %u", G_STRFUNC, resource_id);
+        return false;
+    }
 
     cursor = virgl_renderer_get_cursor_data(resource_id, &width, &height);
-    g_return_if_fail(cursor != NULL);
-    g_return_if_fail(width == 64);
-    g_return_if_fail(height == 64);
+    if (!cursor || width != 64 || height != 64) {
+        g_debug("%s: failed to read cursor resource %u (%ux%u)",
+                G_STRFUNC, resource_id, width, height);
+        return false;
+    }
 
     memcpy(data, cursor, 64 * 64 * sizeof(uint32_t));
-    free(cursor);
+    return true;
 }
 
 static void
diff --git a/contrib/vhost-user-gpu/virgl.h b/contrib/vhost-user-gpu/virgl.h
index 17078783a50f..40caa766d3fe 100644
--- a/contrib/vhost-user-gpu/virgl.h
+++ b/contrib/vhost-user-gpu/virgl.h
@@ -20,7 +20,7 @@
 bool vg_virgl_init(VuGpu *g);
 uint32_t vg_virgl_get_num_capsets(void);
 void vg_virgl_process_cmd(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
-void vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
+bool vg_virgl_update_cursor_data(VuGpu *g, uint32_t resource_id,
                                  gpointer data);
 
 #endif

-- 
2.56.0.116.g6de20f6092dc


