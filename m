Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191C6CCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8y-0006BO-G1; Mon, 10 Nov 2025 10:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8v-00068w-7x
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8t-0000sG-Jo
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jiylzld/JnerlFQ/PfscPcvSJTjubgAWnA1rA/xzymA=;
 b=fu34WK6pGZEsgjvHiESpifIh2Nn69Pj4G2bmc86yV+xA7OcTGAnQOpGYym8aiI/B6V8l8D
 fKXxWGsfEeBqtl4ai5nw9KgwRnJEWe7sktOmuP5bCWVFU3DI7ax1ph1+U/5gdCgJizgYjR
 q7qkSXJIHU5PA1G+bPao+1i9dweM9TQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-q8a_SLFzOxumsuVa3KvpOQ-1; Mon, 10 Nov 2025 10:49:17 -0500
X-MC-Unique: q8a_SLFzOxumsuVa3KvpOQ-1
X-Mimecast-MFC-AGG-ID: q8a_SLFzOxumsuVa3KvpOQ_1762789756
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso24246465e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789756; x=1763394556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jiylzld/JnerlFQ/PfscPcvSJTjubgAWnA1rA/xzymA=;
 b=krM5Bo8GVg52iLoa557K57glXqm42YHkiSUAisE+2/WQ48zV7qhuXzT3EchjEiVmiV
 cjRrQXMO4DZdRP3a2urK/7D/As53gO76Fl2ovAS+KqvsNdWqIRuAaZ9ulgcxQ/kvTPpL
 fBkAnOvJ8ythv4XAZkHGn5xxD6hIWGJFZq5uHAA+l7zUkta/5a/L4zwB85w7jxJRk+e8
 StaIDg6xjnDNOsKDoAzO02YqpcPrVs3UoVUpERbzzkRcqYHOWMWbmk1aDcmawlkePO5V
 iWrT11tK9b0cwNW+VvyLu5Av5C3BsRABdr/HzjkhI7tGZkDW8q45tsHEeo+NK5hf58Sc
 tP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789756; x=1763394556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jiylzld/JnerlFQ/PfscPcvSJTjubgAWnA1rA/xzymA=;
 b=OrGbSjnE7qIev0M0riJBYEMYP/v1nEXCLxu2lMcejyBjrOsWtL1O4FgCTViBrCKKOU
 z8aIff/oIB+h5u2kYea3ORbw3fjb2pzDaXR9+wyq5LBe6EVtLwTJdB9nM4Ui1ObuzphT
 rVFvffW8lztpXTKcgW9e/NmLbb2sYPGupzNvHt7Og3TS3XcxGw6vCEdUvwVey2svwtqX
 Ig0NUNC1ZRYGCF1q/kDBHRLjArhlVArmoWCm7k406fhHjMtIdwYWqSS8X4K7DK3cXoIY
 CbK///MnBkwXkw7qtcglAbfrM8SoewzJwKiv4Z/FL9rISccbYykbhgx7F4/KLYTTiXxC
 Y2XA==
X-Gm-Message-State: AOJu0YwWmUAlPK4Uvr0kEIauXOiA73bYIuSBKd5mPLE22tOGnfne6loK
 +O5i4GlC7DLyxMEu4A5/fS/0GpfFmo4mBQJR+FtDsOkJWNkB0TaVqZ/F6NKRexZQVXi/g7Cnqp3
 2xDjx2EVVIt8vw9KLz5K+xRr5ZXmlNvWPQO6rCcG/J+6teNLmgf1rRIMA
X-Gm-Gg: ASbGncs/TAIFz+5ucdFW690qtJnzaLzPX6B3IhAiPFvqRmgiouEk7SGITI9y2raACyE
 6wRO8hIgz9PmxbAS+EHhy6eEHIGchOVBCo4xL5nkCj4/bglzlrH+qwMh3aYIkn8S5mS5fvVXekX
 kmUrbyhDYwOrq8aKREqFOMj+LJUKgO7U1/eg1shWO2BkkcQSoznops5AJD3zpB/Jvw34MzOkGHp
 xzo4kkvdMpGBDykLIeKcU+84C8cYWzQPnL3lSoZiDVEJu5wfZs+NtCGODeTQfxxnowCcBe2Ed2o
 aJguDkG2bvOIFal9/8DTdBzG1QA+YfPa05L3BqKngiGksGsu9OCMcDgbGZYk5Z8Gn0tkfs1/N/T
 oDRIbhp9SkBkAhWxnshWd8A6fZbDaG8+7cp39qMdoIS8zCG0lMfN7eixjQQ==
X-Received: by 2002:a05:600c:a41:b0:471:21:554a with SMTP id
 5b1f17b1804b1-47773230acbmr76520645e9.13.1762789756249; 
 Mon, 10 Nov 2025 07:49:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH8mNsh0WnwQPic/UOrROnpqliRAe6zcHzdNEEsnLJGlhpXjHQWASX5GhNEZF2Snqzfc7N7A==
X-Received: by 2002:a05:600c:a41:b0:471:21:554a with SMTP id
 5b1f17b1804b1-47773230acbmr76520425e9.13.1762789755848; 
 Mon, 10 Nov 2025 07:49:15 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47775e9c6c7sm63881105e9.2.2025.11.10.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:14 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 04/19] =?UTF-8?q?nfs:=20Run=20co=20BH=20CB=20in=20the?=
 =?UTF-8?q?=20coroutine=E2=80=99s=20AioContext?=
Date: Mon, 10 Nov 2025 16:48:39 +0100
Message-ID: <20251110154854.151484-5-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Like in “rbd: Run co BH CB in the coroutine’s AioContext”, drop the
completion flag, yield exactly once, and run the BH in the coroutine’s
AioContext.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (!task.complete)` loops.)

Like in “iscsi: Run co BH CB in the coroutine’s AioContext”, this makes
nfs_co_generic_bh_cb() trivial, so we can drop it in favor of just
calling aio_co_wake() directly.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/nfs.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index 0a7d38db09..1d3a34a30c 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -69,7 +69,6 @@ typedef struct NFSClient {
 typedef struct NFSRPC {
     BlockDriverState *bs;
     int ret;
-    int complete;
     QEMUIOVector *iov;
     struct stat *st;
     Coroutine *co;
@@ -230,14 +229,6 @@ static void coroutine_fn nfs_co_init_task(BlockDriverState *bs, NFSRPC *task)
     };
 }
 
-static void nfs_co_generic_bh_cb(void *opaque)
-{
-    NFSRPC *task = opaque;
-
-    task->complete = 1;
-    aio_co_wake(task->co);
-}
-
 /* Called (via nfs_service) with QemuMutex held.  */
 static void
 nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
@@ -256,8 +247,16 @@ nfs_co_generic_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+
+    /*
+     * Safe to call: nfs_service(), which called us, is only run from the FD
+     * handlers, never from the request coroutine.  The request coroutine in
+     * turn will yield unconditionally.
+     * No need to release the lock, even if we directly enter the coroutine, as
+     * the lock is never re-taken after yielding.  (Note: If we do enter the
+     * coroutine, @task will probably be dangling once aio_co_wake() returns.)
+     */
+    aio_co_wake(task->co);
 }
 
 static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
@@ -278,9 +277,7 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (task.ret < 0) {
         return task.ret;
@@ -328,9 +325,7 @@ static int coroutine_fn nfs_co_pwritev(BlockDriverState *bs, int64_t offset,
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     if (my_buffer) {
         g_free(buf);
@@ -358,9 +353,7 @@ static int coroutine_fn nfs_co_flush(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return task.ret;
 }
@@ -723,8 +716,8 @@ nfs_get_allocated_file_size_cb(int ret, struct nfs_context *nfs, void *data,
     if (task->ret < 0) {
         error_report("NFS Error: %s", nfs_get_error(nfs));
     }
-    replay_bh_schedule_oneshot_event(task->client->aio_context,
-                                     nfs_co_generic_bh_cb, task);
+    /* Safe to call, see nfs_co_generic_cb() */
+    aio_co_wake(task->co);
 }
 
 static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
@@ -748,9 +741,7 @@ static int64_t coroutine_fn nfs_co_get_allocated_file_size(BlockDriverState *bs)
 
         nfs_set_events(client);
     }
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    qemu_coroutine_yield();
 
     return (task.ret < 0 ? task.ret : st.st_blocks * 512);
 }
-- 
2.51.1


