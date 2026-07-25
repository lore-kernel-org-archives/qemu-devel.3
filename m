Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75163C531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmu-00025H-AQ; Fri, 24 Jul 2026 21:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTF-0006vN-4f
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:29 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTD-0000mi-3T
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:28 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-7466771f1caso410952137.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940146; x=1785544946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRM85ZxQ7NPsNTwS4+uvymRHkxtMcwlZYeUH9jK5Ra0=;
 b=UsuZctpqR2CpAumer0D7y4q7mFg2AkTvMuqVU6PNkUzyaGMIHpRD2mT+DDHSPNUt+H
 qnvc1yKTkRsw7duO0QSL91D4egsW+N3eD9v2ETSFGRb2ocGbEJWbv2jeDb1TLYaPvWEM
 xnVE5VNrRzUDtjasj3lGJaT/gTWyyH8fHTfsi094pLBlOWOSR5WzavVboTi6Qs3vwccA
 DFhfCQuD/LaTrsV9lS7A4e0jGxSQkUm1hoPGlhWPD+R3Sffrn6DHv8zs0fHlE0RGx3oX
 CA0ZubeIKMvPH2ehmnKocPRmZ57wK46RMdI/WGZ0aJNp3y93j4HYmXNfIFXGaLranmcp
 n7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940146; x=1785544946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PRM85ZxQ7NPsNTwS4+uvymRHkxtMcwlZYeUH9jK5Ra0=;
 b=RzMXIMiLY/E75rknLEMjZcD7rLUMfZg2oJ5+YraQXn5YW6GmMtUE5K+h9/Fu/3arx/
 9IziDTTq9IcOM1K+XN7wewS/Ykb7gqbde2p/r71ByTGA+a9tR5qm9L1Vapyc5WqqttCr
 wEJjT6zgdWzCSaE+ckt9FmApg5j+Qsnx/Rruy/xw6pc70JHUitcI5LKrJ2iVdMRPzzpn
 EoKkXRpnaSX3whj0s9AyExeVxwGBfavFpOEyDb76vRTT+4ELjKRqh5Cad693YoBWf5oX
 q8iEL/cmE1TptvkxNaOMN0rqvUaI0DVhRxc2ikhX98HinPcBtmgrMrAUcqLbe24fLOMF
 KZ8w==
X-Gm-Message-State: AOJu0YxvutwjibVfCrJa1N6JkKgzPDceazke16F3bcnLI0+djv9BMqCb
 EF9CnIDFjHgq+lB56t0OV4ZiTL94CybvG3TTUmqsswYx58ZpfsHuQE8WMVmQTVHE
X-Gm-Gg: AR+sD11PbCZyhfEdwA9gI4WVbeQBmhVWa2vErxfg23x1j+f7zt4ZXbnheVV+NUUFNr6
 e0OiIbsc260qg+pbQFKUJH1H3K2FdmYuf1ll3QuAslyvW9D0KhxRFglOAjUUrYsL7TSbEsJPR3P
 k2YPEBvvjYE8hEoIfoDp2z68p3oN2kYqp5tYhwYs4IkYNQEKWGzHIUut539O29YeLbuY97B5Cf0
 hRZTWM7iu/xWhqNlW7ACpoAs4qowMmDPYJXVUqg59eXHj+glEGCuAcPyi5yUZozLJR9UqwspYtn
 SnapZZ39bc4USMk6fnJ/mJutFXb0AdnHS41UqZDy31b0aVTrMBMJgvm3G8Uh87KmBcICgU3fUpw
 Im2O/lch6Z4bO4AjzwVy2a3vQfyt1dJaROtXowje7vdlzt+3bry4lBi0qpMMp80aNA9FBUzGok2
 AZiHICzCc9wWt9RXs3sjPZmJVbRub1KssxTdavlgcjBCA=
X-Received: by 2002:a05:6102:953:b0:74a:ca1d:7f58 with SMTP id
 ada2fe7eead31-750412f037emr717895137.28.1784940145964; 
 Fri, 24 Jul 2026 17:42:25 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:25 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 04/19] hw/net/bcm2838_genet: add GENET stub device
Date: Fri, 24 Jul 2026 20:42:03 -0400
Message-ID: <20260725004219.66222-5-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

Add a bare-bones BCM2838 GENET (Gigabit Ethernet) sysbus device:
MMIO region registration, an out-of-range read/write handler that
just logs, and a reset callback. No register-level behavior yet;
that comes in the following patches.

Adapted from patch 19/41 of Sergey Kambalin's Raspberry Pi 4B
series (patchwork series 829638) against current QEMU master. The
reset callback and class_init() use the current Resettable-phases
API (ResettableClass / resettable_class_set_parent_phases()) rather
than the plain DeviceClass::reset hook the original patch used, and
headers moved under hw/core/, both API changes since the series was
originally posted.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c               | 103 +++++++++++++++++++++++++++
 hw/net/meson.build                   |   2 +
 hw/net/trace-events                  |  16 +++++
 include/hw/arm/bcm2838_peripherals.h |   2 +
 include/hw/net/bcm2838_genet.h       |  40 +++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/net/bcm2838_genet.h

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
new file mode 100644
index 00000000..2ff93a34
--- /dev/null
+++ b/hw/net/bcm2838_genet.c
@@ -0,0 +1,103 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "net/eth.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "net/checksum.h"
+#include "system/dma.h"
+#include "hw/core/resettable.h"
+#include "hw/net/bcm2838_genet.h"
+#include "trace.h"
+
+
+static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = ~0;
+
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+
+    trace_bcm2838_genet_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size) {
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+}
+
+static const MemoryRegionOps bcm2838_genet_ops = {
+    .read = bcm2838_genet_read,
+    .write = bcm2838_genet_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {.max_access_size = 4},
+    .valid = {.min_access_size = 4},
+};
+
+
+static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838GenetState *s = BCM2838_GENET(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Controller registers */
+    memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
+                          "bcm2838_genet_regs", sizeof(s->regs));
+    sysbus_init_mmio(sbd, &s->regs_mr);
+}
+
+static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
+{
+    trace_bcm2838_genet_phy_reset("done");
+}
+
+static void bcm2838_genet_reset(Object *obj, ResetType type)
+{
+    BCM2838GenetState *s = BCM2838_GENET(obj);
+
+    memset(&s->regs, 0x00, sizeof(s->regs));
+
+    trace_bcm2838_genet_reset("done");
+
+    bcm2838_genet_phy_reset(s);
+}
+
+static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
+{
+    static ResettablePhases unused_parent_phases;
+    DeviceClass *dc = DEVICE_CLASS(class);
+    ResettableClass *rc = RESETTABLE_CLASS(class);
+
+    dc->realize = bcm2838_genet_realize;
+    resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
+                                       &unused_parent_phases);
+}
+
+static const TypeInfo bcm2838_genet_info = {
+    .name       = TYPE_BCM2838_GENET,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GenetState),
+    .class_init = bcm2838_genet_class_init,
+};
+
+static void bcm2838_genet_register(void)
+{
+    type_register_static(&bcm2838_genet_info);
+}
+
+type_init(bcm2838_genet_register)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 84f142df..e290e179 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -69,4 +69,6 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
 stub_ss.add(files('rocker/rocker-stubs.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_genet.c'))
+
 subdir('can')
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 001a20b0..2dde33e8 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -528,3 +528,19 @@ xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d f
 ethlite_pkt_lost(uint32_t rx_ctrl) "rx_ctrl:0x%" PRIx32
 ethlite_pkt_size_too_big(uint64_t size) "size:0x%" PRIx64
 ethlite_pkt_tx_size_too_big(uint64_t size) "size:0x%" PRIx64
+# bcm2838_genet.c
+bcm2838_genet_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_can_receive(const char *state) "receive is %s"
+bcm2838_genet_receive(ssize_t bytes_received) "%zd bytes received"
+bcm2838_genet_phy_update_link(const char *link_state) "link is %s"
+bcm2838_genet_phy_reset(const char *status) "PHY reset %s"
+bcm2838_genet_reset(const char *status) "MAC reset %s"
+bcm2838_genet_mac_address(const char *info) "%s"
+bcm2838_genet_tx_dma(const char *dma_state) "TX DMA %s"
+bcm2838_genet_tx_dma_ring(uint32_t ring_en) "TX DMA enabled rings: 0x%05x"
+bcm2838_genet_tx_dma_ring_buf(uint32_t ring_buf_en) "TX DMA enabled ring buffers: 0x%05x"
+bcm2838_genet_tx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
+bcm2838_genet_tx_request(unsigned int ring_idx, uint32_t prod_idx, uint32_t cons_idx) "ring %u, PROD_INDEX %u, CONS_INDEX %u"
+bcm2838_genet_tx(unsigned int ring_idx, uint64_t desc_idx, uint32_t desc_status, uint64_t data_addr) "ring %u, descriptor %" PRIu64 ": 0x%08x, data @ 0x%08" PRIx64
+bcm2838_genet_rx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 56c0c209..903970a3 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -52,6 +52,8 @@
 #define BCM2838_MPHI_OFFSET     0xb200
 #define BCM2838_MPHI_SIZE       0x200
 
+#define GENET_OFFSET            0x1580000
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
new file mode 100644
index 00000000..91cf1773
--- /dev/null
+++ b/include/hw/net/bcm2838_genet.h
@@ -0,0 +1,40 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_GENET_H
+#define BCM2838_GENET_H
+
+#include "net/net.h"
+#include "hw/core/sysbus.h"
+
+#define TYPE_BCM2838_GENET "bcm2838-genet"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
+
+#define BCM2838_GENET_REV_MAJOR         6
+#define BCM2838_GENET_REV_MINOR         0
+
+typedef struct {
+    uint8_t stub_area[0x10000]; /* temporary stub */
+} BCM2838GenetRegs;
+
+struct BCM2838GenetState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    MemoryRegion regs_mr;
+    AddressSpace dma_as;
+
+    BCM2838GenetRegs regs;
+
+    qemu_irq irq_default;
+    qemu_irq irq_prio;
+};
+
+#endif /* BCM2838_GENET_H */
-- 
2.47.1


