Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E66C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLI5-0000PE-5y; Sat, 02 Aug 2025 19:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLHx-0000M8-IM
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:17 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLHv-00012I-SL
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:05:17 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741a6272c8fso138681a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754175914; x=1754780714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1teBz1tpgu95L0I+2UE2HVAE2iWmmgVf0P4YpDt2W3o=;
 b=tVYn1ubtKGFv7hqsxgRA1Pyr3QhFyTK14D7VGhM3fwF6XCJ8ywAEUVVys5o6+B1VWW
 XXjOjBGJCcW5Iu5CgYN2BisNIUs75vGoyW3erVrMdQoPlr1mnRthCAI+ONrkp2lQWxlN
 GsKJ1BLLP8cdg0BtjaS8jiOKJ4t/0V0H4px3DgpqP5cJT0uDq8C+XDJEbNEwq6AUDHnS
 eYrrbPSq+8Dgc/LaMsGh7b6kgIErSjGSZ9/C4E7f/VQGXxGHh+XCSiWlT4LhXgfrk24S
 3jJi5SMqP+5opy7FrfeQjb1bUo3xkTe3TXXzvWa4pIoySuSGgiMunjX7d6E8LGtQSyeZ
 t5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754175914; x=1754780714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1teBz1tpgu95L0I+2UE2HVAE2iWmmgVf0P4YpDt2W3o=;
 b=c1Gq2Q+z82Md3fftcvAQlSWegwiA8YSFL1vo/Ekg994h0tR3T0nTC4U/Q/JsjwnqYt
 57skgqcvHi5pQ86+3Nb6hJ/Tg9rDlozxnmNmVgTBtiAhjr1lv5YwhqJrLHehQwkNiogD
 l25zG2Tm4wwYCi/2JNuaawmOOAK6wP6z82+I5BfE2kAEyBgYflmGgk86Xrbwms2rOyla
 RKsYcXl/qdwlMVNyufsQ3YiZTDVOo0Po67gVxapZI7EkVEWTUsk7xTV4+9TO/MOyDc4u
 OhllLZJwyyNzSvgAEcSupYncym4T1OeNl/VlBMm/n9DmRE3byDr7LsOjRs4iGy5Zem8k
 2PJQ==
X-Gm-Message-State: AOJu0Yx9ypqI94dW7mVexpd77Vv7POWgz/W65tT6aeJgsewKeNf9Iz9v
 ZUXbjNcLn1aU9bE+z1Z1ACKpDz2sv79YubfqB5g0KE6lT2BvNP8gdrfaH2pHuUEl1yimAJ03ZYc
 USlm4yDk=
X-Gm-Gg: ASbGncusa0l1quA6qWjtYp/v1ovw4o6J4AB5TZDD3EeH1ZxFfm8NNzKwuYpECxXOsWF
 GFj3/3xM6f9ToZtuQSoEK0idJR0aVUIUQQ6IwLWhoHcevQuXcAPcq8yqn8fWxrOt5OUyJS+1ZK8
 Ns1DP2qY8bxmLEXczW0uZY3hosC/3nopCmcVZcrd5FhypTpSnT7HEsemTXgTUSLFrorytH6rAq6
 3NbQ48gsOkxzuYiIDX5P1QIsPcnapafICcY3IZlmdWniCUNXJwi1kpUzhh8AaT8nDJHs2NpXoQT
 V/YF2+tpEfqBvCK4oyL5JV1MX7yRb8AgZl229It2MkBFw+VOzy/EK8DQ6fEKyaFxS9k7RX0Fr6W
 RBoCu44VdUbLUHP8Hf69czUg5fryOAEH+UpHrprj9+pvTPM7wZiUXqdJkYfOHoNc=
X-Google-Smtp-Source: AGHT+IHlGc+P1F7URvQ4im32KFVhTjCF8nMUgoBLSvtkGXLanyC6rPcWlEUFkipTcv/PA/ruUiOhuw==
X-Received: by 2002:a05:6830:438b:b0:72c:320c:d960 with SMTP id
 46e09a7af769-7419d287c4cmr2596065a34.15.1754175913840; 
 Sat, 02 Aug 2025 16:05:13 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.05.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:05:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/95] semihosting: Retrieve stack top from image_info
Date: Sun,  3 Aug 2025 09:03:25 +1000
Message-ID: <20250802230459.412251-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Remove the write-once field TaskState.stack_base, and use the
same value from struct image_info.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/qemu.h             | 1 -
 linux-user/aarch64/cpu_loop.c | 1 -
 linux-user/arm/cpu_loop.c     | 1 -
 linux-user/m68k/cpu_loop.c    | 1 -
 linux-user/riscv/cpu_loop.c   | 1 -
 semihosting/arm-compat-semi.c | 6 +++++-
 6 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 0b19fa43e6..b6621536b3 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -127,7 +127,6 @@ struct TaskState {
     abi_ulong heap_base;
     abi_ulong heap_limit;
 #endif
-    abi_ulong stack_base;
     int used; /* non zero if used */
     struct image_info *info;
     struct linux_binprm *bprm;
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index fea43cefa6..b65999a75b 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -168,7 +168,6 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         qemu_guest_getrandom_nofail(&env->keys, sizeof(env->keys));
     }
 
-    ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
     ts->heap_limit = 0;
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 33f63951a9..e40d6beafa 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -504,7 +504,6 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     arm_rebuild_hflags(env);
 #endif
 
-    ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
     ts->heap_limit = 0;
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index 5da91b997a..3aaaf02ca4 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -117,7 +117,6 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
     env->aregs[7] = regs->usp;
     env->sr = regs->sr;
 
-    ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
     ts->heap_limit = 0;
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 3ac8bbfec1..541de765ff 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -109,7 +109,6 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         exit(EXIT_FAILURE);
     }
 
-    ts->stack_base = info->start_stack;
     ts->heap_base = info->brk;
     /* This will be filled in on the first SYS_HEAPINFO call.  */
     ts->heap_limit = 0;
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 86e5260e50..bc04b02eba 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -696,7 +696,11 @@ void do_common_semihosting(CPUState *cs)
 
             retvals[0] = ts->heap_base;
             retvals[1] = ts->heap_limit;
-            retvals[2] = ts->stack_base;
+            /*
+             * Note that semihosting is *not* thread aware.
+             * Always return the stack base of the main thread.
+             */
+            retvals[2] = ts->info->start_stack;
             retvals[3] = 0; /* Stack limit.  */
 #else
             retvals[0] = info.heapbase;  /* Heap Base */
-- 
2.43.0


