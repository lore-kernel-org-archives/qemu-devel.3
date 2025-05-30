Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FEAC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKu1e-0002Fz-8g; Fri, 30 May 2025 03:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyM-0005NE-AV
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtyJ-0007Ib-Tk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Iimmx3LXinhgynxRgcB48lJkgSlMQLDLzosRd3Ht1E=;
 b=GU2Zs6z5eZSvZGUzgiemFWxS8ZgkPX4VrJ6W3EkohsSLUnE0HJBfP9YZrNtNIZhIbHigWU
 7xMFmIu1ie+ZdhE+SIuPMiLaSxmEelB0Gq4wu7gxKx/WxeX/nh2g5bYxqiod186T9b9oag
 JVZ0GjJz2nS28hIprPR4l0DnDpvMUdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-yIBbeLdEM3-HDUydvAFi7A-1; Fri, 30 May 2025 03:16:05 -0400
X-MC-Unique: yIBbeLdEM3-HDUydvAFi7A-1
X-Mimecast-MFC-AGG-ID: yIBbeLdEM3-HDUydvAFi7A_1748589364
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-adb2a6688a4so89143666b.1
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589363; x=1749194163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Iimmx3LXinhgynxRgcB48lJkgSlMQLDLzosRd3Ht1E=;
 b=QNU7jS/u7slpn1yY+GEku46pmrbLmXJrOS9wYve1gvYLhpBeSDmx4Yb4XBRpnkuvOp
 Ld88AV194LChdvZ0AAyeHELfqv8/M/eoCmt+BV+yQslf0BDktXA2RWAio1xY4ndVNDtW
 d1ZCpwhveipl1az0rsLaS9ORBKkiLI2h1VVK0XUgP3w9zPOHeICDvboF1BFizi5VFzUk
 VozQz8J9g196laVSxsjgGGPT66dbz/C11E88SvYNTyZy4z7oALsE4p2oJCOc9cilQxrE
 npJQD1IhBiYLe4wBprBovKabep8UI/BodGSHm/thcbjMcwzOudCkZAH+xgcb9W1SK6Zp
 Xa4w==
X-Gm-Message-State: AOJu0YyYv7XAx27KpXRWveMknPnBYD8L1hOjbRmb1gtOt2llsyA6wVeX
 VRuqvwxa79xXBtT2ylWtzKEOowoDkC8Dqe6SufyQmR/bdY/fg0VX8aU9H3ycfTdyqYMVOcfoZwQ
 zWREVNUAvzgOB/bgjhTZ1tuShKElrj7S0hU6OX47hxoUbKhsqvt2i7yYrr7ivqUOlJAY5oXUGz4
 TAfBtpdR/nKkxE8Eis8F3lCnw98FiwX8qBbZCw5oDU
X-Gm-Gg: ASbGncvggk4F0RHaCm/mgffFgOHQkBIyh/oiwiJ7UGZ43AZO+x/LmgmeYMryJiiN7vy
 spAzY+/FAM4jrGYldda0IYlz4tZ1rV/mSoIQHttl3ZaGK0kP6GrbswDPLIUlhwpzM7Pce7SFCOJ
 2/pqv6QiQ/rzrODuSqLhFpArAY1Yt0cvwqDQ+GHsUztZNf9XhULT14P3hFWwXSCfC50B9ZfblzT
 TmT5VtkBiO8L2NYz/gSVPO+koTGy8P1Z5kYNO1PO9FBQbeU8v/r4ZPEqMfE+dxpS88WaJhvt6id
 kMfEpEPWp7zO8g==
X-Received: by 2002:a17:906:6a0f:b0:ad8:a4a8:103a with SMTP id
 a640c23a62f3a-adb36afcee2mr112433166b.4.1748589363457; 
 Fri, 30 May 2025 00:16:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLrykM3ai0Ao1kulb2MvI1Fc7bMdyuzK+UYZOtZJPMeJ4i6cAsErwHdT79Y5jrE4xyhi6gMA==
X-Received: by 2002:a17:906:6a0f:b0:ad8:a4a8:103a with SMTP id
 a640c23a62f3a-adb36afcee2mr112428966b.4.1748589362916; 
 Fri, 30 May 2025 00:16:02 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82de76sm279272766b.65.2025.05.30.00.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:16:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 76/77] target/i386: Add support for EPYC-Turin model
Date: Fri, 30 May 2025 09:12:46 +0200
Message-ID: <20250530071250.2050910-77-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Babu Moger <babu.moger@amd.com>

Add the support for AMD EPYC zen 5 processors (EPYC-Turin).

Add the following new feature bits on top of the feature bits from
the previous generation EPYC models.

movdiri             : Move Doubleword as Direct Store Instruction
movdir64b           : Move 64 Bytes as Direct Store Instruction
avx512-vp2intersect : AVX512 Vector Pair Intersection to a Pair
                      of Mask Register
avx-vnni            : AVX VNNI Instruction
prefetchi           : Indicates support for IC prefetch
sbpb                : Selective Branch Predictor Barrier
ibpb-brtype         : IBPB includes branch type prediction flushing
srso-user-kernel-no : Not vulnerable to SRSO at the user-kernel boundary

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/b4fa7708a0e1453d2e9b8ec3dc881feb92eeca0b.1746734284.git.babu.moger@amd.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a656b3c664e..15439fdfa8b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2696,6 +2696,61 @@ static const CPUCaches epyc_genoa_v2_cache_info = {
         .share_level = CPU_TOPOLOGY_LEVEL_DIE,
     },
 };
+
+static const CPUCaches epyc_turin_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+        .type = DATA_CACHE,
+        .level = 1,
+        .size = 48 * KiB,
+        .line_size = 64,
+        .associativity = 12,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 32 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .partitions = 1,
+        .sets = 64,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 1 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 1024,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .inclusive = true,
+        .share_level = CPU_TOPOLOGY_LEVEL_CORE,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 32 * MiB,
+        .line_size = 64,
+        .associativity = 16,
+        .partitions = 1,
+        .sets = 32768,
+        .lines_per_tag = 1,
+        .self_init = true,
+        .no_invd_sharing = true,
+        .complex_indexing = false,
+        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
+    },
+};
+
 /* The following VMX features are not supported by KVM and are left out in the
  * CPU definitions:
  *
@@ -5959,6 +6014,89 @@ static const X86CPUDefinition builtin_x86_defs[] = {
             { /* end of list */ }
         }
     },
+    {
+        .name = "EPYC-Turin",
+        .level = 0xd,
+        .vendor = CPUID_VENDOR_AMD,
+        .family = 26,
+        .model = 0,
+        .stepping = 0,
+        .features[FEAT_1_ECX] =
+            CPUID_EXT_RDRAND | CPUID_EXT_F16C | CPUID_EXT_AVX |
+            CPUID_EXT_XSAVE | CPUID_EXT_AES |  CPUID_EXT_POPCNT |
+            CPUID_EXT_MOVBE | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
+            CPUID_EXT_PCID | CPUID_EXT_CX16 | CPUID_EXT_FMA |
+            CPUID_EXT_SSSE3 | CPUID_EXT_MONITOR | CPUID_EXT_PCLMULQDQ |
+            CPUID_EXT_SSE3,
+        .features[FEAT_1_EDX] =
+            CPUID_SSE2 | CPUID_SSE | CPUID_FXSR | CPUID_MMX | CPUID_CLFLUSH |
+            CPUID_PSE36 | CPUID_PAT | CPUID_CMOV | CPUID_MCA | CPUID_PGE |
+            CPUID_MTRR | CPUID_SEP | CPUID_APIC | CPUID_CX8 | CPUID_MCE |
+            CPUID_PAE | CPUID_MSR | CPUID_TSC | CPUID_PSE | CPUID_DE |
+            CPUID_VME | CPUID_FP87,
+        .features[FEAT_6_EAX] =
+            CPUID_6_EAX_ARAT,
+        .features[FEAT_7_0_EBX] =
+            CPUID_7_0_EBX_FSGSBASE | CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_AVX2 |
+            CPUID_7_0_EBX_SMEP | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ERMS |
+            CPUID_7_0_EBX_INVPCID | CPUID_7_0_EBX_AVX512F |
+            CPUID_7_0_EBX_AVX512DQ | CPUID_7_0_EBX_RDSEED | CPUID_7_0_EBX_ADX |
+            CPUID_7_0_EBX_SMAP | CPUID_7_0_EBX_AVX512IFMA |
+            CPUID_7_0_EBX_CLFLUSHOPT | CPUID_7_0_EBX_CLWB |
+            CPUID_7_0_EBX_AVX512CD | CPUID_7_0_EBX_SHA_NI |
+            CPUID_7_0_EBX_AVX512BW | CPUID_7_0_EBX_AVX512VL,
+        .features[FEAT_7_0_ECX] =
+            CPUID_7_0_ECX_AVX512_VBMI | CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU |
+            CPUID_7_0_ECX_AVX512_VBMI2 | CPUID_7_0_ECX_GFNI |
+            CPUID_7_0_ECX_VAES | CPUID_7_0_ECX_VPCLMULQDQ |
+            CPUID_7_0_ECX_AVX512VNNI | CPUID_7_0_ECX_AVX512BITALG |
+            CPUID_7_0_ECX_AVX512_VPOPCNTDQ | CPUID_7_0_ECX_LA57 |
+            CPUID_7_0_ECX_RDPID | CPUID_7_0_ECX_MOVDIRI |
+            CPUID_7_0_ECX_MOVDIR64B,
+        .features[FEAT_7_0_EDX] =
+            CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_AVX512_VP2INTERSECT,
+        .features[FEAT_7_1_EAX] =
+            CPUID_7_1_EAX_AVX_VNNI | CPUID_7_1_EAX_AVX512_BF16,
+        .features[FEAT_8000_0001_ECX] =
+            CPUID_EXT3_OSVW | CPUID_EXT3_3DNOWPREFETCH |
+            CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A | CPUID_EXT3_ABM |
+            CPUID_EXT3_CR8LEG | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM |
+            CPUID_EXT3_TOPOEXT | CPUID_EXT3_PERFCORE,
+        .features[FEAT_8000_0001_EDX] =
+            CPUID_EXT2_LM | CPUID_EXT2_RDTSCP | CPUID_EXT2_PDPE1GB |
+            CPUID_EXT2_FFXSR | CPUID_EXT2_MMXEXT | CPUID_EXT2_NX |
+            CPUID_EXT2_SYSCALL,
+        .features[FEAT_8000_0007_EBX] =
+            CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR,
+        .features[FEAT_8000_0008_EBX] =
+            CPUID_8000_0008_EBX_CLZERO | CPUID_8000_0008_EBX_XSAVEERPTR |
+            CPUID_8000_0008_EBX_WBNOINVD | CPUID_8000_0008_EBX_IBPB |
+            CPUID_8000_0008_EBX_IBRS | CPUID_8000_0008_EBX_STIBP |
+            CPUID_8000_0008_EBX_STIBP_ALWAYS_ON |
+            CPUID_8000_0008_EBX_AMD_SSBD | CPUID_8000_0008_EBX_AMD_PSFD,
+        .features[FEAT_8000_0021_EAX] =
+            CPUID_8000_0021_EAX_NO_NESTED_DATA_BP |
+            CPUID_8000_0021_EAX_FS_GS_BASE_NS |
+            CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING |
+            CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE |
+            CPUID_8000_0021_EAX_AUTO_IBRS | CPUID_8000_0021_EAX_PREFETCHI |
+            CPUID_8000_0021_EAX_SBPB | CPUID_8000_0021_EAX_IBPB_BRTYPE |
+            CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO,
+        .features[FEAT_8000_0022_EAX] =
+            CPUID_8000_0022_EAX_PERFMON_V2,
+        .features[FEAT_XSAVE] =
+            CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XSAVEC |
+            CPUID_XSAVE_XGETBV1 | CPUID_XSAVE_XSAVES,
+        .features[FEAT_SVM] =
+            CPUID_SVM_NPT | CPUID_SVM_LBRV | CPUID_SVM_NRIPSAVE |
+            CPUID_SVM_TSCSCALE | CPUID_SVM_VMCBCLEAN | CPUID_SVM_FLUSHASID |
+            CPUID_SVM_PAUSEFILTER | CPUID_SVM_PFTHRESHOLD |
+            CPUID_SVM_V_VMSAVE_VMLOAD | CPUID_SVM_VGIF |
+            CPUID_SVM_VNMI | CPUID_SVM_SVME_ADDR_CHK,
+        .xlevel = 0x80000022,
+        .model_id = "AMD EPYC-Turin Processor",
+        .cache_info = &epyc_turin_cache_info,
+    },
 };
 
 /*
-- 
2.49.0


