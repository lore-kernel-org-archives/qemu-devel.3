Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41EBCD0421
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04w-00046O-Cr; Tue, 06 Jan 2026 00:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04r-0003xy-3y
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:59 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04p-0001pH-Da
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:56 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-34c1d84781bso645142a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679074; x=1768283874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZBzbTGkFgMZKTeYQM8W9WJlddFLDQHBD3j9FjDSynA=;
 b=Y+Otp2kXb0jTGxymmi8DMcHGetyuv8w7iek3Wm8A8hRIMdcsbv0CVtOAkl/VF1i3K7
 sj5YbxCAPNKGJs+PDtWnQeV+mLVlKFiZM8Ok74UZ9IHUQlrBckUfM3EeL2Lv+R2GA6rD
 5Qgt2nctbHntGr/JmVnpkEPH+jstCsDMN8TPuDfrkc4ZumIfP7TYf6oA6jvNWtCp3QHV
 5O05BQ0u7xLpKzBLRMfXEN0N+3nQU+HXboHC5+2+9VJFxQdSGibfnBWrniGclSh50zUF
 cskJkQtGJqjdyyN74B3Dg1yg2miHv4q9pumdTGW47yIPystqsDzsxMhcgpy/NkKafLCp
 Fapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679074; x=1768283874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HZBzbTGkFgMZKTeYQM8W9WJlddFLDQHBD3j9FjDSynA=;
 b=mr3EiaWzM43z7xYIMWJcIyFVfvOr1KjnjWr0TJz4m8wXRhdNDkzDgAxM0kmY4aX76K
 h14P8YiFfcUdLRS8rozlfY8893PUx8KXEIRWjAaQ+8X77N2mDFnjOGT8D40yzeka90e7
 IP8Ta45KgUlpcDja46XebaeU9Rt0hj95mYkzHMYPxHlsjC7z3QRwkxqo5qwQ+frTEjT9
 8J6ubKNw7wy+oEbLcxTw5ffueoZZu73F+o/Rw5ftVGgeCEtIyZ8Gekju7P94u1L6o+hm
 qgxtFsBsTcQeI+8ChvoAYheiaaia5wwwm4unYIEN7jbehLEd2ou1lifO5M/hR/SHkS1i
 Wi/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr1IjsuzXRrZ4fvITgEucu/+0EkWnUe3197cV0we/numXYSuPzIKO9fzMZPncJHd2yruaVM56aQqTw@nongnu.org
X-Gm-Message-State: AOJu0YwNWrHSgEI/w07PZ/GeMhM36U6JUF/4wVYlBsAmBT7v1rx8eU2i
 o/E4iKfmYy/K48nnfIN+VL42RpbePukB6fs3QXzfQiR0oXmnUoeR58lW
X-Gm-Gg: AY/fxX4hAo8mqIzjkT6tlHUtN3RFJwT5Jwz+lIr7nQJPfZB4cy6ifTDPH5YmJnVIl5C
 AQrCFSDXIK2d1OLdzFiXBodrgX19qpxecHoD5Q7taUaiXVD96bMxf1i45LovX09tG+l8JM1wAVK
 OOhD88ye8q5YxE66jFKOAUVpIZAV9+pDbM0PZACU3LR2eY+TjTMh7PTZAF+YKsDrDZlPCK0gHQ/
 vn9s1nyeyvL6yoAqnwIpUH9l1WbJtrPg9Ar+xuaPhMGRSFSWYMfkM1WUUiT2mHSk9oBfzyCtv7R
 NmQMsaJlFzPZVwp9dC+srnk5h8M5nXw/NvgeiWF+RxdEpdYFpc9dq1mMlbMKJ6TqzxeeIifXFy1
 jYhWD5lVsUKmVxIizFAgFNbmaVX0Nw4IAg4aIt10Tp3F/URZ7gXiqwEiNsnZO8Q4Hi0UzogJCmY
 eXzO57dvMBUHb8LmhgXD4KYRO6lWScRHo=
X-Google-Smtp-Source: AGHT+IHF2IdslvfvPg5YvdFBLejsnI1rncX2N6MnvgG1vBKqHdvL7V9TTA/JrXDbAx71a5pyZDlDrA==
X-Received: by 2002:a17:90b:4f88:b0:32e:5646:d448 with SMTP id
 98e67ed59e1d1-34f5f30038bmr1537411a91.21.1767679073948; 
 Mon, 05 Jan 2026 21:57:53 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:53 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 07/16] hw/riscv/aia: Provide number of irq sources
Date: Tue,  6 Jan 2026 16:26:47 +1030
Message-ID: <20260106055658.209029-8-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1031.google.com
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

Instead of hard coding the number of IRQ sources used by the
APLIC, pass it in as a parameter. This allows other machines to
configure this as required.

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
index 6abab9786ff8..bf6c768c2d50 100644
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
index 38d7a20d7ea5..27e9ffd7bb70 100644
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


