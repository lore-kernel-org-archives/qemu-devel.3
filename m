Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C327C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 14:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1texdb-0003qR-V4; Mon, 03 Feb 2025 09:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdQ-0003h6-Tw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1texdD-0002QQ-Pp
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 09:41:12 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so9629481a12.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738593658; x=1739198458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vu9pOked5UqOucuAkIMsH1wV3NsjfZIqorCbgdhJbNs=;
 b=oz+PZ6kuKYzRbF0YsJ24w2ZlzLXWsH6vlpQ6lvDLM61YNufw5HDa9Pd07PAoxcI17A
 Egr2JPiH9/rPIRdoPt6k5cvGVzepqygM7IPQRoV7gIWdIuo+7vccv12IYw5QlelaIVpK
 83+e2zGxYyzGdZjIYOxWPyxbvXyzh9iQlehp9AUXf1GRdMRHTpG0LtbOYRIuS7LitXYf
 M+NJ9p5o69xgyRaMI4qKWxAJe4OAnwQHuKOff26WwDKTdtc+Ao8cmEnsWQefrNCy3O8v
 ZoszT+5HlDUp5PLMXyNVreggW0eNXjRD7K5k3Ecsj+OHXxMZrvpLqLH1xy6hpZkNAhkK
 u3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738593658; x=1739198458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vu9pOked5UqOucuAkIMsH1wV3NsjfZIqorCbgdhJbNs=;
 b=u4OeUx+YcMtm7KXl4rBnTC3DCoPFF0DM86fUZkxivvQeGpG/umLUPnjia/n24pYVKb
 PP4VeSYKL1AyU2aRX13yRD+t3i370jy/20h/yj/OCvZDwmb4FwEkQipbtezFnpapck2Z
 VfDiycw3Ta/+WFuvh5L5c4Pemiz+c+7Vyjy3tBikh2D7ZNERfpzbIRyvvhwOt3rkr/69
 mNq6D6e/EuC0ZCLHR9iHYwMAXw3cHIt7XDWGSo+0Bdp3DYDue+L5o6bDqx1NK2MeXT4G
 nK8owYIJnx7tStq1iaJbXTIa6lgbkih8idoBC+RoIgbQDmstw6I2p2HPZEiqh77A9zhq
 WYOg==
X-Gm-Message-State: AOJu0Yz0QMpoGL/uNi8z7ZLexsSYAPxBmbf0lx9xw2Dy6fcjT0joZkWh
 JfbWPy8gf5GO85i7kfB1qprwVv5OJSp8HO/Tju5rST1MggOMbG/MDYw/Oizve7Q=
X-Gm-Gg: ASbGncueX3bT/0MPtkhfZpvLtQsn3Gz6TG/IyUApDbQT18QbzFr3YEpV7sgxsbR+K/Q
 w/mNIkUHiIolIV3TcC0VJtl+NIn5RMjhhw7t80VFTlbMGRY7kcKQxyN24kiBJU7pSolFQP/2HK/
 iuNaKkgQQSJFClhM6SiICemCeMzA+/qIyTfspr3hLXOft6tz3yrw5cTW+DYZY7TQNb8Hwt1sRht
 SAjA6n5OqFiBh1rTDPLoIsg2xl+3vmC+ZWla/kd5DGdN6tOn7EdTJ/ex8Vj67vw4YdxBFJj8UGj
 8tWdkvZTapSpy/w95Q==
X-Google-Smtp-Source: AGHT+IEdVQrHge+ZZtzPsalbMXBN7f3sBneytdfxQblWWoHlxRiCnjis6+76OPfKMAyMU4FY0srneQ==
X-Received: by 2002:a17:907:8b94:b0:aa6:8a1b:8b84 with SMTP id
 a640c23a62f3a-ab6cfe17745mr2460903766b.57.1738593658202; 
 Mon, 03 Feb 2025 06:40:58 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7b0fsm769101066b.12.2025.02.03.06.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 06:40:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 03C70609FC;
 Mon,  3 Feb 2025 14:40:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Peter Xu <peterx@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-rust@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-riscv@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 13/18] user: Introduce host_interrupt_signal
Date: Mon,  3 Feb 2025 14:40:43 +0000
Message-Id: <20250203144048.2131117-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250203144048.2131117-1-alex.bennee@linaro.org>
References: <20250203144048.2131117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Attaching to the gdbstub of a running process requires stopping its
threads. For threads that run on a CPU, cpu_exit() is enough, but the
only way to grab attention of a thread that is stuck in a long-running
syscall is to interrupt it with a signal.

Reserve a host realtime signal for this, just like it's already done
for TARGET_SIGABRT on Linux. This may reduce the number of available
guest realtime signals by one, but this is acceptable, since there are
quite a lot of them, and it's unlikely that there are apps that need
them all.

Set signal_pending for the safe_sycall machinery to prevent invoking
the syscall. This is a lie, since we don't queue a guest signal, but
process_pending_signals() can handle the absence of pending signals.
The syscall returns with QEMU_ERESTARTSYS errno, which arranges for
the automatic restart. This is important, because it helps avoiding
disturbing poorly written guests.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20250117001542.8290-5-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/user/signal.h |  2 ++
 bsd-user/signal.c     | 12 ++++++++++++
 linux-user/signal.c   | 25 ++++++++++++++++++++-----
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/user/signal.h b/include/user/signal.h
index 19b6b9e5dd..7fa33b05d9 100644
--- a/include/user/signal.h
+++ b/include/user/signal.h
@@ -20,4 +20,6 @@
  */
 int target_to_host_signal(int sig);
 
+extern int host_interrupt_signal;
+
 #endif
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 8c51f6ce65..ff2ccbbf60 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -51,6 +51,8 @@ static inline int sas_ss_flags(TaskState *ts, unsigned long sp)
         on_sig_stack(ts, sp) ? SS_ONSTACK : 0;
 }
 
+int host_interrupt_signal = SIGRTMAX;
+
 /*
  * The BSD ABIs use the same signal numbers across all the CPU architectures, so
  * (unlike Linux) these functions are just the identity mapping. This might not
@@ -491,6 +493,12 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
     uintptr_t pc = 0;
     bool sync_sig = false;
 
+    if (host_sig == host_interrupt_signal) {
+        ts->signal_pending = 1;
+        cpu_exit(thread_cpu);
+        return;
+    }
+
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
      * handling wrt signal blocking and unwinding.
@@ -854,6 +862,9 @@ void signal_init(void)
 
     for (i = 1; i <= TARGET_NSIG; i++) {
         host_sig = target_to_host_signal(i);
+        if (host_sig == host_interrupt_signal) {
+            continue;
+        }
         sigaction(host_sig, NULL, &oact);
         if (oact.sa_sigaction == (void *)SIG_IGN) {
             sigact_table[i - 1]._sa_handler = TARGET_SIG_IGN;
@@ -872,6 +883,7 @@ void signal_init(void)
             sigaction(host_sig, &act, NULL);
         }
     }
+    sigaction(host_interrupt_signal, &act, NULL);
 }
 
 static void handle_pending_signal(CPUArchState *env, int sig,
diff --git a/linux-user/signal.c b/linux-user/signal.c
index bffbef235c..81a98c6d02 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -517,6 +517,8 @@ static int core_dump_signal(int sig)
     }
 }
 
+int host_interrupt_signal;
+
 static void signal_table_init(const char *rtsig_map)
 {
     int hsig, tsig, count;
@@ -580,10 +582,10 @@ static void signal_table_init(const char *rtsig_map)
          * Attempts for configure "missing" signals via sigaction will be
          * silently ignored.
          *
-         * Reserve one signal for internal usage (see below).
+         * Reserve two signals for internal usage (see below).
          */
 
-        hsig = SIGRTMIN + 1;
+        hsig = SIGRTMIN + 2;
         for (tsig = TARGET_SIGRTMIN;
              hsig <= SIGRTMAX && tsig <= TARGET_NSIG;
              hsig++, tsig++) {
@@ -604,12 +606,17 @@ static void signal_table_init(const char *rtsig_map)
     host_to_target_signal_table[SIGABRT] = 0;
     for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
         if (!host_to_target_signal_table[hsig]) {
-            host_to_target_signal_table[hsig] = TARGET_SIGABRT;
-            break;
+            if (host_interrupt_signal) {
+                host_to_target_signal_table[hsig] = TARGET_SIGABRT;
+                break;
+            } else {
+                host_interrupt_signal = hsig;
+            }
         }
     }
     if (hsig > SIGRTMAX) {
-        fprintf(stderr, "No rt signals left for SIGABRT mapping\n");
+        fprintf(stderr,
+                "No rt signals left for interrupt and SIGABRT mapping\n");
         exit(EXIT_FAILURE);
     }
 
@@ -689,6 +696,8 @@ void signal_init(const char *rtsig_map)
         }
         sigact_table[tsig - 1]._sa_handler = thand;
     }
+
+    sigaction(host_interrupt_signal, &act, NULL);
 }
 
 /* Force a synchronously taken signal. The kernel force_sig() function
@@ -1036,6 +1045,12 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
     bool sync_sig = false;
     void *sigmask;
 
+    if (host_sig == host_interrupt_signal) {
+        ts->signal_pending = 1;
+        cpu_exit(thread_cpu);
+        return;
+    }
+
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
      * handling wrt signal blocking and unwinding.  Non-spoofed SIGILL,
-- 
2.39.5


