Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A660C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujxdo-0005ng-82; Thu, 07 Aug 2025 06:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujxdg-0005bC-FS
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:14:24 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ujxde-00088b-8M
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 06:14:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4538bc52a8dso5265575e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754561660; x=1755166460; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+qG9r7mdKkleg7y6tHdMrSM2/xvDDGZjAXcJ4uQc3Y8=;
 b=vDmd63jUa8zRcV6nkxvN5qppihYpx5HdApTwdOPnkJq/4gdCm9xPUex4tiDpP93nW9
 07wtd9rhQDfcvTixCBUDPakrOVj3Y3Yzsis3YHZNWvB+8dTxBdoVxTNecuup4hTNAyxo
 /IJWjtm300G9pzEUpTEcy7dBZr6ftrFXvZxu1FdjgO8pKHu9Wy4LXjdQDRBLeGsEvp/Z
 FUSSXfIw9XNsho21aIE9eCl3RGe2dWM1Aiwf5tp02C4xRVC0V0CeqRDoMNkfH0a37qHg
 Agu9jwOFNwDTshaFOGeZwqy/qBVgDyElQPBMSa8AVD3QIxzXw267pzH9ExHLDru32Xar
 2odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754561660; x=1755166460;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+qG9r7mdKkleg7y6tHdMrSM2/xvDDGZjAXcJ4uQc3Y8=;
 b=agsEhgWSrJyKZxaV1COfEsEVmIxQWR1eHrhbyUt8eAf/XoVRAZYHOMw/CG8NlfHd4O
 7hBD4yXxCQD4sARjVveU/WYBZ1uRFsmuNxs1+oV9EU2i4Q3XtH1OSPumJyT8qkTtgTfG
 54WDLtYIKG0LaToxbiielg9UTzStpPS4yh9VS1p6cjOnWb0BT16deRsi5gWskgDEaCn4
 kMUSSCLgTpN543mK8FIHIxodNKR8uuES+dyfO8fGI1/4bRjm6Mow5cKhFntaJShK3LWh
 CCdXXpjF6CVaaDwgDGTngOROvIS5XVlkDo0zfY+btS9cMEgy904X6Gb4kZtAANAfn8mM
 BdDw==
X-Gm-Message-State: AOJu0Yx2Ou0vsg0QKNjv6JcZqzV/F2rUYBJY/rDTL+LBtrZa74JjdmfQ
 ddpwBpD/I4bLlZK2toS3SoFZEu/8nTMENSHjXALdNystFTHKXUxF3wwON7Y+d96Tq18=
X-Gm-Gg: ASbGncvps/wY5nuGr/cZOKgBwvxGI9fuHw0z5lHayWxkFOu8X2Ieg/HeWN2V7zK6dsT
 2ll7ZnqI1LzRONrcKaoNp7z7ylhzE7Zai8Uul/rouasLLs6F7+00VOPdTyDHhW8XW4PiJhyr8Xg
 YJ29F79RmGQ2OHIH2HaZc7gc/vM7sv7nYT3a4kb58hdFLMIgHNPr4JWgk/gpIjctVuQpXXcrmWA
 s8tT4M70Hp28ll/BXRVstUwfZlC8fa/6qpgOofxrE6W8CuMLJGiSk2dBwOUo3OeVDOUv0sNOesx
 rqhI0hWhaKJpVpM1qLYbjfKDN8Y9KWFml/GypaMNkKWg0rvgTssJxrGXViQXq1T5fYa6ZfYaQh8
 nbR4W1F4wmU/ak8+YSUvw0QPvmL/9FuG43aq9rIr4rV+UrOg2fPF0NojwjdZuIPdJ7I/h
X-Google-Smtp-Source: AGHT+IE4WpHrNJV63icm9Zsubnixysx3pHWc8Ni0BTUHleEXYJVHxE8A+G5Kb6TD+q38ogiQZZLe/Q==
X-Received: by 2002:a05:600c:35cf:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-459e70eeb46mr59848695e9.18.1754561659596; 
 Thu, 07 Aug 2025 03:14:19 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440194.home.otenet.gr. [79.129.176.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dc900606sm151014105e9.15.2025.08.07.03.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 03:14:18 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 07 Aug 2025 13:14:14 +0300
Subject: [PATCH v2] hw/arm: add static NVDIMMs in device tree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250807-nvdimm_arm64_virt-v2-1-b8054578bea8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHV8lGgC/32NQQqDMBBFryKzbkoSozaueo8ikmjUgZqUiYQW8
 e5NPUCX78F/f4foCF2EttiBXMKIwWeQlwKGxfjZMRwzg+Sy4k3JmU8jrmtvaK1Vn5A2pkthmlp
 Z6/gAefciN+H7bD66zAvGLdDnvEjiZ//VkmCCTTdVVro2Vuvq/kRvKFwDzdAdx/EF1+uK37MAA
 AA=
X-Change-ID: 20250730-nvdimm_arm64_virt-931a764bbe0c
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Gustavo Romero <gustavo.romero@linaro.org>, jonathan.cameron@huawei.com, 
 philmd@linaro.org, shameerali.kolothum.thodi@huawei.com, 
 hsiangkao@linux.alibaba.com, alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5090;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=h0SeThr1Wbng5z0Dg3T2xFKrvEgtuVVmzANGnv5oINc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9sSHg1QnhGRlVMaWhpSDRWbVpvOHNxUDlWalBLCkszckxnRnBHNzExd3pvVmpR
 Y1dKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpSOGVRQUt
 DUkIzS2Nkd2YzNEowTkpQRC85bWtxdHJheUJrOTlsblhoZmZaemJvdGhtUU9BQVJPN2dTYU9MSw
 pyVmdEblJuVnU3THpXVlRvMmg2QkxXclJmMXFiVVpGbkh5RXZ0Mmlyb1N5VFFuR2pacWJydlZPa
 FNqZEdVc2kyCkVnc3RNM2FFL2dqQVU4dHR3akJKYzVjVWs0WmJNY3h0dUZuZHlLTjhoM1hFdlR1
 OTVabVRRcTJPQWVrZG1MdFIKRDlnL3hkL09mR0MzaGViNXRaem5ZR2IySVo3eVArdWdldnU0MFp
 CNFZBLzFOWTBuQnUvaEF6b3VTdmV4UVFpeAowWjhtV0JWeVBoUkxTaVRxbUlpMmNxR0hlcWh0M2
 IxbGVGN25qNWJ4eUdmSzdxYXhtQ3BEdVk3dGpXTUNKcUhQCmVrRWx6RDB4QnhZMzlqMmVQbWNLO
 DdoMEFGZ3liZW9WYVVNaEh6VGlFaXZGbzJpeXFjNk1DdUo2dTFXMXhrLzYKenl4WVpOZE9MK1d6
 aVJIN1kzb0h4bzU1V1o3bzRpanR1d1VVSlZkbVRhSW1qZ29EWUNJVFVveExpaElWQzNsKwpDMS9
 ZbWZHK0ZFZy9ENE1rMFBLY0dQQXNPZmx3a1djMk9pemFsWkhRb2NBTGFHL2R0RSsvR0kwQkhRNl
 JBUkFECkdRQ1h5RGlvSldhVnY1dWJEODZoSDdOdHpTRlZiU09SOTdLQzV5aDViL2xvQzVBZi9PT
 GVOWFZDNEd4TEpCTXkKd0FVVWZHTHhwMzdJQ3B1SmJ6UVIrUnltZThUS1ZNZGtabWM2clBWbEkv
 bkFQK2Y2UGltMDU4SGlTUnFlSzJ4ZgowYVlsVWxoRzU4TG85SHZaaG8rOVZ0NVhIOVhvblE1NUd
 jS1FURnpVc05oNUQ4S3NqRnM3enMwcytFQkJ0TmNmCk5JR01kdz09Cj1qemgvCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

NVDIMM is used for fast rootfs with EROFS, for example by kata
containers. To allow booting with static NVDIMM memory, add them to the
device tree in arm virt machine.

This allows users to boot directly with nvdimm memory devices without
having to rely on ACPI and hotplug.

Verified to work with command invocation:

./qemu-system-aarch64 \
  -M virt,nvdimm=on \
  -cpu cortex-a57 \
  -m 4G,slots=2,maxmem=8G \
  -object memory-backend-file,id=mem1,share=on,mem-path=/tmp/nvdimm,size=4G,readonly=off \
  -device nvdimm,id=nvdimm1,memdev=mem1,unarmed=off \
  -drive file=./debian-12-nocloud-arm64-commited.qcow2,format=qcow2 \
  -kernel ./vmlinuz-6.1.0-13-arm64 \
  -append "root=/dev/vda1 console=ttyAMA0,115200 acpi=off"
  -initrd ./initrd.img-6.1.0-13-arm64 \
  -nographic \
  -serial mon:stdio

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v2:
- Reduce ret value lines in fdt_add_pmem_node() (thanks Jonathan Cameron!)
- Link to v1: https://lore.kernel.org/qemu-devel/20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org
---
 hw/arm/boot.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt.c |  8 +++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d391cd01bb1b92ff213e69b84e5a69413b36c4f8..1e57c4ab9ee864433c8b985ddc95138f7d84b56a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "system/reset.h"
 #include "hw/loader.h"
+#include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "system/device_tree.h"
 #include "qemu/config-file.h"
@@ -515,6 +516,29 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armcpu)
     qemu_fdt_setprop_cell(fdt, "/psci", "migrate", migrate_fn);
 }
 
+static int fdt_add_pmem_node(void *fdt, uint32_t acells, uint32_t scells,
+                             int64_t mem_base, int64_t size, int64_t node)
+{
+    int ret;
+
+    g_autofree char *nodename = g_strdup_printf("/pmem@%" PRIx64, mem_base);
+
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "pmem-region");
+    ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg", acells,
+                                       mem_base, scells, size);
+    if (ret) {
+        return ret;
+    }
+
+    if (node >= 0) {
+        return qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id",
+                                     node);
+    }
+
+    return 0;
+}
+
 int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  hwaddr addr_limit, AddressSpace *as, MachineState *ms,
                  ARMCPU *cpu)
@@ -525,6 +549,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     unsigned int i;
     hwaddr mem_base, mem_len;
     char **node_path;
+    g_autofree MemoryDeviceInfoList *md_list = NULL;
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
@@ -628,6 +653,23 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
     }
 
+    md_list = qmp_memory_device_list();
+    for (MemoryDeviceInfoList *m = md_list; m != NULL; m = m->next) {
+        MemoryDeviceInfo *mi = m->value;
+
+        if (mi->type == MEMORY_DEVICE_INFO_KIND_NVDIMM) {
+            PCDIMMDeviceInfo *di = mi->u.nvdimm.data;
+
+            rc = fdt_add_pmem_node(fdt, acells, scells,
+                                   di->addr, di->size, di->node);
+            if (rc < 0) {
+                fprintf(stderr, "couldn't add NVDIMM /pmem@%"PRIx64" node\n",
+                        di->addr);
+                goto fail;
+            }
+        }
+    }
+
     rc = fdt_path_offset(fdt, "/chosen");
     if (rc < 0) {
         qemu_fdt_add_subnode(fdt, "/chosen");
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f5fb38da84235c32dc2d13a5c61889c..910f5bb5f66ee217a9140f9128804a5b9f69b5b6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2917,7 +2917,7 @@ static void virt_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    if (!vms->acpi_dev) {
+    if (!vms->acpi_dev && !(is_nvdimm && !dev->hotplugged)) {
         error_setg(errp,
                    "memory hotplug is not enabled: missing acpi-ged device");
         return;
@@ -2949,8 +2949,10 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
         nvdimm_plug(ms->nvdimms_state);
     }
 
-    hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
-                         dev, &error_abort);
+    if (vms->acpi_dev) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(vms->acpi_dev),
+                             dev, &error_abort);
+    }
 }
 
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,

---
base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
change-id: 20250730-nvdimm_arm64_virt-931a764bbe0c

--
γαῖα πυρί μιχθήτω


