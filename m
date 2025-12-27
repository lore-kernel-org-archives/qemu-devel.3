Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62A7E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQxe-0005lP-E7; Sat, 27 Dec 2025 04:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxc-0005Wy-EO
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQxa-0007Vu-8X
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMcTna4Pd4l5Ct+ykWJLm//LQtzcLJUerHKSxe/7YXA=;
 b=gnCOmy8oUYAi+bDglxpGv/YyO0Nq0FJwsF/KkZM+uVv93vWnn1bEaRLfjcknh5JgEKTmFB
 r/UGMotBVm3jslCCEeD5prZULHpW59v7NkCggZoiNvS0aQhO/7MEafrOFp3aX7h9PkGm32
 3RTCd4HwjHa/LIEJIUc+gcjB9Vyqvfg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-V5F5sPHYOY2yyltICxXnwA-1; Sat, 27 Dec 2025 04:51:40 -0500
X-MC-Unique: V5F5sPHYOY2yyltICxXnwA-1
X-Mimecast-MFC-AGG-ID: V5F5sPHYOY2yyltICxXnwA_1766829099
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso19460375e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829098; x=1767433898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMcTna4Pd4l5Ct+ykWJLm//LQtzcLJUerHKSxe/7YXA=;
 b=bjf1WGRUUfXyJ8niGN043/S+zvDA14wuI6jLKk0r5md9HbSX8s8aHX/2XNgZDD7SzV
 jbiDQNut9c1146KNPU3Fv7VUCfxm6CHUGaVKcEY19mUR8cTgJZeea0+H6OSl66gSmFam
 /lPhOKzCf9rbQS4ozchPLoMNjq6UG/MuUV5P041Hn+pdDirEaN2rFWxxTGHCjgX6yOae
 jgIe2Z9vPnKfgFYMrPjIPX6n7BCJ2vjuC+UJWja011qJEo84pNlx1w9Hkp5BiR7Rc5/i
 LUFohZ/A2e1GkBfJewGd+IJBcHzvf7Hx+abMyVpC+l3Lq42mHd7+xiA0W8gYltkSQ/G1
 vUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829098; x=1767433898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JMcTna4Pd4l5Ct+ykWJLm//LQtzcLJUerHKSxe/7YXA=;
 b=RTWYmfjO7+1WjWa2uFsU/HMXj4dQc0Xsj70KKEgtvlKhqelSrmjS3LCWvHzYATRRFs
 dDJczKADgGNjaVbUbOpNeVmsHmlg7NCQLfPrUY5L0Yrt147uiOH4xONJ3uJIUOdrFimF
 BXKOGJlljiT+Zee+U/2oKF9Cj3lJWIy7bj3HXbFmop5amJdXPqTYU815ns1F08i1Sygh
 UjXE9t2S33JZMFdpzHqqFxW9KENNVIVU8FH6NWUxjiJWbaJjv6a6swb+sL3bjvRZjH+0
 tQILv4ii6s58FRKmtRAijJ60W/UC+55hfc9TdsU9bz1R+49xjQEjjCv6cCGHAaHyTOzT
 Zjtw==
X-Gm-Message-State: AOJu0YynDgDpeL07tG/sOeTi7vZzRL2cA6lUVXkQQZELbdbEjBNxklzF
 PkEZ0C8Xs/AbaC3qFXsZ4FM1LrBKG7HWSTP6rb7t1pvCryD17PO6dxbyz45pecelO2dcY4j1bIw
 Pu0M61YkL0hwPudY7Xp1iyTM9Y8tDC+l/VOL4yhU0IfMOiKsie/lPjUjtSj/FTyXAtrWw/xM9mZ
 L0fGvXQx40gHZ/FDxHwCNgmcTysGOCCdoGJswi/A5k
X-Gm-Gg: AY/fxX4L2EROZBtPywedBpo1GCS6PnHVqhJvVvhRKq5oCycPg+YIQUBpwrA3dlGs2nC
 nz/Pls/cbuEWX1i/DaV11k8G4bioBTSOWKRYLZia3M8UorYeFHfmAprAXnS79sIQJvsdPqA27dw
 K6tMoMCRb38OH1yVw4yTCNgEovx1IqW1rqY0P2ZJBs3Cb6ebr6F5ocANc2NAv/zqBClvrWu8WRf
 qRxkuOVg5oG9nYcG3Ibs9OVFPHGQmUyd/zUMs3PPEwNenfBi0TJ5yIHgjr3988irZ0p0Vofkw+l
 6lTIxF/4JAPWQyCxzHkOOnPXWa6iBTXADUyBsfUwTZzXMAMVIC0rKpRf9xp/bE8sC3ohqH3INjb
 25emgjN9ozS+G0QoOWcOl/ZSoirwpgKbE4tSEHT7yeipi8qVM9SxltddjT1icuvGKmwgYD37beR
 5lc6/bZ+oz0p0Leo4=
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr284074375e9.9.1766829097936; 
 Sat, 27 Dec 2025 01:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7wjzsEhSIGQLSNW6I+u469gOU38imzhpZCZV66zljLHR5KMwyyYupzchhBc77xoro4ccAoQ==
X-Received: by 2002:a05:600c:828d:b0:477:73cc:82c2 with SMTP id
 5b1f17b1804b1-47d1954a14dmr284074115e9.9.1766829097444; 
 Sat, 27 Dec 2025 01:51:37 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2253csm50813815f8f.14.2025.12.27.01.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:51:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
Subject: [PULL 145/153] i386/cpu: Add CPU model for Diamond Rapids
Date: Sat, 27 Dec 2025 10:47:50 +0100
Message-ID: <20251227094759.35658-71-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

According to table 1-2 in Intel Architecture Instruction Set Extensions
and Future Features (rev 059), Diamond Rapids has the following new
features which have already been supported for guest:
 * SM4 (EVEX)
 * Intel Advanced Vector Extensions 10 Version 2 (Intel AVX10.2)
 * MOVRS and the PREFETCHRST2 instruction
 * AMX-MOVRS, AMX-AVX512, AMX-FP8, AMX-TF32
 * Intel Advanced Performance Extensions

And FRED - Flexible Return and Event Delivery (FRED) and the LKGS
instruction (introduced since Clearwater Forest & Diamond Rapids) - is
included in Diamond Rapids CPU model.

In addition, the following features are added into Diamond Rapids CPU
model:
 * CET: Control-flow Enforcement Technology (introduced since Sapphire
   Rapids & Sierra Forest).

Tested-by: Xudong Hao <xudong.hao@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251215073743.4055227-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3440a70852d..37803cd7249 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5443,6 +5443,198 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ },
         },
     },
+    {
+        .name = "DiamondRapids",
+        .level = 0x29,
+        .vendor = CPUID_VENDOR_INTEL,
+        .family = 0x13, /* family: 0xf, extended famil: 0x4 */
+        .model = 0x1, /* model: 0x1, extended model: 0x0 */
+        .stepping = 0,
+        .avx10_version = 2, /* avx10.2 */
+        .cpuid_0x1f = true,
+        /*
+         * Please keep the ascending order so that we can have a clear view of
+         * bit position of each feature.
+         *
+         * Missing: CPUID_EXT_DTES64, CPUID_EXT_MONITOR, CPUID_EXT_DSCPL,
+         * CPUID_EXT_VMX, CPUID_EXT_SMX, CPUID_EXT_EST, CPUID_EXT_TM2,
+         * CPUID_EXT_XTPR, CPUID_EXT_PDCM, CPUID_EXT_DCA, CPUID_EXT_OSXSAVE
+         */
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_SSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSSE3 |
+            CPUID_EXT_FMA | CPUID_EXT_CX16 | CPUID_EXT_PCID | CPUID_EXT_SSE41 |
+            CPUID_EXT_SSE42 | CPUID_EXT_X2APIC | CPUID_EXT_MOVBE |
+            CPUID_EXT_POPCNT | CPUID_EXT_TSC_DEADLINE_TIMER | CPUID_EXT_AES |
+            CPUID_EXT_XSAVE | CPUID_EXT_AVX | CPUID_EXT_F16C | CPUID_EXT_RDRAND,
+        /* Missing: CPUID_DTS, CPUID_ACPI, CPUID_HT, CPUID_TM, CPUID_PBE */
+        .features[FEAT_1_EDX] =
+            CPUID_FP87 | CPUID_VME | CPUID_DE | CPUID_PSE | CPUID_TSC |
+            CPUID_MSR | CPUID_PAE | CPUID_MCE | CPUID_CX8 | CPUID_APIC |
+            CPUID_SEP | CPUID_MTRR | CPUID_PGE | CPUID_MCA | CPUID_CMOV |
+            CPUID_PAT | CPUID_PSE36 | CPUID_CLFLUSH | CPUID_MMX | CPUID_FXSR |
+            CPUID_SSE | CPUID_SSE2 | CPUID_SS,
+        .features[FEAT_6_EAX] = CPUID_6_EAX_ARAT,
+        /*
+         * Missing: CPUID_7_0_EBX_SGX, "cqm" Cache QoS Monitoring,
+         * "rdt_a" Resource Director Technology Allocation,
+         * CPUID_7_0_EBX_INTEL_PT,
+         */
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_TSC_ADJUST |
+            CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_HLE | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_FDP_EXCPTN_ONLY | CPUID_7_0_EBX_SMEP |
+            CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_INVPCID |
+            CPUID_7_0_EBX_RTM | CPUID_7_0_EBX_ZERO_FCS_FDS |
+            CPUID_7_0_EBX_AVX512F | CPUID_7_0_EBX_AVX512DQ |
+            CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX | CPUID_7_0_EBX_SMAP |
+            CPUID_7_0_EBX_AVX512IFMA | CPUID_7_0_EBX_CLFLUSHOPT |
+            CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_AVX512CD |
+            CPUID_7_0_EBX_SHA_NI | CPUID_7_0_EBX_AVX512BW |
+            CPUID_7_0_EBX_AVX512VL,
+        /*
+         * Missing: CPUID_7_0_ECX_OSPKE, CPUID_7_0_ECX_WAITPKG, TME, ENQCMD,
+         * CPUID_7_0_ECX_SGX_LC, CPUID_7_0_ECX_PKS
+         */
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP |
+            CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_AVX512_VBMI2 |
+            CPUID_7_0_ECX_CET_SHSTK | CPUID_7_0_ECX_GFNI | CPUID_7_0_ECX_VAES |
+            CPUID_7_0_ECX_VPCLMULQDQ | CPUID_7_0_ECX_AVX512VNNI |
+            CPUID_7_0_ECX_AVX512BITALG | CPUID_7_0_ECX_AVX512_VPOPCNTDQ |
+            CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_RDPID |
+            CPUID_7_0_ECX_BUS_LOCK_DETECT | CPUID_7_0_ECX_CLDEMOTE |
+            CPUID_7_0_ECX_MOVDIRI | CPUID_7_0_ECX_MOVDIR64B,
+        /*
+         * Missing: SGX-KEYS, UINTR, PCONFIG, ARCH LBR,
+         * CPUID_7_0_EDX_CORE_CAPABILITY
+         */
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_MD_CLEAR |
+            CPUID_7_0_EDX_SERIALIZE | CPUID_7_0_EDX_TSX_LDTRK |
+            CPUID_7_0_EDX_CET_IBT | CPUID_7_0_EDX_AMX_BF16 |
+            CPUID_7_0_EDX_AVX512_FP16 | CPUID_7_0_EDX_AMX_TILE |
+            CPUID_7_0_EDX_AMX_INT8 | CPUID_7_0_EDX_SPEC_CTRL |
+            CPUID_7_0_EDX_STIBP | CPUID_7_0_EDX_FLUSH_L1D |
+            CPUID_7_0_EDX_ARCH_CAPABILITIES | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
+        /* Missing: CPUID_7_1_EAX_LASS, ArchPerfmonExt (0x23 leaf), MSRLIST */
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16 |
+            CPUID_7_1_EAX_CMPCCXADD | CPUID_7_1_EAX_FZRM |
+            CPUID_7_1_EAX_FSRS | CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_FRED |
+            CPUID_7_1_EAX_LKGS | CPUID_7_1_EAX_WRMSRNS |
+            CPUID_7_1_EAX_AMX_FP16 | CPUID_7_1_EAX_AVX_IFMA |
+            CPUID_7_1_EAX_LAM | CPUID_7_1_EAX_MOVRS,
+        /* Missing: CET_SSS */
+        .features[FEAT_7_1_EDX] =
+            CPUID_7_1_EDX_AVX_VNNI_INT8 | CPUID_7_1_EDX_AVX_NE_CONVERT |
+            CPUID_7_1_EDX_AMX_COMPLEX | CPUID_7_1_EDX_PREFETCHITI |
+            CPUID_7_1_EDX_AVX10 | CPUID_7_1_EDX_APXF,
+        /* Missing: UC-lock disable */
+        .features[FEAT_7_2_EDX] =
+            CPUID_7_2_EDX_PSFD | CPUID_7_2_EDX_IPRED_CTRL |
+            CPUID_7_2_EDX_RRSBA_CTRL | CPUID_7_2_EDX_DDPD_U |
+            CPUID_7_2_EDX_BHI_CTRL | CPUID_7_2_EDX_MCDT_NO,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES | CPUID_D_1_EAX_XFD,
+        .features[FEAT_1E_1_EAX] =
+            CPUID_1E_1_EAX_AMX_INT8_MIRROR | CPUID_1E_1_EAX_AMX_BF16_MIRROR |
+            CPUID_1E_1_EAX_AMX_COMPLEX_MIRROR |
+            CPUID_1E_1_EAX_AMX_FP16_MIRROR | CPUID_1E_1_EAX_AMX_FP8 |
+            CPUID_1E_1_EAX_AMX_TF32 | CPUID_1E_1_EAX_AMX_AVX512 |
+            CPUID_1E_1_EAX_AMX_MOVRS,
+        .features[FEAT_29_0_EBX] = CPUID_29_0_EBX_APX_NCI_NDD_NF,
+        /*
+         * Though this bit will be set by avx_version=2, it's better to
+         * explicitly enumerate this feature here.
+         */
+        .features[FEAT_24_1_ECX] = CPUID_24_1_ECX_AVX10_VNNI_INT,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_LAHF_LM | CPUID_EXT3_ABM | CPUID_EXT3_3DNOWPREFETCH,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_NX | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_RDTSCP | CPUID_EXT2_LM,
+        .features[FEAT_8000_0008_EBX] = CPUID_8000_0008_EBX_WBNOINVD,
+        /*
+         * Missing: ARCH_CAP_RRSBA (KVM bit 19), ARCH_CAP_RFDS_CLEAR (KVM bit
+         * 28), MCU_CONTROL (bit 9), MISC_PACKAGE_CTLS (bit 10),
+         * ENERGY_FILTERING_CTL (bit 11), DOITM (bit 12), MCU_ENUMERATION (bit
+         * 16), RRSBA (bit 19), XAPIC_DISABLE_STATUS (bit 21),
+         * OVERCLOCKING_STATUS (bit 23).
+         */
+        .features[FEAT_ARCH_CAPABILITIES] =
+            MSR_ARCH_CAP_RDCL_NO | MSR_ARCH_CAP_IBRS_ALL |
+            MSR_ARCH_CAP_SKIP_L1DFL_VMENTRY | MSR_ARCH_CAP_MDS_NO |
+            MSR_ARCH_CAP_PSCHANGE_MC_NO | MSR_ARCH_CAP_TAA_NO |
+            MSR_ARCH_CAP_SBDR_SSDP_NO | MSR_ARCH_CAP_FBSDP_NO |
+            MSR_ARCH_CAP_PSDP_NO | MSR_ARCH_CAP_BHI_NO |
+            MSR_ARCH_CAP_PBRSB_NO | MSR_ARCH_CAP_GDS_NO |
+            MSR_ARCH_CAP_RFDS_NO,
+        .features[FEAT_VMX_BASIC] =
+            MSR_VMX_BASIC_INS_OUTS | MSR_VMX_BASIC_TRUE_CTLS |
+            MSR_VMX_BASIC_NESTED_EXCEPTION,
+        .features[FEAT_VMX_ENTRY_CTLS] =
+            VMX_VM_ENTRY_LOAD_DEBUG_CONTROLS | VMX_VM_ENTRY_IA32E_MODE |
+            VMX_VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_ENTRY_LOAD_IA32_PAT | VMX_VM_ENTRY_LOAD_IA32_EFER |
+            VMX_VM_ENTRY_LOAD_CET | VMX_VM_ENTRY_LOAD_IA32_FRED,
+        .features[FEAT_VMX_EPT_VPID_CAPS] =
+            MSR_VMX_EPT_EXECONLY |
+            MSR_VMX_EPT_PAGE_WALK_LENGTH_4 | MSR_VMX_EPT_PAGE_WALK_LENGTH_5 |
+            MSR_VMX_EPT_WB | MSR_VMX_EPT_2MB | MSR_VMX_EPT_1GB |
+            MSR_VMX_EPT_INVEPT | MSR_VMX_EPT_AD_BITS |
+            MSR_VMX_EPT_INVEPT_SINGLE_CONTEXT | MSR_VMX_EPT_INVEPT_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID | MSR_VMX_EPT_INVVPID_SINGLE_ADDR |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT |
+            MSR_VMX_EPT_INVVPID_ALL_CONTEXT |
+            MSR_VMX_EPT_INVVPID_SINGLE_CONTEXT_NOGLOBALS,
+        .features[FEAT_VMX_EXIT_CTLS] =
+            VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE,
+            VMX_VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
+            VMX_VM_EXIT_ACK_INTR_ON_EXIT | VMX_VM_EXIT_SAVE_IA32_PAT |
+            VMX_VM_EXIT_LOAD_IA32_PAT | VMX_VM_EXIT_SAVE_IA32_EFER |
+            VMX_VM_EXIT_LOAD_IA32_EFER | VMX_VM_EXIT_SAVE_VMX_PREEMPTION_TIMER |
+            VMX_VM_EXIT_SAVE_CET | VMX_VM_EXIT_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_MISC] =
+            MSR_VMX_MISC_STORE_LMA | MSR_VMX_MISC_ACTIVITY_HLT |
+            MSR_VMX_MISC_ACTIVITY_SHUTDOWN | MSR_VMX_MISC_ACTIVITY_WAIT_SIPI |
+            MSR_VMX_MISC_VMWRITE_VMEXIT,
+        .features[FEAT_VMX_PINBASED_CTLS] =
+            VMX_PIN_BASED_EXT_INTR_MASK | VMX_PIN_BASED_NMI_EXITING |
+            VMX_PIN_BASED_VIRTUAL_NMIS | VMX_PIN_BASED_VMX_PREEMPTION_TIMER |
+            VMX_PIN_BASED_POSTED_INTR,
+        .features[FEAT_VMX_PROCBASED_CTLS] =
+            VMX_CPU_BASED_VIRTUAL_INTR_PENDING |
+            VMX_CPU_BASED_USE_TSC_OFFSETING | VMX_CPU_BASED_HLT_EXITING |
+            VMX_CPU_BASED_INVLPG_EXITING | VMX_CPU_BASED_MWAIT_EXITING |
+            VMX_CPU_BASED_RDPMC_EXITING | VMX_CPU_BASED_RDTSC_EXITING |
+            VMX_CPU_BASED_CR3_LOAD_EXITING | VMX_CPU_BASED_CR3_STORE_EXITING |
+            VMX_CPU_BASED_CR8_LOAD_EXITING | VMX_CPU_BASED_CR8_STORE_EXITING |
+            VMX_CPU_BASED_TPR_SHADOW | VMX_CPU_BASED_VIRTUAL_NMI_PENDING |
+            VMX_CPU_BASED_MOV_DR_EXITING | VMX_CPU_BASED_UNCOND_IO_EXITING |
+            VMX_CPU_BASED_USE_IO_BITMAPS | VMX_CPU_BASED_MONITOR_TRAP_FLAG |
+            VMX_CPU_BASED_USE_MSR_BITMAPS | VMX_CPU_BASED_MONITOR_EXITING |
+            VMX_CPU_BASED_PAUSE_EXITING |
+            VMX_CPU_BASED_ACTIVATE_SECONDARY_CONTROLS,
+        .features[FEAT_VMX_SECONDARY_CTLS] =
+            VMX_SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES |
+            VMX_SECONDARY_EXEC_ENABLE_EPT | VMX_SECONDARY_EXEC_DESC |
+            VMX_SECONDARY_EXEC_RDTSCP |
+            VMX_SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+            VMX_SECONDARY_EXEC_ENABLE_VPID | VMX_SECONDARY_EXEC_WBINVD_EXITING |
+            VMX_SECONDARY_EXEC_UNRESTRICTED_GUEST |
+            VMX_SECONDARY_EXEC_APIC_REGISTER_VIRT |
+            VMX_SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
+            VMX_SECONDARY_EXEC_RDRAND_EXITING |
+            VMX_SECONDARY_EXEC_ENABLE_INVPCID |
+            VMX_SECONDARY_EXEC_ENABLE_VMFUNC | VMX_SECONDARY_EXEC_SHADOW_VMCS |
+            VMX_SECONDARY_EXEC_RDSEED_EXITING | VMX_SECONDARY_EXEC_ENABLE_PML |
+            VMX_SECONDARY_EXEC_XSAVES | VMX_SECONDARY_EXEC_TSC_SCALING |
+            VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE,
+        .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
+        .xlevel = 0x80000008,
+        .model_id = "Intel Xeon Processor (DiamondRapids)",
+    },
     {
         .name = "SierraForest",
         .level = 0x23,
-- 
2.52.0


