Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB6FC88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x683p-0002ws-8H; Mon, 14 Sep 2026 10:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683P-0002e8-0D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x683L-0005nA-2G
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:53:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49e6e69d528so21683425e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789397581; x=1790002381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=aNqOaKUpja4u5utFO0hvDl3rz/EZQMk6KO3Avr4zN96456tVOosacL1Bd9ZYlcXhIr
 xTDNa7tTKdMKcewBlfiq085tE8XdYcvQQxt9RnE651Sq92ztz1DI4/2kBrmGDLFx5f1J
 tEUVVwwbYDqAPETHNbgx5cEGgIiv1uosJk+u0wj5es4oNQN5eA4KCyerJ94tzqLPM6C1
 yNHPv38pZiD3z4dktPbhM+IHtPdr+ByehyQtCvteuU4pe/ADlTboPESyrrctzJDlKTpQ
 3nLtgvbwrSpT5hEGimCdsp3Cm+FhztBTKvnyLCU6mJfe8GFRD3aLlJaXLgSYE4icUJbn
 hR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789397581; x=1790002381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=a5Wc/1f0qfUfPDRMgb+QWiDfcv/bNo7cHnzvNsA0ruqOm/bnL6ToArQWXbBv6xFcT/
 EU/HUsI7BagLxD4Dcdx+7nVsNQNrrn8hmo57nT7I9hs+TyAnuFjeBfkYux+zd2lVelnb
 7jJLuzzJObWMvcAGYcCmfIG+bZu3PJDBpwzA/rqUpOjU2kzos+m6imMFSUvRhbOmQl/M
 nQjXPY1nmbBzIk1VNPsc48SetqHdlcZCKD8h1qO2y7WXqTcy/UkQWplSQh0sym6XU8oe
 bHdV52iNXrrNyghQ4fgbQYyTKlN1Nx14iFlAMJeg2KnWBPrZq9XwdvVA5jSYazLxCKqr
 /J1A==
X-Gm-Message-State: AFuF++mn2h/uTjGUxTT3njSPniZWDTOUb27+3YUOU+LzWNGV+prSGMHF
 Hi81fiNv6hJBbZ7+YICMcxCAzFi4PJvr0TYYd3+gomLd3ypRCRajbeSw6d4tJrylvTYrRzR2bh0
 XcFor
X-Gm-Gg: AYBFou0FjiXazRzkDd7e8HIwRpf2Tnv4M3Ez3teFKYixP9puS6hWPlfjVFfYZdIcYjP
 6RezCUzMc3VF+64OBmO9apRa7a6avdN3WW2lFqnxvZ7b3t1uuRk8zfomhOODcFTyEMy6HFDNVpy
 LDS92wsxnPIMEMnJ02c6+cJO/IEQABBo7iKAvkNiK1j58g34/Z81UUOgrp9ntN8qkYHtLAXh8yW
 dG35+pylEeKIdZQHeBadmrk9ZAWL5pMoqNYXoNGqCUXw72UIGTEHeWBeMoECAQPOmstZyzCRyzG
 Rq6so1a9DkSZV08X3eWJdv3PKUKyCmsJoh+VyYSbu4TWytXmKnx2//aSTe4MTzWmlHbOtp8VHK4
 z0Jlay1ulM6Y9110RRNg4KqjxnARZRwJie8s6ZKGNYSx94eDYfWcdVMTcCrlX30tth6Ko5hTkAX
 Y86CXjyP2Gw18eU8I4cZT7X/VIzeADteELqh4k6W/8zcVpUgy/NCr0i15ey/leC+ixr6uT
X-Received: by 2002:a05:600c:1992:b0:49c:db20:da13 with SMTP id
 5b1f17b1804b1-49e7a65cecfmr37370525e9.5.1789397580744; 
 Mon, 14 Sep 2026 07:53:00 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:aec6:5a37:bc54:89b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e63c9a7c9sm540230595e9.13.2026.09.14.07.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:53:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 5/9] block/block-copy: don't reserve memory for zero tasks
Date: Mon, 14 Sep 2026 16:52:46 +0200
Message-ID: <20260914145250.2792879-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914145250.2792879-1-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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


