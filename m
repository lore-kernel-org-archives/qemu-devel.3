Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD549CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCl-00038F-M4; Fri, 17 Oct 2025 09:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCa-00032v-Hn
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCW-0004Vi-P0
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:59 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ecde0be34eso1805116f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706533; x=1761311333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMx4fEQDiJT90/D4DN9KKgZOlwkZG5AqjHkgHNGaAMU=;
 b=gy+i3IuYLQZqQKLgtZTBlTXQZ6vxYnKfh6MehOsc69cTao0J43xBTYqZkIr/r6O8Bn
 ZrakJCaTuV5ClmuSqqEE2DoZx8PkuPAuHFPtoQoEUxRu8XVzh0dzFzDxMj9uQvENMZoW
 82aPqtqFcalPOf36vnaj/EG4Ke1PjuniZ8l+nynv6zEea6XysG8B/MyViJpkHr5vDkXa
 +MBznlunv9redmKhsb/RSYSPl3vvrcnH4Uj6GDzYvT/Bh2Dcgtka/RB8vE2ISbKpBsO3
 3pZK2BoZb0BGyPEpV2Ol3Sdwn550e+MNm0pXHO1acgcvkoHLsy24gd6St/fQ/zPWJJCf
 rPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706533; x=1761311333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMx4fEQDiJT90/D4DN9KKgZOlwkZG5AqjHkgHNGaAMU=;
 b=B+Sk9I1TL3aU0qsd6q3YzL8U6W1v+IkB0Z10EZe5LpOhUQGZ623pTKn8+PpBvZUbpZ
 RsewHftfv6dxntql4b9RxoOI8izRCnQ7MFIGUopdb5ouvVa8+g3CE58/udjoLnocXkL4
 Al3ByOdGWNr9bJVZ/iaCsFGoggG5lQ3YDnY3vH5cYyANs4DlbS449SwkdQ6FGA6PgIyo
 mJ0GGmyI3VruvTxS8JwEVFPChr119DnQVzGVhfw7QvVIEhONH7w5AEHL+Zw335fjbC5B
 uQHUHEnP5Pt3xIpitX2MXCpA6EmpdL4nJqj8gfL6Rb0oMewQtnwp1GpvACJEwVOBxkb8
 AM8g==
X-Gm-Message-State: AOJu0YwTFxQBBRaM761wfG8C/9+jlVdzE866zlJ+/wlwtJuLCzr89X1B
 4bKgSt4XghBvyjaeTPAmQCnP7tGHl0UGfGdqa5aROcSyuhNdrnQ40xtudXEtCJtEU5HuXTQcr9H
 utZlDoGc=
X-Gm-Gg: ASbGncvubz9hR812sGd0N/ysqO7+qZvKuoLHRROHVPYmxk0fS6qNwKsYFP3g2+TkxQ8
 QRx4CgKeHTsQF2MmJvQjCLUrwvooRtXBLoaap/FJ4ypRglCPOevBrkNtkzlwLBtlHDZ89eM9ngA
 OGGXRxB4FkI6HAzn3bdcKmlughyrwQyTFiRVT7nCpkwuekSD80pj3fHQx/LSGCfv90q405PizID
 1vHbURbX+BZqU8NiP8t8Wv8ZMZ1KM81R2UR/DQqkfjE3eD7tGh/3S/oymW492j5BYUQjqZScdXU
 AyAaAS1CyaZAI4G1AhmEWjGn71sBthS3B4x6eWtw02cvQ1U44AbR3ht5MO176M6MdClMRXXlce7
 u5wwkNgISiZAGfp8ZEfV3Ver77V9SZBctA8wA6jzgA0sJUTzi690oLd3c+KcO6Pa9t8BHRQeoFx
 6PWF818xs6RaxY6QiYvyBGMxpGN3fdelpn0thltNKdo9prCfPMjDhhLoQ5p+r5
X-Google-Smtp-Source: AGHT+IE8UN+4oQyxjGUMq75DN1hnmRVOHtIzWVcvAgmLkxSHO+M2PXS7GoNr4AUT9S+HUM4PSK4Lzw==
X-Received: by 2002:a05:6000:144e:b0:426:fb63:c01f with SMTP id
 ffacd0b85a97d-42704bf71ecmr2951519f8f.29.1760706532567; 
 Fri, 17 Oct 2025 06:08:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4270665efdcsm4169402f8f.29.2025.10.17.06.08.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/20] hw/arm/virt: Remove VirtMachineClass::acpi_expose_flash
 field
Date: Fri, 17 Oct 2025 15:08:05 +0200
Message-ID: <20251017130821.58388-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

The VirtMachineClass::acpi_expose_flash field was only used by
the virt-5.0 machine, which got removed (see commit 2c1fb4d5c01
"hw/arm/virt-acpi-build: Only expose flash on older machine types"
for more context). Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/virt.h    |  1 -
 hw/arm/virt-acpi-build.c | 28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index c77a33f6df2..ba16acb8626 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -124,7 +124,6 @@ struct VirtMachineClass {
     bool no_tcg_its;
     bool no_highmem_compact;
     bool no_kvm_steal_time;
-    bool acpi_expose_flash;
     bool no_secure_gpio;
     /* Machines < 6.2 have no support for describing cpu topology to guest */
     bool no_cpu_topology;
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b605154..5db5baa7cf3 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -99,30 +99,6 @@ static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
     aml_append(scope, dev);
 }
 
-static void acpi_dsdt_add_flash(Aml *scope, const MemMapEntry *flash_memmap)
-{
-    Aml *dev, *crs;
-    hwaddr base = flash_memmap->base;
-    hwaddr size = flash_memmap->size / 2;
-
-    dev = aml_device("FLS0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0015")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-
-    crs = aml_resource_template();
-    aml_append(crs, aml_memory32_fixed(base, size, AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-
-    dev = aml_device("FLS1");
-    aml_append(dev, aml_name_decl("_HID", aml_string("LNRO0015")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
-    crs = aml_resource_template();
-    aml_append(crs, aml_memory32_fixed(base + size, size, AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-}
-
 static void build_acpi0017(Aml *table)
 {
     Aml *dev, *scope, *method;
@@ -1011,7 +987,6 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 {
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     Aml *scope, *dsdt;
     MachineState *ms = MACHINE(vms);
     const MemMapEntry *memmap = vms->memmap;
@@ -1036,9 +1011,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         acpi_dsdt_add_uart(scope, &memmap[VIRT_UART1],
                            (irqmap[VIRT_UART1] + ARM_SPI_BASE), 1);
     }
-    if (vmc->acpi_expose_flash) {
-        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
-    }
     fw_cfg_acpi_dsdt_add(scope, &memmap[VIRT_FW_CFG]);
     virtio_acpi_dsdt_add(scope, memmap[VIRT_MMIO].base, memmap[VIRT_MMIO].size,
                          (irqmap[VIRT_MMIO] + ARM_SPI_BASE),
-- 
2.51.0


