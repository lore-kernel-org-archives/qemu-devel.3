Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA386C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJsg-0003px-0I; Fri, 24 Jan 2025 08:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJse-0003p1-3r
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:52 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJsc-0003xi-L2
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725871; x=1769261871;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qmNZXY74mhCvcHjPeZ7Zt9Eiiug9SdAA9hSZ2NO+cEA=;
 b=kZxfGUH8y4VTxegICwkv2Y2ifj+2E0PaYjbSzzvEYyf9Pe8mgqNjHaPb
 AsH6vyMCY2uIb9Xyv0yq1R48icNvZvmjbGD5pFmno7k/8rygP2i8EGgJM
 gaHXhfNHQcTB8Pqd0KDTJzOFYCERuXh+1gmGCM3eSOM6vPeNCOVfU5P9y
 kOZxLBloLFdteBKkcnkqvbkmmfZEwuy8oTJjMAWQBfRB9fp5iUJDyHO6z
 RbAlsQSN0tPSFxsfOIi5i5uq+zKdECXvEnObYRJs+UgHYBebrId9S6/8D
 VyYTY3cSLJRkD2yEt5kUVaCNhovQ3KB+pLRgR3GaNws4+UOHCwLfVaPVo g==;
X-CSE-ConnectionGUID: 0mOK8CCWT4GftIkhgHvRoA==
X-CSE-MsgGUID: 0PL6fSpcSu2Yn7yT0j81lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246274"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246274"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:37:50 -0800
X-CSE-ConnectionGUID: p75RpVOpQQqG+e6CaUHL2Q==
X-CSE-MsgGUID: hw4H65BBSYm+zmpJJIXQkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804209"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:37:46 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 13/52] i386/tdx: Set APIC bus rate to match with what TDX
 module enforces
Date: Fri, 24 Jan 2025 08:20:09 -0500
Message-Id: <20250124132048.3229049-14-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

TDX advertises core crystal clock with cpuid[0x15] as 25MHz for TD
guests and it's unchangeable from VMM. As a result, TDX guest reads
the APIC timer as the same frequency, 25MHz.

While KVM's default emulated frequency for APIC bus is 1GHz, set the
APIC bus rate to match with TDX explicitly to ensure KVM provide correct
emulated APIC timer for TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
 - new patch;
---
 target/i386/kvm/tdx.c | 13 +++++++++++++
 target/i386/kvm/tdx.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ed843af1d0b6..96138c2d2b73 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -253,6 +253,19 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+    if (!kvm_check_extension(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS)) {
+        error_setg(errp, "KVM doesn't support KVM_CAP_X86_APIC_BUS_CYCLES_NS");
+        return -EOPNOTSUPP;
+    }
+
+    r = kvm_vm_enable_cap(kvm_state, KVM_CAP_X86_APIC_BUS_CYCLES_NS,
+                          0, TDX_APIC_BUS_CYCLES_NS);
+    if (r < 0) {
+        error_setg_errno(errp, -r,
+                         "Unable to set core crystal clock frequency to 25MHz");
+        return r;
+    }
+
     if (tdx_guest->mrconfigid) {
         g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
                               strlen(tdx_guest->mrconfigid), &data_len, errp);
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index e472b11fb0dd..d39e733d9fcc 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -16,6 +16,9 @@ typedef struct TdxGuestClass {
     X86ConfidentialGuestClass parent_class;
 } TdxGuestClass;
 
+/* TDX requires bus frequency 25MHz */
+#define TDX_APIC_BUS_CYCLES_NS 40
+
 typedef struct TdxGuest {
     X86ConfidentialGuest parent_obj;
 
-- 
2.34.1


