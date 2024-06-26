Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA25DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTzF-0000qA-23; Wed, 26 Jun 2024 10:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTzB-0000oS-Oz; Wed, 26 Jun 2024 10:51:01 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMTz9-0005Uf-SV; Wed, 26 Jun 2024 10:51:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c16:1680:0:640:d42f:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 55F6B60F06;
 Wed, 26 Jun 2024 17:50:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id eoRt0i0IXKo0-4cjltysf; Wed, 26 Jun 2024 17:50:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719413455;
 bh=yjKIFn3IW3Wt3M76Ap6pQxfEulndCa+O/gp6BbNy0EY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZYE1WDhfPGfnGUVguhK8p5YsbAQ58RmxHrHtvN1pmx8d7Sn9iUcD9EsYWm67yogkZ
 +5yB24kwuCB+IfxNxx8B9dI+q25ObhGQz8uaF64DJzX55clq0EBJazu1GZA0mhTolF
 3Z4QbD8xHL2RIbCRQ+cMoYssH0f+BtKW4kOqX2bc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org,
 f.ebner@proxmox.com
Subject: [PATCH v2 3/3] block/backup: implement final flush
Date: Wed, 26 Jun 2024 17:50:38 +0300
Message-Id: <20240626145038.458709-4-vsementsov@yandex-team.ru>
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

Do this for backup job too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c             | 2 +-
 block/block-copy.c         | 7 +++++++
 include/block/block-copy.h | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/backup.c b/block/backup.c
index 3dd2e229d2..fee78ba5ad 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -156,7 +156,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
         job->bg_bcs_call = s = block_copy_async(job->bcs, 0,
                 QEMU_ALIGN_UP(job->len, job->cluster_size),
                 job->perf.max_workers, job->perf.max_chunk,
-                backup_block_copy_callback, job);
+                true, backup_block_copy_callback, job);
 
         while (!block_copy_call_finished(s) &&
                !job_is_cancelled(&job->common.job))
diff --git a/block/block-copy.c b/block/block-copy.c
index 7e3b378528..842b0383db 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -54,6 +54,7 @@ typedef struct BlockCopyCallState {
     int max_workers;
     int64_t max_chunk;
     bool ignore_ratelimit;
+    bool need_final_flush;
     BlockCopyAsyncCallbackFunc cb;
     void *cb_opaque;
     /* Coroutine where async block-copy is running */
@@ -899,6 +900,10 @@ block_copy_common(BlockCopyCallState *call_state)
          */
     } while (ret > 0 && !qatomic_read(&call_state->cancelled));
 
+    if (ret == 0 && call_state->need_final_flush) {
+        ret = bdrv_co_flush(s->target->bs);
+    }
+
     qatomic_store_release(&call_state->finished, true);
 
     if (call_state->cb) {
@@ -954,6 +959,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      int max_workers, int64_t max_chunk,
+                                     bool need_final_flush,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque)
 {
@@ -965,6 +971,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .bytes = bytes,
         .max_workers = max_workers,
         .max_chunk = max_chunk,
+        .need_final_flush = need_final_flush,
         .cb = cb,
         .cb_opaque = cb_opaque,
 
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index bdc703bacd..6588ebaf77 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -62,6 +62,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      int max_workers, int64_t max_chunk,
+                                     bool need_final_flush,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque);
 
-- 
2.34.1


