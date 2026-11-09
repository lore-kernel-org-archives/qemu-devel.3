Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFF606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Hri080vH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSWz-00033M-Fg; Mon, 09 Nov 2026 11:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVT-0002DP-Uc
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xQSVK-0000zl-Bk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794242757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBqMVyQXE2/e03lm9+Q1Kg1wRJ/cZjoG1FyYdMPnQ4A=;
 b=Hri080vH+d0aVDJWIJiC1cZxwGyxCTqqc+nI13HPGVhY3sX7xKwxqOr67NvfY9djzxeHra
 13LFy5wRSyiAd+2ew786d3l7Dzjjngsu8S5nj/klMktTiAlMl4e8VsWdMQ6o9FJq0BQn1/
 IVwAbvbapFkl5WCk/NvUnEEPWpwxNW0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-cUobQppcO2K_1hRnq2k7Jw-1; Mon,
 09 Nov 2026 11:45:53 -0500
X-MC-Unique: cUobQppcO2K_1hRnq2k7Jw-1
X-Mimecast-MFC-AGG-ID: cUobQppcO2K_1hRnq2k7Jw_1794242752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92A881955E7C; Mon,  9 Nov 2026 16:45:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 099473001DA5; Mon,  9 Nov 2026 16:45:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/11] iotests/290: add test case to check 'discard-no-unref'
 option behavior
Date: Mon,  9 Nov 2026 17:45:30 +0100
Message-ID: <20261109164533.293487-9-kwolf@redhat.com>
In-Reply-To: <20261109164533.293487-1-kwolf@redhat.com>
References: <20261109164533.293487-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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
---
 tests/qemu-iotests/290     | 38 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
index 341a25f96b5..cf4ff6c2bac 100755
--- a/tests/qemu-iotests/290
+++ b/tests/qemu-iotests/290
@@ -29,6 +29,7 @@ status=1    # failure is the default!
 _cleanup()
 {
     _cleanup_test_img
+    _rm_test_img "$TEST_IMG.nounref"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -40,6 +41,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _supported_os Linux
 _unsupported_imgopts 'compat=0.10' refcount_bits data_file compression_type
+_require_disk_usage
 
 echo
 echo "### Test 'qemu-io -c discard' on a QCOW2 image without a backing file"
@@ -90,6 +92,42 @@ for qcow2_compat in 0.10 1.1; do
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
2.56.0


