Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B4DD11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQStv-0008Bc-Ny; Tue, 02 Dec 2025 11:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQStA-0006G8-IP; Tue, 02 Dec 2025 11:06:08 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSt4-0007EB-K7; Tue, 02 Dec 2025 11:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691559; x=1796227559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XMzTshkaREcl++9l12TEk06snzZmGLE5fioILBSOwEY=;
 b=b3J89hja1jp/DvO7j0viSwulmsIcEkZeBgCM2wje7sZKjwKppWIZJipw
 4Mw04lMUUTjdKObGarvZh/GX86xqGx3dmkKKvksTmF9qAa/dnVkb0gdZz
 GsanAsXCNwhc1gMx0uSAu3vJWf+EM6ngte24ZP3CVOim7tT/G2UxxeVDr
 B5MRKOR7EiL4znto7c+BuxU70CYE/AKpYzjzTs9AFlCtg1rynBmpzMF/g
 4skF08bfKCowfl1RDwTp/42vW6u7KDde48GJD8xQfoPg5bwq6OsN4mxf1
 qww2ykY9gEhvPPSeTqAAJL1lgqFxqlry9gtu6T0v+efMc6yJlPugrWk+9 A==;
X-CSE-ConnectionGUID: jw+RcajRTj+HjotI4G5POQ==
X-CSE-MsgGUID: OL5dqWf6QuKHnJ8Wi5TmHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142639"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142639"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:05:56 -0800
X-CSE-ConnectionGUID: 8e0YFFBSR32Urk+LnN8yIA==
X-CSE-MsgGUID: AdMXHMP1TNeoXsUgtwF2ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537304"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:05:47 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org, kvm@vger.kernel.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Amit Shah <amit@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Helge Deller <deller@gmx.de>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Peter Krempa <pkrempa@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 12/28] hw/nvram/fw_cfg: Rename fw_cfg_init_mem_wide() ->
 fw_cfg_init_mem_dma()
Date: Wed,  3 Dec 2025 00:28:19 +0800
Message-Id: <20251202162835.3227894-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202162835.3227894-1-zhao1.liu@intel.com>
References: <20251202162835.3227894-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"wide" in fw_cfg_init_mem_wide() means "DMA support".
Rename for clarity.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v4:
 * Fix a missing case in hw/loongarch/fw_cfg.c.
---
 hw/arm/virt.c             | 2 +-
 hw/loongarch/fw_cfg.c     | 4 ++--
 hw/nvram/fw_cfg.c         | 6 +++---
 hw/riscv/virt.c           | 4 ++--
 include/hw/nvram/fw_cfg.h | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 25fb2bab5680..23d88e2fd014 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1412,7 +1412,7 @@ static FWCfgState *create_fw_cfg(const VirtMachineState *vms, AddressSpace *as)
     FWCfgState *fw_cfg;
     char *nodename;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16, as);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16, as);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     nodename = g_strdup_printf("/fw-cfg@%" PRIx64, base);
diff --git a/hw/loongarch/fw_cfg.c b/hw/loongarch/fw_cfg.c
index 493563669e5b..d2a79efbf767 100644
--- a/hw/loongarch/fw_cfg.c
+++ b/hw/loongarch/fw_cfg.c
@@ -23,8 +23,8 @@ FWCfgState *virt_fw_cfg_init(ram_addr_t ram_size, MachineState *ms)
     int max_cpus = ms->smp.max_cpus;
     int smp_cpus = ms->smp.cpus;
 
-    fw_cfg = fw_cfg_init_mem_wide(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
-                                  VIRT_FWCFG_BASE + 16, &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(VIRT_FWCFG_BASE + 8, VIRT_FWCFG_BASE, 8,
+                                 VIRT_FWCFG_BASE + 16, &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, (uint16_t)max_cpus);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)smp_cpus);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index c65deeb7c382..3f0d337eb9c5 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,9 +1088,9 @@ static FWCfgState *fw_cfg_init_mem_internal(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as)
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as)
 {
     assert(dma_addr && dma_as);
     return fw_cfg_init_mem_internal(ctl_addr, data_addr, data_width,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7ef..bfbb28f5bd26 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1274,8 +1274,8 @@ static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
 
-    fw_cfg = fw_cfg_init_mem_wide(base + 8, base, 8, base + 16,
-                                  &address_space_memory);
+    fw_cfg = fw_cfg_init_mem_dma(base + 8, base, 8, base + 16,
+                                 &address_space_memory);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, (uint16_t)ms->smp.cpus);
 
     return fw_cfg;
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d5161a794362..c4c49886754c 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -309,9 +309,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
 FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
                                   unsigned data_width);
-FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
-                                 hwaddr data_addr, uint32_t data_width,
-                                 hwaddr dma_addr, AddressSpace *dma_as);
+FWCfgState *fw_cfg_init_mem_dma(hwaddr ctl_addr,
+                                hwaddr data_addr, uint32_t data_width,
+                                hwaddr dma_addr, AddressSpace *dma_as);
 
 FWCfgState *fw_cfg_find(void);
 bool fw_cfg_dma_enabled(void *opaque);
-- 
2.34.1


