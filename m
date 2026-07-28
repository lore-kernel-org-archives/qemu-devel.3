Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0C1C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtU-0003XU-Jr; Tue, 28 Jul 2026 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtS-0003Vv-RM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtP-0002gZ-SR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so36630885e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253134; x=1785857934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YJaoJvgzXUZ8yMjiVjFNLoDIXX0M+tiKgbemBDHpStA=;
 b=tLLZfon7B7o79PqiRu19RaD3yHMV+GYsg7yxoQ0T67am8Ee5EgQGo4BctK5yAcpHg4
 qMzB+TN72hLv606LcjZbCMJ2/QeFCLpQbDDAv6kUygD9/mW5Nav4NR2rfD3b/Fs5RsoO
 ny9b4w82Hqj7ASQoMjKzkTFfnEQtfe+0kfKgvObKpOQzExh9fdhcUiWTNTEVSIjOxi1c
 5Btsy/iQiGfEMAvXLiaaRUcmwIIiDQd/f13iUfmVMW9jL7aYkXTiZwyCrju14CmbDMeH
 0nDqCLRhOcwiGCO1A/mclJ9r9iVgs5bIUOW1tkOX2NnqgP0YAprJYJ1CP68MPrDSPi+P
 UJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253134; x=1785857934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YJaoJvgzXUZ8yMjiVjFNLoDIXX0M+tiKgbemBDHpStA=;
 b=BKhdVmXEPZF46kYyvp4mX10LQ9fdor8FyThTA2olxOHkvQxcqjVK64pTvMMkdC4sh8
 v6XmzUUNHjNsiONUzevcSXenh75jN4yTywPc9wXS+q1xj+sT42Wg980UELj3jsRdUSWz
 LunWzuRQPQyhPl4qb279Wws0euh2T6wUa/qJOqr9XnqhISGM7XkFniakGYHe8JRidhvA
 pNznwNfFrJ0Lxk1/ZrQJNhF3Xs6bG6JopPOxjSwDdLveT4RdP9raugsZu1/FSuibYgiX
 2ZXWJNmJPJglTHN4slVGR/TjFyD7BdndWEny7bq/2ugvE4FAB59g5px5HHihME5gksAy
 4+WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Roc8Zl2ChhfGmzgii166Q5l3NmQNcG+amp/v8phPhe4lqCOQLIQEDToVjyckyb4CXDNAP1AOunz4Qrj@nongnu.org
X-Gm-Message-State: AOJu0Yyl5sBCllvw9uMiDiTmJUjwWKO+XYb3YrJONf6spYGXOUpsHfTl
 iAUG9qGl5RE814xhm3TzslDkgeNFdtlWER0k8eyUQyE8raNRYYl3Xd681VC5SKLL5Io=
X-Gm-Gg: AR+sD11T8XWy/TPQFLFyZN7mjGTHCnwm8des+6t7jFkxfncxrumDUxNx4HrVsNIyuvH
 xo3VYg5+K0pSxxq1JBTXvyJQIQo4K0rwgsCFfg87vLC1/nsktz4CxHLSBElLXBVQJJhKYZWa4/H
 AtmdgRRMpSjx/nGQPUfTxMuQVChXti4R4nzRdEvjTXxU8X/B8f4tQ+9Z7f/yjpxmqflO5NO6PGc
 PcKl87T9DWibnY9j9bXf8q/YF/8x67X7LCQ1QzrvOoC7Zpi3rdfcZ9rcIXzgepXu1vDDbhODiKz
 6Bv7ke/WTCOrQ7AJEOvcXtyfMr8SfwGHGtkU8y8V5o/5e4invhdfVUdr06OxeN/LzYWCPYqfXrT
 eqI8ZABbhIhgHK8CrZTQVP6RJGSo1lRFhM6f4huutm1n4uRrlh3IvMkCNsn6/AoFoGYX2uTAjXw
 ==
X-Received: by 2002:a05:600c:c8d:b0:493:e57e:7aa5 with SMTP id
 5b1f17b1804b1-496c657cdbemr31123585e9.22.1785253134209; 
 Tue, 28 Jul 2026 08:38:54 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:53 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 2/9] parallels: read header/BAT table in bounded chunks
Date: Tue, 28 Jul 2026 17:38:42 +0200
Message-ID: <20260728153849.601939-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=den@openvz.org; helo=mail-wm1-x329.google.com
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
 tests/qemu-iotests/tests/parallels-checks.out | 11 +++++++++
 3 files changed, 47 insertions(+), 4 deletions(-)

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
index b281246a42..9535024885 100755
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
+_img_info
+
+echo "== an unallocated cluster still reads as zeroes =="
+{ $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index 9793423111..6fb2014e8e 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -129,4 +129,15 @@ No errors were found on the image.
 == check first cluster ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST HUGE BAT TABLE OPEN ==
+== advertise a BAT table larger than BDRV_REQUEST_MAX_BYTES ==
+== grow the file to match, without writing real data ==
+== open must succeed: the header/BAT read is chunked ==
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 4 MiB (4194304 bytes)
+== an unallocated cluster still reads as zeroes ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.53.0


