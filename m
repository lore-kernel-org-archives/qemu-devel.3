Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EC606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=J8jBHPHT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqW3-00027Q-4S; Tue, 10 Nov 2026 13:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqW0-000265-Sa
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:24:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xQqVy-0002UN-B0
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:24:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so19554125e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1794335052; x=1794939852; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=km+hBAzvnvfDPCwEyUqAgklvaoh4AgeGGZMYyeks7FA=;
 b=J8jBHPHTnnn9r5J/0DshCnSPIIUg2456bLTNyI+ek2CDvZmRR1njZymbJ36YJOb8NY
 aDeiw6kALP89KrzzP902fTAHAR03U5zpXJCzU3gsO4et0sYhnP1hBYInn7QtD5ZRH4u+
 VrtrrX1pJtQ7hp38vbhonsO3qosSoBH8lRhp24VixYkQyZrp6X0IiOWq0MfSlPeJ/KRm
 QUJkJ48pZi4O6psCw0ZyeEITTr+czX5cPyrhH/tqKD6liY0GSvkJTJkpKsRSjWqLdb07
 7dzj/9ATgL5ld0tvslpS7Vr3MsC6aL81aMojwOa53yMbAEnr9DpRgir/dQsggUoIX32s
 X3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794335052; x=1794939852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=km+hBAzvnvfDPCwEyUqAgklvaoh4AgeGGZMYyeks7FA=;
 b=lIco+73+wN+taIFilXgAjtpKLNklJ+poTdkR7+NuMYpP3SnFITh41NS+D5QnyJee/j
 svQ97JEHANJgKVPYg5rxNESAvsG6O0HLdyM5ppMUhuUB6SHWEq+O15pxh/EQ+YqLipCT
 bhSVPXHfrUVWwgVCMYy32yljxn4WqxdclfIkGMhnUwyfl3Gr87A+j2mzyw4T2Nz3mFvS
 HopdNmwXWKIg0Hg/hVkShLf62vK6PiOICrtSugP1iKfVXLJT8BD0loIAwrRlQEoZVq7i
 6+hh8nPrNiQI9ibsbydbukL7gV+BRFSLo/CXZWcDOqnEbPDT/vjkDu8SsydWmec5QyO2
 ERaw==
X-Gm-Message-State: APuU4Z/g3TBJ5JvjNJcz90PQ7kQamrNFJlbPaw/63OeK5ZDSuJdRM3eE
 5Txo+VgIdezaC8wR+NSwhq2nESrz05WF55v9HxvgrGib5k6CguttdH4JC+2rBS4wk1M/4DIaUty
 m8NnD
X-Gm-Gg: AYBFou24M3eOt2FibPC7/xoP8x6nDoTyRjJGPM9AzYbHSFho8E+EuUQYlpK8+UzAhfp
 3u/zDMyXF//lVboVO+98XDZfrz7NlepABHnpMAWJopnmGM1eSI7KOpnpgPzvjp/1ZsJwiDxp+7e
 SmlNMsG2sNJMZo+n+qarlc6TANZUdxrq6Wf+yWnjAnx14AugJOADepHi6OtoGObpYwDEsQLlndT
 Jo5suyz1ZmhSldbrTeXzvJ7w3rTsmCkFqVPPV0nM15QquwS+jLc1FRXAcW3YtdidlwtS15K0RmI
 PbwUh3aaH/qe/QaH1G34KwsZf0cG0iFnOy0tkphwmq+H8t6mIVFMjnUsLPm0jFoF2IsMpPKToGA
 pg9Gx0YxDr7An3OOexIkjKOEwiCOBHo2+oMzZKtZLUaKlnVyTqmbqdiz6ZnAg16O0z6kg1eUdCn
 FlNG7scAoTBgrxVdvJo9NH0F/6EEZYUJz06OYHX2D1A2U96yVNU8PuJMaKsWqOWaYJ83E7djNsX
 Je4heSlJcNAF19MJ/jgNcBz/n/VWZ5rfC2NWhrwc/50hiRiUH+MC3yWHclli/Nh4al61WeFq6eF
 a8Y/CxlzIhdwlS2ipHelRx0iLA==
X-Received: by 2002:a05:600c:468f:b0:4a3:12fb:1ee7 with SMTP id
 5b1f17b1804b1-4ba0234cd58mr61857645e9.25.1794335051883; 
 Tue, 10 Nov 2026 10:24:11 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:4f78:6441:d0f1:22af])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08e354b0sm2219345e9.1.2026.11.10.10.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:24:11 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org
Subject: [PATCH] migration/block-dirty-bitmap: don't hold the load lock across
 stream reads
Date: Tue, 10 Nov 2026 19:24:08 +0100
Message-ID: <20261110155113.2721134-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=den@openvz.org; helo=mail-wm1-x330.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

dirty_bitmap_load() takes dbm_state.load.lock for each chunk and holds
it while it reads the chunk from the migration stream.

In precopy the load runs in the incoming migration coroutine, which
yields in qemu_fill_buffer() while it waits for data, still holding
the lock. A quit on the destination at that point never completes:
migration_shutdown() calls dirty_bitmap_mig_cancel_incoming(), which
takes the same lock in the same main thread.

In postcopy the load runs in the listen thread, and the main thread
takes the lock in dirty_bitmap_mig_before_vm_start(), called from
loadvm_postcopy_handle_run_bh(), and in migration_shutdown(). The main
loop then waits until the source sends the next chunk.

Read each chunk into a DBMLoadChunk first and take the lock only to
resolve the names and apply the chunk. The lock protects the bitmaps
list and the resolved node and bitmap, which the main thread uses. The
flags and alias strings read from the stream are only touched by the
code doing the load.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: qemu-block@nongnu.org
---
 migration/block-dirty-bitmap.c | 222 +++++++++++++++++++--------------
 1 file changed, 130 insertions(+), 92 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 35623379eb..14e5a984e4 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -796,12 +796,22 @@ static void dirty_bitmap_state_pending(void *opaque, MigPendingData *data,
     data->postcopy_bytes += pending;
 }
 
+/* Chunk payload, read from the stream without holding DBMLoadState.lock */
+typedef struct DBMLoadChunk {
+    uint32_t granularity;
+    uint8_t start_flags;
+    uint64_t first_byte;
+    uint64_t nr_bytes;
+    uint64_t buf_size;
+    uint8_t *buf;
+} DBMLoadChunk;
+
 /* First occurrence of this bitmap. It should be created if doesn't exist */
-static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
+static int dirty_bitmap_load_start(DBMLoadState *s, DBMLoadChunk *c)
 {
     Error *local_err = NULL;
-    uint32_t granularity = qemu_get_be32(f);
-    uint8_t flags = qemu_get_byte(f);
+    uint32_t granularity = c->granularity;
+    uint8_t flags = c->start_flags;
     LoadBitmapState *b;
     bool persistent;
 
@@ -959,7 +969,7 @@ void dirty_bitmap_mig_cancel_incoming(void)
     qemu_mutex_unlock(&s->lock);
 }
 
-static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
+static void dirty_bitmap_load_complete(DBMLoadState *s)
 {
     GSList *item;
     trace_dirty_bitmap_load_complete();
@@ -990,71 +1000,43 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
     }
 }
 
-static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
+static int dirty_bitmap_load_bits(DBMLoadState *s, DBMLoadChunk *c)
 {
-    uint64_t first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
-    uint64_t nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
-    trace_dirty_bitmap_load_bits_enter(first_byte >> BDRV_SECTOR_BITS,
-                                       nr_bytes >> BDRV_SECTOR_BITS);
+    uint64_t needed_size;
+
+    trace_dirty_bitmap_load_bits_enter(c->first_byte >> BDRV_SECTOR_BITS,
+                                       c->nr_bytes >> BDRV_SECTOR_BITS);
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
         trace_dirty_bitmap_load_bits_zeroes();
         if (!s->cancelled) {
-            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, first_byte,
-                                                 nr_bytes, false);
-        }
-    } else {
-        size_t ret;
-        g_autofree uint8_t *buf = NULL;
-        uint64_t buf_size = qemu_get_be64(f);
-        uint64_t needed_size;
-
-        /*
-         * The actual check for buf_size is done a bit later. We can't do it in
-         * cancelled mode as we don't have the bitmap to check the constraints
-         * (so, we allocate a buffer and read prior to the check). On the other
-         * hand, we shouldn't blindly g_malloc the number from the stream.
-         * Actually one chunk should not be larger than CHUNK_SIZE. Let's allow
-         * a bit larger (which means that bitmap migration will fail anyway and
-         * the whole migration will most probably fail soon due to broken
-         * stream).
-         */
-        if (buf_size > 10 * CHUNK_SIZE) {
-            error_report("Bitmap migration stream buffer allocation request "
-                         "is too large");
-            return -EIO;
-        }
-
-        buf = g_malloc(buf_size);
-        ret = qemu_get_buffer(f, buf, buf_size);
-        if (ret != buf_size) {
-            error_report("Failed to read bitmap bits");
-            return -EIO;
-        }
-
-        if (s->cancelled) {
-            return 0;
+            bdrv_dirty_bitmap_deserialize_zeroes(s->bitmap, c->first_byte,
+                                                 c->nr_bytes, false);
         }
+        return 0;
+    }
 
-        needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
-                                                           first_byte,
-                                                           nr_bytes);
-
-        if (needed_size > buf_size ||
-            buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
-             /* Here used same alignment as in send_bitmap_bits */
-        ) {
-            error_report("Migrated bitmap granularity doesn't "
-                         "match the destination bitmap '%s' granularity",
-                         bdrv_dirty_bitmap_name(s->bitmap));
-            cancel_incoming_locked(s);
-            return 0;
-        }
+    if (s->cancelled) {
+        return 0;
+    }
 
-        bdrv_dirty_bitmap_deserialize_part(s->bitmap, buf, first_byte, nr_bytes,
-                                           false);
+    needed_size = bdrv_dirty_bitmap_serialization_size(s->bitmap,
+                                                       c->first_byte,
+                                                       c->nr_bytes);
+
+    if (needed_size > c->buf_size ||
+        c->buf_size > QEMU_ALIGN_UP(needed_size, 4 * sizeof(long))
+         /* Here used same alignment as in send_bitmap_bits */
+    ) {
+        error_report("Migrated bitmap granularity doesn't "
+                     "match the destination bitmap '%s' granularity",
+                     bdrv_dirty_bitmap_name(s->bitmap));
+        cancel_incoming_locked(s);
+        return 0;
     }
 
+    bdrv_dirty_bitmap_deserialize_part(s->bitmap, c->buf, c->first_byte,
+                                       c->nr_bytes, false);
     return 0;
 }
 
@@ -1105,23 +1087,73 @@ static BdrvDirtyBitmap *dirty_bitmap_load_find_bitmap(DBMLoadState *s)
     return NULL;
 }
 
-static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
-                                    GHashTable *alias_map)
+static int dirty_bitmap_read_chunk(QEMUFile *f, DBMLoadState *s,
+                                   DBMLoadChunk *c)
+{
+    s->flags = qemu_get_bitmap_flags(f);
+    trace_dirty_bitmap_load_header(s->flags);
+
+    if ((s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) &&
+        !qemu_get_counted_string(f, s->node_alias)) {
+        error_report("Unable to read node alias string");
+        return -EINVAL;
+    }
+
+    if ((s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) &&
+        !qemu_get_counted_string(f, s->bitmap_alias)) {
+        error_report("Unable to read bitmap alias string");
+        return -EINVAL;
+    }
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        c->granularity = qemu_get_be32(f);
+        c->start_flags = qemu_get_byte(f);
+    } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+        /* no payload */
+    } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+        c->first_byte = qemu_get_be64(f) << BDRV_SECTOR_BITS;
+        c->nr_bytes = (uint64_t)qemu_get_be32(f) << BDRV_SECTOR_BITS;
+
+        if (!(s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES)) {
+            c->buf_size = qemu_get_be64(f);
+
+            /*
+             * The actual check for buf_size is done when the chunk is
+             * applied. We can't do it in cancelled mode as we don't have the
+             * bitmap to check the constraints (so, we allocate a buffer and
+             * read prior to the check). On the other hand, we shouldn't
+             * blindly g_malloc the number from the stream. Actually one chunk
+             * should not be larger than CHUNK_SIZE. Let's allow a bit larger
+             * (which means that bitmap migration will fail anyway and the
+             * whole migration will most probably fail soon due to broken
+             * stream).
+             */
+            if (c->buf_size > 10 * CHUNK_SIZE) {
+                error_report("Bitmap migration stream buffer allocation "
+                             "request is too large");
+                return -EIO;
+            }
+
+            c->buf = g_malloc(c->buf_size);
+            if (qemu_get_buffer(f, c->buf, c->buf_size) != c->buf_size) {
+                error_report("Failed to read bitmap bits");
+                return -EIO;
+            }
+        }
+    }
+
+    return qemu_file_get_error(f);
+}
+
+static void dirty_bitmap_load_header(DBMLoadState *s, GHashTable *alias_map)
 {
     GHashTable *bitmap_alias_map = NULL;
     Error *local_err = NULL;
     bool nothing;
-    s->flags = qemu_get_bitmap_flags(f);
-    trace_dirty_bitmap_load_header(s->flags);
 
     nothing = s->flags == (s->flags & DIRTY_BITMAP_MIG_FLAG_EOS);
 
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_DEVICE_NAME) {
-        if (!qemu_get_counted_string(f, s->node_alias)) {
-            error_report("Unable to read node alias string");
-            return -EINVAL;
-        }
-
         if (!s->cancelled) {
             if (alias_map) {
                 const AliasMapInnerNode *amin;
@@ -1165,11 +1197,6 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
     if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
         const char *bitmap_name;
 
-        if (!qemu_get_counted_string(f, s->bitmap_alias)) {
-            error_report("Unable to read bitmap alias string");
-            return -EINVAL;
-        }
-
         bitmap_name = s->bitmap_alias;
         if (!s->cancelled && bitmap_alias_map) {
             BitmapMigrationBitmapAlias *bmap_inner;
@@ -1206,7 +1233,23 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
         error_report("Error: block device name is not set");
         cancel_incoming_locked(s);
     }
+}
 
+static int dirty_bitmap_apply_chunk(DBMLoadState *s, DBMLoadChunk *c,
+                                    GHashTable *alias_map)
+{
+    dirty_bitmap_load_header(s, alias_map);
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return dirty_bitmap_load_start(s, c);
+    }
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
+        dirty_bitmap_load_complete(s);
+        return 0;
+    }
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
+        return dirty_bitmap_load_bits(s, c);
+    }
     return 0;
 }
 
@@ -1240,28 +1283,23 @@ static int dirty_bitmap_load(QEMUFile *f, void *opaque, int version_id)
     }
 
     do {
-        QEMU_LOCK_GUARD(&s->lock);
-
-        ret = dirty_bitmap_load_header(f, s, alias_map);
-        if (ret < 0) {
-            cancel_incoming_locked(s);
-            goto fail;
-        }
-
-        if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
-            ret = dirty_bitmap_load_start(f, s);
-        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_COMPLETE) {
-            dirty_bitmap_load_complete(f, s);
-        } else if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITS) {
-            ret = dirty_bitmap_load_bits(f, s);
-        }
+        DBMLoadChunk c = {};
 
-        if (!ret) {
-            ret = qemu_file_get_error(f);
+        /*
+         * dirty_bitmap_mig_before_vm_start() takes the lock from the main
+         * thread, so never hold it while waiting for the stream.
+         */
+        ret = dirty_bitmap_read_chunk(f, s, &c);
+        WITH_QEMU_LOCK_GUARD(&s->lock) {
+            if (!ret) {
+                ret = dirty_bitmap_apply_chunk(s, &c, alias_map);
+            }
+            if (ret) {
+                cancel_incoming_locked(s);
+            }
         }
-
+        g_free(c.buf);
         if (ret) {
-            cancel_incoming_locked(s);
             goto fail;
         }
     } while (!(s->flags & DIRTY_BITMAP_MIG_FLAG_EOS));

base-commit: 723622bedb0b423de7d1c61ebbe6e7a71934949c
-- 
2.53.0


