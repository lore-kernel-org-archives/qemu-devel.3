Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1840C9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7V-0005uY-RJ; Tue, 29 Sep 2026 11:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7L-0005o0-0W
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:43 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7H-0001Rr-N2
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:42 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-488811c9ebaso2136553f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697098; x=1791301898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=hZwXKynwgCmIsIhPXvqlNsFlAZjUQEGq4DDgMjpJFCiZ6lsX30FTy+OzHpGi6v/TDe
 +3FWmMFXogSRU/MsWlV/DWtPtjbbcHbt1dF58nkY2PcaGwhnmhUkjy3SZBDHcWZVoWJ/
 RPPUNGM/eTxXDUPtE0aQXNucQ3uoZZ1sKLUkwFil8D17RGOpqxzLW3AST5PQSYAliBxw
 wI5FsErzaWhtJ1+ZJTQ93wcISUAN8FqZ66ouvPXtLDRfw0G1pjBVNrhGYAZDzMVUcu3P
 N1tajbUr6nHzlL30Bvd3h5qwOCupqqMAk7lH+h2pdDEG4HqIcdH7D3lYgwnKJ8dJcfw6
 72eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697098; x=1791301898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=2NV0HfbGdbApeAcgsRzFqh2brlaYXn5DD+dXDWf+7IsA0DjaPY/81cQ2OK4YzGSvZb
 qIsyDzLcvDuYo5NGVgCmT7XxvyV3BXxJcaJjNWdmGvkr63FK5ymipMqvIjXI9WyRwAwk
 dVZaz3hcHFKw7I96B9BauBkyS9TfXZVhrZxPzSXHBY+BSccFClsXEWmo7NsQ1SV/JFkI
 ENX7PchFbgiSu336tm4DwDcqKMZwiWoZ/6szJDGEdnjQoWbXKr9KX03t5wsIMTZW1XOY
 0dzEf0pCx4x7XuYQ9s+Nb/CsBR4lysbJSQcHZJ39HnJZsXtU+ugKbW1MX3G4SC1egxxC
 BR0w==
X-Gm-Message-State: AFq9FYIh9v2YRGpG68h64Dz32OvY8qtPOX+huqH7CPW9T0atFHZcsw3D
 LFxpYc+vVK47X2RcNGTLq8r4svDmv57ptMWc6hketfEQ6tAM6GxZH/Z4M1aUZC9HxogAx6v888N
 xrsd8
X-Gm-Gg: AYBFou0SX1H4MniBuiunu1obpRUgB9sofqpN3VvePEO3wO3UEmtYI0uxxSU7hMG+GyS
 1TcXh6DaesNAbzIFsf1inr8LfrSSnROJ/wJ6kZR9t2OS/b3S7DaA9t729Ux0Qdmy3VQJJOOGYCx
 GxGJPIO2XM4vJyX3Y6uG+aiZjWEMx2yyLW3FAUFWFv8j+9k+eUHGCVTgl2ttE4zPqY9Gczpimx0
 rQXo1q5biwiugPsWq4LhCeKngE42US1ae7SxHEySZw5pz/7gh49phr7kEisq+MbBB0j3hNSogJM
 m3C9Cl+Ul85QAHU78EOOhQQV6weIHy+7UJSPwI/+nFywJVHyrHzyDVHR/k4x8cz7DD+dfrKpW5G
 kvgLIA+2FObCdWo6IFmqF2MIE1+0f8ICXumjvFJbCaxJ1eBCqSPppLIXndsea6xDnuo8HLBPUGZ
 3JGlBKX6PIeZduKxNxiFff6U4IAfHfLHfiE9GS4HYxZnYHzK4WnqxlGOsekMY=
X-Received: by 2002:a5d:5d0c:0:b0:487:1f7:f506 with SMTP id
 ffacd0b85a97d-488835f2adamr25347759f8f.11.1790697098360; 
 Tue, 29 Sep 2026 08:51:38 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 5/9] block/block-copy: don't reserve memory for zero tasks
Date: Tue, 29 Sep 2026 17:51:21 +0200
Message-ID: <20260929155125.3151111-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f; envelope-from=den@openvz.org;
 helo=mail-wr2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

block_copy_dirty_clusters() charges task->req.bytes to the shared memory
pool for every task, but a COPY_WRITE_ZEROES task allocates no bounce
buffer, so there is nothing to account for. Add
block_copy_task_shres_bytes() and use it at all three call sites.

Zero tasks lose the throttling the pool gave them incidentally and are
bounded only by BLOCK_COPY_MAX_WORKERS (64).

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/block-copy.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 1826c2e1c7..21ebe8aec2 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -453,6 +453,11 @@ void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm)
     s->progress = pm;
 }
 
+static uint64_t block_copy_task_shres_bytes(BlockCopyTask *task)
+{
+    return task->method == COPY_WRITE_ZEROES ? 0 : task->req.bytes;
+}
+
 /*
  * Takes ownership of @task
  *
@@ -474,7 +479,7 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
 
     aio_task_pool_wait_slot(pool);
     if (aio_task_pool_status(pool) < 0) {
-        co_put_to_shres(task->s->mem, task->req.bytes);
+        co_put_to_shres(task->s->mem, block_copy_task_shres_bytes(task));
         block_copy_task_end(task, -ECANCELED);
         g_free(task);
         return -ECANCELED;
@@ -605,7 +610,7 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
             progress_work_done(s->progress, t->req.bytes);
         }
     }
-    co_put_to_shres(s->mem, t->req.bytes);
+    co_put_to_shres(s->mem, block_copy_task_shres_bytes(t));
     block_copy_task_end(t, ret);
 
     if (s->discard_source && ret == 0) {
@@ -816,7 +821,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_state)
 
         trace_block_copy_process(s, task->req.offset);
 
-        co_get_from_shres(s->mem, task->req.bytes);
+        co_get_from_shres(s->mem, block_copy_task_shres_bytes(task));
 
         offset = task_end(task);
         bytes = end - offset;
-- 
2.53.0


