Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4DCE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxA-00031Q-6U; Sat, 27 Dec 2025 04:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx8-0002l3-BL
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQx6-0007Sb-HT
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Pdru0MfLIqHbpQU13WkMnFJzrHGBb8pb6UyfGGGtrg=;
 b=HY57LwHjAifNcKD4Ttj5n/Yo6466Lq8tAb2nmdts0FsSAX/WQTG5jQLUAtJvjeC6wz9Tqq
 QH2QKGP3xh3zbvmJt7PmFpUSeSWewd0iRhQgsPscm/Y+zQjZd9lNDwVzsQ6gwliX84naDT
 V4wDDdUtQgCio2Ticccda48Rnb2QaoI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-p1M8PQHSPpqmZHKTB_gOrQ-1; Sat, 27 Dec 2025 04:51:10 -0500
X-MC-Unique: p1M8PQHSPpqmZHKTB_gOrQ-1
X-Mimecast-MFC-AGG-ID: p1M8PQHSPpqmZHKTB_gOrQ_1766829070
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-431054c09e3so4775880f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829069; x=1767433869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Pdru0MfLIqHbpQU13WkMnFJzrHGBb8pb6UyfGGGtrg=;
 b=f57WaOQSm1650RsHEbbrJlkc7Hn6JfR9ixlB5lgPcGHwOVWzN9DqzAIp6xVhcAeHdQ
 x08Kv3cGvvf2xKh0z4n8EcQR4X4eW4UjCrIzEUjk/MjsaE5VreeWNhjU2BrheZm5LR3u
 hpUiwKas4KSM2Pu5xP7aahU/45yTQ4Yq7ZvDa3GW/HXBu58YY+YV+syeT9wk0xTLrl7g
 kPSFnJzzU0WO3ONC+dkNDmFJI8e7vacg6Bnh/KDBqH4N2dZLJP90OF3Jn4KOan9J+Okh
 tyT7jPx4iL2ds9lZdGRdjluDOwU00w/kR3RBO0E0rHYcrRwrE07RCOmG8PkZCWpKDewF
 XxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829069; x=1767433869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Pdru0MfLIqHbpQU13WkMnFJzrHGBb8pb6UyfGGGtrg=;
 b=Ml8CM0fWS9Ln4J1Bwc6RIJau8K3E73KwhuFx1K57oaisejhSzSZ2CtvcgOUHCQKQOK
 7c+l46Ltdg9iqBGVESnrj3L2xVEz3BlXwcOrWPAubr+u7uwVYRZqZ3w7MFyxn+OGRLNC
 Z7P+HLB1uWcx4MOGLz+te69vIlwxsMh2r6ky8de42HTFuiHtZ8uF4iTt2N8g64Xkqxbh
 x+j4mrpm+XMEeELRinvQDgGAqa+MoDyqVTB1A5Nu0GE/gUF1DvGVWK1KsoxCHpE1lUh+
 eqTMFyMpFnn4JFsFIVcyW3SppNCNYgYUlmlwJyBHxoqQBMstTWz72KacqD7qw3fxwdZ3
 J+dA==
X-Gm-Message-State: AOJu0YxuCMLH7HogM5Gf+MMdO3R75uwQ4tJ9fD20Ob1dO9Ti+VXx3Sg5
 z0gBjqokTnRQPhgKw9KaMMKI+vWNsvxo5eB6LzBYi0chGcRvHuDjkKEYcIcSY2fyuqZh3BrtOzf
 rq4RJ9XrdFajEAIAwSy51ZtNEXVpnTh9Q827kpT83ksGADIh3Eeyx5/NtFGcEavKrKLckOT7VzL
 m4O90QIIgRYOIOgFHij6WyS39iRt67z41+3Dfk7Nmb
X-Gm-Gg: AY/fxX5rgTZ4nhJhBFsGHrmKfWUeOgoegc9RkfYrS+IqSvcKSRSHuzxTZXTK0BIHP4Q
 cRsLMf8rGJoa8KIOMD/kMQzar0jskqtPmW29mzg/nY4jP/i6pOy2qiuSU4EU0hrRsh53VbM5OMV
 3MmX7hZh8Ky0JO6C+rRuEreGN5B0zm4VcTwo6mKXs5woV05jq+LG+w58Ig05vA6MVkFdowvt/i8
 5Hgb89n6tUcCRF2DLtQUBWw8nqVpAOT1BcytQOdi/ZGwPaxVje5IAO4RvSxi6AfPOrMu7Xen7N9
 2oGMjnL7zc0trnV8doVqIJCvOzrmEBvfGoXMbU1sQSeTaxVmaQq8/wl0kXtkVLt+S9ve+LbGZSI
 tZm5YBR9SSZJPqvRm3TnKGdVQV1usMsIDOcSjG4E9med7198tVJgTQOCZ1rLGZtnwTvHWuSRZqz
 lSlV4TDlXGNaWXilw=
X-Received: by 2002:a05:6000:2089:b0:430:f449:5f0e with SMTP id
 ffacd0b85a97d-4324e4c8efemr25992726f8f.16.1766829069119; 
 Sat, 27 Dec 2025 01:51:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsS34CJGdZ+xIjgOLEqv9y/QKxx4mI7B05z77snjRxnf/yJJtO40BY2BBNaR29tyc9euOCqQ==
X-Received: by 2002:a05:6000:2089:b0:430:f449:5f0e with SMTP id
 ffacd0b85a97d-4324e4c8efemr25992701f8f.16.1766829068681; 
 Sat, 27 Dec 2025 01:51:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm50243853f8f.24.2025.12.27.01.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 137/153] i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX
 instructions
Date: Sat, 27 Dec 2025 10:47:42 +0100
Message-ID: <20251227094759.35658-63-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Intel Diamond Rapids adds new AMX instructions to support new formats
and memory operations [*]. And it introduces the CPUID subleaf 0x1E.0x1
to centralize the discrete AMX feature bits within EAX.

For new feature bits (CPUID 0x1E.0x1.EAX[bits 4,6-8]), it's
straightforward to add their enurmeration support.

In addition to the new features, CPUID 0x1E.0x1.EAX[bits 0-3] are
mirrored positions of existing AMX feature bits distributing across
the 0x7 leaves. It's not flexible to make these mirror bits have the
same names as existing ones, because QEMU would try to set both original
bit and mirror bit which would cause warning if host doesn't support
0x1E.0x1 subleaf. Thus, name these mirror bits with "*-mirror" suffix.

[*]: Intel Architecture Instruction Set Extensions and Future Features
     (rev.059).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 18 ++++++++++++++++++
 target/i386/cpu.c | 25 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index be430a73bdd..7b002962e23 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -711,6 +711,7 @@ typedef enum FeatureWord {
     FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEAT_24_0_EBX,      /* CPUID[EAX=0x24,ECX=0].EBX */
     FEAT_29_0_EBX,      /* CPUID[EAX=0x29,ECX=0].EBX */
+    FEAT_1E_1_EAX,      /* CPUID[EAX=0x1E,ECX=1].EAX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -1084,6 +1085,23 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP              (1U << 31)
 
+/* AMX_INT8 instruction (mirror of CPUID_7_0_EDX_AMX_INT8) */
+#define CPUID_1E_1_EAX_AMX_INT8_MIRROR      (1U << 0)
+/* AMX_BF16 instruction (mirror of CPUID_7_0_EDX_AMX_BF16) */
+#define CPUID_1E_1_EAX_AMX_BF16_MIRROR      (1U << 1)
+/* AMX_COMPLEX instruction (mirror of CPUID_7_1_EDX_AMX_COMPLEX) */
+#define CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR   (1U << 2)
+/* AMX_FP16 instruction (mirror of CPUID_7_1_EAX_AMX_FP16) */
+#define CPUID_1E_1_EAX_AMX_FP16_MIRROR      (1U << 3)
+/* AMX_FP8 instruction */
+#define CPUID_1E_1_EAX_AMX_FP8              (1U << 4)
+/* AMX_TF32 instruction */
+#define CPUID_1E_1_EAX_AMX_TF32             (1U << 6)
+/* AMX_AVX512 instruction */
+#define CPUID_1E_1_EAX_AMX_AVX512           (1U << 7)
+/* AMX_MOVRS instruction */
+#define CPUID_1E_1_EAX_AMX_MOVRS            (1U << 8)
+
 /* AVX10 128-bit vector support is present */
 #define CPUID_24_0_EBX_AVX10_128        (1U << 16)
 /* AVX10 256-bit vector support is present */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 817f78a0c20..1246a9af4a3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1037,6 +1037,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_1_EAX_FEATURES 0
 #define TCG_24_0_EBX_FEATURES 0
 #define TCG_29_0_EBX_FEATURES 0
+#define TCG_1E_1_EAX_FEATURES 0
 
 #if defined CONFIG_USER_ONLY
 #define CPUID_8000_0008_EBX_KERNEL_FEATURES (CPUID_8000_0008_EBX_IBPB | \
@@ -1332,6 +1333,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
     },
+    [FEAT_1E_1_EAX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "amx-int8-mirror", "amx-bf16-mirror", "amx-complex-mirror", "amx-fp16-mirror",
+            "amx-fp8", NULL, "amx-tf32", "amx-avx512",
+            "amx-movrs", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 0x1e,
+            .needs_ecx = true, .ecx = 1,
+            .reg = R_EAX,
+        },
+        .tcg_features = TCG_1E_1_EAX_FEATURES,
+    },
     [FEAT_24_0_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -8413,8 +8433,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
 
         if (count == 0) {
+            uint32_t unused;
+            x86_cpu_get_supported_cpuid(0x1E, 0, eax, &unused,
+                                        &unused, &unused);
             /* Highest numbered palette subleaf */
             *ebx = INTEL_AMX_TMUL_MAX_K | (INTEL_AMX_TMUL_MAX_N << 8);
+        } else if (count == 1) {
+            *eax = env->features[FEAT_1E_1_EAX];
         }
         break;
     }
-- 
2.52.0


