Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBAFD13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5FqQ-0006Bo-5v; Sun, 27 Oct 2024 22:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqN-0006AX-2u
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:50:59 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tao1.su@linux.intel.com>)
 id 1t5FqL-0003WR-Ef
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730083858; x=1761619858;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1T2y+tcJtXzNjiVuhdwnguoXTqleNUI1LAkfNAE+DyY=;
 b=V66VLCmlvkhYhjdom0JJavGPkApYHsxZrATrneZ+ahYHDqgkIrZ66OOx
 fukOPFsyBoQC0yRyWFmJeUoPwK2GiqA7zOnkq6Jo6qwOF5vj6Kmer/8YV
 tG/V82E2ek4/jc/ybhQ9RxP8q3Eb7za0P7fVq792eLq+pwlMA7JqakAhc
 DxKnuB2VB6bYxhUduZdRczQ4FReLwjWSJlAHdXvX1BnPCIMX5m8xyRlES
 +Cd+vH52ezPzNkXx3K0p8KRV+cu7isJVFfiOqYAhvrvZmNoj2nO0QY1yx
 7blNejY9HJztAShCStIbak6HziyP6kkS2laR3DvYZsWO6QeSMs6o8wPhB Q==;
X-CSE-ConnectionGUID: J1NlcV22TzaD8ZQpzVooDQ==
X-CSE-MsgGUID: vBVQooySTC2D+EOTSev+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="40249465"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="40249465"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:50:55 -0700
X-CSE-ConnectionGUID: qc9EuPeGRgCX/LybdGH0Og==
X-CSE-MsgGUID: qpeiZ7GXRaK9A9FMNY5ntw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="81420932"
Received: from st-server.bj.intel.com ([10.240.193.102])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2024 19:50:53 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, xiaoyao.li@intel.com,
 xuelian.guo@intel.com, tao1.su@linux.intel.com
Subject: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
Date: Mon, 28 Oct 2024 10:45:07 +0800
Message-Id: <20241028024512.156724-2-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028024512.156724-1-tao1.su@linux.intel.com>
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.11;
 envelope-from=tao1.su@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
are identical to AVX512 state regardless of the supported vector lengths.

Given that some E-cores will support AVX10 but not support AVX512, add
AVX512 state components to guest when AVX10 is enabled.

Tested-by: Xuelian Guo <xuelian.guo@intel.com>
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 target/i386/cpu.c | 14 ++++++++++++++
 target/i386/cpu.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1ff1af032e..d845ff5e4e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
         }
         if (env->features[esa->feature] & esa->bits) {
             xcr0 |= 1ull << i;
+            continue;
+        }
+        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
+            i == XSTATE_Hi16_ZMM_BIT) {
+            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+                xcr0 |= 1ull << i;
+            }
         }
     }
 
@@ -7315,6 +7322,13 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         const ExtSaveArea *esa = &x86_ext_save_areas[i];
         if (env->features[esa->feature] & esa->bits) {
             mask |= (1ULL << i);
+            continue;
+        }
+        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
+            i == XSTATE_Hi16_ZMM_BIT) {
+            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
+                mask |= (1ULL << i);
+            }
         }
     }
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 74886d1580..280bec701c 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -972,6 +972,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
+/* Support for Advanced Vector Extensions 10 */
+#define CPUID_7_1_EDX_AVX10             (1U << 19)
 /* Flexible return and event delivery (FRED) */
 #define CPUID_7_1_EAX_FRED              (1U << 17)
 /* Load into IA32_KERNEL_GS_BASE (LKGS) */
-- 
2.34.1


