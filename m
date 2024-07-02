Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD1DC3DA40
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgYI-0005py-Gv; Tue, 02 Jul 2024 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYD-0005ne-1c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgY3-0008Oz-7M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719938406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sszMcQ9HKCsFtPXabnsiH9GPa27av1dB9YF+5jtJfU=;
 b=Ih5wc/zW+EAenX67Iz2LWfyo09EM2qTqAM94Glxkbk0o0sBEUdW5jXqLDvJilt8lVnhqk6
 48zk2O6fq+DSfOWvfUrpS5pBR4nfbJbta0h1AD+Ebbkp/znqMsvk/H4tL5gKAnsQbcmKDk
 Bf1irtPXmfDYavI4MV8V2RoNy+2XHuo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-94qxzfOONoK38G1qoMJnfA-1; Tue,
 02 Jul 2024 12:40:03 -0400
X-MC-Unique: 94qxzfOONoK38G1qoMJnfA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2099D196CDE1; Tue,  2 Jul 2024 16:40:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.206])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3E4819560AE; Tue,  2 Jul 2024 16:39:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 1/4] qcow2: Don't open data_file with BDRV_O_NO_IO
Date: Tue,  2 Jul 2024 18:39:40 +0200
Message-ID: <20240702163943.276618-2-kwolf@redhat.com>
In-Reply-To: <20240702163943.276618-1-kwolf@redhat.com>
References: <20240702163943.276618-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

One use case for 'qemu-img info' is verifying that untrusted images
don't reference an unwanted external file, be it as a backing file or an
external data file. To make sure that calling 'qemu-img info' can't
already have undesired side effects with a malicious image, just don't
open the data file at all with BDRV_O_NO_IO. If nothing ever tries to do
I/O, we don't need to have it open.

This changes the output of iotests case 061, which used 'qemu-img info'
to show that opening an image with an invalid data file fails. After
this patch, it succeeds. Replace this part of the test with a qemu-io
call, but keep the final 'qemu-img info' to show that the invalid data
file is correctly displayed in the output.

Fixes: CVE-2024-4467
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.c              | 17 ++++++++++++++++-
 tests/qemu-iotests/061     |  6 ++++--
 tests/qemu-iotests/061.out |  8 ++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 10883a2494..70b19730a3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1636,7 +1636,22 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (open_data_file) {
+    if (open_data_file && (flags & BDRV_O_NO_IO)) {
+        /*
+         * Don't open the data file for 'qemu-img info' so that it can be used
+         * to verify that an untrusted qcow2 image doesn't refer to external
+         * files.
+         *
+         * Note: This still makes has_data_file() return true.
+         */
+        if (s->incompatible_features & QCOW2_INCOMPAT_DATA_FILE) {
+            s->data_file = NULL;
+        } else {
+            s->data_file = bs->file;
+        }
+        qdict_extract_subqdict(options, NULL, "data-file.");
+        qdict_del(options, "data-file");
+    } else if (open_data_file) {
         /* Open external data file */
         bdrv_graph_co_rdunlock();
         s->data_file = bdrv_co_open_child(NULL, options, "data-file", bs,
diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
index 53c7d428e3..b71ac097d1 100755
--- a/tests/qemu-iotests/061
+++ b/tests/qemu-iotests/061
@@ -326,12 +326,14 @@ $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
 echo
 _make_test_img -o "compat=1.1,data_file=$TEST_IMG.data" 64M
 $QEMU_IMG amend -o "data_file=foo" "$TEST_IMG"
-_img_info --format-specific
+$QEMU_IO -c "read 0 4k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" -c "read 0 4k" | _filter_qemu_io
 TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info --format-specific --image-opts
 
 echo
 $QEMU_IMG amend -o "data_file=" --image-opts "data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG"
-_img_info --format-specific
+$QEMU_IO -c "read 0 4k" "$TEST_IMG" 2>&1 | _filter_testdir | _filter_imgfmt
+$QEMU_IO -c "open -o data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" -c "read 0 4k" | _filter_qemu_io
 TEST_IMG="data-file.filename=$TEST_IMG.data,file.filename=$TEST_IMG" _img_info --format-specific --image-opts
 
 echo
diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
index 139fc68177..24c33add7c 100644
--- a/tests/qemu-iotests/061.out
+++ b/tests/qemu-iotests/061.out
@@ -545,7 +545,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 qemu-img: data-file can only be set for images that use an external data file
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 data_file=TEST_DIR/t.IMGFMT.data
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Could not open 'foo': No such file or directory
+qemu-io: can't open device TEST_DIR/t.IMGFMT: Could not open 'foo': No such file or directory
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
@@ -560,7 +562,9 @@ Format specific information:
     corrupt: false
     extended l2: false
 
-qemu-img: Could not open 'TEST_DIR/t.IMGFMT': 'data-file' is required for this image
+qemu-io: can't open device TEST_DIR/t.IMGFMT: 'data-file' is required for this image
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
-- 
2.45.2


