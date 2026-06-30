Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829B3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOYT-0004EV-Be; Mon, 29 Jun 2026 22:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYQ-0004Dl-Pw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:30 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYN-00029C-6F
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:30 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37e4098e920so1617160a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 19:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787825; x=1783392625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t10Ezi/uwWFyoRD6k5OU/iZ8iwpW3lBUPBJKT84zHY0=;
 b=C8tEx26qleQE4pMx1wVuU8zm1nxkeNJ93c5kIG3lZUHh6xjNxK2R11EM68dN+RzXIN
 ONQEOCDQV7r9oaYBFnbJhXKhILDd52S4M0Lw1zTfzj9UJHlz1Pao2LmbzFeYLDawdfP1
 ai8qmAininHKvvNpd/rrWwWchYkyT6gC9tY4+xOc00X0ajE2+b62/Zh5SOvylujPJcfW
 yPM5fpWcTtg0ywP6lI+xW3/Kwp1tzsdzO2RrXxdxZq2mpgGjgWcTA1gpsHUgwyYYOuHw
 /VNosHxywNxHkvPRMAgPJ0OBebNxRkmgERz50XY14o7QiftpcrIiVicsvrxx91/o1gTK
 8MgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787826; x=1783392626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t10Ezi/uwWFyoRD6k5OU/iZ8iwpW3lBUPBJKT84zHY0=;
 b=nrW3XwpvAQwJe9jzmxPRV6YFYxtMR246jbLY8Vx1Yc3gx+7vp+40zJvTtm9y8xW494
 Qn1Nt1r4YGr7uTO9t1bxxl4dtKwWGDq32paH6Ebuxe0CcDwipcoGf1ChbUNoFLGjikuV
 kOpvLdLe99l4wC2k6ygZx/eTJTPh3sM1p48lWdlzDYshW+Im7cY8QoVsLNKl0Owjq7S8
 IaOIzToxRea9ZhD8Fm/PnrKTxAYZLWL1J8xIvH4APhsiMyfKV9wjztwrfPWNrlTZJVWu
 GEn/JOcvZ6dpG6yVVCxlipsl/h46ROK52XMR12205ty8D4nXubO6uiSKG+eedr1SF6J8
 BgTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RovQZsqnlXmC8FnN4o5Ksq8LjH1q04aMJWye8VqstHGhlnA55YMag/lApLPrEZNA0qp8V673RPoL28+@nongnu.org
X-Gm-Message-State: AOJu0YwTPPZ5jh/k5CwhyGeiVCjetm7mI11gzacLCywj8ohMjCniRHu7
 /9w0JfvGI00fnIoapIGC6M945OunFfpxTGjqLPp8SqJT4iNTg+78ahtu
X-Gm-Gg: AfdE7cmeKU6vQN08iH28eOVLBuKig65grNjDxOGDSKe+TBSSIjBawaoOgXhLVcE0w4s
 rr5fbCU5cRvaqGtz6fxIcVqDIOraKBTR+UiOBoQxK3DLqF/+6+wY0zbKRCrQRp9Xr/GIfkHg4G3
 FaT3yAYZJhnrOE7JjJpWEM+cAiIVS54lQ/odRqJi1qTXfY4r5f3pahR11Z1Muyr6D0hr+p0iLZv
 FuzVnKwlrut2XaY4oVQI3ExpOMiCuDPcTPOwWS/yhCYZTZIiHtgzq4WcbuNvnBKcIVzUUsUhsev
 v3NaiJQWZ/myMWvNnVmlLa7kZsf5bfnDR1sBNoJY35MIUbZhfyQJGOLXDxcZjDajmavU38K+bJZ
 Iz/pqknnuxFcoomrImvF6q718FW/kX3Rio/IGjXKLw1hWkIGzBhvIsgoc/YTTnFDRIgDgFKBZ9N
 b1ojgZ1dYzklkLAHdJWdUYraXHvuOjDEHI8hQs5aa6S2ULrMaYKorXGuFs/jFAxXIXMAgoPHdo0
 LNFvAQLBkI672LhbQO1RIijE1tJrxz9+OpszJ0wSww=
X-Received: by 2002:a17:90b:3f0f:b0:37f:eb45:e058 with SMTP id
 98e67ed59e1d1-380527a8a91mr1251367a91.19.1782787825532; 
 Mon, 29 Jun 2026 19:50:25 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32661sm704545a91.9.2026.06.29.19.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:50:24 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 04/12] hw/riscv/aia: Provide number of irq sources
Date: Tue, 30 Jun 2026 12:19:42 +0930
Message-ID: <20260630024952.1520546-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630024952.1520546-1-joel@jms.id.au>
References: <20260630024952.1520546-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Instead of hard coding the number of IRQ sources used by the APLIC pass
it in as a parameter. This allows other machines to configure this as
required.

The maximum number of sources is 1023.

Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h             |  3 +--
 include/hw/riscv/virt.h    |  1 +
 hw/riscv/aia.c             |  8 ++++++--
 hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
 hw/riscv/virt.c            |  2 ++
 5 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index dbb833340276..5ad0a902be0d 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -11,11 +11,10 @@
 
 #include "exec/hwaddr.h"
 
-#define VIRT_IRQCHIP_NUM_SOURCES 96
-
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index ad858deb76ad..36a2def41096 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -64,6 +64,7 @@ struct RISCVVirtState {
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
+    uint16_t num_sources;
 };
 
 enum {
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c724612a50a5..82ea9d48ea75 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
@@ -38,6 +39,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     DeviceState *aplic_s_dev = NULL;
     DeviceState *aplic_m_dev = NULL;
 
+    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
+    g_assert(num_sources <= 1023);
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
@@ -66,7 +70,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
                                      (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     num_sources,
                                      num_prio_bits,
                                      msimode, true, NULL);
     }
@@ -77,7 +81,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
                                  (msimode) ? 0 : hart_count,
-                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 num_sources,
                                  num_prio_bits,
                                  msimode, false, aplic_m_dev);
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 02ab460e589c..59c454f4f94e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -148,6 +148,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -155,9 +156,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
     uint32_t gsi_base;
     uint8_t  socket;
 
+    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
+    g_assert(num_sources <= 1023);
+
     for (socket = 0; socket < socket_count; socket++) {
         plic_aplic_addr = mmio_base + mmio_size * socket;
-        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+        gsi_base = num_sources * socket;
         Aml *dev = aml_device("IC%.02X", socket);
         aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
         aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
@@ -476,10 +480,13 @@ static void build_dsdt(GArray *table_data,
     socket_count = riscv_socket_count(ms);
 
     if (s->aia_type == VIRT_AIA_TYPE_NONE) {
-        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_PLIC].base,
-                                 memmap[VIRT_PLIC].size, "RSCV0001");
+        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
+                                 memmap[VIRT_PLIC].base,
+                                 memmap[VIRT_PLIC].size,
+                                 "RSCV0001");
     } else {
-        acpi_dsdt_add_plic_aplic(scope, socket_count, memmap[VIRT_APLIC_S].base,
+        acpi_dsdt_add_plic_aplic(scope, socket_count, s->num_sources,
+                                 memmap[VIRT_APLIC_S].base,
                                  memmap[VIRT_APLIC_S].size, "RSCV0002");
     }
 
@@ -496,15 +503,15 @@ static void build_dsdt(GArray *table_data,
     } else if (socket_count == 2) {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
-                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_IRQ + s->num_sources, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources);
     } else {
         virtio_acpi_dsdt_add(scope, memmap[VIRT_VIRTIO].base,
                              memmap[VIRT_VIRTIO].size,
-                             VIRTIO_IRQ + VIRT_IRQCHIP_NUM_SOURCES, 0,
+                             VIRTIO_IRQ + s->num_sources, 0,
                              VIRTIO_COUNT);
-        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
+        acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
     }
 
     aml_append(dsdt, scope);
@@ -583,7 +590,7 @@ static void build_madt(GArray *table_data,
         for (socket = 0; socket < riscv_socket_count(ms); socket++) {
             aplic_addr = s->memmap[VIRT_APLIC_S].base +
                              s->memmap[VIRT_APLIC_S].size * socket;
-            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            gsi_base = s->num_sources * socket;
             build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
             build_append_int_noprefix(table_data, 36, 1);      /* Length */
             build_append_int_noprefix(table_data, 1, 1);       /* Version */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index b76bbb62f888..8f80c0607b92 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1401,6 +1401,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
                                              &s->memmap[VIRT_IMSIC_M],
@@ -1557,6 +1558,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
-- 
2.47.3


