Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A38C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojtU-0003Xe-Q4; Tue, 28 Jul 2026 11:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtS-0003Vy-RY
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtQ-0002h5-Uu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:38:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso20236465e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253135; x=1785857935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/g2p3N4kfpkZuJaxI9UjRhwniulc+lWWhKKajqjETAQ=;
 b=WBaf1ljcBNk8ccZ1uCrMYmCxiJ1SbQhGA+U8SOleaDH9ZdnvZn9U6g/U0l5U83kAvO
 KW7cEy+m2QXMwSGYqnevboSQ97gYpZoXqL1xwXrY0ISyUQ5mfDehDL3r7UmFYgTEbreQ
 Qene7BV82v9dRjeUYKg1gIncqy9szmwj6KFnsD3ioYq50iWCkXiMuFVDSBnawsxgvt5j
 SmZRAkidtdeqKvgwS+xSco1b8gm1ti8gAlBDMHcqbNYY8L7o/D1cjQ4vmLElWd+JXLHm
 +iv+PK41WYasrSt3zSyb/b5TZs0ASTxkJOcEOC7Tm4BGwa7shtUD0APoKWHyqRxkubbr
 vHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253135; x=1785857935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/g2p3N4kfpkZuJaxI9UjRhwniulc+lWWhKKajqjETAQ=;
 b=Eto83mlOV9OoIwEzJ8czbp6GRgE07yZZlUImUKu8coSftPcQW2bJyLVwk0k4W240A9
 ayMQpsKNT5LJYpM3LNEHlZhEu0Gh1rxrt/B3TQVLNJw6aD1wtw4VzW753NFdu9GC8wlX
 3PatrfTI1sQmTFc4lpQKR0sP4EEE8CzJzovxjWbBjwKswDKHDw/9xdrgeeQSz3K+0OoG
 gUis3EdOimAiBfq6T/tpBhF8wbsWzkSrkIzBsrJvLG0qkwJuYT4/d75T9Vg9lFa05sCS
 vT5dVvxkrUDPqBeIemDVJ+dsJ5lm+HkcnUKBfkZ6VQVsHLc0sT2QgA9i7xRvGlWSLqSp
 +B9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeLyeD8CYpfK62Qejub6GORL389Byt8XH6YesgAStg04eha5B0J1kNwhRgm5QKJtZxPtvkSP3FMxjT@nongnu.org
X-Gm-Message-State: AOJu0YxzTXfRIiEgK5lcXluGkPllVkc1qj1aExaI4XvBg/K8PH89H2p4
 20xQev6bWNB/eUlk7Z1PU6yGYOpUcCX6MATZFRt9dp8s5p/0siZsT5xgYAwRXBLByuA=
X-Gm-Gg: AR+sD11Ni8pwh1GSaqUcfqzG6QErCfpfIlr6qUW9EfOTIJIvQsspCGy1+gbbqJodwpJ
 jvXEwIirhN0csw9cORAfvnAAHIrAjAJpwbNRBT8cImecv0iQNQt6SuRTXr93F6j8pjldyo7HS8Z
 ir3V+SOqpeyQPVVtD6coorl5eJxSwLTik0GlXqlIDfrr0xlbruv4QvGxbv/8iu8b0dbXvhfJH4z
 +YewszxLZpz+CWKHsgwcxUktIaWymn4mu6gnZZAGM2bR7vlO2vguSVjUaPfp5pjYA8cOg4VxHkA
 5BTcIW2h5Vk3j6zNrk8VHhd2vbtJhBh57XkZGabuZZjb0afd0wU+0OBRszjY+Vaxss/SROShrRZ
 Wozvc7LziljPUumOHXAooxjwx+uO66l9I0wNHuOTlIorZWKfyoeh3ls/NN8XbP2igG3ZxChLzWQ
 ==
X-Received: by 2002:a05:600c:4eca:b0:495:7379:17b1 with SMTP id
 5b1f17b1804b1-496c6585036mr32275645e9.30.1785253135218; 
 Tue, 28 Jul 2026 08:38:55 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 3/9] parallels: fix bat_entries overflow in image creation
Date: Tue, 28 Jul 2026 17:38:43 +0200
Message-ID: <20260728153849.601939-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=den@openvz.org; helo=mail-wm1-x333.google.com
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


