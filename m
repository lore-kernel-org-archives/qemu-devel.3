Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DB1C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctz3-0007nD-Nv; Wed, 21 Feb 2024 16:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyy-0007GL-M3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctyw-00017z-0c
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:18:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4126f48411dso1366555e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550300; x=1709155100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbWaENVXrPEDOnkXsgR9cEbYG3NY0XwtRW+JhFfX4HQ=;
 b=h68HLyehp/sb1F348DsrxBHvI+gwHeXPYbxRRPQyGc2Cp7tibkHTL95Yslhije+exx
 vp85F7ZfldhmcK4J9ZKRvJR6sQnCpRWM19O5rXiciGDZ/y7zctc51nywtAt8wJb2ZKCA
 Z2/rK9ZhNJ2w5lMvpw7sXBMTuAXsanmMM4rHQd6bMVsT6P7EdFaVJ8tNSVh0zJlZCeS+
 tPm7B1l5v+85Tdj68hh73BoVz8TXpudVzwrZbi010556OY8N/pTY6DC4X7UAkY1TvEh7
 H/4nw3GY43QN6YJzWcxBYLKRBh14/5UtYymgQUl6fmFP7ITjPujldOwYDoulInw5ogW1
 ZWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550300; x=1709155100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbWaENVXrPEDOnkXsgR9cEbYG3NY0XwtRW+JhFfX4HQ=;
 b=eAJsnIGYyf1jx9VBIZGq0IaKMcgoMH+lVQ87i4FIxidbitzjYTgg29MRboH8PNDoLd
 M+70iKFlNUD1c2rp9zH04GsnBme9A2ghcASYaKXs5K2iKbrzOn8r2lWnsaIr99710KJU
 CSMJKf/qSGSpU53cUa526r61uTXndFVa9QMvkvvCIfWjI+16h55ERq9Zju3sanAbHHcg
 cQNRwumy1PUDLZJUHlFANEDvmzJkzGBbHA3pilhtG5m2UnEfT+eVD9SjUnqrodcyX+XR
 FYCmE45+AMeOe84iLH66Nqx7l9Sl01U2eUe6nn1bFVhqT/CEIzizT0D9TOonswcor2r6
 5ucA==
X-Gm-Message-State: AOJu0YwjzQIrBPVLayJnXmSocaRaHLqKL6ql7BfH9PQOOdEJo371rsLH
 LI9c80WCFCzly5cuWzBJ74vtvVs9IOz9aH5bR5mzJBZIMM26e+680kZinP7XtVXZBzp04OwjnpT
 5Wus=
X-Google-Smtp-Source: AGHT+IF0jNEPnhSUj95rWqtZjH+AbQriP9iNbGmANFZLQa84Bbg3OPddEHv7yeTpnf1HLGCm4/u+Cw==
X-Received: by 2002:a05:600c:6029:b0:412:6e83:b89d with SMTP id
 az41-20020a05600c602900b004126e83b89dmr603451wmb.8.1708550300263; 
 Wed, 21 Feb 2024 13:18:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a5d6a02000000b0033d071c0477sm17903145wru.59.2024.02.21.13.18.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:18:19 -0800 (PST)
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
Subject: [PULL 14/25] hw/i386/pc: Confine system flash handling to pc_sysfw
Date: Wed, 21 Feb 2024 22:16:14 +0100
Message-ID: <20240221211626.48190-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Rather than distributing PC system flash handling across three files, let's
confine it to one. Now, pc_system_firmware_init() creates, configures and cleans
up the system flash which makes the code easier to understand. It also avoids
the extra call to pc_system_flash_cleanup_unused() in the Xen case.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240208220349.4948-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 2 --
 hw/i386/pc.c         | 1 -
 hw/i386/pc_piix.c    | 1 -
 hw/i386/pc_sysfw.c   | 6 ++++--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0a8a96600c..e8f4af5d5c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -193,8 +193,6 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 #define TYPE_PORT92 "port92"
 
 /* pc_sysfw.c */
-void pc_system_flash_create(PCMachineState *pcms);
-void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 bool pc_system_ovmf_table_find(const char *entry, uint8_t **data,
                                int *data_len);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e526498164..1ee41a5e56 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1733,7 +1733,6 @@ static void pc_machine_initfn(Object *obj)
 #endif
     pcms->default_bus_bypass_iommu = false;
 
-    pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 34203927e1..ec7c07b362 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -231,7 +231,6 @@ static void pc_init1(MachineState *machine,
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
 
-        pc_system_flash_cleanup_unused(pcms);
         if (machine->kernel_filename != NULL) {
             /* For xen HVM direct kernel boot, load linux here */
             xen_load_linux(pcms);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c8d9e71b88..b4c3833352 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -91,7 +91,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
     return PFLASH_CFI01(dev);
 }
 
-void pc_system_flash_create(PCMachineState *pcms)
+static void pc_system_flash_create(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
 
@@ -103,7 +103,7 @@ void pc_system_flash_create(PCMachineState *pcms)
     }
 }
 
-void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
@@ -212,6 +212,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
         return;
     }
 
+    pc_system_flash_create(pcms);
+
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
         pflash_cfi01_legacy_drive(pcms->flash[i],
-- 
2.41.0


