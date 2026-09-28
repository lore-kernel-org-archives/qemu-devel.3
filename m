Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D209ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBB2i-0006I0-Ji; Mon, 28 Sep 2026 09:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0y-0005QO-QL
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBB0w-0004Om-H6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790600605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dfu8COcO7bTDT11F8VTKT7W8wN/p/kNPOs2GOY98rzk=;
 b=b7il2pmCgo0zqNb4iT2H0t5vRhpK8GvMSf8ugv7J2m2/YHvZ66MGC2EIh/+pwvr274tVMd
 vNRt5kf0b3jaEn5PgMR2TQmsybq7sn+DvO0NxCmIBWWjdKOglm2bNjjGCtwLIQKSYU2VIn
 THqnK76my6z+dvWoFxIIpBCpyCNNu6k=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-D6idrbKOO76688baAnjQiA-1; Mon, 28 Sep 2026 09:03:24 -0400
X-MC-Unique: D6idrbKOO76688baAnjQiA-1
X-Mimecast-MFC-AGG-ID: D6idrbKOO76688baAnjQiA_1790600603
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c294ae16922so370606866b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790600603; x=1791205403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dfu8COcO7bTDT11F8VTKT7W8wN/p/kNPOs2GOY98rzk=;
 b=T5Af3EZXTdZsQADBYFXWmcte8VLw+1ATu6FVwqkqxTtCNU3a7eo2ppOtnx/fd/5P+j
 z/ABXmarGZlMmCjZXaVWxIfmjDTvYh3tPmbUdIzMA/bWh2YHh9NER8oBLgHTMvGVNnm2
 tzNcGwPDps0MRaGb+CbNBI02Y+RHjmBFnCSobuSp5tMsXWGFHg7XJSwV9HAiGXljkDxJ
 blP3zrF7hJgd5bj2U0W47FCrvD4u/otvSOs6NM4FzbQWOLPtuRHwBypbzFJmWlN6TZ2K
 jJCcXnfjtygwBl1nljjkTMnG7LfVVAzUJcyXMbXmjSGgZ+uLmSPEC2fDDjEF+rYxCo2T
 ZzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790600603; x=1791205403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dfu8COcO7bTDT11F8VTKT7W8wN/p/kNPOs2GOY98rzk=;
 b=daEsVN40FUZ4wqleYPNkG4dqDCQfqbwIQuYtEb3t/V4BzNdpqumfTgR6Ez4t4ul6xn
 nLb0ak5s9LgwnNabihXzjhonVxMm0uVDJQCNx/dtMu1yMjqB4PY7rMbQrx6k92/2AORf
 IbQ+0Ho3jUWFIX9pYCdpJH0ChZiQKr534NAkuzxR7m+RZ6HIRP1DgLjVQRXHY6Nua4/c
 TFGqKvLhIZL4CwHMzFuQJp0qAzbAa7tew/2iBx9P7BpWCIhjpDsi1ScMlFhUyeYR+3gR
 u5bTxpr4oJhEWUgOpA1HIsbJNep7fgG6Tlv8zRcPRIJZO1iIX3BIJcpxR0zYEOwztPxM
 +yoA==
X-Gm-Message-State: AFuF++kq6aoHoA/izANGaikIYqjkwOFW/yNbS46NBMHHLm7hpf88IF39
 KvvaHTk5Pw+qmWAapf2PGKD8FQW2L0BP7xXo9BRv56blsFK9CSUuHHwGW7OriPyKsmLW2fVwvcT
 Ev7Ecz+D2lZxXWzZVc0TUxY1GQpvYyXBSJWRFj6CKBjBI9ocZqdfUwpyOnqjlKtlD9GB79MIyfg
 pNFYWX3wGQZSOHuozubncdD8PQaTcCgeLUpRAB1T6e
X-Gm-Gg: AYBFou3/HIEAR1tlF6FpQOkqWdk/nAha7Jq1bPHIFug0i01m3HxXMCYy6K6jLRW3knv
 nLIWPHd3i7AwM6zbFtbFr1KkxEIlnMBdSvZSbHbdFQp7k5izyFwtCHbg4AS89+/WCSN9XU2yZjU
 pDf3U2IR/n06kX0E3HvbfiFs8t1/DuQiwRwqc1lnAVevbx1fl45E48wGzMe6L1c2b8ZmMo6DfpW
 x16Wi2vz38QvAsZ5XqZnL4qRHCjGcWvLoyUz8iTfkwxHZ/uQA7WFd6+TidCb3Jm35YXK/Zsiu/O
 DJwL6l3vokadHBcJa3LDXx6UWA5+o6mb+oPKAWALw4PAjOXS1mXmOMgwvNBEluoZP1yoKfgOAdn
 s85Zw3o7ykLScFmyUGWgdAbuousOrKRZGfhdZmcw2hxlZDfA8zSD7MdU6zG7i+WvPWTv7wrisoR
 Ky7Xif
X-Received: by 2002:a17:906:7946:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c2ac2511a13mr1011418866b.38.1790600602730; 
 Mon, 28 Sep 2026 06:03:22 -0700 (PDT)
X-Received: by 2002:a17:906:7946:b0:c26:1648:a06b with SMTP id
 a640c23a62f3a-c2ac2511a13mr1011416166b.38.1790600602167; 
 Mon, 28 Sep 2026 06:03:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2dbd3bcadbsm272109966b.72.2026.09.28.06.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:03:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PULL 16/30] target/i386/tcg: add APX support to XSAVE/XRSTOR
Date: Mon, 28 Sep 2026 15:02:14 +0200
Message-ID: <20260928130228.877003-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928130228.877003-1-pbonzini@redhat.com>
References: <20260928130228.877003-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h            |  3 ++
 target/i386/tcg/tcg-cpu.h    | 18 ++++++++---
 target/i386/helper.c         | 11 +++++++
 target/i386/tcg/fpu_helper.c | 59 +++++++++++++++++++++++++++++++++---
 target/i386/tcg/tcg-cpu.c    |  5 +--
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3f69b0a066a..c8619666f07 100644
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
 
@@ -2771,6 +2773,7 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
 /* helper.c */
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
+void cpu_sync_apx_hflag(CPUX86State *env);
 
 typedef enum X86ASIdx {
     X86ASIdx_MEM = 0,
diff --git a/target/i386/tcg/tcg-cpu.h b/target/i386/tcg/tcg-cpu.h
index 85bcd61678f..919c2f3ee3b 100644
--- a/target/i386/tcg/tcg-cpu.h
+++ b/target/i386/tcg/tcg-cpu.h
@@ -32,6 +32,7 @@
 #define XSAVE_AVX_OFFSET        0x240
 #define XSAVE_BNDREG_OFFSET     0x3c0
 #define XSAVE_BNDCSR_OFFSET     0x400
+#define XSAVE_APX_OFFSET        XSAVE_BNDREG_OFFSET
 #define XSAVE_OPMASK_OFFSET     0x440
 #define XSAVE_ZMM_HI256_OFFSET  0x480
 #define XSAVE_HI16_ZMM_OFFSET   0x680
@@ -52,9 +53,15 @@ typedef struct X86XSaveArea {
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
@@ -71,8 +78,9 @@ QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.mxcsr) != XSAVE_MXCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.fpregs) != XSAVE_ST_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, legacy.xmm_regs) != XSAVE_XMM_SPACE_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, avx_state) != XSAVE_AVX_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndreg_state) != XSAVE_BNDREG_OFFSET);
-QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, bndcsr_state) != XSAVE_BNDCSR_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, apx_state) != XSAVE_APX_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndreg) != XSAVE_BNDREG_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, mpx_state.bndcsr) != XSAVE_BNDCSR_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, opmask_state) != XSAVE_OPMASK_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, zmm_hi256_state) != XSAVE_ZMM_HI256_OFFSET);
 QEMU_BUILD_BUG_ON(offsetof(X86XSaveArea, hi16_zmm_state) != XSAVE_HI16_ZMM_OFFSET);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 4133b5f244c..cb25018ecbb 100644
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
index 56d093da8c9..fb473c28f7b 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2709,6 +2709,19 @@ static void do_xsave_pkru(X86Access *ac, target_ulong ptr)
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
@@ -2773,14 +2786,19 @@ static void do_xsave_access(X86Access *ac, target_ulong ptr, uint64_t rfbm,
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
@@ -2974,6 +2992,29 @@ static void do_fxrstor(X86Access *ac, target_ulong ptr)
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
@@ -3045,7 +3086,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(mpx_state.bndreg));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -3054,7 +3095,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -3072,6 +3113,15 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
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
@@ -3253,6 +3303,7 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
     env->xcr0 = mask;
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
     return;
 
  do_gpf:
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 2402608fe90..9db9795a3b2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -200,12 +200,13 @@ static void x86_tcg_cpu_xsave_init(void)
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


