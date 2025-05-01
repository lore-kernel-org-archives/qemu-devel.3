Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A740C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 09:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAQAd-0006AD-Sw; Thu, 01 May 2025 05:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uAQAZ-00068w-Gg; Thu, 01 May 2025 05:25:27 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uAQAW-00054W-VJ; Thu, 01 May 2025 05:25:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a1d:0:640:a167:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E4485609D5;
 Thu,  1 May 2025 12:25:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b533::1:21])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id EPTMlH1FX0U0-u9gzxfkf; Thu, 01 May 2025 12:25:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1746091516;
 bh=sYotRo+Ah37n4F4X6wotrKuMaZmMSZbEF/oLv8iWpXI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Xp7jfZ9yrL8RZYOXBfOp+8OqUnw6e4k71SzkapnDiOUD2cfQY5CX4DAVQwbcbBOc+
 RDdCqd4IEjARmZgMojeqFRt5gv9W20l3rEF5CWdhpCExb0au0REocuL1YysW5vc951
 7jnNMiXaW74qDQ029akn4gXiPSBpNTSN5ItDu4q8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, stefanha@gmail.com,
 Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Subject: [PULL v2 3/8] block: refactor error handling of commit_iteration
Date: Thu,  1 May 2025 12:25:11 +0300
Message-ID: <20250501092511.24068-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250501092511.24068-1-vsementsov@yandex-team.ru>
References: <20250501092511.24068-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>

Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
Message-Id: <20241026163010.2865002-4-libvirt-e6954efa@volkihar.be>
[vsementsov]: move action declaration to the top of the function
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 63 ++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 3ee0ade7df..5c6596a52e 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -129,51 +129,60 @@ static void commit_clean(Job *job)
 }
 
 static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *n, void *buf)
+                            int64_t *requested_bytes, void *buf)
 {
+    BlockErrorAction action;
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
+
+fail:
+    action = block_job_error_action(&s->common, s->on_error,
+                                    error_in_source, -ret);
+    if (action == BLOCK_ERROR_ACTION_REPORT) {
+        return ret;
     }
 
+    *requested_bytes = 0;
+
     return 0;
 }
 
-- 
2.48.1


