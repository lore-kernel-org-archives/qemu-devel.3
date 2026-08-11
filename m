Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1760C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtqSb-0005cC-5G; Tue, 11 Aug 2026 13:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRl-0004c4-Rf
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:30 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wtqRj-0000Va-2Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 13:39:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6a10d02ff43so170391a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786469964; x=1787074764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q2P3wf2OCE/uBwdM3uTHXwb8VtUf7Xr3Kv0lq0Cjg98=;
 b=YVqbrKpSgZ2j6Y92pKZ4SQovSz16VQ/QuIapo0HIiCyZcB1oHhjb0t7fZZGSzlsztZ
 DvN2Fb4IbmTuZp7mZULzxgNx8ULI33L0+v/pahKuGtJk+J04pHuPDWFEApa9KmhqEkIP
 6vTBMbGE9NLnQjIXCzMjeEal6na9oHciV16dz++gNYj0Qrdlqb2drWB5cnSB1/qX8SK3
 DY2sbV2F4HCCmA6PWOdzfJHpmDnhhkawIAbe+yOl4nMRY1sYIu0z8t5tl7sQxX74HZ2G
 5LCmHh75c+VnoW/LRgz2CKZFje+UTQkOeKmj6qXmVVF7yOy3JxME6pvQZ+jLSlWl3w5N
 vA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469964; x=1787074764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q2P3wf2OCE/uBwdM3uTHXwb8VtUf7Xr3Kv0lq0Cjg98=;
 b=Mk6rQ7IFMC88bJdD/NS0STVb2XRqc531gh772AVLSEEW4hqvABTAzHoWhwemHz/xr1
 me/h+QA2sR+ATXupqJIRdcIMce7IuLNax6A7UckZmzBueSE/R75hXKeBqBTVgIqcINSC
 OoJ6/24soFE0IqaiKTMpXoyD0HXHMjcNarmRLr0VjFAyyBIVMBYLnp3TWpcIuUHS2BWE
 Z3w1uhSrq6PuOO5LjpA/hQMxo2bKZSM2mC/2lbxLGo5iPPW7ArawkVPfVIbM1wy+ufZK
 ovOYXtqPFtwAImK5XwM2o9fqyvLW7+v3PfLGFSmo7JzHLQ/aN2TeFqqwHqy3cIYydq0Y
 9haQ==
X-Gm-Message-State: AOJu0Yzr/nD/TtXWhzXX5xRLUX5LJqZZaP+Iaw+HOt5Y9pAFzpFtxcwF
 8oKmzWvfoqS2mU8uHhZ0SY0dNBvhy+VToWPa/ynlCgxbrOiDd5GcHcC3vehpTpGoNOTZnJbxKwk
 CudzQ
X-Gm-Gg: AR+sD10EjXNUmUHvopihhNNX9maoxu4TzdTIjR6HsyELOry8JRXMEl3IAAREgFJtpqS
 3InvGlzwbPm0W4Hym9cdceTU4+d+NLDC67k4R1yVoz6eT9kGnFFd+I9F8YoQElBcFNzhIUCM5xr
 QLqJWwp9RDab3BmB7531zS0qjF/KLqQvdGpGNcSywuLFF9Y4J8ZMCUF//uP7okJO3ICzYje2m4R
 AKofJmM/s9wVhflB/hNTYUca6GWrErT22J/zpEK8EzMzCQddcExVNFuMcYxs6V4yTNEMFUvWErd
 xhOfIvqxrGUGAGHAoJWDnUulDHjIeoJvbQXZtrd/ObijPY5kLSGImBYBX/mr801Zi/kmbRQgXyW
 S8gp/c7N5EgBk4NvIegDl/C+KBJ0kYhlmeHXnV1ApjQ7DGF+1j2OWKOVlRvJqBuo2OuQGs7PMYI
 KWGoca4SN33CCUo01QRQGkgic5OATV8k2BO2SOBQhcl7P/t8JWJBQLAI1n
X-Received: by 2002:a05:6402:a682:b0:6a1:dbd:bfe with SMTP id
 4fb4d7f45d1cf-6a36be4387amr819310a12.7.1786469963593; 
 Tue, 11 Aug 2026 10:39:23 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c43:d230:7bbc:68d4])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a362ef7525sm880945a12.29.2026.08.11.10.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:39:22 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 8/8] iotests: cover the Parallels format extension parser
Date: Tue, 11 Aug 2026 19:38:57 +0200
Message-ID: <20260811173857.396571-9-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811173857.396571-1-den@openvz.org>
References: <20260811173857.396571-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=den@openvz.org; helo=mail-ed1-x52c.google.com
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

Extend the existing test with hand crafted extension clusters, built
in the test rather than shipped as samples. Each corruption case is
one qemu-img info run which either opens the image or reports why it
was rejected: extension magic and checksum, feature magic and flags,
payloads running past the cluster, bitmap granularity, an L1 entry
which overflows when converted to an offset, and a cluster_size larger
than the image file. Two more cases load a bitmap spanning two L1
entries.

Termination by a signal is not covered by check=False, so it is caught
and logged to keep the remaining cases running.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 .../qemu-iotests/tests/parallels-read-bitmap  | 180 +++++++++++++++++-
 .../tests/parallels-read-bitmap.out           |  33 ++++
 2 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap b/tests/qemu-iotests/tests/parallels-read-bitmap
index 38ab5fa5b2..5cbef25018 100755
--- a/tests/qemu-iotests/tests/parallels-read-bitmap
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap
@@ -18,14 +18,22 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
 
+import hashlib
+import struct
+import uuid
+
+from qemu.utils import VerboseProcessError
+
 import iotests
-from iotests import qemu_nbd_popen, qemu_img_map, log, file_path
+from iotests import qemu_nbd_popen, qemu_img, qemu_img_map, log, file_path
 
 iotests.script_initialize(supported_fmts=['parallels'])
 
 nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
+nbd_sock2 = file_path('nbd-sock2', base_dir=iotests.sock_dir)
 disk = iotests.file_path('disk')
 bitmap = 'e4f2eed0-37fe-4539-b50b-85d2e7fd235f'
+MULTI_L1_UUID = '5f2e1c00-0000-4000-8000-0123456789ab'
 nbd_opts = f'driver=nbd,server.type=unix,server.path={nbd_sock}' \
         f',x-dirty-bitmap=qemu:dirty-bitmap:{bitmap}'
 
@@ -51,3 +59,173 @@ with qemu_nbd_popen('--read-only', f'--socket={nbd_sock}',
             log(f'{a}-{b-1}')
         else:
             log(a)
+
+
+# Hand crafted Format Extension clusters.
+
+EXT_MAGIC = 0xAB234CEF23DCEA87
+BITMAP_MAGIC = 0x20385FAE252CB34A
+
+CLUSTER = 512           # one sector per track
+SECTORS = 8             # 4 KiB disk
+EXT_SECTOR = 1          # the extension cluster follows the header
+EH_SIZE = 24            # ParallelsFormatExtensionHeader
+FH_SIZE = 24            # ParallelsFeatureHeader
+BF_SIZE = 32            # ParallelsDirtyBitmapFeature
+
+crafted = file_path('crafted')
+
+
+def feature(magic, data_size, flags=0):
+    return struct.pack('<QQII', magic, flags, data_size, 0)
+
+
+def bitmap_feature(l1, granularity=1, nb_sectors=SECTORS, bid=None):
+    """ParallelsDirtyBitmapFeature followed by its L1 table"""
+    bid = uuid.UUID(bid).bytes if bid else uuid.uuid4().bytes
+    return (struct.pack('<Q16sII', nb_sectors, bid, granularity, len(l1))
+            + b''.join(struct.pack('<Q', entry) for entry in l1))
+
+
+def extension(body, magic=EXT_MAGIC, checksum=True):
+    body = body.ljust(CLUSTER - EH_SIZE, b'\0')
+    csum = hashlib.md5(body).digest() if checksum else bytes(16)
+    return struct.pack('<Q16s', magic, csum) + body
+
+
+def parallels_header(tracks, bat_entries, nb_sectors, ext_sector):
+    return struct.pack('<16sIIIIIQIIIQ', b'WithouFreSpacExt', 2, 16, 0,
+                       tracks, bat_entries, nb_sectors, 0, 1, 0, ext_sector)
+
+
+def write_sparse_image(body, tracks, nb_sectors, bat_entries, ext_sector):
+    """Image whose extension cluster is the given body, zero padded."""
+    cluster_size = tracks * 512
+    md5 = hashlib.md5()
+    md5.update(body)
+    md5.update(bytes(cluster_size - EH_SIZE - len(body)))
+
+    with open(crafted, 'wb') as f:
+        f.write(parallels_header(tracks, bat_entries, nb_sectors, ext_sector))
+        f.write(bytes(ext_sector * 512 - 64))            # BAT, unallocated
+        f.write(struct.pack('<Q16s', EXT_MAGIC, md5.digest()) + body)
+        f.truncate(ext_sector * 512 + cluster_size)      # sparse zero tail
+
+
+def report(name):
+    log(f'--- {name}')
+    try:
+        res = qemu_img('info', '-f', iotests.imgfmt, crafted, check=False)
+    except VerboseProcessError as exc:
+        # check=False does not cover termination by a signal
+        log(f'qemu-img died with signal {-exc.returncode}')
+        return
+
+    log('image opened' if res.returncode == 0
+        else iotests.filter_testfiles(res.stdout).strip())
+
+
+def check(name, ext, tracks=1):
+    header = parallels_header(tracks, SECTORS, SECTORS, EXT_SECTOR)
+    with open(crafted, 'wb') as f:
+        f.write(header)
+        f.write(bytes(EXT_SECTOR * 512 - len(header)))   # BAT, unallocated
+        f.write(ext)
+
+    report(name)
+
+
+log('')
+
+# Control case, must keep working.
+good = bitmap_feature([0])
+check('well-formed extension',
+      extension(feature(BITMAP_MAGIC, len(good)) + good + feature(0, 0)))
+
+check('wrong extension magic',
+      extension(feature(0, 0), magic=EXT_MAGIC ^ 1))
+
+check('wrong extension checksum',
+      extension(feature(0, 0), checksum=False))
+
+check('unknown feature', extension(feature(BITMAP_MAGIC ^ 1, 0)))
+
+check('feature flags set', extension(feature(0, 0, flags=1)))
+
+check('feature data_size beyond the cluster',
+      extension(feature(BITMAP_MAGIC, CLUSTER)))
+
+payload = CLUSTER - EH_SIZE - FH_SIZE
+check('feature payload consumes the cluster',
+      extension(feature(BITMAP_MAGIC, payload)
+                + good.ljust(payload, b'\0')))
+
+# bf.size must match the disk size or the compiler elides the OOB loads.
+data1 = CLUSTER - 40 - EH_SIZE - FH_SIZE
+check('second feature payload beyond the cluster',
+      extension(feature(BITMAP_MAGIC, data1) + good.ljust(data1, b'\0')
+                + feature(BITMAP_MAGIC, BF_SIZE + 8)
+                + struct.pack('<Q', SECTORS)))
+
+# Zero, not a power of two, and wrapping when shifted: all three assert.
+for gran in (0, 3, 1 << 23):
+    bf = bitmap_feature([0], granularity=gran)
+    check(f'bitmap granularity {gran}',
+          extension(feature(BITMAP_MAGIC, len(bf)) + bf + feature(0, 0)))
+
+# entry << BDRV_SECTOR_BITS must not wrap into a negative offset.
+bf = bitmap_feature([0xffffffffffffffff])
+check('bitmap L1 entry overflows',
+      extension(feature(BITMAP_MAGIC, len(bf)) + bf + feature(0, 0)))
+
+# Largest cluster_size parallels_open() accepts, about 2 GiB.
+check('cluster_size beyond the file size',
+      extension(feature(0, 0)), tracks=0x7fffffff // 513)
+
+
+def check_big_cluster():
+    """Reaches the serialization coverage overflow, costs about 550 MiB."""
+    tracks = 1 << 19                    # cluster_size = 2^28
+    nb_sectors = 1 << 32                # 2 TiB, needs two L1 entries
+    ext_sector = 256                    # past the BAT
+    l1 = [0, 1]                         # entry 1 deserializes as all ones
+
+    bmap = bitmap_feature(l1, nb_sectors=nb_sectors)
+    body = feature(BITMAP_MAGIC, len(bmap)) + bmap + feature(0, 0)
+
+    write_sparse_image(body, tracks, nb_sectors, nb_sectors // tracks,
+                       ext_sector)
+    report('bitmap serialization coverage overflow')
+
+
+check_big_cluster()
+
+
+def check_multi_l1():
+    """Bitmap spanning two L1 entries with an ordinary 64 KiB cluster."""
+    tracks = 128                        # cluster_size = 64 KiB
+    nb_sectors = 1 << 27                # 64 GiB, needs two L1 entries
+    gran_sectors = 128                  # 64 KiB, as in the sample image
+    bat_entries = nb_sectors // tracks
+    ext_sector = (64 + 4 * bat_entries) // 512 + 8   # past the BAT
+    l1 = [0, 1]                         # first half clean, second all ones
+
+    bmap = bitmap_feature(l1, gran_sectors, nb_sectors, MULTI_L1_UUID)
+    body = feature(BITMAP_MAGIC, len(bmap)) + bmap + feature(0, 0)
+
+    write_sparse_image(body, tracks, nb_sectors, bat_entries, ext_sector)
+
+    log('--- bitmap spanning two L1 entries')
+    opts = f'driver=nbd,server.type=unix,server.path={nbd_sock2}' \
+           f',x-dirty-bitmap=qemu:dirty-bitmap:{MULTI_L1_UUID}'
+    with qemu_nbd_popen('--read-only', f'--socket={nbd_sock2}',
+                        f'--bitmap={MULTI_L1_UUID}', '-f', iotests.imgfmt,
+                        crafted):
+        for chunk in qemu_img_map('--image-opts', opts):
+            if not chunk['data']:
+                first = chunk['start'] >> 30
+                last = (chunk['start'] + chunk['length']) >> 30
+                log(f'dirty {first}-{last} GiB')
+
+
+check_multi_l1()
diff --git a/tests/qemu-iotests/tests/parallels-read-bitmap.out b/tests/qemu-iotests/tests/parallels-read-bitmap.out
index e8f6bc9e96..3b3f90c8de 100644
--- a/tests/qemu-iotests/tests/parallels-read-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-read-bitmap.out
@@ -4,3 +4,36 @@ dirty clusters (cluster size is 64K):
 10-12
 30
 Kill NBD server
+
+--- well-formed extension
+image opened
+--- wrong extension magic
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Wrong parallels Format Extension magic: 0xab234cef23dcea86, expected: 0xab234cef23dcea87
+--- wrong extension checksum
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Wrong checksum in Format Extension header. Format extension is corrupted.
+--- unknown feature
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Unknown feature: 0x20385fae252cb34b
+--- feature flags set
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Flags for extension feature are unsupported
+--- feature data_size beyond the cluster
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Feature data_size exceedes Format Extension cluster
+--- feature payload consumes the cluster
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Can not read feature header, as remaining bytes (0) in Format Extension is less than Feature header size (24)
+--- second feature payload beyond the cluster
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Feature data_size exceedes Format Extension cluster
+--- bitmap granularity 0
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 0, expected a power of two of at least 512 bytes
+--- bitmap granularity 3
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 1536, expected a power of two of at least 512 bytes
+--- bitmap granularity 8388608
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid bitmap granularity 4294967296, expected a power of two of at least 512 bytes
+--- bitmap L1 entry overflows
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Failed to read bitmap data cluster: Input/output error
+--- cluster_size beyond the file size
+qemu-img: Could not open 'TEST_DIR/PID-crafted': Invalid image: Format Extension is outside the image file
+--- bitmap serialization coverage overflow
+image opened
+--- bitmap spanning two L1 entries
+Start NBD server
+dirty 32-64 GiB
+Kill NBD server
-- 
2.53.0


