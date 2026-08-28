Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCA7C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqM-0002iZ-Ip; Fri, 28 Aug 2026 10:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqK-0002hc-Ln
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:08 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqH-0000fy-Uj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:08 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso7112925e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928364; x=1788533164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=lNmrEW1U3fxUQ2CfZ3PLHqzniWwI6yQiE/6C+o3KjM26PCdrdmgeEhobZgOPhXh2vY
 NVZi0jbcPJnOvE8Se8QabcGNmykvLJX+NjyCFaQIxbmuBPHtn19L/FqTTMgfIZxOo6hR
 0r/JoEI9xKbTQRe2UcWPlxde+7yFZKYfuWN0P8xJ/Yh6BlYX3bGqJIaVxc6wgIGsKsYq
 HPYeXPkd1SX/FY0Bz+4S6E/X+oXCnwAjSj0Aj/9ZOLGUTKABvuo++JeykyCfC15jGhpX
 vmNM8762pi37Thq8+lwoMKgjsalprnB5T4pkASS8XOyx2GwarA9p0ZukuUEvCuyKaV4f
 2npQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928364; x=1788533164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SJFEI1lQ8SXWXqcCjUVxKX69y0HMHBq5YIZK1wiDeeQ=;
 b=LG8xNNU/uWPRpfYWrrp2Qh9sOalDZd7s7vQRpqEC2xeqBe5Moifb44kLmkfgqLouCa
 tA2RcygTk67cofEFAhM/ZHPF/8gFswtb3i1jobh1jFP8JmSFJZ0N6j6YUzJN+gxShtHB
 57ksyQyDJv7tlzCoRqCcE7wq2D4agTUnlB4Xhdamxy/wzGoBt2/gfT+W7vA9GGXXf604
 f6Dttc94kSTrIIB55MQKrOF5tYvQ7XwefdaZly34bBwAGtSV3JgpXmLRuvHY0JGXyDrt
 HWN4cWBzfJGIJ3tjrv3oRMQEsQDQq+fQ1nc0+6GUo9IRF3xTw/51p39+LwluQwYivrd1
 PQMQ==
X-Gm-Message-State: AFuF++kxXf+kMdT4LlX6cHwjPpyvq7YmAPrDq2AJk6ulSW/o1ICMFEv6
 RFlQzh/KZdKIEcZr8mjWtBN2Pmvhg53ow0iI4iQWl3WrQSn03gQHzLpgbWXlK1TqADt3sUp+kAD
 XtU6c
X-Gm-Gg: AR+sD12KP52SFUPOLh2NbCib3sqnUYyA3YBWK/6WA3oh812gFUrET66z/1tGQFZy3oj
 N9ypRDTcqyCS+amblx62TzpenZijW9wNsH4txDCdTzJhtsub/brCee2LweekSJ2/JfoOKf6XbRl
 Z3V28Mtwl7rJOI8fLj1zzPKz5zZfl675qrBAHW3C2knd8SdDlcgGcx5FKbIrAdkBnd8GE3rV6e5
 zTP54lIwNnXlc/nb9RtUBJMIkcYE3uJCyanYS6GG9poCMzKOlC6fift+qSJN5RGG8mfBGz51gME
 AUphtwJcmIhu28AxaFDXXpUDxhd1zSKvLzCuD1d0/kQODFSUhOMmfebZmBQ6QW2mWTlD6H/UlMS
 aABchp+X/5YQD2zOwpQMcnWB6D+GfFMhG47Hv5MG7eB5XrCekaxquOMbAmlYj6PuJmaSZt76yE+
 MMxvDYvTPsE4XaQk1ANwGRUz7nbSZ/7ngIjVWnrbBx3dMwON/TzjYANMkVYg==
X-Received: by 2002:a05:600c:6748:b0:499:b65d:124f with SMTP id
 5b1f17b1804b1-49b91c57449mr123180105e9.11.1787928364171; 
 Fri, 28 Aug 2026 07:46:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 5/9] block/block-copy: don't reserve memory for zero tasks
Date: Fri, 28 Aug 2026 16:45:50 +0200
Message-ID: <20260828144554.1741910-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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


