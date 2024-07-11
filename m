Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12265C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthG-0001gd-3o; Thu, 11 Jul 2024 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthB-0001Pu-DX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:49 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00063H-2o
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:49 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52ea952ce70so983941e87.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703908; x=1721308708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SxqLyHUbkYCo8EG3kZU0Rlig+6+Eh6nt+y6z+OFn3N0=;
 b=QeTkwacm0JhBUL0JtxCOuzXTR/YMuP/znmVp9JINkgByqQCJp6gcYP1N+xLlgkvtNk
 SIWlymU4Jnjw4A2B+r6LBVRkUXfO3w4lqkkwgLT0ILjC6LtXSrlZ5uysl8EPW4MQCW3B
 kCavYtvOeChArl3tBL1i1uZeijycjsrBalvExwSWD5MFjEcLvNZBxku3NHwu4DUEUbN0
 wXYbJcKvi8xI7bACC/2HNYYo1wWtfIw+xBS79+wKu1NSStRfvim4UbaNkmyV2PeOWTQd
 dSe7S0z5C0zP4fAgEP61gjRIqLq84okU+5w+zYBSXIHWtdOZSkQLuFWXZTvMSgbALC17
 BC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703908; x=1721308708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxqLyHUbkYCo8EG3kZU0Rlig+6+Eh6nt+y6z+OFn3N0=;
 b=AseO2yNa1dya3DgXY33Bqt1mDPLs+MSam30dcwzGi4FTbnQ+Z31Nr16DIRi5ViYHcV
 1fWBnXu8x8tUjJ077/hyMy3tl3Khe2m13/oDQXupgoF4JwEdKg1ngNup8k6LiuT/FD43
 hcgQX4DQmSFWvJ4fs4kUS5ogK04j9PPc0VIcsFkIflryZxbhr0nXep8zL4tIyPues9dF
 d6aZMOd16UtR+jxIOZaZl2YlrR4Frxx/ATMEMZrgtR3rRIJcPQDveHHdXf/ap7ffoJkg
 jeco9CT/+ii/2D5csFxaj1eBxOfypdzPU5Ok3pNfGs+UmD4YJvsyyISms4KuHTicQOVf
 EhNw==
X-Gm-Message-State: AOJu0YxQCm6ZVI7rmFpOMLnmHO4pXJNSXdJEV5R1JKn6kv88BTugaQWS
 5HiT2UReaUb1vM9Z34uHtn5Xd/DGJ8W0L3g0ZbBKnqyXEzw4hLD0j48bc2CZ75v2UJYdm3+HUIC
 2rkI=
X-Google-Smtp-Source: AGHT+IF7DGmCHfMXpwAXhPPiVkst6QjYiQ0H/Wb/NohoLy/FjkYSQXhuZSRAfRwQ8mUqAil/qT+qUw==
X-Received: by 2002:a05:6512:224f:b0:52e:be0d:56dd with SMTP id
 2adb3069b0e04-52ebe0d579emr5320421e87.40.1720703907764; 
 Thu, 11 Jul 2024 06:18:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/24] target/arm: Store FPSR and FPCR in separate CPU state
 fields
Date: Thu, 11 Jul 2024 14:18:04 +0100
Message-Id: <20240711131822.3909903-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

Now that we have refactored the set/get functions so that the FPSCR
format is no longer the authoritative one, we can keep FPSR and FPCR
in separate CPU state fields.

As well as the get and set functions, we also have a scattering of
places in the code which directly access vfp.xregs[ARM_VFP_FPSCR] to
extract single fields which are stored there.  These all change to
directly access either vfp.fpsr or vfp.fpcr, depending on the
location of the field.  (Most commonly, this is the NZCV flags.)

We make the field in the CPU state struct 64 bits, because
architecturally FPSR and FPCR are 64 bits.  However we leave the
types of the arguments and return values of the get/set functions as
32 bits, since we don't need to make that change with the current
architecture and various callsites would be unable to handle
set bits in the high half (for instance the gdbstub protocol
assumes they're only 32 bit registers).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-7-peter.maydell@linaro.org
---
 target/arm/cpu.h                  |  7 +++++++
 target/arm/tcg/translate.h        |  3 +--
 target/arm/tcg/mve_helper.c       | 12 ++++++------
 target/arm/tcg/translate-m-nocp.c |  6 +++---
 target/arm/tcg/translate-vfp.c    |  2 +-
 target/arm/vfp_helper.c           | 25 ++++++++++---------------
 6 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b1b48c1d775..53232239197 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -619,6 +619,13 @@ typedef struct CPUArchState {
         int vec_len;
         int vec_stride;
 
+        /*
+         * Floating point status and control registers. Some bits are
+         * stored separately in other fields or in the float_status below.
+         */
+        uint64_t fpsr;
+        uint64_t fpcr;
+
         uint32_t xregs[16];
 
         /* Scratch space for aa32 neon expansion.  */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index aba21f730fe..a8672c857c1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -351,8 +351,7 @@ static inline TCGv_i32 get_ahp_flag(void)
 {
     TCGv_i32 ret = tcg_temp_new_i32();
 
-    tcg_gen_ld_i32(ret, tcg_env,
-                   offsetof(CPUARMState, vfp.xregs[ARM_VFP_FPSCR]));
+    tcg_gen_ld_i32(ret, tcg_env, offsetoflow32(CPUARMState, vfp.fpcr));
     tcg_gen_extract_i32(ret, ret, 26, 1);
 
     return ret;
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 8b99736aad1..234f395b093 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -1115,21 +1115,21 @@ static void do_vadc(CPUARMState *env, uint32_t *d, uint32_t *n, uint32_t *m,
 
     if (update_flags) {
         /* Store C, clear NZV. */
-        env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPCR_NZCV_MASK;
-        env->vfp.xregs[ARM_VFP_FPSCR] |= carry_in * FPCR_C;
+        env->vfp.fpsr &= ~FPCR_NZCV_MASK;
+        env->vfp.fpsr |= carry_in * FPCR_C;
     }
     mve_advance_vpt(env);
 }
 
 void HELPER(mve_vadc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPCR_C;
     do_vadc(env, vd, vn, vm, 0, carry_in, false);
 }
 
 void HELPER(mve_vsbc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPCR_C;
     do_vadc(env, vd, vn, vm, -1, carry_in, false);
 }
 
@@ -3343,7 +3343,7 @@ static void do_vcvt_sh(CPUARMState *env, void *vd, void *vm, int top)
     uint32_t *m = vm;
     uint16_t r;
     uint16_t mask = mve_element_mask(env);
-    bool ieee = !(env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_AHP);
+    bool ieee = !(env->vfp.fpcr & FPCR_AHP);
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
@@ -3373,7 +3373,7 @@ static void do_vcvt_hs(CPUARMState *env, void *vd, void *vm, int top)
     uint16_t *m = vm;
     uint32_t r;
     uint16_t mask = mve_element_mask(env);
-    bool ieee = !(env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_AHP);
+    bool ieee = !(env->vfp.fpcr & FPCR_AHP);
     unsigned e;
     float_status *fpst;
     float_status scratch_fpst;
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index f564d06ccf1..875f6a8725d 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -341,10 +341,10 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
                                  16, 16, qc);
         }
         tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
-        fpscr = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+        fpscr = load_cpu_field_low32(vfp.fpsr);
         tcg_gen_andi_i32(fpscr, fpscr, ~FPCR_NZCV_MASK);
         tcg_gen_or_i32(fpscr, fpscr, tmp);
-        store_cpu_field(fpscr, vfp.xregs[ARM_VFP_FPSCR]);
+        store_cpu_field_low32(fpscr, vfp.fpsr);
         break;
     }
     case ARM_VFP_FPCXT_NS:
@@ -465,7 +465,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
          * Read just NZCV; this is a special case to avoid the
          * helper call for the "VMRS to CPSR.NZCV" insn.
          */
-        tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+        tmp = load_cpu_field_low32(vfp.fpsr);
         tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
         storefn(s, opaque, tmp, true);
         break;
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 39ec971ff70..0d9788e8103 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -833,7 +833,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
             break;
         case ARM_VFP_FPSCR:
             if (a->rt == 15) {
-                tmp = load_cpu_field(vfp.xregs[ARM_VFP_FPSCR]);
+                tmp = load_cpu_field_low32(vfp.fpsr);
                 tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
             } else {
                 tmp = tcg_temp_new_i32();
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 678de5eb6f7..a8c89a910f6 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -115,7 +115,7 @@ static void vfp_set_fpsr_to_host(CPUARMState *env, uint32_t val)
 
 static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 {
-    uint32_t changed = env->vfp.xregs[ARM_VFP_FPSCR];
+    uint64_t changed = env->vfp.fpcr;
 
     changed ^= val;
     if (changed & (3 << 22)) {
@@ -175,7 +175,7 @@ static void vfp_set_fpcr_to_host(CPUARMState *env, uint32_t val)
 
 uint32_t vfp_get_fpcr(CPUARMState *env)
 {
-    uint32_t fpcr = (env->vfp.xregs[ARM_VFP_FPSCR] & FPCR_MASK)
+    uint32_t fpcr = env->vfp.fpcr
         | (env->vfp.vec_len << 16)
         | (env->vfp.vec_stride << 20);
 
@@ -190,7 +190,7 @@ uint32_t vfp_get_fpcr(CPUARMState *env)
 
 uint32_t vfp_get_fpsr(CPUARMState *env)
 {
-    uint32_t fpsr = env->vfp.xregs[ARM_VFP_FPSCR] & FPSR_MASK;
+    uint32_t fpsr = env->vfp.fpsr;
     uint32_t i;
 
     fpsr |= vfp_get_fpsr_from_host(env);
@@ -229,15 +229,13 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
     }
 
     /*
-     * The only FPSR bits we keep in vfp.xregs[FPSCR] are NZCV:
+     * The only FPSR bits we keep in vfp.fpsr are NZCV:
      * the exception flags IOC|DZC|OFC|UFC|IXC|IDC are stored in
      * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
-     * and zero any of the other FPSR bits (but preserve the FPCR
-     * bits).
+     * and zero any of the other FPSR bits.
      */
     val &= FPCR_NZCV_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPSR_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+    env->vfp.fpsr = val;
 }
 
 void vfp_set_fpcr(CPUARMState *env, uint32_t val)
@@ -271,14 +269,13 @@ void vfp_set_fpcr(CPUARMState *env, uint32_t val)
      * We don't implement trapped exception handling, so the
      * trap enable bits, IDE|IXE|UFE|OFE|DZE|IOE are all RAZ/WI (not RES0!)
      *
-     * The FPCR bits we keep in vfp.xregs[FPSCR] are AHP, DN, FZ, RMode
+     * The FPCR bits we keep in vfp.fpcr are AHP, DN, FZ, RMode
      * and FZ16. Len, Stride and LTPSIZE we just handled. Store those bits
      * there, and zero any of the other FPCR bits and the RES0 and RAZ/WI
      * bits.
      */
     val &= FPCR_AHP | FPCR_DN | FPCR_FZ | FPCR_RMODE_MASK | FPCR_FZ16;
-    env->vfp.xregs[ARM_VFP_FPSCR] &= ~FPCR_MASK;
-    env->vfp.xregs[ARM_VFP_FPSCR] |= val;
+    env->vfp.fpcr = val;
 }
 
 void HELPER(vfp_set_fpscr)(CPUARMState *env, uint32_t val)
@@ -356,8 +353,7 @@ static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
     default:
         g_assert_not_reached();
     }
-    env->vfp.xregs[ARM_VFP_FPSCR] =
-        deposit32(env->vfp.xregs[ARM_VFP_FPSCR], 28, 4, flags);
+    env->vfp.fpsr = deposit64(env->vfp.fpsr, 28, 4, flags); /* NZCV */
 }
 
 /* XXX: check quiet/signaling case */
@@ -1160,8 +1156,7 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
     uint32_t z = (pair >> 32) == 0;
 
     /* Store Z, clear NCV, in FPSCR.NZCV.  */
-    env->vfp.xregs[ARM_VFP_FPSCR]
-        = (env->vfp.xregs[ARM_VFP_FPSCR] & ~CPSR_NZCV) | (z * CPSR_Z);
+    env->vfp.fpsr = (env->vfp.fpsr & ~FPCR_NZCV_MASK) | (z * FPCR_Z);
 
     return result;
 }
-- 
2.34.1


