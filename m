Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EBBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1Sm-0001Oe-Sc; Thu, 08 May 2025 09:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1SY-00012X-El
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1SU-0003xE-Uo
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:38:46 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22e033a3a07so11452235ad.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711521; x=1747316321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePutPBZZqx13DDtsmzXUVgqQnJtyUKSO1VjVCMGLpvw=;
 b=DmQVI2BEN1CwGD+i3WIDfSUsucc1//Oy68U5bV5QWb39ZSXi10yYf7jLk+065ZiXbC
 LSOPdTefsDvChMpFLgXfwW4bPkSo3D98NjHY9178Tz+W7AQ+mQYXu69EX2lDytpb932v
 Gq66TonR93Xxj3zQHlfbtRwzGbUpLahR3KiDxp/mdNgryZY0p4O6HpTGg6rOrbIm+8WV
 pLrJe+YvcwP3k17IRAefYKlGhWNPlXkBw5DOc+PKoH4xc7/l5LPAh8hvA3XRRhBgKL1U
 TjOb4rXYdrCK8nNk+QCW93GhJGGGnxPOub9lqCSR82kRkqe2AzRcnD//PS+Vfk48bolr
 oL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711521; x=1747316321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePutPBZZqx13DDtsmzXUVgqQnJtyUKSO1VjVCMGLpvw=;
 b=kv5Hr+ejTZ7FGGGQmmlcH5EEb9tga7L8W24dQRvVETLTomdzVk7rJOwXNSKmGTtCTP
 GjTguMWX1xVu/z8ldd3aYQXBlZnxtHOp9HGfEqFKnlgDutleJz5gRKEGjvPOkqBamKiZ
 9EvDS02I2qVsgcdAbiN6oFery38470xqG71myhzidSLXS95JmdocwKkTFdB6Ie+B61Ka
 ZDv4bPiZLBQjMJ0uXvBcH7p3YRUGdVRUz1//QBxVrTXJ6xrNWr0Lg0n9eiuvsZI8Xn5z
 +vQ6VRIdy8halzAYOCaCFZJn0SRXSwSm8DA7V7jL7TpgoBzxAdflPDZcBj7ZE2jqLXsE
 Si5A==
X-Gm-Message-State: AOJu0YxDUyGypM1HlU2NP9/MWnP4KSnpTVEESAzW+F76pj/mARH47DuH
 75OIzaz/cE6jZAxVFl9mdrsIXReekk6B9s+naA9Qb4tknRcJG9Gb2hj5bz01jKwSk51nqvaE3bY
 JZ5CddA==
X-Gm-Gg: ASbGncthHxduQyBA/XvsLOI037GWLEPIxyHNQAhtvgVq4Nwq3XDapNXTeJyJN5DIyXH
 ety8BhoHyDa/jxBnAMxQV+z1yIQUsoNIP35RnAECQHVuuTmP+w+89UZfPP9xI+hPsX1KZH48L9t
 YkxbyMtdH0L0B3GFbth19eZAcq6Bn0HfENU+WvTPVRqog/TfNR1RD+MKUvpZUhfRWJw3bXVBT3O
 WZZijWL7AqPNGkdnKI3FBPiR7ozMgd/56JQ8krD2lSdrVJN4zwr7kEjDKemqtF0N6fKPY9zddS3
 ngJefJoiiLnUGYXvtH15bZapHJZdYSxTnm+5I/jEYL65AOSyrWVJWgoV8MyWPmcJU3Q8W962M7Q
 Ulhl0mgEZh8ZyeE4=
X-Google-Smtp-Source: AGHT+IGNgxOPLiTzh1fGobc2t1F5+RIKAiji7b9B9I1DfVv+yb0iKtesoZBDvhr0nJNnujewbvszoQ==
X-Received: by 2002:a17:903:32c1:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-22e5ecab7c3mr113369565ad.42.1746711521068; 
 Thu, 08 May 2025 06:38:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e4299618esm51501905ad.198.2025.05.08.06.38.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:38:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 07/27] hw/i386/x86: Remove
 X86MachineClass::fwcfg_dma_enabled field
Date: Thu,  8 May 2025 15:35:30 +0200
Message-ID: <20250508133550.81391-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The X86MachineClass::fwcfg_dma_enabled boolean was only used
by the pc-q35-2.6 and pc-i440fx-2.6 machines, which got
removed. Remove it and simplify.

'multiboot.bin' isn't used anymore, we'll remove it in the
next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 2 --
 hw/i386/microvm.c     | 3 ---
 hw/i386/multiboot.c   | 7 +------
 hw/i386/x86-common.c  | 3 +--
 hw/i386/x86.c         | 2 --
 5 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index fc460b82f82..29d37af11e6 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -29,8 +29,6 @@
 struct X86MachineClass {
     MachineClass parent;
 
-    /* use DMA capable linuxboot option rom */
-    bool fwcfg_dma_enabled;
     /* CPU and apic information: */
     bool apic_xrupt_override;
 };
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e0daf0d4fc3..b1262fb1523 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -637,7 +637,6 @@ GlobalProperty microvm_properties[] = {
 
 static void microvm_class_init(ObjectClass *oc, const void *data)
 {
-    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
@@ -671,8 +670,6 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
     hc->unplug_request = microvm_device_unplug_request_cb;
     hc->unplug = microvm_device_unplug_cb;
 
-    x86mc->fwcfg_dma_enabled = true;
-
     object_class_property_add(oc, MICROVM_MACHINE_RTC, "OnOffAuto",
                               microvm_machine_get_rtc,
                               microvm_machine_set_rtc,
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 6e6b96bc345..bfa7e8f1e83 100644
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
index 1b0671c5239..27254a0e9f1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -634,7 +634,6 @@ void x86_load_linux(X86MachineState *x86ms,
                     int acpi_data_size,
                     bool pvh_enabled)
 {
-    bool linuxboot_dma_enabled = X86_MACHINE_GET_CLASS(x86ms)->fwcfg_dma_enabled;
     uint16_t protocol;
     int setup_size, kernel_size, cmdline_size;
     int dtb_size, setup_data_offset;
@@ -993,7 +992,7 @@ void x86_load_linux(X86MachineState *x86ms,
 
     option_rom[nb_option_roms].bootindex = 0;
     option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (linuxboot_dma_enabled && fw_cfg_dma_enabled(fw_cfg)) {
+    if (fw_cfg_dma_enabled(fw_cfg)) {
         option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     }
     nb_option_roms++;
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index f80533df1c5..dbf104d60af 100644
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
-- 
2.47.1


