Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99B8C25B78
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 20:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBKU7-00054N-7G; Sun, 26 May 2024 16:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sBJZF-0007Cq-Rr; Sun, 26 May 2024 15:30:06 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be ([134.58.240.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sBJZB-0004iD-Id; Sun, 26 May 2024 15:30:03 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 6A8952005B.AC773
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:133:242:ac11:42])
 by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 6A8952005B;
 Sun, 26 May 2024 21:29:55 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:dd0a:a068:3e21:22de])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 46CA6D4E60C0E; 
 Sun, 26 May 2024 21:29:55 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 04D002822F6; Sun, 26 May 2024 21:29:55 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH 1/2] block: allow commit to unmap zero blocks
Date: Sun, 26 May 2024 21:29:16 +0200
Message-ID: <20240526192918.3503128-2-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240526192918.3503128-1-libvirt-e6954efa@volkihar.be>
References: <20240526192918.3503128-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.58.240.132;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-1.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 May 2024 16:28:49 -0400
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

Non-active block commits do not discard blocks only containing zeros,
causing images to lose sparseness after the commit. This commit fixes
that by writing zero blocks using blk_co_pwrite_zeroes rather than
writing them out as any oother arbitrary data.

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
---
 block/commit.c | 71 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 13 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 7c3fdcb0ca..5bd97b5a74 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -12,9 +12,13 @@
  *
  */
 
+#include "bits/time.h"
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
+#include "time.h"
 #include "trace.h"
+#include "block/block-common.h"
+#include "block/coroutines.h"
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
@@ -126,6 +130,12 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
+typedef enum CommitMethod {
+    COMMIT_METHOD_COPY,
+    COMMIT_METHOD_ZERO,
+    COMMIT_METHOD_IGNORE,
+} CommitMethod;
+
 static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
@@ -156,8 +166,9 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
 
     for (offset = 0; offset < len; offset += n) {
-        bool copy;
         bool error_in_source = true;
+        CommitMethod commit_method = COMMIT_METHOD_COPY;
+
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -167,21 +178,54 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             break;
         }
         /* Copy if allocated above the base */
-        ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
-                                        offset, COMMIT_BUFFER_SIZE, &n);
-        copy = (ret > 0);
+        WITH_GRAPH_RDLOCK_GUARD() {
+            ret = bdrv_co_common_block_status_above(blk_bs(s->top),
+                s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
+                &n, NULL, NULL, NULL);
+        }
+
         trace_commit_one_iteration(s, offset, n, ret);
-        if (copy) {
-            assert(n < SIZE_MAX);
-
-            ret = blk_co_pread(s->top, offset, n, buf, 0);
-            if (ret >= 0) {
-                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
-                if (ret < 0) {
-                    error_in_source = false;
+
+        if (ret >= 0 && !(ret & BDRV_BLOCK_ALLOCATED)) {
+            commit_method = COMMIT_METHOD_IGNORE;
+        } else if (ret >= 0 && ret & BDRV_BLOCK_ZERO) {
+            int64_t target_offset;
+            int64_t target_bytes;
+            WITH_GRAPH_RDLOCK_GUARD() {
+                bdrv_round_to_subclusters(s->base_bs, offset, n,
+                                       &target_offset, &target_bytes);
+            }
+
+            if (target_offset == offset &&
+                target_bytes == n) {
+                commit_method = COMMIT_METHOD_ZERO;
+            }
+        }
+
+        if (ret >= 0) {
+            switch (commit_method) {
+            case COMMIT_METHOD_COPY:
+                assert(n < SIZE_MAX);
+                ret = blk_co_pread(s->top, offset, n, buf, 0);
+                if (ret >= 0) {
+                    ret = blk_co_pwrite(s->base, offset, n, buf, 0);
+                    if (ret < 0) {
+                        error_in_source = false;
+                    }
                 }
+                break;
+            case COMMIT_METHOD_ZERO:
+                ret = blk_co_pwrite_zeroes(s->base, offset, n,
+                    BDRV_REQ_MAY_UNMAP);
+                error_in_source = false;
+                break;
+            case COMMIT_METHOD_IGNORE:
+                break;
+            default:
+                abort();
             }
         }
+
         if (ret < 0) {
             BlockErrorAction action =
                 block_job_error_action(&s->common, s->on_error,
@@ -193,10 +237,11 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
                 continue;
             }
         }
+
         /* Publish progress */
         job_progress_update(&s->common.job, n);
 
-        if (copy) {
+        if (commit_method == COMMIT_METHOD_COPY) {
             block_job_ratelimit_processed_bytes(&s->common, n);
         }
     }
-- 
2.42.0


