Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A16C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFh-00040C-9F; Wed, 15 May 2024 11:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFc-0003xA-PZ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFY-0003EQ-LK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41fd5dc0480so43837435e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785739; x=1716390539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StedKx2if52BenXHp9OmhhxzvGoDONYhwtdzrxe9+sA=;
 b=M9HICQ+xGh/8PjGIt64BfriMvyi4GanZJQ4yLA1mudgvNSgvXshsLNs2Kj0fowdhao
 Vg/xd/L050ZMQqQTiyrTrtIjt1djG7EJg9bPetLQI2RrsndcvAqOKSQHky/P9VLFMmg/
 ZdrWxu/Jfpze60reqh0mbyMCGdsIqNgvX1nUX4skr6QvyW3fYkCoZi6uzHcy2kTjsjDo
 0qPOAba15qNNxiN/uYmOtPLiWar/5JFyRMaNQPbMSGjERJvbI4wE6L1YSbZu0JE+fHeX
 MX6vobxUnWoj38NafXNoOT9sQ3+dRPtKJrKXwtSCWiDhKlPhCtWyy6B1UnFw+qb8BmZ4
 m5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785739; x=1716390539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StedKx2if52BenXHp9OmhhxzvGoDONYhwtdzrxe9+sA=;
 b=cDfNQpNHnJgAS8Qgy651E4d5HwCllV4TiKzuP1c/nlplIhUM44y7HomhFpUi7Ue/NN
 HTh8RK2stEU/pK4Zc9qKMc/BBwqxsDwBu4S0bAJW6ueIdznN3OgFtxjF4owEYjhjg3jN
 meSpFlV2ddBs2t5u3Gztu0N3em2+XZYyVMhsbBAqFMdvB+T2rXp97lnGxmwgOnB9CFZf
 RkBpxWD8f04lX9/+015zSbLORdhOKN+RCyrkhJaLwTLAXc8hIOODo3cSQXMFNu2asp04
 N5Sb7jkVs28DhmlFEY/+sHTUELwyTIUHgR4BsKJ+vKE354JPY0jo+lcBLoXAkGJVaVas
 qHCw==
X-Gm-Message-State: AOJu0YyqeY3tsRZ278aLkDmE2dm6ezcyqAAs14POu6ukKklQzisVKFHX
 q8dZZsncUMywhv9R7UfubD/Gk10yY9uS8+n3R1kkXXp2zblcGzIbnXTDAHrFgkpBGVL2EH1Xe1C
 iETI=
X-Google-Smtp-Source: AGHT+IE6sBSZgH6csM8mWCrtTUCxujXxgwIKq9nebxJplJjC0hUUTwLll0FGaD+2MUUGgzYgWJtvRQ==
X-Received: by 2002:a05:600c:46d3:b0:41b:6753:30be with SMTP id
 5b1f17b1804b1-41fead6cf75mr138876155e9.38.1715785739379; 
 Wed, 15 May 2024 08:08:59 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 25/28] target/i386: Convert do_xrstor to X86Access
Date: Wed, 15 May 2024 17:08:34 +0200
Message-Id: <20240515150837.259747-26-richard.henderson@linaro.org>
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 106 +++++++++++++++++++++--------------
 1 file changed, 64 insertions(+), 42 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index f5748b72b8..1ac61c5d7d 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2903,51 +2903,38 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
     do_fxrstor(&ac, ptr);
 }
 
-static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
+static bool valid_xrstor_header(X86Access *ac, uint64_t *pxsbv,
+                                target_ulong ptr)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
-    X86Access ac;
-    unsigned size, size_ext;
 
-    rfbm &= env->xcr0;
+    xstate_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
+    xcomp_bv = access_ldq(ac, ptr + XO(header.xcomp_bv));
+    reserve0 = access_ldq(ac, ptr + XO(header.reserve0));
+    *pxsbv = xstate_bv;
 
-    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
-    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
-
-    xstate_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
-
-    if ((int64_t)xstate_bv < 0) {
-        /* FIXME: Compact form.  */
-        raise_exception_ra(env, EXCP0D_GPF, ra);
+    /*
+     * XCOMP_BV bit 63 indicates compact form, which we do not support,
+     * and thus must raise #GP.  That leaves us in standard form.
+     * In standard form, bytes 23:8 must be zero -- which is both
+     * XCOMP_BV and the following 64-bit field.
+     */
+    if (xcomp_bv || reserve0) {
+        return false;
     }
 
-    /* Standard form.  */
-
     /* The XSTATE_BV field must not set bits not present in XCR0.  */
-    if (xstate_bv & ~env->xcr0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
+    return (xstate_bv & ~ac->env->xcr0) == 0;
+}
 
-    /* The XCOMP_BV field must be zero.  Note that, as of the April 2016
-       revision, the description of the XSAVE Header (Vol 1, Sec 13.4.2)
-       describes only XCOMP_BV, but the description of the standard form
-       of XRSTOR (Vol 1, Sec 13.8.1) checks bytes 23:8 for zero, which
-       includes the next 64-bit field.  */
-    xcomp_bv = access_ldq(&ac, ptr + XO(header.xcomp_bv));
-    reserve0 = access_ldq(&ac, ptr + XO(header.reserve0));
-    if (xcomp_bv || reserve0) {
-        raise_exception_ra(env, EXCP0D_GPF, ra);
-    }
-
-    size_ext = xsave_area_size(rfbm & xstate_bv, false);
-    if (size < size_ext) {
-        /* TODO: See if existing page probe has covered extra size. */
-        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
-    }
+static void do_xrstor(X86Access *ac, target_ulong ptr,
+                      uint64_t rfbm, uint64_t xstate_bv)
+{
+    CPUX86State *env = ac->env;
 
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
-            do_xrstor_fpu(&ac, ptr);
+            do_xrstor_fpu(ac, ptr);
         } else {
             do_fninit(env);
             memset(env->fpregs, 0, sizeof(env->fpregs));
@@ -2956,23 +2943,23 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that the standard form of XRSTOR loads MXCSR from memory
            whether or not the XSTATE_BV bit is set.  */
-        do_xrstor_mxcsr(&ac, ptr);
+        do_xrstor_mxcsr(ac, ptr);
         if (xstate_bv & XSTATE_SSE_MASK) {
-            do_xrstor_sse(&ac, ptr);
+            do_xrstor_sse(ac, ptr);
         } else {
             do_clear_sse(env);
         }
     }
     if (rfbm & XSTATE_YMM_MASK) {
         if (xstate_bv & XSTATE_YMM_MASK) {
-            do_xrstor_ymmh(&ac, ptr + XO(avx_state));
+            do_xrstor_ymmh(ac, ptr + XO(avx_state));
         } else {
             do_clear_ymmh(env);
         }
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(&ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -2981,7 +2968,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(&ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -2990,7 +2977,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_PKRU_MASK) {
         uint64_t old_pkru = env->pkru;
         if (xstate_bv & XSTATE_PKRU_MASK) {
-            do_xrstor_pkru(&ac, ptr + XO(pkru_state));
+            do_xrstor_pkru(ac, ptr + XO(pkru_state));
         } else {
             env->pkru = 0;
         }
@@ -3006,9 +2993,27 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 void helper_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
     uintptr_t ra = GETPC();
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size, size_ext;
 
     do_xsave_chk(env, ptr, ra);
-    do_xrstor(env, ptr, rfbm, ra);
+
+    /* Begin with just the minimum size to validate the header. */
+    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        raise_exception_ra(env, EXCP0D_GPF, ra);
+    }
+
+    rfbm &= env->xcr0;
+    size_ext = xsave_area_size(rfbm & xstate_bv, false);
+    if (size < size_ext) {
+        /* TODO: See if existing page probe has covered extra size. */
+        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 
 #if defined(CONFIG_USER_ONLY)
@@ -3066,7 +3071,24 @@ void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 
 void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, rfbm, 0);
+    X86Access ac;
+    uint64_t xstate_bv;
+    unsigned size;
+
+    /*
+     * Since this is only called from user-level signal handling,
+     * we should have done the job correctly there.
+     */
+    assert((rfbm & ~env->xcr0) == 0);
+    size = xsave_area_size(rfbm, false);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, 0);
+
+    if (!valid_xrstor_header(&ac, &xstate_bv, ptr)) {
+        /* TODO: Report failure to caller. */
+        xstate_bv &= env->xcr0;
+    }
+
+    do_xrstor(&ac, ptr, rfbm, xstate_bv);
 }
 #endif
 
-- 
2.34.1


