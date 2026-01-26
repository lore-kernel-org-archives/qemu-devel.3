Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305E1D13C22
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 15:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkOKS-0002dC-0v; Mon, 26 Jan 2026 10:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vkOKE-0002Wv-AQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:16:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vkOKB-0005IG-87
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 10:16:20 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2776719f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769440577; x=1770045377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=n9old+XAOXg8zEgQfhD8yuTdEVckceINWY04xyiJLnc=;
 b=YAGv0OTIzp0O+QnvbMTRf8fbaCeWx52XURHAoWda/Lr4HqsR7xjyhHCeExAiwoegeH
 cRiI9D3jUKIdwmwusWXzHN8qrbNqxx9xiJDiynwj89itt5azoYmPUAgY3afjFUEqctb/
 I1CepaHwEt0GxKmE1qPdk5sqdB9UGvomGIZLvymfm2kYdZ3FeYdYnN9CcDVpi/9YOLn2
 PQAQEn8cKPrbmrcjjQWwxPEAGW4gHuTy2nsGhvH5m2BdRwlaYC0mkxYnA4ic3K8fYqx9
 nbKNKXCJp6Yi3Gf/5WxYnqgnDeH8gx+e6WDb+L3MSQZRaizF5GU9A8ySLyUK/DDnGzZv
 Aw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440577; x=1770045377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9old+XAOXg8zEgQfhD8yuTdEVckceINWY04xyiJLnc=;
 b=PhdA+OyncNzbxJetmpXw07pOfc1rltK3bescxXRFbz+2w6yo6Uxkl6+/2RqbMINUki
 wZvXkW6Cgi10nZa4/gSKWSdZ5Geu5dXalsmPGZtAok7e6xEJ7Xw5B9NpAdTfPSzBJTr9
 rKBjkhxhHQ5g48ta8dUVA7sDTzfnq2Oz/OELZ4cMbvzeyGgmmbmAhSeLbaFavKOm0rNA
 Ip6ccjgfnnNzTLvL2b0635HZOlththeUKy4uUu+8LHoMSb7cyqtad8vBRAFq6MgOveGF
 EF80d9dpJ5mQRUhWdNHH/WC4PoohXbwFmIGWa4kCAPfwLPlQtHxMygLXMpcN0NR1cQ5N
 /K2A==
X-Gm-Message-State: AOJu0YysYN1xzzmt9y03fJzZ9GXNoq+a5S4FhpUel6yWgKz65bkJMMep
 v0l7NsCevqUwb/DsQxp/AWqHwEAZVOZM2SNRhxx0nqLFBwrR49KKtK6QvKdr0oq4
X-Gm-Gg: AZuq6aL2zWbGWGTdpQyL5Ryf1iVDTzVdBi1XXq0s5bGbdvz8fxnatOqWcUWq6EqwHCB
 +dnWywkzGkl7dshBNuRF0Tdsrm5RYTowwjsGamyeQFHP2W0l3ILeBcqUBbPPatNzP1f7rKXr28B
 kOjUXCorKJj5axIYF7YVxs4OrC66fR+ozVjPjkmXGGyTiBp6dXZX8Zs+ctOmHTaJD5ECCLqUY2s
 4GzR6JkUbeqJ5j+ILq35nidOITVBKbcbH0iGbyBC4bmKtXYEMoEGF/0z8v/YyWh7JuZYm3Tu0Uh
 OV7xCldDlC2m0yhnj3eBGjQGVs7HTquiRQin6m4wWWN4XBjeqBy5O/aEOcF9nceOYYTvsRnZClc
 EqDxidSV18EwGxP1eZe9fezCgDqNcb7ivLs/ZhrqN3ZnU+cy3oVSRjjrs1WF/A3vKQpKv5EnMJi
 pOOzEEyH9kqufb21We
X-Received: by 2002:a05:6000:2482:b0:435:9e81:105a with SMTP id
 ffacd0b85a97d-435ca0ef8aemr8177310f8f.20.1769440576424; 
 Mon, 26 Jan 2026 07:16:16 -0800 (PST)
Received: from NB-8855.Dlink ([109.236.104.200])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24f15sm31644221f8f.18.2026.01.26.07.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 07:16:15 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [PATCH] linux-user/syscall.c: Prevent acquiring clone_lock while
 fork()
Date: Mon, 26 Jan 2026 18:16:12 +0300
Message-ID: <20260126151612.2176451-1-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=sergeev0xef@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---
 linux-user/main.c           |  2 ++
 linux-user/syscall.c        | 14 ++++++++++++++
 linux-user/user-internals.h |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index db751c07576..c49d1e91d22 100644
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
index 3944004568f..e64e5db1139 100644
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
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 067c02bb93e..24d35998f07 100644
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
 
-- 
2.52.0


