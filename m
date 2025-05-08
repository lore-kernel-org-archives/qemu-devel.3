Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8760C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2ro-0005Fu-Td; Thu, 08 May 2025 11:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rc-0004po-QY
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:48 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2rZ-0007UR-4n
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716921; x=1778252921;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NV3mTH60gcvIjwnn6kwqKcY8PoQJ7+HSm/o7zQJIltk=;
 b=Y76eOs9kKMNxEihQcIM7+wtylaHmQetf/sfLft0OKsGJ5szfgfIeORK9
 51IAvpxez45NDJqgU5TE/lVvLXTfQJwZ5w3FsA7eqGmUAxyeFoV4B6YS1
 cUm1Kk2ud7TLIQFAdMTyroKwqr+i6Xg2gMgxdnehVlBPkPDT+JM6qTVc8
 SCU2ZKijQ6METJY8Pu42K8QQtSZiB5YS13JT22vLmvkuOku7YW2KCVFte
 aMV9JPNTo3K7IkHyTIDVyhk6wU+vv4FnbmgeEJtw9HjF2grl6k6zuUWl9
 LREtqqbdb6mVVWOvP+l0WzOERBhTuCDm1D2XKYv/OuYeSiZi+PFs7pgcw g==;
X-CSE-ConnectionGUID: ztxiq7YcQbKiSKQNxTTsZw==
X-CSE-MsgGUID: AXCnO5iRSa6oB/Qsd0cNCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888541"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888541"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:07:23 -0700
X-CSE-ConnectionGUID: DO4YXkSLR3q6mKaO6TWudQ==
X-CSE-MsgGUID: TUh9Rcj7RV2U3xhDfSZNiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440496"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:07:20 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 48/55] i386/tdx: Add XFD to supported bit of TDX
Date: Thu,  8 May 2025 10:59:54 -0400
Message-ID: <20250508150002.689633-49-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/cpu.h     | 1 +
 target/i386/kvm/tdx.c | 6 ++++++
 2 files changed, 7 insertions(+)

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
index df6b71568321..528b5cb4ae47 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -628,6 +628,12 @@ static void tdx_add_supported_cpuid_by_xfam(void)
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XCR0_MASK) >> 32;
 
     e = find_in_supported_entry(0xd, 1);
+    /*
+     * Mark XFD always support for TDX, it will be cleared finally in
+     * tdx_adjust_cpuid_features() if XFD is unavailable on the hardware
+     * because in this case the original data has it as 0.
+     */
+    e->eax |= CPUID_XSAVE_XFD;
     e->ecx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK);
     e->edx |= (tdx_caps->supported_xfam & CPUID_XSTATE_XSS_MASK) >> 32;
 }
-- 
2.43.0


