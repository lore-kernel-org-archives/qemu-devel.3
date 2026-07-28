Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A315C54EFC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGa-00086p-L4; Tue, 28 Jul 2026 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGY-00085B-FM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:30 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGW-0008Gf-Hq
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:30 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso593249666b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235347; x=1785840147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bm+t6tVWssOS3Bc74G2+tUbVOT2wab5L0F6cKOp1Il0=;
 b=YHQn9TV9Lj3uVLkdiE/jMSRw5DJ4oOWjO3sjepj44PtcUhG9dvIO5uqUeZ40dVYNwy
 LUj35iRUT9Gv/VWC97oVAqC8JlVTOoMsmlHC2vbROakoozvyLj59vpVyTGY6zlYFCN2J
 IBMLn955LhF0DpjRC9t3HQPJNcffIuC9PWtuGKDJvXMEwGKt+U2Cpea8fJzi0wNiFwa1
 0saPJ2rUKHLcQAL+7PHxaWxivZ3hfYZJwo5DuLyU1brFKF9vX1xboFhPWgq10/TmsRAn
 67kRalYgi3JWnjTZMaXOUxga1ysoZRXsBGdLPHk3/XPRqnxFfZYbt2RltgJUecf47Mi7
 MbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235347; x=1785840147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bm+t6tVWssOS3Bc74G2+tUbVOT2wab5L0F6cKOp1Il0=;
 b=Wv9mFAl9rhqdjwKOJOaOL9xGVXToKHHdrapp2qbQDBm27ET6NA+gcbB3gTvAybB4OG
 IU8fP/uM6bl2zNktD0okXWghr0rol+Q24lQ9XJqtucYaeE3OVPc1yMatWYiAW7FhE2PE
 niLq+kjBZaqZYnA32kEi7Hf2/mty0/389fcZJATWU1ctthYoth9IFUGViu1tniS4RWnQ
 U/eWLeipBldoLnrpzturF3e/cZdNzSK8YJpeowoG9gcdcaMQANXOQZJw+YB63Q/aylaO
 jvSoU0x7KxyO7NG4d/ipgwTSEHnFlOllsArQyLePuKyRgC1nTwolOTyJyBhJ1ksi8HxI
 aKbg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9rp13q82MSOrowEpmnnymYTsuj1GNpRc3bkl6YaFshT87wcjr52FkbexGjXUBPd6xAt6y1fNW+RYY@nongnu.org
X-Gm-Message-State: AOJu0YzUE2muJUcyFBKZx4O04R9XDfuhgO2/sTaWPpM8CznPwa2Y8GEv
 +tM+tkBXZr4YuNsm1dZrf1uJXL09AHwnLzKJqrmUjYSsXEOKTZqoRhZMKtAbHh93qVY=
X-Gm-Gg: AR+sD11DPTu886DPhUwHD8UzZuYif9l4GQ9crASzqhQa4jQ43BKMM0d8yqZBGaL3eKE
 9MmsWe7isKELreZdsuJyL22TQW4sAP20PHuVY90wmAtyvLQH4auL1mo6zINik4gURQyULFFi53O
 g7c1uCU0sVSifaPvPi+6WkUGCNggBe7lYt/A+xip3+M81U8fU5AUOZRBpioGDbeXm/jnpTWdJF2
 8fWRyUiWdroRDpFOzr7DwODwVXDNIxJGz5ar+o7vWKf1B4Pq2I6HGtBtkEyCGjoSGmEJm5NJ6Yk
 CVgmic5fVjJdj2lXT+A9K2tL38vpvVInkFsgDakVtPI8rL85FfqNQcgSkwkV5PylETlXbm+ihzn
 Lr4SI7+5BxVOQBrlQ7fT0v53CnOr3fWMpN8WtM7FfhJN4NHYoi8E0nLEtyPiQHy3BZg==
X-Received: by 2002:a17:907:1c93:b0:c16:5855:65a3 with SMTP id
 a640c23a62f3a-c1f71d2c871mr84993666b.7.1785235346794; 
 Tue, 28 Jul 2026 03:42:26 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:26 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/9] parallels: read header/BAT table in bounded chunks
Date: Tue, 28 Jul 2026 12:42:14 +0200
Message-ID: <20260728104221.3981592-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
References: <20260728104221.3981592-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=den@openvz.org; helo=mail-ej1-x634.google.com
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


