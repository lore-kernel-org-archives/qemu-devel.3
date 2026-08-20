Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99337C5DF89
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CL-0004wH-5j; Thu, 20 Aug 2026 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CI-0004u8-On
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:42 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CF-0001ZG-6Q
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:42 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b14so345043a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230117; x=1787834917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mlx8fyJPMGGwXCk+Dpb/GgVYA1CTHyr1kyqzPiMgA+0=;
 b=fKC57uy4gMIkxDvrMk4KcsxGGyU5vPy9fVQcZi5K89ivbKhMdDdw0WxcK5kZaH6swk
 B42z552NFKM5COFMGugpXoOjYOoimvDv47udyjQfxIEyElHZo/VxOuUDgmrqlJX3bpGT
 A1FmypbAY71ptC1U30lnXyaQIDp+Vj+IzTprY4qYpeoCwyVGX6jyH0QPyfyfn7AdWoKZ
 6CgTiV+E81aDxBGuD9qsPpLu5UF5lCEde0CG6Rm7TtbFbjqiK2ec+uIQiMIAdN176GC/
 +0J1VjBR1ekuMz/2KR8f8N9TnXCi1QODKhFWQS/7RYX4BmXCXsOSRAyh01NdMfgxVLGm
 0Tng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230117; x=1787834917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mlx8fyJPMGGwXCk+Dpb/GgVYA1CTHyr1kyqzPiMgA+0=;
 b=YINow1GyhYFzHAeo/OjxTd5LmmKs6F/ED9awWmoEQU675Aak0PYigB6TuSVJXI51l/
 hhcMHbLjO8DS+x0RCG63Z3gUxQ/2DYjK5yMPkTlNXf4LAVx2i3dp7W2w3r0IvVsGsZVk
 FCeQG/vXMfOpKU3BtuIBB2ju2i6SV028x0WyCKFlYXT+oVwO7a5R2QAS5CQxqDGj0aAx
 bmRBSZD5ZOU4DMnJfQAULsNH8C6i45ENEnM9u/mZ7HM1+ol+cRVnQyCcS/2lFAnBlhhJ
 4NM+j6NkG+2N6lsaZCugz3r6j9AZQmL0TtYluMHMpJ4Emjtz8bJmMYUVv5tO+Xv9A/Il
 2G8g==
X-Gm-Message-State: AFuF++koT1wMc9w7sFQsonmhcn7R3uhadoGQ028hGMd9WdYN+cRiYL1r
 fF9g+RJ7S/XR9pQtH36gHktcVkxvxIWszx46TZJuY4uBRdoGgxyDgOHrpsMpmH3U
X-Gm-Gg: AR+sD11I0AwdG1Z3Mx515h7rPcz+H2D6AMQC7U+PJyTYltPz0GQOIa+WbHmgJwxrAiQ
 ob+HvHD7E7kT6KB2n3w2BKY5VtnEKTyXiTpUnfZY51Taujvo1qW6QJ317XPGcIeBATWmyeUYESx
 R+YV02VErBN1lnqXehgWoYorANknuOfwlpe+V6vh4swwMW9y8B8SwEFnvFXepL+3WtanBYxK/5n
 I3WR/ZnRPV7zlmnH/mDxBH5tp1mDqtKufaZwwLKs38u5OIYG1v4BRqKNFGelQhRT7dpb5hW2GQE
 T6QmwoaVWOTThpwz175A4mFyGEZAtiso105W/FdsdfMlDne0DX/laFWLNcBxts8gkUyu/t5zkSx
 PMH9Iu2/7JXNpSOZ9cqvU6Sdpc64oiVfBridY88vrSUxw7xDov84mZxpFcuo41r9ECJyQ1+SY+y
 u+UqNtwB5JhuWA+Ob7p3EJFy9nX8mQvNEfQDNcJ7gjXBZ2qtSZdmhUwI16ml0ijehL4juQd+O2/
 9mc521VIoI=
X-Received: by 2002:a05:6402:540e:b0:6a0:8885:e6f0 with SMTP id
 4fb4d7f45d1cf-6a403296d5fmr9996481a12.3.1787230117194; 
 Thu, 20 Aug 2026 05:48:37 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:36 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 06/14] hw/misc: add TI K3 CTRL_MMR, GTC, DDRSS,
 SDHCI PHY and TRNG models
Date: Thu, 20 Aug 2026 14:48:06 +0200
Message-ID: <20260820124824.618671-7-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add the small K3 support blocks the boot chain touches:

 - ti-k3-ctrlmmr: control module registers, including the DEVSTAT boot
   pins, which the ROM and SPL use to select the boot device.
 - ti-k3-gtc: global timebase counter, read by TF-A.
 - ti-k3-ddrss: DDR subsystem stub that reports a successful DRAM init
   (including BIST/ECC priming status) to the R5 SPL.
 - ti-k3-sdhci-phy: PHY control/calibration registers of the K3 SDHCI
   wrapper, reporting calibration as done.
 - ti-k3-trng: TRNG stub used by OP-TEE.

These are register-level stubs: they implement the handshakes that
firmware polls for, not the underlying hardware behaviour.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/misc/Kconfig                   |  15 ++++
 hw/misc/meson.build               |   6 ++
 hw/misc/ti-k3-ctrlmmr.c           | 103 ++++++++++++++++++++++
 hw/misc/ti-k3-ddrss.c             |  98 +++++++++++++++++++++
 hw/misc/ti-k3-gtc.c               | 100 +++++++++++++++++++++
 hw/misc/ti-k3-sdhci-phy.c         |  91 +++++++++++++++++++
 hw/misc/ti-k3-trng.c              | 139 ++++++++++++++++++++++++++++++
 hw/misc/trace-events              |   4 +
 include/hw/misc/ti-k3-ctrlmmr.h   |  26 ++++++
 include/hw/misc/ti-k3-ddrss.h     |  26 ++++++
 include/hw/misc/ti-k3-gtc.h       |  23 +++++
 include/hw/misc/ti-k3-sdhci-phy.h |  26 ++++++
 include/hw/misc/ti-k3-trng.h      |  35 ++++++++
 13 files changed, 692 insertions(+)
 create mode 100644 hw/misc/ti-k3-ctrlmmr.c
 create mode 100644 hw/misc/ti-k3-ddrss.c
 create mode 100644 hw/misc/ti-k3-gtc.c
 create mode 100644 hw/misc/ti-k3-sdhci-phy.c
 create mode 100644 hw/misc/ti-k3-trng.c
 create mode 100644 include/hw/misc/ti-k3-ctrlmmr.h
 create mode 100644 include/hw/misc/ti-k3-ddrss.h
 create mode 100644 include/hw/misc/ti-k3-gtc.h
 create mode 100644 include/hw/misc/ti-k3-sdhci-phy.h
 create mode 100644 include/hw/misc/ti-k3-trng.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index b8860dd3e7..3e499a902d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -143,6 +143,21 @@ config MPS2_SCC
     bool
     select LED
 
+config TI_K3_CTRLMMR
+    bool
+
+config TI_K3_GTC
+    bool
+
+config TI_K3_DDRSS
+    bool
+
+config TI_K3_SDHCI_PHY
+    bool
+
+config TI_K3_TRNG
+    bool
+
 config TZ_MPC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e86d9ad6b3..e973d7e8a4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -96,6 +96,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
@@ -122,6 +123,11 @@ system_ss.add(when: 'CONFIG_STM32L4X5_RCC', if_true: files('stm32l4x5_rcc.c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
 
+system_ss.add(when: 'CONFIG_TI_K3_CTRLMMR', if_true: files('ti-k3-ctrlmmr.c'))
+system_ss.add(when: 'CONFIG_TI_K3_GTC', if_true: files('ti-k3-gtc.c'))
+system_ss.add(when: 'CONFIG_TI_K3_DDRSS', if_true: files('ti-k3-ddrss.c'))
+system_ss.add(when: 'CONFIG_TI_K3_SDHCI_PHY', if_true: files('ti-k3-sdhci-phy.c'))
+system_ss.add(when: 'CONFIG_TI_K3_TRNG', if_true: files('ti-k3-trng.c'))
 system_ss.add(when: 'CONFIG_TZ_MPC', if_true: files('tz-mpc.c'))
 system_ss.add(when: 'CONFIG_TZ_MSC', if_true: files('tz-msc.c'))
 system_ss.add(when: 'CONFIG_TZ_PPC', if_true: files('tz-ppc.c'))
diff --git a/hw/misc/ti-k3-ctrlmmr.c b/hw/misc/ti-k3-ctrlmmr.c
new file mode 100644
index 0000000000..5925573075
--- /dev/null
+++ b/hw/misc/ti-k3-ctrlmmr.c
@@ -0,0 +1,103 @@
+/*
+ * TI K3 CTRL_MMR stub
+ *
+ * Minimal AM64x control MMR model: selected boot, reset-source and
+ * security-status registers are configurable; other reads return zero,
+ * writes are ignored.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/ti-k3-ctrlmmr.h"
+
+#define CTRLMMR_MAIN_DEVSTAT 0x30
+#define CTRLMMR_MCU_RST_SRC  0x18178
+/*
+ * K3_SEC_MGR_SYS_STATUS lives at offset 0x100 in the sec-ctrlmmr window.
+ * It reports the device type, e.g. GP or HS.
+ */
+#define CTRLMMR_SEC_MGR_SYS_STATUS 0x100
+#define CTRLMMR_SIZE 0x20000 /* partitions 0-7 */
+
+static uint64_t ti_k3_ctrlmmr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3CtrlMmrState *s = TI_K3_CTRLMMR(opaque);
+
+    if (addr == CTRLMMR_MAIN_DEVSTAT) {
+        return s->devstat;
+    }
+    if (addr == CTRLMMR_MCU_RST_SRC) {
+        return s->rst_src;
+    }
+    if (addr == CTRLMMR_SEC_MGR_SYS_STATUS) {
+        return s->sec_mgr_sys_status;
+    }
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented read @0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
+    return 0;
+}
+
+static void ti_k3_ctrlmmr_write(void *opaque, hwaddr addr, uint64_t val,
+                                unsigned size)
+{
+    /* lock-kick and pinmux writes are accepted and ignored. */
+}
+
+static const MemoryRegionOps ti_k3_ctrlmmr_ops = {
+    .read = ti_k3_ctrlmmr_read,
+    .write = ti_k3_ctrlmmr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void ti_k3_ctrlmmr_init(Object *obj)
+{
+    TIK3CtrlMmrState *s = TI_K3_CTRLMMR(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_ctrlmmr_ops, s,
+                          TYPE_TI_K3_CTRLMMR, CTRLMMR_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const Property ti_k3_ctrlmmr_properties[] = {
+    /* Default primary bootmode is eMMC (0x9 << 3). */
+    DEFINE_PROP_UINT32("devstat", TIK3CtrlMmrState, devstat, 0x48),
+    /*
+     * Report warm reset in MCU_RST_SRC. Cold/POR cause bits are not
+     * modelled by this reset-source stub.
+     */
+    DEFINE_PROP_UINT32("rst-src", TIK3CtrlMmrState, rst_src, 0x1),
+    /*
+     * Default to SYS_STATUS_DEV_TYPE_GP (0x3), matching a model without
+     * security manager and certificate authentication.
+     */
+    DEFINE_PROP_UINT32("sec-mgr-sys-status", TIK3CtrlMmrState,
+                       sec_mgr_sys_status, 0x3),
+};
+
+static void ti_k3_ctrlmmr_class_init(ObjectClass *klass, const void *data)
+{
+    device_class_set_props(DEVICE_CLASS(klass), ti_k3_ctrlmmr_properties);
+}
+
+static const TypeInfo ti_k3_ctrlmmr_info = {
+    .name = TYPE_TI_K3_CTRLMMR,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3CtrlMmrState),
+    .instance_init = ti_k3_ctrlmmr_init,
+    .class_init = ti_k3_ctrlmmr_class_init,
+};
+
+static void ti_k3_ctrlmmr_register_types(void)
+{
+    type_register_static(&ti_k3_ctrlmmr_info);
+}
+
+type_init(ti_k3_ctrlmmr_register_types)
diff --git a/hw/misc/ti-k3-ddrss.c b/hw/misc/ti-k3-ddrss.c
new file mode 100644
index 0000000000..661b88b02c
--- /dev/null
+++ b/hw/misc/ti-k3-ddrss.c
@@ -0,0 +1,98 @@
+/*
+ * TI K3 DDRSS register-file stub (AM64x, DDR4 flavour)
+ *
+ * RAM-backed DENALI CTL/PI/PHY register file. Writes are stored and read
+ * back unchanged. Init-done and optional ECC BIST_DONE status bits are ORed
+ * into reads, so the DDR bring-up handshake completes immediately.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/ti-k3-ddrss.h"
+
+/* Read-side OR masks: {offset, bits}. */
+static const struct {
+    hwaddr offset;
+    uint32_t bits;
+} ddrss_status_bits[] = {
+    { 0x214C, 1u << 0 },   /* DENALI_PI_83:  PI init done       */
+    { 0x0538, 1u << 13 },  /* DENALI_CTL_334: MASTER, MC_INIT grp */
+    { 0x0558, 1u << 25 },  /* DENALI_CTL_342: INT_STATUS_INIT bit1 */
+    /*
+     * ECC BIST_DONE is exposed in both places: INT_STATUS_MASTER bit 8 and
+     * INT_STATUS_BIST bit 0, resp. raw bit 16.
+     */
+    { 0x0538, 1u << 8 },   /* DENALI_CTL_334: MASTER, BIST grp     */
+    { 0x0554, 1u << 16 },  /* DENALI_CTL_341: BIST fld, BIST_DONE  */
+};
+
+static uint64_t ti_k3_ddrss_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3DdrssState *s = TI_K3_DDRSS(opaque);
+    uint32_t val = s->regs[addr >> 2];
+
+    for (size_t i = 0; i < ARRAY_SIZE(ddrss_status_bits); i++) {
+        if (addr == ddrss_status_bits[i].offset) {
+            val |= ddrss_status_bits[i].bits;
+        }
+    }
+    return val;
+}
+
+static void ti_k3_ddrss_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned size)
+{
+    TIK3DdrssState *s = TI_K3_DDRSS(opaque);
+
+    s->regs[addr >> 2] = val;
+}
+
+static const MemoryRegionOps ti_k3_ddrss_ops = {
+    .read = ti_k3_ddrss_read,
+    .write = ti_k3_ddrss_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void ti_k3_ddrss_reset(DeviceState *dev)
+{
+    TIK3DdrssState *s = TI_K3_DDRSS(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void ti_k3_ddrss_init(Object *obj)
+{
+    TIK3DdrssState *s = TI_K3_DDRSS(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_ddrss_ops, s,
+                          TYPE_TI_K3_DDRSS, TI_K3_DDRSS_CFG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void ti_k3_ddrss_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, ti_k3_ddrss_reset);
+}
+
+static const TypeInfo ti_k3_ddrss_info = {
+    .name = TYPE_TI_K3_DDRSS,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3DdrssState),
+    .instance_init = ti_k3_ddrss_init,
+    .class_init = ti_k3_ddrss_class_init,
+};
+
+static void ti_k3_ddrss_register_types(void)
+{
+    type_register_static(&ti_k3_ddrss_info);
+}
+
+type_init(ti_k3_ddrss_register_types)
diff --git a/hw/misc/ti-k3-gtc.c b/hw/misc/ti-k3-gtc.c
new file mode 100644
index 0000000000..b51baddc71
--- /dev/null
+++ b/hw/misc/ti-k3-gtc.c
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * TI K3 Global Timebase Counter (GTC) register stub.
+ *
+ * The GTC distributes a system counter and its nominal frequency to the ARM
+ * generic timers. Only CNTCR and CNTFID0 are implemented; the counter itself
+ * is not modelled. Reset reports an enabled 200 MHz counter, the AM64x
+ * default.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/ti-k3-gtc.h"
+
+#define TI_K3_GTC_SIZE       0x1000
+
+#define GTC_CNTCR            0x000   /* control; bit0 = EN */
+#define GTC_CNTFID0          0x020   /* frequency id 0 (Hz) */
+
+static uint64_t ti_k3_gtc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3GtcState *s = TI_K3_GTC(opaque);
+
+    switch (addr) {
+    case GTC_CNTCR:
+        return s->cntcr;
+    case GTC_CNTFID0:
+        return s->cntfid0;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read @0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+    }
+}
+
+static void ti_k3_gtc_write(void *opaque, hwaddr addr, uint64_t val,
+                            unsigned size)
+{
+    TIK3GtcState *s = TI_K3_GTC(opaque);
+
+    switch (addr) {
+    case GTC_CNTCR:
+        s->cntcr = (uint32_t)val;
+        break;
+    case GTC_CNTFID0:
+        s->cntfid0 = (uint32_t)val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write @0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps ti_k3_gtc_ops = {
+    .read = ti_k3_gtc_read,
+    .write = ti_k3_gtc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+};
+
+static void ti_k3_gtc_init(Object *obj)
+{
+    TIK3GtcState *s = TI_K3_GTC(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_gtc_ops, s,
+                          TYPE_TI_K3_GTC, TI_K3_GTC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const Property ti_k3_gtc_properties[] = {
+    DEFINE_PROP_UINT32("cntcr", TIK3GtcState, cntcr, 0x1),
+    DEFINE_PROP_UINT32("cntfid0", TIK3GtcState, cntfid0, 200000000),
+};
+
+static void ti_k3_gtc_class_init(ObjectClass *klass, const void *data)
+{
+    device_class_set_props(DEVICE_CLASS(klass), ti_k3_gtc_properties);
+}
+
+static const TypeInfo ti_k3_gtc_info = {
+    .name = TYPE_TI_K3_GTC,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3GtcState),
+    .instance_init = ti_k3_gtc_init,
+    .class_init = ti_k3_gtc_class_init,
+};
+
+static void ti_k3_gtc_register_types(void)
+{
+    type_register_static(&ti_k3_gtc_info);
+}
+
+type_init(ti_k3_gtc_register_types)
diff --git a/hw/misc/ti-k3-sdhci-phy.c b/hw/misc/ti-k3-sdhci-phy.c
new file mode 100644
index 0000000000..10b1f56032
--- /dev/null
+++ b/hw/misc/ti-k3-sdhci-phy.c
@@ -0,0 +1,91 @@
+/*
+ * TI K3 SDHCI PHY register-file stub (AM64x)
+ *
+ * RAM-backed SDHCI companion PHY window. Drive and delay registers are stored
+ * as written. PHY_STAT1 reports CALDONE (bit 1) and DLLRDY (bit 0) set, so
+ * calibration resp. DLL lock complete immediately.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/misc/ti-k3-sdhci-phy.h"
+
+/* Read-side OR masks: {offset, bits}. */
+static const struct {
+    hwaddr offset;
+    uint32_t bits;
+} sdhci_phy_status_bits[] = {
+    /* PHY_STAT1: CALDONE (bit 1) | DLLRDY (bit 0) */
+    { 0x130, 0x3 },
+};
+
+static uint64_t ti_k3_sdhci_phy_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3SdhciPhyState *s = TI_K3_SDHCI_PHY(opaque);
+    uint32_t val = s->regs[addr >> 2];
+
+    for (size_t i = 0; i < ARRAY_SIZE(sdhci_phy_status_bits); i++) {
+        if (addr == sdhci_phy_status_bits[i].offset) {
+            val |= sdhci_phy_status_bits[i].bits;
+        }
+    }
+    return val;
+}
+
+static void ti_k3_sdhci_phy_write(void *opaque, hwaddr addr, uint64_t val,
+                                  unsigned size)
+{
+    TIK3SdhciPhyState *s = TI_K3_SDHCI_PHY(opaque);
+
+    s->regs[addr >> 2] = val;
+}
+
+static const MemoryRegionOps ti_k3_sdhci_phy_ops = {
+    .read = ti_k3_sdhci_phy_read,
+    .write = ti_k3_sdhci_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void ti_k3_sdhci_phy_reset(DeviceState *dev)
+{
+    TIK3SdhciPhyState *s = TI_K3_SDHCI_PHY(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+}
+
+static void ti_k3_sdhci_phy_init(Object *obj)
+{
+    TIK3SdhciPhyState *s = TI_K3_SDHCI_PHY(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_sdhci_phy_ops, s,
+                          TYPE_TI_K3_SDHCI_PHY, TI_K3_SDHCI_PHY_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void ti_k3_sdhci_phy_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, ti_k3_sdhci_phy_reset);
+}
+
+static const TypeInfo ti_k3_sdhci_phy_info = {
+    .name = TYPE_TI_K3_SDHCI_PHY,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3SdhciPhyState),
+    .instance_init = ti_k3_sdhci_phy_init,
+    .class_init = ti_k3_sdhci_phy_class_init,
+};
+
+static void ti_k3_sdhci_phy_register_types(void)
+{
+    type_register_static(&ti_k3_sdhci_phy_info);
+}
+
+type_init(ti_k3_sdhci_phy_register_types)
diff --git a/hw/misc/ti-k3-trng.c b/hw/misc/ti-k3-trng.c
new file mode 100644
index 0000000000..14fb2d077c
--- /dev/null
+++ b/hw/misc/ti-k3-trng.c
@@ -0,0 +1,139 @@
+/*
+ * TI K3 SA2UL TRNG (EIP-76) stub (AM64x)
+ *
+ * Minimal EIP-76 register subset. STATUS reports RNG_READY, INTACK writes
+ * are accepted, OUTPUT_0..3 return two cached 64-bit pairs, and configuration
+ * registers are RAM-backed.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "hw/misc/ti-k3-trng.h"
+#include "trace.h"
+
+#define RNG_OUTPUT_0    0x00
+#define RNG_OUTPUT_1    0x04
+#define RNG_OUTPUT_2    0x08
+#define RNG_OUTPUT_3    0x0C
+#define RNG_STATUS      0x10
+#define RNG_READY       (1u << 0)
+#define RNG_CONTROL     0x14
+
+/* Nonzero xorshift64 state reaches never zero. */
+static uint64_t ti_k3_trng_next(TIK3TrngState *s)
+{
+    s->rng_state ^= s->rng_state << 13;
+    s->rng_state ^= s->rng_state >> 7;
+    s->rng_state ^= s->rng_state << 17;
+    return s->rng_state;
+}
+
+static uint64_t ti_k3_trng_read(void *opaque, hwaddr addr, unsigned size)
+{
+    TIK3TrngState *s = TI_K3_TRNG(opaque);
+    uint32_t val;
+
+    switch (addr) {
+    case RNG_OUTPUT_0:
+        s->pair_a = ti_k3_trng_next(s);
+        val = (uint32_t)s->pair_a;
+        break;
+    case RNG_OUTPUT_1:
+        val = (uint32_t)(s->pair_a >> 32);
+        break;
+    case RNG_OUTPUT_2:
+        s->pair_b = ti_k3_trng_next(s);
+        val = (uint32_t)s->pair_b;
+        break;
+    case RNG_OUTPUT_3:
+        val = (uint32_t)(s->pair_b >> 32);
+        break;
+    case RNG_STATUS:
+        /* Always ready, never in shutdown. */
+        val = RNG_READY;
+        break;
+    default:
+        val = s->regs[addr >> 2];
+        break;
+    }
+
+    trace_ti_k3_trng_read(addr, val);
+    return val;
+}
+
+static void ti_k3_trng_write(void *opaque, hwaddr addr, uint64_t value,
+                             unsigned size)
+{
+    TIK3TrngState *s = TI_K3_TRNG(opaque);
+
+    trace_ti_k3_trng_write(addr, value);
+
+    switch (addr) {
+    case RNG_OUTPUT_0:
+    case RNG_OUTPUT_1:
+    case RNG_OUTPUT_2:
+    case RNG_OUTPUT_3:
+        /* Output registers are read-only; use RAZ/WI. */
+        break;
+    case RNG_STATUS:
+        /* STATUS is synthesized on each read, so INTACK has no state. */
+        break;
+    default:
+        s->regs[addr >> 2] = (uint32_t)value;
+        break;
+    }
+}
+
+static const MemoryRegionOps ti_k3_trng_ops = {
+    .read = ti_k3_trng_read,
+    .write = ti_k3_trng_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void ti_k3_trng_reset(DeviceState *dev)
+{
+    TIK3TrngState *s = TI_K3_TRNG(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+    s->rng_state = 0x9e3779b97f4a7c15ULL;
+    s->pair_a = 0;
+    s->pair_b = 0;
+}
+
+static void ti_k3_trng_init(Object *obj)
+{
+    TIK3TrngState *s = TI_K3_TRNG(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ti_k3_trng_ops, s,
+                          TYPE_TI_K3_TRNG, TI_K3_TRNG_REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void ti_k3_trng_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, ti_k3_trng_reset);
+}
+
+static const TypeInfo ti_k3_trng_info = {
+    .name = TYPE_TI_K3_TRNG,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIK3TrngState),
+    .instance_init = ti_k3_trng_init,
+    .class_init = ti_k3_trng_class_init,
+};
+
+static void ti_k3_trng_register_types(void)
+{
+    type_register_static(&ti_k3_trng_info);
+}
+
+type_init(ti_k3_trng_register_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index c9a868b3ef..b32ce80ea9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -442,3 +442,7 @@ iommu_testdev_dma_read(uint64_t gva, uint32_t len) "gva=0x%" PRIx64 " len=%u"
 iommu_testdev_dma_verify(uint32_t expected, uint32_t actual) "expected=0x%x actual=0x%x"
 iommu_testdev_dma_result(uint32_t result) "DMA completed result=0x%x"
 iommu_testdev_dma_armed(bool armed) "armed=%d"
+
+# ti-k3-trng.c
+ti_k3_trng_read(uint64_t addr, uint32_t val) "offset 0x%" PRIx64 " -> 0x%08x"
+ti_k3_trng_write(uint64_t addr, uint64_t val) "offset 0x%" PRIx64 " <- 0x%" PRIx64
diff --git a/include/hw/misc/ti-k3-ctrlmmr.h b/include/hw/misc/ti-k3-ctrlmmr.h
new file mode 100644
index 0000000000..01fb71bc74
--- /dev/null
+++ b/include/hw/misc/ti-k3-ctrlmmr.h
@@ -0,0 +1,26 @@
+/*
+ * TI K3 CTRL_MMR stub
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_TI_K3_CTRLMMR_H
+#define HW_MISC_TI_K3_CTRLMMR_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_CTRLMMR "ti-k3-ctrlmmr"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3CtrlMmrState, TI_K3_CTRLMMR)
+
+struct TIK3CtrlMmrState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t devstat;
+    uint32_t rst_src;
+    uint32_t sec_mgr_sys_status;
+};
+
+#endif
diff --git a/include/hw/misc/ti-k3-ddrss.h b/include/hw/misc/ti-k3-ddrss.h
new file mode 100644
index 0000000000..ed0f54e5c4
--- /dev/null
+++ b/include/hw/misc/ti-k3-ddrss.h
@@ -0,0 +1,26 @@
+/*
+ * TI K3 DDRSS register-file stub (AM64x)
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_TI_K3_DDRSS_H
+#define HW_MISC_TI_K3_DDRSS_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_DDRSS "ti-k3-ddrss"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3DdrssState, TI_K3_DDRSS)
+
+#define TI_K3_DDRSS_CFG_SIZE 0x8000
+
+struct TIK3DdrssState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t regs[TI_K3_DDRSS_CFG_SIZE / 4];
+};
+
+#endif
diff --git a/include/hw/misc/ti-k3-gtc.h b/include/hw/misc/ti-k3-gtc.h
new file mode 100644
index 0000000000..a2a22afbf6
--- /dev/null
+++ b/include/hw/misc/ti-k3-gtc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ */
+#ifndef HW_MISC_TI_K3_GTC_H
+#define HW_MISC_TI_K3_GTC_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_GTC "ti-k3-gtc"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3GtcState, TI_K3_GTC)
+
+struct TIK3GtcState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    uint32_t cntcr;    /* GTC control: bit0 EN. Read back enabled. */
+    uint32_t cntfid0;  /* GTC frequency id 0, in Hz. */
+};
+
+#endif /* HW_MISC_TI_K3_GTC_H */
diff --git a/include/hw/misc/ti-k3-sdhci-phy.h b/include/hw/misc/ti-k3-sdhci-phy.h
new file mode 100644
index 0000000000..2a7296fc6f
--- /dev/null
+++ b/include/hw/misc/ti-k3-sdhci-phy.h
@@ -0,0 +1,26 @@
+/*
+ * TI K3 SDHCI PHY register-file stub (AM64x)
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_TI_K3_SDHCI_PHY_H
+#define HW_MISC_TI_K3_SDHCI_PHY_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_SDHCI_PHY "ti-k3-sdhci-phy"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3SdhciPhyState, TI_K3_SDHCI_PHY)
+
+#define TI_K3_SDHCI_PHY_SIZE 0x400
+
+struct TIK3SdhciPhyState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    uint32_t regs[TI_K3_SDHCI_PHY_SIZE / 4];
+};
+
+#endif
diff --git a/include/hw/misc/ti-k3-trng.h b/include/hw/misc/ti-k3-trng.h
new file mode 100644
index 0000000000..b9c33b589f
--- /dev/null
+++ b/include/hw/misc/ti-k3-trng.h
@@ -0,0 +1,35 @@
+/*
+ * TI K3 SA2UL TRNG (EIP-76) stub (AM64x)
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MISC_TI_K3_TRNG_H
+#define HW_MISC_TI_K3_TRNG_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_K3_TRNG "ti-k3-trng"
+OBJECT_DECLARE_SIMPLE_TYPE(TIK3TrngState, TI_K3_TRNG)
+
+/* EIP-76 register window: offsets 0x00..0x7c. */
+#define TI_K3_TRNG_REGS_SIZE 0x80
+
+struct TIK3TrngState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+
+    /* Nonzero xorshift64 generator state. */
+    uint64_t rng_state;
+    /* Cached pairs for OUTPUT_0/1 and OUTPUT_2/3. */
+    uint64_t pair_a;
+    uint64_t pair_b;
+
+    /* RAM-backed registers except OUTPUT_x and STATUS. */
+    uint32_t regs[TI_K3_TRNG_REGS_SIZE / 4];
+};
+
+#endif
-- 
2.43.0


