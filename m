Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9ADC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGc-000887-Gh; Tue, 28 Jul 2026 06:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGa-00086r-Ny
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:32 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGY-0008HP-MB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:32 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c1740c36c5cso517484566b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235349; x=1785840149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BhGcypSN9c7MXiKGLST/q5b00sWwo654rqpJZ/LWYcg=;
 b=uCbD+IrGPJf3XqfLIqq/MVmMM505mkKORydGuuI8q59tzF1Vx7t6gGg2iJRoM1ilKK
 Gh0h48kKCgXX2UIIhRJWmwug8+Qb0ZVMqeLE2DPKLUkJzVGeunqt46VGqp0uNOeAsA31
 ocn7vRjL3KDYodnbW9tqp5j5X2nXL/OowkOD6G9wUqaD6yjNz8lSIU7OXKasfqkOmYq1
 uL9q05l5HSYCqX59XiXMymKn9MQF/fZpbHqnnKvx1Ot54cz0KeMabXhhkVlvHz1mWc8g
 KdDW4VxIzGwuT6S+UTq1pQSAjomgcxf9mlFr1rEnaWNPzziLT9bVDIHwt50rhktmVM6s
 /UAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235349; x=1785840149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BhGcypSN9c7MXiKGLST/q5b00sWwo654rqpJZ/LWYcg=;
 b=dqg8PdEtTZnZU5hkvyo6Wx+ascFBKVCkLqZU/qvFaiW+BxisdfxBpF2srHo5LHJ3nt
 vvJsUOdnrvGzshfSTbEYC1t4pIQc//i1ju/kKR+++Izb1qW7OYVumKSDFbt/Dj18nq73
 ERwKJ9k5EgbH5B/Ti+dpphRt6a2p7yAuEL2OVxtpBw1SaXELfegzEg3P4fc5NqNrRmFs
 O7Udr198b3vDBa140L4tBscsP4sTfazNBLDYD0F7QyWr6vhHMla0agGitl2nor7F0hWk
 WetzRP4ByLi1MVIIvuviBP4U0kl0cAxU35DcKE+8WEMTEkN71RNSXCepd7N+MUr7zzpF
 SBSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxUIALUVDZeuD8+ZnuaHbL6SqqNtneAv1X6k5v2gcrKLwEdA+j9ikrhaqbO8dLSzJsJNQfACq8nDVt@nongnu.org
X-Gm-Message-State: AOJu0YzFMd6RyeQwP9CIa1hFVtMfTH6UPRRwVnUxnOrZaJkJsFocN3E8
 Gjdw5mqyJaYYTV26Szuq/zutDYAVgQwysO1EMXdTuwiFGDeJCm4lUomcGBv+ImNxLk8=
X-Gm-Gg: AR+sD13PHVfb1GOu+TauxBaH2Iv6HACC3IZLDWodNZFplT9yhOAn8NDkcGK/YYa8RTo
 pLA2lTuP/F4Z5+OzfqkoDP/4HFlAwaPZ+dMtYE45jUHC5hVUK6banWqjiKXU84WTBuCyvP+dk4z
 +d3zCNU4tVEswfkp7UVHbj4+vKwk8ivcHwqBCs3xSiQfHuKTy6NaK3w+BIJQSUb6A5DnWHXDZLk
 ajqYIn4D4yAzBYV8EEYhY2QLqYdrJ7OeNlNPKd4uwi3HZzt+KU0Sx+qRLgOe6BknkQpJLknf4nS
 YuT7le5dXYS2iFWOWKzwZkM46EHjxS0uClDXqFIcRMOayiSGFyfayIadSXGdLMHIIMOPWRk0soc
 RITHvraQoRb0Mh2jSsmQ0d/l+8DYmOmZmWdBLllW/zMTwvUImgbSlZ1tpSo4UmmDCgw==
X-Received: by 2002:a17:907:d18:b0:c16:589d:c965 with SMTP id
 a640c23a62f3a-c1f722567a1mr97029166b.46.1785235349187; 
 Tue, 28 Jul 2026 03:42:29 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:28 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 4/9] parallels: reject BAT entries pointing outside backed
 storage
Date: Tue, 28 Jul 2026 12:42:16 +0200
Message-ID: <20260728104221.3981592-5-den@openvz.org>
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


