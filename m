Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A846610F284C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69gD-0007UJ-A1; Fri, 27 Mar 2026 12:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69g9-0007U1-Fr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w69g6-0006sm-OP
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774627493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZeIRO4BaFMz6G9xnsw/6nCZo/XaL0YyNYHk0Nv93uOg=;
 b=MJJkMffcZUISpwp3NnTMoi+ipehiNTxcea/M4kxaCOBTwlNtQ3HbDPJvXCwf3HJtj+jCsj
 +RYWge02KaMnWhNMp/6w43B/g24pDQ/vr4uqdzP3AWtPvLSueU0UmmqABMrsJk841hdaY+
 m7m+KW8LGvHv74Pg9j0OakFdzKVWe4Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-dQJObZ6sOCa76F-SFj9Z1w-1; Fri, 27 Mar 2026 12:04:51 -0400
X-MC-Unique: dQJObZ6sOCa76F-SFj9Z1w-1
X-Mimecast-MFC-AGG-ID: dQJObZ6sOCa76F-SFj9Z1w_1774627490
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso25123575e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774627490; x=1775232290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZeIRO4BaFMz6G9xnsw/6nCZo/XaL0YyNYHk0Nv93uOg=;
 b=i4mQ7EvfHXf53UHlD3voGNVgkhBBq2R6uOztet8liIVnX6OCpw/ejWZB2yZxxf3IUe
 Ldjufpmn8Aw60CahWjwz+sdm/9CelA5WNuDt64PTDtACkowTuOh2hSXB86il9wbGk4Ns
 NuzMSY9eIm+y9HZvJZH+8GlKdkOmH3huRAymnRB4IyamGxqiHvzCu/wvgbWvx79j7Os7
 Y9yMZ1jmjoNQJt9nKQyLmT+1Ztb3oSU+aEiZWcUVJbF8bRbsUGg4LKFYNVwt5AAvmghA
 TUidvLp6/SeGVO8+Sx/jdoEwnzzStdVgl6l0Xn6sIz7lTckXqRy/BrKlAmaUfAeifYVO
 ei2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627490; x=1775232290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeIRO4BaFMz6G9xnsw/6nCZo/XaL0YyNYHk0Nv93uOg=;
 b=KAchH9aK3EMp+UTkjlDZGsMNwSJn75kDWptKO8uFNihAB7xjsemyj9Y/F3ocjaJg9k
 ynJBf7VUgTmJpQOV+QWxofZYMvg/9a2Pd5kzR/nSOXBwhqZMn+/NH1MpH0RZeeF+blY9
 yhWehEg8NFjdaAUOr9Hxa1PJnTDBXN1+W4dFiyc5aGPlELPiI6M+XrrPaqs1xWOYzpgV
 ZmBW+RUhoTAYo32zs0TXxJfcTwS504W+fLr76xV5nyP6A0LhWhgkGcMbQ7qWEmN2UNqL
 1f4zn3HdEcENWvKvsTv38JZHr1/+Ymp0lm4hSfqZPcgOiOTbuo3y80R5nenic51Nb3+r
 /CLA==
X-Gm-Message-State: AOJu0YzhaJvN9bCcmwG1uNxOyqXTgaFdyT4L29ljWo7tz4rWY+hmh+e3
 r3tCtQG9b8NQbngYsM3r5HDsvv3HRJtvCgGnd5SW5fAMi665DReyfMxN4NUQGz86pdvYnZqpRAH
 5TteuHgt430xXMJX7ugpISNpOG9In4KremndaDfY5W4pow8MJFqHFigHkIpFebKU5DtmEKIVXTu
 oxxbDIdP+TvfU0ntGH0Uj2yEz1ke1ncslbEwERKGo1
X-Gm-Gg: ATEYQzyyQB4k8krpQSTmMvqYLcPhCXmZQpkFp1w5oj9i7mVDtx12biQF5ilmWGmnDnd
 UJguJxV2YnSOIFg2wT/xInVSDgtEuixklak/EWhPyvgiG2aQJdbgeuVTpzetKTiZdupwqUPiFT0
 t4Chlod38qbarVnKfSuhW+I83EwfPdrs10Mi3K2MdnHZLXYyB+lGd5NHJ647sT4no1ah4Ra+6mO
 bQIqeLQRsgkHvb8vSabyOEJaH+S3gvvHDh62k3EM0z+0El7GeeItiWYJAB/phCWH+ta0dVqoIcH
 iIsG0LOKBn3cXE6LAy1DCo8vqXCxMeE2wR11VpFYSshasptFIlpUMUk8q2S7HfLE/U7Gsgk+l+D
 A3YjE+i0H1Nit6D4ioDPjtMeroC0QsuEnAMd3AQCLXtg9/LRpd/1Mg9DY7gc8vjRDGGiK9boJDq
 Eey7P0K7na2C3UBdFBhrAtiA7i
X-Received: by 2002:a05:600c:1d15:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-48727ee9a7amr51822995e9.16.1774627489678; 
 Fri, 27 Mar 2026 09:04:49 -0700 (PDT)
X-Received: by 2002:a05:600c:1d15:b0:47e:e48b:506d with SMTP id
 5b1f17b1804b1-48727ee9a7amr51821785e9.16.1774627488920; 
 Fri, 27 Mar 2026 09:04:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d4d884sm137166465e9.15.2026.03.27.09.04.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:04:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386/tcg: svm: implement GMET
Date: Fri, 27 Mar 2026 17:04:46 +0100
Message-ID: <20260327160446.330583-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

GMET (Guest Mode Execution Trap) has two effects: it disables
the U bit check when the guest is in user mode, and enables
the SMEP check when the guest is in kernel mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                    |  2 ++
 target/i386/svm.h                    |  1 +
 target/i386/cpu.c                    |  2 +-
 target/i386/tcg/system/excp_helper.c | 20 ++++++++++++++++----
 target/i386/tcg/system/svm_helper.c  |  4 ++++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c40..82b7d1a52e4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -354,6 +354,7 @@ typedef enum X86Seg {
 #define PG_MODE_NXE      (1 << 2)
 #define PG_MODE_PSE      (1 << 3)
 #define PG_MODE_LA57     (1 << 4)
+#define PG_MODE_SVM_GMET (1 << 5)
 #define PG_MODE_SVM_MASK MAKE_64BIT_MASK(0, 15)
 
 /* Bits of CR4 that do not affect the NPT page format.  */
@@ -879,6 +880,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_SVM_AVIC            (1U << 13)
 #define CPUID_SVM_V_VMSAVE_VMLOAD (1U << 15)
 #define CPUID_SVM_VGIF            (1U << 16)
+#define CPUID_SVM_GMET            (1U << 17)
 #define CPUID_SVM_VNMI            (1U << 25)
 #define CPUID_SVM_SVME_ADDR_CHK   (1U << 28)
 
diff --git a/target/i386/svm.h b/target/i386/svm.h
index 1bd78447306..e05a66ecc43 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -140,6 +140,7 @@
 #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
 
 #define SVM_NPT_ENABLED     (1 << 0)
+#define SVM_GMET_ENABLED    (1 << 3)
 
 #define SVM_NPTEXIT_GPA     (1ULL << 32)
 #define SVM_NPTEXIT_GPT     (1ULL << 33)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d02f6f0653e..ec80649658c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -960,7 +960,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #else
 #define CPUID_SVM_KERNEL_FEATURES 0
 #endif
-#define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | \
+#define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | CPUID_SVM_GMET | \
           CPUID_SVM_SVME_ADDR_CHK | CPUID_SVM_KERNEL_FEATURES)
 
 #define TCG_KVM_FEATURES 0
diff --git a/target/i386/tcg/system/excp_helper.c b/target/i386/tcg/system/excp_helper.c
index d7ea77c8558..bd99e8416f5 100644
--- a/target/i386/tcg/system/excp_helper.c
+++ b/target/i386/tcg/system/excp_helper.c
@@ -371,7 +371,9 @@ do_check_protect_pse36:
     ptep ^= PG_NX_MASK;
 
     /* can the page can be put in the TLB?  prot will tell us */
-    if (is_user && !(ptep & PG_USER_MASK)) {
+
+    /* GMET disables checks to the U bit other than the SMEP check below.  */
+    if (is_user && !(ptep & PG_USER_MASK) && !(pg_mode & PG_MODE_SVM_GMET)) {
         goto do_fault_protect;
     }
 
@@ -384,7 +386,7 @@ do_check_protect_pse36:
     }
     if (!(ptep & PG_NX_MASK) &&
         (is_user ||
-         !((pg_mode & PG_MODE_SMEP) && (ptep & PG_USER_MASK)))) {
+         !((pg_mode & (PG_MODE_SMEP | PG_MODE_SVM_GMET)) && (ptep & PG_USER_MASK)))) {
         prot |= PAGE_EXEC;
     }
 
@@ -543,6 +545,17 @@ static G_NORETURN void raise_stage2(CPUX86State *env, TranslateFault *err,
     cpu_vmexit(env, SVM_EXIT_NPF, exit_info_1, retaddr);
 }
 
+static int cpu_mmu_index_svm(CPUX86State *env)
+{
+    unsigned pl = env->hflags & HF_CPL_MASK;
+    int mmu_index_32 = (env->nested_pg_mode & PG_MODE_LMA) ? 0 : 1;
+    int mmu_index_base =
+        pl < 3 && (env->nested_pg_mode & PG_MODE_SVM_GMET)
+        ? MMU_KNOSMAP64_IDX : MMU_USER64_IDX;
+
+    return mmu_index_base + mmu_index_32;
+}
+
 static bool get_physical_address(CPUX86State *env, vaddr addr,
                                  MMUAccessType access_type, int mmu_idx,
                                  TranslateResult *out, TranslateFault *err,
@@ -562,8 +575,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         if (likely(use_stage2)) {
             in.cr3 = env->nested_cr3;
             in.pg_mode = env->nested_pg_mode;
-            in.mmu_idx =
-                env->nested_pg_mode & PG_MODE_LMA ? MMU_USER64_IDX : MMU_USER32_IDX;
+            in.mmu_idx = cpu_mmu_index_svm(env);
             in.ptw_idx = MMU_PHYS_IDX;
 
             if (!mmu_translate(env, &in, out, err, ra)) {
diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/system/svm_helper.c
index d5ffabc2f4d..14e46f00bb6 100644
--- a/target/i386/tcg/system/svm_helper.c
+++ b/target/i386/tcg/system/svm_helper.c
@@ -296,6 +296,10 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
         env->hflags2 |= HF2_NPT_MASK;
 
         env->nested_pg_mode = get_pg_mode(env) & PG_MODE_SVM_MASK;
+        if ((nested_ctl & SVM_GMET_ENABLED) &&
+            (env->features[FEAT_SVM] & CPUID_SVM_GMET)) {
+            env->nested_pg_mode |= PG_MODE_SVM_GMET;
+        }
 
         tlb_flush_by_mmuidx(cs, 1 << MMU_NESTED_IDX);
     }
-- 
2.53.0


