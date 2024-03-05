Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D1DC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTdg-0002dB-JI; Tue, 05 Mar 2024 07:11:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcq-0001bG-Ht
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:30 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcc-0001P0-QA
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412e6bdd454so12021035e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640612; x=1710245412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXkKB6oKUyrrNS5PAFHEEy/nZhjQotVShPfjRJSJXXY=;
 b=Cd0XR8YCyPXAwU7YhKdrMMPiB4LFjPYcIO/reS7phUVFI7RmFGi8QCr33diLWthxkP
 eDeTj6AYUBUeJB1f8P7ezCWi6VkRY1MwCeap3wybZek7jWCfbdVkK/udU8CiRFWxXDkq
 Yom+iQIxdyRLL4MQC0XXZoF4xzbQZX7CoIZffBCtK0JYS9715xO6zX3RE6WQKirvOqP+
 bVLl4U+U0V2EyJOIE9d/y2SLC8kY0x+CV9Rgz3G1rTYIuYMrc+gQi0vDOsiUyL/NlWT5
 wWlHc9z5SWfpCY+YRVghqokV77AvleMXMJS1UGvXMuXHBj+bQp4u1qDdqV9kky9tQtH9
 OOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640612; x=1710245412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXkKB6oKUyrrNS5PAFHEEy/nZhjQotVShPfjRJSJXXY=;
 b=qLSJ0TS2bKOOot4N6KblqN15zGXUp7ooPvXGd57vAT6uXB7TvNg3vOrKcEja/s8UaQ
 uaeEogT08I9/7PR4I8KA2mFuQMZhVOx4zg7ijNVsQbzVHfEgm0M57pQH0w4i51Os2lqY
 2TOreiTw9MDrEebfw1IUYgOoDPMXq11qPfEXXKfg5z3m85y6LwoHD9wtBPj2z7bM3/Wn
 PJMDr0fU6dzFYBaaxMqlSh6zLvq68cUBpOjP30UijGEc/n003E/E2nyvO1JlMmKnhzcY
 32HBnm7SlCLg09eoepJwpBB6BalClnfuZyvl3P5uhIZa13vxhaXuD2ThlBX5kI/IOCew
 T4gw==
X-Gm-Message-State: AOJu0Yykts20vowHiLJAnnlWkRhBq1cuQx35t6T+lpwhUjnpp8oIYUYL
 rk0eaju+0R/V1ivntcvgDZDotgCTavf7fokRkLN4vX0WgkHUPThKO85mSGm/VCk=
X-Google-Smtp-Source: AGHT+IFihsx+QOfv8tfwnYUEolqlOO1XCnU8T0HLsKzH+rxO+pVVFFd6wvVuGPOcCe38TlOUvrZ8lQ==
X-Received: by 2002:a05:600c:5249:b0:412:e59e:da2c with SMTP id
 fc9-20020a05600c524900b00412e59eda2cmr3295051wmb.37.1709640611931; 
 Tue, 05 Mar 2024 04:10:11 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fa10-20020a05600c518a00b00412e17d5f83sm7151450wmb.14.2024.03.05.04.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A3755F958;
 Tue,  5 Mar 2024 12:10:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 06/29] {linux,bsd}-user: Pass pid to fork_end()
Date: Tue,  5 Mar 2024 12:09:42 +0000
Message-Id: <20240305121005.3528075-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

The upcoming follow-fork-mode child support requires knowing the child
pid. Pass it down.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20240219141628.246823-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 bsd-user/freebsd/os-proc.h  | 6 +++---
 bsd-user/qemu.h             | 2 +-
 linux-user/user-internals.h | 2 +-
 bsd-user/main.c             | 4 +++-
 linux-user/main.c           | 4 +++-
 linux-user/syscall.c        | 6 +++---
 6 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index d6418780344..3003c8cb637 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -208,7 +208,7 @@ static inline abi_long do_freebsd_fork(void *cpu_env)
      */
     set_second_rval(cpu_env, child_flag);
 
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
@@ -252,7 +252,7 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 
@@ -285,7 +285,7 @@ static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
      * value: 0 for parent process, 1 for child process.
      */
     set_second_rval(cpu_env, child_flag);
-    fork_end(child_flag);
+    fork_end(ret);
 
     return ret;
 }
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4adb75d19ff..1b0a591d2d2 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -192,7 +192,7 @@ void cpu_loop(CPUArchState *env);
 char *target_strerror(int err);
 int get_osversion(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 #include "qemu/log.h"
 
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index c63ef45fc78..ce11d9e21c1 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -71,7 +71,7 @@ const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
 void fork_start(void);
-void fork_end(int child);
+void fork_end(pid_t pid);
 
 /**
  * probe_guest_base:
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 517c6b3ec2f..fca9b302043 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -116,8 +116,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
diff --git a/linux-user/main.c b/linux-user/main.c
index 755c566d6d2..cab95f5b0aa 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -148,8 +148,10 @@ void fork_start(void)
     gdbserver_fork_start();
 }
 
-void fork_end(int child)
+void fork_end(pid_t pid)
 {
+    bool child = pid == 0;
+
     qemu_plugin_user_postfork(child);
     mmap_fork_end(child);
     if (child) {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c233d4eb30a..7f30defcb13 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6669,7 +6669,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         if (ret == 0) {
             /* Child Process.  */
             cpu_clone_regs_child(env, newsp, flags);
-            fork_end(1);
+            fork_end(ret);
             /* There is a race condition here.  The parent process could
                theoretically read the TID in the child process before the child
                tid is set.  This would require using either ptrace
@@ -6700,8 +6700,8 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
                 }
 #endif
                 put_user_u32(pid_fd, parent_tidptr);
-                }
-            fork_end(0);
+            }
+            fork_end(ret);
         }
         g_assert(!cpu_in_exclusive_context(cpu));
     }
-- 
2.39.2


