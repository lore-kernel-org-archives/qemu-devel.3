Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFB4D11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQStx-0008Ry-4Q; Tue, 02 Dec 2025 11:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQStF-0006MA-NW; Tue, 02 Dec 2025 11:06:14 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vQStD-0007EB-5q; Tue, 02 Dec 2025 11:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764691567; x=1796227567;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+z5nIoH78wA+yFYRCQXaohR6ZmUY0zV8s02/chMIeGk=;
 b=ee8+27flE6g1SPQGNm2YlN3+KUVqdcBxnr32FFOpLDz3pgXlV88KxyCH
 5WCUhvxLymc/M06zWnOBPUw2phqDs5Shrbu+Z1k0nhlM2EHjtCzsu0aM4
 KolMbmr3VLSiuO9fq89MPwJoQZsqPECPVpRK5T2u7c4TUH61BKyEVM1/s
 i+R43z0JNUFBEOk+py2ZHheJQmXR3LsD6TfhczCuHiUC7/Rs9352dK5aT
 IgmbfgAA4+eU//0CX+L4z7fYM2yMy/+c8J3lT5IEsOAhzaFI/Dw0ux6Nt
 IOmoCdZ4W7J/VKxxPJCfaWzDs8/bkaSHjgNHl2d1zUbabfFx0/4H4P9vH A==;
X-CSE-ConnectionGUID: fhBievr3QnCvh878M2/pOQ==
X-CSE-MsgGUID: y4dVYOOWTBqGSyS330VBog==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="92142667"
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="92142667"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 08:06:05 -0800
X-CSE-ConnectionGUID: YspVYPo2RVu6Bh2S79YSnw==
X-CSE-MsgGUID: KQtfBojEQcaBf/c83+ZLeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,243,1758610800"; d="scan'208";a="199537367"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 02 Dec 2025 08:05:56 -0800
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
Subject: [PATCH v5 13/28] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Date: Wed,  3 Dec 2025 00:28:20 +0800
Message-Id: <20251202162835.3227894-14-zhao1.liu@intel.com>
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

The X86MachineClass::fwcfg_dma_enabled boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify.

'multiboot.bin' isn't used anymore, we'll remove it in the
next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/microvm.c     | 3 ---
 hw/i386/multiboot.c   | 7 +------
 hw/i386/x86-common.c  | 3 +--
 hw/i386/x86.c         | 2 --
 include/hw/i386/x86.h | 2 --
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 94d22a232aca..812f2ac2f983 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -640,7 +640,6 @@ GlobalProperty microvm_properties[] = {
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
 {
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
@@ -674,8 +673,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    x86mc->fwcfg_dma_enabled = true;
-
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 78690781b74c..3b993126edb6 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -153,7 +153,6 @@ int load_multiboot(X86MachineState *x86ms,
                    int kernel_file_size,
                    uint8_t *header)
 {
-    bool multiboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     int i, is_multiboot = 0;
     uint32_t flags = 0;
     uint32_t mh_entry_addr;
@@ -402,11 +401,7 @@ int load_multiboot(X86MachineState *x86ms,
     fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, mb_bootinfo_data,
                      sizeof(bootinfo));
 
-    if (multiboot_dma_enabled) {
-        option_rom[nb_option_roms].name = "multiboot_dma.bin";
-    } else {
-        option_rom[nb_option_roms].name = "multiboot.bin";
-    }
+    option_rom[nb_option_roms].name = "multiboot_dma.bin";
     option_rom[nb_option_roms].bootindex = 0;
     nb_option_roms++;
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 60b7ab80433a..1ee55382dab8 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -645,7 +645,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     int acpi_data_size,
                     bool pvh_enabled)
 {
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
     int dtb_size, setup_data_offset;
@@ -1004,7 +1003,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f80533df1c54..dbf104d60af4 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -375,14 +375,12 @@ static void x86_machine_initfn(Object *obj)
 static void x86_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
 
     object_class_property_add(oc, X86_MACHINE_SMM, "OnOffAuto",
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 8755cad50a36..201eee80eb73 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -30,8 +30,6 @@
 struct X86MachineClass {
     MachineClass parent;
 
-    /* use DMA capable linuxboot option rom */
-    bool fwcfg_dma_enabled;
     /* CPU and apic information: */
     bool apic_xrupt_override;
 };
-- 
2.34.1


