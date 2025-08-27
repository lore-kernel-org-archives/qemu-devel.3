Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15950CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRW-0001MJ-2H; Wed, 27 Aug 2025 19:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRU-0001KA-Ba
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:36 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRS-00046t-Dt
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:36 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32326e5f0bfso315327a91.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336832; x=1756941632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvTG6S97liWsArsykSMZMkGcdgNUE7efYe1n52Jwhg8=;
 b=Nfhbde0RrVY+HkgWftZqIziBRine3GyiWG3WwtdOKLzQ+UfDq5ZTswaFkKoFkmRZ3e
 XkmEnUM6RdlLzQ+SUqeRE5RpTvvXeXJGRbgVuGDyoljMcQMXHKO2fxmeFwxsdpjDkeJn
 EOukfBu5hwbB1OedxpBFEJrSZu7Yj1x2MB4X9XOY/+Gqq+9+nYs8CdLJPeAH2ttAHBV5
 Wib6tOIP/d5F9hJD4R2ZXD/Cu81mAzB5OmIJgW2PqQL1LQhW597WVvqnpe+fFYK2iKW7
 ltoFQqEk/QHHd6+3RJpvPl5PBWmF+bV24W62wQrA51TTYXsFmIe1jcrUYMXV8+kLunaB
 PXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336832; x=1756941632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvTG6S97liWsArsykSMZMkGcdgNUE7efYe1n52Jwhg8=;
 b=ptLlXzWbxp5dkP4GABozQTsVCBAG5VG8pR00zE3M8AohazIVl1dL/SYRfdM3YZyqyX
 jg3CzCnG52hPRShoYeknBdR/ryHINrkJOLSjF7qdX4wrE3oZ6F6bbZPvqZeCHYGdJo0a
 qDVm4Z52s65JByaQGtIDTmI8hsXWLZlAN3OdGCpkbftlZMGLsky3GBNNugTlYRFCQ4lb
 n9GOpjM09ZKrX2Qu0r/3v4ooBkBmE8sIlwPpyyXTIpTvOeBl49Au+XQzwAdxI4AfnWT3
 ubP82l8+vyibEWHfdcrWfUJes+qprAAbALbGLogQq2N3yufvnG9hbge7V57TNLegonQ/
 SU7g==
X-Gm-Message-State: AOJu0Yyhvjryap5eWTAIik2B2VdtBZ+TQwKDXtv6JHzqARZa8QCgutir
 /2szG2jMbv0rD3J9ZFg7WynlZvuJZeDwnaOCaP+DQTR+VGl0niN+pfj8BqrqMB7CYIu8t8T8Hnu
 dFIyaRUs=
X-Gm-Gg: ASbGnctwy50soPZcNOSPOreM5mNhbrmPabSQCzbE10O2+gAJLYFTsGKQjb2RyKjcEpC
 pG5aKDYVXhcxYMWIb3N7CPbqwMLkbZ3/jRI9O9WTYQNLqqPNOIWJJfWQlI9i8+YFZJIG1gfQ3tL
 6E2MouNUij7DqyPsTqgA2eF6t8dOvSHup/REAV1gRXpn4VuZ7RcLDt3UxD1029QcKWyWewocIBd
 IRvVVBmB9wRkcxUKffhtHBIyXgc9DVsUu7csAXVUXxsq7zlTtufpiUapQeNHgyFfK4lCAnJlf3a
 XfesxUTmC05eFtt0KZfDAERbIl/2sdSjwUZYbtZSc0YVqcgMQ2YMdd9Mqv+jbmh6NsO9eDkxtEG
 F81MUnsrDkTwosVh2hlUxFj4scOgNxFbxCAA9Kdqcc33pfto=
X-Google-Smtp-Source: AGHT+IH7hUVSYVSSeP3dVAtJlQxVli/0DdOLGOM+GA72vUdvEo3gEd+bzkgNwJeMIljRU2mY70vWAA==
X-Received: by 2002:a17:90b:258c:b0:323:265e:d9d6 with SMTP id
 98e67ed59e1d1-32515edd530mr28682813a91.6.1756336832559; 
 Wed, 27 Aug 2025 16:20:32 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/46] semihosting: Retrieve stack top from image_info
Date: Thu, 28 Aug 2025 09:19:38 +1000
Message-ID: <20250827232023.50398-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


