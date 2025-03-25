Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFC0C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 13:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3wK-0001ES-Id; Tue, 25 Mar 2025 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vP-0000pF-8T
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3vM-000824-Vp
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 09:02:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so38535275e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 06:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907750; x=1743512550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHkl1CLLTMtxzzv7to/S3wSbPsj8b4TlffAoIJKx3UM=;
 b=VUTu5RSWfwR0TBwN7s4Ng7ylnc+06k55gxqq6tnlvTs7SsxJ9aNj52AfnNfNV8uy39
 qu39VAgyWQYk0hAenXqsdjJFJ6nMqobjD7DFgGMpGpXdEjJSzPi3hOe48OGxw1Mf5ZXo
 hjRlGOESHiPLDRE3nLUmkYitzPgzHlULqS/QCrml8BmlgP4xmyO522rz/4TyDt2CnoVH
 /31hVLsiTXmB/7MGtDGIp/0tuL5XwLPwadSaFxdK+K3Bmls4cwwVuRYF2OGKTBZJmksF
 +ZZ3v55seCO7zWo3nPRle3X9M1KeI3hBKw6yAYD8ZXZ+4HDiMhcdgO6/WgbokD+qksne
 gBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907750; x=1743512550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHkl1CLLTMtxzzv7to/S3wSbPsj8b4TlffAoIJKx3UM=;
 b=H2GfN0fZOwWGy4kvEKINgBhzrDVLLmgHLfFjyTXf2E19RlS6xWjfc0W0H2SYxCux4X
 ljQhJdog75CaYI2/9MqH/2gaphQYUfJtxnG+pNTCvQIkkrhv6Gr8lHxmhMTBYYk1MTgx
 N+JkpvthAJuvxoknGQpT2gTxrfg9EFfFecqsY6N92+sk+HvJXQD1PzO7jncGy64gBOYO
 SG7OCNOLEFz7yyRIEGXgc3jT/ViEyENyCl3acIG0q6OyWSO+7ZNWdhvAkpZEOh0KOJtH
 ORuqRGqoRsQGyVYogLFJJ2Q+nuih7JDZuYFv+F285B5fLVnDx9hESdsYA2cjIgZDhn7b
 VCdA==
X-Gm-Message-State: AOJu0Yy3LPPNpxUzqJB6Q3SV8NsAdbn7XtG74XYtIVLyKBrlsdP2clBG
 ECY/oy9HPDHFt02ZfA5pv91UskYvaqJDnZ36wvTsMmcmP129/SOdTjgBdRbRmEYszZJPtwrPwme
 w
X-Gm-Gg: ASbGncuET6+0cLlH+raenLrio3yYmjb3vXjl6jb3AtTXYmPIUP+lBbxQEJln3cA3Fvc
 JrIfkpEtm6d7HDI0VWaWtpj0SgMUvPAibSocSzE+qf16qbT0wf8C1YQl2rSWwScYv2SjwunSjzK
 vF2ksOShhMhhsuDmqgZq0lZylKLWi80/eIFNJO/LJMBNDx6xQy3MQ0KJSQjmVrKUkIdV1m3DYlO
 gfG0yJMkBBSfUuYWoXNXk3nZSWqJ2Aj9928gTO+6LorrYNuuS4PGqvJKpGgTzUo53j5lzMNlmlc
 qADH3HbMDHcTZVzjbEZBTgLqVxJw5SOWWwfR6Ny9B+rLRULPsAww0PFotzt2ayqBNVM4XEcUSaG
 S0XQIKRj1OCsbrHbRaW0vrKPoMRFKIw==
X-Google-Smtp-Source: AGHT+IFFDabTZixO+e5sAR1FX1lGbsGU7mFepQeZGMHMboFlwZ4ePzjLUfieuUPI1GSRjfgrNgbTVg==
X-Received: by 2002:a05:6000:1f8f:b0:391:2dea:c984 with SMTP id
 ffacd0b85a97d-3997f8f6129mr14693864f8f.11.1742907748366; 
 Tue, 25 Mar 2025 06:02:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e66a7sm13670849f8f.76.2025.03.25.06.02.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 06:02:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org
Subject: [PATCH-for-10.1 1/5] target/i386: Use explicit little-endian LD/ST API
Date: Tue, 25 Mar 2025 14:02:16 +0100
Message-ID: <20250325130221.76116-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
References: <20250325130221.76116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004163042.85922-10-philmd@linaro.org>
---
 target/i386/gdbstub.c                | 24 ++++++++++-----------
 target/i386/tcg/system/excp_helper.c |  4 ++--
 target/i386/xsave_helper.c           | 32 ++++++++++++++--------------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 04c49e802d7..9262cf46b0a 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -94,10 +94,10 @@ static int gdb_read_reg_cs64(uint32_t hflags, GByteArray *buf, target_ulong val)
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
 
@@ -231,7 +231,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
 {
     CPUX86State *env = &cpu->env;
-    uint16_t selector = ldl_p(mem_buf);
+    uint16_t selector = ldl_le_p(mem_buf);
 
     if (selector != env->segs[sreg].selector) {
 #if defined(CONFIG_USER_ONLY)
@@ -287,15 +287,15 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < CPU_NB_REGS) {
         if (TARGET_LONG_BITS == 64) {
             if (env->hflags & HF_CS64_MASK) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf);
+                env->regs[gpr_map[n]] = ldq_le_p(mem_buf);
             } else if (n < CPU_NB_REGS32) {
-                env->regs[gpr_map[n]] = ldtul_p(mem_buf) & 0xffffffffUL;
+                env->regs[gpr_map[n]] = ldq_le_p(mem_buf) & 0xffffffffUL;
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
@@ -306,8 +306,8 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
@@ -315,7 +315,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         case IDX_IP_REG:
             return gdb_write_reg(env, mem_buf, &env->eip);
         case IDX_FLAGS_REG:
-            env->eflags = ldl_p(mem_buf);
+            env->eflags = ldl_le_p(mem_buf);
             return 4;
 
         case IDX_SEG_REGS:
@@ -341,10 +341,10 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
@@ -362,7 +362,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             return 4;
 
         case IDX_MXCSR_REG:
-            cpu_set_mxcsr(env, ldl_p(mem_buf));
+            cpu_set_mxcsr(env, ldl_le_p(mem_buf));
             return 4;
 
         case IDX_CTL_CR0_REG:
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index 6876329de21..f00bb15afe0 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -85,7 +85,7 @@ static bool ptw_translate(PTETranslate *inout, hwaddr addr)
 static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
 {
     if (likely(in->haddr)) {
-        return ldl_p(in->haddr);
+        return ldl_le_p(in->haddr);
     }
     return cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, ra);
 }
@@ -93,7 +93,7 @@ static inline uint32_t ptw_ldl(const PTETranslate *in, uint64_t ra)
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
2.47.1


