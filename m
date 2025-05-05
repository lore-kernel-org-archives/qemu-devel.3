Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3EDC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1pK-0001Z1-IL; Mon, 05 May 2025 15:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1pI-0001Xr-ME
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:50:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1pF-0004jf-HF
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:50:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso6969290b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746474604; x=1747079404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yR1HKmXCPfGdsdtQ5AgCLnBtqE1jcfbBbaMp/JIfNKs=;
 b=HXjJxSDab6qNv/f2GYxTW3pEYie+e5XMl7cVCCepNGqrbYhaanylfDesxOES6DAKbL
 xX1S7UDFdbdrIk0mYjwpP9+deRfPWQxInZ4OdeItYFuiMQhSuY5nysFf98tY4ycgajmI
 DNSLkMlQ/z5YFHJfKVhcy45J4sQcFTyNYg6XZGUImbUhazrROumZCGhm/eQm7bmfbAw4
 Ps+SzAxF1YhgnOKrGBX/4xqPaQsqGGfVwnJIc2S4oK0OKTjQ/WtHd66uq+2IjglhIieQ
 LaVBKpBlXVb2Bf3x5XUlVgn4NLMBuRgObe4hH99bjtlw8zcsdpJpzu7KqtuCZLkZxaGF
 tzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746474604; x=1747079404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yR1HKmXCPfGdsdtQ5AgCLnBtqE1jcfbBbaMp/JIfNKs=;
 b=NjRRcV9fJqE7KnkJPQKQSX520AN6ybHGnD18dJIwyso1wWDZZJkf/z3r5SaAsCzgQs
 iMBJqCvyihdezA1GE6qFNsagdfP2uO16nziywhJpeBqsLGk3lSSIg+5IyT8iv+Nwksah
 jN+EF5neprSSMinC63uQALfXnjcW8okxJZCJ5YBy87y2Q040imHOh2wGsdsBpqbBcC1T
 lFsAq2dDKKDnqbwnAa9RxFNnE1qjsscC8jtPj9SbgTZ4GfsumqJHLF30HyQ71pbhWNcs
 O2EFzFiDewURxW8c84+GvNxO8Iu+kig5JViFEo8WlYvSI9G7n6k5UJSmh3x0sjK4TRrf
 Ldrg==
X-Gm-Message-State: AOJu0YwaRuKURkex/rl628KacEkMC7umx0q+V4K4QYYa7codqevWg8ZO
 jCr0p0YKvS0JgepXZpIrfpv2QmPI9pavTShj4YzRTCOyiZw+EviaqPaX/ehdIBUMNhWrPjdHHDT
 4
X-Gm-Gg: ASbGncv4U9dMfkUK986nAFRgB9jJujSmz7OJjxRg725Hupz9mZGpI2pybdQeZKEHfKp
 kLFTT+GANFJkiqNXiZmaCTX4Vfwwxgazd7D0/lem/Q3iPRbqK0mIjumadICd/4lOzRlfYhYSvlk
 KxMx3Xiztfu8p9id6MHP/Ygs32eQhsjlgdXe4oIsTeUygd9TzIjgPG6gT7VhUi3ebq9ZSdj40j7
 we1aOi2QnkIzoh2n/SPisc1080Nlc25TNYAS4ZUOAJcg4c732Axp/bOFfYGdM0pedPJJ1qEwOjf
 8Suze9LqDJAIcyu7sDnJsOO2ewPanO4y5opJA57OvL3J20F7vN1KbcQ7D4Zo63wD/pFO8XmX4Rs
 =
X-Google-Smtp-Source: AGHT+IHS7J3paT78pHLkapBIQ9lDchzYzOfIiktSi3QpAt1ZUZFS7u2XXlIOZREfpd4W82OauePA4w==
X-Received: by 2002:a05:6a00:ab86:b0:736:a77d:5412 with SMTP id
 d2e1a72fcca58-740919f4923mr652186b3a.12.1746474603738; 
 Mon, 05 May 2025 12:50:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058df2a6csm7275900b3a.81.2025.05.05.12.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 12:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL v2 48/59] accel/tcg: Use vaddr in cpu_loop.h
Date: Mon,  5 May 2025 12:50:01 -0700
Message-ID: <20250505195001.3479169-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505195001.3479169-1-richard.henderson@linaro.org>
References: <20250505195001.3479169-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Use vaddr instead of abi_ptr or target_ulong for a guest address.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/cpu_loop.h | 12 +++++-------
 accel/tcg/user-exec.c   |  2 +-
 bsd-user/signal.c       |  4 ++--
 linux-user/signal.c     |  4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/user/cpu_loop.h b/include/user/cpu_loop.h
index 589c66543f..ad8a1d711f 100644
--- a/include/user/cpu_loop.h
+++ b/include/user/cpu_loop.h
@@ -20,11 +20,9 @@
 #ifndef USER_CPU_LOOP_H
 #define USER_CPU_LOOP_H
 
-#include "exec/abi_ptr.h"
+#include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
-#include "exec/log.h"
-#include "exec/target_long.h"
-#include "special-errno.h"
+
 
 /**
  * adjust_signal_pc:
@@ -46,7 +44,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write);
  * Return true if the write fault has been handled, and should be re-tried.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr);
+                                 uintptr_t host_pc, vaddr guest_addr);
 
 /**
  * cpu_loop_exit_sigsegv:
@@ -59,7 +57,7 @@ bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGSEGV, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                                       MMUAccessType access_type,
                                       bool maperr, uintptr_t ra);
 
@@ -73,7 +71,7 @@ G_NORETURN void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
  * Use the TCGCPUOps hook to record cpu state, do guest operating system
  * specific things to raise SIGBUS, and jump to the main cpu loop.
  */
-G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+G_NORETURN void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                                      MMUAccessType access_type,
                                      uintptr_t ra);
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 68e01fc584..e1f4c4eacf 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -126,7 +126,7 @@ MMUAccessType adjust_signal_pc(uintptr_t *pc, bool is_write)
  * guest, we'd end up in an infinite loop of retrying the faulting access.
  */
 bool handle_sigsegv_accerr_write(CPUState *cpu, sigset_t *old_set,
-                                 uintptr_t host_pc, abi_ptr guest_addr)
+                                 uintptr_t host_pc, vaddr guest_addr)
 {
     switch (page_unprotect(cpu, guest_addr, host_pc)) {
     case 0:
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 1aa0fd79d6..dadcc037dc 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -1030,7 +1030,7 @@ void process_pending_signals(CPUArchState *env)
     ts->in_sigsuspend = false;
 }
 
-void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
@@ -1046,7 +1046,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
     cpu_loop_exit_restore(cpu, ra);
 }
 
-void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 4dafc2c3a2..cd0e7398aa 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -750,7 +750,7 @@ void force_sigsegv(int oldsig)
 }
 #endif
 
-void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigsegv(CPUState *cpu, vaddr addr,
                            MMUAccessType access_type, bool maperr, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
@@ -766,7 +766,7 @@ void cpu_loop_exit_sigsegv(CPUState *cpu, target_ulong addr,
     cpu_loop_exit_restore(cpu, ra);
 }
 
-void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
+void cpu_loop_exit_sigbus(CPUState *cpu, vaddr addr,
                           MMUAccessType access_type, uintptr_t ra)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-- 
2.43.0


