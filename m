Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82078C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLuO-0006Ei-4U; Thu, 04 Jul 2024 08:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLuD-0005Wt-Dr; Thu, 04 Jul 2024 08:49:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLuA-0006YS-C2; Thu, 04 Jul 2024 08:49:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0EC1773AA;
 Thu,  4 Jul 2024 15:48:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 87E0EFE78F;
 Thu,  4 Jul 2024 15:48:27 +0300 (MSK)
Received: (nullmailer pid 1471814 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 16/17] iotests/270: Don't store data-file with json:
 prefix in image
Date: Thu,  4 Jul 2024 15:48:23 +0300
Message-Id: <20240704124826.1471715-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

We want to disable filename parsing for data files because it's too easy
to abuse in malicious image files. Make the test ready for the change by
passing the data file explicitly in command line options.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit 7e1110664ecbc4826f3c978ccb06b6c1bce823e6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/270 b/tests/qemu-iotests/270
index 74352342db..c37b674aa2 100755
--- a/tests/qemu-iotests/270
+++ b/tests/qemu-iotests/270
@@ -60,8 +60,16 @@ _make_test_img -o cluster_size=2M,data_file="$TEST_IMG.orig" \
 # "write" 2G of data without using any space.
 # (qemu-img create does not like it, though, because null-co does not
 # support image creation.)
-$QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
-    "$TEST_IMG"
+test_img_with_null_data="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'filename': '$TEST_IMG'
+    },
+    'data-file': {
+        'driver': 'null-co',
+        'size':'4294967296'
+    }
+}"
 
 # This gives us a range of:
 #   2^31 - 512 + 768 - 1 = 2^31 + 255 > 2^31
@@ -74,7 +82,7 @@ $QEMU_IMG amend -o data_file="json:{'driver':'null-co',,'size':'4294967296'}" \
 # on L2 boundaries, we need large L2 tables; hence the cluster size of
 # 2 MB.  (Anything from 256 kB should work, though, because then one L2
 # table covers 8 GB.)
-$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write 768 $((2 ** 31 - 512))" "$test_img_with_null_data" | _filter_qemu_io
 
 _check_test_img
 
-- 
2.39.2


