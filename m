Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1601C44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaO4-0005CO-Nu; Wed, 22 Jul 2026 13:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO1-00059T-8z
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaNz-0001YW-A1
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:37 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49557167508so43953285e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739934; x=1785344734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bm+t6tVWssOS3Bc74G2+tUbVOT2wab5L0F6cKOp1Il0=;
 b=ob+iSTUMjmw4TR47itrNyaHz93k4tn/y9tYXHJkuUTOZ7mYawAL68dWYjBEx0YyMEc
 ePhpI1TNM3Kk88YMuPMlicx5t6XX6PvuZujdAdzn/dmRqLzh4wGBV48gE7RtRlp++4e5
 AarSzCvbdAmN2AEFbAPNh2WJkKEmX/tJrA+bhhNm+dfQUlsjBl9IAqjRmpsJa1XyMwBl
 BBf7C6R3juWjiTEc34zrEpFBWgoIu4zlI8/0wMyy15Znl9tLqtOIT04QxrCZXitPIUbQ
 gmTPs2u+M4riNX1HTCKjg3kmV36SrF+K/J1hxX80XRkL5QVirUFeAtnXqSc9DgDiWuPH
 ZURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739934; x=1785344734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bm+t6tVWssOS3Bc74G2+tUbVOT2wab5L0F6cKOp1Il0=;
 b=KEIHrb4z/vM+tp0WKmrU4HGaGdHKqRXCys6TxBKrZ/hYFEB28Tx/6U4Q7xks+96EwQ
 XLVwD8Si0tK/L+8/+bFZ5RtbQmZnhkbM/Eir0nGTV7FNZbMlIsLKk7fp+hYieHiDdZrk
 cDSa3LwabtgFFwd8Xn6fRPELYIo6q1Ear4qNejlxylbr226OihhK9RUohtgY9/gh8Wm9
 OGGfttFwqa3SMs2U0LUx3lYu5eLYpn5qrqYi1Apu1mtbKk+hdg5U63Igp9Pq2TF7JajY
 39dSbO3AhzTV8I/YvBR8VZfMw7rvkENkkE4dfIyjCqPFnrsfweXTmMd1upFOcHvaAjDK
 +B2A==
X-Gm-Message-State: AOJu0YzA4cp02ix3md6IjbYzKdyhBVs0GD9eYp6/is3mGJGxqMQ6y+nz
 TnnmAhtV5mFYtUseOdURhDkh+Uqq2IVh/Mw6Zxjl79XCf3heTvMKTlbDLyOYlO8vBf7pM0YpFRx
 35ACz
X-Gm-Gg: AR+sD11bxpVYOpVnkrl851uSxgigKLgY5FxW9usm+5WdAH5II+5+1aR7t5fU389qg4u
 CZwMGOKcIlEW4DcVsKjCkueMMGagTY6oVPdXRVKEBAjJ9PUQUxoETgthQsXfMWFZOn6w29S/LyR
 y+YT95BQ5hNlUEVBP1KrxN82WucdE56jOxHI24t58XasVpwVp5axnuAIYELSQJt29ABggaKyl4Z
 SSkpig6wCW5WIDlt5MKRmfflK8P+WR/w5A8PjvSJBKD730VonTqLeWJULt0G/nJn3bCPQt3wxbs
 2JqrCnNWnjdU/MYbh/Uq/hGlk3LGugcU0nkv3/PyiJ7AICZSB12SUlzyREILeYtzinfvui5eYS8
 UybWZOyLqHK6Txcg6VGts2tWH3ltHtbAYAt9EJ2uNXMZeUHappJPJ2sqi4fpq9UicuM+7gRtyX4
 A=
X-Received: by 2002:a05:600c:42c6:b0:495:4182:4456 with SMTP id
 5b1f17b1804b1-4954a4104e1mr171163275e9.29.1784739933607; 
 Wed, 22 Jul 2026 10:05:33 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/9] parallels: read header/BAT table in bounded chunks
Date: Wed, 22 Jul 2026 19:05:20 +0200
Message-ID: <20260722170527.2593225-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
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

parallels_open() read the whole header+BAT table with a single
bdrv_pread() call sized s->header_size. For an image whose catalog
approaches the "Catalog too large" bound (INT_MAX / sizeof(uint32_t)
entries), that size approaches BDRV_REQUEST_MAX_BYTES, and the block
layer legitimately refuses a single request that large, so the image
failed to open with a generic I/O error even though the catalog size
itself is within the format's documented limit.

Read the header and BAT table in fixed-size chunks instead, so the
maximum catalog size parallels_open() can actually address matches
the bound it already enforces, independent of the file's block-layer
alignment requirements.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c                             | 17 ++++++++++----
 tests/qemu-iotests/tests/parallels-checks     | 23 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 17 ++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 59f00c64a6..0f655b58d5 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -52,6 +52,7 @@
 #define HEADER_VERSION 2
 #define HEADER_INUSE_MAGIC  (0x746F6E59)
 #define MAX_PARALLELS_IMAGE_FACTOR (1ull << 32)
+#define PARALLELS_HEADER_READ_CHUNK (64 * 1024 * 1024)
 
 static QEnumLookup prealloc_mode_lookup = {
     .array = (const char *const[]) {
@@ -1241,7 +1242,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, i;
-    uint32_t size;
+    uint32_t size, header_off;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
     bool need_check = false;
@@ -1311,9 +1312,17 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return -ENOMEM;
     }
 
-    ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
-    if (ret < 0) {
-        goto fail;
+    /* A single request s->header_size large exceeds BDRV_REQUEST_MAX_BYTES. */
+    for (header_off = 0; header_off < s->header_size;
+         header_off += PARALLELS_HEADER_READ_CHUNK) {
+        uint32_t chunk = MIN(s->header_size - header_off,
+                             PARALLELS_HEADER_READ_CHUNK);
+
+        ret = bdrv_pread(bs->file, header_off, chunk,
+                         (uint8_t *)s->header + header_off, 0);
+        if (ret < 0) {
+            goto fail;
+        }
     }
     s->bat_bitmap = (uint32_t *)(s->header + 1);
 
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index b281246a42..8087b03fb9 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -44,6 +44,7 @@ _supported_os Linux
 SIZE=$((4 * 1024 * 1024))
 IMGFMT=parallels
 CLUSTER_SIZE_OFFSET=28
+BAT_ENTRIES_OFFSET=32
 DATA_OFF_OFFSET=48
 BAT_OFFSET=64
 
@@ -199,6 +200,28 @@ _check_test_img -r all
 echo "== check first cluster =="
 { $QEMU_IO -r -c "read -P 0x55 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST HUGE BAT TABLE OPEN =="
+
+# Overflows a single read request, but stays under parallels_open()'s
+# own catalog-size cap.
+BAT_ENTRIES=536870896
+HEADER_SIZE=$((64 + 4 * BAT_ENTRIES))
+
+echo "== advertise a BAT table larger than BDRV_REQUEST_MAX_BYTES =="
+poke_file "$TEST_IMG" "$BAT_ENTRIES_OFFSET" "\xf0\xff\xff\x1f"
+
+echo "== grow the file to match, without writing real data =="
+truncate -s $HEADER_SIZE "$TEST_IMG"
+
+echo "== open must succeed: the header/BAT read is chunked =="
+{ $QEMU_IMG info "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== an unallocated cluster still reads as zeroes =="
+{ $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 9793423111..b47c42cf4d 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -129,4 +129,21 @@ No errors were found on the image.
 == check first cluster ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST HUGE BAT TABLE OPEN ==
+== advertise a BAT table larger than BDRV_REQUEST_MAX_BYTES ==
+== grow the file to match, without writing real data ==
+== open must succeed: the header/BAT read is chunked ==
+image: TEST_DIR/t.parallels
+file format: parallels
+virtual size: 4 MiB (4194304 bytes)
+disk size: 1 MiB
+Child node '/file':
+    filename: TEST_DIR/t.parallels
+    protocol type: file
+    file length: 2 GiB (2147483648 bytes)
+    disk size: 1 MiB
+== an unallocated cluster still reads as zeroes ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.53.0


