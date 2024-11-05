Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F2D1CA3A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DCV-0006ZN-Rv; Tue, 05 Nov 2024 01:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DCT-0006IC-3A
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:01 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t8DCR-0001vd-F2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730788679; x=1762324679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UOhXpmceQkEx8s4Oa9vrgi40TyS418oe+WG7+rZTz0Q=;
 b=NRha1ua7Ozst4Om2qAcCu/C0Oiys4vNhjx6jH79KedQCNosPPMxmxQX9
 x+Llj7K04aietu0BRsdVOtUJ6j9LzQX4eGChzfauErEWC/aipXVr8mCDU
 bWrGL0ql2mzKULs553UfGI5+IdGF0PW2Iia2mQvUOkw/3pev4pM+9DeEE
 vTq8szha6zUlSPsLwTu3xnuAolSeFwZtTHbd9q/s3qy64ojUu57LlwwWL
 Sq0LkOQJ2SCiTwi+9LzVdmJgszSSNpOGQt53T+c4pQ5IyBsNuOyHB/G2J
 0m8umwABdkuhf+F9Bd24A5plr6Xc6MNIOV2mZvFf8Du7FFSUVDN6g3x+1 g==;
X-CSE-ConnectionGUID: 3frwkflJRCetIJE+3FsAiw==
X-CSE-MsgGUID: Iim5R/PZShmVVbz1a37ZIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30689518"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30689518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:37:49 -0800
X-CSE-ConnectionGUID: EWYM0303ShenTTql/6GbMg==
X-CSE-MsgGUID: Nr3+H8eZQYORr8CJ9auVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83988959"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2024 22:37:44 -0800
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
Subject: [PATCH v6 20/60] i386/tdx: Don't initialize pc.rom for TDX VMs
Date: Tue,  5 Nov 2024 01:23:28 -0500
Message-Id: <20241105062408.3533704-21-xiaoyao.li@intel.com>
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
index 2047633e4cf7..4a23856aed47 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -43,6 +43,7 @@
 #include "sysemu/xen.h"
 #include "sysemu/reset.h"
 #include "kvm/kvm_i386.h"
+#include "kvm/tdx.h"
 #include "hw/xen/xen.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/error-report.h"
@@ -966,21 +967,23 @@ void pc_memory_init(PCMachineState *pcms,
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


