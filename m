Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1DAC369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4x2O-0007V5-R2; Wed, 16 Apr 2025 03:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2J-0007S1-HC; Wed, 16 Apr 2025 03:18:21 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2D-0001oe-MA; Wed, 16 Apr 2025 03:18:19 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id F08141520F9F;
 Wed, 16 Apr 2025 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1744787884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4eHuFiwy8bthRIgr6VRuJkXpBxcL9KA+wWFQkjE4X98=;
 b=L0MFfZrxpX1KtN2np+H9+tVBYTLUzpU8QRKhKzSglRvPC4svUtBHIfw+gQAxIgDXMkMwEn
 gOrUZjl+RCu26KNWzmdr6monj0perfQLGLX/7EhWE4xk3KA0Te12CbInL3gSMOmwMrn1Fl
 AgT42Vynu5/zmksLmMcSrilmw7QtDa5D5Afi0vEI+NNYc4oMKhRcSM8OIpf4J6dQPEaNiE
 Lv7eligbtwbFawalt1QHlQCCvlYgrFTued7raY1+y3/pTLx+daGqIgP/oWaBcsMsknv4Qj
 A9YfE2WGGS7U9aSvWZYkjIygUSJybN3QsCVwdhb0nayh7TZV+XYYVWDHn0Nkmw==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 3/3] iotests/290: add test case for for_commit measure
Date: Wed, 16 Apr 2025 09:16:54 +0200
Message-ID: <20250416071654.978264-4-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416071654.978264-1-jean-louis@dupond.be>
References: <20250416071654.978264-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Then we measure the images with 'for_commit' option to calculate the
merged image size. Finally we commit the image and check it's size.

This scenario is executed for discard-no-unref enabled and disabled.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 tests/qemu-iotests/290     | 45 ++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 61 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b59de1b..1d6608ad13 100755
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
+    $QEMU_IMG measure --output=json -ofor_commit=on -O qcow2 "${FILE_JSON}"
+    echo "# Merging the top image into the base image"
+    $QEMU_IMG commit -t none -f qcow2 "${FILE_JSON}"
+    stat -c"base disk image file size in bytes: %s" "$TEST_IMG.base"
+done
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index 22b476594f..4207572118 100644
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
+    "required": 88670208,
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
+    "required": 71892992,
+    "fully-allocated": 134545408
+}
+# Merging the top image into the base image
+Image committed.
+base disk image file size in bytes: 71630848
 *** done
-- 
2.49.0


