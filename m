Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC5C25B5F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lO1-0003et-QQ; Wed, 08 May 2024 13:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNi-0003Ih-7e
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:11 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4lNf-0000MI-IR
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:47:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so3029566b.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715190421; x=1715795221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GB+h+ullzzmv/KusE/p+zIoKaJmtmVB+MJSh/BqOlQ=;
 b=xhCjbhfQMOd5Kh/KTNe470oSdjn6NOM5vycnXCxnbQoIFlIlcp+/QTsYjD29DjqE+l
 VJfq+0tXMwTYndvbHz3s6pnKr7eFqC+Ctr2bE3lFBJc3pnsoqxB6dIMAJGgfpzpDHh1F
 2zcl+vuw8NzC1XU/8NsHbFd6bA8/1l4z0TSJu7BJzu6zEd+sLfGPJTINpr0X3DkJ+pxl
 9Q++49KEGRrXI6asUGmdRxEFyOw9kwSwlANhSifSphttQ0rgRMeWPKJaCBQfwgaCmIAT
 didCguShYf+26hh8njCrNUQPgRYbiboKQyoo8yh2NeEItehWyMiu9rSvOJL2YOUurjs3
 ZTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190421; x=1715795221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GB+h+ullzzmv/KusE/p+zIoKaJmtmVB+MJSh/BqOlQ=;
 b=Nh1mvm0vJSfxJ8fp5XfSKPFDRBdnRz5p7yNLdYaK2AOoiXK+T0GSh8oK56wy61SmJa
 meF+RPi6plRTbQ0gUuy3ovMCu8RAWmPl7ndyDSKm04ZpYQwa+z0wwnd21fJcnb0tBC1V
 QGIajFTn9ZbNVnRYDwYI4gHpOF4XhxBcIYIO9xU662C24rmVRI8p1bcfyF7Qvxhz4a78
 WO6lm5eEo5rq+nmfo+taMIIjQTLkvkEPwvM1oMMZvdTgMsr0hqhl16fA69Si7pGJ6wdC
 0mOCPVxsZHUmq8jxe3X6d+6TLcYM2ZUD0pIGpsqZoWvu0Xju28BaJhafpJbwFa6VckEq
 hx0g==
X-Gm-Message-State: AOJu0YwJARG06+Vq4G6kyAQTYaOd3LDYTCNo7s/lcRAAkM7UGxDg+1wt
 b4NPeM6fikuqscFoAVM1d2V/B1o9wvtsNJXlcSM/6JSL4nLXzGckmdwec8jBFwQhVD746nQtk6w
 G
X-Google-Smtp-Source: AGHT+IHD3AUgd/CcL/KThcp3J38xByXFF0SSiYjuImQ6QSdaui9gYytUxySob8FqbtGR9gPqG3thNA==
X-Received: by 2002:a17:906:c4d:b0:a59:c23d:85d6 with SMTP id
 a640c23a62f3a-a59fb9db269mr192493866b.57.1715190421535; 
 Wed, 08 May 2024 10:47:01 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 ww1-20020a170907084100b00a59cb8c93f3sm4177010ejb.58.2024.05.08.10.47.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 May 2024 10:47:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/26] hw/loongarch: Rename LOONGARCH_MACHINE with
 LOONGARCH_VIRT_MACHINE
Date: Wed,  8 May 2024 19:45:04 +0200
Message-ID: <20240508174510.60470-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240508174510.60470-1-philmd@linaro.org>
References: <20240508174510.60470-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch system, there is only virt machine type now, name
LOONGARCH_MACHINE is confused, rename it with LOONGARCH_VIRT_MACHINE.
Machine name about Other real hw boards can be added in future.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240508031110.2507477-2-maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loongarch/virt.h |  4 ++--
 hw/loongarch/acpi-build.c   |  8 ++++----
 hw/loongarch/boot.c         |  2 +-
 hw/loongarch/virt.c         | 19 +++++++++----------
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index fdbd2b146f..5b1416d7bc 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -63,8 +63,8 @@ struct LoongArchMachineState {
     struct loongarch_boot_info bootinfo;
 };
 
-#define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
+#define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
+OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_VIRT_MACHINE)
 bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
 void loongarch_acpi_setup(LoongArchMachineState *lams);
 #endif
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index e5ab1080af..c7150cc0c4 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -167,7 +167,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     int i, arch_id, node_id;
     uint64_t mem_len, mem_base;
     int nb_numa_nodes = machine->numa_state->num_nodes;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
     AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
@@ -279,7 +279,7 @@ static void
 build_la_ged_aml(Aml *dsdt, MachineState *machine)
 {
     uint32_t event;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
 
     build_ged_aml(dsdt, "\\_SB."GED_DEVICE,
                   HOTPLUG_HANDLER(lams->acpi_ged),
@@ -391,7 +391,7 @@ static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     Aml *dsdt, *scope, *pkg;
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
     AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lams->oem_id,
                         .oem_table_id = lams->oem_table_id };
 
@@ -421,7 +421,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
 static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
     GArray *table_offsets;
     AcpiFadtData fadt_data;
     unsigned facs, rsdt, dsdt;
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 03f6301a77..e37512729d 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -319,7 +319,7 @@ static void loongarch_direct_kernel_boot(struct loongarch_boot_info *info)
 
 void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(ms);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(ms);
     int i;
 
     /* register reset function */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 69924a8734..d7de80baf8 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -877,7 +877,7 @@ static void loongarch_init(MachineState *machine)
     ram_addr_t ram_size = machine->ram_size;
     uint64_t highram_size = 0, phyAddr = 0;
     MemoryRegion *address_space_mem = get_system_memory();
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(machine);
     int nb_numa_nodes = machine->numa_state->num_nodes;
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
@@ -1028,7 +1028,7 @@ bool loongarch_is_acpi_enabled(LoongArchMachineState *lams)
 static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
     OnOffAuto acpi = lams->acpi;
 
     visit_type_OnOffAuto(v, name, &acpi, errp);
@@ -1037,14 +1037,14 @@ static void loongarch_get_acpi(Object *obj, Visitor *v, const char *name,
 static void loongarch_set_acpi(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
 
     visit_type_OnOffAuto(v, name, &lams->acpi, errp);
 }
 
 static void loongarch_machine_initfn(Object *obj)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(obj);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(obj);
 
     lams->acpi = ON_OFF_AUTO_AUTO;
     lams->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
@@ -1076,7 +1076,7 @@ static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
     /* the acpi ged is always exist */
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(lams->acpi_ged), dev,
@@ -1094,7 +1094,7 @@ static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
 static void virt_mem_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
     hotplug_handler_unplug(HOTPLUG_HANDLER(lams->acpi_ged), dev, errp);
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(lams));
@@ -1112,7 +1112,7 @@ static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
 static void virt_mem_plug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
 
     pc_dimm_plug(PC_DIMM(dev), MACHINE(lams));
     hotplug_handler_plug(HOTPLUG_HANDLER(lams->acpi_ged),
@@ -1122,7 +1122,7 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
-    LoongArchMachineState *lams = LOONGARCH_MACHINE(hotplug_dev);
+    LoongArchMachineState *lams = LOONGARCH_VIRT_MACHINE(hotplug_dev);
     MachineClass *mc = MACHINE_GET_CLASS(lams);
 
     if (device_is_dynamic_sysbus(mc, dev)) {
@@ -1204,7 +1204,6 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
-    mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
     mc->default_ram_size = 1 * GiB;
     mc->default_cpu_type = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1241,7 +1240,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo loongarch_machine_types[] = {
     {
-        .name           = TYPE_LOONGARCH_MACHINE,
+        .name           = TYPE_LOONGARCH_VIRT_MACHINE,
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(LoongArchMachineState),
         .class_init     = loongarch_class_init,
-- 
2.41.0


