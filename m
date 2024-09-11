Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AF7EE4998
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMGj-0003I4-5k; Wed, 11 Sep 2024 08:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGd-0002di-Rc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMGZ-0007SG-40
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-374c1e5fe79so4458952f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056969; x=1726661769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lejIJU4kxmt+LhgvW+tkuXq4ppkbZk/Bu8HvE1Ri0Rs=;
 b=JjSdvZL8Al3d87vHHWM/CXiOOzT+KKu5K4ZQIkfMRTPPjQAEdOSYiMaph8yeJJdOSK
 Zpnj63J2KicPJxNNk148KRNzQtIL+eUTOU7YbuY+MGU32yys7eQtDEe+yipuP3roPO5y
 eZqLkRWlEjVUnWY3j40CxuYWapNGZGjLyiSNlFm61Af1M4heoAWW8P5M2Vl/5kS/f8CB
 AK79dv7Bk+a0fbSWUGf7M+aZBwDVUNyoATPGihtnAjavvuUliFWptviAp/PS3UlBD8bd
 GJeu+s22U/6z49HdROBIOPekcxonlfjVnOenLZiJwBCKc33t+P7zYL0FJOlQ5ktxkKxN
 hu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056969; x=1726661769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lejIJU4kxmt+LhgvW+tkuXq4ppkbZk/Bu8HvE1Ri0Rs=;
 b=de7if7dfeJlXIWU0zTevH9UgR5PutG6Ss8fgmLmD6dzk0OASxvlQRWx2qibpmVE6XB
 omuzoEVr8EyNs8Xm5dNyXOnsJVKiBq6FwPIAA6H/H5E1nPVpltTUoHLVz3WGtewTCa47
 YmSmA5qyozdgAdm6vFFVLhkR1Cc2zJS8c6RkLvty2BoYhH1JxhAdWahuiH8SaPIhEOej
 DgI00Dtq2S147MrEE4+FgljC3831sippuPgY3cWrq6Wbbr7XD1hpjWiXSd6umXiSxxe9
 Fet603tvMP7bwKKW31yygjtn4gC2wHsYwgYhhg5b9EXhODtHQ5mbzjV+SwHM+M6iXObl
 IBRw==
X-Gm-Message-State: AOJu0YyoaO0lAiAHgpX70NwA88aUuVe+NOtI4TpMKo9DUc0Ft7hc+cpP
 4zlpFiPFwdZz4jZUnesf1zwxPGZm/d51H9KSIXYRRI9nwxhOGa9ShQhCyYD6IICfW7+UgYZ9yA6
 A
X-Google-Smtp-Source: AGHT+IFb/bycv8lqSpVB/O3/fFuZpS3l6dAc+H/Dkdpflkitr4JLbT83orpvXjRfOg8ZOvWIrR6rGQ==
X-Received: by 2002:adf:f602:0:b0:374:c977:7453 with SMTP id
 ffacd0b85a97d-378895d55a3mr10053128f8f.25.1726056968635; 
 Wed, 11 Sep 2024 05:16:08 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb8180csm141003815e9.35.2024.09.11.05.16.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 15/56] hw/net: Remove TYPE_ETRAX_FS_ETH device
Date: Wed, 11 Sep 2024 14:13:40 +0200
Message-ID: <20240911121422.52585-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
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

We just removed the single machine using it (axis-dev88).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-10-philmd@linaro.org>
---
 include/hw/cris/etraxfs.h |  36 --
 hw/net/etraxfs_eth.c      | 688 --------------------------------------
 hw/net/meson.build        |   1 -
 hw/net/trace-events       |   5 -
 4 files changed, 730 deletions(-)
 delete mode 100644 include/hw/cris/etraxfs.h
 delete mode 100644 hw/net/etraxfs_eth.c

diff --git a/include/hw/cris/etraxfs.h b/include/hw/cris/etraxfs.h
deleted file mode 100644
index 6d23f6f13f..0000000000
--- a/include/hw/cris/etraxfs.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * QEMU ETRAX System Emulator
- *
- * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef HW_ETRAXFS_H
-#define HW_ETRAXFS_H
-
-#include "net/net.h"
-#include "hw/cris/etraxfs_dma.h"
-#include "qapi/error.h"
-
-DeviceState *etraxfs_eth_init(hwaddr base, int phyaddr,
-                              struct etraxfs_dma_client *dma_out,
-                              struct etraxfs_dma_client *dma_in);
-
-#endif
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
deleted file mode 100644
index 5faf20c782..0000000000
--- a/hw/net/etraxfs_eth.c
+++ /dev/null
@@ -1,688 +0,0 @@
-/*
- * QEMU ETRAX Ethernet Controller.
- *
- * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/sysbus.h"
-#include "net/net.h"
-#include "hw/cris/etraxfs.h"
-#include "qemu/error-report.h"
-#include "qemu/module.h"
-#include "trace.h"
-#include "qom/object.h"
-
-#define D(x)
-
-/* Advertisement control register. */
-#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
-#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
-#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
-#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
-
-/*
- * The MDIO extensions in the TDK PHY model were reversed engineered from the
- * linux driver (PHYID and Diagnostics reg).
- * TODO: Add friendly names for the register nums.
- */
-struct qemu_phy
-{
-    uint32_t regs[32];
-
-    int link;
-
-    unsigned int (*read)(struct qemu_phy *phy, unsigned int req);
-    void (*write)(struct qemu_phy *phy, unsigned int req, unsigned int data);
-};
-
-static unsigned int tdk_read(struct qemu_phy *phy, unsigned int req)
-{
-    int regnum;
-    unsigned r = 0;
-
-    regnum = req & 0x1f;
-
-    switch (regnum) {
-    case 1:
-        if (!phy->link) {
-            break;
-        }
-        /* MR1.     */
-        /* Speeds and modes.  */
-        r |= (1 << 13) | (1 << 14);
-        r |= (1 << 11) | (1 << 12);
-        r |= (1 << 5); /* Autoneg complete.  */
-        r |= (1 << 3); /* Autoneg able.     */
-        r |= (1 << 2); /* link.     */
-        break;
-    case 5:
-        /* Link partner ability.
-           We are kind; always agree with whatever best mode
-           the guest advertises.  */
-        r = 1 << 14; /* Success.  */
-        /* Copy advertised modes.  */
-        r |= phy->regs[4] & (15 << 5);
-        /* Autoneg support.  */
-        r |= 1;
-        break;
-    case 18:
-    {
-        /* Diagnostics reg.  */
-        int duplex = 0;
-        int speed_100 = 0;
-
-        if (!phy->link) {
-            break;
-        }
-
-        /* Are we advertising 100 half or 100 duplex ? */
-        speed_100 = !!(phy->regs[4] & ADVERTISE_100HALF);
-        speed_100 |= !!(phy->regs[4] & ADVERTISE_100FULL);
-
-        /* Are we advertising 10 duplex or 100 duplex ? */
-        duplex = !!(phy->regs[4] & ADVERTISE_100FULL);
-        duplex |= !!(phy->regs[4] & ADVERTISE_10FULL);
-        r = (speed_100 << 10) | (duplex << 11);
-    }
-    break;
-
-    default:
-        r = phy->regs[regnum];
-        break;
-    }
-    trace_mdio_phy_read(regnum, r);
-    return r;
-}
-
-static void
-tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
-{
-    int regnum;
-
-    regnum = req & 0x1f;
-    trace_mdio_phy_write(regnum, data);
-    switch (regnum) {
-    default:
-        phy->regs[regnum] = data;
-        break;
-    }
-}
-
-static void
-tdk_reset(struct qemu_phy *phy)
-{
-    phy->regs[0] = 0x3100;
-    /* PHY Id.  */
-    phy->regs[2] = 0x0300;
-    phy->regs[3] = 0xe400;
-    /* Autonegotiation advertisement reg.  */
-    phy->regs[4] = 0x01E1;
-    phy->link = 1;
-}
-
-struct qemu_mdio
-{
-    /* bus.     */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
-    enum {
-        PREAMBLE,
-        SOF,
-        OPC,
-        ADDR,
-        REQ,
-        TURNAROUND,
-        DATA
-    } state;
-    unsigned int drive;
-
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
-
-    struct qemu_phy *devs[32];
-};
-
-static void
-mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = phy;
-}
-
-#ifdef USE_THIS_DEAD_CODE
-static void
-mdio_detach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = NULL;
-}
-#endif
-
-static void mdio_read_req(struct qemu_mdio *bus)
-{
-    struct qemu_phy *phy;
-
-    phy = bus->devs[bus->addr];
-    if (phy && phy->read) {
-        bus->data = phy->read(phy, bus->req);
-    } else {
-        bus->data = 0xffff;
-    }
-}
-
-static void mdio_write_req(struct qemu_mdio *bus)
-{
-    struct qemu_phy *phy;
-
-    phy = bus->devs[bus->addr];
-    if (phy && phy->write) {
-        phy->write(phy, bus->req, bus->data);
-    }
-}
-
-static void mdio_cycle(struct qemu_mdio *bus)
-{
-    bus->cnt++;
-
-    trace_mdio_bitbang(bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive);
-#if 0
-    if (bus->mdc) {
-        printf("%d", bus->mdio);
-    }
-#endif
-    switch (bus->state) {
-    case PREAMBLE:
-        if (bus->mdc) {
-            if (bus->cnt >= (32 * 2) && !bus->mdio) {
-                bus->cnt = 0;
-                bus->state = SOF;
-                bus->data = 0;
-            }
-        }
-        break;
-    case SOF:
-        if (bus->mdc) {
-            if (bus->mdio != 1) {
-                printf("WARNING: no SOF\n");
-            }
-            if (bus->cnt == 1*2) {
-                bus->cnt = 0;
-                bus->opc = 0;
-                bus->state = OPC;
-            }
-        }
-        break;
-    case OPC:
-        if (bus->mdc) {
-            bus->opc <<= 1;
-            bus->opc |= bus->mdio & 1;
-            if (bus->cnt == 2*2) {
-                bus->cnt = 0;
-                bus->addr = 0;
-                bus->state = ADDR;
-            }
-        }
-        break;
-    case ADDR:
-        if (bus->mdc) {
-            bus->addr <<= 1;
-            bus->addr |= bus->mdio & 1;
-
-            if (bus->cnt == 5*2) {
-                bus->cnt = 0;
-                bus->req = 0;
-                bus->state = REQ;
-            }
-        }
-        break;
-    case REQ:
-        if (bus->mdc) {
-            bus->req <<= 1;
-            bus->req |= bus->mdio & 1;
-            if (bus->cnt == 5*2) {
-                bus->cnt = 0;
-                bus->state = TURNAROUND;
-            }
-        }
-        break;
-    case TURNAROUND:
-        if (bus->mdc && bus->cnt == 2*2) {
-            bus->mdio = 0;
-            bus->cnt = 0;
-
-            if (bus->opc == 2) {
-                bus->drive = 1;
-                mdio_read_req(bus);
-                bus->mdio = bus->data & 1;
-            }
-            bus->state = DATA;
-        }
-        break;
-    case DATA:
-        if (!bus->mdc) {
-            if (bus->drive) {
-                bus->mdio = !!(bus->data & (1 << 15));
-                bus->data <<= 1;
-            }
-        } else {
-            if (!bus->drive) {
-                bus->data <<= 1;
-                bus->data |= bus->mdio;
-            }
-            if (bus->cnt == 16 * 2) {
-                bus->cnt = 0;
-                bus->state = PREAMBLE;
-                if (!bus->drive) {
-                    mdio_write_req(bus);
-                }
-                bus->drive = 0;
-            }
-        }
-        break;
-    default:
-        break;
-    }
-}
-
-/* ETRAX-FS Ethernet MAC block starts here.  */
-
-#define RW_MA0_LO      0x00
-#define RW_MA0_HI      0x01
-#define RW_MA1_LO      0x02
-#define RW_MA1_HI      0x03
-#define RW_GA_LO      0x04
-#define RW_GA_HI      0x05
-#define RW_GEN_CTRL      0x06
-#define RW_REC_CTRL      0x07
-#define RW_TR_CTRL      0x08
-#define RW_CLR_ERR      0x09
-#define RW_MGM_CTRL      0x0a
-#define R_STAT          0x0b
-#define FS_ETH_MAX_REGS      0x17
-
-#define TYPE_ETRAX_FS_ETH "etraxfs-eth"
-OBJECT_DECLARE_SIMPLE_TYPE(ETRAXFSEthState, ETRAX_FS_ETH)
-
-struct ETRAXFSEthState {
-    SysBusDevice parent_obj;
-
-    MemoryRegion mmio;
-    NICState *nic;
-    NICConf conf;
-
-    /* Two addrs in the filter.  */
-    uint8_t macaddr[2][6];
-    uint32_t regs[FS_ETH_MAX_REGS];
-
-    struct etraxfs_dma_client *dma_out;
-    struct etraxfs_dma_client *dma_in;
-
-    /* MDIO bus.  */
-    struct qemu_mdio mdio_bus;
-    unsigned int phyaddr;
-    int duplex_mismatch;
-
-    /* PHY.     */
-    struct qemu_phy phy;
-};
-
-static void eth_validate_duplex(ETRAXFSEthState *eth)
-{
-    struct qemu_phy *phy;
-    unsigned int phy_duplex;
-    unsigned int mac_duplex;
-    int new_mm = 0;
-
-    phy = eth->mdio_bus.devs[eth->phyaddr];
-    phy_duplex = !!(phy->read(phy, 18) & (1 << 11));
-    mac_duplex = !!(eth->regs[RW_REC_CTRL] & 128);
-
-    if (mac_duplex != phy_duplex) {
-        new_mm = 1;
-    }
-
-    if (eth->regs[RW_GEN_CTRL] & 1) {
-        if (new_mm != eth->duplex_mismatch) {
-            if (new_mm) {
-                printf("HW: WARNING ETH duplex mismatch MAC=%d PHY=%d\n",
-                       mac_duplex, phy_duplex);
-            } else {
-                printf("HW: ETH duplex ok.\n");
-            }
-        }
-        eth->duplex_mismatch = new_mm;
-    }
-}
-
-static uint64_t
-eth_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    ETRAXFSEthState *eth = opaque;
-    uint32_t r = 0;
-
-    addr >>= 2;
-
-    switch (addr) {
-    case R_STAT:
-        r = eth->mdio_bus.mdio & 1;
-        break;
-    default:
-        r = eth->regs[addr];
-        D(printf("%s %x\n", __func__, addr * 4));
-        break;
-    }
-    return r;
-}
-
-static void eth_update_ma(ETRAXFSEthState *eth, int ma)
-{
-    int reg;
-    int i = 0;
-
-    ma &= 1;
-
-    reg = RW_MA0_LO;
-    if (ma) {
-        reg = RW_MA1_LO;
-    }
-
-    eth->macaddr[ma][i++] = eth->regs[reg];
-    eth->macaddr[ma][i++] = eth->regs[reg] >> 8;
-    eth->macaddr[ma][i++] = eth->regs[reg] >> 16;
-    eth->macaddr[ma][i++] = eth->regs[reg] >> 24;
-    eth->macaddr[ma][i++] = eth->regs[reg + 1];
-    eth->macaddr[ma][i] = eth->regs[reg + 1] >> 8;
-
-    D(printf("set mac%d=%x.%x.%x.%x.%x.%x\n", ma,
-             eth->macaddr[ma][0], eth->macaddr[ma][1],
-             eth->macaddr[ma][2], eth->macaddr[ma][3],
-             eth->macaddr[ma][4], eth->macaddr[ma][5]));
-}
-
-static void
-eth_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    ETRAXFSEthState *eth = opaque;
-    uint32_t value = val64;
-
-    addr >>= 2;
-    switch (addr) {
-    case RW_MA0_LO:
-    case RW_MA0_HI:
-        eth->regs[addr] = value;
-        eth_update_ma(eth, 0);
-        break;
-    case RW_MA1_LO:
-    case RW_MA1_HI:
-        eth->regs[addr] = value;
-        eth_update_ma(eth, 1);
-        break;
-
-    case RW_MGM_CTRL:
-        /* Attach an MDIO/PHY abstraction.  */
-        if (value & 2) {
-            eth->mdio_bus.mdio = value & 1;
-        }
-        if (eth->mdio_bus.mdc != (value & 4)) {
-            mdio_cycle(&eth->mdio_bus);
-            eth_validate_duplex(eth);
-        }
-        eth->mdio_bus.mdc = !!(value & 4);
-        eth->regs[addr] = value;
-        break;
-
-    case RW_REC_CTRL:
-        eth->regs[addr] = value;
-        eth_validate_duplex(eth);
-        break;
-
-    default:
-        eth->regs[addr] = value;
-        D(printf("%s %x %x\n", __func__, addr, value));
-        break;
-    }
-}
-
-/* The ETRAX FS has a groupt address table (GAT) which works like a k=1 bloom
-   filter dropping group addresses we have not joined.    The filter has 64
-   bits (m). The has function is a simple nible xor of the group addr.    */
-static int eth_match_groupaddr(ETRAXFSEthState *eth, const unsigned char *sa)
-{
-    unsigned int hsh;
-    int m_individual = eth->regs[RW_REC_CTRL] & 4;
-    int match;
-
-    /* First bit on the wire of a MAC address signals multicast or
-       physical address.  */
-    if (!m_individual && !(sa[0] & 1)) {
-        return 0;
-    }
-
-    /* Calculate the hash index for the GA registers. */
-    hsh = 0;
-    hsh ^= (*sa) & 0x3f;
-    hsh ^= ((*sa) >> 6) & 0x03;
-    ++sa;
-    hsh ^= ((*sa) << 2) & 0x03c;
-    hsh ^= ((*sa) >> 4) & 0xf;
-    ++sa;
-    hsh ^= ((*sa) << 4) & 0x30;
-    hsh ^= ((*sa) >> 2) & 0x3f;
-    ++sa;
-    hsh ^= (*sa) & 0x3f;
-    hsh ^= ((*sa) >> 6) & 0x03;
-    ++sa;
-    hsh ^= ((*sa) << 2) & 0x03c;
-    hsh ^= ((*sa) >> 4) & 0xf;
-    ++sa;
-    hsh ^= ((*sa) << 4) & 0x30;
-    hsh ^= ((*sa) >> 2) & 0x3f;
-
-    hsh &= 63;
-    if (hsh > 31) {
-        match = eth->regs[RW_GA_HI] & (1 << (hsh - 32));
-    } else {
-        match = eth->regs[RW_GA_LO] & (1 << hsh);
-    }
-    D(printf("hsh=%x ga=%x.%x mtch=%d\n", hsh,
-             eth->regs[RW_GA_HI], eth->regs[RW_GA_LO], match));
-    return match;
-}
-
-static ssize_t eth_receive(NetClientState *nc, const uint8_t *buf, size_t size)
-{
-    unsigned char sa_bcast[6] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
-    ETRAXFSEthState *eth = qemu_get_nic_opaque(nc);
-    int use_ma0 = eth->regs[RW_REC_CTRL] & 1;
-    int use_ma1 = eth->regs[RW_REC_CTRL] & 2;
-    int r_bcast = eth->regs[RW_REC_CTRL] & 8;
-
-    if (size < 12) {
-        return -1;
-    }
-
-    D(printf("%x.%x.%x.%x.%x.%x ma=%d %d bc=%d\n",
-         buf[0], buf[1], buf[2], buf[3], buf[4], buf[5],
-         use_ma0, use_ma1, r_bcast));
-
-    /* Does the frame get through the address filters?  */
-    if ((!use_ma0 || memcmp(buf, eth->macaddr[0], 6))
-        && (!use_ma1 || memcmp(buf, eth->macaddr[1], 6))
-        && (!r_bcast || memcmp(buf, sa_bcast, 6))
-        && !eth_match_groupaddr(eth, buf)) {
-        return size;
-    }
-
-    /* FIXME: Find another way to pass on the fake csum.  */
-    etraxfs_dmac_input(eth->dma_in, (void *)buf, size + 4, 1);
-
-    return size;
-}
-
-static int eth_tx_push(void *opaque, unsigned char *buf, int len, bool eop)
-{
-    ETRAXFSEthState *eth = opaque;
-
-    D(printf("%s buf=%p len=%d\n", __func__, buf, len));
-    qemu_send_packet(qemu_get_queue(eth->nic), buf, len);
-    return len;
-}
-
-static void eth_set_link(NetClientState *nc)
-{
-    ETRAXFSEthState *eth = qemu_get_nic_opaque(nc);
-    D(printf("%s %d\n", __func__, nc->link_down));
-    eth->phy.link = !nc->link_down;
-}
-
-static const MemoryRegionOps eth_ops = {
-    .read = eth_read,
-    .write = eth_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 4
-    }
-};
-
-static NetClientInfo net_etraxfs_info = {
-    .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState),
-    .receive = eth_receive,
-    .link_status_changed = eth_set_link,
-};
-
-static void etraxfs_eth_reset(DeviceState *dev)
-{
-    ETRAXFSEthState *s = ETRAX_FS_ETH(dev);
-
-    memset(s->regs, 0, sizeof(s->regs));
-    memset(s->macaddr, 0, sizeof(s->macaddr));
-    s->duplex_mismatch = 0;
-
-    s->mdio_bus.mdc = 0;
-    s->mdio_bus.mdio = 0;
-    s->mdio_bus.state = 0;
-    s->mdio_bus.drive = 0;
-    s->mdio_bus.cnt = 0;
-    s->mdio_bus.addr = 0;
-    s->mdio_bus.opc = 0;
-    s->mdio_bus.req = 0;
-    s->mdio_bus.data = 0;
-
-    tdk_reset(&s->phy);
-}
-
-static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
-{
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    ETRAXFSEthState *s = ETRAX_FS_ETH(dev);
-
-    if (!s->dma_out || !s->dma_in) {
-        error_setg(errp, "Unconnected ETRAX-FS Ethernet MAC");
-        return;
-    }
-
-    s->dma_out->client.push = eth_tx_push;
-    s->dma_out->client.opaque = s;
-    s->dma_in->client.opaque = s;
-    s->dma_in->client.pull = NULL;
-
-    memory_region_init_io(&s->mmio, OBJECT(dev), &eth_ops, s,
-                          "etraxfs-eth", 0x5c);
-    sysbus_init_mmio(sbd, &s->mmio);
-
-    qemu_macaddr_default_if_unset(&s->conf.macaddr);
-    s->nic = qemu_new_nic(&net_etraxfs_info, &s->conf,
-                          object_get_typename(OBJECT(s)), dev->id,
-                          &dev->mem_reentrancy_guard, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-
-    s->phy.read = tdk_read;
-    s->phy.write = tdk_write;
-    mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
-}
-
-static Property etraxfs_eth_properties[] = {
-    DEFINE_PROP_UINT32("phyaddr", ETRAXFSEthState, phyaddr, 1),
-    DEFINE_NIC_PROPERTIES(ETRAXFSEthState, conf),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->realize = etraxfs_eth_realize;
-    dc->reset = etraxfs_eth_reset;
-    device_class_set_props(dc, etraxfs_eth_properties);
-    /* Reason: dma_out, dma_in are not user settable */
-    dc->user_creatable = false;
-}
-
-
-/* Instantiate an ETRAXFS Ethernet MAC.  */
-DeviceState *
-etraxfs_eth_init(hwaddr base, int phyaddr,
-                 struct etraxfs_dma_client *dma_out,
-                 struct etraxfs_dma_client *dma_in)
-{
-    DeviceState *dev;
-
-    dev = qdev_new("etraxfs-eth");
-    qemu_configure_nic_device(dev, true, "fseth");
-    qdev_prop_set_uint32(dev, "phyaddr", phyaddr);
-
-    /*
-     * TODO: QOM design, define a QOM interface for "I am an etraxfs
-     * DMA client" (which replaces the current 'struct
-     * etraxfs_dma_client' ad-hoc interface), implement it on the
-     * ethernet device, and then have QOM link properties on the DMA
-     * controller device so that you can pass the interface
-     * implementations to it.
-     */
-    ETRAX_FS_ETH(dev)->dma_out = dma_out;
-    ETRAX_FS_ETH(dev)->dma_in = dma_in;
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-
-    return dev;
-}
-
-static const TypeInfo etraxfs_eth_info = {
-    .name          = TYPE_ETRAX_FS_ETH,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(ETRAXFSEthState),
-    .class_init    = etraxfs_eth_class_init,
-};
-
-static void etraxfs_eth_register_types(void)
-{
-    type_register_static(&etraxfs_eth_info);
-}
-
-type_init(etraxfs_eth_register_types)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index b7426870e8..00a9e9dd51 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -40,7 +40,6 @@ system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
 
-system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
 system_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 78efa2ec2c..4c6687923e 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -10,11 +10,6 @@ allwinner_sun8i_emac_set_link(bool active) "Set link: active=%u"
 allwinner_sun8i_emac_read(uint64_t offset, uint64_t val) "MMIO read: offset=0x%" PRIx64 " value=0x%" PRIx64
 allwinner_sun8i_emac_write(uint64_t offset, uint64_t val) "MMIO write: offset=0x%" PRIx64 " value=0x%" PRIx64
 
-# etraxfs_eth.c
-mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d value:0x%04x"
-mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d value:0x%04x"
-mdio_bitbang(bool mdc, bool mdio, int state, uint16_t cnt, unsigned int drive) "bitbang mdc=%u mdio=%u state=%d cnt=%u drv=%d"
-
 # lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
-- 
2.45.2


