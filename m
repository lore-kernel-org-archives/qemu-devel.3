Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoY-00059M-Rn; Tue, 02 Sep 2025 09:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoS-0004qv-M6
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoM-0004ds-K3
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso266176f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818748; x=1757423548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v7oLK0U7kzqQPlPvNwCsAS4WO8Y8iTsMjuOMv+ikM+4=;
 b=uK2Vlw6Hyl6JVZXIt3S54aD5L7r6j6T2TzXL3//gA6vywxBPn0i36UEG7fZ0QuS0bA
 3pH3ID2e0zH6NpTJQaisotY5hKqcPBpqBgpA4QJJpkr7mXB0AnCXXTA2vUFeCfh0Xi3m
 AnocsFf5qP6osF4dsIZQ2l+8wjPuRv5jbkGQzDVFV3p8d2KQuTlOBcw9jj/plwp+t7Fg
 hGdtoKmoRXJjApgeay49VRpHK2OVY0IwWoorjtbA1z4zenebyEULbZVIUUVXKlEeMkjZ
 q6rKPlLNt6Ral9fn2TgxPOFi82UAq8Te0y4h/Q7EPQZg9i0Oiby5c0HebR9J7a2C8S10
 ksQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818748; x=1757423548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7oLK0U7kzqQPlPvNwCsAS4WO8Y8iTsMjuOMv+ikM+4=;
 b=XoWpwlqSgsdDuEjH/cHgABaN8ALSVbt1g1yajRMOQpCsiunxVlHThT6FNzz3u0dq05
 3EZjCgoqe0H15N34LHiqxRShC5WTeCNTAfp3d4nCcFXG5qTMRZ+/+NWLapj6WFOfcaVT
 VwA/b05krnrSu7ubnDCO3uoD+Mr0zqLf1mTeMGNMEd8xe4wJCawK9lDgzo6fKifNdH+u
 3czJG2miTd+eRRKrsLQChZQnxiGz5SeL5udt24i4Vd/eFifmtjtnQFVsqYQugYW7/uKO
 dfGuzhJ99eRkvFFKSheHJjeYT84tn7DFr3Md3uyxdUseAuayo1dtHEl794cw2tcAWxWs
 THNQ==
X-Gm-Message-State: AOJu0YyQgDKQq5k6r+tPWQlG2zBxCz3q1Nu6QW9SFlYVLZubO9aXqUfr
 XrsDAriucLAS+yVZYRc8Yjwi8kc7YR+zcsaK1nYxrsr10copjfiBry7w8h8G50/g4F+xyxA+Phr
 UkOrn
X-Gm-Gg: ASbGncvEsEpqZfnTbs8VRH3IquY9E5ps4O6aNHXLUE8/OtSpMj/EujlAVVSK4rKKOxP
 2VN+Q+TM9NUy8fFOiSAxlqbO6xIFqAyx0qKW+u0pEU4qtEm/II/qlsBUtbp/WT4woVGTnG1eJre
 +Ame6uCdXKy/755A8+A8DMnvuLgTPeKm9HM5HGlY1TI8vCNOPkym1TDjDzwyPzgu56q3ZhTh9d1
 /O+JptH4ndvByRxU4fWRe3W2TM+s7Da+ExogeJ3prgVw3v+xEHK/8UEYrvGx6PwFykCwUGosRh5
 truxQCAqr2CtILketqcomPptWo9d5aKIGSaaEsC8qryTcbX0nS9bI3iUKx6gUYKZn7o/LrPHppV
 egyzW1YueIXcwulN0TbS/lTPEctoOFyiTbc6GpJ10IwnMzm8mjIWic/irq1EIIC+eoCzWXfPL
X-Google-Smtp-Source: AGHT+IFxWDQuINJFH8CQtJbicvo2ar/tdSRhQkhDAThfDWTRLDLnvKG/6tT3fy4eK58/hqu5he4DXA==
X-Received: by 2002:a05:6000:3112:b0:3d1:42dc:c710 with SMTP id
 ffacd0b85a97d-3d1dcb76607mr9225185f8f.16.1756818747460; 
 Tue, 02 Sep 2025 06:12:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d48760d1c9sm12192482f8f.17.2025.09.02.06.12.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/39] hw/net: Remove mipsnet device model
Date: Tue,  2 Sep 2025 15:10:05 +0200
Message-ID: <20250902131016.84968-29-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The mipsnet device model was only used by the mipssim machine,
which just got removed. Remove as now dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ján Tomko <jtomko@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20250828143800.49842-3-philmd@linaro.org>
---
 MAINTAINERS         |   5 -
 hw/net/mipsnet.c    | 297 --------------------------------------------
 hw/net/Kconfig      |   3 -
 hw/net/meson.build  |   1 -
 hw/net/trace-events |   7 --
 5 files changed, 313 deletions(-)
 delete mode 100644 hw/net/mipsnet.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fc6900829..fccf53fcaf6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1411,11 +1411,6 @@ F: include/hw/southbridge/piix.h
 F: tests/functional/mips*/test_malta.py
 F: tests/functional/mips*/test_tuxrun.py
 
-Mipssim
-R: Aleksandar Rikalo <arikalo@gmail.com>
-S: Orphan
-F: hw/net/mipsnet.c
-
 Fuloong 2E
 M: Huacai Chen <chenhuacai@kernel.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
deleted file mode 100644
index 583aa1c7de6..00000000000
--- a/hw/net/mipsnet.c
+++ /dev/null
@@ -1,297 +0,0 @@
-#include "qemu/osdep.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "net/net.h"
-#include "qemu/module.h"
-#include "trace.h"
-#include "hw/sysbus.h"
-#include "migration/vmstate.h"
-#include "qom/object.h"
-
-/* MIPSnet register offsets */
-
-#define MIPSNET_DEV_ID          0x00
-#define MIPSNET_BUSY            0x08
-#define MIPSNET_RX_DATA_COUNT   0x0c
-#define MIPSNET_TX_DATA_COUNT   0x10
-#define MIPSNET_INT_CTL         0x14
-# define MIPSNET_INTCTL_TXDONE          0x00000001
-# define MIPSNET_INTCTL_RXDONE          0x00000002
-# define MIPSNET_INTCTL_TESTBIT         0x80000000
-#define MIPSNET_INTERRUPT_INFO  0x18
-#define MIPSNET_RX_DATA_BUFFER  0x1c
-#define MIPSNET_TX_DATA_BUFFER  0x20
-
-#define MAX_ETH_FRAME_SIZE      1514
-
-#define TYPE_MIPS_NET "mipsnet"
-OBJECT_DECLARE_SIMPLE_TYPE(MIPSnetState, MIPS_NET)
-
-struct MIPSnetState {
-    SysBusDevice parent_obj;
-
-    uint32_t busy;
-    uint32_t rx_count;
-    uint32_t rx_read;
-    uint32_t tx_count;
-    uint32_t tx_written;
-    uint32_t intctl;
-    uint8_t rx_buffer[MAX_ETH_FRAME_SIZE];
-    uint8_t tx_buffer[MAX_ETH_FRAME_SIZE];
-    MemoryRegion io;
-    qemu_irq irq;
-    NICState *nic;
-    NICConf conf;
-};
-
-static void mipsnet_reset(MIPSnetState *s)
-{
-    s->busy = 1;
-    s->rx_count = 0;
-    s->rx_read = 0;
-    s->tx_count = 0;
-    s->tx_written = 0;
-    s->intctl = 0;
-    memset(s->rx_buffer, 0, MAX_ETH_FRAME_SIZE);
-    memset(s->tx_buffer, 0, MAX_ETH_FRAME_SIZE);
-}
-
-static void mipsnet_update_irq(MIPSnetState *s)
-{
-    int isr = !!s->intctl;
-    trace_mipsnet_irq(isr, s->intctl);
-    qemu_set_irq(s->irq, isr);
-}
-
-static int mipsnet_buffer_full(MIPSnetState *s)
-{
-    if (s->rx_count >= MAX_ETH_FRAME_SIZE) {
-        return 1;
-    }
-    return 0;
-}
-
-static int mipsnet_can_receive(NetClientState *nc)
-{
-    MIPSnetState *s = qemu_get_nic_opaque(nc);
-
-    if (s->busy) {
-        return 0;
-    }
-    return !mipsnet_buffer_full(s);
-}
-
-static ssize_t mipsnet_receive(NetClientState *nc,
-                               const uint8_t *buf, size_t size)
-{
-    MIPSnetState *s = qemu_get_nic_opaque(nc);
-
-    trace_mipsnet_receive(size);
-    if (!mipsnet_can_receive(nc)) {
-        return 0;
-    }
-
-    if (size >= sizeof(s->rx_buffer)) {
-        return 0;
-    }
-    s->busy = 1;
-
-    /* Just accept everything. */
-
-    /* Write packet data. */
-    memcpy(s->rx_buffer, buf, size);
-
-    s->rx_count = size;
-    s->rx_read = 0;
-
-    /* Now we can signal we have received something. */
-    s->intctl |= MIPSNET_INTCTL_RXDONE;
-    mipsnet_update_irq(s);
-
-    return size;
-}
-
-static uint64_t mipsnet_ioport_read(void *opaque, hwaddr addr,
-                                    unsigned int size)
-{
-    MIPSnetState *s = opaque;
-    int ret = 0;
-
-    addr &= 0x3f;
-    switch (addr) {
-    case MIPSNET_DEV_ID:
-        ret = be32_to_cpu(0x4d495053);          /* MIPS */
-        break;
-    case MIPSNET_DEV_ID + 4:
-        ret = be32_to_cpu(0x4e455430);          /* NET0 */
-        break;
-    case MIPSNET_BUSY:
-        ret = s->busy;
-        break;
-    case MIPSNET_RX_DATA_COUNT:
-        ret = s->rx_count;
-        break;
-    case MIPSNET_TX_DATA_COUNT:
-        ret = s->tx_count;
-        break;
-    case MIPSNET_INT_CTL:
-        ret = s->intctl;
-        s->intctl &= ~MIPSNET_INTCTL_TESTBIT;
-        break;
-    case MIPSNET_INTERRUPT_INFO:
-        /* XXX: This seems to be a per-VPE interrupt number. */
-        ret = 0;
-        break;
-    case MIPSNET_RX_DATA_BUFFER:
-        if (s->rx_count) {
-            s->rx_count--;
-            ret = s->rx_buffer[s->rx_read++];
-            if (mipsnet_can_receive(s->nic->ncs)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
-        }
-        break;
-    /* Reads as zero. */
-    case MIPSNET_TX_DATA_BUFFER:
-    default:
-        break;
-    }
-    trace_mipsnet_read(addr, ret);
-    return ret;
-}
-
-static void mipsnet_ioport_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned int size)
-{
-    MIPSnetState *s = opaque;
-
-    addr &= 0x3f;
-    trace_mipsnet_write(addr, val);
-    switch (addr) {
-    case MIPSNET_TX_DATA_COUNT:
-        s->tx_count = (val <= MAX_ETH_FRAME_SIZE) ? val : 0;
-        s->tx_written = 0;
-        break;
-    case MIPSNET_INT_CTL:
-        if (val & MIPSNET_INTCTL_TXDONE) {
-            s->intctl &= ~MIPSNET_INTCTL_TXDONE;
-        } else if (val & MIPSNET_INTCTL_RXDONE) {
-            s->intctl &= ~MIPSNET_INTCTL_RXDONE;
-        } else if (val & MIPSNET_INTCTL_TESTBIT) {
-            mipsnet_reset(s);
-            s->intctl |= MIPSNET_INTCTL_TESTBIT;
-        } else if (!val) {
-            /* ACK testbit interrupt, flag was cleared on read. */
-        }
-        s->busy = !!s->intctl;
-        mipsnet_update_irq(s);
-        if (mipsnet_can_receive(s->nic->ncs)) {
-            qemu_flush_queued_packets(qemu_get_queue(s->nic));
-        }
-        break;
-    case MIPSNET_TX_DATA_BUFFER:
-        s->tx_buffer[s->tx_written++] = val;
-        if ((s->tx_written >= MAX_ETH_FRAME_SIZE)
-            || (s->tx_written == s->tx_count)) {
-            /* Send buffer. */
-            trace_mipsnet_send(s->tx_written);
-            qemu_send_packet(qemu_get_queue(s->nic),
-                                s->tx_buffer, s->tx_written);
-            s->tx_count = s->tx_written = 0;
-            s->intctl |= MIPSNET_INTCTL_TXDONE;
-            s->busy = 1;
-            mipsnet_update_irq(s);
-        }
-        break;
-    /* Read-only registers */
-    case MIPSNET_DEV_ID:
-    case MIPSNET_BUSY:
-    case MIPSNET_RX_DATA_COUNT:
-    case MIPSNET_INTERRUPT_INFO:
-    case MIPSNET_RX_DATA_BUFFER:
-    default:
-        break;
-    }
-}
-
-static const VMStateDescription vmstate_mipsnet = {
-    .name = "mipsnet",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(busy, MIPSnetState),
-        VMSTATE_UINT32(rx_count, MIPSnetState),
-        VMSTATE_UINT32(rx_read, MIPSnetState),
-        VMSTATE_UINT32(tx_count, MIPSnetState),
-        VMSTATE_UINT32(tx_written, MIPSnetState),
-        VMSTATE_UINT32(intctl, MIPSnetState),
-        VMSTATE_BUFFER(rx_buffer, MIPSnetState),
-        VMSTATE_BUFFER(tx_buffer, MIPSnetState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static NetClientInfo net_mipsnet_info = {
-    .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState),
-    .receive = mipsnet_receive,
-};
-
-static const MemoryRegionOps mipsnet_ioport_ops = {
-    .read = mipsnet_ioport_read,
-    .write = mipsnet_ioport_write,
-    .impl.min_access_size = 1,
-    .impl.max_access_size = 4,
-};
-
-static void mipsnet_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    MIPSnetState *s = MIPS_NET(dev);
-
-    memory_region_init_io(&s->io, OBJECT(dev), &mipsnet_ioport_ops, s,
-                          "mipsnet-io", 36);
-    sysbus_init_mmio(sbd, &s->io);
-    sysbus_init_irq(sbd, &s->irq);
-
-    s->nic = qemu_new_nic(&net_mipsnet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id,
-                          &dev->mem_reentrancy_guard, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-}
-
-static void mipsnet_sysbus_reset(DeviceState *dev)
-{
-    MIPSnetState *s = MIPS_NET(dev);
-    mipsnet_reset(s);
-}
-
-static const Property mipsnet_properties[] = {
-    DEFINE_NIC_PROPERTIES(MIPSnetState, conf),
-};
-
-static void mipsnet_class_init(ObjectClass *klass, const void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = mipsnet_realize;
-    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
-    dc->desc = "MIPS Simulator network device";
-    device_class_set_legacy_reset(dc, mipsnet_sysbus_reset);
-    dc->vmsd = &vmstate_mipsnet;
-    device_class_set_props(dc, mipsnet_properties);
-}
-
-static const TypeInfo mipsnet_info = {
-    .name          = TYPE_MIPS_NET,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MIPSnetState),
-    .class_init    = mipsnet_class_init,
-};
-
-static void mipsnet_register_types(void)
-{
-    type_register_static(&mipsnet_info);
-}
-
-type_init(mipsnet_register_types)
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 7f80218d10f..2b513d68958 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -82,9 +82,6 @@ config OPENCORES_ETH
 config XGMAC
     bool
 
-config MIPSNET
-    bool
-
 config ALLWINNER_EMAC
     bool
 
diff --git a/hw/net/meson.build b/hw/net/meson.build
index e6759e26ca6..913eaedbc52 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -23,7 +23,6 @@ system_ss.add(when: 'CONFIG_LAN9118_PHY', if_true: files('lan9118_phy.c'))
 system_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
 system_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
 system_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
-system_ss.add(when: 'CONFIG_MIPSNET', if_true: files('mipsnet.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axienet.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_EMAC', if_true: files('allwinner_emac.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_SUN8I_EMAC', if_true: files('allwinner-sun8i-emac.c'))
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 72b69c4a8bb..e82d7490c33 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -20,13 +20,6 @@ lan9118_phy_reset(void) ""
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
 
-# mipsnet.c
-mipsnet_send(uint32_t size) "sending len=%u"
-mipsnet_receive(uint32_t size) "receiving len=%u"
-mipsnet_read(uint64_t addr, uint32_t val) "read addr=0x%" PRIx64 " val=0x%x"
-mipsnet_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
-mipsnet_irq(uint32_t isr, uint32_t intctl) "set irq to %d (0x%02x)"
-
 # ne2000.c
 ne2000_read(uint64_t addr, uint64_t val) "read addr=0x%" PRIx64 " val=0x%" PRIx64
 ne2000_write(uint64_t addr, uint64_t val) "write addr=0x%" PRIx64 " val=0x%" PRIx64
-- 
2.51.0


