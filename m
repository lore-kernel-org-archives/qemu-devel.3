Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89761CD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsV6-0000yJ-TQ; Mon, 18 May 2026 03:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUS-0000gW-VP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wOsUP-0000Ro-En
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:34:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so13375635e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779089652; x=1779694452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkpw8uNTIXSCp40Ig7WNHrAYDPuWwd/JK/wFhcbksMI=;
 b=KrvitqjcUlw5R2UmKmziLtXa2rBHowoMbhaDr9MjKpiyI4Ethv9bdO1IeP2A4pLq+7
 F5Z1xoSRAMLGniDSrPma1LnqZM32fWJSB+IFhEBgQZ8Kfc8YzjW2T2pbuSqNOFOcTHLq
 jmecfZqmjBi6gl7XgZZRP5E30FG5N3C/eW9JfxaceC0G86lY5ctYLKM07UiEGcF8Zhr/
 jbkcyPSqe2hQ18J3m4oTIDerSSQ1pP5+E0yHCUpZJ3/YHarjRtIJu2vDcQXa87hET14U
 NvsOwem7OUoaYEt4aBPN6pYuu9EQCBukwgw8YQA8Nuq7FbyyLrKv4unBdJfrX5UcIdFI
 6p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779089652; x=1779694452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkpw8uNTIXSCp40Ig7WNHrAYDPuWwd/JK/wFhcbksMI=;
 b=smc0T/XqJLCQm4fCF7Kzz7DiJ8KJzcNI8n/uEMkwRfRpfMfMtQrf/vksbjcv97d0b+
 ALiKYbPMEE2vZKxe0sS6Yov9KyVQvK9NfS56GWbIJn34XLpwH5AM6ysdjacPETme2Hnv
 VtpAsO11U4m9GqqyjtGU1l+VhekNFmam9AMoPxQn1YSS1MGN+Yr0JkUwoYJCEJd+Fx+o
 H3nlgCTlqRQBCBMQ1E63rz+VRE1aRQRVXSG26FXxInves+EoZoA1mW3qs5FSooHPZXus
 JBFztU95z9yN8yGh4TFCye7z+npUrgEfb6j0E6ZiXppuV8xdU5+EUfPozHepzNcbfOI0
 5ryQ==
X-Gm-Message-State: AOJu0YzgySzbs6J0k8BbKSUWHjPt11ppxYzWyo/gYwYNZdFWlRfNdGM1
 gDp9XhTuIYucB7RvlWLT995VFsgsFDVMSOvSO5phRj1t1+Xvwj2KVvyxXhbcyl9w
X-Gm-Gg: Acq92OElu7Yz9uVU2S+rfGEPpd4GtkoU+AlI5jVbev8tfR3e6p/Nl+F8+0I9giJy+rG
 KYPcU91I5pBKC09SUJmGLMkGFvhT2CJBW7LnV39esFBrCerk1E55khgXylFdHgkGGaHMOgIFcma
 k/q0OvQa9Y5VEyS99/xmniqDgnjXJ1F2feirAO+5EoyV7rD31OlHgkDR+IqlIX3FB3ZWLCKNowr
 4yA7eVY9G5TkRw5m6oh8mb0JB9PlNcczzAiPscDYBhRhWlLcnrH4N6A/uMgW1AUZFDC3lxsPIsr
 y5VR3Hf/btXzOd4ALu53A0TtaxDMnNIzgU41pf4CKzkZmNAYOFMkLcgwVgrsFDyUhHEPbAqcWJT
 o6xSA53tsh5yG6FisLRWJhSR3dDsw8H/rintf+x7pL48qvfmnM6YhEBU3uY3HVbJCeP6gNTeI5o
 dHohr6mDAL1AjrBkHey4lRfBfiX2Msd86CM5R2iUz367nwj56BmCfklW6dMVejCoYEB/Y=
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id
 5b1f17b1804b1-48fe60ecb9cmr192478205e9.10.1779089651827; 
 Mon, 18 May 2026 00:34:11 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc08:b284:85e6:f7f4:1a4a:4dfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm32590222f8f.11.2026.05.18.00.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 00:34:11 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yannick Vossen <Y.Vossen@beckhoff.com>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Corvin Koehne <C.Koehne@beckhoff.com>, qemu-block@nongnu.org
Subject: [PATCH v7 08/16] hw/misc: Add Beckhoff CCAT device
Date: Mon, 18 May 2026 09:33:53 +0200
Message-ID: <20260518073401.11279-9-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518073401.11279-1-corvin.koehne@gmail.com>
References: <20260518073401.11279-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32b.google.com
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
 hw/misc/beckhoff_ccat.c | 339 ++++++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build     |   1 +
 3 files changed, 343 insertions(+)
 create mode 100644 hw/misc/beckhoff_ccat.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1543ee6653..2217b2005b 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -257,4 +257,7 @@ config XLNX_VERSAL_TRNG
 config XLNX_ZYNQ_DDRC
     bool
 
+config BECKHOFF_CCAT
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/beckhoff_ccat.c b/hw/misc/beckhoff_ccat.c
new file mode 100644
index 0000000000..a29e9f6166
--- /dev/null
+++ b/hw/misc/beckhoff_ccat.c
@@ -0,0 +1,339 @@
+/*
+ * Beckhoff Communication Controller Emulation
+ *
+ * Copyright (c) Beckhoff Automation GmbH. & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "qemu/units.h"
+#include "hw/core/register.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
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
+#define CCAT_MEM_SIZE (64 * KiB)
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
+static void beckhoff_ccat_class_init(ObjectClass *klass, const void *data)
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
index 23265f6035..8e1e6e7586 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -15,6 +15,7 @@ system_ss.add(when: 'CONFIG_PL310', if_true: files('arm_l2x0.c'))
 system_ss.add(when: 'CONFIG_INTEGRATOR_DEBUG', if_true: files('arm_integrator_debug.c'))
 system_ss.add(when: 'CONFIG_A9SCU', if_true: files('a9scu.c'))
 system_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
+system_ss.add(when: 'CONFIG_BECKHOFF_CCAT', if_true: files('beckhoff_ccat.c'))
 
 system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
-- 
2.47.3


