Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04831C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2oz-0001yt-47; Thu, 08 May 2025 11:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2ox-0001vW-E0
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2ov-0007UR-12
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716757; x=1778252757;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PHTPaQbkYb8j0G2p4mfivx3f0bL2ixSPSpvr06RaVEQ=;
 b=F3qG1aP45sI95trbVGdNYXFo0/cHOaebCkIC8MD48d1sVGmQwXclfOjx
 +ecWUaFSC+ERyNJhBkb5ytjPu64K/oLc2hZbUtP52ztQME7Lwfn2or4RT
 hb8GdcFbZnciP5PULXpu43YVeiZDIZ69SbCAsG5sOn0MsezE99uI5NHr9
 2ZQYzINZDt7L68NeoUpCo4eIRRberqeKz1MVk27B6/nLxWPTxX4RVuKT6
 uvKmjpt0Gt2quiEqrJVhIKsKWMPd5N5YB86sKdnF5MFWoeP3hf7JX6YpY
 KLL9coG3aUiioRACRZeKwhhPGsyJPeFNX8vI7+RZ6DT0pa5Uyrq+FZisM Q==;
X-CSE-ConnectionGUID: fU4MC5yZS9ywzH3eXiuUeg==
X-CSE-MsgGUID: pqHMetElSeelfeFiRrn0Hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888121"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888121"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:05:44 -0700
X-CSE-ConnectionGUID: 78Pt+vYLRQanUgzsDo+i9w==
X-CSE-MsgGUID: mG/BSXj/R+iJIsyx9A/XaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141439909"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:05:41 -0700
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
Subject: [PATCH v9 16/55] i386/tdx: load TDVF for TD guest
Date: Thu,  8 May 2025 10:59:22 -0400
Message-ID: <20250508150002.689633-17-xiaoyao.li@intel.com>
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/x86-common.c  | 6 +++++-
 target/i386/kvm/tdx.c | 6 ++++++
 target/i386/kvm/tdx.h | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 1b0671c52397..b1b5f11e7396 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -44,6 +44,7 @@
 #include "standard-headers/asm-x86/bootparam.h"
 #include CONFIG_DEVICES
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 
 #ifdef CONFIG_XEN_EMU
 #include "hw/xen/xen.h"
@@ -1035,11 +1036,14 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
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
index 56ad5f599d4b..2522f2030de3 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -137,6 +137,12 @@ static int get_tdx_capabilities(Error **errp)
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
index d39e733d9fcc..b73461b8d8a3 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -30,6 +30,8 @@ typedef struct TdxGuest {
     char *mrconfigid;       /* base64 encoded sha348 digest */
     char *mrowner;          /* base64 encoded sha348 digest */
     char *mrownerconfig;    /* base64 encoded sha348 digest */
+
+    MemoryRegion *tdvf_mr;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -39,5 +41,6 @@ bool is_tdx_vm(void);
 #endif /* CONFIG_TDX */
 
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.43.0


