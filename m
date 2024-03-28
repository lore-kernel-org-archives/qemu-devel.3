Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02971CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps7c-0005A6-Sf; Thu, 28 Mar 2024 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps7D-0004Rf-UL
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:35 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps79-0002Qm-MC
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:56:30 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-513e6777af4so1700851e87.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641383; x=1712246183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YADozrynE6WAolQE0PpJsPO9+XRuTB0w7hXGd8JOVMk=;
 b=bNgcRPVC1lAOCjQ3ZlTPi4Rvg7x9ZYCxsNS9xHm8EtSjXq5pBEugDnEORT0gIM+jLz
 BWwy1RBcbJxvV7INgHFththJF4onONnPSJj4Hg+6l/sSUj0o6bsSg1j7PhR81sIN6THG
 GAjdctwf6BaQiwpdrKEBu5CBL+H9qYm1s59t0UE5nH/q7ZOBysCHhMtsZ+EHzhysYL2K
 7ooQuBXIuoOSfjyPucuzszDAuwHIDznaIm5VCKvrxqAkZocwdhl+l5BsdNZzvz7hZPue
 JFCEGhkBb/4+0aS4QVQrBaZU7mYx0lLUbDjTjlU/w4cms1D2a7x8UVxSCms9OT5EC2zs
 VD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641383; x=1712246183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YADozrynE6WAolQE0PpJsPO9+XRuTB0w7hXGd8JOVMk=;
 b=vvhRIsEN6bgNDKIwI9mnrrgjJEc9iDbaxWo/7RE6OM76KlyOHyXxg6ElsB7ISpjPFp
 /stUoElYHMufpDfG4zOF25U42ZHwmx6fWIivKHitSQ2V7cgaxE9em34S3ekYLHVEOhoY
 YeG18J7DtafZW6dtQfTY5lJFHjOOdVB5r1S5qqtSRfudSPerLzWuTISKcMNNzSog05k8
 dEvJwHw8PYeiGqrFgYsphXsY+fUuq5SFUBq2WDDMov8V002g4VM7LDmUfkWDXnfgkiqj
 JKp+4ND8y3bgkpMXgwpy3eNoPFOcMs2YyWucpQZZ+4Zg+lGWv0Gl9hw1kwxghHfpFhEr
 rWwQ==
X-Gm-Message-State: AOJu0Yw9YZn0qieKd9/zQXp5gOAfv17O0HNtQ6cwWMcLuzJj3qfrgiUy
 YuBirRvoE1hUmadBV2xGjHr7bekxwcgcUA40Nz8qmjrG/4Pa8UjSVv8Ss27k7JB2f/o1KdJYPMY
 u
X-Google-Smtp-Source: AGHT+IFET2qLkxCYJlLAe5wqUF2LJxJCZxdIrO9Tbo3cYr9nsR7BCDgXHuGLT1xPB8OJyuTlfGMDhg==
X-Received: by 2002:a05:6512:78f:b0:513:e643:cd12 with SMTP id
 x15-20020a056512078f00b00513e643cd12mr2537328lfr.26.1711641383341; 
 Thu, 28 Mar 2024 08:56:23 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 i23-20020a170906265700b00a4749a1de50sm911948ejc.176.2024.03.28.08.56.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:56:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 16/29] hw/i386/pc: Move south-bridge related
 fields to PcPciMachine
Date: Thu, 28 Mar 2024 16:54:24 +0100
Message-ID: <20240328155439.58719-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
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

South bridge type is only relevant for the i440fx/piix
machine, which is PCI-based.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  8 ++++----
 hw/i386/pc.c         |  3 ++-
 hw/i386/pc_piix.c    | 12 ++++++------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 668347c248..2db2aa03d3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,7 +38,6 @@ typedef struct PCMachineState {
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
     SmbiosEntryPointType smbios_entry_point_type;
-    const char *south_bridge;
 
     bool smbus_enabled;
     bool sata_enabled;
@@ -59,6 +58,7 @@ typedef struct PcPciMachineState {
     Notifier machine_done;
 
     bool acpi_build_enabled;
+    const char *southbridge_typename;
     uint64_t max_fw_size;
 
     PFlashCFI01 *flash[2];
@@ -88,9 +88,6 @@ typedef struct PcPciMachineState {
 typedef struct PCMachineClass {
     X86MachineClass parent_class;
 
-    /* Device configuration: */
-    const char *default_south_bridge;
-
     /* Compat options: */
 
     /* Default CPU model version.  See x86_cpu_set_default_version(). */
@@ -126,6 +123,9 @@ typedef struct PCMachineClass {
 typedef struct PcPciMachineClass {
     PCMachineClass parent_class;
 
+    /* Device configuration: */
+    const char *default_southbridge_typename;
+
     /* ACPI compat: */
     int pci_root_uid;
 } PcPciMachineClass;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5753a3ff0b..dd44df0470 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1667,7 +1667,6 @@ static void pc_machine_initfn(Object *obj)
 #endif /* CONFIG_VMPORT */
     pcms->max_ram_below_4g = 0; /* use default */
     pcms->smbios_entry_point_type = pcmc->default_smbios_ep_type;
-    pcms->south_bridge = pcmc->default_south_bridge;
 
     pcms->smbus_enabled = true;
     pcms->sata_enabled = true;
@@ -1689,9 +1688,11 @@ static void pc_machine_initfn(Object *obj)
 static void pc_pci_machine_initfn(Object *obj)
 {
     PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
+    PcPciMachineClass *ppmc = PC_PCI_MACHINE_GET_CLASS(ppms);
 
     ppms->acpi_build_enabled = true;
     ppms->max_fw_size = 8 * MiB;
+    ppms->southbridge_typename = ppmc->default_southbridge_typename;
 
     pc_system_flash_create(ppms);
     cxl_machine_init(obj, &ppms->cxl_devices_state);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6b3403d0bd..2043a7022a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -243,7 +243,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         DeviceState *dev;
         size_t i;
 
-        pci_dev = pci_new_multifunction(-1, pcms->south_bridge);
+        pci_dev = pci_new_multifunction(-1, ppms->southbridge_typename);
         object_property_set_bool(OBJECT(pci_dev), "has-usb",
                                  machine_usb(machine), &error_abort);
         object_property_set_bool(OBJECT(pci_dev), "has-acpi",
@@ -385,12 +385,12 @@ static const QEnumLookup PCSouthBridgeOption_lookup = {
 
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(obj);
+    PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
     int i;
 
     for (i = 0; i < PCSouthBridgeOption_lookup.size; i++) {
         if (g_strcmp0(PCSouthBridgeOption_lookup.array[i],
-                      pcms->south_bridge) == 0) {
+                      ppms->southbridge_typename) == 0) {
             return i;
         }
     }
@@ -401,7 +401,7 @@ static int pc_get_south_bridge(Object *obj, Error **errp)
 
 static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(obj);
+    PcPciMachineState *ppms = PC_PCI_MACHINE(obj);
 
     if (value < 0) {
         error_setg(errp, "Value can't be negative");
@@ -413,7 +413,7 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
         return;
     }
 
-    pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
+    ppms->southbridge_typename = PCSouthBridgeOption_lookup.array[value];
 }
 
 /* Looking for a pc_compat_2_4() function? It doesn't exist.
@@ -472,7 +472,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     PcPciMachineClass *ppmc = PC_PCI_MACHINE_CLASS(m);
     ObjectClass *oc = OBJECT_CLASS(m);
 
-    pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
+    ppmc->default_southbridge_typename = TYPE_PIIX3_DEVICE;
     ppmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
-- 
2.41.0


