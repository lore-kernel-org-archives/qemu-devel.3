Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE320C5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2aX-0007X7-RS; Mon, 17 Aug 2026 15:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z8-0006Bq-4r
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1ww2Z0-0006Pu-3C
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:00:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso18569295e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786993199; x=1787597999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KKueZu+GFSkWyU7T0dX3d7sLIihGkdnqnU65zduwsLQ=;
 b=Wz0ldQH8bQ++RnVvTYzBnbPheS81rserfTn9YikkFKeEYVBKDbHpEmUE2joIe/kPmj
 oPJsiD7n98RAoAWWCrY81eqW1T4/f2vrSdhR6hvlcrtKrSCRHCqJ7VZNHv9lf1DlPvT4
 2LUKkVrZlp5KHHGmOQFgDAzVpMq4zb0y5X1i5oil7swemu+d+00BGjBivbsvP2EGwqHM
 SsTaZqK/dJOMoEd8dR9/4IcOSTNmRIWWIIeLpeeO/cG4QaX6W8pG6q3eeu7xEwrBsI1d
 BqDbGPUrCVvm81wfoUWodAVoHxYghZWnMumkGu8b9pkfqIsTDM+GOL3JY56l7hsb/nSc
 xgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786993199; x=1787597999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KKueZu+GFSkWyU7T0dX3d7sLIihGkdnqnU65zduwsLQ=;
 b=PQECSSuPKF7oa2ZEEGKKLvtHKlMPyadh4dIcBaXsl95CrTLnut4JKszSss8jyYgezI
 KJgYXXlg5pBq8kiwuk9QzVTVUY6VDS8WDXI2ElxwhAGzB3vyb/FzFg/5eJhhVDfdSNrJ
 57lAphHMaRaknbj7Z62EVjebC/7Bubk3GDBuLhnT9Emoz3rs58OzX3dMUtLjIr1Pkhre
 KdSxgsKAzJe71Vlhx3GQ7JCfFxg7/331uig5/Bj5nj5+SrRbOxs+cxGMlL1jFze2Ls31
 PIDgjFy6QCtCEzxGh487otm62KjzoSan8VXr3lI2HSWKEfBXgmgXE2lQO0l4ojsA2jh7
 E2gA==
X-Gm-Message-State: AOJu0Yy+C+XiWObMd8wFonEJiJkQEYx8hDleXlItiwwXHuOmfb4WZpQL
 PDiAhDu8tw28hYn6eZvDF6g1JuJ/M5q+WG/l/uOtmCGPUYcVHhFsRehluIf6GjYX9zNJfINOvcj
 kwoZF
X-Gm-Gg: AR+sD1332rklbPGcpsVxgGFpdxHRzWh6jhKbko5LGt1U10riVU4M931v2jjHkDR28FB
 lCsv/CqW8uI4Um5CkkFjtrzyVgiZJop3WDzlA2p1zwxTvGV5tP/d4CS1ew/wyDc5g1XEn5YIbV0
 Uiq25HaVDggmKSN5BFXJhWU17qejsiY7ZZ9uq8kN0GSxjA8D9s9iwGEA1hBuT0/nZkrNne+Rf5q
 mH54uxx8XfzVhPbu3HOVkaFus/8pUgwJPT/qgKGplS/OTUlc7qhxbFygcg8rDb7QtIaJbAgr1se
 QPUIDC0kHj659PjZh1oOdTtQCG9A7qchwcajRjINLkzjryO8e1Xz8oD9SMdLhP7+taaK4aST4XK
 xYOg3QaScAd2+fMSVzHrKGYBy8G99ULr7xqguLqjbFpj5OmIgke6lwWNH4yYRD8G6872g9Y+kA9
 Ybunv1VhykZKKgG9gC8OK6mPyDs0UIfApITJ5wlvmCVT1IxSN3jSXN63lWuB4W
X-Received: by 2002:a05:600c:1389:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-4999fa88216mr37334025e9.0.1786993199194; 
 Mon, 17 Aug 2026 11:59:59 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:f6f8:884c:b162:eaeb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996188217sm381011085e9.13.2026.08.17.11.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 11:59:58 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v6 12/25] parallels: Let image extensions work in RW mode
Date: Mon, 17 Aug 2026 20:59:29 +0200
Message-ID: <20260817185942.1065143-13-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817185942.1065143-1-den@openvz.org>
References: <20260817185942.1065143-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Saving extensions is supported now, so we can let them work in
read-write mode as well.

The bounds check rejecting a Format Extension outside the image file
used to sit in the read-only branch of the condition. Perform it
unconditionally, as the extension is now read in both modes.

A loaded bitmap was marked read-only unconditionally, guarded by an
assert that the image is not writable. Mark it so for a read-only node
only, as qcow2_load_dirty_bitmaps() does, or the next inactivation
fails with "No write access". The condition is read-only alone rather
than the full write access qcow2 asks about, as an inactive node can
become writable later and parallels has no path which would clear the
flag again. Mark the bitmap persistent as well, or it disappears from
the image the first time it is written out.

An unreadable extension must not keep the image shut. Its clusters are
deliberately left free for reuse, so a guest write may have landed on
them, and every qemu up to this one ignores the extension in read-write
mode and truncates the file to the end of the payload on close, leaving
ext_off pointing past the end of the file. Both refuse an image whose
payload is perfectly fine, in either mode, with no way back through
qemu-img check or convert. So do not ask the in use flag, ask whether
what the header points at is an extension at all: an offset outside the
file, a wrong magic or a wrong checksum all say that it is not, whoever
left it behind, so drop it with a warning and forget where it ended,
which lets the leak check reclaim the space.

Behind the checksum the extension says what its writer meant it to say,
so a feature this driver does not implement, or a bitmap it can not
parse, keeps the image shut as before. Only an image which was not
closed correctly gives up its extension there, as its bitmaps predate
every write which followed the last inactivation.

Reading a bitmap allocates a cluster sized buffer with the aborting
qemu_blockalign(), and parallels_open() lets a cluster reach almost
2 GiB. That is reachable through every open now, so allocate it the way
the storing side does and align it to bs->file.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c                         | 24 ++++++++-----
 block/parallels.c                             | 35 +++++++++++--------
 .../qemu-iotests/tests/parallels-read-bitmap  | 18 ++++++++--
 .../tests/parallels-read-bitmap.out           | 12 +++++--
 4 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index a0e2be395f..e89c489730 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -74,7 +74,11 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     uint8_t *buf = NULL;
     uint64_t i;
 
-    buf = qemu_blockalign(bs, s->cluster_size);
+    buf = qemu_try_blockalign(bs->file->bs, s->cluster_size);
+    if (!buf) {
+        error_setg(errp, "Failed to allocate a bitmap data cluster");
+        return -ENOMEM;
+    }
     limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
     for (i = 0, offset = 0; i < l1_size; ++i, offset += limit) {
         uint64_t count, entry;
@@ -210,9 +214,9 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         }
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
+    if (!(bs->open_flags & BDRV_O_RDWR)) {
+        bdrv_dirty_bitmap_set_readonly(bitmap, true);
+    }
 
     return bitmap;
 
@@ -226,7 +230,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
                                  Error **errp)
 {
     BDRVParallelsState *s = bs->opaque;
-    int ret;
+    int ret = -EINVAL;
     int remaining = s->cluster_size;
     uint8_t *pos = ext_cluster;
     ParallelsFormatExtensionHeader eh;
@@ -243,12 +247,12 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
         error_setg(errp, "Wrong parallels Format Extension magic: 0x%" PRIx64
                    ", expected: 0x%llx", eh.magic,
                    PARALLELS_FORMAT_EXTENSION_MAGIC);
+        ret = -ENOENT;
         goto fail;
     }
 
-    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALGO_MD5, (char *)pos, remaining,
-                             &hash, &hash_len, errp);
-    if (ret < 0) {
+    if (qcrypto_hash_bytes(QCRYPTO_HASH_ALGO_MD5, (char *)pos, remaining,
+                           &hash, &hash_len, errp) < 0) {
         goto fail;
     }
 
@@ -256,6 +260,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
         memcmp(hash, eh.check_sum, sizeof(eh.check_sum)) != 0) {
         error_setg(errp, "Wrong checksum in Format Extension header. Format "
                    "extension is corrupted.");
+        ret = -ENOENT;
         goto fail;
     }
 
@@ -301,6 +306,7 @@ parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
             if (!bitmap) {
                 goto fail;
             }
+            bdrv_dirty_bitmap_set_persistence(bitmap, true);
             bitmaps = g_slist_append(bitmaps, bitmap);
             break;
 
@@ -319,7 +325,7 @@ fail:
     }
     g_slist_free(bitmaps);
 
-    return -EINVAL;
+    return ret;
 }
 
 int parallels_read_format_extension(BlockDriverState *bs,
diff --git a/block/parallels.c b/block/parallels.c
index a9464d5352..90b7f7c8de 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1454,25 +1454,30 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     if (ph.ext_off) {
         int64_t ext_off = le64_to_cpu(ph.ext_off);
+        Error *ext_err = NULL;
 
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else if (ext_off + s->tracks > file_nb_sectors) {
-            error_setg(errp, "Invalid image: Format Extension is outside the "
-                       "image file");
-            ret = -EINVAL;
-            goto fail;
+        if (ext_off + s->tracks > file_nb_sectors) {
+            ret = -ENOENT;
+            error_setg(&ext_err, "Format Extension is outside the image file");
         } else {
-            ret = parallels_read_format_extension(
-                    bs, ext_off << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
+            ret = parallels_read_format_extension(bs,
+                                                  ext_off << BDRV_SECTOR_BITS,
+                                                  &ext_err);
+        }
+        if (ret == -ENOENT) {
+            s->ext_end = 0;
+            warn_reportf_err(ext_err, "Dropping the Format Extension of node "
+                             "'%s', which does not look like one: ",
+                             bdrv_get_device_or_node_name(bs));
+        } else if (ret < 0) {
+            if (!s->header_unclean) {
+                error_propagate(errp, ext_err);
                 goto fail;
             }
+            s->ext_end = 0;
+            warn_reportf_err(ext_err, "Dropping the Format Extension of node "
+                             "'%s', which was not closed correctly: ",
+                             bdrv_get_device_or_node_name(bs));
         }
     }
 
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-read-bitmap
index 5cbef25018..c9652fcf3a 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap
@@ -121,8 +121,16 @@ def report(name):
         log(f'qemu-img died with signal {-exc.returncode}')
         return
 
-    log('image opened' if res.returncode == 0
-        else iotests.filter_testfiles(res.stdout).strip())
+    out = iotests.filter_generated_node_ids(
+        iotests.filter_testfiles(res.stdout))
+    if res.returncode != 0:
+        log(out.strip())
+        return
+
+    log('image opened')
+    for line in out.splitlines():
+        if 'warning' in line:
+            log(line.strip())
 
 
 def check(name, ext, tracks=1):
@@ -148,6 +156,12 @@ check('wrong extension magic',
 check('wrong extension checksum',
       extension(feature(0, 0), checksum=False))
 
+# An older qemu truncates the extension cluster away on close.
+with open(crafted, 'wb') as f:
+    f.write(parallels_header(1, SECTORS, SECTORS, EXT_SECTOR))
+    f.truncate(EXT_SECTOR * 512)
+report('extension cut off the end of the file')
+
 check('unknown feature', extension(feature(BITMAP_MAGIC ^ 1, 0)))
 
 check('feature flags set', extension(feature(0, 0, flags=1)))
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-read-bitmap.out
index 3b3f90c8de..13b10af5a4 100644
--- a/tests/qemu-iotests/tests/parallels-read-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap.out
@@ -8,9 +8,14 @@ Kill NBD server
 --- well-formed extension
 image opened
 --- wrong extension magic
-qemu-img: Could not open 'TEST_DIR/PID-crafted': Wrong parallels Format Extension magic: 0xab234cef23dcea86, expected: 0xab234cef23dcea87
+image opened
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0xab234cef23dcea86, expected: 0xab234cef23dcea87
 --- wrong extension checksum
-qemu-img: Could not open 'TEST_DIR/PID-crafted': Wrong checksum in Format Extension header. Format extension is corrupted.
+image opened
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong checksum in Format Extension header. Format extension is corrupted.
+--- extension cut off the end of the file
+image opened
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Format Extension is outside the image file
 --- unknown feature
 qemu-img: Could not open 'TEST_DIR/PID-crafted': Unknown feature: 0x20385fae252cb34b
 --- feature flags set
@@ -30,7 +35,8 @@ qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 4294
 --- bitmap L1 entry overflows
 qemu-img: Could not open 'TEST_DIR/PID-crafted': Failed to read bitmap data cluster: Input/output error
 --- cluster_size beyond the file size
-qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid image: Format Extension is outside the image file
+image opened
+qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Format Extension is outside the image file
 --- bitmap serialization coverage overflow
 image opened
 --- bitmap spanning two L1 entries
-- 
2.53.0


