Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51BCD1CA3B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DCE-0005kl-V3; Tue, 05 Nov 2024 01:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DC9-0005Rl-4K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:41 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DC7-0001vJ-5L
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788659; x=1762324659;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eviZxt2uHCaBFHxS9OQDjWkbBKzkgFdGvefQVCQtPgg=;
 b=A1oG4MNKZRB6H0b7HYYv1iGqgeyi5f1ao5hDzCpt0itAXQ+5J/ctczL9
 3p1ZVsxsir33nUS8RsNNNwxXcZhULA6pW4hbA2kGc3/5pmGV1WuG3JSya
 a/MtJPLXLTq8wzurnGlKgumWP68ZvRqLqexe3lDmfsyIAnyIvFSDMgvSZ
 bIQ/k2SYw/VnwCn4ze1rcr2nwMGH2ql85qWqAlKzPRN+SjdQw1HZ8bdPr
 v5nn6VGo4c9mPeBzMzO2gb5qzYSyt7npToK623GyzPaPtpIicP8YZ29nO
 9EGs9xVx8lf2wcgN/HEuyRCuSoL71Q2YtlpPYBJY0FYezAqo4pwVbNf3E A==;
X-CSE-ConnectionGUID: 5ivbuK6pSZmxtT0EBpWxLQ==
X-CSE-MsgGUID: p9BFSTonQR+cc9x1QMMNlw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689480"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689480"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:37:38 -0800
X-CSE-ConnectionGUID: h4M+rUgqSuWhYI8H31oyhw==
X-CSE-MsgGUID: rtUp98ElRPurPn+fT+1nsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988899"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:37:30 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, xiaoyao.li@intel.com
Subject: [PATCH v6 17/60] i386/tdx: load TDVF for TD guest
Date: Tue,  5 Nov 2024 01:23:25 -0500
Message-Id: <20241105062408.3533704-18-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105062408.3533704-1-xiaoyao.li@intel.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.781, RCVD_IN_DNSWL_MED=-2.3,
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

From: Chao Peng <chao.p.peng@linux.intel.com>

TDVF(OVMF) needs to run at private memory for TD guest. TDX cannot
support pflash device since it doesn't support read-only private memory.
Thus load TDVF(OVMF) with -bios option for TDs.

Use memory_region_init_ram_guest_memfd() to allocate the MemoryRegion
for TDVF because it needs to be located at private memory.

Also store the MemoryRegion pointer of TDVF since the shared ramblock of
it can be discared after it gets copied to private ramblock.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86-common.c  | 6 +++++-
 target/i386/kvm/tdx.c | 6 ++++++
 target/i386/kvm/tdx.h | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b86c38212eab..1df496a15eff 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -44,6 +44,7 @@
 #include "standard-headers/asm-x86/bootparam.h"
 #include CONFIG_DEVICES
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen.h"
@@ -1007,11 +1008,14 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     if (machine_require_guest_memfd(MACHINE(x86ms))) {
         memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
                                            bios_size, &error_fatal);
+        if (is_tdx_vm()) {
+            tdx_set_tdvf_region(&x86ms->bios);
+        }
     } else {
         memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
                                bios_size, &error_fatal);
     }
-    if (sev_enabled()) {
+    if (sev_enabled() || is_tdx_vm()) {
         /*
          * The concept of a "reset" simply doesn't exist for
          * confidential computing guests, we have to destroy and
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4193211c3190..d5ebc2430fd1 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -120,6 +120,12 @@ static int get_tdx_capabilities(Error **errp)
     return 0;
 }
 
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
+{
+    assert(!tdx_guest->tdvf_mr);
+    tdx_guest->tdvf_mr = tdvf_mr;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(cgs);
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 0aebc7e3f6c9..e5d836805385 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -28,6 +28,8 @@ typedef struct TdxGuest {
     char *mrconfigid;       /* base64 encoded sha348 digest */
     char *mrowner;          /* base64 encoded sha348 digest */
     char *mrownerconfig;    /* base64 encoded sha348 digest */
+
+    MemoryRegion *tdvf_mr;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -37,5 +39,6 @@ bool is_tdx_vm(void);
 #endif /* CONFIG_TDX */
 
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


