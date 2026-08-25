Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E0BC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 12:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyqHg-0004hM-St; Tue, 25 Aug 2026 08:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHd-0004gl-Ec
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wyqHb-0000JK-BL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787660978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CctPaz35SpkBvSVYmSA+dpAk+d3UWmMos9BA4/wjDdk=;
 b=L+VlyfXDgOU5rtag1DE6PDwX1X/6dPC4PaHewLI9pO7sRwWGeCjiKoQLPf33JkSYLhjWTl
 ck0atYWzKnovdKsiEDGH0HCoY8Akj4InC8Y8w6VHwEhwcBxXPhOmwAN7U14BMM4uLi6BjV
 YRQw+0a6r7pqf8Poe2OO2k8KGTRCtZM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-3h1wvTaaMIm43hLR0pVCrg-1; Tue, 25 Aug 2026 08:29:36 -0400
X-MC-Unique: 3h1wvTaaMIm43hLR0pVCrg-1
X-Mimecast-MFC-AGG-ID: 3h1wvTaaMIm43hLR0pVCrg_1787660975
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c1686e23b9cso400415466b.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 05:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787660975; x=1788265775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CctPaz35SpkBvSVYmSA+dpAk+d3UWmMos9BA4/wjDdk=;
 b=XygYgt0HMl3DhkPy8rDncTAcSOPu3fepg1xoNnowzNiV1e6YYEj/Mkp9DpKcHkgczj
 7hw+i9NOoDcXaJpPmiKP149SGB1jjV/PS0piUvJpqI7wzwD0x8iw0UuZ9qFjD2puuMQH
 HP3JPxmqZ5D2QgYGfngLyOwaTTpMVoNObmktoLwLOvF7/zoV3ahYDDI1BSzsjflidBj4
 /sXYCI1k7lrkHUefLhHPN/gVFphxUBVLtHZMr2TBvx+UFVbSRGByCjUtE30WvFBdWECD
 bFaiA255mApyCXkGkrM66EBcb7H0PEtTpU6LUuJ7uQbQ/pwNaQWxw6Xn8Gu6phaiPTyt
 XEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787660975; x=1788265775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CctPaz35SpkBvSVYmSA+dpAk+d3UWmMos9BA4/wjDdk=;
 b=BwL3yO8spw6gK33efBCIHL7RhiqlagXt0evhR4GVC67SODcnXe7rGOYggiCsfaTt+q
 b5U+f2SEYxXdL8iuh3xCaeR46XR/9tMTYsfn9XUOUbaJ4yXnYvG2MnbM6NefPE/H7HH9
 kqIKFLztkrhT7cH954NBzkhm1kCfqeEGqTliIXsAKYCynUmn9HWyjS39HPzyhYPbU0Kl
 MmBOdLDwQ+/xwl2L1Tr9plLLzKHGE19FYTaOk2vW1DOn6iOdvfxq5aeyj82256LTceOE
 YE4tNu+tnGX64pIPD4eXn/zbSICDlWn8vUvqkyj8J+Pkjp3BJfk+giZWFS5TnlPP3o0n
 9Cqw==
X-Gm-Message-State: AFuF++mISwSKeAE+80aqbD2sj0IiKrHIUIbWK9USfdddC99rcDENkpRk
 0FKXm4AuNqVVIswlykO0bCEUSf2qr64XEMLtsTlNwtcAjWw59u7sTeoKHOVZgzYCEllHidIasOI
 jpZ6TlOn/UKZZDQo9anfPTQCQDEbwhuG2Rthdfs92bSOXzBx7D3qtqokT8Dzyon0iO95YLRQa9c
 h+0WcYUVMP3LQeyzHBuGgzUcy3vnU8j10zLQJxRYfp
X-Gm-Gg: AR+sD12eEKqVO/PguVM5SGtq+NeMauSTwN3Ur6mh15KLcwRfyJnKqacpRynZYmgzrLw
 ncDP7w92U5CFs/xmW8Lt3T5/9a9BDceMD+pSaj6IYOSzcSE+2JCLGL7tDDAccNnx7889lNrZg6L
 JTR2domDAsewP7Ho75/gy+BXeBtHMRN8ZqIdnprPQeKUJZq4Kd00jHQahhYs+LHhpdUnlcBpxgW
 +rIHoG5nOCNFbO6UITEBF2wfxmcQO4KjjJieYXsshRwdj9Q/GEYz/apBo3KrtOzlgnxNpg77iS+
 79E/yyb+Vp8ENu+9bTcZAhuGmXMdwXJDRhskAOCFz6muGi4/CAUektrFp6wnx8wH/XmXBfzxOOn
 C1+67j2EAyt0lDYu5MvBiaaXIRCB+Pls9EOWQ2lhwpyqwWx0SGE8Wziw9gaYj7vDE2mVcEplXDT
 dJslA=
X-Received: by 2002:a17:907:60cd:b0:c24:c22c:6372 with SMTP id
 a640c23a62f3a-c24c22c6490mr1559742566b.5.1787660975259; 
 Tue, 25 Aug 2026 05:29:35 -0700 (PDT)
X-Received: by 2002:a17:907:60cd:b0:c24:c22c:6372 with SMTP id
 a640c23a62f3a-c24c22c6490mr1559726966b.5.1787660974430; 
 Tue, 25 Aug 2026 05:29:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24dfd91dd4sm467031366b.16.2026.08.25.05.29.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 05:29:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/20] target/i386/tcg: add APX support to XSAVE/XRSTOR
Date: Tue, 25 Aug 2026 14:29:06 +0200
Message-ID: <20260825122921.431739-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825122921.431739-1-pbonzini@redhat.com>
References: <20260825122921.431739-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With it, add a new hidden flag that will be used to enable the REX2 prefix
and EVEX map4.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h            |  3 ++
 target/i386/tcg/tcg-cpu.h    | 16 +++++++---
 target/i386/helper.c         | 11 +++++++
 target/i386/tcg/fpu_helper.c | 59 +++++++++++++++++++++++++++++++++---
 target/i386/tcg/tcg-cpu.c    |  5 +--
 5 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2f..dc5d48aceea 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -191,6 +191,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_SHIFT     26 /* BND registers in-use */
 #define HF_UMIP_SHIFT       27 /* CR4.UMIP */
 #define HF_AVX_EN_SHIFT     28 /* AVX Enabled (CR4+XCR0) */
+#define HF_APX_EN_SHIFT     29 /* APX Enabled (CR4+XCR0) */
 
 #define HF_CPL_MASK          (3 << HF_CPL_SHIFT)
 #define HF_INHIBIT_IRQ_MASK  (1 << HF_INHIBIT_IRQ_SHIFT)
@@ -218,6 +219,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_MASK       (1 << HF_MPX_IU_SHIFT)
 #define HF_UMIP_MASK         (1 << HF_UMIP_SHIFT)
 #define HF_AVX_EN_MASK       (1 << HF_AVX_EN_SHIFT)
+#define HF_APX_EN_MASK       (1 << HF_APX_EN_SHIFT)
 
 /* hflags2 */
 
@@ -2759,6 +2761,7 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
+void cpu_sync_apx_hflag(CPUX86State *env);
 
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 85bcd61678f..451f61e2043 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -52,9 +52,15 @@ typedef struct X86XSaveArea {
                     - sizeof(X86XSaveHeader)
                     - sizeof(XSaveAVX)];
 
-    /* MPX State: */
-    XSaveBNDREG bndreg_state;
-    XSaveBNDCSR bndcsr_state;
+    /* Overlapping MPX and APX States: */
+    union {
+        struct {
+            XSaveBNDREG bndreg;
+            XSaveBNDCSR bndcsr;
+        } mpx_state;
+        XSaveAPX apx_state;
+    };
+
     /* AVX-512 State: */
     XSaveOpmask opmask_state;
     XSaveZMM_Hi256 zmm_hi256_state;
@@ -71,8 +77,8 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.mxcsr) != XSAVE_MXCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.fpregs) != XSAVE_ST_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.xmm_regs) != XSAVE_XMM_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, avx_state) != XSAVE_AVX_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndreg_state) != XSAVE_BNDREG_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndcsr_state) != XSAVE_BNDCSR_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndreg) != XSAVE_BNDREG_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndcsr) != XSAVE_BNDCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, opmask_state) != XSAVE_OPMASK_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 68362141621..22d205bed66 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -36,6 +36,16 @@
 #include "tcg/insn-start-words.h"
 #endif
 
+void cpu_sync_apx_hflag(CPUX86State *env)
+{
+    if ((env->cr[4] & CR4_OSXSAVE_MASK)
+        && (env->xcr0 & XSTATE_APX_MASK) == XSTATE_APX_MASK) {
+        env->hflags |= HF_APX_EN_MASK;
+    } else{
+        env->hflags &= ~HF_APX_EN_MASK;
+    }
+}
+
 void cpu_sync_avx_hflag(CPUX86State *env)
 {
     if ((env->cr[4] & CR4_OSXSAVE_MASK)
@@ -250,6 +260,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b812125efa1..e341aefb9f0 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2690,6 +2690,19 @@ static void do_xsave_pkru(X86Access *ac, target_ulong ptr)
     access_stq(ac, ptr, ac->env->pkru);
 }
 
+#ifdef TARGET_X86_64
+static void do_xsave_apx(X86Access *ac, target_ulong ptr)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        access_stq(ac, ptr, env->regs[i]);
+        ptr += 8;
+    }
+}
+#endif
+
 static void do_fxsave(X86Access *ac, target_ulong ptr)
 {
     CPUX86State *env = ac->env;
@@ -2754,14 +2767,19 @@ static void do_xsave_access(X86Access *ac, target_ulong ptr, uint64_t rfbm,
         do_xsave_ymmh(ac, ptr + XO(avx_state));
     }
     if (opt & XSTATE_BNDREGS_MASK) {
-        do_xsave_bndregs(ac, ptr + XO(bndreg_state));
+        do_xsave_bndregs(ac, ptr + XO(mpx_state.bndreg));
     }
     if (opt & XSTATE_BNDCSR_MASK) {
-        do_xsave_bndcsr(ac, ptr + XO(bndcsr_state));
+        do_xsave_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
     }
     if (opt & XSTATE_PKRU_MASK) {
         do_xsave_pkru(ac, ptr + XO(pkru_state));
     }
+#ifdef TARGET_X86_64
+    if (opt & XSTATE_APX_MASK) {
+        do_xsave_apx(ac, ptr + XO(apx_state));
+    }
+#endif
 
     /* Update the XSTATE_BV field.  */
     old_bv = access_ldq(ac, ptr + XO(header.xstate_bv));
@@ -2955,6 +2973,29 @@ static void do_fxrstor(X86Access *ac, target_ulong ptr)
     }
 }
 
+#ifdef TARGET_X86_64
+static void do_xrstor_apx(X86Access *ac, target_ulong ptr)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        env->regs[i] = access_ldq(ac, ptr);
+        ptr += 8;
+    }
+}
+
+static void do_clear_apx(X86Access *ac)
+{
+    CPUX86State *env = ac->env;
+    int i;
+
+    for (i = 16; i < 32; i++) {
+        env->regs[i] = 0;
+    }
+}
+#endif
+
 void helper_fxrstor(CPUX86State *env, target_ulong ptr)
 {
     uintptr_t ra = GETPC();
@@ -3026,7 +3067,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(mpx_state.bndreg));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -3035,7 +3076,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -3053,6 +3094,15 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
             tlb_flush(cs);
         }
     }
+#ifdef TARGET_X86_64
+    if (rfbm & XSTATE_APX_MASK) {
+        if (xstate_bv & XSTATE_APX_MASK) {
+            do_xrstor_apx(ac, ptr + XO(apx_state));
+        } else {
+            do_clear_apx(ac);
+        }
+    }
+#endif
 }
 
 #undef XO
@@ -3228,6 +3278,7 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
     env->xcr0 = mask;
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
     return;
 
  do_gpf:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 6f5dc06b3b9..2965c304e57 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -198,12 +198,13 @@ static void x86_tcg_cpu_xsave_init(void)
     XO(XSTATE_FP_BIT, legacy);
     XO(XSTATE_SSE_BIT, legacy);
     XO(XSTATE_YMM_BIT, avx_state);
-    XO(XSTATE_BNDREGS_BIT, bndreg_state);
-    XO(XSTATE_BNDCSR_BIT, bndcsr_state);
+    XO(XSTATE_BNDREGS_BIT, mpx_state.bndreg);
+    XO(XSTATE_BNDCSR_BIT, mpx_state.bndcsr);
     XO(XSTATE_OPMASK_BIT, opmask_state);
     XO(XSTATE_ZMM_Hi256_BIT, zmm_hi256_state);
     XO(XSTATE_Hi16_ZMM_BIT, hi16_zmm_state);
     XO(XSTATE_PKRU_BIT, pkru_state);
+    XO(XSTATE_APX_BIT, apx_state);
 
 #undef XO
 }
-- 
2.55.0


