Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50563C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFk-00041c-OE; Wed, 15 May 2024 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFc-0003wb-Dt
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFW-0003AK-Q1
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41ff5e3dc3bso39439465e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785737; x=1716390537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmdY83sMBqsJ6J92iPIEFflQV4nP5SinQ+Wwfv7WG8M=;
 b=hiY+ChkmTWBauf0q8+o44uxZ01G1KpHmu/TwJDoYu2lBcFSCpET6cPb/sbM4pB3ZSB
 oY6gwz7SYTdJ5s/QXMljVSo3BCyte92+LidXxv+rkZl8qJYGi0MylrvN9uafHV5lXr+H
 XsBrpvWzCtuUQsj6mhWIQTtfmo6lJPsrq0yv244tDKlRDjqb1yzCM4VGCGQsVceXCIg2
 HeKQNG0ZYLuUvXbzMH6K9z6FsVtuSb9os0lSzlnjsKtE4INWGIsNDe1vidqubpDXn/cp
 bXRpaeKOJJx36Bymt8dtcjM0REvaoFfNGdffyroGOio9+BYAiBrMiwzPnWC8f/HUNJaF
 5WTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785737; x=1716390537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NmdY83sMBqsJ6J92iPIEFflQV4nP5SinQ+Wwfv7WG8M=;
 b=gmh/mAgN89VSrdg9xo35p6FAZgXARhFQ5UDmovnlnSj/P4Tj7H42kY4LxqClIoL/Ac
 S2LT60GB9KtiPgd89yWWo9M4g3kz8l+WVkMrpy/2NGbpx2HTWo4hxZQ/FxI+qdt8GYsK
 /ahzNlOvOrKEALSseGM0myeTtekODyP35/eFJSrgaordbjo30VTQ/+Odc7uzDGuhxjY0
 IBibuv/VPST+fI2LCNEmuewWx80X9khgy1f34FkhzoyKft5WnKJOe80Bdf6ykdFR16KD
 RsRefqu7HBZDCL/DdZ8lHH7/Aj6zKaRY/Kr0GgPTaWZxE22bvLoMlBXX+D6EQ8iMwbt8
 wWFQ==
X-Gm-Message-State: AOJu0YykbHh7HJLahjR+yeWGNylE/odGZ+MYYgXrmX9nWyzhoOvfQSu2
 JS/gWkRNuvrlervPQ1zdGbeT6JIpbojaLA4BiEed/X38h7Ozl3U/TyzZX0a6F9ODmSd11spmA2X
 XnkI=
X-Google-Smtp-Source: AGHT+IEAiQo6eVSGyki8FLMcuqpXNp1+CVMfQuFXoe2zSnLo/quj2YQxbmz4rdunbGG3DRzc+JGx3A==
X-Received: by 2002:a05:600c:468c:b0:420:1067:d698 with SMTP id
 5b1f17b1804b1-4201067d80bmr88255775e9.23.1715785737104; 
 Wed, 15 May 2024 08:08:57 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 22/28] linux-user/i386: Fix allocation and alignment of fp
 state
Date: Wed, 15 May 2024 17:08:31 +0200
Message-Id: <20240515150837.259747-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

For modern cpus, the kernel uses xsave to store all extra
cpu state across the signal handler.  For xsave/xrstor to
work, the pointer must be 64 byte aligned.  Moreover, the
regular part of the signal frame must be 16 byte aligned.

Attempt to mirror the kernel code as much as possible.
Use enum FPStateKind instead of use_xsave() and use_fxsr().

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1648
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c         | 558 +++++++++++++++++++------------
 tests/tcg/x86_64/test-1648.c     |  33 ++
 tests/tcg/x86_64/Makefile.target |   1 +
 3 files changed, 377 insertions(+), 215 deletions(-)
 create mode 100644 tests/tcg/x86_64/test-1648.c

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 03031ef9e5..95dd01820d 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -65,20 +65,6 @@ struct target_fpstate_32 {
     X86LegacyXSaveArea fxstate;
 };
 
-/*
- * For simplicity, setup_frame aligns struct target_fpstate_32 to
- * 16 bytes, so ensure that the FXSAVE area is also aligned.
- */
-QEMU_BUILD_BUG_ON(offsetof(struct target_fpstate_32, fxstate) & 15);
-
-#ifndef TARGET_X86_64
-# define target_fpstate target_fpstate_32
-# define TARGET_FPSTATE_FXSAVE_OFFSET offsetof(struct target_fpstate_32, fxstate)
-#else
-# define target_fpstate X86LegacyXSaveArea
-# define TARGET_FPSTATE_FXSAVE_OFFSET 0
-#endif
-
 struct target_sigcontext_32 {
     uint16_t gs, __gsh;
     uint16_t fs, __fsh;
@@ -161,24 +147,16 @@ struct sigframe {
     int sig;
     struct target_sigcontext sc;
     /*
-     * The actual fpstate is placed after retcode[] below, to make
-     * room for the variable-sized xsave data.  The older unused fpstate
-     * has to be kept to avoid changing the offset of extramask[], which
+     * The actual fpstate is placed after retcode[] below, to make room
+     * for the variable-sized xsave data.  The older unused fpstate has
+     * to be kept to avoid changing the offset of extramask[], which
      * is part of the ABI.
      */
-    struct target_fpstate fpstate_unused;
+    struct target_fpstate_32 fpstate_unused;
     abi_ulong extramask[TARGET_NSIG_WORDS-1];
     char retcode[8];
-
-    /*
-     * This field will be 16-byte aligned in memory.  Applying QEMU_ALIGNED
-     * to it ensures that the base of the frame has an appropriate alignment
-     * too.
-     */
-    struct target_fpstate fpstate QEMU_ALIGNED(8);
+    /* fp state follows here */
 };
-#define TARGET_SIGFRAME_FXSAVE_OFFSET (                                    \
-    offsetof(struct sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
 
 struct rt_sigframe {
     abi_ulong pretcode;
@@ -188,10 +166,8 @@ struct rt_sigframe {
     struct target_siginfo info;
     struct target_ucontext uc;
     char retcode[8];
-    struct target_fpstate fpstate QEMU_ALIGNED(8);
+    /* fp state follows here */
 };
-#define TARGET_RT_SIGFRAME_FXSAVE_OFFSET (                                 \
-    offsetof(struct rt_sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
 
 /*
  * Verify that vdso-asmoffset.h constants match.
@@ -209,66 +185,178 @@ struct rt_sigframe {
     abi_ulong pretcode;
     struct target_ucontext uc;
     struct target_siginfo info;
-    struct target_fpstate fpstate QEMU_ALIGNED(16);
+    /* fp state follows here */
 };
-#define TARGET_RT_SIGFRAME_FXSAVE_OFFSET (                                 \
-    offsetof(struct rt_sigframe, fpstate) + TARGET_FPSTATE_FXSAVE_OFFSET)
 #endif
 
+typedef enum {
+#ifndef TARGET_X86_64
+    FPSTATE_FSAVE,
+#endif
+    FPSTATE_FXSAVE,
+    FPSTATE_XSAVE
+} FPStateKind;
+
+static FPStateKind get_fpstate_kind(CPUX86State *env)
+{
+    if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
+        return FPSTATE_XSAVE;
+    }
+#ifdef TARGET_X86_64
+    return FPSTATE_FXSAVE;
+#else
+    if (env->features[FEAT_1_EDX] & CPUID_FXSR) {
+        return FPSTATE_FXSAVE;
+    }
+    return FPSTATE_FSAVE;
+#endif
+}
+
+static unsigned get_fpstate_size(CPUX86State *env, FPStateKind fpkind)
+{
+    /*
+     * Kernel:
+     *   fpu__alloc_mathframe
+     *     xstate_sigframe_size(current->thread.fpu.fpstate);
+     *       size = fpstate->user_size
+     *       use_xsave() ? size + FP_XSTATE_MAGIC2_SIZE : size
+     *   where fpstate->user_size is computed at init in
+     *   fpu__init_system_xstate_size_legacy and
+     *   fpu__init_system_xstate.
+     *
+     * Here we have no place to pre-compute, so inline it all.
+     */
+    switch (fpkind) {
+    case FPSTATE_XSAVE:
+        return (xsave_area_size(env->xcr0, false)
+                + TARGET_FP_XSTATE_MAGIC2_SIZE);
+    case FPSTATE_FXSAVE:
+        return sizeof(X86LegacyXSaveArea);
+#ifndef TARGET_X86_64
+    case FPSTATE_FSAVE:
+        return sizeof(struct target_fregs_state);
+#endif
+    }
+    g_assert_not_reached();
+}
+
+static abi_ptr get_sigframe(struct target_sigaction *ka, CPUX86State *env,
+                            unsigned frame_size, FPStateKind fpkind,
+                            abi_ptr *fpstate, abi_ptr *fxstate, abi_ptr *fpend)
+{
+    abi_ptr sp;
+    unsigned math_size;
+
+    /* Default to using normal stack */
+    sp = get_sp_from_cpustate(env);
+#ifdef TARGET_X86_64
+    sp -= 128; /* this is the redzone */
+#endif
+
+    /* This is the X/Open sanctioned signal stack switching.  */
+    if (ka->sa_flags & TARGET_SA_ONSTACK) {
+        sp = target_sigsp(sp, ka);
+    } else {
+#ifndef TARGET_X86_64
+        /* This is the legacy signal stack switching. */
+        if ((env->segs[R_SS].selector & 0xffff) != __USER_DS
+            && !(ka->sa_flags & TARGET_SA_RESTORER)
+            && ka->sa_restorer) {
+            sp = ka->sa_restorer;
+        }
+#endif
+    }
+
+    math_size = get_fpstate_size(env, fpkind);
+    sp = ROUND_DOWN(sp - math_size, 64);
+    *fpend = sp + math_size;
+    *fxstate = sp;
+#ifndef TARGET_X86_64
+    if (fpkind != FPSTATE_FSAVE) {
+        sp -= sizeof(struct target_fregs_state);
+    }
+#endif
+    *fpstate = sp;
+
+    sp -= frame_size;
+    /*
+     * Align the stack pointer according to the ABI, i.e. so that on
+     * function entry ((sp + sizeof(return_addr)) & 15) == 0.
+     */
+    sp += sizeof(target_ulong);
+    sp = ROUND_DOWN(sp, 16);
+    sp -= sizeof(target_ulong);
+
+    return sp;
+}
+
 /*
  * Set up a signal frame.
  */
 
-static void xsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
-                             abi_ulong fxsave_addr)
+static void fxsave_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxstate,
+                              abi_ptr fxstate_addr)
 {
-    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+    struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
 
-    if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
-        /* fxsave_addr must be 16 byte aligned for fxsave */
-        assert(!(fxsave_addr & 0xf));
-
-        cpu_x86_fxsave(env, fxsave_addr);
-        __put_user(0, &sw->magic1);
-    } else {
-        uint32_t xstate_size = xsave_area_size(env->xcr0, false);
-
-        /*
-         * extended_size is the offset from fpstate_addr to right after the end
-         * of the extended save states.  On 32-bit that includes the legacy
-         * FSAVE area.
-         */
-        uint32_t extended_size = TARGET_FPSTATE_FXSAVE_OFFSET
-            + xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE;
-
-        /* fxsave_addr must be 64 byte aligned for xsave */
-        assert(!(fxsave_addr & 0x3f));
-
-        /* Zero the header, XSAVE *adds* features to an existing save state.  */
-        memset(fxsave + 1, 0, sizeof(X86XSaveHeader));
-        cpu_x86_xsave(env, fxsave_addr, -1);
-        __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
-        __put_user(extended_size, &sw->extended_size);
-        __put_user(env->xcr0, &sw->xfeatures);
-        __put_user(xstate_size, &sw->xstate_size);
-        __put_user(TARGET_FP_XSTATE_MAGIC2,
-                   (uint32_t *)((void *)fxsave + xstate_size));
-    }
+    /* fxstate_addr must be 16 byte aligned for fxsave */
+    assert(!(fxstate_addr & 0xf));
+    cpu_x86_fxsave(env, fxstate_addr);
+    __put_user(0, &sw->magic1);
 }
 
-static void setup_sigcontext(struct target_sigcontext *sc,
-        struct target_fpstate *fpstate, CPUX86State *env, abi_ulong mask,
-        abi_ulong fpstate_addr)
+static void xsave_sigcontext(CPUX86State *env,
+                             X86LegacyXSaveArea *fxstate,
+                             abi_ptr fpstate_addr,
+                             abi_ptr xstate_addr,
+                             abi_ptr fpend_addr)
+{
+    struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
+    /*
+     * extended_size is the offset from fpstate_addr to right after
+     * the end of the extended save states.  On 32-bit that includes
+     * the legacy FSAVE area.
+     */
+    uint32_t extended_size = fpend_addr - fpstate_addr;
+    /* Recover xstate_size by removing magic2. */
+    uint32_t xstate_size = (fpend_addr - xstate_addr
+                            - TARGET_FP_XSTATE_MAGIC2_SIZE);
+    /* magic2 goes just after xstate. */
+    uint32_t *magic2 = (void *)fxstate + xstate_size;
+
+    /* xstate_addr must be 64 byte aligned for xsave */
+    assert(!(xstate_addr & 0x3f));
+
+    /* Zero the header, XSAVE *adds* features to an existing save state.  */
+    memset(fxstate + 1, 0, sizeof(X86XSaveHeader));
+    cpu_x86_xsave(env, xstate_addr, -1);
+
+    __put_user(TARGET_FP_XSTATE_MAGIC1, &sw->magic1);
+    __put_user(extended_size, &sw->extended_size);
+    __put_user(env->xcr0, &sw->xfeatures);
+    __put_user(xstate_size, &sw->xstate_size);
+    __put_user(TARGET_FP_XSTATE_MAGIC2, magic2);
+}
+
+static void setup_sigcontext(CPUX86State *env,
+                             struct target_sigcontext *sc,
+                             abi_ulong mask, FPStateKind fpkind,
+                             struct target_fregs_state *fpstate,
+                             abi_ptr fpstate_addr,
+                             X86LegacyXSaveArea *fxstate,
+                             abi_ptr fxstate_addr,
+                             abi_ptr fpend_addr)
 {
     CPUState *cs = env_cpu(env);
+
 #ifndef TARGET_X86_64
     uint16_t magic;
 
     /* already locked in setup_frame() */
-    __put_user(env->segs[R_GS].selector, (unsigned int *)&sc->gs);
-    __put_user(env->segs[R_FS].selector, (unsigned int *)&sc->fs);
-    __put_user(env->segs[R_ES].selector, (unsigned int *)&sc->es);
-    __put_user(env->segs[R_DS].selector, (unsigned int *)&sc->ds);
+    __put_user(env->segs[R_GS].selector, (uint32_t *)&sc->gs);
+    __put_user(env->segs[R_FS].selector, (uint32_t *)&sc->fs);
+    __put_user(env->segs[R_ES].selector, (uint32_t *)&sc->es);
+    __put_user(env->segs[R_DS].selector, (uint32_t *)&sc->ds);
     __put_user(env->regs[R_EDI], &sc->edi);
     __put_user(env->regs[R_ESI], &sc->esi);
     __put_user(env->regs[R_EBP], &sc->ebp);
@@ -280,21 +368,15 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user(cs->exception_index, &sc->trapno);
     __put_user(env->error_code, &sc->err);
     __put_user(env->eip, &sc->eip);
-    __put_user(env->segs[R_CS].selector, (unsigned int *)&sc->cs);
+    __put_user(env->segs[R_CS].selector, (uint32_t *)&sc->cs);
     __put_user(env->eflags, &sc->eflags);
     __put_user(env->regs[R_ESP], &sc->esp_at_signal);
-    __put_user(env->segs[R_SS].selector, (unsigned int *)&sc->ss);
+    __put_user(env->segs[R_SS].selector, (uint32_t *)&sc->ss);
 
     cpu_x86_fsave(env, fpstate_addr, 1);
-    fpstate->fpstate.status = fpstate->fpstate.swd;
-    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-        magic = 0xffff;
-    } else {
-        xsave_sigcontext(env, &fpstate->fxstate,
-                         fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
-        magic = 0;
-    }
-    __put_user(magic, &fpstate->fpstate.magic);
+    fpstate->status = fpstate->swd;
+    magic = (fpkind == FPSTATE_FSAVE ? 0 : 0xffff);
+    __put_user(magic, &fpstate->magic);
 #else
     __put_user(env->regs[R_EDI], &sc->rdi);
     __put_user(env->regs[R_ESI], &sc->rsi);
@@ -323,57 +405,25 @@ static void setup_sigcontext(struct target_sigcontext *sc,
     __put_user((uint16_t)0, &sc->gs);
     __put_user((uint16_t)0, &sc->fs);
     __put_user(env->segs[R_SS].selector, &sc->ss);
-
-    xsave_sigcontext(env, fpstate, fpstate_addr);
 #endif
 
-    __put_user(fpstate_addr, &sc->fpstate);
+    switch (fpkind) {
+    case FPSTATE_XSAVE:
+        xsave_sigcontext(env, fxstate, fpstate_addr, fxstate_addr, fpend_addr);
+        break;
+    case FPSTATE_FXSAVE:
+        fxsave_sigcontext(env, fxstate, fxstate_addr);
+        break;
+    default:
+        break;
+    }
 
+    __put_user(fpstate_addr, &sc->fpstate);
     /* non-iBCS2 extensions.. */
     __put_user(mask, &sc->oldmask);
     __put_user(env->cr[2], &sc->cr2);
 }
 
-/*
- * Determine which stack to use..
- */
-
-static inline abi_ulong
-get_sigframe(struct target_sigaction *ka, CPUX86State *env, size_t fxsave_offset)
-{
-    unsigned long esp;
-
-    /* Default to using normal stack */
-    esp = get_sp_from_cpustate(env);
-#ifdef TARGET_X86_64
-    esp -= 128; /* this is the redzone */
-#endif
-
-    /* This is the X/Open sanctioned signal stack switching.  */
-    if (ka->sa_flags & TARGET_SA_ONSTACK) {
-        esp = target_sigsp(esp, ka);
-    } else {
-#ifndef TARGET_X86_64
-        /* This is the legacy signal stack switching. */
-        if ((env->segs[R_SS].selector & 0xffff) != __USER_DS &&
-                !(ka->sa_flags & TARGET_SA_RESTORER) &&
-                ka->sa_restorer) {
-            esp = (unsigned long) ka->sa_restorer;
-        }
-#endif
-    }
-
-    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-        return (esp - (fxsave_offset + sizeof(X86LegacyXSaveArea))) & -8ul;
-    } else if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
-        return ((esp - sizeof(X86LegacyXSaveArea)) & -16ul) - fxsave_offset;
-    } else {
-        size_t xstate_size =
-               xsave_area_size(env->xcr0, false) + TARGET_FP_XSTATE_MAGIC2_SIZE;
-        return ((esp - xstate_size) & -64ul) - fxsave_offset;
-    }
-}
-
 #ifndef TARGET_X86_64
 static void install_sigtramp(void *tramp)
 {
@@ -395,20 +445,36 @@ static void install_rt_sigtramp(void *tramp)
 void setup_frame(int sig, struct target_sigaction *ka,
                  target_sigset_t *set, CPUX86State *env)
 {
-    abi_ulong frame_addr;
+    abi_ptr frame_addr, fpstate_addr, fxstate_addr, fpend_addr;
     struct sigframe *frame;
-    int i;
+    struct target_fregs_state *fpstate;
+    X86LegacyXSaveArea *fxstate;
+    unsigned total_size;
+    FPStateKind fpkind;
 
-    frame_addr = get_sigframe(ka, env, TARGET_SIGFRAME_FXSAVE_OFFSET);
+    fpkind = get_fpstate_kind(env);
+    frame_addr = get_sigframe(ka, env, sizeof(struct sigframe), fpkind,
+                              &fpstate_addr, &fxstate_addr, &fpend_addr);
     trace_user_setup_frame(env, frame_addr);
 
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
-        goto give_sigsegv;
+    total_size = fpend_addr - frame_addr;
+    frame = lock_user(VERIFY_WRITE, frame_addr, total_size, 0);
+    if (!frame) {
+        force_sigsegv(sig);
+        return;
+    }
 
-    setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
-            frame_addr + offsetof(struct sigframe, fpstate));
+    fxstate = (void *)frame + (fxstate_addr - frame_addr);
+#ifdef TARGET_X86_64
+    fpstate = NULL;
+#else
+    fpstate = (void *)frame + (fpstate_addr - frame_addr);
+#endif
 
-    for (i = 1; i < TARGET_NSIG_WORDS; i++) {
+    setup_sigcontext(env, &frame->sc, set->sig[0], fpkind,
+                     fpstate, fpstate_addr, fxstate, fxstate_addr, fpend_addr);
+
+    for (int i = 1; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
 
@@ -421,6 +487,7 @@ void setup_frame(int sig, struct target_sigaction *ka,
         install_sigtramp(frame->retcode);
         __put_user(default_sigreturn, &frame->pretcode);
     }
+    unlock_user(frame, frame_addr, total_size);
 
     /* Set up registers for signal handler */
     env->regs[R_ESP] = frame_addr;
@@ -438,13 +505,6 @@ void setup_frame(int sig, struct target_sigaction *ka,
     cpu_x86_load_seg(env, R_SS, __USER_DS);
     cpu_x86_load_seg(env, R_CS, __USER_CS);
     env->eflags &= ~TF_MASK;
-
-    unlock_user_struct(frame, frame_addr, 1);
-
-    return;
-
-give_sigsegv:
-    force_sigsegv(sig);
 }
 #endif
 
@@ -453,37 +513,51 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_siginfo_t *info,
                     target_sigset_t *set, CPUX86State *env)
 {
-    abi_ulong frame_addr;
+    abi_ptr frame_addr, fpstate_addr, fxstate_addr, fpend_addr;
     struct rt_sigframe *frame;
-    int i;
+    X86LegacyXSaveArea *fxstate;
+    struct target_fregs_state *fpstate;
+    unsigned total_size;
+    FPStateKind fpkind;
 
-    frame_addr = get_sigframe(ka, env, TARGET_RT_SIGFRAME_FXSAVE_OFFSET);
+    fpkind = get_fpstate_kind(env);
+    frame_addr = get_sigframe(ka, env, sizeof(struct rt_sigframe), fpkind,
+                              &fpstate_addr, &fxstate_addr, &fpend_addr);
     trace_user_setup_rt_frame(env, frame_addr);
 
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
+    total_size = fpend_addr - frame_addr;
+    frame = lock_user(VERIFY_WRITE, frame_addr, total_size, 0);
+    if (!frame) {
         goto give_sigsegv;
+    }
 
     if (ka->sa_flags & TARGET_SA_SIGINFO) {
         frame->info = *info;
     }
 
     /* Create the ucontext.  */
-    if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
-        __put_user(1, &frame->uc.tuc_flags);
-    } else {
-        __put_user(0, &frame->uc.tuc_flags);
-    }
+    __put_user(fpkind == FPSTATE_XSAVE, &frame->uc.tuc_flags);
     __put_user(0, &frame->uc.tuc_link);
     target_save_altstack(&frame->uc.tuc_stack, env);
-    setup_sigcontext(&frame->uc.tuc_mcontext, &frame->fpstate, env,
-            set->sig[0], frame_addr + offsetof(struct rt_sigframe, fpstate));
 
-    for (i = 0; i < TARGET_NSIG_WORDS; i++) {
+    fxstate = (void *)frame + (fxstate_addr - frame_addr);
+#ifdef TARGET_X86_64
+    fpstate = NULL;
+#else
+    fpstate = (void *)frame + (fpstate_addr - frame_addr);
+#endif
+
+    setup_sigcontext(env, &frame->uc.tuc_mcontext, set->sig[0], fpkind,
+                     fpstate, fpstate_addr, fxstate, fxstate_addr, fpend_addr);
+
+    for (int i = 0; i < TARGET_NSIG_WORDS; i++) {
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
 
-    /* Set up to return from userspace.  If provided, use a stub
-       already in userspace.  */
+    /*
+     * Set up to return from userspace.  If provided, use a stub
+     * already in userspace.
+     */
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         __put_user(ka->sa_restorer, &frame->pretcode);
     } else {
@@ -515,60 +589,113 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->regs[R_ESI] = frame_addr + offsetof(struct rt_sigframe, info);
     env->regs[R_EDX] = frame_addr + offsetof(struct rt_sigframe, uc);
 #endif
+    unlock_user(frame, frame_addr, total_size);
 
     cpu_x86_load_seg(env, R_DS, __USER_DS);
     cpu_x86_load_seg(env, R_ES, __USER_DS);
     cpu_x86_load_seg(env, R_CS, __USER_CS);
     cpu_x86_load_seg(env, R_SS, __USER_DS);
     env->eflags &= ~TF_MASK;
-
-    unlock_user_struct(frame, frame_addr, 1);
-
     return;
 
 give_sigsegv:
     force_sigsegv(sig);
 }
 
-static bool xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
-                              abi_ulong fxsave_addr)
+/*
+ * Restore a signal frame.
+ */
+
+static bool xrstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
+                              X86LegacyXSaveArea *fxstate,
+                              abi_ptr fxstate_addr)
 {
-    struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
+    struct target_fpx_sw_bytes *sw = (void *)&fxstate->sw_reserved;
+    uint32_t magic1, magic2;
+    uint32_t extended_size, xstate_size, min_size, max_size;
 
-    if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
-        uint32_t magic1 = tswapl(sw->magic1);
-        uint32_t extended_size = tswapl(sw->extended_size);
-        uint32_t xstate_size = tswapl(sw->xstate_size);
-        uint32_t minimum_size = (TARGET_FPSTATE_FXSAVE_OFFSET
-                                 + TARGET_FP_XSTATE_MAGIC2_SIZE
-                                 + xstate_size);
-        uint32_t magic2;
+    switch (fpkind) {
+    case FPSTATE_XSAVE:
+        magic1 = tswap32(sw->magic1);
+        extended_size = tswap32(sw->extended_size);
+        xstate_size = tswap32(sw->xstate_size);
+        min_size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+        max_size = xsave_area_size(env->xcr0, false);
 
-        /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
-        if (magic1 == TARGET_FP_XSTATE_MAGIC1
-            && extended_size >= minimum_size) {
-            if (!access_ok(env_cpu(env), VERIFY_READ, fxsave_addr,
-                           extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
-                return false;
-            }
-            magic2 = tswapl(*(uint32_t *)((void *)fxsave + xstate_size));
-            if (magic2 == TARGET_FP_XSTATE_MAGIC2) {
-                cpu_x86_xrstor(env, fxsave_addr, -1);
-                return true;
-            }
+        /* Check for the first magic field and other error scenarios. */
+        if (magic1 != FP_XSTATE_MAGIC1 ||
+            xstate_size < min_size ||
+            xstate_size > max_size ||
+            xstate_size > extended_size) {
+            break;
         }
-        /* fall through to fxrstor */
+        if (!access_ok(env_cpu(env), VERIFY_READ, fxstate_addr,
+                       xstate_size + TARGET_FP_XSTATE_MAGIC2_SIZE)) {
+            return false;
+        }
+        /*
+         * Check for the presence of second magic word at the end of memory
+         * layout. This detects the case where the user just copied the legacy
+         * fpstate layout with out copying the extended state information
+         * in the memory layout.
+         */
+        if (get_user_u32(magic2, fxstate_addr + xstate_size)) {
+            return false;
+        }
+        if (magic2 != FP_XSTATE_MAGIC2) {
+            break;
+        }
+        cpu_x86_xrstor(env, fxstate_addr, -1);
+        return true;
+
+    default:
+        break;
     }
 
-    cpu_x86_fxrstor(env, fxsave_addr);
+    cpu_x86_fxrstor(env, fxstate_addr);
     return true;
 }
 
+#ifndef TARGET_X86_64
+static bool frstor_sigcontext(CPUX86State *env, FPStateKind fpkind,
+                              struct target_fregs_state *fpstate,
+                              abi_ptr fpstate_addr,
+                              X86LegacyXSaveArea *fxstate,
+                              abi_ptr fxstate_addr)
+{
+    switch (fpkind) {
+    case FPSTATE_XSAVE:
+        if (!xrstor_sigcontext(env, fpkind, fxstate, fxstate_addr)) {
+            return false;
+        }
+        break;
+    case FPSTATE_FXSAVE:
+        cpu_x86_fxrstor(env, fxstate_addr);
+        break;
+    case FPSTATE_FSAVE:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /*
+     * Copy the legacy state because the FP portion of the FX frame has
+     * to be ignored for histerical raisins.  The kernel folds the two
+     * states together and then performs a single load; here we perform
+     * the merge within ENV by loading XSTATE/FXSTATE first, then
+     * overriding with the FSTATE afterward.
+     */
+    cpu_x86_frstor(env, fpstate_addr, 1);
+    return true;
+}
+#endif
+
 static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
 {
-    abi_ulong fpstate_addr;
-    unsigned int tmpflags;
-    struct target_fpstate *fpstate;
+    abi_ptr fpstate_addr;
+    unsigned tmpflags, math_size;
+    FPStateKind fpkind;
+    void *fpstate;
     bool ok;
 
 #ifndef TARGET_X86_64
@@ -614,29 +741,33 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
 
     tmpflags = tswapl(sc->eflags);
     env->eflags = (env->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
-    //          regs->orig_eax = -1;            /* disable syscall checks */
 
     fpstate_addr = tswapl(sc->fpstate);
     if (fpstate_addr == 0) {
         return true;
     }
-    if (!lock_user_struct(VERIFY_READ, fpstate, fpstate_addr,
-                          sizeof(struct target_fpstate))) {
+
+    fpkind = get_fpstate_kind(env);
+    math_size = get_fpstate_size(env, fpkind);
+#ifndef TARGET_X86_64
+    if (fpkind != FPSTATE_FSAVE) {
+        math_size += sizeof(struct target_fregs_state);
+    }
+#endif
+    fpstate = lock_user(VERIFY_READ, fpstate_addr, math_size, 1);
+    if (!fpstate) {
         return false;
     }
-#ifndef TARGET_X86_64
-    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-        cpu_x86_frstor(env, fpstate_addr, 1);
-        ok = true;
-    } else {
-        ok = xrstor_sigcontext(env, &fpstate->fxstate,
-                               fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
-    }
-#else
-    ok = xrstor_sigcontext(env, fpstate, fpstate_addr);
-#endif
-    unlock_user_struct(fpstate, fpstate_addr, 0);
 
+#ifdef TARGET_X86_64
+    ok = xrstor_sigcontext(env, fpkind, fpstate, fpstate_addr);
+#else
+    ok = frstor_sigcontext(env, fpkind, fpstate, fpstate_addr,
+                           fpstate + sizeof(struct target_fregs_state),
+                           fpstate_addr + sizeof(struct target_fregs_state));
+#endif
+
+    unlock_user(fpstate, fpstate_addr, 0);
     return ok;
 }
 
@@ -648,30 +779,27 @@ long do_sigreturn(CPUX86State *env)
     abi_ulong frame_addr = env->regs[R_ESP] - 8;
     target_sigset_t target_set;
     sigset_t set;
-    int i;
 
     trace_user_do_sigreturn(env, frame_addr);
-    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
-        goto badframe;
-    /* set blocked signals */
-    __get_user(target_set.sig[0], &frame->sc.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
+    if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1)) {
+        force_sig(TARGET_SIGSEGV);
+        return -QEMU_ESIGRETURN;
     }
 
+    /* Set blocked signals. */
+    __get_user(target_set.sig[0], &frame->sc.oldmask);
+    for (int i = 1; i < TARGET_NSIG_WORDS; i++) {
+        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
+    }
     target_to_host_sigset_internal(&set, &target_set);
     set_sigmask(&set);
 
-    /* restore registers */
+    /* Restore registers */
     if (!restore_sigcontext(env, &frame->sc)) {
-        goto badframe;
+        force_sig(TARGET_SIGSEGV);
     }
-    unlock_user_struct(frame, frame_addr, 0);
-    return -QEMU_ESIGRETURN;
 
-badframe:
     unlock_user_struct(frame, frame_addr, 0);
-    force_sig(TARGET_SIGSEGV);
     return -QEMU_ESIGRETURN;
 }
 #endif
diff --git a/tests/tcg/x86_64/test-1648.c b/tests/tcg/x86_64/test-1648.c
new file mode 100644
index 0000000000..fd0644a8ce
--- /dev/null
+++ b/tests/tcg/x86_64/test-1648.c
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* See https://gitlab.com/qemu-project/qemu/-/issues/1648 */
+
+#include <signal.h>
+
+__attribute__((noinline))
+void bar(void)
+{
+    /* Success! Continue through sigreturn. */
+}
+
+/*
+ * Because of the change of ABI between foo and bar, the compiler is
+ * required to save XMM6-XMM15.  The compiler will use MOVAPS or MOVDQA,
+ * which will trap if the stack frame is not 16 byte aligned.
+ */
+__attribute__((noinline, ms_abi))
+void foo(void)
+{
+    bar();
+}
+
+void sighandler(int num)
+{
+    foo();
+}
+
+int main(void)
+{
+    signal(SIGUSR1, sighandler);
+    raise(SIGUSR1);
+    return 0;
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index e64aab1b81..5fedf22117 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -13,6 +13,7 @@ X86_64_TESTS += vsyscall
 X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
+X86_64_TESTS += test-1648
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
-- 
2.34.1


