Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D144C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTzF-0000qB-24; Wed, 26 Jun 2024 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTzD-0000p8-8P; Wed, 26 Jun 2024 10:51:03 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTz9-0005UF-NT; Wed, 26 Jun 2024 10:51:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A513260D92;
 Wed, 26 Jun 2024 17:50:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eoRt0i0IXKo0-ps725Jpk; Wed, 26 Jun 2024 17:50:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719413453;
 bh=6YFkVEVHcdtg+ey8WHEMcbq0FjjptYTHFhCj9XTAgY4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ndXFqpfOQCzCcHp48F6hRTm5gqRg/95XpfOcLm7MLjdusk2OYp4saQc6/1cAGEosE
 3o1PWHb9fWwWXdeLREi7GIMSTH8j/66IlOjsHh5lPJr2kwhNbxARdPnFXKgrwGEwaF
 HBoGXFk3uc2miMA/4ngxLCWBdVe0AEVH6QnrgMcE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 1/3] block/commit: implement final flush
Date: Wed, 26 Jun 2024 17:50:36 +0300
Message-Id: <20240626145038.458709-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626145038.458709-1-vsementsov@yandex-team.ru>
References: <20240626145038.458709-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Actually block job is not completed without the final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Mirror job already has mirror_flush() for this. So, it's OK.

Do this for commit job too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/commit.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 7c3fdcb0ca..81971692a2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -134,6 +134,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
     int64_t len, base_len;
+    bool need_final_flush = true;
 
     len = blk_co_getlength(s->top);
     if (len < 0) {
@@ -155,8 +156,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
 
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);
 
-    for (offset = 0; offset < len; offset += n) {
-        bool copy;
+    for (offset = 0; offset < len || need_final_flush; offset += n) {
+        bool copy = false;
         bool error_in_source = true;
 
         /* Note that even when no rate limit is applied we need to yield
@@ -166,22 +167,34 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
-        /* Copy if allocated above the base */
-        ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
-                                        offset, COMMIT_BUFFER_SIZE, &n);
-        copy = (ret > 0);
-        trace_commit_one_iteration(s, offset, n, ret);
-        if (copy) {
-            assert(n < SIZE_MAX);
 
-            ret = blk_co_pread(s->top, offset, n, buf, 0);
-            if (ret >= 0) {
-                ret = blk_co_pwrite(s->base, offset, n, buf, 0);
-                if (ret < 0) {
-                    error_in_source = false;
+        if (offset < len) {
+            /* Copy if allocated above the base */
+            ret = blk_co_is_allocated_above(s->top, s->base_overlay, true,
+                                            offset, COMMIT_BUFFER_SIZE, &n);
+            copy = (ret > 0);
+            trace_commit_one_iteration(s, offset, n, ret);
+            if (copy) {
+                assert(n < SIZE_MAX);
+
+                ret = blk_co_pread(s->top, offset, n, buf, 0);
+                if (ret >= 0) {
+                    ret = blk_co_pwrite(s->base, offset, n, buf, 0);
+                    if (ret < 0) {
+                        error_in_source = false;
+                    }
                 }
             }
+        } else {
+            assert(need_final_flush);
+            ret = blk_co_flush(s->base);
+            if (ret < 0) {
+                error_in_source = false;
+            } else {
+                need_final_flush = false;
+            }
         }
+
         if (ret < 0) {
             BlockErrorAction action =
                 block_job_error_action(&s->common, s->on_error,
-- 
2.34.1


