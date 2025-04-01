Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB698C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbt8-0006Wp-M9; Tue, 01 Apr 2025 09:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbsw-0005sJ-Ar
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:36 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbss-0006Zf-S2
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514951; x=1775050951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nlAe9WpERrXUlGfHAoVGpLsg+Xj3YjTCOkA2zr+Kkfg=;
 b=Z4QLeOdtZXgcQYbrJHXiP4WY+dcg8C0Zxj8jXizGrKWr8xbDRZWeALIq
 jEAxDp4IhzX52dMpCrbXoAooNq4BaezfvtMVopZv/3shx4e8z26Byn1WW
 p5NuoRtkBHt397w2TITqX2tnaZUGp4r3UckAxosGrNgHVZopq/Qf0lZI+
 MGPHs6lAmpfqsckzobwrB4uisiFyMfcLv1i3bdiMuuUBfyuD07MKpbqjo
 jM0PKHgkKIVopM30YIA8N0cQlQl3ozA/uuNoE2/U6oBeRCEaPTnIkPwTx
 NznCfSyabc/I6bjkBHEjqziWJmsyca9+5ms1bROTrcxDjvbatM2TyBtAd g==;
X-CSE-ConnectionGUID: ma9VuIJCQLmXGkoigC77qA==
X-CSE-MsgGUID: byWRbXSFRk2TDgmm5y89nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433304"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433304"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:00 -0700
X-CSE-ConnectionGUID: Z9lq0syESzaQSrUYYJUqTA==
X-CSE-MsgGUID: OBFd8pIrQ1yyIJQIep3UJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640001"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:41:57 -0700
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
Subject: [PATCH v8 19/55] i386/tdx: Don't initialize pc.rom for TDX VMs
Date: Tue,  1 Apr 2025 09:01:29 -0400
Message-Id: <20250401130205.2198253-20-xiaoyao.li@intel.com>
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

For TDX, the address below 1MB are entirely general RAM. No need to
initialize pc.rom memory region for TDs.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
This is more as a workaround of the issue that for q35 machine type, the
real memslot update (which requires memslot deletion )for pc.rom happens
after tdx_init_memory_region. It leads to the private memory ADD'ed
before get lost. I haven't work out a good solution to resolve the
order issue. So just skip the pc.rom setup to avoid memslot deletion.
---
 hw/i386/pc.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 01d0581f62a3..bcbbea235645 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -43,6 +43,7 @@
 #include "system/xen.h"
 #include "system/reset.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "hw/xen/xen.h"
 #include "qobject/qlist.h"
 #include "qemu/error-report.h"
@@ -972,21 +973,23 @@ void pc_memory_init(PCMachineState *pcms,
     /* Initialize PC system firmware */
     pc_system_firmware_init(pcms, rom_memory);
 
-    option_rom_mr = g_malloc(sizeof(*option_rom_mr));
-    if (machine_require_guest_memfd(machine)) {
-        memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
-                                           PC_ROM_SIZE, &error_fatal);
-    } else {
-        memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
-                               &error_fatal);
-        if (pcmc->pci_enabled) {
-            memory_region_set_readonly(option_rom_mr, true);
+    if (!is_tdx_vm()) {
+        option_rom_mr = g_malloc(sizeof(*option_rom_mr));
+        if (machine_require_guest_memfd(machine)) {
+            memory_region_init_ram_guest_memfd(option_rom_mr, NULL, "pc.rom",
+                                            PC_ROM_SIZE, &error_fatal);
+        } else {
+            memory_region_init_ram(option_rom_mr, NULL, "pc.rom", PC_ROM_SIZE,
+                                &error_fatal);
+            if (pcmc->pci_enabled) {
+                memory_region_set_readonly(option_rom_mr, true);
+            }
         }
+        memory_region_add_subregion_overlap(rom_memory,
+                                            PC_ROM_MIN_VGA,
+                                            option_rom_mr,
+                                            1);
     }
-    memory_region_add_subregion_overlap(rom_memory,
-                                        PC_ROM_MIN_VGA,
-                                        option_rom_mr,
-                                        1);
 
     fw_cfg = fw_cfg_arch_create(machine,
                                 x86ms->boot_cpus, x86ms->apic_id_limit);
-- 
2.34.1


