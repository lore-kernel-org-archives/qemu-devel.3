Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29FF5A8D2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3jt-0000Vl-6X; Tue, 21 Apr 2026 01:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jq-0000V7-VW
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:35 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jp-0004RH-1v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36146ae9dd4so2853503a91.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749611; x=1777354411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQzUKnDEDxeEJKHujdd1Mmnc0S04pC7+ydkmi3SAr9M=;
 b=VGBV9R5tGG5Mr6TyL0eTkRnn9dQVTiQyP8JtiprsV5UmuJ6vTgehebMBX3jOWx5Y2n
 XrznYw8WIQX4CFyRRqct96/aqG6L3mJS9lVWiSEYpNJf4ekdco5ktvjDN6J1K5SLnWLL
 pdbViD3eWa7FaJv9Ec9k5z7meDKXTInTTRYkGEjhvHKJZrxuU9WBYRVxF9dAP3xPT/OG
 D4PQsKNrcNmy9yzHwDaHsjhddNr4fCHCnlj1d1uzhtyblCmx17v/ynzChC6x0RwAJIbg
 /fUWFHU4h+1f448osQUy8K2FEVvprU7Xcgy8znv+weOJfkkSiNviGC2Xjoo6jX5p965c
 gGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749611; x=1777354411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gQzUKnDEDxeEJKHujdd1Mmnc0S04pC7+ydkmi3SAr9M=;
 b=GQ8xI4t3mbgVYO47nMHpuKo1OLAGvQ6KxWsgE8x5BlSBeAtB3I0uk6uF4B1DBCnLLE
 r63TYqYGpgrJvLq4bd73egybHip95qFGn7BivUmFzTOYLV+LxnNMCwG3JCPClGrYG/vu
 2Ew0Q2qy903Ry9Ws6aaTLyo0TPQ0PxquUrOdotxtW0yKrrr3W/jlg6h0wnTEkenWMaKM
 E21UVnhCsD2Z/yu8Co4bIocAeaWaSzUJqlDQiETBGCuDQ/YjXySUWAALJqS9LhO3LC1f
 MpPEMS5i8JtNpe1b48SmIgj3xcVvz7x9Y5I6stwfXNFGTzagWcPAzrl9wF88amqYPqIy
 j21Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NHaxa+nxNAieu0b9XeHbaUmSCpxltclAYUd7Bv1R0G8hraKKkxtrGjGUYIJVcYTNeDpN5zzIpGfwV@nongnu.org
X-Gm-Message-State: AOJu0YxoQ8CSSkBz4PL/wmnn6KaO3tAy3C82QaRaYi+wdt9d4t9niePB
 ipkqEEd1qkGa1Dz4nKtE8m1qae7V+CIPqm85T2tY2vO3pt2ksqY9Nbf0tfULtQ==
X-Gm-Gg: AeBDievYkXY2fXeIStX6KRAANIUp6NkgS1zSKbApe3E9FlZMOmPViUXNvprEX/BL/T+
 ba4mdzQFCJx3SJF7gqC7NL6AIdSQmtX34katqu+0fvdjbJHouzniDrgiIaGlnYELIOgI3xxalxg
 osQccCPsgdWIfP8SFLJdZcGZuTUaTcUJDXTzDHtR2L9xtr9YmWXknKOX6QMWm/WEhvEcNmGwK2p
 CYvfSSQoE0GvUuqdP9CSIk2uLiJMFqB1rp5hbE78h43nhL3tNVaEv6ezjnOSCKubiYzq/o5+pfu
 L6upJbCxMAkt7r8bAD9nttDz5RWqVrUs32123/sh0hRzTjjn+X2FywgPlUKN5zykxUer0GyG5Ht
 REZKRzjc97fRWqDHX3UoH7wHjqN9H6I87BJAMDMfvgS0iuV282Hlidn+aGvTvAm+tlE3n73rL5A
 vCpMc2+7KksfN7/NcBWnkvcR0b78oPN0ExmBFbt60Go33nM3+vQIydLeU5h3gKJ/+plHCjisJoc
 HdtCpvEoD5h3NGfRHAwEWf0TdObFF1rjmwMxA==
X-Received: by 2002:a17:90b:4b87:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-36140469b55mr17537204a91.14.1776749611380; 
 Mon, 20 Apr 2026 22:33:31 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:30 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v3 06/13] hw/riscv/aia: Provide number of irq sources
Date: Tue, 21 Apr 2026 15:31:31 +1000
Message-ID: <20260421053140.752059-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v3: Add r-b
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
index 145f8d92ad69..9ef3ef842a28 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -146,6 +146,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -153,9 +154,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
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
@@ -474,10 +478,13 @@ static void build_dsdt(GArray *table_data,
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
 
@@ -494,15 +501,15 @@ static void build_dsdt(GArray *table_data,
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
@@ -581,7 +588,7 @@ static void build_madt(GArray *table_data,
         for (socket = 0; socket < riscv_socket_count(ms); socket++) {
             aplic_addr = s->memmap[VIRT_APLIC_S].base +
                              s->memmap[VIRT_APLIC_S].size * socket;
-            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            gsi_base = s->num_sources * socket;
             build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
             build_append_int_noprefix(table_data, 36, 1);      /* Length */
             build_append_int_noprefix(table_data, 1, 1);       /* Version */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce0fd6f50c4a..6c5bcd43dc54 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1548,6 +1548,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
                                              &s->memmap[VIRT_IMSIC_M],
@@ -1691,6 +1692,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
-- 
2.47.3


