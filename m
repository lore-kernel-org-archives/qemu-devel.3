Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FA2C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa7B-0006o7-0D; Thu, 29 Feb 2024 01:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa6n-0005zv-PM
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:41:35 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa6l-0004qw-RT
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188891; x=1740724891;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7gqINbzguIZPAZ32V6gUuwIXeZkcagTHNpNt0PPOTHg=;
 b=hV/S3GZMB3OfrUEUn+UNp2rv8jK4kdQ+c1WRSvMkUa4pKQMRJOCbEbK6
 XpNRQ9/6Q5du7M1Y1LyTarAL72kgFABCKzGhemel8GXPhV0gU+ZKWpfsP
 CwF7WfsekVzdElo8fQjmuOP8OnOtZSnbZCdrLA+BhoWxCPeV6BMJF0Hw3
 25xhco2aGDpbvcRcMPbkr81fcyfd8Q7nY3GnrtLFy8+ZKeKiMzud/9Qc3
 ParGsWr1E0uu5CFzgA3EAaNDPlaVJFUraC9gh5fn2Jhu2tVm3ZINCnrB9
 n2c6IGZay/RKUNGX8zh/vl4TaDfcdJqhU7rGHw77h6/ZDaTufmZnundeV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802899"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802899"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075691"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:41:24 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, xiaoyao.li@intel.com
Subject: [PATCH v5 36/65] i386/tdx: load TDVF for TD guest
Date: Thu, 29 Feb 2024 01:36:57 -0500
Message-Id: <20240229063726.610065-37-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229063726.610065-1-xiaoyao.li@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.596, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 hw/i386/x86.c         | 13 +++++++++++--
 target/i386/kvm/tdx.c |  7 +++++++
 target/i386/kvm/tdx.h |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index fa7095310f37..5a0cadc88c4f 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -47,6 +47,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "target/i386/sev.h"
+#include "kvm/tdx.h"
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/irq.h"
@@ -1157,9 +1158,17 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
+
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
-    if (sev_enabled()) {
+    if (is_tdx_vm()) {
+        memory_region_init_ram_guest_memfd(bios, NULL, "pc.bios", bios_size,
+                                           &error_fatal);
+        tdx_set_tdvf_region(bios);
+    } else {
+        memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    }
+
+    if (sev_enabled() || is_tdx_vm()) {
         /*
          * The concept of a "reset" simply doesn't exist for
          * confidential computing guests, we have to destroy and
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 13f069171db7..7c8e14e3cc58 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,7 @@
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
+#include "exec/ramblock.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -463,6 +464,12 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
             (tdx_caps->xfam_fixed1 & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr)
+{
+    assert(!tdx_guest->tdvf_mr);
+    tdx_guest->tdvf_mr = tdvf_mr;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 2697e6bdfb1d..c021223001a5 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -24,6 +24,8 @@ typedef struct TdxGuest {
     char *mrconfigid;       /* base64 encoded sha348 digest */
     char *mrowner;          /* base64 encoded sha348 digest */
     char *mrownerconfig;    /* base64 encoded sha348 digest */
+
+    MemoryRegion *tdvf_mr;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -35,5 +37,6 @@ bool is_tdx_vm(void);
 void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
                              uint32_t *ret);
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


