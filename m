Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B997FE7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 22:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPqkD-0002Fh-Sg; Mon, 23 Dec 2024 17:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjr-00024N-Gm
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tPqjm-000707-Cx
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 17:17:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so48366365e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 14:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734992236; x=1735597036;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTW3PItu33BhI5IkVRjrY9Xz/ZsiIXnA27EwTGw7g/8=;
 b=1neVMuP/Z1r1Mjx/1ABCwntwsuqOiSnkWmablQIERylImz02U9tZgOQzV839j0tPla
 dmNWrcWHWRpNvf2uP4dpTengkDiQlAI+oDpXzHIkktXSt7PsUiy7q72+uAQOwnCELI58
 5M0MuikAVrPgGiGiknVPoIjoHa6iaQav/oSfulQxm3164g5KulDAF0Pn33sfbsQEgB2B
 t17UTe61z7R4SVekg3qmk6SNR9iOpdmFYl1sIhHEWkovBTiHBFDgy+4ggEyIKGEUWrJJ
 yz8gYk7HMggV38HKfzgnwfEjGol1DW7i4ibccBqQM1QUVbOAn3VDPDtHEn678Wbc2/xh
 NwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734992236; x=1735597036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTW3PItu33BhI5IkVRjrY9Xz/ZsiIXnA27EwTGw7g/8=;
 b=uKYJ2k/2zew7VeLTS2rocdjjYFB/Hem3Q8o3+FpobEYQiXegvxe3ljV1dXu7JKnVKl
 k6BME8pEzdHnJc1i8hfO3eWGe2R8+K77CwJx77WGBH0c/rY7GifkgROnZvteePCeRfqG
 FDe/c9bG9dqjgB3BxlQ0BLPvZeJGUVbd1N6OCus/4oITdU8cHwYoCNeQCwHL3ceK6V7a
 0r+tzNFIvO+ICI/J9NGWpz7n+TcotdBK4MrY1wW5lU45V+dBHHwHNQP45DMqVjTyO2Ei
 hz5b8R0d0sDniLkrz2wjc5/Ndp5SEwCT2Hhw+LWgnx1OV2QnJTC9UIdvVdVdRI0/MWCO
 TSGg==
X-Gm-Message-State: AOJu0YxFjtvpf/RbeEscuKs2n5hDx5qIn5RHYs7vlYXS3HMihfe3IabZ
 9ipzWKcL9MU6dHZ7L7CqLdDSNCgh+elCcxyoWzjygnG7iBXYSA6nA/9b4Y2gTXK0XzmAJj7BHgW
 bFg==
X-Gm-Gg: ASbGncsQiYZ4eM2+OzBI2FeT7w/Pgtdfs6868N6NTGY7qpZ9l7Y06l9e1Z7EDvnsahR
 VadMMmwxlFi5URdWsMxcTuaeNb29U2qcN783EBS6aOGHSFyDTqsPyekbcMeJWsqDGE+pWsP4POc
 /wlPF0Eeggc5IUveZ+FKNbsEQEzJ7eV/KcblL+FBKxCjusnkyQf/loIWHBfx3LbhpRr5q5rc+xZ
 mr7UuFhlD+URjTscRiBkDvw//KlhsFxvkYBJzr9vfXy2Xdih95IcwDkhfDF04+JZbkYSInfV7zZ
 4/KfAdimlAQQuXLZNV4beNC/JkgOnqfo
X-Google-Smtp-Source: AGHT+IENQBBbU0NGxjqljRsRHIWRGrfwR5DmhnS32KrOrN4Ib81iALkGpcJ1ku1QeakSZWB9Xi4KuQ==
X-Received: by 2002:a05:600c:4f83:b0:434:f4f9:8104 with SMTP id
 5b1f17b1804b1-43668b79023mr100664465e9.33.1734992235944; 
 Mon, 23 Dec 2024 14:17:15 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611fc161sm147561075e9.10.2024.12.23.14.17.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Dec 2024 14:17:14 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v16 10/14] hw/vmapple/bdif: Introduce vmapple backdoor
 interface
Date: Mon, 23 Dec 2024 23:16:41 +0100
Message-Id: <20241223221645.29911-11-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241223221645.29911-1-phil@philjordan.eu>
References: <20241223221645.29911-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32d;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

The VMApple machine exposes AUX and ROOT block devices (as well as USB OTG
emulation) via virtio-pci as well as a special, simple backdoor platform
device.

This patch implements this backdoor platform device to the best of my
understanding. I left out any USB OTG parts; they're only needed for
guest recovery and I don't understand the protocol yet.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v4:

 * Moved most header code to .c, rest to vmapple.h
 * Better compliance with coding, naming, and formatting conventions.

v8:

 * Replaced uses of cpu_physical_memory_read with dma_memory_read.
 * Replaced an instance of g_free with g_autofree.

v9:

 * Replaced uses of cpu_physical_memory_write with dma_memory_write.

v15:

 * Constified the property table.

v16:

 * Fixed #include path breakage from recent sysemu->system path rename.
 * Removed the DEFINE_PROP_END_OF_LIST marker to match recent upstream
   changes.

 hw/vmapple/Kconfig           |   3 +
 hw/vmapple/bdif.c            | 274 +++++++++++++++++++++++++++++++++++
 hw/vmapple/meson.build       |   1 +
 hw/vmapple/trace-events      |   5 +
 include/hw/vmapple/vmapple.h |   2 +
 5 files changed, 285 insertions(+)
 create mode 100644 hw/vmapple/bdif.c

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index a73504d599..68f88876eb 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -1,3 +1,6 @@
 config VMAPPLE_AES
     bool
 
+config VMAPPLE_BDIF
+    bool
+
diff --git a/hw/vmapple/bdif.c b/hw/vmapple/bdif.c
new file mode 100644
index 0000000000..5827dd2aab
--- /dev/null
+++ b/hw/vmapple/bdif.c
@@ -0,0 +1,274 @@
+/*
+ * VMApple Backdoor Interface
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "trace.h"
+#include "hw/vmapple/vmapple.h"
+#include "hw/sysbus.h"
+#include "hw/block/block.h"
+#include "qapi/error.h"
+#include "system/block-backend.h"
+#include "system/dma.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(VMAppleBdifState, VMAPPLE_BDIF)
+
+struct VMAppleBdifState {
+    SysBusDevice parent_obj;
+
+    BlockBackend *aux;
+    BlockBackend *root;
+    MemoryRegion mmio;
+};
+
+#define VMAPPLE_BDIF_SIZE   0x00200000
+
+#define REG_DEVID_MASK      0xffff0000
+#define DEVID_ROOT          0x00000000
+#define DEVID_AUX           0x00010000
+#define DEVID_USB           0x00100000
+
+#define REG_STATUS          0x0
+#define REG_STATUS_ACTIVE     BIT(0)
+#define REG_CFG             0x4
+#define REG_CFG_ACTIVE        BIT(1)
+#define REG_UNK1            0x8
+#define REG_BUSY            0x10
+#define REG_BUSY_READY        BIT(0)
+#define REG_UNK2            0x400
+#define REG_CMD             0x408
+#define REG_NEXT_DEVICE     0x420
+#define REG_UNK3            0x434
+
+typedef struct VblkSector {
+    uint32_t pad;
+    uint32_t pad2;
+    uint32_t sector;
+    uint32_t pad3;
+} VblkSector;
+
+typedef struct VblkReqCmd {
+    uint64_t addr;
+    uint32_t len;
+    uint32_t flags;
+} VblkReqCmd;
+
+typedef struct VblkReq {
+    VblkReqCmd sector;
+    VblkReqCmd data;
+    VblkReqCmd retval;
+} VblkReq;
+
+#define VBLK_DATA_FLAGS_READ  0x00030001
+#define VBLK_DATA_FLAGS_WRITE 0x00010001
+
+#define VBLK_RET_SUCCESS  0
+#define VBLK_RET_FAILED   1
+
+static uint64_t bdif_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t ret = -1;
+    uint64_t devid = offset & REG_DEVID_MASK;
+
+    switch (offset & ~REG_DEVID_MASK) {
+    case REG_STATUS:
+        ret = REG_STATUS_ACTIVE;
+        break;
+    case REG_CFG:
+        ret = REG_CFG_ACTIVE;
+        break;
+    case REG_UNK1:
+        ret = 0x420;
+        break;
+    case REG_BUSY:
+        ret = REG_BUSY_READY;
+        break;
+    case REG_UNK2:
+        ret = 0x1;
+        break;
+    case REG_UNK3:
+        ret = 0x0;
+        break;
+    case REG_NEXT_DEVICE:
+        switch (devid) {
+        case DEVID_ROOT:
+            ret = 0x8000000;
+            break;
+        case DEVID_AUX:
+            ret = 0x10000;
+            break;
+        }
+        break;
+    }
+
+    trace_bdif_read(offset, size, ret);
+    return ret;
+}
+
+static void le2cpu_sector(VblkSector *sector)
+{
+    sector->sector = le32_to_cpu(sector->sector);
+}
+
+static void le2cpu_reqcmd(VblkReqCmd *cmd)
+{
+    cmd->addr = le64_to_cpu(cmd->addr);
+    cmd->len = le32_to_cpu(cmd->len);
+    cmd->flags = le32_to_cpu(cmd->flags);
+}
+
+static void le2cpu_req(VblkReq *req)
+{
+    le2cpu_reqcmd(&req->sector);
+    le2cpu_reqcmd(&req->data);
+    le2cpu_reqcmd(&req->retval);
+}
+
+static void vblk_cmd(uint64_t devid, BlockBackend *blk, uint64_t gp_addr,
+                     uint64_t static_off)
+{
+    VblkReq req;
+    VblkSector sector;
+    uint64_t off = 0;
+    g_autofree char *buf = NULL;
+    uint8_t ret = VBLK_RET_FAILED;
+    int r;
+    MemTxResult dma_result;
+
+    dma_result = dma_memory_read(&address_space_memory, gp_addr,
+                                 &req, sizeof(req), MEMTXATTRS_UNSPECIFIED);
+    if (dma_result != MEMTX_OK) {
+        goto out;
+    }
+
+    le2cpu_req(&req);
+
+    if (req.sector.len != sizeof(sector)) {
+        goto out;
+    }
+
+    /* Read the vblk command */
+    dma_result = dma_memory_read(&address_space_memory, req.sector.addr,
+                                 &sector, sizeof(sector),
+                                 MEMTXATTRS_UNSPECIFIED);
+    if (dma_result != MEMTX_OK) {
+        goto out;
+    }
+    le2cpu_sector(&sector);
+
+    off = sector.sector * 512ULL + static_off;
+
+    /* Sanity check that we're not allocating bogus sizes */
+    if (req.data.len > 128 * MiB) {
+        goto out;
+    }
+
+    buf = g_malloc0(req.data.len);
+    switch (req.data.flags) {
+    case VBLK_DATA_FLAGS_READ:
+        r = blk_pread(blk, off, req.data.len, buf, 0);
+        trace_bdif_vblk_read(devid == DEVID_AUX ? "aux" : "root",
+                             req.data.addr, off, req.data.len, r);
+        if (r < 0) {
+            goto out;
+        }
+        dma_result = dma_memory_write(&address_space_memory, req.data.addr, buf,
+                                      req.data.len, MEMTXATTRS_UNSPECIFIED);
+        if (dma_result == MEMTX_OK) {
+            ret = VBLK_RET_SUCCESS;
+        }
+        break;
+    case VBLK_DATA_FLAGS_WRITE:
+        /* Not needed, iBoot only reads */
+        break;
+    default:
+        break;
+    }
+
+out:
+    dma_memory_write(&address_space_memory, req.retval.addr, &ret, 1,
+                     MEMTXATTRS_UNSPECIFIED);
+}
+
+static void bdif_write(void *opaque, hwaddr offset,
+                       uint64_t value, unsigned size)
+{
+    VMAppleBdifState *s = opaque;
+    uint64_t devid = (offset & REG_DEVID_MASK);
+
+    trace_bdif_write(offset, size, value);
+
+    switch (offset & ~REG_DEVID_MASK) {
+    case REG_CMD:
+        switch (devid) {
+        case DEVID_ROOT:
+            vblk_cmd(devid, s->root, value, 0x0);
+            break;
+        case DEVID_AUX:
+            vblk_cmd(devid, s->aux, value, 0x0);
+            break;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps bdif_ops = {
+    .read = bdif_read,
+    .write = bdif_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+    },
+};
+
+static void bdif_init(Object *obj)
+{
+    VMAppleBdifState *s = VMAPPLE_BDIF(obj);
+
+    memory_region_init_io(&s->mmio, obj, &bdif_ops, obj,
+                         "VMApple Backdoor Interface", VMAPPLE_BDIF_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static const Property bdif_properties[] = {
+    DEFINE_PROP_DRIVE("aux", VMAppleBdifState, aux),
+    DEFINE_PROP_DRIVE("root", VMAppleBdifState, root),
+};
+
+static void bdif_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "VMApple Backdoor Interface";
+    device_class_set_props(dc, bdif_properties);
+}
+
+static const TypeInfo bdif_info = {
+    .name          = TYPE_VMAPPLE_BDIF,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VMAppleBdifState),
+    .instance_init = bdif_init,
+    .class_init    = bdif_class_init,
+};
+
+static void bdif_register_types(void)
+{
+    type_register_static(&bdif_info);
+}
+
+type_init(bdif_register_types)
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index bcd4dcb28d..d4624713de 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
+system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
index 0d4a73d7d1..d86f64d50f 100644
--- a/hw/vmapple/trace-events
+++ b/hw/vmapple/trace-events
@@ -14,3 +14,8 @@ aes_2_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
 aes_2_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
 aes_dump_data(const char *desc, const char *hex) "%s%s"
 
+# bdif.c
+bdif_read(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
+bdif_write(uint64_t offset, uint32_t size, uint64_t value) "offset=0x%"PRIx64" size=0x%x value=0x%"PRIx64
+bdif_vblk_read(const char *dev, uint64_t addr, uint64_t offset, uint32_t len, int r) "dev=%s addr=0x%"PRIx64" off=0x%"PRIx64" size=0x%x r=%d"
+
diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
index 6762b6c869..9090e9c5ac 100644
--- a/include/hw/vmapple/vmapple.h
+++ b/include/hw/vmapple/vmapple.h
@@ -14,4 +14,6 @@
 
 #define TYPE_APPLE_AES "apple-aes"
 
+#define TYPE_VMAPPLE_BDIF "vmapple-bdif"
+
 #endif /* HW_VMAPPLE_VMAPPLE_H */
-- 
2.39.5 (Apple Git-154)


