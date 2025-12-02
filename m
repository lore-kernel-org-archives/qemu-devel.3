Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD3D11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSth-00077Y-Et; Tue, 02 Dec 2025 11:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSsh-0005lQ-HL; Tue, 02 Dec 2025 11:05:35 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQSse-0006YS-02; Tue, 02 Dec 2025 11:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691532; x=1796227532;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ychCVbqR9+MH7IrFfMWxLP9JiDk1K/Y5IPVoZNfBoew=;
 b=NDJCRj3UWnEI5aY8UtZ2MzOgXNmQ3emKDPnjk6h22x+VpqktsbCUHnGA
 ooQ6vEdoCjHUbIHLEEreZvwGnzha+iQLWWGG430uvKX/a4qVF4g4Jiw1e
 ld08SEu1jDG2L7Q5Ha3dHreppVrrTYya17ZEXrI6m7fBAfONVzYWe7FR8
 M375ZeeKxN9HPi/MnWJuyLX15wNCIdqo15iRXNpDdDe/nGlCc745EQEaq
 fTs9B/oiVus+XmxhzUHUuZYHeSl/sagStXiHB6AvMg0pH1FU98Zt2yPnF
 vMdlyGHhKOaUxgR+W/F2ZilTm2OrPH+t68+NWZ5bLaxUywe3MSu2B7UK0 w==;
X-CSE-ConnectionGUID: NilV3TTPQ4+h3Xi7rMWJWw==
X-CSE-MsgGUID: plqdc64xSiuf/TMREgtaOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142527"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142527"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:05:29 -0800
X-CSE-ConnectionGUID: FgXYYBQPSF+kJ0OVXIKTnw==
X-CSE-MsgGUID: RAVfP1jBRPi0louUYc/Tcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537198"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:05:20 -0800
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
Subject: [PATCH v5 09/28] hw/nvram/fw_cfg: Rename fw_cfg_init_mem() with
 '_nodma' suffix
Date: Wed,  3 Dec 2025 00:28:16 +0800
Message-Id: <20251202162835.3227894-10-zhao1.liu@intel.com>
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

Rename fw_cfg_init_mem() as fw_cfg_init_mem_nodma()
to distinct with the DMA version (currently named
fw_cfg_init_mem_wide).

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/hppa/machine.c         | 2 +-
 hw/nvram/fw_cfg.c         | 7 +++----
 include/hw/nvram/fw_cfg.h | 3 ++-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8c66eed5a269..479fbf25b9ac 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -208,7 +208,7 @@ static FWCfgState *create_fw_cfg(MachineState *ms, PCIBus *pci_bus,
     int btlb_entries = HPPA_BTLB_ENTRIES(&cpu[0]->env);
     int len;
 
-    fw_cfg = fw_cfg_init_mem(addr, addr + 4);
+    fw_cfg = fw_cfg_init_mem_nodma(addr, addr + 4, 1);
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index aa240504935b..2b8715679fe7 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1088,11 +1088,10 @@ FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
     return s;
 }
 
-FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr)
+FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
+                                  unsigned data_width)
 {
-    return fw_cfg_init_mem_wide(ctl_addr, data_addr,
-                                fw_cfg_data_mem_ops.valid.max_access_size,
-                                0, NULL);
+    return fw_cfg_init_mem_wide(ctl_addr, data_addr, data_width, 0, NULL);
 }
 
 
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index d41b9328fd13..d5161a794362 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -307,7 +307,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
 
 FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
                                 AddressSpace *dma_as);
-FWCfgState *fw_cfg_init_mem(hwaddr ctl_addr, hwaddr data_addr);
+FWCfgState *fw_cfg_init_mem_nodma(hwaddr ctl_addr, hwaddr data_addr,
+                                  unsigned data_width);
 FWCfgState *fw_cfg_init_mem_wide(hwaddr ctl_addr,
                                  hwaddr data_addr, uint32_t data_width,
                                  hwaddr dma_addr, AddressSpace *dma_as);
-- 
2.34.1


