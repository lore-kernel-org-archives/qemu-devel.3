Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552F8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWkq-0003YX-1S; Tue, 18 Mar 2025 09:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiz-0002Ht-Cn; Tue, 18 Mar 2025 09:11:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiu-0003n4-GL; Tue, 18 Mar 2025 09:11:15 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ab78e6edb99so866016466b.2; 
 Tue, 18 Mar 2025 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303470; x=1742908270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s2z3osT8h7ewZgx/qICYbX5hRMSuhv1wkR46Mb73ULA=;
 b=aHTipcpsd6hjgFl3OpkYUtG1Vd8A7z4G3EDg8wHOKhnRsrZFNVH/iPttBn6zOoocL4
 uYBxLpeRb9YBp5qS9VY1ya+pXpZrJLQ9hgvmMJ2WCCIEIvAgDgwVCJusCsGJUDz4JSah
 evmCRTsy6ptllNcWaI6xOegU7NV7DPM0L1Pg92HgoHBDNnrYXNCexFHig8vwFwH3j+5v
 6lsCm3DMEH4KfdVRx2u+3MvFgniy4Cvaeh8qCSdi3AK8ZnQzAS/8c14wOLWXtOVZZgN5
 QL/RMbVsTEUZzTkmRnkLT7PmrbdNfzqwzBO3GwQd2YVScIl5aC3vk3jjsbqHkj0SMsEL
 8LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303470; x=1742908270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s2z3osT8h7ewZgx/qICYbX5hRMSuhv1wkR46Mb73ULA=;
 b=JGW9ICg48VCwsbeYX9LZ0x5FMZaqdhDKIh3X3YScRPhyy6SLxbc1VB7YyfYJRrUqDm
 0DUffpAdiaJ70iKLhhwSS3QaknI+03kqcYSnm03+qUQR7p28I94Fk4iaGkUrrC7zmtS4
 /5gVJ1EH+eLnxmFUZb3JrryWq8O6rlb9czBkXOLmeNzGr+0FsmbGaGKWKMPMym/cpxPJ
 Dv+6BylMtYoO3OHi62Qx2Hutxg+EEMXhu7PHHKjKgtGP13j3YR5hLfA75VkyvxfXXY5+
 ZN+2wjP0TNHz+aV3Vf4MHvQ98JGhLmn9pnE7anx54rJUBV09j4d71aneOQo1HPzWXyGV
 XarQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnTNRUmKhd56RpADgm/JkdfMCUKrxVLMebHI9/e+f5dgUbnj2LzHFvwKGYXBCUHaeJe8oW6c1l1A==@nongnu.org
X-Gm-Message-State: AOJu0YyupDucp/h4LbDJwncxtIzKzpnOaGJfmCloxJVhj6YS4tPgVleS
 6tQbN6aZxrNSTQwypHFCCUymuFkX3pKGcT7x0p+AgcjhnWhKY4wHX71uELlS
X-Gm-Gg: ASbGncsT4sCcoXVzbWZ/4zgiXrY9P3sbFzCf8DeTt89vTE1ajh+k41eX0RG1w+sA4By
 STr0xt56pmK6EZNEKiwFDilA9IZYpypvHKBrESFeQz9Ye+RZv5Fz+nQv1Xpu1KA9y80O4aY859I
 KdzBLwr1vHSjtnL02Vi3VySSPvf32eFuogVkx/OK1uQ4jcheYrCuTScj9LcSk8Ox4JAILeOgCBQ
 dYQY0cr4waOSjmZ0fYOdyi1sVp4u/fTAXqJRKV9PTtZtyabUNg9KiHfe6qj2QIwoZLT7AE2H20o
 CwKyM1O6SVgg5vP+1MP0V7AEdsOxa4UwO9IppZE7rd+YaKfKxjq4LM8o56mihs7B/MY=
X-Google-Smtp-Source: AGHT+IHrBv7vxPgrrtJ0Kcv9NhG6+27FIaBrXmgVMG76k0HKdpuiE4hPDMzjTBPN3jJWeMTNG1gg6w==
X-Received: by 2002:a17:907:7241:b0:ac0:527c:9cd5 with SMTP id
 a640c23a62f3a-ac330441df6mr1828641766b.42.1742303468234; 
 Tue, 18 Mar 2025 06:11:08 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:07 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 11/21] hw/misc: Add Beckhoff CCAT device
Date: Tue, 18 Mar 2025 14:08:02 +0100
Message-ID: <20250318130817.119636-12-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

This adds the Beckhoff Communication Controller (CCAT). The information
block, EEPROM interface and DMA controller are currently  implemented.

The EEPROM provides production information for Beckhoff Devices.
An EEPORM binary must therefor be handed over. It should be aligned to
a power of two. If no EEPROM binary is handed over an empty EEPROM of
size 4096 is initialized.

This device is needed for the Beckhoff CX7200 board emulation.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/misc/Kconfig         |   3 +
 hw/misc/beckhoff_ccat.c | 365 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build     |   1 +
 3 files changed, 369 insertions(+)
 create mode 100644 hw/misc/beckhoff_ccat.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1bc4228572..c264862046 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -225,4 +225,7 @@ config XLNX_VERSAL_TRNG
 config DDR_CTRLR
     bool
 
+config BECKHOFF_CCAT
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/beckhoff_ccat.c b/hw/misc/beckhoff_ccat.c
new file mode 100644
index 0000000000..3ab1259702
--- /dev/null
+++ b/hw/misc/beckhoff_ccat.c
@@ -0,0 +1,365 @@
+/*
+ * Beckhoff Communication Controller Emulation
+ *
+ * Copyright (c) Beckhoff Automation GmbH. & Co. KG
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
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
+
+#ifndef CCAT_ERR_DEBUG
+#define CCAT_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (CCAT_ERR_DEBUG > (level)) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DB_PRINT(...) DB_PRINT_L(0, ## __VA_ARGS__)
+
+#define TYPE_BECKHOFF_CCAT "beckhoff-ccat"
+#define BECKHOFF_CCAT(obj) \
+    OBJECT_CHECK(BeckhoffCcat, (obj), TYPE_BECKHOFF_CCAT)
+
+#define MAX_NUM_SLOTS 32
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
+#define CCAT_INFO_BLOCK_PARAMS (MAX_NUM_SLOTS << 0) | (0x1 << 8) | \
+                              (0x1 << 16) | (0x1 << 24)
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
+    int64_t eeprom_size;
+} BeckhoffCcat;
+
+typedef struct __attribute__((packed)) CcatFunctionBlock {
+    uint16_t type;
+    uint16_t revision;
+    uint32_t parameter;
+    uint32_t address_offset;
+    uint32_t size;
+} CcatFunctionBlock;
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
+    uint64_t val = 0;
+    memcpy(&val, &s->mem[addr], size);
+    return val;
+}
+
+static void beckhoff_ccat_eeprom_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    uint64_t eeprom_adr;
+    switch (addr) {
+    case EEPROM_CMD_OFFSET:
+        eeprom_adr = *(uint32_t *)&s->mem[EEPROM_ADR_OFFSET];
+        eeprom_adr = (eeprom_adr * 2) % s->eeprom_size;
+        if (val & EEPROM_CMD_READ_MASK) {
+            uint64_t buf = 0;
+            uint32_t bytes_to_read = 8;
+            if (eeprom_adr > s->eeprom_size - 8) {
+                bytes_to_read = s->eeprom_size - eeprom_adr;
+            }
+            memcpy(&buf, s->eeprom_storage + eeprom_adr, bytes_to_read);
+            *(uint64_t *)&s->mem[EEPROM_DATA_OFFSET] = buf;
+
+        } else if (val & EEPROM_CMD_WRITE_MASK) {
+            uint32_t buf = *(uint32_t *)&s->mem[EEPROM_DATA_OFFSET];
+            memcpy(s->eeprom_storage + eeprom_adr, &buf, 2);
+            sync_eeprom(s);
+        }
+        break;
+    default:
+            memcpy(&s->mem[addr], &val, size);
+    }
+}
+
+static uint64_t beckhoff_ccat_dma_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    uint64_t val = 0;
+
+    switch (addr) {
+    case DMA_TRANSFER_OFFSET:
+        if (s->mem[DMA_TRANSFER_OFFSET] & 0x1) {
+            DB_PRINT("DMA transfer finished\n");
+            s->mem[DMA_TRANSFER_OFFSET] = 0;
+        }
+        break;
+    }
+    memcpy(&val, &s->mem[addr], size);
+    return val;
+}
+
+static void beckhoff_ccat_dma_write(void *opaque, hwaddr addr, uint64_t val,
+                           unsigned size)
+{
+    BeckhoffCcat *s = opaque;
+    switch (addr) {
+    case DMA_TRANSFER_OFFSET:
+        uint8_t len = s->mem[DMA_TRANSFER_LENGTH_OFFSET];
+        uint8_t *mem_buf = &s->mem[DMA_BUFFER_OFFSET];
+
+        if (s->mem[DMA_DIRECTION_OFFSET] & DMA_DIRECTION_MASK) {
+            dma_addr_t dmaAddr = *(uint32_t *)&s->mem[DMA_HOST_ADR_OFFSET];
+            dma_memory_read(&address_space_memory, dmaAddr,
+                            mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
+        } else {
+            dma_addr_t dmaAddr = *(uint32_t *)&s->mem[DMA_HOST_ADR_OFFSET];
+            dma_memory_write(&address_space_memory, dmaAddr + 8,
+                                mem_buf, len * 8, MEMTXATTRS_UNSPECIFIED);
+        }
+        break;
+    }
+    memcpy(&s->mem[addr], &val, size);
+}
+static uint64_t beckhoff_ccat_read(void *opaque, hwaddr addr, unsigned size)
+{
+    DB_PRINT("CCAT_READ addr=0x%lx size=%u\n", addr, size);
+
+    BeckhoffCcat *s = opaque;
+    uint64_t val = 0;
+
+    if (addr > CCAT_MEM_SIZE - size) {
+        error_report("Overflow. Address or size is too large.\n");
+        exit(1);
+    }
+
+    if (addr >= CCAT_EEPROM_OFFSET &&
+                        addr <= CCAT_EEPROM_OFFSET + s->eeprom_size) {
+        return beckhoff_ccat_eeprom_read(opaque, addr, size);
+    } else if (addr >= CCAT_DMA_OFFSET &&
+                        addr <= CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
+        return beckhoff_ccat_dma_read(opaque, addr, size);
+    } else {
+         memcpy(&val, &s->mem[addr], size);
+    }
+
+    return val;
+}
+
+static void beckhoff_ccat_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    DB_PRINT("CCAT_WRITE addr=0x%lx size=%u val=0x%lx\n", addr, size, val);
+
+    BeckhoffCcat *s = opaque;
+
+    if (addr > CCAT_MEM_SIZE - size) {
+        error_report("Overflow. Address or size is too large.\n");
+        exit(1);
+    }
+
+    if (addr >= CCAT_EEPROM_OFFSET &&
+                        addr <= CCAT_EEPROM_OFFSET + s->eeprom_size) {
+        beckhoff_ccat_eeprom_write(opaque, addr, val, size);
+    } else if (addr >= CCAT_DMA_OFFSET &&
+                        addr <= CCAT_DMA_OFFSET + CCAT_DMA_SIZE) {
+        beckhoff_ccat_dma_write(opaque, addr, val, size);
+    } else {
+        memcpy(&s->mem[addr], &val, size);
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
+
+static void beckhoff_ccat_reset(DeviceState *dev)
+{
+    BeckhoffCcat *s = BECKHOFF_CCAT(dev);
+
+    CcatFunctionBlock function_blocks[MAX_NUM_SLOTS] = {0};
+
+    CcatFunctionBlock info_block = {
+        .type = CCAT_FUN_TYPE_ENTRY,
+        .revision = 0x0001,
+        .parameter = CCAT_INFO_BLOCK_PARAMS,
+        .address_offset = CCAT_ID_1,
+        .size = CCAT_ID_2
+    };
+    CcatFunctionBlock eeprom_block = {
+        .type = CCAT_FUN_TYPE_EEPROM,
+        .revision = 0x0001,
+        .parameter = 0,
+        .address_offset = CCAT_EEPROM_OFFSET,
+        .size = CCAT_EEPROM_SIZE
+    };
+    CcatFunctionBlock dma_block = {
+        .type = CCAT_FUN_TYPE_DMA,
+        .revision = 0x0000,
+        .parameter = 0,
+        .address_offset = CCAT_DMA_OFFSET,
+        .size = CCAT_DMA_SIZE
+    };
+
+    /*
+     * The EEPROM interface is usually at function slot 11.
+     * The DMA controller is usually at function slot 15.
+     */
+    function_blocks[0] = info_block;
+    function_blocks[11] = eeprom_block;
+    function_blocks[15] = dma_block;
+
+    memcpy(&s->mem[0], function_blocks, sizeof(function_blocks));
+}
+
+static void beckhoff_ccat_realize(DeviceState *dev, Error **errp)
+{
+    BeckhoffCcat *s = BECKHOFF_CCAT(dev);
+    BlockBackend *blk;
+
+    blk = blk_by_name("ccat-eeprom");
+
+    if (blk) {
+        uint64_t blk_size = blk_getlength(blk);
+        if (!is_power_of_2(blk_size)) {
+            error_report("Blockend size is not a power of two.");
+        }
+
+        if (blk_size < 512) {
+            error_report("Blockend size is too small. Using backup.");
+            s->eeprom_size = EEPROM_MEMORY_SIZE;
+            s->eeprom_storage = blk_blockalign(NULL, s->eeprom_size);
+            memset(s->eeprom_storage, 0x00, s->eeprom_size);
+        } else {
+            DB_PRINT("EEPROM block backend found\n");
+            blk_set_perm(blk, BLK_PERM_WRITE, BLK_PERM_ALL, errp);
+
+            s->eeprom_size = blk_size;
+            s->eeprom_blk = blk;
+            s->eeprom_storage = blk_blockalign(s->eeprom_blk, s->eeprom_size);
+
+            if (!blk_check_size_and_read_all(s->eeprom_blk, DEVICE(s),
+                                             s->eeprom_storage, s->eeprom_size,
+                                             errp)) {
+                exit(1);
+            }
+        }
+    } else {
+        s->eeprom_size = EEPROM_MEMORY_SIZE;
+        s->eeprom_storage = blk_blockalign(NULL, s->eeprom_size);
+        memset(s->eeprom_storage, 0x00, s->eeprom_size);
+    }
+
+    beckhoff_ccat_reset(dev);
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
+static void beckhoff_ccat_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    dc->realize = beckhoff_ccat_realize;
+}
+
+static const TypeInfo beckhoff_ccat_info = {
+ .name = TYPE_BECKHOFF_CCAT,
+ .parent = TYPE_SYS_BUS_DEVICE,
+ .instance_size = sizeof(BeckhoffCcat),
+ .class_init = beckhoff_ccat_class_init,
+ .instance_init = beckhoff_ccat_init,
+};
+
+static void beckhoff_ccat_register_types(void)
+{
+    type_register_static(&beckhoff_ccat_info);
+}
+
+type_init(beckhoff_ccat_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8d4c4279c4..ca0b261715 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -14,6 +14,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_BECKHOFF_CCAT', if_true: files('beckhoff_ccat.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.49.0


