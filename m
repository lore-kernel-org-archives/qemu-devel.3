Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65E9C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf3q-00049a-2G; Wed, 19 Aug 2026 08:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3j-00046c-9h
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3d-0007qS-4n
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:16 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso4850875e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787141166; x=1787745966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lUGQaUR+CLxPkQrQ5gkup6JnciUavYiHeppLJtzEdQE=;
 b=i/0BHDwImWyLGxiDE1R9plYiufwsI5b43Uijzvq5EV8sUnx1pLivCqiJsb2C6uus3W
 BVjzACGl5AUYTfU4fpIiT9wgiXrD8wd+xq5dyqYu5dewvD0sYyEQLT8m6DYknPj47QCI
 tFrdzuiLx6NyZqi9gVgoUSOG8xV15WCgdLbyDVNqnoFA+AmU7ltcZu6+LtLID7MXInCG
 AVEYEXl9XvogbCvmdOMIj/XPJQWBbXssZcB//5fnkugm7vfs7CyaziIsItAol2qr/dqa
 csWju1gYodEB7LRtb6yoyDgTtuKycj7agGqDZ1vICLZOr9cmQEKGf4kSOkQDryw1+VWc
 Y1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141166; x=1787745966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lUGQaUR+CLxPkQrQ5gkup6JnciUavYiHeppLJtzEdQE=;
 b=p57W7wuofVsAlWfGiZGbD75DkaoJYIvIVqgMYqgGqMUee4BFRKZK25of7xqBgIxrBa
 SXxSnDGAfAH6jQBvVlnxNOtIeTA4aihjrx6bs0H4dqQVmvE/NHSNXj8WftC/f/cU4By2
 e/FyYwuvCq4HQplQgQsL7lz4UMKkCGQiCL6LSSI/CffokB5LMNwZY/N9WZMJgf6JeSBA
 dADNRU1FUGfxcqlh/BNDXTHrci1GzBlqHgkoChqtIQ/3mehXC+dSwy6spVLN4GRvGQHb
 DfIdUg3MEuvnTZW70uDEpyZ4nDTbnFeJhs/p1DWwvm+67UKWCnj6RCqpJk2AMiKWT9Cl
 2BOg==
X-Gm-Message-State: AOJu0YygGpLK5A2KMYs8190vKCcZsZcjxzf3sdvfsp3WVm4yiXyhQTPg
 haLUjh+EtyPix66zmbhovobYrDcrs4WJrgH2NQRm0QnNgwBhjLRr/sAHg2sdLkpqvo1nEueemRA
 zZJs2
X-Gm-Gg: AR+sD120dNO7DoNyjgw8jRZg40ssBQprxhFsUzxErwUK/AUBX/Y6wPtyZc3WZuV0TY+
 6I14Go40PlAaPL0EcfiJyLJceKiHnVheB5LZCJojk5lCv8x+w4hKiMPIAwZiaEg73BjF3vMdMzs
 uL+AyLqwpNwtXPZP+w+iLqpcpgKvbqmwFpl7XP2PGykLkmNLYGHhZO0IjQ/Ukzb5DhTfJrsqXP0
 +Oit2vrHpuBccreOVdb45oBTamJ1W+G3LYKqdW9GxXYSk+HG+7d5Vat4PlpR6A/X6V8xN3N+wG3
 gxNoaNL6NNiEhCSrt69iYC8uIHDJA/lpXX4CzkmGpP/fi3KnwBvo1ExpVPGYpl1uVmhacPwdP7h
 zW88kVHblunuYLWOE31HC5/FHAHd35kCpzr1Fa5Gw9pZ7X6PA0Ww3+EGKQY/NLspJ7M4tcLQtUz
 uQ38exZkA+mN49pU+HIBuwBLQD6XPslnTaKgdjCvNn7M+juZdff7lfnsVPmA==
X-Received: by 2002:a05:600c:8b27:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499aa16a958mr87712855e9.8.1787141165724; 
 Wed, 19 Aug 2026 05:06:05 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:258d:1706:7089:f765])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm59244785e9.6.2026.08.19.05.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:06:05 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 3/5] block: let bdrv_reopen_commit_post() report a failure
Date: Wed, 19 Aug 2026 14:05:56 +0200
Message-ID: <20260819120558.3870413-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819120558.3870413-1-den@openvz.org>
References: <20260819120558.3870413-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
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
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
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


