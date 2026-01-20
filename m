Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6097D2ECE9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAze-0001ze-AZ; Tue, 20 Jan 2026 07:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1viAzF-0001ez-Tl; Tue, 20 Jan 2026 07:37:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1viAzA-0002YT-Pk; Tue, 20 Jan 2026 07:37:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 055E11802C5;
 Tue, 20 Jan 2026 15:21:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 801B035174E;
 Tue, 20 Jan 2026 15:21:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/9] tests/qemu-iotests: Use "gsed" for expressions that
 require GNU sed
Date: Tue, 20 Jan 2026 15:21:43 +0300
Message-ID: <20260120122150.2254321-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120122150.2254321-1-mjt@tls.msk.ru>
References: <20260120122150.2254321-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

A bunch of tests are currently failing e.g. on FreeBSD like this:

 082   fail       [13:38:58] [13:38:59]   0.5s                 output
  mismatch (see .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad)
 --- .../src/tests/qemu-iotests/082.out
 +++ .../build/tests/qemu-iotests/scratch/qcow2-file-082/082.out.bad
 @@ -17,7 +17,7 @@
  cluster_size: 4096
  Format specific information:
      compat: 1.1
 -    compression type: COMPRESSION_TYPE
 +    compression type: zlib
      lazy refcounts: true
      refcount bits: 16
      corrupt: false

This happens because the sed statements require GNU sed. Let's use
gsed in these spots to get it fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/qemu-iotests/286       | 2 +-
 tests/qemu-iotests/common.rc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index 38216c2a0e..cc6aacf022 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -62,7 +62,7 @@ wait=yes _cleanup_qemu
 
 echo 'Output structure:'
 $QEMU_IMG snapshot -l "$TEST_IMG" | tail -n 1 | tr -s ' ' \
-    | sed -e 's/\S\+/./g' \
+    | gsed -e 's/\S\+/./g' \
     | sed -e 's/\./(snapshot ID)/' \
           -e 's/\./(snapshot name)/' \
           -e 's/\./(VM state size value)/' \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index c0f8f0f8df..731e4b2b99 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -719,7 +719,7 @@ _img_info()
     regex_json_spec_start='^ *"format-specific": \{'
     regex_json_child_start='^ *"children": \['
     $QEMU_IMG info $QEMU_IMG_EXTRA_ARGS "$@" "$TEST_IMG" 2>&1 | \
-        sed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
+        gsed -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
             -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$SOCK_DIR/fuse-#TEST_DIR/#g" \
-- 
2.47.3


