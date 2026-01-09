Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436ACD1A61D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veCbD-0004uN-QT; Fri, 09 Jan 2026 08:32:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCbA-0004oM-T5
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:17 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1veCb9-0002IZ-1R
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 08:32:16 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a3e89aa5d0so31535815ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 05:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767965533; x=1768570333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GDMaByVmMHwtYNS++6XQhDSUJD2LPqp5KSIrV8LbU1A=;
 b=ZI8cTyp+QVaSJY3f0aRx0fqx7uhPZ/RlGk7pWYp67OqEP8DDzqevt6HkxJLutQITMs
 EkLC8nGuNsNcOQf92156M7TubWFCML3kuXpIBoZD05SEH8P63Z6zLBSHUrQLc5E11HNL
 /0qvPhXiL6F0S+BBIhGpuBuu9g2IHBKuoRoAD5C3HoCg/SgPJ0GZv5NYWRnUkWQMhX6C
 kBYKFpOjF90nvHvlvqAKgE8/WwmY5Jc2jfnBm7rQgZu1v0P2jA0TYE+i24wxula8GmPY
 RSHom0usXM4Giv3qtZzL0S6bN3hfFrlpQU6HKGd134z8XAc75UoWO4g+G4udO37iL/Wx
 sz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767965533; x=1768570333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GDMaByVmMHwtYNS++6XQhDSUJD2LPqp5KSIrV8LbU1A=;
 b=gQVdhoPjpNltKbGhqUbd316rEsdaQY82apxl5tu1DNMHDXRL7wmxVpiuOYKH/Q8N+G
 rvUrFV6LRaOipu9iKjR2xKa0S7XbQzIEDrrkFJG2CYb5NqX1pZd7womRgLvddZqN7GPQ
 jqXyi74uefEL5XU4UcpMkcwYFPgcge2EjDvronFJJGfIf/GF1JGyN6kslCOAETQTp4KF
 EtOnJp7aaKRXj6Vp7l+a6TgyPd9cgDyuI7f/WQgCxQL3XSmMSPqItAt66eNAB9lh8jJF
 QTlLb6QMce6CLedj46uMztgi0tkMqeSaCj5jH9j+7fz8FFpp48s/7HtopXZJGxS4jHpz
 +e2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM9lhCZm5/stvwVjoUl99TvjzDlLKGGdBSZXmjuYSEvWZD/EtyzogrzBhTOa6QEHYR/zRwvxdKT3mQ@nongnu.org
X-Gm-Message-State: AOJu0YxYOP48Rl3Zf5J3o3xwoXOa8I9K3B4SRGTB2z8qmxEPwhl0Vk4r
 7gBsuc+WbUcMgRbIAw+7vLR8Ig7AhPgS29E+aQymZxThKQwqgJSQ9lak
X-Gm-Gg: AY/fxX6Dz9420yfsLBSbtCXfIC28wRydDdqhDY85FGvLxDoBRlUtmu4IQbppMmCVc+a
 hIQ0X52Hh/D6mPM0tGC/+GMVKpEbJpnzG4/9rrCeSGnwUpk7mikhzre9NuIvli5KrZss7PWTQix
 TVRq+EsVGK8sUE805/9pCZSfq1U9i6JyRExDvLSq42UwuzsXHluOIhoaj6a7qog14IkMW/OrC7t
 tgC8Zt8QLuoKSnmkZVhzE226HYTQZriT/ovI/mt3uuUj5ihpkRmuXGx46MUKZjsllYI7IL5lSOI
 Vo9yI8J2ivSaiRSv89xhecnbnXufWdBKsqUbv1BnV8i+mcxpyUkg1uCZor5jlu6NDpcGWq/uVX0
 NKG73VK///iiVnW5MQ+UU+YHkNQ8Q14/qVJM0EMHBghuItreVFZCemfr9QwDa0DlD7KJPe16Tbn
 O/9Ey4z0eo21rHsUYu705F
X-Google-Smtp-Source: AGHT+IHkWT0grG1hToYjthIsnbHV8dIiVVzTUaladptfFtDw9p8hdSEOV9Gcl9/1ycoOfAk/cN8mAg==
X-Received: by 2002:a17:902:ce88:b0:298:6a79:397b with SMTP id
 d9443c01a7336-2a3ee4b8d62mr93807545ad.56.1767965528712; 
 Fri, 09 Jan 2026 05:32:08 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c491e7sm107755535ad.38.2026.01.09.05.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 05:32:08 -0800 (PST)
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
Date: Sat, 10 Jan 2026 00:01:23 +1030
Message-ID: <20260109133125.397364-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109133125.397364-1-joel@jms.id.au>
References: <20260109133125.397364-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
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

Instead of hard coding the number of IRQ sources used by the APLIC pass
it in as a parameter. This allows other machines to configure this as
required.

The maximum number of sources is 1023.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h             |  1 +
 include/hw/riscv/virt.h    |  1 +
 hw/riscv/aia.c             |  5 +++--
 hw/riscv/virt-acpi-build.c | 22 +++++++++++++---------
 hw/riscv/virt.c            |  2 ++
 5 files changed, 20 insertions(+), 11 deletions(-)

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
index 0a89d7b49b7b..8d45a21f85e2 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
                              const MemMapEntry *imsic_m,
@@ -65,7 +66,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                      aplic_m->size,
                                      (msimode) ? 0 : base_hartid,
                                      (msimode) ? 0 : hart_count,
-                                     VIRT_IRQCHIP_NUM_SOURCES,
+                                     num_sources,
                                      VIRT_IRQCHIP_NUM_PRIO_BITS,
                                      msimode, true, NULL);
     }
@@ -76,7 +77,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
                                  aplic_s->size,
                                  (msimode) ? 0 : base_hartid,
                                  (msimode) ? 0 : hart_count,
-                                 VIRT_IRQCHIP_NUM_SOURCES,
+                                 num_sources,
                                  VIRT_IRQCHIP_NUM_PRIO_BITS,
                                  msimode, false, aplic_m_dev);
 
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index b091a9df9e0f..8da60fe127c4 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -144,6 +144,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
 }
 
 static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
+                                     uint16_t num_sources,
                                      uint64_t mmio_base, uint64_t mmio_size,
                                      const char *hid)
 {
@@ -153,7 +154,7 @@ static void acpi_dsdt_add_plic_aplic(Aml *scope, uint8_t socket_count,
 
     for (socket = 0; socket < socket_count; socket++) {
         plic_aplic_addr = mmio_base + mmio_size * socket;
-        gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+        gsi_base = num_sources * socket;
         Aml *dev = aml_device("IC%.02X", socket);
         aml_append(dev, aml_name_decl("_HID", aml_string("%s", hid)));
         aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
@@ -469,10 +470,13 @@ static void build_dsdt(GArray *table_data,
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
 
@@ -489,15 +493,15 @@ static void build_dsdt(GArray *table_data,
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
@@ -576,7 +580,7 @@ static void build_madt(GArray *table_data,
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


