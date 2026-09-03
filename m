Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEF5C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fB-0002pf-3g; Thu, 03 Sep 2026 10:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f8-0002mN-JL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28f6-00044o-AX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-482e067e908so2162475f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446610; x=1789051410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y+iZAgzaoiObj44pBZTJ06CwchhMM20VAZVaSA9mDmA=;
 b=NmtPjQXNoAyZvawbQJyQ3rxsQdX8JN9j0vipAZhOkVX2Ugc6bUt2Kf1BX9IPeMoxPV
 /khp7eDvsL68y+qGKTOE4Unfi0pgVeIQrbkWvow3cPuZaY5CMB6jI+IE+Y5po7ybZQZv
 jPRr0FHph2PHRgGgTw3bZbn6F+clBarZpsI1Fh7X7mxGrzDEydfgYoWHjbkCsuod8RiV
 gLcdOUAuYtEV/nPo9J1dQjb3cqRjxrXc66WXdXuWs+aycl7i63YISKqZKR3Un/lBwhGz
 wZTg0yW7l0JUvF2VFwsH15oVswLN6nflxyMGHlaLjoDpthvTWbqs1350gI5ccuvt/hkX
 Puxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446610; x=1789051410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y+iZAgzaoiObj44pBZTJ06CwchhMM20VAZVaSA9mDmA=;
 b=i1VcQLbLip5ZTPs70cxyW5We90hmvYSsa++520vKTOC4PQ1nHo1gk7mDJR5EYDaCLi
 a0TYAWhXoGK6L/eK+JpjG4aHUuWWfARA7NOT/Nisfv3mADuZotfmXfj3kMUZ9TBmPkQA
 6gLE4mVrd/kDIIUM2DbWaevKTJa847P/lRsJaXsB7umd8fuTw1tnYQOx0nlcmBvtjjid
 R5MULs6qbsDMRyCFhxixRCaMw0oUD5KiDA8p5KLkmMaA//wDvqU/xOxIJmz2Fxl5v4KT
 a0friMQluz3DjQ+9P/m/iT/t8FIOrXuD9mMyA8snmN3uFFTpkSgeRgrxpPX85jUlIbJA
 9dnQ==
X-Gm-Message-State: AFuF++l8kftizgpdwVguR6NUFHJJSg0AJm4H8mLuXIrYOpog9/HZ4uST
 nT0BKKNN2aBmPbk7+13cob+2GRz1k5TlerVTfxMpl4TkhM6Z8aKbj4wn00ZV4KS6Kkbg39FAnKY
 WQh0z
X-Gm-Gg: AYBFou2wSQ9Y0StIngbphYj2YWKGpxKHB9r7r+3XNCk7h5GYLOVOCj+2iHXoUm1s+uZ
 eD4JHjZYdJ7D7QphEdJFggLh/jqx+ZU7sqP2opPTeExZsBRCs/rFahCHeQ5OQRX+04LQzzLc1eG
 vCW5ICtwkwpNWEKlHj2XsHY6/6FWMpPS8eGUMHYrN9Prka1LutstBTQkkBAlxYx/ruwdRHfP/H3
 3dB1GkzQb+myYAxNALFPSzAUjqXQbb+keoC7CYONHDsYNwdNX/qPV8FMtbN+zNsfxlqumsRLHqY
 yqvU1i2lPnx3sYlP6xFHGrz6UxcMk2LbhNVWvbN5gaBWxXvud0hAdcOIC81dDc5ssVp5HEaZtER
 dQ4bbRof/yUnd8TLwPmuL6t15RD2SRVOqsF7mxYkA4jyMEBlj4xrSt1TrxE2wJM4eBmqoENl81n
 8fwikLJfp+L9xvhlCO70h26wIa9iG+dP7x2UYgo7gclcKVPovt7ljje/a+
X-Received: by 2002:a05:6000:208a:b0:484:3311:3702 with SMTP id
 ffacd0b85a97d-48488f2205dmr21923319f8f.25.1788446610124; 
 Thu, 03 Sep 2026 07:43:30 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 16/25] parallels: reject a bitmap L1 entry outside the data
 area
Date: Thu,  3 Sep 2026 16:41:34 +0200
Message-ID: <20260903144143.2328870-17-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=den@openvz.org; helo=mail-wr1-x42f.google.com
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

Nothing checks where a bitmap L1 entry points. The entry is turned into
an offset and the cluster is read from there, so the image decides which
part of the file, if any, is deserialized as bitmap data.

A short read on the protocol node is zero filled rather than refused, so
an entry beyond the end of the file does not even fail: the bitmap
quietly loads as completely clean. An entry below data_off deserializes
the header and the BAT as bitmap data instead. Both cases used to be
harmless in the sense that the extension was only parsed for read-only
images, but the bitmap becomes writable and is stored back as
authoritative once the image can be opened read-write.

Bound the entry the way parallels_check_outside_image() bounds a BAT
entry: it has to address the data area of the image file. The offset
computation is bounded first, as the entry is a 64 bit value coming from
the image and the shift by BDRV_SECTOR_BITS would overflow.

The overflow case was reported as an I/O error before, so the test
expectation changes along with it.

Fixes: baefd977002e ("parallels: support bitmap extension for read-only mode")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels-ext.c                         | 30 ++++++++++++++++++-
 .../qemu-iotests/tests/parallels-read-bitmap  | 23 +++++++++++---
 .../tests/parallels-read-bitmap.out           |  6 +++-
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 6a889d86fa..17445d183b 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -71,9 +71,17 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     int ret = 0;
     uint64_t offset, limit;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
+    int64_t file_size, data_start_off;
     uint8_t *buf = NULL;
     uint64_t i;
 
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        error_setg_errno(errp, -file_size, "Failed to get image file length");
+        return file_size;
+    }
+    data_start_off = s->data_start << BDRV_SECTOR_BITS;
+
     buf = qemu_try_blockalign(bs->file->bs, s->cluster_size);
     if (!buf) {
         error_setg(errp, "Failed to allocate a bitmap data cluster");
@@ -101,7 +109,27 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
         if (entry == 1) {
             bdrv_dirty_bitmap_deserialize_ones(bitmap, offset, count, false);
         } else {
-            int64_t host_off = entry << BDRV_SECTOR_BITS;
+            int64_t host_off;
+
+            if (entry > INT64_MAX / BDRV_SECTOR_SIZE) {
+                error_setg(errp, "Bitmap L1 entry %" PRIu64 " is out of range",
+                           i);
+                ret = -EINVAL;
+                goto finish;
+            }
+            host_off = entry * BDRV_SECTOR_SIZE;
+            if (host_off < data_start_off) {
+                error_setg(errp, "Bitmap L1 entry %" PRIu64 " points before "
+                           "the data area of the image", i);
+                ret = -EINVAL;
+                goto finish;
+            }
+            if (host_off > file_size - (int64_t)s->cluster_size) {
+                error_setg(errp, "Bitmap L1 entry %" PRIu64 " points outside "
+                           "the image file", i);
+                ret = -EINVAL;
+                goto finish;
+            }
 
             ret = bdrv_pread(bs->file, host_off, s->cluster_size, buf, 0);
             if (ret < 0) {
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-read-bitmap
index 6990926d60..f5a1f33907 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap
@@ -93,9 +93,10 @@ def extension(body, magic=EXT_MAGIC, checksum=True):
     return struct.pack('<Q16s', magic, csum) + body
 
 
-def parallels_header(tracks, bat_entries, nb_sectors, ext_sector):
+def parallels_header(tracks, bat_entries, nb_sectors, ext_sector, data_off=1):
     return struct.pack('<16sIIIIIQIIIQ', b'WithouFreSpacExt', 2, 16, 0,
-                       tracks, bat_entries, nb_sectors, 0, 1, 0, ext_sector)
+                       tracks, bat_entries, nb_sectors, 0, data_off, 0,
+                       ext_sector)
 
 
 def write_sparse_image(body, tracks, nb_sectors, bat_entries, ext_sector):
@@ -133,12 +134,14 @@ def report(name):
             log(line.strip())
 
 
-def check(name, ext, tracks=1):
-    header = parallels_header(tracks, SECTORS, SECTORS, EXT_SECTOR)
+def check(name, ext, tracks=1, data_off=1, pad=0):
+    header = parallels_header(tracks, SECTORS, SECTORS, EXT_SECTOR, data_off)
     with open(crafted, 'wb') as f:
         f.write(header)
         f.write(bytes(EXT_SECTOR * 512 - len(header)))   # BAT, unallocated
         f.write(ext)
+        if pad:
+            f.truncate(EXT_SECTOR * 512 + tracks * 512 * (1 + pad))
 
     report(name)
 
@@ -192,6 +195,18 @@ bf = bitmap_feature([0xffffffffffffffff])
 check('bitmap L1 entry overflows',
       extension(feature(BITMAP_MAGIC, len(bf)) + bf + feature(0, 0)))
 
+# A cluster which is not there reads back as zeroes, as short reads on the
+# protocol node are zero filled, so the bitmap would silently load as clean.
+bf = bitmap_feature([8])
+check('bitmap L1 entry past the image file',
+      extension(feature(BITMAP_MAGIC, len(bf)) + bf + feature(0, 0)))
+
+# An entry pointing at the header would deserialize the header as bitmap data.
+bf = bitmap_feature([4])
+check('bitmap L1 entry inside the header',
+      extension(feature(BITMAP_MAGIC, len(bf)) + bf + feature(0, 0)),
+      data_off=8, pad=16)
+
 # Largest cluster_size parallels_open() accepts, about 2 GiB.
 check('cluster_size beyond the file size',
       extension(feature(0, 0)), tracks=0x7fffffff // 513)
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-read-bitmap.out
index 13b10af5a4..ebfc0acb4d 100644
--- a/tests/qemu-iotests/tests/parallels-read-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap.out
@@ -33,7 +33,11 @@ qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 1536
 --- bitmap granularity 8388608
 qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 4294967296, expected a power of two of at least 512 bytes
 --- bitmap L1 entry overflows
-qemu-img: Could not open 'TEST_DIR/PID-crafted': Failed to read bitmap data cluster: Input/output error
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Bitmap L1 entry 0 is out of range
+--- bitmap L1 entry past the image file
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Bitmap L1 entry 0 points outside the image file
+--- bitmap L1 entry inside the header
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Bitmap L1 entry 0 points before the data area of the image
 --- cluster_size beyond the file size
 image opened
 qemu-img: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Format Extension is outside the image file
-- 
2.53.0


