Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFDDCCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 09:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHIcs-0006tx-US; Fri, 07 Nov 2025 04:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vHIcZ-0006ib-Jt; Fri, 07 Nov 2025 04:19:04 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1vHIcP-0003Sy-Ve; Fri, 07 Nov 2025 04:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=52WhEql8AgWmBXcdnE9GlEQPDOyrgWmIotlo9Rxs1Vc=; b=om4BknDCm/z0dnxU5L4djc0lDN
 PzwR5RjgN974IyEammtK+PNmDegXTZXM4J0wMa1Wvhc8UVfKNMp0Uho0Hc+WLeCTeYdGQrkUzBUwZ
 s+NQ9pA01AB8ReNDjN4ta+FqcWgkYr8Sp3JUplDDBAI0GIvhUulfgMx4YCkUO/vxREiRpRcgC4pd4
 v2LfqacwOsVDm+hupF68L3kexW4gtZxp9zNLooxzukHaqg+lx5FxyRJ4wB0i7EgoT5tZ94Utyw/EW
 160SnVp7oRSunji4JzaRFT8BNyXUWrScDtN2/bZgKRmyBiyeB3j9YeL5+z3uwppMGFechaJfzR/2B
 1FiPwx8g==;
Received: from 116.pool92-176-6.dynamic.orange.es ([92.176.6.116]
 helo=perseus.local) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vHIcJ-003NbT-Dh; Fri, 07 Nov 2025 10:18:47 +0100
Received: from berto by perseus.local with local (Exim 4.98.2)
 (envelope-from <berto@igalia.com>) id 1vHIcH-00000001bqr-1jdZ;
 Fri, 07 Nov 2025 10:18:45 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH] qemu-img rebase: don't exceed IO_BUF_SIZE in one operation
Date: Fri,  7 Nov 2025 10:18:30 +0100
Message-ID: <20251107091834.383781-1-berto@igalia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

During a rebase operation data is copied from the backing chain into
the target image using a loop, and each iteration looks for a
contiguous region of allocated data of at most IO_BUF_SIZE (2 MB).

Once that region is found, and in order to avoid partial writes, its
boundaries are extended so they are aligned to the (sub)clusters of
the target image (see commit 12df580b).

This operation can however result in a region that exceeds the maximum
allowed IO_BUF_SIZE, crashing qemu-img.

This can be easily reproduced when the source image has a smaller
cluster size than the target image:

base <- int <- active

$ qemu-img create -f qcow2 base.qcow2 4M
$ qemu-img create -f qcow2 -F qcow2 -b base.qcow2 -o cluster_size=1M int.qcow2
$ qemu-img create -f qcow2 -F qcow2 -b int.qcow2  -o cluster_size=2M active.qcow2
$ qemu-io -c "write -P 0xff 1M 2M" int.qcow2
$ qemu-img rebase -F qcow2 -b base.qcow2 active.qcow2
qemu-img: qemu-img.c:4102: img_rebase: Assertion `written + pnum <= IO_BUF_SIZE' failed.
Aborted

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3174
Fixes: 12df580b3b7f ("qemu-img: rebase: avoid unnecessary COW operations")
Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 qemu-img.c                 |  2 +-
 tests/qemu-iotests/024     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 27 ++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index a7791896c1..454da88c73 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4081,7 +4081,7 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
             n += offset - QEMU_ALIGN_DOWN(offset, write_align);
             offset = QEMU_ALIGN_DOWN(offset, write_align);
             n += QEMU_ALIGN_UP(offset + n, write_align) - (offset + n);
-            n = MIN(n, size - offset);
+            n = MIN(n, MIN(size - offset, IO_BUF_SIZE));
             assert(!bdrv_is_allocated(unfiltered_bs, offset, n, &n_alloc) &&
                    n_alloc == n);
 
diff --git a/tests/qemu-iotests/024 b/tests/qemu-iotests/024
index b29c76e161..b59d825b42 100755
--- a/tests/qemu-iotests/024
+++ b/tests/qemu-iotests/024
@@ -315,6 +315,52 @@ echo
 
 $QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
 
+# Check that the region to copy to the overlay during a rebase
+# operation does not exceed the I/O buffer size.
+#
+# backing_new <-- backing_old <-- overlay
+#
+# Backing (new): -- -- -- --    <-- Empty image, size 4MB
+# Backing (old):|--|ff|ff|--|   <-- 4 clusters, 1MB each
+# Overlay:      |-- --|-- --|   <-- 2 clusters, 2MB each
+#
+# The data at [1MB, 3MB) must be copied from the old backing image to
+# the overlay. However the rebase code will extend that region to the
+# overlay's (sub)cluster boundaries to avoid CoW (see commit 12df580b).
+# This test checks that IO_BUF_SIZE (2 MB) is taken into account.
+
+echo
+echo "=== Test that the region to copy does not exceed 2MB (IO_BUF_SIZE) ==="
+echo
+
+echo "Creating backing chain"
+echo
+
+TEST_IMG=$BASE_NEW _make_test_img 4M
+TEST_IMG=$BASE_OLD CLUSTER_SIZE=1M _make_test_img -b "$BASE_NEW" -F $IMGFMT
+TEST_IMG=$OVERLAY  CLUSTER_SIZE=2M _make_test_img -b "$BASE_OLD" -F $IMGFMT
+
+echo
+echo "Writing data to region [1MB, 3MB)"
+echo
+
+$QEMU_IO "$BASE_OLD" -c "write -P 0xff 1M 2M" | _filter_qemu_io
+
+echo
+echo "Rebasing"
+echo
+
+$QEMU_IMG rebase -b "$BASE_NEW" -F $IMGFMT "$OVERLAY"
+
+echo "Verifying the data"
+echo
+
+$QEMU_IO "$OVERLAY" -c "read -P 0x00  0 1M" | _filter_qemu_io
+$QEMU_IO "$OVERLAY" -c "read -P 0xff 1M 2M" | _filter_qemu_io
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 2M 1M" | _filter_qemu_io
+
+$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
+
 echo
 
 # success, all done
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 3d1e31927a..cc18ee0290 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -243,4 +243,31 @@ Offset          Length          File
 0               0x20000         TEST_DIR/subdir/t.IMGFMT
 0x40000         0x20000         TEST_DIR/subdir/t.IMGFMT
 
+=== Test that the region to copy does not exceed 2MB (IO_BUF_SIZE) ===
+
+Creating backing chain
+
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_new', fmt=IMGFMT size=4194304
+Formatting 'TEST_DIR/subdir/t.IMGFMT.base_old', fmt=IMGFMT size=4194304 backing_file=TEST_DIR/subdir/t.IMGFMT.base_new backing_fmt=IMGFMT
+Formatting 'TEST_DIR/subdir/t.IMGFMT', fmt=IMGFMT size=4194304 backing_file=TEST_DIR/subdir/t.IMGFMT.base_old backing_fmt=IMGFMT
+
+Writing data to region [1MB, 3MB)
+
+wrote 2097152/2097152 bytes at offset 1048576
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Rebasing
+
+Verifying the data
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 2097152/2097152 bytes at offset 1048576
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Pattern verification failed at offset 2097152, 1048576 bytes
+read 1048576/1048576 bytes at offset 2097152
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x400000        TEST_DIR/subdir/t.IMGFMT
+
 *** done
-- 
2.47.3


