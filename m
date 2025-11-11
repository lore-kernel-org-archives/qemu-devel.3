Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D331ACCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIw17-0000yB-TT; Tue, 11 Nov 2025 16:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0R-0000XO-Un
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0N-0002I2-3i
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsWpJ1fT5oClZZ7jlO7mqvDN0tCOobR4rddQnL5QirM=;
 b=IgXdn83OgJssYqoJCXBpXSWC1titsWG1XPXtXVRr+YJU6g3H5lWZ4FfoCMqPkXEz4CSDZZ
 VvTuj/u9xJpGuGE0XfU5WT0NFysfP8wa4kqXxeok67Jtplyl2zZCuMZik+c6cLsflr+t+X
 g7ELarGAXCTVtnosz2Y4vBH7W7Oi0tQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-9mM8K_mGM1yu25r8vN8R1w-1; Tue,
 11 Nov 2025 16:34:04 -0500
X-MC-Unique: 9mM8K_mGM1yu25r8vN8R1w-1
X-Mimecast-MFC-AGG-ID: 9mM8K_mGM1yu25r8vN8R1w_1762896843
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB7951956063; Tue, 11 Nov 2025 21:34:03 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2534230044E0; Tue, 11 Nov 2025 21:34:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 28/28] qemu-img rebase: don't exceed IO_BUF_SIZE in one
 operation
Date: Tue, 11 Nov 2025 22:32:38 +0100
Message-ID: <20251111213238.181992-29-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alberto Garcia <berto@igalia.com>

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

Cc: qemu-stable <qemu-stable@nongnu.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3174
Fixes: 12df580b3b7f ("qemu-img: rebase: avoid unnecessary COW operations")
Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-ID: <20251107091834.383781-1-berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 |  2 +-
 tests/qemu-iotests/024     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/024.out | 26 +++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7a32d2d16c..c42dd4e995 100644
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
index b29c76e161..021169b4a1 100755
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
+$QEMU_IO "$OVERLAY" -c "read -P 0x00 3M 1M" | _filter_qemu_io
+
+$QEMU_IMG map "$OVERLAY" | _filter_qemu_img_map
+
 echo
 
 # success, all done
diff --git a/tests/qemu-iotests/024.out b/tests/qemu-iotests/024.out
index 3d1e31927a..1b7522ba71 100644
--- a/tests/qemu-iotests/024.out
+++ b/tests/qemu-iotests/024.out
@@ -243,4 +243,30 @@ Offset          Length          File
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
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Offset          Length          File
+0               0x400000        TEST_DIR/subdir/t.IMGFMT
+
 *** done
-- 
2.51.1


