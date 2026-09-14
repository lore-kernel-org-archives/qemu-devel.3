Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E213C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63Bi-0006mI-IF; Mon, 14 Sep 2026 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63Bg-0006lD-3F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:41:20 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x63Be-0001sN-8v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:41:19 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68E9fCdK025133
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 14 Sep 2026 18:41:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+SNjQSTjYTQuXo9g9m0nSujeJ2kduqznDiq97Hz0U9A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1789378876; v=1;
 b=nTFtgCec76ve+o/lL8qIz4Ts+BfPrwuH3yqo7KAXJbWIIg5KWMNsUFJt0ZX6avvb
 tdHIVltOS6XLK5KiNTXroyYV7+K+kC13/Bp83p+VTwEZDiqP0nXax6RUcH2ckwSW
 BXBv93/qRL+E+D51L5GUyr6vzmv89vJ4D8ioxvfi4+2i32rh8fJBgRtUY98/Jgut
 z/5w79YhKo1n8LWj/gPEJhUJI9vPhN1/hMEj9biAlCkY/P8M5jazoDvHJFjVi8kL
 9vW8CUFQDF+JOnZOdQnhvbmotSddUcScd5zB57qnBZ0CtZl4a1hCN9QaSiv6jhpC
 fEMBB1h3Ow37ox9k7v5mFg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 14 Sep 2026 18:40:40 +0900
Subject: [PATCH] hw/display/virtio-gpu: Block migration with large blobs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-block-v1-1-4df9617573ca@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNL3aSc/ORsXaPUtBQzs9RkI+PkFCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIM1RFUWphKdCCEqiy2loAn/4SaH4AAAA=
X-Change-ID: 20260729-block-2efd66ec23cd
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=KDvmjJ8HEQ2mdrZ7njg5NilOU8qMlDM0NwKIRwriYYc=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9byg6aHluu+lf6Y3XJK1irDk29hRa721PUzDctXZsQsX
 3UmaI9vRykLgxgXg6yYIktK0W5ujejaT4UJ8S0wc1iZQIYwcHEKwER2lzP8DzJ3NFhvvmrSnRem
 ZvHX+kQ9y8QfKzSaP53Pqr178Y/eDYwMb6byRn52YVt7uG5/juaXkoXTLnYliR/bLFH5Pl//wad
 MFgA=
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

The blob size is encoded as a 64-bit integer in the virtio protocol, but
it is encoded as a 32-bit integer in the migration stream, and
a large blob whose size cannot be expressed in a 32-bit integer will
be corrupted after migration.

Block migration with such large blobs, and, if it is not possible, deny
creating a large blob.

Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Supersedes: <20260727-blob-v2-1-d0b9af38a975@rsg.ci.i.u-tokyo.ac.jp>
("[PATCH v2] hw/display/virtio-gpu: Reject non-migratable large blobs")
---
 hw/display/virtio-gpu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bb0f41bb1e05..5d43ffb99184 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -27,6 +27,7 @@
 #include "hw/virtio/virtio-gpu-pixman.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/core/qdev-properties.h"
+#include "migration/blocker.h"
 #include "qemu/log.h"
 #include "qemu/memfd.h"
 #include "qemu/module.h"
@@ -35,6 +36,9 @@
 
 #define VIRTIO_GPU_VM_VERSION 1
 
+static size_t num_large_blobs;
+static Error *large_blob_blocker;
+
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                const char *caller, uint32_t *error);
@@ -355,6 +359,7 @@ end:
 static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
                                             struct virtio_gpu_ctrl_command *cmd)
 {
+    Error *local_err = NULL;
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_create_blob cblob;
     int ret;
@@ -415,6 +420,26 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
         }
     }
 
+    if (cblob.size > UINT32_MAX) {
+        if (!num_large_blobs) {
+            error_setg(&large_blob_blocker,
+                       "a large virtio-gpu blob is present");
+            if (migrate_add_blocker(&large_blob_blocker, &local_err)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: blocking migration for a large blob failed: %s\n",
+                              __func__, error_get_pretty(local_err));
+                error_free(local_err);
+                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+                virtio_gpu_fini_udmabuf(res);
+                virtio_gpu_cleanup_mapping(g, res);
+                g_free(res);
+                return;
+            }
+        }
+
+        num_large_blobs++;
+    }
+
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
@@ -460,6 +485,13 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *g,
 {
     virtio_gpu_disable_scanout_for_resource(g, res->resource_id);
 
+    if (res->blob_size > UINT32_MAX) {
+        num_large_blobs--;
+        if (!num_large_blobs) {
+            migrate_del_blocker(&large_blob_blocker);
+        }
+    }
+
     qemu_pixman_image_unref(res->image);
     virtio_gpu_cleanup_mapping(g, res);
     QTAILQ_REMOVE(&g->reslist, res, next);

---
base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
change-id: 20260729-block-2efd66ec23cd

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


