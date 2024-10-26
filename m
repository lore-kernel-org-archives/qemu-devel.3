Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EB3D10C00
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 16:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4jhA-0007wt-Ux; Sat, 26 Oct 2024 12:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jgj-0007sh-SC; Sat, 26 Oct 2024 12:31:01 -0400
Received: from icts-p-cavuit-3.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1t4jge-0003c3-BZ; Sat, 26 Oct 2024 12:30:52 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: EF25620066.ADDCD
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:135:242:ac11:35])
 by icts-p-cavuit-3.kulnet.kuleuven.be (Postfix) with ESMTP id EF25620066;
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (236.58-240-81.adsl-dyn.isp.belgacom.be
 [81.240.58.236])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id D3D00D4F2584F; 
 Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 9C8004B91EE; Sat, 26 Oct 2024 18:30:37 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v4 3/5] block: refactor error handling of commit_iteration
Date: Sat, 26 Oct 2024 18:30:07 +0200
Message-ID: <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
References: <20241026163010.2865002-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:133;
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
 block/commit.c | 61 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 078e54f51f..5c24c8b80a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -129,51 +129,58 @@ static void commit_clean(Job *job)
 }
 
 static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *n, void *buf)
+                            int64_t *requested_bytes, void *buf)
 {
+    int64_t bytes = *requested_bytes;
     int ret = 0;
-    bool copy;
     bool error_in_source = true;
 
     /* Copy if allocated above the base */
     WITH_GRAPH_RDLOCK_GUARD() {
         ret = bdrv_co_common_block_status_above(blk_bs(s->top),
             s->base_overlay, true, true, offset, COMMIT_BUFFER_SIZE,
-            n, NULL, NULL, NULL);
+            &bytes, NULL, NULL, NULL);
     }
 
-    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
-    trace_commit_one_iteration(s, offset, *n, ret);
-    if (copy) {
-        assert(*n < SIZE_MAX);
+    trace_commit_one_iteration(s, offset, bytes, ret);
 
-        ret = blk_co_pread(s->top, offset, *n, buf, 0);
-        if (ret >= 0) {
-            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
-            if (ret < 0) {
-                error_in_source = false;
-            }
-        }
-    }
     if (ret < 0) {
-        BlockErrorAction action = block_job_error_action(&s->common,
-                                                         s->on_error,
-                                                         error_in_source,
-                                                         -ret);
-        if (action == BLOCK_ERROR_ACTION_REPORT) {
-            return ret;
-        } else {
-            *n = 0;
-            return 0;
+        goto fail;
+    }
+
+    if (ret & BDRV_BLOCK_ALLOCATED) {
+        assert(bytes < SIZE_MAX);
+
+        ret = blk_co_pread(s->top, offset, bytes, buf, 0);
+        if (ret < 0) {
+            goto fail;
         }
+
+        ret = blk_co_pwrite(s->base, offset, bytes, buf, 0);
+        if (ret < 0) {
+            error_in_source = false;
+            goto fail;
+        }
+
+        block_job_ratelimit_processed_bytes(&s->common, bytes);
     }
+
     /* Publish progress */
-    job_progress_update(&s->common.job, *n);
 
-    if (copy) {
-        block_job_ratelimit_processed_bytes(&s->common, *n);
+    job_progress_update(&s->common.job, bytes);
+
+    *requested_bytes = bytes;
+
+    return 0;
+fail:;
+    BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
+                                                     error_in_source, -ret);
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return ret;
     }
 
+    *requested_bytes = 0;
+
     return 0;
 }
 
-- 
2.44.1


