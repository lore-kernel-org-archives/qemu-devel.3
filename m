Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F8DEE2085
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 10:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJ3U-0001SC-R7; Fri, 06 Feb 2026 05:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3N-0001RG-0x
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:09 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voJ3L-0007SG-Aq
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 05:27:08 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3532aa9a77eso898665a91.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 02:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770373626; x=1770978426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RH3cLAMiAOc5SS6FZ+P7B8pmgCY7JMOLIwxKd4xRODc=;
 b=NwdYRRjIObIftKSdhT++7uLFB+SyQ0jwCiP8xxAsxeJr8XlcyJeAmq1RwTmhDXM/mY
 wZ+FjJJUfXzIbTZ0qRlOw2IHGzi5jsRB+A1RJrFiWmV3tJkuzLzXaxl8b/JLX0csTyt0
 xMSDtvA6NEkT3dSwXpKzqNdKrLFgZk1zWzKBEeop0LbNLIntvCeSyfo7YBaodR/kqTZt
 ej2sfXPq7qa4wu4K9H74i+rKSUaf7S6Z+hjXRc5l3cidQCXjQFmsGPu0gK2gDaI6p+mb
 +7of82J0zAp7yQZz3w+nsDXqP14Ttv+lq3wp6njLKi3y035MAzSNXtgClLuOMhs4l3BB
 FhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770373626; x=1770978426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RH3cLAMiAOc5SS6FZ+P7B8pmgCY7JMOLIwxKd4xRODc=;
 b=vmQzyT3kEgMvOwECsAcP8MmUu1oBgnAOsls2DDhn9m12XBb0Xo5wKKmn2QlglxejsW
 OZ0tSHN6m6EcnRioZl1W9kJzCqv/wBu8UeqKTWKBDrcmaDZOghGvHCdD5oPjvwGf0g+o
 1cdbgt56tGv4TBHuCoNmRVOoHfdPSokq/iBoY3VWWmP66Vjfr8ABtqRRSEHjOHKH24Po
 ddIe6Mkx92fWDfal6ZiJAnySYnogMSCVgMXIeknWJBoUjlsSxzl24H8iLOAYyxRfHBNp
 ozSzxVXBvU3R+HWxichxJXF0UrZr84g6nN7z/UcZXnHEQZZ8uMnzGdFXhfuIXLolsa5Z
 mYVw==
X-Gm-Message-State: AOJu0YyFxOGJKqUkec3ZF27w6hN8FliBOPOXaBYKOL3Z7p2I9OEZ5E5O
 tN2zeTthfy04Y25i+1wI2Oi2iceGoI4Oo6+gJjxyze1oEGr8VGwTST7pVEkCM4YQp/KqKHeIl6H
 jAvDyBehYtg==
X-Gm-Gg: AZuq6aL5agtbEckois7v4t+pNOpynqybWU3JrdLrfS8G4Bhr8DneKeJPVSLC1OyiGP5
 nM1h9xsp2RnVxqn8pczLI4AdxQ2g+r0c8GwsAj7Ry30dgwlWo8cjYfqNsXqKw34GBf4/gEpQMM6
 GGolRnFSSwaPCPeRBfAdBdU5LzTvgQgLEbYz76NEeFv2a9UwSySSABBIY9af8pPFHF0FJ0PUR3i
 XOjA2giOVKP3t3w72Opg2fW+Z2CumxWTQs+JXXz3+gVV9Rf0ZhmZb8tWSxDYfEUZh0wQg1dVSz+
 jrkfXpMbRiUjQkPhSbmIEemEr1fnBMGBzx1Us/h9BAIl3LYmOv7lWrIcv536YRCEEm5dQa8Y6/F
 dsgP468d2oGS3f4mYFy58MMTSmqfHfis7SQwztDEwW8c3WC48mm9/vPbF8zzSjGal6KZI6dqiQH
 6IECZX9t7Ruu6otmZAWG9wn0kvBqfb14q1DLFBnHoycqDnhdmlE2pwaTs7ftDc2tE=
X-Received: by 2002:a17:90a:d607:b0:32e:7340:a7f7 with SMTP id
 98e67ed59e1d1-354b3c52d79mr1857077a91.2.1770373625890; 
 Fri, 06 Feb 2026 02:27:05 -0800 (PST)
Received: from stoup.. (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b1f49191sm2113723a91.7.2026.02.06.02.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:27:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [PULL 3/5] linux-user/syscall.c: Prevent acquiring clone_lock while
 fork()
Date: Fri,  6 Feb 2026 20:26:50 +1000
Message-ID: <20260206102652.164018-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206102652.164018-1-richard.henderson@linaro.org>
References: <20260206102652.164018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

From: Aleksandr Sergeev <sergeev0xef@gmail.com>

By the spec, fork() copies only the thread which executes it.
So it may happen, what while one thread is doing a fork,
another thread is holding `clone_lock` mutex
(e.g. doing a `fork()` or `exit()`).
So the child process is born with the mutex being held,
and there are nobody to release it.

As the thread executing do_syscall() is not considered running,
start_exclusive() does not protect us from the case.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3226
Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260126151612.2176451-1-sergeev0xef@gmail.com>
---
 linux-user/user-internals.h |  2 ++
 linux-user/main.c           |  2 ++
 linux-user/syscall.c        | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 067c02bb93..24d35998f0 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -69,6 +69,8 @@ abi_long get_errno(abi_long ret);
 const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
+void clone_fork_start(void);
+void clone_fork_end(bool child);
 void fork_start(void);
 void fork_end(pid_t pid);
 
diff --git a/linux-user/main.c b/linux-user/main.c
index db751c0757..c49d1e91d2 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -145,6 +145,7 @@ unsigned long guest_stack_size = TARGET_DEFAULT_STACK_SIZE;
 void fork_start(void)
 {
     start_exclusive();
+    clone_fork_start();
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
@@ -174,6 +175,7 @@ void fork_end(pid_t pid)
         cpu_list_unlock();
     }
     gdbserver_fork_end(thread_cpu, pid);
+    clone_fork_end(child);
     /*
      * qemu_init_cpu_list() reinitialized the child exclusive state, but we
      * also need to keep current_cpu consistent, so call end_exclusive() for
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3e6a56aa0f..d466d0e32f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6856,6 +6856,20 @@ static void *clone_func(void *arg)
     return NULL;
 }
 
+void clone_fork_start(void)
+{
+    pthread_mutex_lock(&clone_lock);
+}
+
+void clone_fork_end(bool child)
+{
+    if (child) {
+        pthread_mutex_init(&clone_lock, NULL);
+    } else {
+        pthread_mutex_unlock(&clone_lock);
+    }
+}
+
 /* do_fork() Must return host values and target errnos (unlike most
    do_*() functions). */
 static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
-- 
2.43.0


