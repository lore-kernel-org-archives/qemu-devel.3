Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962A3C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaO8-0005DR-9k; Wed, 22 Jul 2026 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO3-0005B0-Kr
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO1-0001ZI-8j
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso23063065e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739936; x=1785344736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BhGcypSN9c7MXiKGLST/q5b00sWwo654rqpJZ/LWYcg=;
 b=kBwy9BK/7VAsmJH2z7ZMCzCLt69muBdgK2+SgOmEL8FFgjt8PFENGNKoSCOgl97LSs
 +bPCUUBYoTiw5k+hZk3y96uq6vpVFJANqNdDrwjvl8pOyq3e0aOCiSZWwalf+CRAoDDK
 cisQjDJxhiqclEDLUeaUcxGYYUQM6QjESe7kGtjyo68WQHdbut5PwOG5yhy39Il3iT6s
 J6iWprhpSmqcapGju4TVegLEpKW1qf6aM1XS9WP4T/wsN5VuXCXPUXAdYqJix/OInQUj
 CGbsBqkWOm/ysChUCycuSGIC8wo/Ge3sKkI8jI00Qb6PxreGsAc07rpfgrW9xOS7HQgc
 8z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739936; x=1785344736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BhGcypSN9c7MXiKGLST/q5b00sWwo654rqpJZ/LWYcg=;
 b=MfOpZIjol7Nbjlhefnd9NO+Cjmiq4lFNdHoKSvEWacv6lsTAwB7MwX8TcNFofqYM2S
 gsPalQ3vosMgSok0q8WLXG+jy/DEWQoOTP6EY72kT2EjqKA3dF2ZIOV+y4Kk+HFul1hX
 vSLmrOB5osZ1Ck60FEnXSx5/ML8dzXFaClf2yGoRHcnrth8CynfppmZ2dAwCywAIFInT
 PSr0jaIfRCQZ7bZ7g5z3NBXoNRfxdafnVe+NhNftNIxt2qcL/STilGs6w+H2dSE6HVV9
 Rxpdglwj7VvtvUI+FVaIGHi28Z7u0Ee6noA1IiQBqiceh3+UJmpKdvzUxchiryCTEN+q
 QFzg==
X-Gm-Message-State: AOJu0YxBmbQayq45ccaPeaPQuMM1HAUTOwucPQZu1DcjNUYALepvrErY
 aqnjhPp/SbGZ/UD50cSOhSHv8pqDSwx9ytGmauyclVUiDHm5NtDQ7f8SeRShbirXUFgnlrT+hmD
 ZQBLT
X-Gm-Gg: AR+sD118TJZToVp/4tJzS6I2lLUbcUxiUcYkSZNu37iN51dw+SYvfarWMNX/8mqIgGJ
 rs0en+d41vJioYFBIDqKvr0woBvIU4vBZvf5D8uMmzlU+bYL2sjEyL7YkFuXqICf/2mwD6QAQKu
 +sHpKoMGZWi7467ddbhHB6k9u2QiOU87gWoBOVMb6bV9UUb3mDWLzbN8Tw9fsK7mDPNEuvCZuY6
 x8H+Lx1P3jFD863OnAZ+4y/ANVkuX4qXx74PU8rKt6wHGaEZDYL745iK5UnP0cwCKSKyBS9cIrK
 mqbW5/snjPTfIkNFvf5utEZn9Qm797mjuul2fAV+3VYhfF6gIM9x3HZ5YY8YhHGG7EvEkH6VVsg
 ioPrYX8wep636T6xBHnCjMhqbZQS7mZrLlh/UCPBQ3jXDbnhK2SePpje7W+hpimiI7RijGU6RRr
 D2FgAKHhovsA==
X-Received: by 2002:a05:600c:4687:b0:495:3a52:71b1 with SMTP id
 5b1f17b1804b1-4956a4ef4e2mr56959605e9.5.1784739935705; 
 Wed, 22 Jul 2026 10:05:35 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:35 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 4/9] parallels: reject BAT entries pointing outside backed
 storage
Date: Wed, 22 Jul 2026 19:05:22 +0200
Message-ID: <20260722170527.2593225-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

parallels_open()'s BAT scan and parallels_check_outside_image() only
checked entries against the file's upper end, matching just half of
what docs/interop/parallels.rst requires: an entry's offset must be
both >= data_start and < the file size. An entry below data_start
resolves into the header/BAT region itself, corrupting metadata on
write or losing the write silently on a partial overlap, and neither
qemu-img check nor the open-time scan ever caught it.

Check both bounds everywhere a BAT entry is resolved to a host
offset: seek_to_sector(), the open-time scan (without letting a bad
entry inflate data_end), and parallels_check_outside_image().

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c                             | 27 +++++++--
 tests/qemu-iotests/tests/parallels-checks     | 58 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out | 35 +++++++++++
 3 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index e3d26a6650..8a7e8b4aba 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -119,6 +119,7 @@ static uint32_t bat_entry_off(uint32_t idx)
 static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
 {
     uint32_t index, offset;
+    int64_t cluster_off;
 
     index = sector_num / s->tracks;
     offset = sector_num % s->tracks;
@@ -127,7 +128,14 @@ static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
     if ((index >= s->bat_size) || (s->bat_bitmap[index] == 0)) {
         return -1;
     }
-    return bat2sect(s, index) + offset;
+
+    cluster_off = bat2sect(s, index);
+    if (cluster_off < s->data_start || cluster_off + s->tracks > s->data_end) {
+        /* Cluster is outside of the image file or overlaps the header. */
+        return -1;
+    }
+
+    return cluster_off + offset;
 }
 
 static int cluster_remainder(BDRVParallelsState *s, int64_t sector_num,
@@ -703,18 +711,22 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t i;
-    int64_t off, high_off, size;
+    int64_t off, high_off, size, data_start_off;
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
+    data_start_off = s->data_start << BDRV_SECTOR_BITS;
 
     high_off = 0;
     for (i = 0; i < s->bat_size; i++) {
         off = bat2sect(s, i) << BDRV_SECTOR_BITS;
-        if (off + s->cluster_size > size) {
+        if (off == 0) {
+            continue;
+        }
+        if (off < data_start_off || off + s->cluster_size > size) {
             fprintf(stderr, "%s cluster %u is outside image\n",
                     fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR", i);
             res->corruptions++;
@@ -1398,11 +1410,18 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
+        if (sector == 0) {
+            continue; /* not allocated */
+        }
+        if (sector < data_start || sector + s->tracks > file_nb_sectors) {
+            /* Cluster is outside of the image file or overlaps the header. */
+            need_check = true;
+            continue;
+        }
         if (sector + s->tracks > s->data_end) {
             s->data_end = sector + s->tracks;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     if (!need_check) {
         ret = parallels_fill_used_bitmap(bs);
diff --git a/tests/qemu-iotests/tests/parallels-checks b/tests/qemu-iotests/tests/parallels-checks
index 8087b03fb9..eef1c86809 100755
--- a/tests/qemu-iotests/tests/parallels-checks
+++ b/tests/qemu-iotests/tests/parallels-checks
@@ -222,6 +222,64 @@ echo "== open must succeed: the header/BAT read is chunked =="
 echo "== an unallocated cluster still reads as zeroes =="
 { $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
 
+# Clear image
+_make_test_img $SIZE
+
+echo "== TEST BAT ENTRY POINTING OUTSIDE IMAGE =="
+
+echo "== corrupt image: point first cluster far outside the file =="
+poke_file_le "$TEST_IMG" $BAT_OFFSET 4 1000000
+
+echo "== read-only read must return zeroes, not an I/O error =="
+{ $QEMU_IO -r -c "read -P 0x00 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== write must allocate a fresh cluster instead of trusting the entry =="
+{ $QEMU_IO -c "write -P 0x77 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== file did not grow anywhere near the bogus offset =="
+file_size=`stat --printf="%s" "$TEST_IMG"`
+if [ "$file_size" -lt $((16 * 1024 * 1024)) ]; then
+    echo "file size sane: yes"
+else
+    echo "file size sane: no ($file_size bytes)"
+fi
+
+echo "== data reads back correctly =="
+{ $QEMU_IO -r -c "read -P 0x77 0 $CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+# Clear image, with a small cluster size so the BAT table itself spans
+# more than one cluster and there is room to point before data_off.
+_make_test_img -o cluster_size=512 65536
+
+SMALL_CLUSTER_SIZE=$(peek_file_le $TEST_IMG $CLUSTER_SIZE_OFFSET 4)
+SMALL_CLUSTER_SIZE=$((SMALL_CLUSTER_SIZE * 512))
+DATA_OFF=$(peek_file_le $TEST_IMG $DATA_OFF_OFFSET 4)
+echo "cluster size: $SMALL_CLUSTER_SIZE, data offset (sectors): $DATA_OFF"
+
+# Cluster index 1 starts at this byte offset, which must be < data_off
+# in sectors * 512 for this test to actually exercise the bug.
+VICTIM_OFFSET=$SMALL_CLUSTER_SIZE
+
+echo "== TEST BAT ENTRY POINTING BEFORE DATA AREA =="
+
+echo "== corrupt image: point first cluster into the BAT table itself =="
+poke_file_le "$TEST_IMG" $BAT_OFFSET 4 1
+
+echo "== qemu-img check detects it without repairing =="
+_check_test_img
+
+echo "== bytes at the victim offset before write =="
+echo "$(peek_file_le "$TEST_IMG" $VICTIM_OFFSET 4)"
+
+echo "== write must allocate a fresh cluster instead of clobbering the BAT =="
+{ $QEMU_IO -c "write -P 0x88 0 $SMALL_CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
+echo "== bytes at the victim offset are unchanged =="
+echo "$(peek_file_le "$TEST_IMG" $VICTIM_OFFSET 4)"
+
+echo "== data reads back correctly =="
+{ $QEMU_IO -r -c "read -P 0x88 0 $SMALL_CLUSTER_SIZE" "$TEST_IMG"; } 2>&1 | _filter_qemu_io | _filter_testdir
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/tests/parallels-checks.out b/tests/qemu-iotests/tests/parallels-checks.out
index b47c42cf4d..86d5b6ac2d 100644
--- a/tests/qemu-iotests/tests/parallels-checks.out
+++ b/tests/qemu-iotests/tests/parallels-checks.out
@@ -146,4 +146,39 @@ Child node '/file':
 == an unallocated cluster still reads as zeroes ==
 read 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304
+== TEST BAT ENTRY POINTING OUTSIDE IMAGE ==
+== corrupt image: point first cluster far outside the file ==
+== read-only read must return zeroes, not an I/O error ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== write must allocate a fresh cluster instead of trusting the entry ==
+Repairing cluster 0 is outside image
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== file did not grow anywhere near the bogus offset ==
+file size sane: yes
+== data reads back correctly ==
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
+cluster size: 512, data offset (sectors): 2
+== TEST BAT ENTRY POINTING BEFORE DATA AREA ==
+== corrupt image: point first cluster into the BAT table itself ==
+== qemu-img check detects it without repairing ==
+ERROR cluster 0 is outside image
+
+1 errors were found on the image.
+Data may be corrupted, or further writes to the image may corrupt it.
+== bytes at the victim offset before write ==
+0
+== write must allocate a fresh cluster instead of clobbering the BAT ==
+Repairing cluster 0 is outside image
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== bytes at the victim offset are unchanged ==
+0
+== data reads back correctly ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
-- 
2.53.0


