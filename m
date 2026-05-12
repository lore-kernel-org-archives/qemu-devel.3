Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D935CD4F35
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMiZL-00023E-7Q; Tue, 12 May 2026 04:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZK-00022Y-0y
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:22 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wMiZH-00005i-5A
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778574859; x=1810110859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FqMTFJZhhczXckszP0/dw7hvWNcTDTeX6slbhhoplXs=;
 b=FG7uXUUg8b+lKcmJu8GvYMAM/guPxAbQjYAXT/He1e5E0GBXgGcj8m2h
 L9bmTkGY1nVk5Qgb9bpYrNTN2ZgVcFz9X7OCac1W+WMg2pQ0jd+84QV0s
 iy/oO+L9O6AxV5J6p9OHOibvQ5PZLObdaIMIPPrpnsbbefBWnDscEUSLW
 vF4EPqlkV1xc6LWgO3L7o6pHxVP/LQrHfKd1HKUgw2LZUN24jvf07vRz+
 vs0lPCsw02qacuIpdxsniJ0fetvMMrSNR7dPeMZwJxpc0AYlHWpXBPFW3
 DwZXK4sKj8PKmd4zTZT/b+5yz8aiyCfFqX9lpBCzJvUyCVfGn/KsWPqYO Q==;
X-CSE-ConnectionGUID: t/d5c5swSQytRGOp0imclg==
X-CSE-MsgGUID: ETIzc2uURwuXEqe0yuoE4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90060005"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="90060005"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 01:34:18 -0700
X-CSE-ConnectionGUID: u6DhdmH9QIac95HEJuQq8Q==
X-CSE-MsgGUID: axzOspCCQ5KnMRPkC9rBfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; d="scan'208";a="237947186"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa007.jf.intel.com with ESMTP; 12 May 2026 01:34:15 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH 2/3] i386/tdx: Make AMX alias bits supported
Date: Tue, 12 May 2026 16:21:07 +0800
Message-ID: <20260512082108.621596-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512082108.621596-1-xiaoyao.li@intel.com>
References: <20260512082108.621596-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

When booting a TD guest on a platform that supports AMX alias bits, QEMU
emits the warning such as:

  qemu-system-x86_64: warning: TDX forcibly sets the feature: CPUID[eax=1Eh,ecx=01h].EAX.amx-int8-alias [bit 0]
  ...

Bit[3:0] of CPUID(0x1e,1).EAX alias the AMX CPUID bits from leaf 7.
Their TDX virtualization type is "CPUID_Enabled & Native": the value is
determined by the leaf-7 AMX bit they are aliased to and the native
hardware value.

These bits must be added to the TDX supported bits list so that they can
be enabled without triggering the forced-set warning. For simplicity,
mark them as supported whenever the corresponding AMX XFAM bit is
supported, rather than checking each aliased leaf-7 bit individually.
This reduces code complexity. Any platform that supports the AMX XFAM bit
but not these alias bits will still be handled correctly, since the TDX
module provides the real value via tdx_check_features().

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
 target/i386/kvm/tdx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 6f93997d62db..6c80f6e7dcbe 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -560,13 +560,19 @@ typedef struct TdxXFAMDep {
 } TdxXFAMDep;
 
 /*
- * Note, only the CPUID bits whose virtualization type are "XFAM & Native" are
- * defiend here.
+ * Note, usually the CPUID bits whose virtualization type are "XFAM & Native"
+ * are defined here while "XFAM & Configured & Native" are not. Because the
+ * latter are reported as configurable bits by KVM when they are supported.
+ * And they are not supported when not in the configurable bits list from KVM
+ * even if the corresponding XFAM bit is supported.
  *
- * For those whose virtualization type are "XFAM & Configured & Native", they
- * are reported as configurable bits. And they are not supported if not in the
- * configureable bits list from KVM even if the corresponding XFAM bit is
- * supported.
+ * Special cases:
+ *
+ * - AMX alias bits, their type is "CPUID_Enabled & Native" which means their
+ * value is determined by the CPUID bit they are aliased to.
+ *
+ * For simplicity, relax the dependency to related XFAM bit.
+ * tdx_check_features() will eventually catch the unsupported configurations.
  */
 TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_YMM_BIT,       { FEAT_1_ECX, CPUID_EXT_FMA } },
@@ -580,6 +586,10 @@ TdxXFAMDep tdx_xfam_deps[] = {
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_BF16 } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_TILE } },
     { XSTATE_XTILE_CFG_BIT, { FEAT_7_0_EDX, CPUID_7_0_EDX_AMX_INT8 } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_INT8_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_BF16_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_COMPLEX_ALIAS } },
+    { XSTATE_XTILE_CFG_BIT, { FEAT_1E_1_EAX, CPUID_1E_1_EAX_AMX_FP16_ALIAS } },
 };
 
 static struct kvm_cpuid_entry2 *find_in_supported_entry(uint32_t function,
-- 
2.43.0


