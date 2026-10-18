Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D835ACCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3t-0002Wv-9P; Sun, 18 Oct 2026 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3l-0002Nh-To
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:23 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3h-0002II-3W
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:19 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-93f3c89594cso14901185a.2
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330576; x=1792935376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z9J2kIbDNvmhAerfd+y18qGUtn3Xv/VR+B36v2gtLCY=;
 b=AmPcsb3NT+Id+dPJbmTsgrd6/l1F3Kx8nM2D9oi+IYVGd0qTZMjzanInIqdUPYJIZl
 1gXA9HFUr25gRXvuBV5dGlaJcmuGU1KuJWyRDeq7YFO04DhGZ2YvGUIdKmZMtoEQQ2gx
 2UTJ7W/eiI68ft7VeS2IeN6IwYxqCIyGhfotJNZExpwleICNZ2i4bCPZUiZCXI2GA1Sy
 CkOrcaipCJxK4ThZ9p55GGaAgrxZshZmm6VdVvH00uKpvoGN3umh+cyBijre9XUomVjq
 AzMH+MzpemUZPCYag01Kk1ldw6nxFg/nbKlXiEpODHGrYGsd56OWMX3pAaZmmOmdgrr3
 jOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330576; x=1792935376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z9J2kIbDNvmhAerfd+y18qGUtn3Xv/VR+B36v2gtLCY=;
 b=f+YaM6aj7gmdf0XwVdbspy3OuzZQuBqfAWo0z1d5VMBdidsBN0/Isg9X/aTAcW2dff
 7Hv0SAsZH23swpcOoqdtWmnCa5Ym39eg/rj+010U9ENxF8X5ZPAkbjGiZ8xh5kJYXfsy
 9scrCmJ9jxeiVZRqPSTTmJb5NbGb6sjZzZtyhpoPsENL0GgI8okXHpHJDONfE/psFZxJ
 4+AUczJnXraGZbkCShQkmyog8Ig8Kkgwchre8bjulvqEGgZpVr1FUmaUyoQQbQBYkFRT
 UwmxYfUzFRfBWSxgF0ijf/yHU1ykxZOjIFpobW1JOd79rbGpGk/o7osdJyn9wDHuqmza
 IJVQ==
X-Gm-Message-State: AFq9FYK51goeZUakhAzKutZJw3zEH9FwTyqZTq/IgDiqls/vuxdGv0Ha
 pKc6VmVp26dXCB8VwzQtl2Qdnqb4skU01DeRYos37yN3sYhK42p7xCLOBfzsShun
X-Gm-Gg: AYBFou2eUeBqxYH82KU+IYTQH+H2jtHQnFmueIWIbB52mxS7SUmV7p+Du1yArI4kmm2
 ywHxpTxf7OJH5j2svHkCkwB33biPy8zSAl2VkjRgSDMDTS24V6FOHe1Pv5MliREDyY2r7dIsy1D
 GPAue0qCg+/XbINHlh0ntiSnZF+nN3OEOor5NqVmdy+qZTCOiIF8LwEtLB4fdY4HtPt9gYUo2MJ
 xCThByKiqZWizlrSvfp9aCPzt7AGJrWoCxLX5aqtLF9DwNOsJgrOQoYJQckdI0jHpRnMOiy1oP7
 QuGnVsyK+KjCv7fo6YwNmvUa5ebqOTH4H0vAtWmSxBI4KQGFOiCXuCgmvgFKhlvUAkUNWa5X/Su
 wLWIV8gUpWTFBak6MpYkU7//ZJkzOciLqFXBBnGLMiFMxFpf5AhuShemVv2pbMuQUrmbH6bNTBH
 ZkqyWBYwvzv9DkEYqOZfcJ5ti93Z7USMLS9JP3llZ/n5D27KcD23apgRHPOWXEUpAcCtUwgW2/+
 nh2CpOeEJ+ygFe5EcIuQ2HuVZSoNR9o8WhSkdoxo/zuVn2yhw0bwjwcJaUxrEFCLKAsaHk=
X-Received: by 2002:a05:620a:d85:b0:93e:5fff:db02 with SMTP id
 af79cd13be357-93f29ccb86amr871596185a.28.1792330575910; 
 Sun, 18 Oct 2026 06:36:15 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:15 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v4 10/17] hw/net/bcm2838_genet: implement GENET register ops
Date: Sun, 18 Oct 2026 09:35:56 -0400
Message-ID: <20261018133603.64323-11-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x736.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Replace the stub MMIO read/write handlers with real dispatch over
the register offsets from the previous patches: SYS revision
control, INTRL0/1 status/mask registers, UMAC command/MAC-address/
MDIO-command registers, and TDMA/RDMA ring configuration, wired up
to the NIC's realize()/reset() and qdev NIC properties
(DEFINE_NIC_PROPERTIES) so the device gets a MAC address and peer
netdev from the command line.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo:
adapted to the current Property/class_init/Resettable APIs.

While carrying this forward, make these changes to the original code:

 - Access registers as a host-order uint32_t at their byte offset
   instead of memcpy()ing an arbitrary number of bytes in and out of
   the register block, which gives the wrong result on big-endian hosts
   for anything that is not a uint32_t. The HFB filter array becomes a
   uint32_t array too, so that every register in the block is one.
 - Do not call qemu_macaddr_default_if_unset() when the guest
   programs a MAC address: it is for realize() to pick a default when
   the user gave none. Only update the NIC info string.
 - Accept an access that ends exactly at the end of the register block.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 195 +++++++++++++++++++++++++++++++--
 include/hw/net/bcm2838_genet.h |  18 ++-
 2 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 091cd38954..af94c60c88 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -236,25 +236,149 @@ REG16(GENET_PHY_EXP_SEL,           0)
 FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
 FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
 
+static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
+{
+    const MACAddr *addr = &s->nic_conf.macaddr;
+
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_0, addr->a[0]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_1, addr->a[1]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_2, addr->a[2]);
+    s->regs.umac.mac0 = FIELD_DP32(s->regs.umac.mac0, GENET_UMAC_MAC_0,
+                                   ADDR_3, addr->a[3]);
+    s->regs.umac.mac1 = FIELD_DP32(s->regs.umac.mac1, GENET_UMAC_MAC_1,
+                                   ADDR_4, addr->a[4]);
+    s->regs.umac.mac1 = FIELD_DP32(s->regs.umac.mac1, GENET_UMAC_MAC_1,
+                                   ADDR_5, addr->a[5]);
+}
+
+static void bcm2838_genet_set_irq_default(BCM2838GenetState *s)
+{
+    uint32_t intrl_0_status = s->regs.intrl0.stat;
+    uint32_t intrl_0_mask = s->regs.intrl0.mask_status;
+    int level = (intrl_0_status & ~intrl_0_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_default, level);
+}
+
+static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
+{
+    uint32_t intrl_1_status = s->regs.intrl1.stat;
+    uint32_t intrl_1_mask = s->regs.intrl1.mask_status;
+    int level = (intrl_1_status & ~intrl_1_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_prio, level);
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
+    BCM2838GenetState *s = opaque;
 
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+    if (offset + size <= sizeof(s->regs)) {
+        value = *bcm2838_genet_reg(s, offset);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 
     trace_bcm2838_genet_read(size, offset, value);
     return value;
 }
 
 static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
-                                unsigned size) {
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+                                unsigned size)
+{
+    BCM2838GenetState *s = opaque;
+    MACAddr *mac = &s->nic_conf.macaddr;
+    NetClientState *ncs = qemu_get_queue(s->nic);
+
+    trace_bcm2838_genet_write(size, offset, value);
+
+    if (offset + size <= sizeof(s->regs)) {
+        switch (offset) {
+        case BCM2838_GENET_INTRL0_SET:
+            s->regs.intrl0.stat |= value;
+            break;
+        case BCM2838_GENET_INTRL0_CLEAR:
+            s->regs.intrl0.stat &= ~value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_SET:
+            s->regs.intrl0.mask_status |= value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_CLEAR:
+            s->regs.intrl0.mask_status &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_SET:
+            s->regs.intrl1.stat |= value;
+            break;
+        case BCM2838_GENET_INTRL1_CLEAR:
+            s->regs.intrl1.stat &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_SET:
+            s->regs.intrl1.mask_status |= value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_CLEAR:
+            s->regs.intrl1.mask_status &= ~value;
+            break;
+        case BCM2838_GENET_UMAC_CMD:
+            /* Complete SW reset as soon as it has been requested */
+            if (FIELD_EX32(value, GENET_UMAC_CMD, SW_RESET) == 1) {
+                device_cold_reset(DEVICE(s));
+                value = FIELD_DP32(value, GENET_UMAC_CMD, SW_RESET, 0);
+            }
+            break;
+        /*
+         * TODO: before changing MAC address we'd better inform QEMU
+         * network subsystem about freeing previously used one, but
+         * qemu_macaddr_set_free function isn't accessible for us (marked
+         * as static in net/net.c), see also https://lists.nongnu.org/
+         * archive/html/qemu-devel/2022-07/msg02123.html
+         */
+        case BCM2838_GENET_UMAC_MAC0:
+            mac->a[0] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_0);
+            mac->a[1] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_1);
+            mac->a[2] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_2);
+            mac->a[3] = FIELD_EX32(value, GENET_UMAC_MAC_0, ADDR_3);
+            qemu_format_nic_info_str(ncs, mac->a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MAC1:
+            mac->a[4] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_4);
+            mac->a[5] = FIELD_EX32(value, GENET_UMAC_MAC_1, ADDR_5);
+            qemu_format_nic_info_str(ncs, mac->a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_RDMA_CTRL:
+            s->regs.rdma.status = (~value) & GENET_DMA_ENABLE_MASK;
+            break;
+        case BCM2838_GENET_UMAC_MDIO_CMD:
+        case BCM2838_GENET_TDMA_REGS
+            ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
+            qemu_log_mask(LOG_UNIMP,
+                "UMAC MDIO and TDMA aren't implemented yet");
+            break;
+        default:
+            break;
+        }
+
+        *bcm2838_genet_reg(s, offset) = value;
+        if (offset == BCM2838_GENET_RDMA_CTRL &&
+            FIELD_EX32(value, GENET_DMA_CTRL, EN)) {
+            qemu_flush_queued_packets(ncs);
+        }
+        bcm2838_genet_set_irq_default(s);
+        bcm2838_genet_set_irq_prio(s);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 }
 
 static const MemoryRegionOps bcm2838_genet_ops = {
@@ -265,9 +389,14 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4, .max_access_size = 4},
 };
 
+static NetClientInfo bcm2838_genet_client_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState)
+};
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
 {
+    NetClientState *ncs;
     BCM2838GenetState *s = BCM2838_GENET(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
@@ -275,10 +404,46 @@ static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
                           "bcm2838_genet_regs", sizeof(s->regs));
     sysbus_init_mmio(sbd, &s->regs_mr);
+
+    /* QEMU-managed NIC (host network back-end connection) */
+    qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+    s->nic = qemu_new_nic(&bcm2838_genet_client_info, &s->nic_conf,
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
+    bcm2838_genet_set_qemu_mac(s);
+    ncs = qemu_get_queue(s->nic);
+    qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+    trace_bcm2838_genet_mac_address(ncs->info_str);
+
+    /* Interrupts */
+    sysbus_init_irq(sbd, &s->irq_default);
+    sysbus_init_irq(sbd, &s->irq_prio);
+
+    /* DMA space */
+    address_space_init(&s->dma_as, get_system_memory(), "bcm2838_genet_dma");
 }
 
 static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
 {
+    memset(&s->phy_regs, 0x00, sizeof(s->phy_regs));
+    memset(&s->phy_shd_regs, 0x00, sizeof(s->phy_shd_regs));
+    memset(&s->phy_aux_ctl_shd_regs, 0x00, sizeof(s->phy_aux_ctl_shd_regs));
+
+    /* All values below were taken from real HW trace and logs */
+    s->phy_regs.bmcr = 0x1140;
+    s->phy_regs.bmsr = 0x7949;
+    s->phy_regs.sid1 = 0x600D;
+    s->phy_regs.sid2 = 0x84A2;
+    s->phy_regs.advertise = 0x01E1;
+    s->phy_regs.ctrl1000 = 0x0200;
+    s->phy_regs.estatus = 0x3000;
+
+    s->phy_shd_regs.clk_ctl = 0x0200;
+    s->phy_shd_regs.scr3 = 0x001F;
+    s->phy_shd_regs.apd = 0x0001;
+
+    s->phy_aux_ctl_shd_regs.regs[BCM2838_GENET_PHY_AUX_CTL_MISC] = 0x1E;
+
     trace_bcm2838_genet_phy_reset("done");
 }
 
@@ -288,11 +453,22 @@ static void bcm2838_genet_reset(Object *obj, ResetType type)
 
     memset(&s->regs, 0x00, sizeof(s->regs));
 
+    s->regs.sys.rev_ctrl = FIELD_DP32(s->regs.sys.rev_ctrl, GENET_SYS_REV_CTRL,
+                                      MAJOR_REV, BCM2838_GENET_REV_MAJOR);
+    s->regs.sys.rev_ctrl = FIELD_DP32(s->regs.sys.rev_ctrl, GENET_SYS_REV_CTRL,
+                                      MINOR_REV, BCM2838_GENET_REV_MINOR);
+    s->regs.rdma.status = GENET_DMA_ENABLE_MASK;
+    s->regs.tdma.status = GENET_DMA_ENABLE_MASK;
+
     trace_bcm2838_genet_reset("done");
 
     bcm2838_genet_phy_reset(s);
 }
 
+static const Property genet_properties[] = {
+    DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
 {
     static ResettablePhases unused_parent_phases;
@@ -302,6 +478,7 @@ static void bcm2838_genet_class_init(ObjectClass *class, const void *data)
     dc->realize = bcm2838_genet_realize;
     resettable_class_set_parent_phases(rc, NULL, bcm2838_genet_reset, NULL,
                                        &unused_parent_phases);
+    device_class_set_props(dc, genet_properties);
 }
 
 static const TypeInfo bcm2838_genet_info = {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index e0add41aab..533848d3c1 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -293,8 +293,7 @@ typedef struct {
 } BCM2838GenetRegsTdma;
 
 typedef struct {
-    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
-        * sizeof(uint32_t)];
+    uint32_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE];
     uint32_t reserved_0x6000[1792];
     uint32_t ctrl;
     uint32_t flt_enable[2];
@@ -388,6 +387,8 @@ struct BCM2838GenetState {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    NICState *nic;
+    NICConf nic_conf;
 
     MemoryRegion regs_mr;
     AddressSpace dma_as;
@@ -402,4 +403,17 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 };
 
+/*
+ * Every field of BCM2838GenetRegs is a uint32_t and the MMIO ops only allow
+ * naturally aligned 4-byte accesses, so a register can be accessed as a
+ * host-order uint32_t at its byte offset; the memory API takes care of the
+ * guest/host byte order difference.
+ */
+static inline uint32_t *bcm2838_genet_reg(BCM2838GenetState *s, hwaddr offset)
+{
+    QEMU_BUILD_BUG_ON(sizeof(BCM2838GenetRegs) % sizeof(uint32_t) != 0);
+
+    return (uint32_t *)((uint8_t *)&s->regs + offset);
+}
+
 #endif /* BCM2838_GENET_H */
-- 
2.55.0


