Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449E3FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi08-0000Fm-60; Sun, 01 Mar 2026 09:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi07-0000FR-1F
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi05-0005hp-7g
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rA4MuoUWmXPQm8XF//NcOYkPAnhjZ821mcmAcEjJyA=;
 b=bjPTrXiiClzcTyEMa8UMwnFlBY90hdfS7s/rxnL8mGHJjhcjoIb++BpnRkPFzi8O+mXqkH
 pb0bcabZPy5s8CSdnqYVxvk/sXZCY5v1mfsKdOC9D+CkWyv8T4UaG3j2BKzom5NFFT9MT0
 mACznU4J3jLE3Vgg7JByxYrdacLGsyw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-5-i-QV29M--fEtKshWajIA-1; Sun, 01 Mar 2026 09:42:27 -0500
X-MC-Unique: 5-i-QV29M--fEtKshWajIA-1
X-Mimecast-MFC-AGG-ID: 5-i-QV29M--fEtKshWajIA_1772376146
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso41586505e9.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376145; x=1772980945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4rA4MuoUWmXPQm8XF//NcOYkPAnhjZ821mcmAcEjJyA=;
 b=YwPhqr7zqlP8IP4ZmgK+mwPP5vodTkIc4T00Nfwwz/ow8mz5qkC3IFIbvc+bErqi5X
 V+2MY2VVk8aR+VSYnWA2vpIB5unD0CZP7Ilzd2oa67aVHLXlEpSnT9WmoSMtC/xhewE/
 2XAUsN5FqHbbhjS13B2omw4XSO5I5ZuNBHr4i5l/AZIWO52vXFX41OECaqmNh4/uCt1y
 4LsfmEqoETeEYpd1LmBanOPJgwqI78s/tXfXWaa1NNVSvWxGYOq5gCtb0QAD4Tkk5ihF
 WBiVOcx2/yEhf3BXNDRJ7qo/GmY7n4gaSpxDfkwxV9wppoEm5v5sWbPfIdUmqztpilcY
 jdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376145; x=1772980945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4rA4MuoUWmXPQm8XF//NcOYkPAnhjZ821mcmAcEjJyA=;
 b=PI2kyeKnNUv+Z693kInlGN6VLqGOeKtF6PpyI42MyRPYh4eHC8+ATGpULVeieY2eNE
 fWvcXKMsbcyN6UQb5lNp4sENI1F0k/KOS15o9AsVoDW/jqohLcArwYP/HhGSsDagEqJX
 JUQlyhTAHRhqwmerO/1J47hWlEx6KEaTp/LX41UUlj+SJLIdRkVlbAhPW8RsqHf70xrf
 t1bx0C7H1clfViNvpNVPZbbaLXbLRf1LE3CN+aT+EFeevPNrssglcF05xCGYDi91W42+
 FR0KEoIuymghzH3QKymcAi8qrzsOrMyL6ZnO9VwustRUPgq0V6HVDlIXPxSrATd91H0E
 Pnmw==
X-Gm-Message-State: AOJu0Yy7kq6z1mpNFl/nAUzFttjd6F+HF5HQDeKZRbP62mzxIlrX/kFj
 5jQU08Ci8q57l4e08qm4B78sx8OTs4zIXyQgvQisjip3LzklCvmonZqCVaA8mB8ttOV5UVOXfgQ
 BdzCe0drh04gOW92MMWosfQ3mDpX+dC8Xv4JmvTuQOZOTDSEsehdYoYp/JaWR7I0wIlHFdgV4F8
 MFcdqP3pMOSHhkWM5cUOC8vhKnmypDUVQlBk7lIwEg
X-Gm-Gg: ATEYQzwecQ4NC/aef98Ckwv9MZmKebOBu84VnB44UthDIVi4nQJixDgPj8/JdjtTxpG
 YJ0a7pC5Msntxuh2OHupPorTteJ0G5h2OeDgdMdm5cWRz29Bl+GWwgCmdv/8Pn2DTWQfH/VfEPy
 +eT5d1STFOQYbjkb2XdkHgUYI3IYkk2AOfuTxffXUQN3M8RmRmo25agznQbKTJ+RGJX80ThPI83
 VHl7tEYdHI43TT5ivNsNbjzxWAI4uNWb//5sVfvYvZe9+JXPmvV2nIJZkwJmxDZU+Ryjyp4Phh7
 Y8OVjuGbKorHSST9pz3QA+LrdIz7jM7Kv67G06Nc2Do88W8TW9LP8F55JESf1ADKe6IiOkjIBO5
 tnknMuj7P+ogjAD/rHkD56l2HQxHYmn9dbCyViTm8ly9LSu+bykQol0j6C/tny7Cvw1NxbmQ6lp
 8idifA8gc9P9+3cbDiUbclQnGx2q4=
X-Received: by 2002:a05:600c:3e12:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-483c9babd97mr159956655e9.9.1772376145393; 
 Sun, 01 Mar 2026 06:42:25 -0800 (PST)
X-Received: by 2002:a05:600c:3e12:b0:480:6ab1:ed0d with SMTP id
 5b1f17b1804b1-483c9babd97mr159955955e9.9.1772376144774; 
 Sun, 01 Mar 2026 06:42:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75df90sm359259615e9.14.2026.03.01.06.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/18] target/i386/tcg: add APX support to XSAVE/XRSTOR
Date: Sun,  1 Mar 2026 15:42:02 +0100
Message-ID: <20260301144218.458140-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301144218.458140-1-pbonzini@redhat.com>
References: <20260301144218.458140-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index da5161fc1a5..7586ea0ed8d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -186,6 +186,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_SHIFT     26 /* BND registers in-use */
 #define HF_UMIP_SHIFT       27 /* CR4.UMIP */
 #define HF_AVX_EN_SHIFT     28 /* AVX Enabled (CR4+XCR0) */
+#define HF_APX_EN_SHIFT     29 /* APX Enabled (CR4+XCR0) */
 
 #define HF_CPL_MASK          (3 << HF_CPL_SHIFT)
 #define HF_INHIBIT_IRQ_MASK  (1 << HF_INHIBIT_IRQ_SHIFT)
@@ -213,6 +214,7 @@ typedef enum X86Seg {
 #define HF_MPX_IU_MASK       (1 << HF_MPX_IU_SHIFT)
 #define HF_UMIP_MASK         (1 << HF_UMIP_SHIFT)
 #define HF_AVX_EN_MASK       (1 << HF_AVX_EN_SHIFT)
+#define HF_APX_EN_MASK       (1 << HF_APX_EN_SHIFT)
 
 /* hflags2 */
 
@@ -2729,6 +2731,7 @@ static inline bool x86_has_cpuid_0x1f(X86CPU *cpu)
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
index f9f9488eb4d..d01b12f8af7 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -35,6 +35,16 @@
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
@@ -249,6 +259,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)
 
     cpu_sync_bndcs_hflags(env);
     cpu_sync_avx_hflag(env);
+    cpu_sync_apx_hflag(env);
 }
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index b3b23823fda..26fc9af7082 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2691,6 +2691,19 @@ static void do_xsave_pkru(X86Access *ac, target_ulong ptr)
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
@@ -2755,14 +2768,19 @@ static void do_xsave_access(X86Access *ac, target_ulong ptr, uint64_t rfbm,
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
@@ -2956,6 +2974,29 @@ static void do_fxrstor(X86Access *ac, target_ulong ptr)
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
@@ -3027,7 +3068,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(ac, ptr + XO(bndreg_state));
+            do_xrstor_bndregs(ac, ptr + XO(mpx_state.bndreg));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -3036,7 +3077,7 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(ac, ptr + XO(bndcsr_state));
+            do_xrstor_bndcsr(ac, ptr + XO(mpx_state.bndcsr));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -3054,6 +3095,15 @@ static void do_xrstor(X86Access *ac, target_ulong ptr,
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
@@ -3229,6 +3279,7 @@ void helper_xsetbv(CPUX86State *env, uint32_t ecx, uint64_t mask)
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
2.52.0


