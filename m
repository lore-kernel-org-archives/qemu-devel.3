Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DA3FC616A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9LW-0000LY-DJ; Fri, 13 Sep 2024 12:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9LI-0007ul-Nr; Fri, 13 Sep 2024 12:40:21 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9LG-00015Z-Un; Fri, 13 Sep 2024 12:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=Of+BGFkX4T73fvOvveXGD/8FZywciz8d+w+vmJhE8o8=; b=tvXwKb/KSIxC
 An5LpO3/0uVf1RjWHIUY+mKpM4sERYQEkboW42dqUtT9A1/yHucs1LRbD42B0OAw5GAy/S4hSCluZ
 2gAkxGnMuFafddc/JlgZOGx7y5OKcIPn99/myP1qyGqAeI6vsq82M6QlKXTqqLE9DW06QxvioY44U
 riCrCV2np0b8g6Y8b23JIzIwR1kqYuTTAnArfThQ3FGeWmMJGK8EFnKuuT4Um3pcm2xu5zC1qHuqj
 Cf0emyoA79h9J3+7gfsHACflLkLV7gFc9e9VDi7jDlpv1QQkph2Rw55oDDt9BRE9Sqr2KUhDdDfUZ
 5mMpUyriqRAJi1HKRVaZ9g==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hz-002OPf-0Y;
 Fri, 13 Sep 2024 18:39:40 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 12/12] qcow2: add discard-subclusters option
Date: Fri, 13 Sep 2024 19:39:42 +0300
Message-Id: <20240913163942.423050-13-andrey.drobyshev@virtuozzo.com>
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

Introduce Qcow2 runtime boolean option "discard-subclusters".  This
option influences discard alignment value (either cluster_size or
subcluster_size) and essentially makes subcluster-based discard optional.
We disable it by default.

Also tweak iotests/271 to enable this option and really test subcluster
based discards.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2.c          | 21 ++++++++++++++++++++-
 block/qcow2.h          |  2 ++
 tests/qemu-iotests/271 | 10 ++++++----
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c2086d0bd1..7c38a5be41 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -685,6 +685,7 @@ static const char *const mutable_opts[] = {
     QCOW2_OPT_DISCARD_SNAPSHOT,
     QCOW2_OPT_DISCARD_OTHER,
     QCOW2_OPT_DISCARD_NO_UNREF,
+    QCOW2_OPT_DISCARD_SUBCLUSTERS,
     QCOW2_OPT_OVERLAP,
     QCOW2_OPT_OVERLAP_TEMPLATE,
     QCOW2_OPT_OVERLAP_MAIN_HEADER,
@@ -734,6 +735,11 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "Do not unreference discarded clusters",
         },
+        {
+            .name = QCOW2_OPT_DISCARD_SUBCLUSTERS,
+            .type = QEMU_OPT_BOOL,
+            .help = "Allow subcluster aligned discard requests",
+        },
         {
             .name = QCOW2_OPT_OVERLAP,
             .type = QEMU_OPT_STRING,
@@ -978,6 +984,7 @@ typedef struct Qcow2ReopenState {
     int overlap_check;
     bool discard_passthrough[QCOW2_DISCARD_MAX];
     bool discard_no_unref;
+    bool discard_subclusters;
     uint64_t cache_clean_interval;
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
 } Qcow2ReopenState;
@@ -1157,6 +1164,16 @@ qcow2_update_options_prepare(BlockDriverState *bs, Qcow2ReopenState *r,
         goto fail;
     }
 
+    r->discard_subclusters =
+        qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_SUBCLUSTERS, false);
+    if (r->discard_subclusters && !has_subclusters(s)) {
+        error_setg(errp,
+                   "Image doesn't have extended L2 entries, but option "
+                   "'discard-subclusters' is enabled");
+        ret = -EINVAL;
+        goto fail;
+    }
+
     switch (s->crypt_method_header) {
     case QCOW_CRYPT_NONE:
         if (encryptfmt) {
@@ -1238,6 +1255,7 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
     }
 
     s->discard_no_unref = r->discard_no_unref;
+    s->discard_subclusters = r->discard_subclusters;
 
     if (s->cache_clean_interval != r->cache_clean_interval) {
         cache_clean_timer_del(bs);
@@ -1981,7 +1999,8 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
     bs->bl.pwrite_zeroes_alignment = s->subcluster_size;
-    bs->bl.pdiscard_alignment = s->subcluster_size;
+    bs->bl.pdiscard_alignment = s->discard_subclusters ?
+                                s->subcluster_size : s->cluster_size;
 }
 
 static int GRAPH_UNLOCKED
diff --git a/block/qcow2.h b/block/qcow2.h
index a65c185b51..4e91bdde3f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -134,6 +134,7 @@
 #define QCOW2_OPT_DISCARD_SNAPSHOT "pass-discard-snapshot"
 #define QCOW2_OPT_DISCARD_OTHER "pass-discard-other"
 #define QCOW2_OPT_DISCARD_NO_UNREF "discard-no-unref"
+#define QCOW2_OPT_DISCARD_SUBCLUSTERS "discard-subclusters"
 #define QCOW2_OPT_OVERLAP "overlap-check"
 #define QCOW2_OPT_OVERLAP_TEMPLATE "overlap-check.template"
 #define QCOW2_OPT_OVERLAP_MAIN_HEADER "overlap-check.main-header"
@@ -387,6 +388,7 @@ typedef struct BDRVQcow2State {
     bool discard_passthrough[QCOW2_DISCARD_MAX];
 
     bool discard_no_unref;
+    bool discard_subclusters;
 
     int overlap_check; /* bitmask of Qcow2MetadataOverlap values */
     bool signaled_corruption;
diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
index 8b80682cff..d7cf3c459b 100755
--- a/tests/qemu-iotests/271
+++ b/tests/qemu-iotests/271
@@ -100,13 +100,14 @@ _filter_trace_fallocate()
 #      discard  -> discard
 _run_test()
 {
-    unset c sc off len cmd opt
+    unset c sc off len cmd trace opt
     for var in "$@"; do eval "$var"; done
     case "${cmd:-write}" in
         zero)
             cmd="write -q -z";;
         unmap)
-            opt="--trace enable=file_do_fallocate"
+            trace="--trace enable=file_do_fallocate"
+            opt="-c reopen -o discard-subclusters=on"
             cmd="write -q -z -u";;
         compress)
             pat=$((${pat:-0} + 1))
@@ -115,7 +116,8 @@ _run_test()
             pat=$((${pat:-0} + 1))
             cmd="write -q -P ${pat}";;
         discard)
-            opt="--trace enable=file_do_fallocate"
+            trace="--trace enable=file_do_fallocate"
+            opt="-c reopen -o discard-subclusters=on"
             cmd="discard -q";;
         *)
             echo "Unknown option $cmd"
@@ -129,7 +131,7 @@ _run_test()
     cmd="$cmd ${offset} ${len}"
     raw_cmd=$(echo $cmd | sed s/-c//) # Raw images don't support -c
     echo $cmd | sed 's/-P [0-9][0-9]\?/-P PATTERN/'
-    $QEMU_IO $opt -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
+    $QEMU_IO $trace ${opt:+ "$opt"} -c "$cmd" "$TEST_IMG" 2>&1 | _filter_qemu_io | _filter_trace_fallocate
     $QEMU_IO -c "$raw_cmd" -f raw "$TEST_IMG.raw" | _filter_qemu_io
     _verify_img
     _verify_l2_bitmap "$c"
-- 
2.39.3


