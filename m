Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46988D30CDB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 01:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfphI-0004b9-Fx; Tue, 13 Jan 2026 20:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfphG-0004aO-SQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:29:19 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vfphF-0004ca-6c
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 20:29:18 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81f4c0e2b42so1927825b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 17:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768354155; x=1768958955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzgJoRRDsOV4IzjAo9zFOnPPBxb+jC9cP48KbIovXbo=;
 b=L8tw4k2zlCAZ239UJxy7d72RSo/0IniY8CYEAaMEXGFbd4yHZwNTaHaJHIdK6ht7VL
 d73RtYMnqBlohIs8dStnOC4yJLf3NugPxLeUky6ZwrYsDVSHrfioIZseIdWCBcGRYLF8
 dk/6YevBu1Hd/484HaHNP4Od4SDAk4Rm9j7REWuLZnQ3HR1KztUTqiSk3mmQqb2J+8Rh
 H1BpPyKBw0mb5O9tOhY5WyApv522zOgMEWpHmhk86RcuD4P5YrjK9dwsYXugbLPVVKAY
 c7+8vJ3ppCktC9GbMJM/gI0xodMoblPpFt95gMeSYTLGfO2GMrxQ8wkTNDC1zot6XR2A
 wsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768354155; x=1768958955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EzgJoRRDsOV4IzjAo9zFOnPPBxb+jC9cP48KbIovXbo=;
 b=L/pTv9K4WnBzA2/wBOVwfwIgcrl/lzXaAlXUtKyA9/sKbD5y786Zskxx1TcWuMi4YS
 +7LyMPWYdEq3j3/TrTX64gwp1zBHSw8NYh0M1REBUVoUZkuL1UvyA4hFVPe8LraFrXl8
 6QKobX8QGOE76ifoOTydbqnirXoj5rQOxKuwX6SQ3Jb2DIDXmABZCdsuPW/W4erkhUpf
 1s1ZKStQcIdNKuqXafoHhffjwYvUqj2W9TcQJhODNVPbqKlhnsM2W4EEkqtZngaQvIKf
 G8Uq0q6IAk5WuUoVs1BPGfX3q6CLZaR5NaJYmRiRYiRQYSjCkBIlN9CGmw8txIDv0pYV
 BpBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpz2rhnaYTfibCLiy2M/+43b1Vp8Or38nhxK3417RjgS9QscK66KoVpLO1Ug7IJxPFm14eICnp3Ted@nongnu.org
X-Gm-Message-State: AOJu0Yy+yRwfgsmkFMlMtIhD1f+y37mne9mn3sGsSY03HCPnEIKayT4j
 DUmLfCU5bwDJRCaV5x0RvZqJ6zJoGOlTk9d/3seoeyHNZFKmqtuqST/J
X-Gm-Gg: AY/fxX5FjHwu0f7yem8l5tRShrXObvSeopqSDH0kjasbfMzTZpt8hs0Bx04J3VLVXHQ
 /yZXZJbeVa4uLfLHbOtxlOiH2rQyDpk4T5NMFts5rHxJBn0sJnoxcmzaJvZBT0pgA4ZAQ9ko6o+
 /pKxO70tNVcOAzNVFJA/f5yvRi65cwabV7EK3wTz/7t0nraZxgk8YTirK8wTc+4fVqG8j3ekXRH
 bnDQxkuLHjvczP/TunVOzg0UgcaWOSFoUS/M0NImCS/MW3ToD+3NnagkEMi3Ay3kM2mhRtxPm4L
 pEUXkdBQFOPukFUXd1/Zx3QF94tv3Ntm9nomKB6pafeBBZKAfPhriGJq5n8cqzPXOJGjPz4fx9e
 BQ85ctg1hDq9Hu8C8WV4LcGJ1ARw4gCMtZwAG20uEeUeVAP+xNg3TNIZsxqrvsJzhH4kJDGI6tA
 5Mck+4PY6izwE2ACmf52rl
X-Received: by 2002:a05:6a00:8f0a:b0:81f:3f10:6b7c with SMTP id
 d2e1a72fcca58-81f81d5a94fmr798104b3a.28.1768354155411; 
 Tue, 13 Jan 2026 17:29:15 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f3909d2cbsm10704108b3a.48.2026.01.13.17.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 17:29:14 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 2/2] hw/riscv/aia: Provide number of irq sources
Date: Wed, 14 Jan 2026 11:58:44 +1030
Message-ID: <20260114012846.981884-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114012846.981884-1-joel@jms.id.au>
References: <20260114012846.981884-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Add assert for the number of irq sources
---
 hw/riscv/aia.h             |  1 +
 include/hw/riscv/virt.h    |  1 +
 hw/riscv/aia.c             |  8 ++++++--
 hw/riscv/virt-acpi-build.c | 25 ++++++++++++++++---------
 hw/riscv/virt.c            |  2 ++
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 50c48ea4d79c..a63a1ab293fe 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -48,6 +48,7 @@
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 25ec5c665780..fa7fe8d4f648 100644
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
index 0a89d7b49b7b..a9130896fba2 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
@@ -37,6 +38,9 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
     DeviceState *aplic_s_dev = NULL;
     DeviceState *aplic_m_dev = NULL;
 
+    /* The RISC-V Advanced Interrupt Architecture, Chapter 1.2. Limits */
+    g_assert(num_sources <= 1023);
+
     if (msimode) {
         if (!kvm_enabled()) {
             /* Per-socket M-level IMSICs */
@@ -65,7 +69,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
                                      (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     num_sources,
                                      VIRT_IRQCHIP_NUM_PRIO_BITS,
                                      msimode, true, NULL);
     }
@@ -76,7 +80,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
                                  (msimode) ? 0 : hart_count,
-                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 num_sources,
                                  VIRT_IRQCHIP_NUM_PRIO_BITS,
                                  msimode, false, aplic_m_dev);
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index b091a9df9e0f..350912903174 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -144,6 +144,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -151,9 +152,12 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
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
@@ -469,10 +473,13 @@ static void build_dsdt(GArray *table_data,
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
 
@@ -489,15 +496,15 @@ static void build_dsdt(GArray *table_data,
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
@@ -576,7 +583,7 @@ static void build_madt(GArray *table_data,
         for (socket = 0; socket < riscv_socket_count(ms); socket++) {
             aplic_addr = s->memmap[VIRT_APLIC_S].base +
                              s->memmap[VIRT_APLIC_S].size * socket;
-            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            gsi_base = s->num_sources * socket;
             build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
             build_append_int_noprefix(table_data, 36, 1);      /* Length */
             build_append_int_noprefix(table_data, 1, 1);       /* Version */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 01115a0fb946..e5df5a5d4638 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1556,6 +1556,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
                                              &s->memmap[VIRT_IMSIC_M],
@@ -1690,6 +1691,7 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+    s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
-- 
2.47.3


