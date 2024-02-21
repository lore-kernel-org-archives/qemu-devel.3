Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E648C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctym-0005zz-Jh; Wed, 21 Feb 2024 16:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyi-0005Tt-1p
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:08 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyf-000145-6g
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:07 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d09cf00214so80603461fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550283; x=1709155083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1hBOWCBa8Kc+AFXTCFEtySegdqlIvAldt191B4hj40=;
 b=bxlRPqzIWBooO6TMuH4aztPfAbHTT1axJyOtQibOOq8zFfeY2ppC9KmFb41u2P8Skl
 cpxXphpQlh7QKvdlFyxhat7g+/6Ayxr2JYGpKqAirG+2yHXRuyE2+6ZvH8PTjqzW5SVL
 58RcIJX8QeExsFrpp/+Z2oU6o5rGyx+T56X5nwgWcntoMZybbD9vvyljH8xIQN8wqwiE
 WDyY0qoqXSr6K+oJLkaaqOG4fST0y9dupmergl2sjpvrAnvcAMtl+n25u5A0YVIZZoVs
 u1Rm3jouQ1qjubnfnPlw8wgUY8joBDwqBzMqnOn9Amy53OH/bq4vYIlcnIX1hCz0H6Ka
 BY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550283; x=1709155083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1hBOWCBa8Kc+AFXTCFEtySegdqlIvAldt191B4hj40=;
 b=SYrPi21cGCpi3qfucxu9gxcb0OEyzkPvFoXhTBYMrWoaqBFVVDUyfH+xfSmK4/8K8x
 dJN0r+ucpumKVr285cJliMsL4rwdeIw5TWN9gxBa+RniagEaVHV0eG8c+muFx3o/RkeW
 zuZ66bG4V9J1DMjzvyuGU2YxThqE9wtI8ub9Liq0Zw7oA90fiaikbHfj76VtRyRPp6On
 aOgA4QZ65z+1kZ14qDlwj/KmKVFJe6fTT11jA4QdK7HS7UaCrvIJQAAzoGrnpXl6w6sP
 FhBdA3E9/KybEKkgEmXhcu94OAYCec7v0W4t9Hr9nBRdCDIA47Rk5azuGnSSkqCaLCHk
 wBtg==
X-Gm-Message-State: AOJu0YwE1d8w26vWNqZY5NmVGgqGnM8VwVTuMKusCUV+bj6f7ek340Js
 5OhnA8dVIhCz+6kv56GU7oD9xigOrv7N3wwJ9fy/OgrU/Sm3qBi9HkbMKc9y3r5MZFgDVhv+UeS
 jTCM=
X-Google-Smtp-Source: AGHT+IHSG+pVEm0escvoviBrtWNCskYg/LSnL+6r2RE2xQq+i7M8kTlUrrZwIAJxSgajDZ6FAjv36A==
X-Received: by 2002:a05:651c:1543:b0:2d2:47e0:4427 with SMTP id
 y3-20020a05651c154300b002d247e04427mr4972111ljp.41.1708550283044; 
 Wed, 21 Feb 2024 13:18:03 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a05600c198b00b0041270c2b95esm5969210wmq.29.2024.02.21.13.18.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 11/25] hw/i386/x86: Turn apic_xrupt_override into class
 attribute
Date: Wed, 21 Feb 2024 22:16:11 +0100
Message-ID: <20240221211626.48190-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

The attribute isn't user-changeable and only true for pc-based machines. Turn it
into a class attribute which allows for inlining pc_guest_info_init() into
pc_machine_initfn().

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/x86.h | 3 ++-
 hw/i386/acpi-common.c | 3 ++-
 hw/i386/pc.c          | 5 ++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index da19ae1546..8e306db7bb 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -34,6 +34,8 @@ struct X86MachineClass {
     bool save_tsc_khz;
     /* use DMA capable linuxboot option rom */
     bool fwcfg_dma_enabled;
+    /* CPU and apic information: */
+    bool apic_xrupt_override;
 };
 
 struct X86MachineState {
@@ -57,7 +59,6 @@ struct X86MachineState {
     uint64_t above_4g_mem_start;
 
     /* CPU and apic information: */
-    bool apic_xrupt_override;
     unsigned pci_irq_mask;
     unsigned apic_id_limit;
     uint16_t boot_cpus;
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 43dc23f7e0..cea4b3d71c 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -100,6 +100,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     int i;
     bool x2apic_mode = false;
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
+    X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
@@ -122,7 +123,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      IO_APIC_SECONDARY_ADDRESS, IO_APIC_SECONDARY_IRQBASE);
     }
 
-    if (x86ms->apic_xrupt_override) {
+    if (x86mc->apic_xrupt_override) {
         build_xrupt_override(table_data, 0, 2,
             0 /* Flags: Conforms to the specifications of the bus */);
     }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 1733dffc00..d7183780bd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -700,9 +700,6 @@ void pc_machine_done(Notifier *notifier, void *data)
 
 void pc_guest_info_init(PCMachineState *pcms)
 {
-    X86MachineState *x86ms = X86_MACHINE(pcms);
-
-    x86ms->apic_xrupt_override = true;
     pcms->machine_done.notify = pc_machine_done;
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
@@ -1795,6 +1792,7 @@ static bool pc_hotplug_allowed(MachineState *ms, DeviceState *dev, Error **errp)
 static void pc_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    X86MachineClass *x86mc = X86_MACHINE_CLASS(oc);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
@@ -1814,6 +1812,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     pcmc->resizable_acpi_blob = true;
+    x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
     mc->hotplug_allowed = pc_hotplug_allowed;
-- 
2.41.0


