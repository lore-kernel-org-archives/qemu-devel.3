Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F3C531FA
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 07:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnWZI-0000nx-R5; Sat, 25 Jul 2026 03:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWZH-0000nX-KQ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:13:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnWZF-0002L5-Sd
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 03:13:07 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66P7CpxK072899
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 16:12:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vRvrLScJdPAR0GchgnULs5QQyUZjxsc0NNPjWRm/ulc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1784963577; v=1;
 b=HLi4bIWEralpavy74wZL3EgfzM5ycWPBhJ0FhCDdd5oDKZbxQBlwYu/iY8BxiMWk
 Fahn5ITjeOxXuOfW05TypjBXVloSjR8GuXwZXWNlMSsMzEsjrMVEJw6OdUOzQKWh
 x9Z1918bNdVnon7u9uKV4YOTK++P2E0GzUZjykeUgv3ITXyRXU8Yuct6OWe3XD8+
 7SBC+uCNyH7cIWbrIHMb53a/JWkW0BVrC6HaE7bkYbU4PV6TVcnOPS9r6i+SlD6c
 cxvVxlil7pGDBqD8ti4JIDvtk6ssOcn6EJN+QXGirmRDIESBLenoFccTmEd9xmw7
 3OENbJ3c0QpgH+b8c72Lhg==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 16:12:51 +0900
Subject: [PATCH] hw/display/virtio-gpu: Fix empty blob discrimination
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNT3czcRKCgWbKFqZlZWpKhkamxElBtQVFqWmYF2JzoWAi/uDQpKzW
 5BKRZqbYWAFZbFuRpAAAA
X-Change-ID: 20260725-image-6c8566fb1253
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=rv35K+1UHqKxm3Q6RjhDIj+vD7Yt/ozd4azyoZoLebo=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ1ZK4o9Mx4NH9LZbrej/2Hoja9XDJz375UpKGk63mLz/5
 fo07NrOjlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIn0pzP8Zvte1f9wvktRUHzy
 gfrFE3bINF7avd7G+iBHxh+WmFyztwz/8yPPF28rbFr6pPdo+ouafn3mDy9cHDUMY1on+KS8ueL
 OAwA=
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

Discriminating blobs by checking whether blob_size is nonzero fails for
empty blobs. Identify 2D resources by their non-NULL image instead.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/display/virtio-gpu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 718ba3039290..6413df029b8e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -56,18 +56,18 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
         return;
     }
 
-    if (res->blob_size) {
-        if (res->blob_size < (s->current_cursor->width *
-                              s->current_cursor->height * 4)) {
-            return;
-        }
-        data = res->blob;
-    } else {
+    if (res->image) {
         if (pixman_image_get_width(res->image)  != s->current_cursor->width ||
             pixman_image_get_height(res->image) != s->current_cursor->height) {
             return;
         }
         data = pixman_image_get_data(res->image);
+    } else {
+        if (res->blob_size < (s->current_cursor->width *
+                              s->current_cursor->height * 4)) {
+            return;
+        }
+        data = res->blob;
     }
 
     pixels = s->current_cursor->width * s->current_cursor->height;
@@ -1279,7 +1279,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (res->blob_size) {
+        if (!res->image) {
             continue;
         }
         qemu_put_be32(f, res->resource_id);
@@ -1430,7 +1430,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (!res->blob_size) {
+        if (res->image) {
             continue;
         }
         assert(!res->image);

---
base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
change-id: 20260725-image-6c8566fb1253

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


