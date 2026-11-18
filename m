Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6D606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F/cvyLUt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTeiL-0002db-Qe; Wed, 18 Nov 2026 07:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiH-0002Zx-J9
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTeiF-00069d-DL
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795004670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwVQzE5EFa2EKF962hF8oADevEyQ7b4RBeLH4bKQCLw=;
 b=F/cvyLUtPx3QB6IK5UNMT0v+lF2kvhiqvRfKHmPQJemhkzx0AL/nybRkIJcedAENYDWSLJ
 IYeLKiyVu0OEJCVqqk7P6wPKPQ6/tuG2ZWe/RtOVE4mgP/jxQOJLx+did+fTazzsc2h61H
 HcE76+nY0KUpvxWTvDpkEKmlwJEcfu4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-PDJqEoYkN9Cx8egzTXh9Fw-1; Wed,
 18 Nov 2026 07:24:29 -0500
X-MC-Unique: PDJqEoYkN9Cx8egzTXh9Fw-1
X-Mimecast-MFC-AGG-ID: PDJqEoYkN9Cx8egzTXh9Fw_1795004668
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5FE1F1956068
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:28 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B13C18004FC
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 12:24:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 26/26] target/i386/tcg: precompute CPUID features used by
 the decoder
Date: Wed, 18 Nov 2026 13:23:57 +0100
Message-ID: <20261118122357.659634-27-pbonzini@redhat.com>
In-Reply-To: <20261118122357.659634-1-pbonzini@redhat.com>
References: <20261118122357.659634-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

has_cpuid_feature() maps each X86CPUIDFeature to a CPUID feature word
and bit with a switch statement, which runs for every instruction.
Replace the switch with a table, and use it to compute a bitmask of the
X86CPUIDFeature values when the CPU is realized; when the decoder
runs, the check becomes a single bit test.

AI-used-for: code
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                |   2 +
 target/i386/tcg/helper-tcg.h     |   1 +
 target/i386/tcg/tcg-cpu.c        |  16 +++-
 target/i386/tcg/translate.c      |   6 +-
 target/i386/tcg/decode-new.c.inc | 130 +++++++++++++------------------
 5 files changed, 70 insertions(+), 85 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90371b..5996abf45c5 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2260,6 +2260,8 @@ typedef struct CPUArchState {
     uint32_t cpuid_vendor3;
     uint32_t cpuid_version;
     FeatureWordArray features;
+    /* Bitmask of X86CPUIDFeature values, used by the TCG decoder */
+    uint64_t tcg_cpuid_features;
     /* AVX10 version */
     uint8_t avx10_version;
     /* AVX10 (CPUID 0x24) maximum supported sub-leaf. */
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 4d543556a9f..a82577800fe 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -57,6 +57,7 @@ static inline target_long lshift(target_long x, int n)
 
 /* translate.c */
 void tcg_x86_init(void);
+void x86_tcg_init_cpuid_features(CPUX86State *env);
 void x86_translate_code(CPUState *cs, TranslationBlock *tb,
                         int *max_insns, vaddr pc, void *host_pc);
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 167ff7695ae..5731220d1f2 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -234,13 +234,23 @@ static void x86_tcg_cpu_instance_init(CPUState *cs)
     x86_tcg_cpu_xsave_init();
 }
 
+static bool x86_tcg_cpu_realizefn(CPUState *cs, Error **errp)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    x86_tcg_init_cpuid_features(&cpu->env);
+#ifndef CONFIG_USER_ONLY
+    return tcg_cpu_realizefn(cs, errp);
+#else
+    return true;
+#endif
+}
+
 static void x86_tcg_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
 
-#ifndef CONFIG_USER_ONLY
-    acc->cpu_target_realize = tcg_cpu_realizefn;
-#endif /* CONFIG_USER_ONLY */
+    acc->cpu_target_realize = x86_tcg_cpu_realizefn;
 
     acc->cpu_instance_init = x86_tcg_cpu_instance_init;
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index bc031d83064..798625ac604 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -129,8 +129,7 @@ typedef struct DisasContext {
     int cpuid_ext3_features;
     int cpuid_7_0_ebx_features;
     int cpuid_7_0_ecx_features;
-    int cpuid_7_1_eax_features;
-    int cpuid_xsave_features;
+    uint64_t tcg_cpuid_features;
 
     /* TCG local temps */
     TCGv cc_srcT;
@@ -3566,8 +3565,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_ext3_features = env->features[FEAT_8000_0001_ECX];
     dc->cpuid_7_0_ebx_features = env->features[FEAT_7_0_EBX];
     dc->cpuid_7_0_ecx_features = env->features[FEAT_7_0_ECX];
-    dc->cpuid_7_1_eax_features = env->features[FEAT_7_1_EAX];
-    dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
+    dc->tcg_cpuid_features = env->tcg_cpuid_features;
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
 
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c254ddfc7c3..9e699119b12 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -766,8 +766,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     return true;
 }
 
-static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid);
-
 #include "decode-table.h"
 
 /* Compute the value of a selector for OP_MATCH, OP_SELECT and OP_SWITCH.  */
@@ -812,7 +810,7 @@ static unsigned decode_selector(DisasContext *s, CPUX86State *env,
     case X86_SEL_NF:
         return EVEX_APX_NF(s);
     case X86_SEL_CPUID:
-        return has_cpuid_feature(s, step.arg);
+        return !!(s->tcg_cpuid_features & BIT_ULL(step.arg));
     default:
         g_assert_not_reached();
     }
@@ -1038,83 +1036,59 @@ static bool decode_ops(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     return true;
 }
 
-static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
+static const struct {
+    FeatureWord w;
+    uint64_t bit;
+} x86_cpuid_features[X86_FEAT_NR] = {
+    [X86_FEAT_3DNOW]      = { FEAT_8000_0001_EDX, CPUID_EXT2_3DNOW },
+    [X86_FEAT_ABM]        = { FEAT_8000_0001_ECX, CPUID_EXT3_ABM },
+    [X86_FEAT_ADX]        = { FEAT_7_0_EBX, CPUID_7_0_EBX_ADX },
+    [X86_FEAT_AES]        = { FEAT_1_ECX, CPUID_EXT_AES },
+    [X86_FEAT_AVX]        = { FEAT_1_ECX, CPUID_EXT_AVX },
+    [X86_FEAT_AVX2]       = { FEAT_7_0_EBX, CPUID_7_0_EBX_AVX2 },
+    [X86_FEAT_BMI1]       = { FEAT_7_0_EBX, CPUID_7_0_EBX_BMI1 },
+    [X86_FEAT_BMI2]       = { FEAT_7_0_EBX, CPUID_7_0_EBX_BMI2 },
+    [X86_FEAT_CLFLUSH]    = { FEAT_1_EDX, CPUID_CLFLUSH },
+    [X86_FEAT_CLFLUSHOPT] = { FEAT_7_0_EBX, CPUID_7_0_EBX_CLFLUSHOPT },
+    [X86_FEAT_CLWB]       = { FEAT_7_0_EBX, CPUID_7_0_EBX_CLWB },
+    [X86_FEAT_CMOV]       = { FEAT_1_EDX, CPUID_CMOV },
+    [X86_FEAT_CMPCCXADD]  = { FEAT_7_1_EAX, CPUID_7_1_EAX_CMPCCXADD },
+    [X86_FEAT_CX8]        = { FEAT_1_EDX, CPUID_CX8 },
+    [X86_FEAT_CX16]       = { FEAT_1_ECX, CPUID_EXT_CX16 },
+    [X86_FEAT_F16C]       = { FEAT_1_ECX, CPUID_EXT_F16C },
+    [X86_FEAT_FMA]        = { FEAT_1_ECX, CPUID_EXT_FMA },
+    [X86_FEAT_FSGSBASE]   = { FEAT_7_0_EBX, CPUID_7_0_EBX_FSGSBASE },
+    [X86_FEAT_FXSR]       = { FEAT_1_EDX, CPUID_FXSR },
+    [X86_FEAT_MOVBE]      = { FEAT_1_ECX, CPUID_EXT_MOVBE },
+    [X86_FEAT_PCLMULQDQ]  = { FEAT_1_ECX, CPUID_EXT_PCLMULQDQ },
+    [X86_FEAT_POPCNT]     = { FEAT_1_ECX, CPUID_EXT_POPCNT },
+    [X86_FEAT_SHA_NI]     = { FEAT_7_0_EBX, CPUID_7_0_EBX_SHA_NI },
+    [X86_FEAT_SSE]        = { FEAT_1_EDX, CPUID_SSE },
+    [X86_FEAT_SSE2]       = { FEAT_1_EDX, CPUID_SSE2 },
+    [X86_FEAT_SSE3]       = { FEAT_1_ECX, CPUID_EXT_SSE3 },
+    [X86_FEAT_SSSE3]      = { FEAT_1_ECX, CPUID_EXT_SSSE3 },
+    [X86_FEAT_SSE41]      = { FEAT_1_ECX, CPUID_EXT_SSE41 },
+    [X86_FEAT_SSE42]      = { FEAT_1_ECX, CPUID_EXT_SSE42 },
+    [X86_FEAT_SSE4A]      = { FEAT_8000_0001_ECX, CPUID_EXT3_SSE4A },
+    [X86_FEAT_VAES]       = { FEAT_7_0_ECX, CPUID_7_0_ECX_VAES },
+    [X86_FEAT_XSAVE]      = { FEAT_1_ECX, CPUID_EXT_XSAVE },
+    [X86_FEAT_XSAVEOPT]   = { FEAT_XSAVE, CPUID_XSAVE_XSAVEOPT },
+};
+
+/* Called when the CPU is realized, after its CPUID features are final.  */
+void x86_tcg_init_cpuid_features(CPUX86State *env)
 {
-    switch (cpuid) {
-    case X86_FEAT_None:
-        return true;
-    case X86_FEAT_CMOV:
-        return (s->cpuid_features & CPUID_CMOV);
-    case X86_FEAT_CLFLUSH:
-        return (s->cpuid_features & CPUID_CLFLUSH);
-    case X86_FEAT_CX8:
-        return (s->cpuid_features & CPUID_CX8);
-    case X86_FEAT_FXSR:
-        return (s->cpuid_features & CPUID_FXSR);
-    case X86_FEAT_CX16:
-        return (s->cpuid_ext_features & CPUID_EXT_CX16);
-    case X86_FEAT_F16C:
-        return (s->cpuid_ext_features & CPUID_EXT_F16C);
-    case X86_FEAT_FMA:
-        return (s->cpuid_ext_features & CPUID_EXT_FMA);
-    case X86_FEAT_MOVBE:
-        return (s->cpuid_ext_features & CPUID_EXT_MOVBE);
-    case X86_FEAT_PCLMULQDQ:
-        return (s->cpuid_ext_features & CPUID_EXT_PCLMULQDQ);
-    case X86_FEAT_POPCNT:
-        return (s->cpuid_ext_features & CPUID_EXT_POPCNT);
-    case X86_FEAT_SSE:
-        return (s->cpuid_features & CPUID_SSE);
-    case X86_FEAT_SSE2:
-        return (s->cpuid_features & CPUID_SSE2);
-    case X86_FEAT_SSE3:
-        return (s->cpuid_ext_features & CPUID_EXT_SSE3);
-    case X86_FEAT_SSSE3:
-        return (s->cpuid_ext_features & CPUID_EXT_SSSE3);
-    case X86_FEAT_SSE41:
-        return (s->cpuid_ext_features & CPUID_EXT_SSE41);
-    case X86_FEAT_SSE42:
-        return (s->cpuid_ext_features & CPUID_EXT_SSE42);
-    case X86_FEAT_AES:
-        return (s->cpuid_ext_features & CPUID_EXT_AES);
-    case X86_FEAT_VAES:
-        return (s->cpuid_7_0_ecx_features & CPUID_7_0_ECX_VAES);
-    case X86_FEAT_AVX:
-        return (s->cpuid_ext_features & CPUID_EXT_AVX);
-    case X86_FEAT_XSAVE:
-        return (s->cpuid_ext_features & CPUID_EXT_XSAVE);
+    uint64_t mask = BIT_ULL(X86_FEAT_None);
+    int i;
 
-    case X86_FEAT_3DNOW:
-        return (s->cpuid_ext2_features & CPUID_EXT2_3DNOW);
-    case X86_FEAT_ABM:
-        return (s->cpuid_ext3_features & CPUID_EXT3_ABM);
-    case X86_FEAT_SSE4A:
-        return (s->cpuid_ext3_features & CPUID_EXT3_SSE4A);
-
-    case X86_FEAT_ADX:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_ADX);
-    case X86_FEAT_BMI1:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1);
-    case X86_FEAT_BMI2:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI2);
-    case X86_FEAT_AVX2:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_AVX2);
-    case X86_FEAT_CLFLUSHOPT:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLFLUSHOPT);
-    case X86_FEAT_CLWB:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLWB);
-    case X86_FEAT_FSGSBASE:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE);
-    case X86_FEAT_SHA_NI:
-        return (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SHA_NI);
-
-    case X86_FEAT_CMPCCXADD:
-        return (s->cpuid_7_1_eax_features & CPUID_7_1_EAX_CMPCCXADD);
-
-    case X86_FEAT_XSAVEOPT:
-        return (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT);
+    QEMU_BUILD_BUG_ON(X86_FEAT_NR > 64);
+    for (i = X86_FEAT_None + 1; i < X86_FEAT_NR; i++) {
+        assert(x86_cpuid_features[i].bit);
+        if (env->features[x86_cpuid_features[i].w] & x86_cpuid_features[i].bit) {
+            mask |= BIT_ULL(i);
+        }
     }
-    g_assert_not_reached();
+    env->tcg_cpuid_features = mask;
 }
 
 static bool validate_evex_apx(DisasContext *s, X86DecodedInsn *decode)
@@ -1238,7 +1212,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
         break;
 
     case X86_VEX_AVX2_256:
-        if ((s->prefix & PREFIX_VEX) && s->vex_l && !has_cpuid_feature(s, X86_FEAT_AVX2)) {
+        if ((s->prefix & PREFIX_VEX) && s->vex_l && !(s->tcg_cpuid_features & (1ULL << X86_FEAT_AVX2))) {
             goto illegal;
         }
     }
-- 
2.56.0


