Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE05C3DA42
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2024 22:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSkmi-0002wk-IY; Sat, 13 Jul 2024 18:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sSkma-0002nB-NY; Sat, 13 Jul 2024 17:59:56 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be ([134.58.240.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sSkmU-000793-Ve; Sat, 13 Jul 2024 17:59:54 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 3506220067.A0C08
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:131:242:ac11:48])
 by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id 3506220067;
 Sat, 13 Jul 2024 23:59:39 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 1BB8CD4EDC7F4; 
 Sat, 13 Jul 2024 23:59:39 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id D521B71CBC2; Sat, 13 Jul 2024 23:59:38 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v2 2/4] block: refactor commit_run for multiple write types
Date: Sat, 13 Jul 2024 23:56:42 +0200
Message-ID: <20240713215644.742244-3-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
References: <20240713215644.742244-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.58.240.133;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-3.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
---
 block/commit.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 8dee25b313..fb54fc9560 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -128,6 +128,11 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
+typedef enum CommitMethod {
+    COMMIT_METHOD_COPY,
+    COMMIT_METHOD_IGNORE,
+} CommitMethod;
+
 static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
@@ -158,8 +163,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
 
     for (offset = 0; offset < len; offset += n) {
-        bool copy;
         bool error_in_source = true;
+        CommitMethod commit_method = COMMIT_METHOD_COPY;
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -175,19 +180,31 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
                 &n, NULL, NULL, NULL);
         }
 
-        copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
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
+        if (ret >= 0) {
+            if (!(ret & BDRV_BLOCK_ALLOCATED)) {
+                commit_method = COMMIT_METHOD_IGNORE;
+            }
+
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
@@ -202,7 +219,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         /* Publish progress */
         job_progress_update(&s->common.job, n);
 
-        if (copy) {
+        if (commit_method == COMMIT_METHOD_COPY) {
             block_job_ratelimit_processed_bytes(&s->common, n);
         }
     }
-- 
2.44.1


