Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCB9C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUru-0003qa-Hi; Mon, 24 Aug 2026 09:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrs-0003oD-9P
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:40 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrp-0002ax-HO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15cd3fd760so416124866b.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578656; x=1788183456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3aZMmyQcXUw8u2baSyqRnIYWSMubnlt40sgnbbIDHKE=;
 b=RzTieUe9jF2ZEXgQLiowbAu/ae22NExkAcVnEqMoj+nzSRGjroWpc2XV9q7NV9mtcz
 hM5lRJ8vSbeDf0Sh+/I+55gag1WAmf9TaZHLAvATXGabGohmYA/mYZEDTggwGG7ZcnWw
 yje7adlRo60+/B77IqJedR6SWEoWLMHKilecYleOH6FT0VuusRU7NHSfEycBGQA8YodV
 tdkKW+dOjgKqvHmKlj0XBbEu3eLnXOwNPRFKlLQVw9zD5soR91EkrpnIAtdxxFZ00664
 y66d0wsc54zIFewsq1M0ZohRDvENFs5A3jujotdxq4HOTy4ew4YWDGU/pwgAqiYF/zGx
 wk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578656; x=1788183456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3aZMmyQcXUw8u2baSyqRnIYWSMubnlt40sgnbbIDHKE=;
 b=pWonIvfEEEMTNs+A/VFDGqH+k0mVZoJPjyDISvfShu0A5YQ0m3tD/8nnS47pGfzjnE
 Dhi2/8wehJY8Rbh9HWZOWea/kINQguYrKfSmGdrkCh3oBDn97cQKhK8vmvvUC6FphGqP
 rYV6UUqlMpxHPRoc4lBz8PZyzdscHulhunRtG05djhLlZ9VDtA/KCbuvq/l4GmWDnahM
 BeeIKekYdObzYZiEYOXk0+mHUPoLRfBFDe+GXH+6vmR752bI9YHAEl/InjFjXlv6xVZC
 DcvPTtIDGbweyUTt1pL+RLrzHxzPHEjjX3CkKXvRMZ1Au2B7pSlfuuoi776R6u9QQkDR
 BzZQ==
X-Gm-Message-State: AFuF++nUPuqa8SFsYxgTStFPOK0fyBzGjkVP+ro4r19czH/HmSu4UoWj
 2sOwY8uaKicGduZTH8CoFPhfHwBN2naWS6osaFpK6o0ahjBiZcA3LqpliGxVLGSyvP4+EEOzMEB
 Qa1/e
X-Gm-Gg: AR+sD1377Hzu2hEH9yahGq0GOWGi49z+p+4KNPwa6J8Z8fxUp1lRKMyCJUXcw1IS3+M
 zfF9pHmRh7bjQIoShOXhF4Oz8aYo/WgkIvMWcGhf+kJAba26d2p4A4mCKzsP4/s6HLwYPwHzCQk
 mpIck4wBxC4vIpjhf18Ye2w+WXZGos24y/lnn29oErh0NUNS+mUETN3cmh5hb6ZE/69LXy0/TS9
 g6H2Ve/U+fVeuwQ3yumUgRkJtujLoXNiF4ZG0CsMUu1u7IHehfpfgRS8/Yp0F6aKnr01shWnA2w
 nwQP2lKxSioN0BJLLBH9uTA6BSbOmNjvb2XGB/mV2dI8Y77OwnTTp0+DO0ZvQWCB5fxOAqXppGB
 AY2WmA2TsYsQAQw7kw38eDrWV7jeFMlL79p+2WqI30iT/86hv1JTPFyoTskqLFBA5hDlC+Q1xVX
 4Zz/4GWpou6HLD2rnNCKxg/bcZWj1+UXNWnTEZ9dzgYZeP3ZIFUZ4pWT+W/xwhB8h2Ol4+
X-Received: by 2002:a17:907:845:b0:c20:fed2:898b with SMTP id
 a640c23a62f3a-c2492782dbemr1777435966b.23.1787578655928; 
 Mon, 24 Aug 2026 06:37:35 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:35 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 3/5] block: let bdrv_reopen_commit_post() report a failure
Date: Mon, 24 Aug 2026 15:37:27 +0200
Message-ID: <20260824133729.1141990-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
References: <20260824133729.1141990-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=den@openvz.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

The callback runs after bdrv_reopen_multiple() has committed the
transaction, so it cannot reject the reopen. It can still find that
the node it has just made writable is unusable, and has no way to say
so: bdrv_reopen() returns success and the caller carries on.

Give it a return value and an Error argument. The reopen stays
committed, the error only reports that the node is gone. Every queued
node still gets its callback, the first error is the one reported. A
callback may leave its node without a driver, and so may the I/O of a
later bdrv_reopen_prepare(), so do not assume that the nodes still
ahead of it in the queue have one. qcow2 is the only implementation and
does not fail yet.

An error therefore means one of two things now, either that the reopen
was denied and nothing changed, or that it went through and left a tree
which cannot be used. Nothing is undone in the second case: the node is
beyond repair by another reopen, and a caller which reacts to the error
by reopening anything is making it worse. bdrv_reopen_multiple() says
so, nothing else changes.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block.c                          | 24 +++++++++++++++++++++---
 block/qcow2.c                    |  4 +++-
 include/block/block_int-common.h |  9 +++++++--
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index e39f15816a..b29202c8d5 100644
--- a/block.c
+++ b/block.c
@@ -4582,6 +4582,10 @@ void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue)
  * If all devices prepare successfully, then the changes are committed
  * to all devices.
  *
+ * A failure means either that the reopen was denied and nothing changed,
+ * or that it went through and a driver then found the node unusable. In
+ * the second case nothing is undone and the tree is no longer usable.
+ *
  * All affected nodes must be drained between bdrv_reopen_queue() and
  * bdrv_reopen_multiple().
  *
@@ -4658,15 +4662,29 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     tran_commit(tran);
     bdrv_graph_wrunlock();
 
+    ret = 0;
     QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         BlockDriverState *bs = bs_entry->state.bs;
+        Error *local_err = NULL;
+        int commit_ret;
 
-        if (bs->drv->bdrv_reopen_commit_post) {
-            bs->drv->bdrv_reopen_commit_post(&bs_entry->state);
+        if (!bs->drv || !bs->drv->bdrv_reopen_commit_post) {
+            continue;
+        }
+
+        commit_ret = bs->drv->bdrv_reopen_commit_post(&bs_entry->state,
+                                                      &local_err);
+        assert(commit_ret >= 0 || local_err);
+
+        if (commit_ret < 0 && ret == 0) {
+            /* Committed already, so report the first failure and go on */
+            error_propagate(errp, local_err);
+            ret = commit_ret;
+        } else {
+            error_free(local_err);
         }
     }
 
-    ret = 0;
     goto cleanup;
 
 abort:
diff --git a/block/qcow2.c b/block/qcow2.c
index 1543255eba..553a94d003 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2145,7 +2145,7 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
     g_free(state->opaque);
 }
 
-static void qcow2_reopen_commit_post(BDRVReopenState *state)
+static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
 {
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
@@ -2163,6 +2163,8 @@ static void qcow2_reopen_commit_post(BDRVReopenState *state)
                               bdrv_get_node_name(state->bs));
         }
     }
+
+    return 0;
 }
 
 static void qcow2_reopen_abort(BDRVReopenState *state)
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..035e54d434 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -239,8 +239,13 @@ struct BlockDriver {
         BDRVReopenState *reopen_state, BlockReopenQueue *queue, Error **errp);
     void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit)(
         BDRVReopenState *reopen_state);
-    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
-        BDRVReopenState *reopen_state);
+    /*
+     * Runs once the reopen is committed, so it cannot reject it. Returns 0,
+     * or a negative errno with @errp set to report that the node it has
+     * just reopened is unusable, which it may leave without a driver.
+     */
+    int GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
+        BDRVReopenState *reopen_state, Error **errp);
     void GRAPH_UNLOCKED_PTR (*bdrv_reopen_abort)(
         BDRVReopenState *reopen_state);
     void (*bdrv_join_options)(QDict *options, QDict *old_options);
-- 
2.53.0


