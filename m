Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F1BCA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sklWJ-0002TA-DT; Sun, 01 Sep 2024 10:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sklWE-0002E5-Kk; Sun, 01 Sep 2024 10:25:30 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be ([2a02:2c40:0:c0::25:132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <libvirt-e6954efa@volkihar.be>)
 id 1sklWC-0003Xd-BI; Sun, 01 Sep 2024 10:25:30 -0400
X-KULeuven-Envelope-From: libvirt-e6954efa@volkihar.be
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: DC24120078.AA034
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be
 (icts-p-ceifnet-smtps.service.icts.svcd
 [IPv6:2a02:2c40:0:51:130:242:ac11:10])
 by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id DC24120078;
 Sun,  1 Sep 2024 16:25:21 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: 
X-CAV-Cluster: smtps
Received: from flutterbat.volkihar.be (unknown
 [IPv6:2a02:a03f:8ada:7900:da25:11b6:eb0b:9b9d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id C3DB8D4F7A27F; 
 Sun,  1 Sep 2024 16:25:21 +0200 (CEST)
Received: by flutterbat.volkihar.be (Postfix, from userid 1000)
 id 902C716E1C0; Sun, 01 Sep 2024 16:25:21 +0200 (CEST)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PATCH v3 3/5] block: refactor error handling of commit_iteration
Date: Sun,  1 Sep 2024 16:24:03 +0200
Message-ID: <20240901142405.3183874-4-libvirt-e6954efa@volkihar.be>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
References: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2c40:0:c0::25:132;
 envelope-from=libvirt-e6954efa@volkihar.be;
 helo=icts-p-cavuit-1.kulnet.kuleuven.be
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 block/commit.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 9eedd1fa47..288e413be3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -130,7 +130,6 @@ static void commit_clean(Job *job)
 
 static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void *buf) {
     int ret = 0;
-    bool copy;
     bool error_in_source = true;
 
     /* Copy if allocated above the base */
@@ -140,19 +139,34 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void
             n, NULL, NULL, NULL);
     }
 
-    copy = (ret >= 0 && ret & BDRV_BLOCK_ALLOCATED);
+    if (ret < 0) {
+        goto handle_error;
+    }
+
     trace_commit_one_iteration(s, offset, *n, ret);
-    if (copy) {
+
+    if (ret & BDRV_BLOCK_ALLOCATED) {
         assert(*n < SIZE_MAX);
 
         ret = blk_co_pread(s->top, offset, *n, buf, 0);
-        if (ret >= 0) {
-            ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
-            if (ret < 0) {
-                error_in_source = false;
-            }
+        if (ret < 0) {
+            goto handle_error;
         }
+
+        ret = blk_co_pwrite(s->base, offset, *n, buf, 0);
+        if (ret < 0) {
+            error_in_source = false;
+            goto handle_error;
+        }
+
+        block_job_ratelimit_processed_bytes(&s->common, *n);
     }
+
+    /* Publish progress */
+
+    job_progress_update(&s->common.job, *n);
+
+handle_error:
     if (ret < 0) {
         BlockErrorAction action = block_job_error_action(&s->common, s->on_error,
                                                          error_in_source, -ret);
@@ -160,15 +174,8 @@ static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void
             return ret;
         } else {
             *n = 0;
-            return 0;
         }
     }
-    /* Publish progress */
-    job_progress_update(&s->common.job, *n);
-
-    if (copy) {
-        block_job_ratelimit_processed_bytes(&s->common, *n);
-    }
 
     return 0;
 }
-- 
2.44.1


