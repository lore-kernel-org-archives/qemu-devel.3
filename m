Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45882CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoRv-0003cw-Pc; Tue, 28 Oct 2025 14:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoRj-0003Ol-Qf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:29:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoRP-0003bB-U7
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:29:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso79843075e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676135; x=1762280935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTqEXniC4Ziu9AqtErkRaLa7hxRjuJdoZvomCUqIauw=;
 b=aDWUqVV8D5iQ3Wozzsv6bTLZ2cZYn4Xrc6pIfmo+l3Ny7hUdlrDAipu87txrQjuqGc
 /x9zwZk3LYvV/plBBN2dt2hFBNbtbGtrrmO0yQUUh6yh8g5hl+yR3HQdPIP46ybM9Eg1
 iTqLpNtiTal9PRCgISSC2rSa/umsJCG2h2GGdDbOmy3N4Ni5Ft5gTGKTrjBrvagiLzRi
 z5iN119Ui06IyKTlJw6c/9c17K6pjozJIb0/DGGB5sq1yUQCW6WZBZefa3iBNjDeEKVG
 hp3hb0CKEQij1E6WCSiCl6iihnBRxjmtD8X/RmPHgH/B3mdSuS1Q5jetSwAVEisbI9oI
 M3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676135; x=1762280935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTqEXniC4Ziu9AqtErkRaLa7hxRjuJdoZvomCUqIauw=;
 b=sIPH/MGkdnEhmGmRUmBMeZNJvvqKVqPY9gtLnxUW7BBhYtg5jkjBylWu5vFRg9v4eb
 JXxbO5nqZ1S7x+JqvWoLs02Dx7ifI5EvWX142AU2ld91Wu0WGToFQp7FItok7PCUbrQ3
 6nacz3H3b6AsMJez/lipjY+Wo5cLD6l5YSbbcccZshVNkcrjIHofHukR6kuV3kQjedCL
 h8FcPigiBnV7dnfamjpJnhN7eIBQsShNp5uvBIg/9lwUOL4AjI7HX40kkELhStvyZQS5
 A+3qI674dqOOSRxwh75LUXvLBn/uFNe9v8shvzTMVDwg+ldjV+bX+DII3DmyYEPU8P5H
 7FZQ==
X-Gm-Message-State: AOJu0Yy0lEGdapo6zxYeTF2dqM61IFsMz040SmFDAeS+K7UEXU5m9s+b
 wxUBJhiUpV0EPi6lJOtP+8QcohoYIr71UAZNIDSAta/gxSYSajOBHKUU/TPzJ0/cDr5N2QVLsEx
 xIeADBE8=
X-Gm-Gg: ASbGnctOA/LNdv6ibApUh5kzMOj6cZQRysaNqsDODKxBEsyq0/Rljc098sWPIJdhplg
 rUGzzhUgQ9eQWLF3P4/C9aS0yto4FmVrHYKTqZU/olTMRd1qhJWMvkUQLZBjsKApfAzYWFlPOoJ
 yBoyCKNuBqkRPSjDPF4TArXrlB5XUX1gIDpimGo+UKN1O1nZgcZQN1Q2MHZDKk0k7S4o6GwcNUn
 1YcsjAYcY43PNHm9KJCOHS4VHrEfduNUehlCQQLuAZ6fIYxp8mfDiZK6a1bDpe45IUtRsXlWz81
 F6TBzsTRJYYSpA5P/X7bphZQcR5Ox+L0/c+zSNV8xspnBqt7IChxTJcUvP7juMmmMp9ydpbZgid
 UyhFr2sYAI35ZVxwUNdi90ZFFyHDnoOMtDFzWjcRDZo8LCYw9z16PTSFfupcDyIELuGHhgx+8HJ
 NKQf72p2szo0iBFuL/jnGpLtA1mMTcSdkCoeb9oDwguS4cM9djkXck2kpXfh+1
X-Google-Smtp-Source: AGHT+IGgEQmNZW/VdvN3gmZwK4t9JcBXVteP83+Z2Xlkr80E9yVxkFA6II8H4a1vEDcjbIXIvUnfIw==
X-Received: by 2002:a05:6000:40cb:b0:428:5673:11e0 with SMTP id
 ffacd0b85a97d-429aefb9d57mr38221f8f.40.1761676134968; 
 Tue, 28 Oct 2025 11:28:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771902981esm23762575e9.9.2025.10.28.11.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:28:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 13/25] hw/acpi: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:47 +0100
Message-ID: <20251028181300.41475-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/cxl.c                  | 8 ++++++--
 hw/i386/acpi-build.c           | 8 +++++---
 hw/loongarch/virt-acpi-build.c | 4 ++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 77c99dfb184..92c032851cc 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -105,6 +105,7 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
     PXBDev *pxb = PXB_DEV(cxl);
     SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl_host_bridge);
     MemoryRegion *mr = sysbus_mmio_get_region(sbd, 0);
+    hwaddr container_base_addr = memory_region_get_address(mr->container);
 
     /* Type */
     build_append_int_noprefix(table_data, 0, 1);
@@ -125,7 +126,9 @@ static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
     build_append_int_noprefix(table_data, 0, 4);
 
     /* Base - subregion within a container that is in PA space */
-    build_append_int_noprefix(table_data, mr->container->addr + mr->addr, 8);
+    build_append_int_noprefix(table_data,
+                              container_base_addr
+                              + memory_region_get_address(mr), 8);
 
     /* Length */
     build_append_int_noprefix(table_data, memory_region_size(mr), 8);
@@ -154,7 +157,8 @@ static void cedt_build_cfmws(CXLFixedWindow *fw, Aml *cedt)
     build_append_int_noprefix(table_data, 0, 4);
 
     /* Base HPA */
-    build_append_int_noprefix(table_data, fw->mr.addr, 8);
+    build_append_int_noprefix(table_data,
+                              memory_region_get_address(&fw->mr), 8);
 
     /* Window Size */
     build_append_int_noprefix(table_data, fw->size, 8);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9446a9f862c..201fdbb39f0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1039,7 +1039,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             /* Handle the ranges for the PXB expanders */
             if (pci_bus_is_cxl(bus)) {
                 MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
-                uint64_t base = mr->addr;
+                hwaddr base = memory_region_get_address(mr);
 
                 cxl_present = true;
                 crs_range_insert(crs_range_set.mem_ranges, base,
@@ -1822,7 +1822,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
+    build_append_int_noprefix(table_data,
+                              memory_region_get_address(&s->mr_mmio), 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
@@ -1857,7 +1858,8 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
+    build_append_int_noprefix(table_data,
+                              memory_region_get_address(&s->mr_mmio), 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 3694c9827f0..101d083ae6a 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -409,11 +409,11 @@ static void build_flash_aml(Aml *scope, LoongArchVirtMachineState *lvms)
     hwaddr flash1_size;
 
     flash_mem = pflash_cfi01_get_memory(lvms->flash[0]);
-    flash0_base = flash_mem->addr;
+    flash0_base = memory_region_get_address(flash_mem);
     flash0_size = memory_region_size(flash_mem);
 
     flash_mem = pflash_cfi01_get_memory(lvms->flash[1]);
-    flash1_base = flash_mem->addr;
+    flash1_base = memory_region_get_address(flash_mem);
     flash1_size = memory_region_size(flash_mem);
 
     dev = aml_device("FLS0");
-- 
2.51.0


