Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE66E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvE-0004eK-QA; Sat, 27 Dec 2025 04:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvD-0004bh-Fq
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvB-0006zf-Dw
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCo0WW35FwlSIdHbwn+36kcSmEpNticlzRreJHisgYM=;
 b=Sm1uaBYSa2zDgDDnwDRNaVFZ0yz1xww2dzX+eR0g02gwJJ7bxS2lqYZ/L6TFynbdXcNYBI
 J95mLnzo79/vWwfFXw8RfRZ1niuMuqkU8UBwzlRg3DEG7+qVm1E+t7G8yN0TzW/l0raoyX
 2a5GI6oe26LI4oH6jwQx5Ea/m/MhAKg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-VkSZEnxoNFWzTUGzrp_FEw-1; Sat, 27 Dec 2025 04:49:11 -0500
X-MC-Unique: VkSZEnxoNFWzTUGzrp_FEw-1
X-Mimecast-MFC-AGG-ID: VkSZEnxoNFWzTUGzrp_FEw_1766828950
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43407965e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828949; x=1767433749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCo0WW35FwlSIdHbwn+36kcSmEpNticlzRreJHisgYM=;
 b=Jy8+Dl1maT6GrD6rHxv3J2oVJmSVwXasJj++udYhwGwQBlyPMGv46cnjTssOp2ACYA
 RuFQBCYpsVSlDvD5ejJlB34BaK+sXZB6RVjYzdUBT5FCrjSHG/CoNwLACCDI8Y344ys4
 5S38KtFi/iuuLngRVV3Beoy+Dg87EP5ENDjD3krtGjN6iSpZ1jWgY1isKuKuO0+45qRT
 KHbR1kd+knB8hYsMt6npvrnM3sdxCryZXloweGI06Zphsx+ef8DKtlIYKJxrqGc4x/Rq
 bZ/6c1nY8BOkKHU4vHH4wIzE1Sr/EHAQ1TvC8vmDjOX061zqyH7DZh2A9gYFgpXXsS+k
 EuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828949; x=1767433749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DCo0WW35FwlSIdHbwn+36kcSmEpNticlzRreJHisgYM=;
 b=ZMo1POsB3FjeEGhb6EAVgGbg4QIBP5cghcq86WXiittwFKx1XtHtv40Orh+G7Yy5q9
 cN2zHIHfRSO6TgPKsPxHOwHJONoRhO6ZI6Ohrp3ptWXm/SkYxkVRf3LRoUxqKds+hIXY
 8LHoqCsVXeGTVlkb+PJBHCyG+9MuwjX9iCLISLIL10sKj2LRqcBkpmwXE07cxba1X5Dp
 /CrdubQ8sLu+T5ch144hWo41MLfDqLaCK8zCoGs4VKBiJevHa9SNhexBTEEwzuJY3RBe
 cs3i/p9sK7Vud3arUS1RDo+ttyrLRQmtCxFpUDOEKob0qnBPcAfQfaQgrfEYpx3UFFv8
 N2Vg==
X-Gm-Message-State: AOJu0YyVR3/VgmuUdELHiyDCReWvrXuggNPgopWilCTGrGkm0O7A9sje
 Lky3NCKnaxaANqI2YW24maVRA8v0NgH2NmzCsVnaDNoTg8SmfgWiofIGPa4DqXMkY5X5UWBQFcr
 iItD/sfNW0mD4QVoZAaRr8yh9H+J5A6JVXbzeNqtipR29+dLJld4DMx162+u7ClNXLH1WC32bd4
 33J+3K1u42XRmVZCmIm0jgVQLLP4L/fbJsTVf1otPx
X-Gm-Gg: AY/fxX5YL7HW7EQOmZv0ZZoUF2DwYP3o+LQCCGDSaVJmOsyu81CxzCV1rVt3ixDDK8K
 imcxdIdRuY9+I9nK8vWNlT27P7FwC8xOHyWo3JbDXshBlbiPpQksJ1aFgn9YYEYvslfMgy3+sWt
 O3VqPLSZscmleXlKl5GWDu545y3BRnVzZr4drzJfV3/9uAGmmD8C22qhDwaubNliysv6Uk22CFk
 FFy+7PfVOjnq+BAixbSRKw1coCiRY1Q7JetlCEDAV0WmZ1gEoMmApP2yH/oHDuxRg8pLpyHuIm+
 Iivs2Izin6THNP0cxWomV0PcJQJei5JW4BFvKxPNodpsr80AHOQ1XDNxo07H4FjxTQFFF3Pnfpf
 rPNa9Up0vbvRgFW71HGbuQ8999K625Ro17PGZ3cCMR5PflSEWfKs6aO9Hhd6WEZ4k4R2YPLALyF
 VCbt8NUC8IBnMrhpY=
X-Received: by 2002:a05:600c:8b82:b0:47b:deb9:163d with SMTP id
 5b1f17b1804b1-47d18b99b99mr262142495e9.7.1766828948834; 
 Sat, 27 Dec 2025 01:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErKeyc4GIUQr2bEY7GdiO3LuoT+sQ2Qbc9eFpOCuNjKYa2268P8sjkr1sSqmHIwKDMMgweVA==
X-Received: by 2002:a05:600c:8b82:b0:47b:deb9:163d with SMTP id
 5b1f17b1804b1-47d18b99b99mr262142305e9.7.1766828948414; 
 Sat, 27 Dec 2025 01:49:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm499566245e9.0.2025.12.27.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Peter Fang <peter.fang@intel.com>
Subject: [PULL 102/153] i386/cpu: Support APX CPUIDs
Date: Sat, 27 Dec 2025 10:47:07 +0100
Message-ID: <20251227094759.35658-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

APX is enumerated by CPUID.(EAX=0x7, ECX=1).EDX[21]. And this feature
bit also indicates the existence of dedicated CPUID leaf 0x29, called
the Intel APX Advanced Performance Extensions Leaf.

This new CPUID leaf now is populated with enumerations for a select
set of Intel APX sub-features.

CPUID.(EAX=0x29, ECX=0)
 - EAX
   * Maximum Subleaf CPUID.(EAX=0x29, ECX=0).EAX[31:0] = 0
 - EBX
   * Reserved CPUID.(EAX=0x29, ECX=0).EBX[31:1] = 0
   * APX_NCI_NDD_NF CPUID.(EAX=0x29, ECX=0).EBX[0:0] = 1, which
     enumerates the presence of New Conditional Instructions (NCIs),
     explicit New Data Destination (NDD) controls, and explicit Flags
     Suppression (NF) controls for select sets of EVEX-encoded Intel
     APX instructions (present in EVEX map=4, and EVEX map=2 0x0F38).
 - ECX
   * Reserved CPUID.(EAX=0x29, ECX=0).ECX[31:0] = 0
 - EDX
   * Reserved CPUID.(EAX=0x29, ECX=0).EDX[31:0] = 0

Note, APX_NCI_NDD_NF is documented as always enabled for Intel
processors since APX spec (revision v7.0). Now any Intel processor
that enumerates support for APX_F (CPUID.(EAX=0x7, ECX=1).EDX[21])
will also enumerate support for APX_NCI_NDD_NF.

Tested-by: Xudong Hao <xudong.hao@intel.com>
Co-developed-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Co-developed-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251211070942.3612547-9-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h |  8 ++++++++
 target/i386/cpu.c | 40 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 691ed974684..fc634883649 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -710,6 +710,7 @@ typedef enum FeatureWord {
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
+    FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1092,6 +1093,13 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
                                          CPUID_24_0_EBX_AVX10_256 | \
                                          CPUID_24_0_EBX_AVX10_512)
 
+/*
+ * New Conditional Instructions (NCIs), explicit New Data Destination (NDD)
+ * controls, and explicit Flags Suppression (NF) controls for select sets of
+ * EVEX-encoded Intel APX instructions
+ */
+#define CPUID_29_0_EBX_APX_NCI_NDD_NF         (1U << 0)
+
 /* RAS Features */
 #define CPUID_8000_0007_EBX_OVERFLOW_RECOV    (1U << 0)
 #define CPUID_8000_0007_EBX_SUCCOR      (1U << 1)
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3c9ed7cd5f7..c9efd3a9d46 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1036,6 +1036,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
+#define TCG_29_0_EBX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1301,7 +1302,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amx-complex", NULL, "avx-vnni-int16", NULL,
             NULL, NULL, "prefetchiti", NULL,
             NULL, NULL, NULL, "avx10",
-            NULL, NULL, NULL, NULL,
+            NULL, "apxf", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
@@ -1345,6 +1346,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_24_0_EBX_FEATURES,
     },
+    [FEAT_29_0_EBX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "apx-nci-ndd-nf", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x29,
+            .needs_ecx = true, .ecx = 0,
+            .reg = R_EBX,
+        },
+        .tcg_features = TCG_29_0_EBX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1996,6 +2016,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_AVX10 },
         .to = { FEAT_24_0_EBX,              ~0ull },
     },
+    {
+        .from = { FEAT_7_1_EDX,             CPUID_7_1_EDX_APXF },
+        .to = { FEAT_29_0_EBX,              ~0ull },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
@@ -8411,6 +8435,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         break;
     }
+    case 0x29:
+        *eax = 0;
+        *ebx = 0;
+        *ecx = 0;
+        *edx = 0;
+        if ((env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) && count == 0) {
+            *ebx = env->features[FEAT_29_0_EBX];
+        }
+        break;
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
@@ -9190,6 +9223,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
             x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x24);
         }
 
+        /* Advanced Performance Extensions (APX) requires CPUID[0x29] */
+        if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF) {
+            x86_cpu_adjust_level(cpu, &env->cpuid_min_level, 0x29);
+        }
+
         /* SVM requires CPUID[0x8000000A] */
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             x86_cpu_adjust_level(cpu, &env->cpuid_min_xlevel, 0x8000000A);
-- 
2.52.0


