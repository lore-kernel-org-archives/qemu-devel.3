Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6643BCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW6-0007oW-LC; Wed, 30 Sep 2026 12:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVh-0006eq-T7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:30 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVb-0003Yl-8n
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:25 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso51985435e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787018; x=1791391818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VbF2v5R4oT26b8Dj57rPb9AkdXwY59tdRR55Q6yPNA4=;
 b=QzWP+DmMMon/rmV4KjdgrgqRNBy0cVl69RQT/zrhNQioS7ZfdGA22XhzYOjABAfQr+
 ccQ9DqAIxFpG5pcaJ6hZoPmh4S2Lxy2PjTiDNfXPDNhq/YKdzHZD2Ag4NRQ+jLDDzwwF
 MhMRAq9UqXpmd4bnPd8LVkMxdQz3IasMSZAFQDDLtogteysr7TlwKl+5F6z30sehYpOk
 b38Ga5cVUjotbSDkTQiAG2fuWoZisLgz39jU+9tHbZOlcxuJNYxkktAHdf23Ks+CCsqV
 hfDIQ19DAcOKpAFXHWdmfAM7AHtyGkQT7+StqTPANGTkN+moo+X4jBGknvcl2d+aEnl+
 rgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787018; x=1791391818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VbF2v5R4oT26b8Dj57rPb9AkdXwY59tdRR55Q6yPNA4=;
 b=gCXmLm3qlmywsoep6ha+j6WrAkMeovzTz9RDZcHfuSe7UUXKBygx6TBNry6ubtHUGk
 faZQiVemhQ/+po2esMpYw5YTmZUsJulOXR/CrwtWkXKX1dRukGLOHAHxlLTnCJnYWqYv
 ok8VpOabl6w42GajBz+aUI8vCbBbolNrcPp3lRnGlCOe72gFxNYHHe3bzw13ztmM+v6W
 UsFq7etYA9kUFlT2GpqCGhhir3VZ3y4m9S9i+3O2mCOUo1F9+fkzTzlLvD+AXG6Ylvgz
 XDtNqwcq1NkDmbelleG7W7Mj9QsVwHVevy+D6kcSXgZNYPplow7IEsHAWjLso0lS4klU
 OJHw==
X-Gm-Message-State: AFuF++kL70CFhnq2FIHWUytDIHws0JL9YNK/eSFtiOSfOZNe/x6EKc9N
 y1JMwNlhgOyKYI7X2HtETUMeNjp39N77Mz7Srm4Y+Ene7J59xS7gy139sdEqlV0KykdA2ap84wr
 FZ4lz
X-Gm-Gg: AYBFou0K3i3v13oanj7RI3ImuD2tCexEC8uPeasxaK9DPRMPJtg0Wc9wdfWEYHv8+ri
 sQt2HD/+Cm8/u8Lxo9SiNyyqLc88TgkoOs/RI8iLQIt+uTmf8fKL0HvBMCZeqjzg9W8CEpNcbP4
 vsWGE+vU8Iy8RBTtTztWS5cEBfojeAWliZoH9zGNTANA6dUGodlhQDa7MU4TU9CgLndBNwwv12+
 Ncc+8vee2Y2eo5t2NhWpmlY0PGD1dWLbs8BbPsV3HSLuOlpmFDTag6nqjkm4Sv/YcnTEqM3ub76
 +eI2xFxL9Fe9N4Gb/Nm74uyHMmeXIqqOzJLbDyddWswOzeIBLV90X+CZxsTC+TYFuoi96mA/+lt
 x0SZcbs8FJH75fTiL6Y2YSLpgjR7kNwx2aDbzZcQOKplT1ILTQYAnZeK3LOjMIa+0GUY4DqSwlR
 xRhdXw0o4h8Velat2KoGoXMuNgazGzgW3eU0JnZZJDgEcAcHtfsjb/A7wC+1jrOctt5joYc2pzs
 ElIQg==
X-Received: by 2002:a05:600c:800e:b0:4a0:12d6:33b6 with SMTP id
 5b1f17b1804b1-4a01afe84f4mr35941475e9.8.1790787017672; 
 Wed, 30 Sep 2026 09:50:17 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 11/13] block/blkdebug: make a breakpoint work across
 AioContexts
Date: Wed, 30 Sep 2026 18:49:57 +0200
Message-ID: <20260930165000.303236-12-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

A request that stops at a breakpoint belongs to whichever AioContext
issued it, and the monitor or qemu-io that resumes it runs somewhere
else. Two things go wrong once those are not the same thread.

resume_req_by_tag() woke the request with qemu_coroutine_enter(), which
enters the coroutine on the caller's thread. That moves the request off
its own thread for the rest of its life, and it aborts outright when it
wins the race against the yield, because the request is published to
the list before the coroutine gets there.

wait_break polled the block backend's AioContext, where the event will
never arrive, so it slept through the suspension it was waiting for.

Wake the request in the context it came from and wait for it the way
the rest of the block layer waits across contexts. Where the two
contexts are the same the coroutine is still entered directly, so
single-threaded behaviour, and the output tests depending on it, do not
change.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/blkdebug.c | 3 ++-
 qemu-io-cmds.c   | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 78cc03746f..1522015b34 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -813,6 +813,7 @@ static void suspend_request(BlockDriverState *bs, BlkdebugRule *rule)
 
     remove_rule(rule);
     QLIST_INSERT_HEAD(&s->suspended_reqs, r, next);
+    aio_wait_kick();
 
     if (!qtest_enabled()) {
         printf("blkdebug: Suspended request '%s'\n", r->tag);
@@ -925,7 +926,7 @@ retry:
             g_free(r);
 
             qemu_mutex_unlock(&s->lock);
-            qemu_coroutine_enter(co);
+            aio_co_wake(co);
             qemu_mutex_lock(&s->lock);
 
             if (all) {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index ce5bb53f4e..eed39ab93c 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2791,9 +2791,8 @@ static const cmdinfo_t resume_cmd = {
 
 static int wait_break_f(BlockBackend *blk, int argc, char **argv, Error **errp)
 {
-    while (!bdrv_debug_is_suspended(blk_bs(blk), argv[1])) {
-        aio_poll(blk_get_aio_context(blk), true);
-    }
+    AIO_WAIT_WHILE_UNLOCKED(NULL,
+                            !bdrv_debug_is_suspended(blk_bs(blk), argv[1]));
     return 0;
 }
 
-- 
2.53.0


