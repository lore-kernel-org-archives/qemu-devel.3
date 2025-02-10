Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F489C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWS4-0006Q4-GP; Mon, 10 Feb 2025 11:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWRB-0004NW-Cb
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:09 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR6-0001X8-Ne
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:07 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab7cc0c1a37so142672066b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204102; x=1739808902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YSWMGdWl+8666egd7dZYOBYPozxtU1KxGkBOuAirDQ=;
 b=Nyyh2ewhHyN1icQhR2BAO/wC2g2q48u2Qmsdvni7XlPIdkEPCESX3tl3viRNyfuaEY
 b8KMqSP1YAcjj1Gh4Ws4ykZRgZlQFde8zEtClZGzVe4WazvYaZB2ZX+bmsY12Yil8rwQ
 cWnwIFyXaSuno1RujisJluO2iPl5QpSAh+dW/ZgkhJt0Z4GDukJ9X0hdC3X0L3Xlz/Rv
 F9L6uQI+w6mTRASKLTkMIrJI1hcSXXpl95ZsT/4UkUBLJcth+QMOROvEleWpEL/R3x3Z
 sP8BGDuNTReDIuHODgfE/7QRLbFP5kaoCYzhgUpw9uyM40cbEGQl/2ecotk7vEM678eg
 OT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204102; x=1739808902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YSWMGdWl+8666egd7dZYOBYPozxtU1KxGkBOuAirDQ=;
 b=PhOggnl60QbHB/sBsBtuPcNS2bn/GaoaHb9/YSeI/dGENbOdllWWwjnpucwDuVO2rj
 rWYsLBwgkgAI7a3KUZPrs/ZwM/t1ZFpwD1WPYfgbIFM7uRSizg1yiwCSfg9qulmUjAz1
 QfBg1tXmTk2KqMqVkkAZ1gOWNROEunfmf1Fo71khqBmLEntyqVG2XH5t5EwPO72M9ldg
 Ea4GEzrhVTNqwxhlxMhAkqAj6TP0NSEt+pF9UQ0VO6yopzfqecpnQyJagD/DCVzT/9w+
 c8HAz4tPdRCBx99Dk+vhtFnI3S0TXUtqiMHvk6RwnXBXZIGBOciQCS/cQ+xTnsmd2qed
 y9Sg==
X-Gm-Message-State: AOJu0Yx6XbN5EwgxpAAYKWblCmylKKbcZ2/YYM/5FN1LGbCqTVvbmzNe
 y/B8f7CyFq2KEFPsUJKfX2dOLOVkzQ3BRJXSG/HzaGpkwTgeumUd/WEoZpelsN8=
X-Gm-Gg: ASbGnctWGTF5Alnm0TJUVuBFZQDaYCG4LKlQPGNk0RJR47JFEU+ig1M9XZINqs9tQVi
 6CJPeijutYlMorcHjnWwuZ0IK4jjzJpTRRIwCJBGP4xzHPiJiPgElzLT2YmDG17q1c2w3af5og8
 I+eVhVZ7k0FJD+imTK4AJ88rWv8p9wVqpmHwc8eeHAc/AQQGxwCj9ZdHy8PeRvv+7gagSPPH9zv
 7rItaNWlYQEBfKY2BsTm7VM5rvQKfcGgavjrODxy33Frvtd24JgEVYvUx3nBByjuHOglCtlah3m
 zdOpq/LGt0OCJA3Wyw==
X-Google-Smtp-Source: AGHT+IFvWeP7Cc/rgbQ2LL18D+kQ0m3lplavqv9M9F0opj5SfDa/12SdXHVq4EqfHgkS/9AAVGWKaQ==
X-Received: by 2002:a17:907:948f:b0:aa6:5d30:d971 with SMTP id
 a640c23a62f3a-ab789a688b5mr1460165866b.11.1739204102396; 
 Mon, 10 Feb 2025 08:15:02 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d4d291bdsm55686866b.17.2025.02.10.08.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:15:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0200060384;
 Mon, 10 Feb 2025 16:14:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 13/17] user: Introduce host_interrupt_signal
Date: Mon, 10 Feb 2025 16:14:47 +0000
Message-Id: <20250210161451.3273284-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-Id: <20250207153112.3939799-14-alex.bennee@linaro.org>

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


