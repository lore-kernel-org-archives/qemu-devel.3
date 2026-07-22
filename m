Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CB0C4453C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaO5-0005Cm-Gq; Wed, 22 Jul 2026 13:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO2-0005Ai-Ra
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO0-0001Yz-Ec
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so27664985e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739935; x=1785344735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/g2p3N4kfpkZuJaxI9UjRhwniulc+lWWhKKajqjETAQ=;
 b=XuG8DZmk8EXwSOlwCeBqNL3vDfVI+Ww+w7b/VZjisJAHiGKRdj9xZYNGB5ccKWUN0G
 Jyg3UgiSo/64bkfvvmhRRgoqdK3A5OnEYNUfZuD3b+vhaUtdwx2OffCOVE8d/YY8WMFr
 IN807a9VooWkbGoAERyt0JEmZ1jU+PFA8nrnSWHr/gvYq+MNaHiUnfPcVg5Y8LmXGVtP
 IbGxvLJO5Bt1egg0W1ej3+94iyjdEXGOuQ/0cRo1a7P+RsgnXerAGtUU5QR1rTfLAtiI
 LmW2Ki3KXBizPVXJMFY5l5cRiiq3mKctsXSpRJnFHad86mCrxLAfakuin+Xx/gfps3Bl
 h85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739935; x=1785344735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/g2p3N4kfpkZuJaxI9UjRhwniulc+lWWhKKajqjETAQ=;
 b=RbVjZ4xKWKkaTmVQIYxtpRvNCIOUy4Bxix0WnG/zj6Aa0hOFTKTiX3xrHt6eYYO/wR
 YVphRpWYzWwWkJinJzzOw9jqULQk5CF0rgt6B0bw9AxGqaygVlYg8tbCZIzciktwPctM
 ltlmxJfyRdX+2rzDsAkw6X32nY3amSUxhfxmHxMarhOxB5ytSO0dzE+kTN+cdTOtgGzj
 1+PZ44LDh5LMRF1NCgaYGgPRXa7HkKY78B02m9fh1m5gjZ2+0nCYgxqsCTnq3n4w5GPm
 upCsjyqYRNenPT6WGDLcC96ynsS/icDT6FDGG4F73nLunW0qm6BDoP3CFmwixIzdVlv0
 UofQ==
X-Gm-Message-State: AOJu0YxkP8MW1zk3BwYx+iBidxe9S+d3Btnk1XQSS437wTtPdFuMRRxb
 B2Uo38zix07EhuDMoiVSuTuj+DgcCUxMii9i03eYyDnB1eDGzH68fFPxszSKdO55wsz/QrRsdZU
 pejk5
X-Gm-Gg: AR+sD11lRzUkjwfUSmL5UB89Ezt4MAKoAw0HFGIMoqSfTfZBxiNgfaHURTFou4qGpZY
 s0ZSs4Txj4SQF+6WXid+gWmW/8M1DdwdLbAwqBWHsYsFQJSJ1hue/hw2+IcGGCLx9YuYGKe1fL2
 TDvpVqB9Fq2ZG5PAMGNnq8oCN+qDgPcRMI2oopIY3S5LPK+g5FPs09IdJ5mSjeBM5m3GbI6XYZ6
 G1pYA5+kQXygISOL2PhcZVLnEz5zdJhctZEfy7q8/CMFgCEyNLMY4qzp/Zz6xRtKFIQQvQctMcO
 jJDmskawvru0vKmZlmjtJ8yRIC3nfm56edwd3qMW7lA6CLAegLXTA2TZ6kmqcV/czy/2IWz3e/6
 Xh2CifSQRDAYU7JeIcvwdUUIFMTP739RnjI+nIdpmJlBPv2YcnEmYviXveGYnbnJJsDF0H8ttD6
 krmnzDbI0iqQ==
X-Received: by 2002:a05:600c:8b4c:b0:495:6a2f:2c76 with SMTP id
 5b1f17b1804b1-4956a2f2cd7mr54583215e9.32.1784739934646; 
 Wed, 22 Jul 2026 10:05:34 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/9] parallels: fix bat_entries overflow in image creation
Date: Wed, 22 Jul 2026 19:05:21 +0200
Message-ID: <20260722170527.2593225-4-den@openvz.org>
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

parallels_co_create() computed the BAT entry count directly into a
uint32_t, wrapping silently to zero at exactly 2^32 entries and
writing out a header whose BAT no longer matches its advertised
size. Compute it in an int64_t first and reject it once it no longer
fits, matching the cap parallels_open() already enforces. Also
reject cluster-size 0, and clamp header.cylinders instead of letting
it truncate the same way.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels.c          | 23 +++++++++++++++++------
 tests/qemu-iotests/212     |  8 ++++++--
 tests/qemu-iotests/212.out | 10 ++++++++--
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 0f655b58d5..e3d26a6650 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -999,7 +999,8 @@ parallels_co_create(BlockdevCreateOptions* opts, Error **errp)
     BlockdevCreateOptionsParallels *parallels_opts;
     BlockDriverState *bs;
     BlockBackend *blk;
-    int64_t total_size, cl_size;
+    int64_t total_size, cl_size, bat_count;
+    uint64_t cylinders;
     uint32_t bat_entries, bat_sectors;
     ParallelsHeader header;
     uint8_t tmp[BDRV_SECTOR_SIZE];
@@ -1017,16 +1018,22 @@ parallels_co_create(BlockdevCreateOptions* opts, Error **errp)
         cl_size = DEFAULT_CLUSTER_SIZE;
     }
 
-    /* XXX What is the real limit here? This is an insanely large maximum. */
+    /* Bounds cl_size so the multiplication below can't overflow int64_t. */
     if (cl_size >= INT64_MAX / MAX_PARALLELS_IMAGE_FACTOR) {
         error_setg(errp, "Cluster size is too large");
         return -EINVAL;
     }
-    if (total_size >= MAX_PARALLELS_IMAGE_FACTOR * cl_size) {
+    if (cl_size <= 0 || total_size >= MAX_PARALLELS_IMAGE_FACTOR * cl_size) {
         error_setg(errp, "Image size is too large for this cluster size");
         return -E2BIG;
     }
 
+    bat_count = DIV_ROUND_UP(total_size, cl_size);
+    if (bat_count > INT_MAX / (int64_t)sizeof(uint32_t)) {
+        error_setg(errp, "Catalog too large");
+        return -EFBIG;
+    }
+
     if (!QEMU_IS_ALIGNED(total_size, BDRV_SECTOR_SIZE)) {
         error_setg(errp, "Image size must be a multiple of 512 bytes");
         return -EINVAL;
@@ -1052,7 +1059,7 @@ parallels_co_create(BlockdevCreateOptions* opts, Error **errp)
     blk_set_allow_write_beyond_eof(blk, true);
 
     /* Create image format */
-    bat_entries = DIV_ROUND_UP(total_size, cl_size);
+    bat_entries = bat_count;
     bat_sectors = DIV_ROUND_UP(bat_entry_off(bat_entries), cl_size);
     bat_sectors = (bat_sectors *  cl_size) >> BDRV_SECTOR_BITS;
 
@@ -1061,8 +1068,12 @@ parallels_co_create(BlockdevCreateOptions* opts, Error **errp)
     header.version = cpu_to_le32(HEADER_VERSION);
     /* don't care much about geometry, it is not used on image level */
     header.heads = cpu_to_le32(HEADS_NUMBER);
-    header.cylinders = cpu_to_le32(total_size / BDRV_SECTOR_SIZE
-                                   / HEADS_NUMBER / SEC_IN_CYL);
+    cylinders = total_size / BDRV_SECTOR_SIZE / HEADS_NUMBER / SEC_IN_CYL;
+    /* Write only by spec, do not care */
+    if (cylinders >= UINT32_MAX) {
+        cylinders = UINT32_MAX;
+    }
+    header.cylinders = cpu_to_le32(cylinders);
     header.tracks = cpu_to_le32(cl_size >> BDRV_SECTOR_BITS);
     header.bat_entries = cpu_to_le32(bat_entries);
     header.nb_sectors = cpu_to_le64(DIV_ROUND_UP(total_size, BDRV_SECTOR_SIZE));
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index d4af0c4ac8..4ca6149b6b 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -133,13 +133,15 @@ with iotests.FilePath('t.parallels') as disk_path, \
     #
     # Maximum size
     #
+    # Largest catalog parallels_open() can address.
+    #
     iotests.log("=== Maximum size ===")
     iotests.log("")
 
     vm.launch()
     vm.blockdev_create({ 'driver': imgfmt,
                          'file': 'node0',
-                         'size': 4503599627369984})
+                         'size': 562949952372736})
     vm.shutdown()
 
     iotests.img_info_log(disk_path)
@@ -158,13 +160,15 @@ with iotests.FilePath('t.parallels') as disk_path, \
     # 4. 2^63 - 512 (generally valid, but with the image header the file will
     #                exceed 63 bits)
     # 5. 2^52 (512 bytes more than maximum image size)
+    # 6. 2^52 - 512 (wraps bat_entries to 0 at the default 1 MiB cluster size)
 
     iotests.log("=== Invalid sizes ===")
     iotests.log("")
 
     vm.launch()
     for size in [ 1234, 18446744073709551104, 9223372036854775808,
-                  9223372036854775296, 4503599627370497 ]:
+                  9223372036854775296, 4503599627370497,
+                  4503599627369984 ]:
         vm.blockdev_create({ 'driver': imgfmt,
                              'file': 'node0',
                              'size': size })
diff --git a/tests/qemu-iotests/212.out b/tests/qemu-iotests/212.out
index 8102033488..d59f8ed44b 100644
--- a/tests/qemu-iotests/212.out
+++ b/tests/qemu-iotests/212.out
@@ -69,14 +69,14 @@ virtual size: 0 B (0 bytes)
 
 === Maximum size ===
 
-{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "parallels", "file": "node0", "size": 4503599627369984}}}
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "parallels", "file": "node0", "size": 562949952372736}}}
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
 image: TEST_IMG
 file format: IMGFMT
-virtual size: 4 PiB (4503599627369984 bytes)
+virtual size: 512 TiB (562949952372736 bytes)
 
 === Invalid sizes ===
 
@@ -110,6 +110,12 @@ Job failed: Image size is too large for this cluster size
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
 
+{"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"driver": "parallels", "file": "node0", "size": 4503599627369984}}}
+{"return": {}}
+Job failed: Catalog too large
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+
 === Invalid cluster size ===
 
 {"execute": "blockdev-create", "arguments": {"job-id": "job0", "options": {"cluster-size": 1234, "driver": "parallels", "file": "node0", "size": 67108864}}}
-- 
2.53.0


