Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3975BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV5N-0003mb-LS; Tue, 05 Mar 2024 08:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4u-0003EI-FB
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:36 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4s-00041u-QQ
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:32 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3566c0309fso84585866b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646208; x=1710251008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hhJFtIMtwQt2Q60UHnY//zCzzc81rKvwExxrpPdrH8=;
 b=nTg20HkEdgEnoO5MKX9hSxi2m8Tk4JLhSlJdPVU0Kgdm80bK/arkGlcY2m7W7UQI07
 h9ysVqKrXrOt/a+ZyRcZ/yK6fpI02w37iWO1NBtFUziElrB/v8p2w2mZjYb02EkWrKzV
 Vp7X4zvyM5Kj1MLtLahwu8oj3uAJEgjeQGf8dtYXe6dGjcGFfSPa7Rvi79iN7/G9jMJ4
 mjBTI277xSQllLD2U2XKfyDn4wONQZ5Q8MWSlkKnhVoQYqJ0/CXemvzHbj4De/tW9BqO
 YqjZCW7PtiBM4XiixDURhmlh3yThs6zxfUgWeWXzLs0feyBQZ4/fWq+BxlWgYsadB7BQ
 1Xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646208; x=1710251008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hhJFtIMtwQt2Q60UHnY//zCzzc81rKvwExxrpPdrH8=;
 b=uG5gnxNp6TbXYwKSu3+wq5vwdlSZId+7Ex0Thv3uePTu81pDyrB5QeOcTeByLeu8to
 Au9RYofBrqXtkFLCWHDXAYCzKzPa/ipC5eQsNYL6C95otU24rTfEcuNje5sBqFSJkw2s
 35CDLqkkc4ZLx3eNEG/VFLMZDPYgtiS+XNIiqkkbPSR6RTTt7NStsYQWhHhUn/7B/l+5
 PvgbUcqagSX/QHBL1TzKXGWwBRaBeCoP82QuUZsTMAHeZFkaOZUSTD34HSot+OQEP1qU
 xSvA+5e0/xP9VKNHwQTvfC/oT5vfzALPITz0PHUdCknSPU2y4c27Rk5rhGgu2NmMc+km
 PzJg==
X-Gm-Message-State: AOJu0YwQfelrrKmg6F9bQ1dmSp35uzCdKzReRbmvoTG1TQ4Mi1vnUHHA
 8vAYCXvqqkn8XKBkoYIBhfuxTq02SvnfOZUcPLI3neWOUXgEqUp7GaCFPmacOXfR0g1i3rWeOnQ
 b
X-Google-Smtp-Source: AGHT+IFem75Y0FPHygJH4hylsAO/6REF+jZArZQNrRqkWJpWcKTi1COMM9pGe9G4ODDoaNilTiITnQ==
X-Received: by 2002:a17:906:1c8d:b0:a44:415d:fa39 with SMTP id
 g13-20020a1709061c8d00b00a44415dfa39mr6365674ejh.37.1709646208209; 
 Tue, 05 Mar 2024 05:43:28 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170906049200b00a44ebb34851sm3773626eja.10.2024.03.05.05.43.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 09/18] hw/i386/pc: Remove
 PCMachineClass::enforce_aligned_dimm
Date: Tue,  5 Mar 2024 14:42:11 +0100
Message-ID: <20240305134221.30924-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 14 +++-----------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index f051ddafca..bf1d6e99b4 100644
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
index 409114bba5..0950abcc2a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -734,7 +734,6 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
                                        hwaddr *base,
                                        ram_addr_t *device_mem_size)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     MachineState *machine = MACHINE(pcms);
     ram_addr_t size;
     hwaddr addr;
@@ -742,10 +741,8 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
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
@@ -1301,12 +1298,9 @@ void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
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
@@ -1331,8 +1325,7 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
-                     pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
+    pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
@@ -1793,7 +1786,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->smbios_defaults = true;
     pcmc->gigabyte_align = true;
     pcmc->has_reserved_memory = true;
-    pcmc->enforce_aligned_dimm = true;
     pcmc->enforce_amd_1tb_hole = true;
     /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
      * to be used at the moment, 32K should be enough for a while.  */
-- 
2.41.0


