Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E15606A33D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=CtedYcBQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3F7-00070a-NP; Mon, 16 Nov 2026 15:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3F0-0006uf-SY; Mon, 16 Nov 2026 15:23:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ey-0004JJ-VH; Mon, 16 Nov 2026 15:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=J0xrd89uKbBh2VW0/9UgA7ZgXvUcPFah7+/KpRNtNRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CtedYcBQtToeNR/Uaa0wZ/5wjePet+OQzbMlCsW7ciC5ZH1J/Pjr4kI8Z/gShFl63
 zSXcyBU11VgwtNin7SfE6s8ChSYhxFc150R0RGDR6vFFYsenO23AwuPYHyvkTTuyo1
 iqQD5cgnLykO/mUjp5692GmM+pOB/f0cI5awHnYQEtM4jPVaxgqdTpcCGJC4xEzmcW
 BLKsNp0CvVe58vtK/QjDz714KN8ygT40L2fmRo4OCBiQTuo1vMd7lRZdiJmidjyfdg
 lUTUZQBvSD4R3vKIX7fzjdQHIZbbozurATipRUsZFPsjozeQmgSiSUNRS/3dkM+fR2
 eRnP3Ct9v9gPg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A2C8D1E716B;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A01C045FBA0;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8AE7FB8E30; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 49/59] iotests/290: add test case to check
 'discard-no-unref' option behavior
Date: Mon, 16 Nov 2026 23:18:53 +0300
Message-ID: <20261116201922.534306-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

We basically fill 2 images with identical data and perform discard
operations with and without 'discard-no-unref' enabled.  Then we check
that images still read identically, that their disk usage is the same
(i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
both) and that with the option enabled cluster is still marked as
allocated in "qemu-img map" output.  We also check that the option
doesn't work with qcow2 v2 images.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20261105161515.794213-2-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 26aae51023123576bf3c89e07d4bf106dc9b5a6a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b59de1bc..6689b903dc7 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -31,6 +31,7 @@ status=1    # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    _rm_test_img "$TEST_IMG.nounref"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -42,6 +43,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts 'compat=0.10' refcount_bits data_file compression_type
+_require_disk_usage
 
 echo
 echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing file"
@@ -92,6 +94,42 @@ for qcow2_compat in 0.10 1.1; do
     $QEMU_IMG map "$TEST_IMG" | _filter_testdir
 done
 
+echo
+echo "### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled"
+echo
+
+echo "# Check that qcow2 v2 images don't support 'discard-no-unref' option"
+NOUNREF_IMG="$TEST_IMG.nounref"
+TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=0.10" 128k
+# This should immediately fail with an error
+$QEMU_IO -c 'reopen -o discard-no-unref=on' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Create two compat=1.1 images and fill them with identical data"
+_make_test_img -o "compat=1.1" 128k
+TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=1.1" 128k
+$QEMU_IO -c 'write -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'write -P 0xaa 0 128k' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both"
+$QEMU_IO -c 'discard 64k 64k' "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c 'reopen -o discard-no-unref=on' \
+         -c 'discard 64k 64k' "$NOUNREF_IMG" | _filter_qemu_io
+
+echo "# Compare disk usage of the 2 images"
+# Don't check the exact disk usage values but rather that they're equal
+usage1=$(disk_usage "$TEST_IMG")
+usage2=$(disk_usage "$NOUNREF_IMG")
+echo "disk_usage($TEST_IMG) - disk_usage($NOUNREF_IMG) = $((usage1 - usage2))" \
+    | _filter_testdir | _filter_imgfmt
+
+echo "# Check that images are still identical"
+$QEMU_IMG compare "$TEST_IMG" "$NOUNREF_IMG"
+
+echo "# Output of qemu-img map for the image with dropped reference"
+$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
+echo "# Output of qemu-img map for the image with kept reference"
+$QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
index 22b476594fb..d8f8d5ff493 100644
--- a/tests/qemu-iotests/290.out
+++ b/tests/qemu-iotests/290.out
@@ -58,4 +58,32 @@ read 131072/131072 bytes at offset 0
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 # Output of qemu-img map
 Offset          Length          Mapped to       File
+
+### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled
+
+# Check that qcow2 v2 images don't support 'discard-no-unref' option
+Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
+qemu-io: discard-no-unref is only supported since qcow2 version 3
+# Create two compat=1.1 images and fill them with identical data
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
+Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 0
+128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both
+discard 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+discard 65536/65536 bytes at offset 65536
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+# Compare disk usage of the 2 images
+disk_usage(TEST_DIR/t.IMGFMT) - disk_usage(TEST_DIR/t.IMGFMT.nounref) = 0
+# Check that images are still identical
+Images are identical.
+# Output of qemu-img map for the image with dropped reference
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
+# Output of qemu-img map for the image with kept reference
+[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
 *** done
-- 
2.47.3


