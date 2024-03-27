Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB019C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 09:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPxf-00050v-0o; Wed, 27 Mar 2024 05:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxd-0004xN-C5
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:45 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPxa-0006rK-C9
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:52:45 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a466a27d30aso799594766b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533161; x=1712137961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS+v/eLxATnG0O4x0k9d/m89qYtDW6sLXZHCB+9mUOM=;
 b=jdQBZRnOkpJ8/r4tBy+y31qMhhw/Qd8zOrxk5Dl7CvjavlM5srxochgjV1prS8gLKP
 t3mCsoYKyOqf/ieytxrA7jwoJ2gayui9zIqukuxOspf4s4bIqyNPUKPqu8n3+NSOhrQ6
 /VwVttCMA4QcSRx08WlqJ+ogTqR9O8dyI1a0xBP6+k0bkKENSmJUshDEs99TzjEXhuQb
 4q/szYbSA3XcJyQYMyPXHueRv5cRsHx40k7WbKyKGfhpuwFfUkW1WhUdfOvpl4zcSIph
 NScH8h9D4HAuD/l/brM554D6VyLA0k9og/kLiGoIqJWEvGWlLSwUIOKttp77/Cz+VlBY
 4LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533161; x=1712137961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TS+v/eLxATnG0O4x0k9d/m89qYtDW6sLXZHCB+9mUOM=;
 b=FIf2yiO72OoJrJIczyS6i7EttftD5UEotp/kldiQ0Cr00m4TBQVrQgAZkMao9sQZmL
 lhM7cSpoojl0qjvKZ3zvIG4MWt4h+HWXEFYn+pEsI7A70Qs6rr63H2TV5Ki2ZnTqorMR
 xyr0k8En5kxLGhxmllrKdrQE8aMNLxZztEAvYCa+hWzFI/Eas1RvZubOa+KLBEuRva7O
 Zq8mC5NfzI6ecf8sdg4+r5wkJSMPfkVZUhI7uE9tWVN7ZoG0rNFzFLDDQRb0CO5mbrwR
 UqF9rTHW+Cdn0ReUqn3Kdpc5H+5Sn10aTR4erZn8wg9kn5mBoDWmPKWMANaun/KLDK0y
 etCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlR/Qn2lNJINpXZCDCdNdhdR+z7FTJsKRWsbvvuF35//Bxtm8zdDYNcYonwNzq7w00mbJ1waw98aSh2VQKi7b7XP9MfWY=
X-Gm-Message-State: AOJu0YxVWl2eIBTQz5SN0JO3iFrxbQxxDdZBaBxQlu/kjKz3s13ErsEo
 OM1QQx3xVdwIj1CURhYEUP77YPXOuwNhFFoOxlQU6l9SbvUGIrPUWIR058Cp0Js=
X-Google-Smtp-Source: AGHT+IGwO0//GshnE3F7qsJKYqNnQPVm/trKifCPk4qGgQPBXwdvKOgA6tQeLu1DYmh6v8j5rd93hQ==
X-Received: by 2002:a17:907:9805:b0:a4e:c5b:4b08 with SMTP id
 ji5-20020a170907980500b00a4e0c5b4b08mr161880ejc.11.1711533160796; 
 Wed, 27 Mar 2024 02:52:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170906668300b00a4750a4a1f7sm4032454ejo.6.2024.03.27.02.52.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:52:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH-for-9.1 v2 12/21] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
Date: Wed, 27 Mar 2024 10:51:14 +0100
Message-ID: <20240327095124.73639-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

PCMachineClass::enforce_aligned_dimm was only used by the
pc-i440fx-2.1 machine, which got removed. It is now always
true. Remove it, simplifying pc_get_device_memory_range().
Update the comment in Avocado test_phybits_low_pse36().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h                  |  3 ---
 hw/i386/pc.c                          | 14 +++-----------
 tests/avocado/mem-addr-space-check.py |  3 +--
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c2d9af36b2..231aae92ed 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -74,8 +74,6 @@ typedef struct PCMachineState {
  *
  * Compat fields:
  *
- * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
- *                        backend's alignment value if provided
  * @acpi_data_size: Size of the chunk of memory at the top of RAM
  *                  for the BIOS ACPI tables and other BIOS
  *                  datastructures.
@@ -114,7 +112,6 @@ struct PCMachineClass {
     /* RAM / address space compat: */
     bool gigabyte_align;
     bool has_reserved_memory;
-    bool enforce_aligned_dimm;
     bool broken_reserved_end;
     bool enforce_amd_1tb_hole;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9650a2821..adbc43ab90 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -716,7 +716,6 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
                                        hwaddr *base,
                                        ram_addr_t *device_mem_size)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineState *machine = MACHINE(pcms);
     ram_addr_t size;
     hwaddr addr;
@@ -724,10 +723,8 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
     size = machine->maxram_size - machine->ram_size;
     addr = ROUND_UP(pc_above_4g_end(pcms), 1 * GiB);
 
-    if (pcmc->enforce_aligned_dimm) {
-        /* size device region assuming 1G page max alignment per slot */
-        size += (1 * GiB) * machine->ram_slots;
-    }
+    /* size device region assuming 1G page max alignment per slot */
+    size += (1 * GiB) * machine->ram_slots;
 
     *base = addr;
     *device_mem_size = size;
@@ -1285,12 +1282,9 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
-    const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     const X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
-    const uint64_t legacy_align = TARGET_PAGE_SIZE;
     Error *local_err = NULL;
 
     /*
@@ -1315,8 +1309,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
-                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
@@ -1778,7 +1771,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-    pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
index af019969c0..ad75170d52 100644
--- a/tests/avocado/mem-addr-space-check.py
+++ b/tests/avocado/mem-addr-space-check.py
@@ -31,8 +31,7 @@ def test_phybits_low_pse36(self):
         at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
         we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
         hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
-        for dimm alignment for all newer machines (see enforce_aligned_dimm
-        property for pc machines and pc_get_device_memory_range()). That leaves
+        for dimm alignment for all machines. That leaves
         total hotpluggable actual memory size of 59 GiB. If the VM is started
         with 0.5 GiB of memory, maxmem should be set to a maximum value of
         59.5 GiB to ensure that the processor can address all memory directly.
-- 
2.41.0


