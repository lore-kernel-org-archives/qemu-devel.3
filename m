Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFFAC5CFEE
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8f1-0001Yp-SJ; Wed, 12 Aug 2026 09:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8eb-0000ct-9t; Wed, 12 Aug 2026 09:05:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8eZ-0004vN-0x; Wed, 12 Aug 2026 09:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=P/AKWco2wBqO6jBi3zzf5fb2Ksg/gZsUwaS36yEb6bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wQh/vO2D0hHVB+1VPglLg5CY+0MPtBIT6c86aY/sN9UgLyr7RBbgF466HVC8RYxrK
 s2RR/Twn2EReIwyxKNBWe08p3FT7nOq9hoPWq1wT6szU60Or2cV3ajHSXC9RlmP0UF
 nr+z8857Wns2jNc3CTKUFAnVWrkYdXlaP0CotEQzAfu13uXD30HaE4ot+LSpJ5cfor
 AcV4VROuXZkmh97HYQ12Bu55PMITlkaSwdyrBdWA3Yyo9ouvDXz3Pmu0pfrAeqlzOL
 ZWBoWgmPPeamm7sq+WckXmXUbMggxmXb4tRS+2JtO5xxioCMntoa5CG15/9IplJF0A
 FeiXOI02Clmgw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A66E41CA49F;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC456409B82;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1F7A82F8D4; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 032/102] hw/display/virtio-gpu: Fix empty blob
 discrimination
Date: Wed, 12 Aug 2026 16:01:07 +0300
Message-ID: <20260812130233.621965-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Discriminating blobs by checking whether blob_size is nonzero fails for
empty blobs. Identify 2D resources by their non-NULL image instead.

Fixes: bdd53f739273 ("virtio-gpu: Update cursor data using blob")
Fixes: f66767f75c9c ("virtio-gpu: add virtio-gpu/blob vmstate subsection")
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260725-image-v1-1-4698a805afde@rsg.ci.i.u-tokyo.ac.jp>
(cherry picked from commit 0fa3e1823b9b9ae1fc1ea0d290849578907a770b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 67ccc81e50c..598ee4026c1 100644
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
@@ -1281,7 +1281,7 @@ static int virtio_gpu_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (res->blob_size) {
+        if (!res->image) {
             continue;
         }
         qemu_put_be32(f, res->resource_id);
@@ -1422,7 +1422,7 @@ static int virtio_gpu_blob_save(QEMUFile *f, void *opaque, size_t size,
     assert(QTAILQ_EMPTY(&g->cmdq));
 
     QTAILQ_FOREACH(res, &g->reslist, next) {
-        if (!res->blob_size) {
+        if (res->image) {
             continue;
         }
         assert(!res->image);
-- 
2.47.3


