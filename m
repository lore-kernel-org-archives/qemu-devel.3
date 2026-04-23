Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E004F9936C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKr-000177-Rv; Thu, 23 Apr 2026 06:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKn-00013q-S7
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrKj-00067l-1g
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERyMgSdbJE1FXknEB9Czp6yuKXaax6AJGVhcoUdtg0o=;
 b=bdR7gY4aZOGreSeFOgN3jjhgXncX3QhJBLjaiVROehayffNGJ9WN/dbnqk3beZpWCwRPnX
 5EoAX/Qtl39gpgAuoCsvuFiDl2OyS2Vp7AVXe5kmUlXnN/doSc3rBzUeXq8y0TmBRB73no
 f3x0sFhDYvNkqLCoUIdCg/yfVRhUBhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-1lzhnvH7MYyhrEl_X4ErsQ-1; Thu, 23 Apr 2026 06:30:54 -0400
X-MC-Unique: 1lzhnvH7MYyhrEl_X4ErsQ-1
X-Mimecast-MFC-AGG-ID: 1lzhnvH7MYyhrEl_X4ErsQ_1776940253
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-488bd1ee9e7so53870425e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940252; x=1777545052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERyMgSdbJE1FXknEB9Czp6yuKXaax6AJGVhcoUdtg0o=;
 b=pv0FabqwL0C8n6cF9bINB3L7kGcWsUUlLWNRfqHybcNRBokEo6cNBQY5MbUnGCW/5N
 eCXfAW4e7RAiWeghux7QLp309yQi1hJ6vW5vr6Y0y5ekWZSoJim2Cx2PQFUijnTJleuy
 jn+gcYAPr60IttjdPnxhNF4F8DgKDVT2QghfP5UVq5Is09vGc8TRZi0FVgRlkLPRSTf5
 4HqTXHrTP/BwSHlV8aZM7M4wzEUtLBTcNYwMeZ8G5vx+9BI8adaC4fZhnEee/zNypTNv
 CQk7r/EklkXnGUUX/8MqH+Mqx+q7YcLNYu8fKVjnxmxy3mDbyg01vmKK1/sZN0WtGJOZ
 rYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940252; x=1777545052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERyMgSdbJE1FXknEB9Czp6yuKXaax6AJGVhcoUdtg0o=;
 b=J7z+LPCdqP2vt1L+z9e3R7NZa1VdzUC8rzlpz/iZkw+E0nvm2hnRjhw3WZKppl1CiI
 gOCON4koNP+9mdySQ4qyhY8gX2MtuHoqhiMxlnzdC3A7KirHsFjZ2CQ/1rB8TTVmguQS
 NX4lVeeEdQRwxlaemsnCDZp70YrWVNRpaKEBW7HHNlFQk5mv8qsVhInWnEe0odBMjDB3
 gx42P7wXmvUdbsvtauBK/gPuZIxCb0oOFz09R3MDewyl1yyPfWoc56iVJI0/kqbIH/ez
 jnHCkMzzU1klLg+1aJCOz0abC4dkjK0MAJdgNjQ6Pp1FzqZqQrayM/SK3/nqZjMJjJJG
 f8oQ==
X-Gm-Message-State: AOJu0YyvivorjZF2vuBm0vvxXpfTgQ4MQHdu6PVoDE6bgk3ojdke9uNb
 L7TzqOpOnQUo9JpC84uQ6gsMC/AEEWHdjIwyfrfw2VdC/c8o19rCFnXbXrda1F9wXr0btaJiF4c
 xdkeIFuquzYuyfF0C1XH8K7ype5tdptBdTUV9GUFiPWUQbFuG7GQNl+ez4u/hebLnhrXT2ypNnI
 +GJbzejQVnjYhdkf5UeVpOZXGpEjFFDtVQgY7oDbIZ
X-Gm-Gg: AeBDievhNXgYV/M6/uHOsV5ryHROX325FqByRgIqT5oIFo3ztLFYpfHDM9ChgWdDpc0
 ocmxu0Oo8uz1/4MDdE/0YxDiEdBTE6NptWJxIF4ZZ3I1XmpBTGUSnXVMwMcyU2PsL3QdoO9TIK9
 SjmN4xf4wYODSxeST0bagajS/N6Mo3mv/mqAnU+Zh1We0pvL2P+nSmRjljG7BhtUUsI4yqgXWzh
 HyS03OibmrOc3rsaz9km/LBIJRen9ShTxuvznxLkYrETiPoKYc7LAZAxavSvt+XCi6+esE/TWPC
 LxjAu3vYPYjMUkOz2M/YtFF/r3Xh7CYTPg/etILeZLAoal+dH0CF2J4EZhAtU84TaTyEHgfU/Uq
 5VphJVDuhSH1gkT7aYUcbcVeKDx7uGhXKXUn8T1HWGE9MKFGjfpvx6+wGvk8SDp1QzoqYtA7ggf
 qiUc8SsChvk5fIOQJRf8VytgtHCDNhshpnN/M=
X-Received: by 2002:a05:600c:530f:b0:48a:56de:d640 with SMTP id
 5b1f17b1804b1-48a56dedc17mr156046625e9.16.1776940252411; 
 Thu, 23 Apr 2026 03:30:52 -0700 (PDT)
X-Received: by 2002:a05:600c:530f:b0:48a:56de:d640 with SMTP id
 5b1f17b1804b1-48a56dedc17mr156046065e9.16.1776940251780; 
 Thu, 23 Apr 2026 03:30:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891ffd2030sm83443695e9.20.2026.04.23.03.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:30:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 22/25] thread-win32: replace CRITICAL_SECTION with SRWLOCK
Date: Thu, 23 Apr 2026 12:29:19 +0200
Message-ID: <20260423102922.443639-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

SRWLOCK is a much cheaper primitive than CRITICAL_SECTION, which
basically exists only as a legacy API.  The SRWLOCK is a single word
in memory and it is cheaper to just initialize it always.

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-thread-win32.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
index 272afc33856..3037732a6fe 100644
--- a/util/qemu-thread-win32.c
+++ b/util/qemu-thread-win32.c
@@ -242,7 +242,7 @@ struct QemuThreadData {
     /* Only used for joinable threads. */
     bool              exited;
     void             *ret;
-    CRITICAL_SECTION  cs;
+    SRWLOCK           lock;
 };
 
 static bool atexit_registered;
@@ -295,9 +295,9 @@ void qemu_thread_exit(void *arg)
     notifier_list_notify(&data->exit, NULL);
     if (data->mode == QEMU_THREAD_JOINABLE) {
         data->ret = arg;
-        EnterCriticalSection(&data->cs);
+        AcquireSRWLockExclusive(&data->lock);
         data->exited = true;
-        LeaveCriticalSection(&data->cs);
+        ReleaseSRWLockExclusive(&data->lock);
     } else {
         g_free(data);
     }
@@ -328,7 +328,6 @@ void *qemu_thread_join(QemuThread *thread)
         CloseHandle(handle);
     }
     ret = data->ret;
-    DeleteCriticalSection(&data->cs);
     g_free(data);
     return ret;
 }
@@ -357,6 +356,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     struct QemuThreadData *data;
 
     data = g_malloc(sizeof *data);
+    InitializeSRWLock(&data->lock);
     data->start_routine = start_routine;
     data->arg = arg;
     data->mode = mode;
@@ -364,10 +364,6 @@ void qemu_thread_create(QemuThread *thread, const char *name,
     data->name = g_strdup(name);
     notifier_list_init(&data->exit);
 
-    if (data->mode != QEMU_THREAD_DETACHED) {
-        InitializeCriticalSection(&data->cs);
-    }
-
     hThread = (HANDLE) _beginthreadex(NULL, 0, win32_start_routine,
                                       data, 0, &thread->tid);
     if (!hThread) {
@@ -406,14 +402,14 @@ HANDLE qemu_thread_get_handle(QemuThread *thread)
         return NULL;
     }
 
-    EnterCriticalSection(&data->cs);
+    AcquireSRWLockExclusive(&data->lock);
     if (!data->exited) {
         handle = OpenThread(SYNCHRONIZE | THREAD_SUSPEND_RESUME |
                             THREAD_SET_CONTEXT, FALSE, thread->tid);
     } else {
         handle = NULL;
     }
-    LeaveCriticalSection(&data->cs);
+    ReleaseSRWLockExclusive(&data->lock);
     return handle;
 }
 
-- 
2.53.0


