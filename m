Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0220AFC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Kt-0006LI-Pv; Fri, 13 Sep 2024 12:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kq-00069X-Pa; Fri, 13 Sep 2024 12:39:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000qA-8c; Fri, 13 Sep 2024 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=yXXklwEAMpNetDgLx0ch4zNLEZrZ08W+a1deIp7OFZg=; b=p1+Fx86UCj4r
 aCsjgh5Kuu9/ESvFDynp8PSryxzg7u0+kc51rwTOoRdYjAx1kP/XKgNpfUqeg+jwyuQIDYmrFPa5E
 kRqxI7FwOMLAMZvTWoXb8+vP/ICeSwHoIVod+/faOKF2q1dZRinzaNeO9+PXE/H4opeVCqt5fGdqM
 L19U78PqaKqML6qexQ7UPxpSRjmxSPE1ofex76Cm5SQncCnTk00xBMQqvnOd5EBZNczqYKpFyn+YW
 eVY2BJFKDTNgyamcnAfh0nI+mH69E/+CBxIMfNY9YuD1o2U8BdspwliM3uLKnd7DCqCaCcz2EtoOt
 FSUuW/jVL7kQ6DZCjlZvIQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2s;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 06/12] iotests/290: add test case to check
 'discard-no-unref' option behavior
Date: Fri, 13 Sep 2024 19:39:36 +0300
Message-Id: <20240913163942.423050-7-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We basically fill 2 images with identical data and perform discard
operations with and without 'discard-no-unref' enabled.  Then we check
that images still read identically, that their disk usage is the same
(i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
both) and that with the option enabled cluster is still marked as
allocated in "qemu-img map" output.  We also check that the option
doesn't work with qcow2 v2 images.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 tests/qemu-iotests/290     | 34 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 776b59de1b..4eb929d15f 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -92,6 +92,40 @@ for qcow2_compat in 0.10 1.1; do
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
+echo "disk_usage(`basename $TEST_IMG`) - disk_usage(`basename $NOUNREF_IMG`)" \
+     "= $(( `disk_usage $TEST_IMG` - `disk_usage $NOUNREF_IMG`))"
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
index 22b476594f..f790feae81 100644
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
+disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
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
2.39.3


