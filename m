Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1052C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQMD-00021Y-NL; Fri, 07 Feb 2025 10:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKO-0008AC-JP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:38 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKB-00041Z-Vw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:36 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so381705466b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942282; x=1739547082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vu9pOked5UqOucuAkIMsH1wV3NsjfZIqorCbgdhJbNs=;
 b=sO2OjvfqiiWe2p8l3aOp1BdGD2+U56p4FUnTUK+u7P0BQ4AjG/1paYX4r0lRjoRthL
 Eowj6IiQHjyaf8Gi3AYHa2UV62qAHS0Bsy8kY1vqnOm8ehDcMFHZiEnnrf6UAm1/GjLi
 dSsh3fiU95ejH9DXGGc5ubinfy19SlyQioj7vcoWMCUmTQQEG51ZYHZr3DsV57ioN2TT
 Sh+LNQO1y3dg9/eqhNUvk5NYdiZny9ArZDQbw+OD03txwIg6EIWgI/yE9tg+p10maZLh
 I9luOO4Q3NO30wkcZ+dTto/2bEX6reqslVZXy1gQbOwTwVdt3l1s/5R745Gu0EkPrtMp
 lizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942282; x=1739547082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vu9pOked5UqOucuAkIMsH1wV3NsjfZIqorCbgdhJbNs=;
 b=nM1uPQ2OMITGMEWhl0ROnzysKojkOHy+l4khuvZ5bRcZQy8GoXsqPq6+VHLFibj+P0
 bnQfQ7IDxlPY7K+bV00nXclZDaVj5S2ktcTCh3KFTwV4BPt8jDpTJ/c1RQt3CSNxgSyx
 7UUPAqJ2Lrz7Q1qzSw2Y0swlJPtIOyv/VlFeFrEWObz+Y1KZ2spcrbZe1f//3+ZErGRu
 RKWMwZkAY+T+nD5DzCoujgygDiqpC/iM9VJZY4i3E7G/dJWORcdOb8h7rm6Z5fZOLBEb
 cES8MIASf+ECFZ2laQHyJIlEDItF8hdjYBOAorDVK9wmSrzyw4E62V+RMAVq0/elh6Q8
 F/eg==
X-Gm-Message-State: AOJu0Ywh1rqeQNJgEGtL7g/PGMvvDWLcukyCqo8nJ58tcxEttHB62Dxb
 EOP5J7MFK+e99iZpZBpUR0nJcde1kVaWeeLLyiKU9xhDUCFTZTqO5zXvkuKbqGM=
X-Gm-Gg: ASbGnctCDNJitykS3WzGZvW00myrsqPDlRgqjT81uyzWZ+hQJZ19QfV06QRT5tFo/7u
 fZ1xJG0k2zb0IRmBOb7z/YbQcA4n2vEGQptAo6tK8wEDoF37pyrJXyJAgPV+oZCXW+mdVtCI7bf
 Q+9Xcf2AxztOH5mWqIP0s0aGf8kuRfZ7eBeiBv2hKBuxLV811yaXlp4lPx31+ahQDLo0DpJrwrH
 0Uno5P52U9/bCWQ9FKDWiq0AmhUiH8SAvJwcBuX9EbDMIdOje7RpsCNidFG0IZ7bR9lTYM4IAYS
 HTmGZyg7pOvJHPGqyA==
X-Google-Smtp-Source: AGHT+IEdzl5YNA6P1McdIM+YD60CvEX9Z6omgknR+gcXMIjyJb+eT35FLmeuVvE0k2cBHVcZRgRpXg==
X-Received: by 2002:a17:907:9719:b0:ab6:e10e:2f5 with SMTP id
 a640c23a62f3a-ab789bf6ae5mr405155466b.37.1738942281797; 
 Fri, 07 Feb 2025 07:31:21 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7885e032fsm155043666b.115.2025.02.07.07.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:18 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9520C60BD2;
 Fri,  7 Feb 2025 15:31:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 13/17] user: Introduce host_interrupt_signal
Date: Fri,  7 Feb 2025 15:31:08 +0000
Message-Id: <20250207153112.3939799-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207153112.3939799-1-alex.bennee@linaro.org>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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


