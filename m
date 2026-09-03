Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347E4C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fD-0002sM-Fa; Thu, 03 Sep 2026 10:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f9-0002oU-Qi
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:35 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f7-000460-Na
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-495437bb891so9081905e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446612; x=1789051412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JT9O3uxdl/4u+w7L1goAbIpPRjFt3fljeh9+YaQRlKg=;
 b=Ye4LjipiAlxU/7HJLW95qJIIBzAmDlungSAZRZ6suSJ3pyiL4nkGVGR2/+AJzsLt3m
 IHOPXfq9KUMkMNwholg3xoNEj7LtJz5PrOJgNz22SgIwTzUjyn/lJ71vVWWlILN5MdGt
 PD2K5ppUb0k/ORvy2nFqQq77yIxi3G7wNmBArq1YZREaN5ArV3fTISkdBeh+8JlZu9Tz
 di6jC/BCpWFDdMnZrNKnBkfnOOnSzdICyFCZBx2PtkOwRRA4g4iWKJwYfowG8rmd6h0j
 lTOER97G4+/g29G2DWQiOocvNwrcM5Brj2vVx8QytJTKaEQ84+oWzcSS/svq9oFFbCTM
 HuBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446612; x=1789051412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JT9O3uxdl/4u+w7L1goAbIpPRjFt3fljeh9+YaQRlKg=;
 b=BQaTnIoT/Trb/EhB0nhwgEs+hrHCYEww1HhixWbrRIDSz4dXnGrFJKN4gGZiJT22Ni
 GQjlRK+oYD7LsY8G3+7l5MjbbO1RXQ3RdokXflE5MH+0BMAasmfrWkjFhgupkOjaa2xK
 tv71jOxn+Kqk3klNDV6kEeVhfEq6WgDZwa8/EtU4VbBWkhZU9/Ng/ZXfsJTvWG3ofsME
 Alqxxuq3jjk5WbWi5Elk7HKSbuDjk/EhQta8MmLvJD+zBMfyatgDlOjxiURcH8P7vUaM
 DkgEwRxde269ZObVyalm7ZZVJOvx8KoSLWdsMuEwZ2WPlSgo441Uzbcen1JDZlFZ2Lmo
 DgVQ==
X-Gm-Message-State: AFuF++lTaYy01p3goRhjGiW8f2XW3rBdwT54GFEPHJSIwIB3UdzbVebA
 jNGuF1FB+zflnie372jcVUUQ/db1GpU6Yk4h7pTdNU/IcJcYq69sjNNcaDey3IzrSKOG+CvKb5/
 6PRTS
X-Gm-Gg: AYBFou2Rq/M7TG1p3sSguJ6EFiCHwXwTOJxNG6YkwOoSkOGe3MO30smfj33aDOOgU03
 EMzjAs4nWd0tfwZhg9uq2kIfbaY+jsA1Z5LVbf7qI87195iY1EN6ZRfquMLhKM3ikEMhMmPzWYW
 erOJtP4GkbEhQkdwZsqkkhkAgFQsNVUe4AXtcDjcDfR+6jz+Ej3rj1LGT+SDBcWoQN96S4LXSUt
 JW1Hqp7yVN6hmXrtTY1SxMlKLy0i5lIhpIaMwzQKOb/jxWuTxtMHCSLw4Li6qq/bXkON1Q4i87N
 6ZKk10EZ08SrbHavN/fUjt8Gs1BtzB/uJ+9Lyf38kXqZNLu4SaDLJtfaBgXyAgDAWs67XeF0WxB
 dw3hNm8noz8KG+4ofaepvVauGsioGj7Vb/QIWLEz8yblzBdlU5tsK4nFNuVRu+/wEM+Ug36RbhU
 7UxaWQ72F/FqS0KIbYi+hE9WW+ylBsyrP6fs7v/L3TK8eR9IRUxOKz/LUA7U7ZzTIbpdPh
X-Received: by 2002:a05:600c:8608:b0:49b:920b:5704 with SMTP id
 5b1f17b1804b1-49cee5b75cbmr58458585e9.3.1788446612153; 
 Thu, 03 Sep 2026 07:43:32 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 18/25] parallels: implement removing a stored dirty bitmap
Date: Thu,  3 Sep 2026 16:41:36 +0200
Message-ID: <20260903144143.2328870-19-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=den@openvz.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

block-dirty-bitmap-remove leaves a parallels image alone. The driver has
no bdrv_co_remove_persistent_dirty_bitmap(), and a missing handler means
nothing to do, so the command reports success while the bitmap stays in
the image until the node is inactivated. qcow2 updates its bitmap
directory on the spot.

Implement the handler. The Format Extension is written as a whole rather
than edited in place, so the bitmap is dropped by clearing its
persistence and storing what is left, and the header is updated to point
at the new extension. Releasing the bitmap itself is up to the caller.
The store runs under s->lock, as it allocates a cluster and a request
can be in flight, unlike the inactivation path where the node is
quiesced already.

Removing a bitmap which was never stored is not an error, as
bdrv_co_remove_persistent_dirty_bitmap() spells out, so a name which is
not there, or is not persistent, is answered with success and no write.

Write access is checked first. The extension is only rewritten while the
node is writable, so on a read-only or an inactive node the request could
not reach the image at all and reporting success would be a lie. The
generic BDRV_BITMAP_RO check in block_dirty_bitmap_remove() hides this
for a read-only node, but it does not cover an inactive one, and
dropping a bitmap which was never stored needs no write access at all.

Persistence is only dropped for the duration of the rewrite, so it goes
back on when the rewrite fails. The bitmap is still in the image, and a
bitmap which is no longer marked persistent would be dropped for good by
the next inactivation, turning a removal the caller was told had failed
into one which silently succeeded.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 block/parallels.c     |  4 +++-
 block/parallels.h     |  4 ++++
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index b7fac2514a..f687f2da7c 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -689,3 +689,50 @@ bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
 
     return true;
 }
+
+int coroutine_fn
+parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                            const char *name, Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    Error *err = NULL;
+    int ret;
+
+    if (bdrv_is_read_only(bs) || (bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
+        error_setg(errp, "Cannot remove persistent bitmap '%s': no write "
+                   "access to node '%s'", name, bdrv_get_node_name(bs));
+        return -EACCES;
+    }
+
+    bitmap = bdrv_find_dirty_bitmap(bs, name);
+    if (bitmap == NULL || !bdrv_dirty_bitmap_get_persistence(bitmap)) {
+        return 0;
+    }
+
+    /* The extension is written as a whole, so drop it from what goes in */
+    bdrv_dirty_bitmap_set_persistence(bitmap, false);
+
+    ret = 0;
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        parallels_store_persistent_dirty_bitmaps(bs, &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            ret = -EIO;
+            break;
+        }
+
+        ret = parallels_update_header(bs);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to update the image header");
+            break;
+        }
+    }
+
+    if (ret < 0) {
+        /* Nothing was removed, so the bitmap is as persistent as it was */
+        bdrv_dirty_bitmap_set_persistence(bitmap, true);
+    }
+
+    return ret;
+}
diff --git a/block/parallels.c b/block/parallels.c
index 90b7f7c8de..2a5ceb8978 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1288,7 +1288,7 @@ static int parallels_probe(const uint8_t *buf, int buf_size,
     return 0;
 }
 
-static int GRAPH_RDLOCK parallels_update_header(BlockDriverState *bs)
+int GRAPH_RDLOCK parallels_update_header(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
     unsigned size = MAX(bdrv_opt_mem_align(bs->file->bs),
@@ -1651,6 +1651,8 @@ static BlockDriver bdrv_parallels = {
     .bdrv_inactivate            = parallels_inactivate,
     .bdrv_co_can_store_new_dirty_bitmap =
                                   parallels_co_can_store_new_dirty_bitmap,
+    .bdrv_co_remove_persistent_dirty_bitmap =
+                                  parallels_co_remove_persistent_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 4684ba2890..27d8c3ac83 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -98,6 +98,7 @@ int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
 
 int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
                                                       int64_t *clusters);
+int GRAPH_RDLOCK parallels_update_header(BlockDriverState *bs);
 
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
@@ -107,5 +108,8 @@ parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp);
 bool coroutine_fn GRAPH_RDLOCK
 parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                         uint32_t granularity, Error **errp);
+int coroutine_fn GRAPH_RDLOCK
+parallels_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
+                                            const char *name, Error **errp);
 
 #endif
-- 
2.53.0


