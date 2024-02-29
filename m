Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B33C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfa7H-00078h-AD; Thu, 29 Feb 2024 01:42:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa77-0006fy-Gg
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:41:53 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rfa75-0004qw-IB
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709188911; x=1740724911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w+3FVIgu6+6PP0tbc6InvSJYIh6/cEjrfhsEEHWGAEQ=;
 b=dWMnZGtpQ04YJVACU9DwUn14yFiEuFde53oes70dSxp6QoJ8lHjc/w4M
 vt4vkrwIg6TIeykMEraLLiq7o1mz+fnRxUGI7+5K52OhjZH5syx1JDsD3
 VJHiAFQClgZ2AtYcLIdUkCmemArASJn+0rFi4NBguYF6J+fTn2krgSbGf
 MrwTQ3UqGlmwp1MJGx13nEp4deutoynr2AHU5Tuv0Hl3z8Js7+rlmwHlU
 naP5f5t4UoEPpVgle6vDnRA/OW6GJHKN2GawRPKPswlvQ8g+DYW+wHBAP
 88AGfMa6S2mGtffsXZL/bj02yeobtUA+j/8ZZllcsj03CFXDP8rFztQTC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3802948"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3802948"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 22:41:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8075755"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 22:41:45 -0800
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
Subject: [PATCH v5 39/65] i386/tdx: Skip BIOS shadowing setup
Date: Thu, 29 Feb 2024 01:37:00 -0500
Message-Id: <20240229063726.610065-40-xiaoyao.li@intel.com>
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

TDX doesn't support map different GPAs to same private memory. Thus,
aliasing top 128KB of BIOS as isa-bios is not supported.

On the other hand, TDX guest cannot go to real mode, it can work fine
without isa-bios.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v1:
 - update commit message and comment to clarify
---
 hw/i386/x86.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 5a0cadc88c4f..61c45dfc14dd 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1190,17 +1190,20 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     }
     g_free(filename);
 
-    /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        isa_bios,
-                                        1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
+    /* For TDX, alias different GPAs to same private memory is not supported */
+    if (!is_tdx_vm()) {
+        /* map the last 128KB of the BIOS in ISA space */
+        isa_bios_size = MIN(bios_size, 128 * KiB);
+        isa_bios = g_malloc(sizeof(*isa_bios));
+        memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                                bios_size - isa_bios_size, isa_bios_size);
+        memory_region_add_subregion_overlap(rom_memory,
+                                            0x100000 - isa_bios_size,
+                                            isa_bios,
+                                            1);
+        if (!isapc_ram_fw) {
+            memory_region_set_readonly(isa_bios, true);
+        }
     }
 
     /* map all the bios at the top of memory */
-- 
2.34.1


