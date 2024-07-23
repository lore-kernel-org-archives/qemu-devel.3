Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E009AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yc-0001hC-Hl; Mon, 22 Jul 2024 21:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3ya-0001ew-U0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:00 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yY-0008P4-Bg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:00 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a1a6af940cso214517685a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696756; x=1722301556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuI0OBU7+znySR9fck86H7yJwkkhEYX3J4q9eeUwu80=;
 b=YIDn7GxFHm7T2yQpnqBuQp30MKSobns4EoMwNc5tsLbMSj+NEPW250fXTPqgfEnd9a
 OgXaPJRwMJLAaRpVzIfKAMnuOmam/YJm+lp3d2xsYzgjh1i6/pQSAfs1tJL/w0tHI2BL
 1ubwNo6GbaX3bjZ3a1SHGWPqKgPs+5iIpDoyFb0YURXjGAKMfmvQzd7w/A0B+no1k7We
 4iBwUzYxNRRuRtxZOvHSLcCffEltfsabuKieNW6InLQpim622qzMSubYYKgplXJfW45+
 YPchIvu0JA623pqv35kCDIH0V4GyrUk3WQIlWTKtbUEliBmjBkT4WQXLW+5ocfQ3CoDm
 hr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696756; x=1722301556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BuI0OBU7+znySR9fck86H7yJwkkhEYX3J4q9eeUwu80=;
 b=LtVLWrPhp+oUeKAs/xfrdQYKLiUWEu1S5twQpSVCFctcsJQpBp9294oBlx1+dAsKv7
 1J353ZGLQ6xBNs8N0nACfZV6dAqM/bGfhHCzPLBIxTcS5wdR7ka/28WOFu1FGhGR0fCi
 Sb2C/eNFr7AYN/XYNkDTlZKvJhEmocZZxrAOGIRogv3UXNh2SU7yVkYtkqKYqp4XOiyI
 DHzqayL+TXkNBa/IYxOBTNPSg/U68phyY4bRiZiaMTSMdQIFOAif6Xmj+Bj7Q8UDv+hd
 TcNxrCftMmhLZe21ouml+VVmfeLptJIYX1o3lY8BbTVrRBhlOQ1MX6UlnYmVPQkvq636
 szPQ==
X-Gm-Message-State: AOJu0YyvFg7V5SW0Q3eNJZR0sCUFZRBkGy2k/dkjhl0KPhURe82tZQu5
 GX5yil0Z3ltq2dYy/dO3Eh+91Rj63T9B6fA6azx9f/gCkICUgz2u0k+amiP5Naeho+C6PkykmcL
 hDXOQD0H7fwqwvxS5tKS7pSKqPLHCEibSWv2d3D8dHzhmXYNbtlWRtffEwBU7OBXT8RFeK4KJbc
 O97bjhKEBl2c/9FR+p3z4eC06rgh9C
X-Google-Smtp-Source: AGHT+IFw+F8IEQN74p1phVOPI1IGNKcs1wUZiYCPfugJbg0cFtziOxs9V1OFiVWNcXT7fA56dGcDLA==
X-Received: by 2002:a05:620a:2944:b0:79d:63ec:b7df with SMTP id
 af79cd13be357-7a1c2eb955dmr99009785a.5.1721696756456; 
 Mon, 22 Jul 2024 18:05:56 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:05:55 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 1/7] Code motion: expose some TCG definitions for page
 table walk consolidation.
Date: Mon, 22 Jul 2024 21:05:39 -0400
Message-Id: <20240723010545.3648706-2-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x733.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 include/hw/core/sysemu-cpu-ops.h     |  6 +++++
 target/i386/cpu.h                    |  5 ++--
 target/i386/helper.c                 | 36 +++++++++++++++++++++++++++
 target/i386/tcg/helper-tcg.h         | 32 ++++++++++++++++++++++++
 target/i386/tcg/seg_helper.c         | 36 ---------------------------
 target/i386/tcg/sysemu/excp_helper.c | 37 +---------------------------
 6 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 24d003fe04..4c94e51267 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -12,6 +12,12 @@
 
 #include "hw/core/cpu.h"
 
+typedef enum TranslateFaultStage2 {
+    S2_NONE,
+    S2_GPA,
+    S2_GPT,
+} TranslateFaultStage2;
+
 /*
  * struct SysemuCPUOps: System operations specific to a CPU class
  */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 1e121acef5..d899644cb8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -21,6 +21,7 @@
 #define I386_CPU_H
 
 #include "sysemu/tcg.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-defs.h"
@@ -2362,6 +2363,7 @@ void host_cpuid(uint32_t function, uint32_t count,
 bool cpu_has_x2apic_feature(CPUX86State *env);
 
 /* helper.c */
+int get_pg_mode(CPUX86State *env);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
@@ -2540,9 +2542,6 @@ static inline bool cpu_vmx_maybe_enabled(CPUX86State *env)
            ((env->cr[4] & CR4_VMXE_MASK) || (env->hflags & HF_SMM_MASK));
 }
 
-/* excp_helper.c */
-int get_pg_mode(CPUX86State *env);
-
 /* fpu_helper.c */
 void update_fp_status(CPUX86State *env);
 void update_mxcsr_status(CPUX86State *env);
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 01a268a30b..9cb6e51426 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -721,3 +721,39 @@ void x86_stq_phys(CPUState *cs, hwaddr addr, uint64_t val)
     address_space_stq(as, addr, val, attrs, NULL);
 }
 #endif
+
+int get_pg_mode(CPUX86State *env)
+{
+    int pg_mode = 0;
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        return 0;
+    }
+    if (env->cr[0] & CR0_WP_MASK) {
+        pg_mode |= PG_MODE_WP;
+    }
+    if (env->cr[4] & CR4_PAE_MASK) {
+        pg_mode |= PG_MODE_PAE;
+        if (env->efer & MSR_EFER_NXE) {
+            pg_mode |= PG_MODE_NXE;
+        }
+    }
+    if (env->cr[4] & CR4_PSE_MASK) {
+        pg_mode |= PG_MODE_PSE;
+    }
+    if (env->cr[4] & CR4_SMEP_MASK) {
+        pg_mode |= PG_MODE_SMEP;
+    }
+    if (env->hflags & HF_LMA_MASK) {
+        pg_mode |= PG_MODE_LMA;
+        if (env->cr[4] & CR4_PKE_MASK) {
+            pg_mode |= PG_MODE_PKE;
+        }
+        if (env->cr[4] & CR4_PKS_MASK) {
+            pg_mode |= PG_MODE_PKS;
+        }
+        if (env->cr[4] & CR4_LA57_MASK) {
+            pg_mode |= PG_MODE_LA57;
+        }
+    }
+    return pg_mode;
+}
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 15d6c6f8b4..1cbeab9161 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -92,6 +92,38 @@ extern const uint8_t parity_table[256];
 /* misc_helper.c */
 void cpu_load_eflags(CPUX86State *env, int eflags, int update_mask);
 
+/* sysemu/excp_helper.c */
+typedef struct TranslateFault {
+    int exception_index;
+    int error_code;
+    target_ulong cr2;
+    TranslateFaultStage2 stage2;
+} TranslateFault;
+
+typedef struct PTETranslate {
+    CPUX86State *env;
+    TranslateFault *err;
+    int ptw_idx;
+    void *haddr;
+    hwaddr gaddr;
+} PTETranslate;
+
+bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new);
+
+static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
+{
+    if (set & ~old) {
+        uint32_t new = old | set;
+        if (likely(in->haddr)) {
+            old = cpu_to_le32(old);
+            new = cpu_to_le32(new);
+            return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) == old;
+        }
+        return ptw_setl_slow(in, old, new);
+    }
+    return true;
+}
+
 /* sysemu/svm_helper.c */
 #ifndef CONFIG_USER_ONLY
 G_NORETURN void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index aac092a356..90f01180d9 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -92,42 +92,6 @@ static uint32_t popl(StackAccess *sa)
     return ret;
 }
 
-int get_pg_mode(CPUX86State *env)
-{
-    int pg_mode = 0;
-    if (!(env->cr[0] & CR0_PG_MASK)) {
-        return 0;
-    }
-    if (env->cr[0] & CR0_WP_MASK) {
-        pg_mode |= PG_MODE_WP;
-    }
-    if (env->cr[4] & CR4_PAE_MASK) {
-        pg_mode |= PG_MODE_PAE;
-        if (env->efer & MSR_EFER_NXE) {
-            pg_mode |= PG_MODE_NXE;
-        }
-    }
-    if (env->cr[4] & CR4_PSE_MASK) {
-        pg_mode |= PG_MODE_PSE;
-    }
-    if (env->cr[4] & CR4_SMEP_MASK) {
-        pg_mode |= PG_MODE_SMEP;
-    }
-    if (env->hflags & HF_LMA_MASK) {
-        pg_mode |= PG_MODE_LMA;
-        if (env->cr[4] & CR4_PKE_MASK) {
-            pg_mode |= PG_MODE_PKE;
-        }
-        if (env->cr[4] & CR4_PKS_MASK) {
-            pg_mode |= PG_MODE_PKS;
-        }
-        if (env->cr[4] & CR4_LA57_MASK) {
-            pg_mode |= PG_MODE_LA57;
-        }
-    }
-    return pg_mode;
-}
-
 /* return non zero if error */
 static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,
                                uint32_t *e2_ptr, int selector,
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..3ebb67d65b 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -39,27 +39,6 @@ typedef struct TranslateResult {
     int page_size;
 } TranslateResult;
 
-typedef enum TranslateFaultStage2 {
-    S2_NONE,
-    S2_GPA,
-    S2_GPT,
-} TranslateFaultStage2;
-
-typedef struct TranslateFault {
-    int exception_index;
-    int error_code;
-    target_ulong cr2;
-    TranslateFaultStage2 stage2;
-} TranslateFault;
-
-typedef struct PTETranslate {
-    CPUX86State *env;
-    TranslateFault *err;
-    int ptw_idx;
-    void *haddr;
-    hwaddr gaddr;
-} PTETranslate;
-
 static bool ptw_translate(PTETranslate *inout, hwaddr addr, uint64_t ra)
 {
     CPUTLBEntryFull *full;
@@ -104,7 +83,7 @@ static inline uint64_t ptw_ldq(const PTETranslate *in, uint64_t ra)
  * even 64-bit ones, because PG_PRESENT_MASK, PG_ACCESSED_MASK and
  * PG_DIRTY_MASK are all in the low 32 bits.
  */
-static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
+bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
 {
     uint32_t cmp;
 
@@ -118,20 +97,6 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
     return cmp == old;
 }
 
-static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
-{
-    if (set & ~old) {
-        uint32_t new = old | set;
-        if (likely(in->haddr)) {
-            old = cpu_to_le32(old);
-            new = cpu_to_le32(new);
-            return qatomic_cmpxchg((uint32_t *)in->haddr, old, new) == old;
-        }
-        return ptw_setl_slow(in, old, new);
-    }
-    return true;
-}
-
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                           TranslateResult *out, TranslateFault *err,
                           uint64_t ra)
-- 
2.34.1


