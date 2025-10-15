Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC2CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8xef-0002B6-At; Wed, 15 Oct 2025 05:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xeZ-00028c-J8
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:39 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1v8xe0-0007Gs-PU
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:18:39 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b2e0513433bso481852066b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760519873; x=1761124673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zSZesig48Z1wDDnUNJr3ddUDwhjrhjlEH2DRdaZ+h24=;
 b=LtYXcBUnejR0zhO10JfRnn5ZMXncwgqzMQteYMOCWeAHWuXbLTD2EJL5sB8uM94z6+
 sfmas4xj7a/1Gqb/lweWnCVXzxa8uNEpZ0xO1IBPoDT/57+s+MF5yGAn6D6UyccJYyDa
 nXoM45z8EMFQKNxgDJdCnOY+oQuGC45HZQFL+SbX95FlaCde2TvDklQP+8hd4eKIUXwU
 29b9vClRDhfjSHkR3N+LUrj/V2z280SUHRvUoYhTMgXcp/0hiJRMGTr8E2YD19pIctvx
 /TaXbOo+XNnNYnLh9RMWd23JKvkukCegl0JTRoJ67nsZTJ2qiVv48m7lV4Kpens+nDIl
 F8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519873; x=1761124673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSZesig48Z1wDDnUNJr3ddUDwhjrhjlEH2DRdaZ+h24=;
 b=a2hsTMVOeUY9dtNJaGM8G0BAZhOe/eLuGCH7oGdngMjzETaltaKGjo5q34Tkw9MrKU
 KBWdyGUxejNqvzk3TjAX9Whc0uZxdX2kEXoBM27U2ob4SN8uPixzFhFPcpfnowuM287s
 C2Mgkzh6SHfHK11dlWV/yLN03mjtECQ8McJ/zmJPUgCHlOPELGm5aKyQdNJ+PuPU3Csm
 lezrTBSPKfm4ovFfupkwu9t93K+kAzavrTMAqHyAdhCXm5mV/Ff1O0EQRZllz5/Q/O+3
 kHLGdNOhMh6mJ+E/KbH5tItlD22oJyMB32fwNe2jYg6hQ0E4F1cYV+CySKzWv0m9KYRx
 zipQ==
X-Gm-Message-State: AOJu0Yz+PbIuZcPJmotKQw2KCtRUTduhkIIc7ntT/9MnvCJOTh9JznFw
 m4vqkzJYx0BGFnThmvWKMKR7687bppkx1qJh9XC1Ej5B/A+OS/9q1K9GWP4B1ZaTLFM=
X-Gm-Gg: ASbGncs4uKuNvhwu2AN1iDWwbf8Pw8S2j8IWRKT1jHfbttUvmmZlmUJYBC6pXUm2IpL
 PSwXy0ilwRmvobN6XzTH2nXAtVV8NMMfiDzRuczOm6nVA8b2gr6OaJpIKNhBNXAfkSrhrV8qoxx
 2GDiIGpo5QHSKO35w2DpsS8nG3KcAmw/y1LeRN/sZlOMS6pEClBLE1G+qfQVmwzdOoR7FMjsuu+
 Aq9gWWGbgPdeqeK+Kqv7D0clMDgIjEP1fU84+XoSdgumRJSKI9ybzt6QUH7W6pTE7UQ67e33wGX
 gn7n/BI1e5jm21zpEdVUdIgwSHT/qYhnSoX+BTl4k2C++OAQeGiPieqihSHUGTkpT8T+7FWYCkt
 HHlHVhdzNBJntMbLw2nMNbanyiD9SNGD0lotHxjj/sUNfXXdrpQhkX/6rh9+3X8uH3lis+p0L
X-Google-Smtp-Source: AGHT+IHhPdg4hJO2Z943DETH4NEAHnNsTUcT1c75SRSkiJU8dUmQaNtAWfDRvXBStPqUikdflrL9Sg==
X-Received: by 2002:a17:906:f599:b0:b18:63b8:c508 with SMTP id
 a640c23a62f3a-b50ac5d079cmr2673232366b.44.1760519872469; 
 Wed, 15 Oct 2025 02:17:52 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b5cb9e7a23dsm182069966b.23.2025.10.15.02.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 02:17:52 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v3 11/14] hw/misc: Add Beckhoff CCAT device
Date: Wed, 15 Oct 2025 11:17:26 +0200
Message-ID: <20251015091729.33761-12-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015091729.33761-1-corvin.koehne@gmail.com>
References: <20251015091729.33761-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

This adds the Beckhoff Communication Controller (CCAT). The information
block, EEPROM interface and DMA controller are currently  implemented.

The EEPROM provides production information for Beckhoff Devices.
An EEPORM binary must therefor be handed over. It should be aligned to
a power of two. If no EEPROM binary is handed over an empty EEPROM of
size 4096 is initialized.

This device is needed for the Beckhoff CX7200 board emulation.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/misc/Kconfig         |   3 +
 hw/misc/beckhoff_ccat.c | 338 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build     |   1 +
 3 files changed, 342 insertions(+)
 create mode 100644 hw/misc/beckhoff_ccat.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index d3be733b2c..8ecf423781 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -238,4 +238,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config BECKHOFF_CCAT
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/beckhoff_ccat.c b/hw/misc/beckhoff_ccat.c
new file mode 100644
index 0000000000..cba570e767
--- /dev/null
+++ b/hw/misc/beckhoff_ccat.c
@@ -0,0 +1,338 @@
+/*
+ * Beckhoff Communication Controller Emulation
+ *
+ * Copyright (c) Beckhoff Automation GmbH. & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "system/dma.h"
+#include "qemu/error-report.h"
+#include "block/block.h"
+#include "block/block_int.h"
+#include "block/qdict.h"
+#include "hw/block/block.h"
+#include "migration/vmstate.h"
+#include "qemu/bswap.h"
+
+#ifndef CCAT_ERR_DEBUG
+#define CCAT_ERR_DEBUG 0
+#endif
+
+#define TYPE_BECKHOFF_CCAT "beckhoff-ccat"
+OBJECT_DECLARE_SIMPLE_TYPE(BeckhoffCcat, BECKHOFF_CCAT)
+
+#define MAX_NUM_SLOTS 32
+#define CCAT_FUNCTION_BLOCK_SIZE 16
+
+#define CCAT_EEPROM_OFFSET 0x100
+#define CCAT_DMA_OFFSET 0x8000
+
+#define CCAT_MEM_SIZE 0xFFFF
+#define CCAT_DMA_SIZE 0x800
+#define CCAT_EEPROM_SIZE 0x20
+
+#define EEPROM_MEMORY_SIZE 0x1000
+
+#define EEPROM_CMD_OFFSET (CCAT_EEPROM_OFFSET + 0x00)
+    #define EEPROM_CMD_WRITE_MASK 0x2
+    #define EEPROM_CMD_READ_MASK 0x1
+#define EEPROM_ADR_OFFSET (CCAT_EEPROM_OFFSET + 0x04)
+#define EEPROM_DATA_OFFSET (CCAT_EEPROM_OFFSET + 0x08)
+
+#define DMA_BUFFER_OFFSET (CCAT_DMA_OFFSET + 0x00)
+#define DMA_DIRECTION_OFFSET (CCAT_DMA_OFFSET + 0x7c0)
+    #define DMA_DIRECTION_MASK 1
+#define DMA_TRANSFER_OFFSET (CCAT_DMA_OFFSET + 0x7c4)
+#define DMA_HOST_ADR_OFFSET (CCAT_DMA_OFFSET + 0x7c8)
+#define DMA_TRANSFER_LENGTH_OFFSET (CCAT_DMA_OFFSET + 0x7cc)
+
+/*
+ * The informationblock  is always located at address 0x0.
+ * Address and size are therefor replaced by two identifiers.
+ * The Parameter give information about the maximal number of
+ * function slots and the creation date (in this case 01.01.2001)
+ */
+#define CCAT_ID_1 0x88a4
+#define CCAT_ID_2 0x54414343
+#define CCAT_INFO_BLOCK_PARAMS ((MAX_NUM_SLOTS << 0) | (0x1 << 8) | \
+                              (0x1 << 16) | (0x1 << 24))
+
+#define CCAT_FUN_TYPE_ENTRY 0x0001
+#define CCAT_FUN_TYPE_EEPROM 0x0012
+#define CCAT_FUN_TYPE_DMA 0x0013
+
+typedef struct BeckhoffCcat {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t mem[CCAT_MEM_SIZE];
+
+    BlockBackend *eeprom_blk;
+    uint8_t *eeprom_storage;
+    uint32_t eeprom_size;
+} BeckhoffCcat;
+
+static void sync_eeprom(BeckhoffCcat *s)
+{
+    if (!s->eeprom_blk) {
+        return;
+    }
+    blk_pwrite(s->eeprom_blk, 0, s->eeprom_size, s->eeprom_storage, 0);
+}
+
+static uint64_t beckhoff_ccat_eeprom_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    return ldn_le_p(&s->mem[addr], size);
+}
+
+static void beckhoff_ccat_eeprom_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    uint64_t eeprom_adr;
+    uint64_t buf;
+    uint32_t bytes_to_read;
+
+    switch (addr) {
+    case EEPROM_CMD_OFFSET:
+        eeprom_adr = ldl_le_p(&s->mem[EEPROM_ADR_OFFSET]);
+        eeprom_adr = (eeprom_adr * 2) % s->eeprom_size;
+        if (val & EEPROM_CMD_READ_MASK) {
+            buf = 0;
+            bytes_to_read = 8;
+            if (eeprom_adr > s->eeprom_size - 8) {
+                bytes_to_read = s->eeprom_size - eeprom_adr;
+            }
+            buf = ldn_le_p(s->eeprom_storage + eeprom_adr, bytes_to_read);
+            stq_le_p(&s->mem[EEPROM_DATA_OFFSET], buf);
+        } else if (val & EEPROM_CMD_WRITE_MASK) {
+            buf = ldl_le_p(&s->mem[EEPROM_DATA_OFFSET]);
+            stw_le_p((uint16_t *)(s->eeprom_storage + eeprom_adr), buf);
+            sync_eeprom(s);
+        }
+        break;
+    default:
+        stn_le_p(&s->mem[addr], size, val);
+    }
+}
+
+static uint64_t beckhoff_ccat_dma_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+
+    switch (addr) {
+    case DMA_TRANSFER_OFFSET:
+        if (s->mem[DMA_TRANSFER_OFFSET] & 0x1) {
+            s->mem[DMA_TRANSFER_OFFSET] = 0;
+        }
+        break;
+    }
+    return ldn_le_p(&s->mem[addr], size);
+}
+
+static void beckhoff_ccat_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    dma_addr_t dmaAddr;
+    uint8_t len;
+    uint8_t *mem_buf;
+
+    switch (addr) {
+    case DMA_TRANSFER_OFFSET:
+        len = s->mem[DMA_TRANSFER_LENGTH_OFFSET];
+        mem_buf = &s->mem[DMA_BUFFER_OFFSET];
+        dmaAddr = ldl_le_p(&s->mem[DMA_HOST_ADR_OFFSET]);
+        if (s->mem[DMA_DIRECTION_OFFSET] & DMA_DIRECTION_MASK) {
+            dma_memory_read(&address_space_memory, dmaAddr,
+                            mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
+        } else {
+            /*
+             * The write transfer uses Host DMA Address + 8 as the target
+             * offset, as described in the CCAT manual Version 0.0.41
+             * section 20.2.
+             */
+            dma_memory_write(&address_space_memory, dmaAddr + 8,
+                                mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
+        }
+        break;
+    }
+    stn_le_p(&s->mem[addr], size, val);
+}
+
+static uint64_t beckhoff_ccat_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    uint64_t val = 0;
+
+    assert(addr <= CCAT_MEM_SIZE - size);
+
+    if (addr >= CCAT_EEPROM_OFFSET &&
+                        addr <= CCAT_EEPROM_OFFSET + s->eeprom_size) {
+        return beckhoff_ccat_eeprom_read(opaque, addr, size);
+    } else if (addr >= CCAT_DMA_OFFSET &&
+                        addr <= CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
+        return beckhoff_ccat_dma_read(opaque, addr, size);
+    } else {
+        val = ldn_le_p(&s->mem[addr], size);
+    }
+
+    return val;
+}
+
+static void beckhoff_ccat_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+
+    assert(addr <= CCAT_MEM_SIZE - size);
+
+    if (addr >= CCAT_EEPROM_OFFSET &&
+                        addr <= CCAT_EEPROM_OFFSET + s->eeprom_size) {
+        beckhoff_ccat_eeprom_write(opaque, addr, val, size);
+    } else if (addr >= CCAT_DMA_OFFSET &&
+                        addr <= CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
+        beckhoff_ccat_dma_write(opaque, addr, val, size);
+    } else {
+        stn_le_p(&s->mem[addr], size, val);
+    }
+}
+
+static const MemoryRegionOps beckhoff_ccat_ops = {
+    .read = beckhoff_ccat_read,
+    .write = beckhoff_ccat_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void beckhoff_ccat_reset(DeviceState *dev)
+{
+    BeckhoffCcat *s = BECKHOFF_CCAT(dev);
+
+    memset(&s->mem[0], 0, MAX_NUM_SLOTS * CCAT_FUNCTION_BLOCK_SIZE);
+
+    size_t offset = 0 * CCAT_FUNCTION_BLOCK_SIZE;
+    stw_le_p(&s->mem[offset + 0], CCAT_FUN_TYPE_ENTRY);
+    stw_le_p(&s->mem[offset + 2], 0x0001);
+    stl_le_p(&s->mem[offset + 4], CCAT_INFO_BLOCK_PARAMS);
+    stl_le_p(&s->mem[offset + 8], CCAT_ID_1);
+    stl_le_p(&s->mem[offset + 12], CCAT_ID_2);
+
+    offset = 11 * CCAT_FUNCTION_BLOCK_SIZE;
+    stw_le_p(&s->mem[offset + 0], CCAT_FUN_TYPE_EEPROM);
+    stw_le_p(&s->mem[offset + 2], 0x0001);
+    stl_le_p(&s->mem[offset + 4], 0);
+    stl_le_p(&s->mem[offset + 8], CCAT_EEPROM_OFFSET);
+    stl_le_p(&s->mem[offset + 12], CCAT_EEPROM_SIZE);
+
+    offset = 15 * CCAT_FUNCTION_BLOCK_SIZE;
+    stw_le_p(&s->mem[offset + 0], CCAT_FUN_TYPE_DMA);
+    stw_le_p(&s->mem[offset + 2], 0x0000);
+    stl_le_p(&s->mem[offset + 4], 0);
+    stl_le_p(&s->mem[offset + 8], CCAT_DMA_OFFSET);
+    stl_le_p(&s->mem[offset + 12], CCAT_DMA_SIZE);
+}
+
+static void beckhoff_ccat_realize(DeviceState *dev, Error **errp)
+{
+    BeckhoffCcat *s = BECKHOFF_CCAT(dev);
+    BlockBackend *blk;
+
+    blk = s->eeprom_blk;
+
+    if (blk) {
+        uint64_t blk_size = blk_getlength(blk);
+        if (!is_power_of_2(blk_size)) {
+            error_setg(errp, "Blockend size is not a power of two.");
+            return;
+        }
+
+        if (blk_size < 512) {
+            error_setg(errp, "Blockend size is too small.");
+            return;
+        } else {
+            blk_set_perm(blk, BLK_PERM_WRITE, BLK_PERM_ALL, errp);
+
+            s->eeprom_size = blk_size;
+            s->eeprom_blk = blk;
+            s->eeprom_storage = blk_blockalign(s->eeprom_blk, s->eeprom_size);
+
+            if (!blk_check_size_and_read_all(s->eeprom_blk, DEVICE(s),
+                                             s->eeprom_storage, s->eeprom_size,
+                                             errp)) {
+                return;
+            }
+        }
+    } else {
+        s->eeprom_size = EEPROM_MEMORY_SIZE;
+        s->eeprom_storage = blk_blockalign(NULL, s->eeprom_size);
+        memset(s->eeprom_storage, 0x00, s->eeprom_size);
+    }
+}
+
+static void beckhoff_ccat_init(Object *obj)
+{
+    BeckhoffCcat *s = BECKHOFF_CCAT(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &beckhoff_ccat_ops, s,
+                          TYPE_BECKHOFF_CCAT, CCAT_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription vmstate_beckhoff_ccat = {
+    .name = "beckhoff-ccat",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(mem, BeckhoffCcat, CCAT_MEM_SIZE),
+        VMSTATE_UINT32(eeprom_size, BeckhoffCcat),
+        VMSTATE_VBUFFER_UINT32(eeprom_storage, BeckhoffCcat, 1, NULL,
+                               eeprom_size),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property beckhoff_ccat_properties[] = {
+    DEFINE_PROP_DRIVE("eeprom", BeckhoffCcat, eeprom_blk),
+};
+
+static void beckhoff_ccat_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = beckhoff_ccat_realize;
+    device_class_set_legacy_reset(dc, beckhoff_ccat_reset);
+    dc->vmsd = &vmstate_beckhoff_ccat;
+    device_class_set_props(dc, beckhoff_ccat_properties);
+}
+
+static const TypeInfo beckhoff_ccat_info = {
+ .name = TYPE_BECKHOFF_CCAT,
+ .parent = TYPE_SYS_BUS_DEVICE,
+ .instance_size = sizeof(BeckhoffCcat),
+ .instance_init = beckhoff_ccat_init,
+ .class_init = beckhoff_ccat_class_init,
+};
+
+static void beckhoff_ccat_register_types(void)
+{
+    type_register_static(&beckhoff_ccat_info);
+}
+
+type_init(beckhoff_ccat_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index ffbcca9796..cd76e04a33 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_BECKHOFF_CCAT', if_true: files('beckhoff_ccat.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.47.3


