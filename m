Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B08CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXmd-0000p5-Sp; Mon, 08 Jun 2026 07:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmW-0000mX-QF; Mon, 08 Jun 2026 07:04:37 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmU-0006v3-9p; Mon, 08 Jun 2026 07:04:36 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id DFB4D1520F7B;
 Mon, 08 Jun 2026 13:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1780916670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9JvfuXR7szPhJ39nFbfdTuSR/jfEBTyesjCCNDkiDaY=;
 b=g1fEhMggR5sdeW3S44CPDNWI812I1Wwek1rJzUnJNpP4UwudhykMGmTqZbeEFXm7AuX+AS
 B0ob9gAYUQXkYvzjeQazR+a0j0w85GYgnWIiW5qLF3vD+sp2i1ykjExYsMdfj4C+BD/S4Z
 nxm1eS00bmxuhuFMi6WLAd9nnVnP7hz6idCM6fvMlHN6rJltoIXERQWUIyFCWXKJwsxY+o
 328ev11gYqeNeo08K1wygwOsJpmmg92+VGCOx7XsV3SeHWmH0QOrV8X9wl/gwTl3dWvNj5
 FBUoShclpigmFYJubqcpH/FoVZqYZbiNWEj1JikpD0qw20UiWOCiE7SUYkIARw==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 3/3] iotests/290: add test case for qemu-img measure
Date: Mon,  8 Jun 2026 13:03:46 +0200
Message-ID: <20260608110346.3231998-4-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608110346.3231998-1-jean-louis@dupond.be>
References: <20260608110346.3231998-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We create an image, write and discard some data in it, and then create a
snapshot. In the snapshot we write and discard again some data.
Then we measure the images with the base specified to calculate the
merged image size. Finally we commit the image and check it's size.

This scenario is executed for discard-no-unref enabled and disabled.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 tests/qemu-iotests/290     | 45 ++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b59de1b..4702461aa8 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -92,6 +92,51 @@ for qcow2_compat in 0.10 1.1; do
     $QEMU_IMG map "$TEST_IMG" | _filter_testdir
 done
 
+echo
+echo "### Test qemu-img measure for commit differences with 'discard-no-unref' option enabled"
+echo
+
+for DISCARD_NO_UNREF in true false; do
+    echo "# Create a base image and fill it with data"
+    TEST_IMG="$TEST_IMG.base" _make_test_img 128M
+
+    $QEMU_IO -c 'write 0 8M' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'write 10M 8M' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'write 24M 32M' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c 'write 56M 20M' "$TEST_IMG.base" | _filter_qemu_io
+    $QEMU_IO -c "reopen -o discard=unmap,discard-no-unref=$DISCARD_NO_UNREF" \
+        -c 'discard 32M 10M' "$TEST_IMG.base" | _filter_qemu_io
+
+    echo "# Create a top image and do some writes and discards"
+    TEST_IMG="$TEST_IMG.top" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT 128M
+
+    $QEMU_IO -c "reopen -o discard=unmap,discard-no-unref=$DISCARD_NO_UNREF" -c 'write 16M 8M' \
+        -c 'discard 60M 20M' -c 'write 84M 10M' "$TEST_IMG.top" | _filter_qemu_io
+
+    FILE_JSON="json:{
+        'file': {
+            'driver': 'file',
+            'filename': '$TEST_IMG.top'
+        },
+        'driver': 'qcow2',
+        'discard': 'unmap',
+        'discard-no-unref': '$DISCARD_NO_UNREF',
+        'backing': {
+            'driver': 'qcow2',
+            'discard-no-unref': '$DISCARD_NO_UNREF',
+            'file': {
+                'driver': 'file',
+                'filename': '$TEST_IMG.base'
+            },
+            'backing': null
+        }}"
+    echo "# Measure size with discard-no-unref=$DISCARD_NO_UNREF"
+    $QEMU_IMG measure --output=json -O qcow2 "${FILE_JSON}"
+    echo "# Merging the top image into the base image"
+    $QEMU_IMG commit -t none -f qcow2 "${FILE_JSON}"
+    stat -c"base disk image file size in bytes: %s" "$TEST_IMG.base"
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index 22b476594f..6dafbfc2b9 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -58,4 +58,65 @@ read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 # Output of qemu-img map
 Offset          Length          Mapped to       File
+
+### Test qemu-img measure for commit differences with 'discard-no-unref' option enabled
+
+# Create a base image and fill it with data
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8388608/8388608 bytes at offset 10485760
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 33554432/33554432 bytes at offset 25165824
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 20971520/20971520 bytes at offset 58720256
+20 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 10485760/10485760 bytes at offset 33554432
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create a top image and do some writes and discards
+Formatting 'TEST_DIR/t.IMGFMT.top', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 8388608/8388608 bytes at offset 16777216
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 20971520/20971520 bytes at offset 62914560
+20 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 88080384
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Measure size with discard-no-unref=true
+{
+    "bitmaps": 0,
+    "required": 88408064,
+    "fully-allocated": 134545408
+}
+# Merging the top image into the base image
+Image committed.
+base disk image file size in bytes: 88408064
+# Create a base image and fill it with data
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+wrote 8388608/8388608 bytes at offset 0
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8388608/8388608 bytes at offset 10485760
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 33554432/33554432 bytes at offset 25165824
+32 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 20971520/20971520 bytes at offset 58720256
+20 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 10485760/10485760 bytes at offset 33554432
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Create a top image and do some writes and discards
+Formatting 'TEST_DIR/t.IMGFMT.top', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 8388608/8388608 bytes at offset 16777216
+8 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 20971520/20971520 bytes at offset 62914560
+20 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 10485760/10485760 bytes at offset 88080384
+10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Measure size with discard-no-unref=false
+{
+    "bitmaps": 0,
+    "required": 71630848,
+    "fully-allocated": 134545408
+}
+# Merging the top image into the base image
+Image committed.
+base disk image file size in bytes: 71630848
 *** done
-- 
2.54.0


