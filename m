Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B27CF884E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlFJ-0007zW-Qw; Fri, 04 Oct 2024 12:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlEq-0007HL-K9
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:33:08 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlEn-0005pQ-OY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:33:08 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so2581146e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059583; x=1728664383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2s/tzGPg/LmnPo+rxsPQADcqJffZEpvaXgXhuXN6AeQ=;
 b=sAI8EQpCYesTCsw2GsCCQcrNrdCSx9ho3tzjWRFFR+Z9PfhiJZwNYB3qZrw6eJyY+E
 s2tVNL7nTS6yuzxKCK5TB7BJShNnDhTU4DOs3pZbRYicp/2KYbShxGJtjWjSIs9OlP+5
 oGiEidj7NwcWp5RYo5bD8mR7ECWelg1f9hRmejNg16Mpwf840eFImEdkRbQk3sVWXt9E
 iUM61x/1UhF28HcF8IP7qMPnkG+4gcOv4i486Zzgh3ZZV0vw93mk5N+0mSXxxdSgAvDs
 FEUOTltjwd9dBo/H1M/nkwi8gd8UfnfvlKH2nmBPFR95MI/BEBmAaxr/GIq15edMji0U
 Vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059583; x=1728664383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2s/tzGPg/LmnPo+rxsPQADcqJffZEpvaXgXhuXN6AeQ=;
 b=mvHZdHRmSixA4FM2p0K0juHZqhbwFsWlX+IRzL4VbP+M5WkBroSGDpYKVYWBpqJ76T
 JtU8eGLyqX7nlqvtOW9/sPllijSg8KuYXdyM51kDBolgQ4ec346LraFq2U5Xg0FtTRoT
 EZj8FBzfpZKSh3ZiKIe14mLzKmBLzOiAHwq5UBaufx1I5scX7EtoQEUusZ++4vAtZDB6
 ZBnRLB56+DK8txsU+iTvCyY7njguz6vErPG95Lbxr6b0mPczgs1M1Z5okai13kBk8i5L
 a8fBkCuQaKgv3J/LscSxDIJ5RiOFEG+hItLClHfzUaaJIUmOBQ8GDAj23Ar9/mfVoZWO
 8NaA==
X-Gm-Message-State: AOJu0YwBbvFNwlTjUHeYEZeqW/eOXtcsZ7rSIP6JzpSlxEugLdfUmtsC
 9frW8SdiLOm8BXyoqfPDTu+aTWFR2jETo85M5ye+5acgc3tx9IOSG5p0eowlFrtfmZCLZgtmZ+s
 +lfwvxQ==
X-Google-Smtp-Source: AGHT+IGC4fHpQTA+27ggAZsNhRcHU2c/GQgEsPn+l3WUcVvbsSReakNbFECwUaxnJDpvvOqCLsru5w==
X-Received: by 2002:a05:6512:39c5:b0:535:6cbf:51a3 with SMTP id
 2adb3069b0e04-539ab88a017mr2509555e87.25.1728059582806; 
 Fri, 04 Oct 2024 09:33:02 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec8255sm1950e87.83.2024.10.04.09.32.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:33:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/25] target/i386: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:25 -0300
Message-ID: <20241004163042.85922-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/i386/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/gdbstub.c                | 30 +++++++++++++-------------
 target/i386/tcg/sysemu/excp_helper.c |  4 ++--
 target/i386/xsave_helper.c           | 32 ++++++++++++++--------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879e..28ccf06309d 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -89,10 +89,10 @@ static int gdb_read_reg_cs64(uint32_t hflags, GByteArray *buf, target_ulong val)
 static int gdb_write_reg_cs64(uint32_t hflags, uint8_t *buf, target_ulong *val)
 {
     if (hflags & HF_CS64_MASK) {
-        *val = ldq_p(buf);
+        *val = ldq_le_p(buf);
         return 8;
     }
-    *val = ldl_p(buf);
+    *val = ldl_le_p(buf);
     return 4;
 }
 
@@ -221,7 +221,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
 {
     CPUX86State *env = &cpu->env;
-    uint16_t selector = ldl_p(mem_buf);
+    uint16_t selector = ldl_le_p(mem_buf);
 
     if (selector != env->segs[sreg].selector) {
 #if defined(CONFIG_USER_ONLY)
@@ -262,15 +262,15 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS == 64) {
             if (env->hflags & HF_CS64_MASK) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+                env->regs[gpr_map[n]] = ldtul_le_p(mem_buf);
             } else if (n < CPU_NB_REGS32) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+                env->regs[gpr_map[n]] = ldtul_le_p(mem_buf) & 0xffffffffUL;
             }
             return sizeof(target_ulong);
         } else if (n < CPU_NB_REGS32) {
             n = gpr_map32[n];
             env->regs[n] &= ~0xffffffffUL;
-            env->regs[n] |= (uint32_t)ldl_p(mem_buf);
+            env->regs[n] |= (uint32_t)ldl_le_p(mem_buf);
             return 4;
         }
     } else if (n >= IDX_FP_REGS && n < IDX_FP_REGS + 8) {
@@ -281,8 +281,8 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else if (n >= IDX_XMM_REGS && n < IDX_XMM_REGS + CPU_NB_REGS) {
         n -= IDX_XMM_REGS;
         if (n < CPU_NB_REGS32 || TARGET_LONG_BITS == 64) {
-            env->xmm_regs[n].ZMM_Q(0) = ldq_p(mem_buf);
-            env->xmm_regs[n].ZMM_Q(1) = ldq_p(mem_buf + 8);
+            env->xmm_regs[n].ZMM_Q(0) = ldq_le_p(mem_buf);
+            env->xmm_regs[n].ZMM_Q(1) = ldq_le_p(mem_buf + 8);
             return 16;
         }
     } else {
@@ -290,18 +290,18 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_IP_REG:
             if (TARGET_LONG_BITS == 64) {
                 if (env->hflags & HF_CS64_MASK) {
-                    env->eip = ldq_p(mem_buf);
+                    env->eip = ldq_le_p(mem_buf);
                 } else {
-                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
+                    env->eip = ldq_le_p(mem_buf) & 0xffffffffUL;
                 }
                 return 8;
             } else {
                 env->eip &= ~0xffffffffUL;
-                env->eip |= (uint32_t)ldl_p(mem_buf);
+                env->eip |= (uint32_t)ldl_le_p(mem_buf);
                 return 4;
             }
         case IDX_FLAGS_REG:
-            env->eflags = ldl_p(mem_buf);
+            env->eflags = ldl_le_p(mem_buf);
             return 4;
 
         case IDX_SEG_REGS:
@@ -327,10 +327,10 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
 
         case IDX_FP_REGS + 8:
-            cpu_set_fpuc(env, ldl_p(mem_buf));
+            cpu_set_fpuc(env, ldl_le_p(mem_buf));
             return 4;
         case IDX_FP_REGS + 9:
-            tmp = ldl_p(mem_buf);
+            tmp = ldl_le_p(mem_buf);
             env->fpstt = (tmp >> 11) & 7;
             env->fpus = tmp & ~0x3800;
             return 4;
@@ -348,7 +348,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
 
         case IDX_MXCSR_REG:
-            cpu_set_mxcsr(env, ldl_p(mem_buf));
+            cpu_set_mxcsr(env, ldl_le_p(mem_buf));
             return 4;
 
         case IDX_CTL_CR0_REG:
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f531..de6765099f3 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -86,7 +86,7 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
-        return ldl_p(in->haddr);
+        return ldl_le_p(in->haddr);
     }
     return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
@@ -94,7 +94,7 @@ static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
-        return ldq_p(in->haddr);
+        return ldq_le_p(in->haddr);
     }
     return cpu_ldq_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
diff --git a/target/i386/xsave_helper.c b/target/i386/xsave_helper.c
index 996e9f3bfef..fc10bfa6718 100644
--- a/target/i386/xsave_helper.c
+++ b/target/i386/xsave_helper.c
@@ -43,8 +43,8 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
     for (i = 0; i < CPU_NB_REGS; i++) {
         uint8_t *xmm = legacy->xmm_regs[i];
 
-        stq_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
-        stq_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
+        stq_le_p(xmm,     env->xmm_regs[i].ZMM_Q(0));
+        stq_le_p(xmm + 8, env->xmm_regs[i].ZMM_Q(1));
     }
 
     header->xstate_bv = env->xstate_bv;
@@ -58,8 +58,8 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             uint8_t *ymmh = avx->ymmh[i];
 
-            stq_p(ymmh,     env->xmm_regs[i].ZMM_Q(2));
-            stq_p(ymmh + 8, env->xmm_regs[i].ZMM_Q(3));
+            stq_le_p(ymmh,     env->xmm_regs[i].ZMM_Q(2));
+            stq_le_p(ymmh + 8, env->xmm_regs[i].ZMM_Q(3));
         }
     }
 
@@ -101,10 +101,10 @@ void x86_cpu_xsave_all_areas(X86CPU *cpu, void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             uint8_t *zmmh = zmm_hi256->zmm_hi256[i];
 
-            stq_p(zmmh,      env->xmm_regs[i].ZMM_Q(4));
-            stq_p(zmmh + 8,  env->xmm_regs[i].ZMM_Q(5));
-            stq_p(zmmh + 16, env->xmm_regs[i].ZMM_Q(6));
-            stq_p(zmmh + 24, env->xmm_regs[i].ZMM_Q(7));
+            stq_le_p(zmmh,      env->xmm_regs[i].ZMM_Q(4));
+            stq_le_p(zmmh + 8,  env->xmm_regs[i].ZMM_Q(5));
+            stq_le_p(zmmh + 16, env->xmm_regs[i].ZMM_Q(6));
+            stq_le_p(zmmh + 24, env->xmm_regs[i].ZMM_Q(7));
         }
 
 #ifdef TARGET_X86_64
@@ -177,8 +177,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
     for (i = 0; i < CPU_NB_REGS; i++) {
         const uint8_t *xmm = legacy->xmm_regs[i];
 
-        env->xmm_regs[i].ZMM_Q(0) = ldq_p(xmm);
-        env->xmm_regs[i].ZMM_Q(1) = ldq_p(xmm + 8);
+        env->xmm_regs[i].ZMM_Q(0) = ldq_le_p(xmm);
+        env->xmm_regs[i].ZMM_Q(1) = ldq_le_p(xmm + 8);
     }
 
     env->xstate_bv = header->xstate_bv;
@@ -191,8 +191,8 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             const uint8_t *ymmh = avx->ymmh[i];
 
-            env->xmm_regs[i].ZMM_Q(2) = ldq_p(ymmh);
-            env->xmm_regs[i].ZMM_Q(3) = ldq_p(ymmh + 8);
+            env->xmm_regs[i].ZMM_Q(2) = ldq_le_p(ymmh);
+            env->xmm_regs[i].ZMM_Q(3) = ldq_le_p(ymmh + 8);
         }
     }
 
@@ -241,10 +241,10 @@ void x86_cpu_xrstor_all_areas(X86CPU *cpu, const void *buf, uint32_t buflen)
         for (i = 0; i < CPU_NB_REGS; i++) {
             const uint8_t *zmmh = zmm_hi256->zmm_hi256[i];
 
-            env->xmm_regs[i].ZMM_Q(4) = ldq_p(zmmh);
-            env->xmm_regs[i].ZMM_Q(5) = ldq_p(zmmh + 8);
-            env->xmm_regs[i].ZMM_Q(6) = ldq_p(zmmh + 16);
-            env->xmm_regs[i].ZMM_Q(7) = ldq_p(zmmh + 24);
+            env->xmm_regs[i].ZMM_Q(4) = ldq_le_p(zmmh);
+            env->xmm_regs[i].ZMM_Q(5) = ldq_le_p(zmmh + 8);
+            env->xmm_regs[i].ZMM_Q(6) = ldq_le_p(zmmh + 16);
+            env->xmm_regs[i].ZMM_Q(7) = ldq_le_p(zmmh + 24);
         }
 
 #ifdef TARGET_X86_64
-- 
2.45.2


