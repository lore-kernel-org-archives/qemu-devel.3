Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E25C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbwk-0003R6-B1; Tue, 01 Apr 2025 09:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbux-0001Mf-OE
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbuw-0006ZP-4K
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743515078; x=1775051078;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXJsHp6IKbQ0urWG/A57EAspFBUln9gJODiT0xlm4gY=;
 b=WDSgL4vHA8LQKmKWODSd3mjRB4mlsLBJX3gL0840/5Wd97r51ImG1t4Q
 XWs0Zhf54uQSkADI4O/sj0Nb1F6zp1QxlFkQxCGo/3EoTfxBU17iRhD0l
 CJnHxykRaTjRKzOqalWzxuF5NWByA2k71ctEyqkAUbCvuKTg1MlHQ82sC
 Yq6Vh9xem4fLLBwph1dKzBnwxR3zRNLMsG99gkKkwKrUDT9RZ9idswx5E
 J+4U/tSBztXZW8Bxyr7lMRu7SBIXFBtQXiOYh/IaOpH83zA9pSuiX2naZ
 Uq1q71Cjqwm1GauYXnYjAYwavgLZvcLje7gUzeM4bSWg6Okm2bu9jk2e3 g==;
X-CSE-ConnectionGUID: A8qWQc1ySnCO4QawgW4j4g==
X-CSE-MsgGUID: NdG5JK1bRL+O537OXrikBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433552"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433552"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:43:12 -0700
X-CSE-ConnectionGUID: eLruHHsSQp6zcuVnYtf3zA==
X-CSE-MsgGUID: AlbD/7EaT+eJ+vvVw5r3Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640253"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:43:10 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 48/55] i386/tdx: Add XFD to supported bit of TDX
Date: Tue,  1 Apr 2025 09:01:58 -0400
Message-Id: <20250401130205.2198253-49-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Just mark XFD as always supported for TDX. This simple solution relies
on the fact KVM will report XFD as 0 when it's not supported by the
hardware.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/tdx.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 132312d70a54..a223e09a25c4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1126,6 +1126,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XSAVEC     (1U << 1)
 #define CPUID_XSAVE_XGETBV1    (1U << 2)
 #define CPUID_XSAVE_XSAVES     (1U << 3)
+#define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
 
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index c7b4a098d12f..e07cd9a1ee15 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -620,6 +620,11 @@ static void tdx_add_supported_cpuid_by_xfam(void)
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
 
     e = find_in_supported_entry(0xd, 1);
+    /* Mark XFD always support for TDX, it will be cleared finally in
+     * tdx_adjust_cpuid_features() if XFD is unavailable on the hardware
+     * because in this case the original data has it as 0.
+     */
+    e->eax |= CPUID_XSAVE_XFD;
     e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
 }
-- 
2.34.1


