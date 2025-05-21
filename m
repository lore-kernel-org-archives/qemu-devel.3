Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC6CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHltO-0001gn-0F; Wed, 21 May 2025 12:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHltD-0001Vx-6i
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:56 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uHlt9-0000Wf-Ck
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EjgORWCxVXGE6WYnvxvXGhoWi/FN9cJTshKnA0rENI8=; b=aqTlcXXapM2ZKhHMMSA8fcTqOM
 yLzLkGg4Qu1roV5QaHalZy5qYCmnw1SKXRt9Xd9OBsQF9YoRXDC7UzEqwFJbLlj7eVgxTakRElLL7
 zOnUnHnIPVegtdNhjPOFcy5Mmpp7C3eY9C+OyiD6D0CfTzVFtB4IKeuYyssEEP4SxGT9IW9802YRZ
 ol5Ka835oxHYKd56zyN2TO5IGLIFR3ojmVCT1QnyNmMohPCmNO9NRNseRVLdyk7sJOKb0VW3UA6q/
 T+bWC6nOMxZrza82Mys+mhm4CbA28ilv+12kRRrjiVyIlwz6E+aBvh25XK11WQUGQe4vxVpr2p7cj
 c2kbMpcQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uHlt1-00FTdM-FE; Wed, 21 May 2025 17:01:43 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uHlt1-000000006RD-0tc3;
 Wed, 21 May 2025 17:01:43 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 qemu-devel@nongnu.org
Cc: ben.dooks@codethink.co.uk
Subject: [RFC 2/3] hw/net: add bit-bang mdio decoding helper (mdio_bb)
Date: Wed, 21 May 2025 17:01:41 +0100
Message-Id: <20250521160142.24715-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250521160142.24715-1-ben.dooks@codethink.co.uk>
References: <20250521160142.24715-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The mdio_bb allows PHY interfaces that are basically IO lines
that are twiddle by registers (although GPIO isn't supported
at this time, it would not be difficult to add)

The code processes the clock changes and issues a callback to
the driver when there is data to be transfered. It supports
both read and write, any other OP code is deemed invalid and
will abort the transfer.

todo:
- add proper vmstate helper for users
- get implementation fully tested with lowrisc_eth

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
notes:
- squashed in tracing and fixups
---
 hw/net/Kconfig           |   3 +
 hw/net/mdio_bb.c         | 167 +++++++++++++++++++++++++++++++++++++++
 hw/net/meson.build       |   1 +
 hw/net/trace-events      |   8 ++
 include/hw/net/mdio_bb.h |  50 ++++++++++++
 5 files changed, 229 insertions(+)
 create mode 100644 hw/net/mdio_bb.c
 create mode 100644 include/hw/net/mdio_bb.h

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 790fe1ce60..3abee9130e 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -109,6 +109,9 @@ config LASI_82596
     bool
     select I82596_COMMON
 
+config MDIO_BB
+    bool
+
 config LOWRISC_ETH
     bool
 
diff --git a/hw/net/mdio_bb.c b/hw/net/mdio_bb.c
new file mode 100644
index 0000000000..945f32b7a8
--- /dev/null
+++ b/hw/net/mdio_bb.c
@@ -0,0 +1,167 @@
+/*
+ * QEMU MDIO bit-bang emulaiton
+ *
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ * Copyright (c) 2025 Codethink Ltd,
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/net/mdio_bb.h"
+
+#include "trace.h"
+
+void mdio_bb_init(struct mdio_bb *s)
+{
+    s->mdi = true;
+    s->mdo = true;
+    s->mdc = true;
+
+    s->opcode = 0;
+    s->bitcount = 0;
+    s->phy_reg_addr = 0;
+    s->phy_data = 0;
+    s->state = MDG_IDLE;
+}
+
+void mdio_bb_update(struct mdio_bb *s,
+                    bool mdc, bool mdo)
+{
+    enum mdio_bb_state n_state = MDG_ILLEGAL;
+    bool rising = (!s->mdc && mdc);
+
+    s->mdc = mdc;
+    s->mdo = mdo;
+
+    /* work on rising edge of mdclk */
+    if (!rising)
+        return;
+
+    trace_mdio_bb_update(s->name, s->state, mdc, mdo);
+
+    switch (s->state) {
+    case MDG_IDLE:
+        /* if we get a '1' stick in idle,the pre-amble is 32 '1' bits */
+
+        if (!mdo) {
+            trace_mdio_bb_start(s->name);
+            n_state = MDG_START0;
+        } else {
+            n_state = MDG_IDLE;
+        }
+        break;
+
+    case MDG_START0:
+        if (!mdo) {
+            n_state = MDG_IDLE;
+        } else {
+            n_state = MDG_OP0;
+        };
+        break;
+
+    case MDG_OP0:
+        s->opcode = mdo << 1;
+        n_state = MDG_OP1;
+        break;
+
+    case MDG_OP1:
+        s->opcode |= mdo;
+        s->bitcount = 0;
+        s->phy_reg_addr = 0;
+
+        if (s->opcode == OP_READ || s->opcode == OP_WRITE) {
+            n_state = MDG_ADDR;
+        } else {
+            fprintf(stderr, "illegal MDIO op %02x\n", s->opcode);
+            n_state = MDG_ILLEGAL;
+        }
+        break;
+
+    case MDG_ADDR:
+        s->phy_reg_addr <<= 1;
+        s->phy_reg_addr |= mdo;
+        s->bitcount++;
+
+        if (s->bitcount == 10) {
+            n_state = MDG_TURN1;
+        } else {
+            n_state = MDG_ADDR;
+        }
+        break;
+
+    case MDG_TURN1:
+        n_state = MDG_TURN2;
+        break;
+
+    case MDG_TURN2:
+        s->bitcount = 15;
+
+        if (s->opcode == OP_READ) {
+            s->phy_data = (s->read)(s->param, s->phy_reg_addr);
+
+            trace_mdio_bb_read(s->name, s->phy_reg_addr >> 5,
+                               s->phy_reg_addr & 0x1f, s->phy_data);
+            n_state = MDG_READ;
+        } else {
+            n_state = MDG_WRITE;
+        }
+        break;
+
+    case MDG_READ:
+        s->mdi = s->phy_data & (1 << s->bitcount) ? 1 : 0;
+
+        if (s->bitcount == 0) {
+            n_state = MDG_IDLE;
+        } else {
+            s->bitcount--;
+            n_state = MDG_READ;
+        }
+        break;
+
+    case MDG_WRITE:
+        /* writing data to the phy, mirror the mdi as the same as mdo in case
+         * it is being checked, otherwise collect bits and invoke the write when
+         * all the bits are received
+         */
+        s->mdi = mdo;
+
+        if (mdo) {
+            s->phy_data |= 1 << s->bitcount;
+        }
+
+        if (!s->bitcount) {
+            trace_mdio_bb_write(s->name, s->phy_reg_addr >> 5,
+                                s->phy_reg_addr & 0x1f, s->phy_data);
+            (s->write)(s->param, s->phy_reg_addr, s->phy_data);
+            n_state = MDG_IDLE;
+        } else {
+            s->bitcount--;
+            n_state = MDG_WRITE;
+        }
+        break;
+
+    case MDG_ILLEGAL:
+        n_state = MDG_IDLE;
+        break;
+
+    default:
+        /* should not need a default state, but if so, illega. */
+        n_state = MDG_ILLEGAL;
+    }
+
+    if (n_state != MDG_ILLEGAL) {
+        trace_mdio_bb_new_state(s->name, s->state, n_state);
+        s->state = n_state;
+    } else {
+        /* encountered an illegal state. not much we can do here but go back
+         * into idle and hope that the reader is going to try and reset?
+         */
+
+        trace_mdio_bb_illegal_state(s->name, s->state, mdo);
+
+        fprintf(stderr, "mdio_bb: illegal next state from current %d (mdo %u)\n", s->state, mdo);
+        s->state = MDG_IDLE;
+    }
+}
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 79a65850fc..fe34ee5c15 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -1,6 +1,7 @@
 system_ss.add(when: 'CONFIG_DP8393X', if_true: files('dp8393x.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen_nic.c'))
 system_ss.add(when: 'CONFIG_NE2000_COMMON', if_true: files('ne2000.c'))
+system_ss.add(when: 'CONFIG_MDIO_BB', if_true: files('mdio_bb.c'))
 
 # PCI network cards
 system_ss.add(when: 'CONFIG_NE2000_PCI', if_true: files('ne2000-pci.c'))
diff --git a/hw/net/trace-events b/hw/net/trace-events
index acf1851eb4..e35324c4fd 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -312,6 +312,14 @@ igb_wrn_rx_desc_modes_not_supp(int desc_type) "Not supported descriptor type: %d
 # igbvf.c
 igbvf_wrn_io_addr_unknown(uint64_t addr) "IO unknown register 0x%"PRIx64
 
+# mdio_bb.c
+mdio_bb_update(const char *name, unsigned state, bool mdc, bool mdo) "(%s) state %u, mdc=%u mdo=%u"
+mdio_bb_start(const char *name) "(%s) starting transaction"
+mdio_bb_read(const char *name, unsigned phy, unsigned reg, unsigned data) "(%s) phy %d reg %u -> read %04x"
+mdio_bb_write(const char *name, unsigned phy, unsigned reg, unsigned data) "(%s) phy %d reg %u -> write  %04x"
+mdio_bb_new_state(const char *name, unsigned prev, unsigned state) "(%s) state %u to new state %u"
+mdio_bb_illegal_state(const char *name, unsigned last, unsigned mdo) "(%s) illegal state from %u (mdo %u)"
+
 # spapr_llan.c
 spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32
 spapr_vlan_get_rx_bd_from_page(int buf_ptr, uint64_t bd) "use_buf_ptr=%d bd=0x%016"PRIx64
diff --git a/include/hw/net/mdio_bb.h b/include/hw/net/mdio_bb.h
new file mode 100644
index 0000000000..d3f80267c9
--- /dev/null
+++ b/include/hw/net/mdio_bb.h
@@ -0,0 +1,50 @@
+/* MDIO GPIO based code
+ *
+ *  * Ben Dooks <ben.dooks@codethink.co.uk>
+ * Copyright (c) 2025 Codethink Ltd,
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+*/
+
+#ifndef MDIO_BB_H
+#define MDIO_BB_H
+
+ enum mdio_bb_state {
+    MDG_IDLE,
+    MDG_START0,
+    MDG_OP0,
+    MDG_OP1,
+    MDG_ADDR,
+    MDG_TURN1,
+    MDG_TURN2,
+    MDG_READ,
+    MDG_WRITE,
+    MDG_ILLEGAL,
+};
+
+#define OP_READ  (2)
+#define OP_WRITE (1)
+
+struct mdio_bb {
+    const char *name;
+    void *param;
+    bool mdc, mdo, mdi;
+    unsigned opcode;
+    unsigned bitcount;
+    unsigned phy_reg_addr;
+    unsigned phy_data;
+    enum mdio_bb_state state;
+
+    /* addresses are supplied as addr[4:0] = reg, addr[10:5] = phy-addr */
+    /* read called to read from phy, so supply data to the MDIO bus */
+    unsigned (*read)(void *opaque, unsigned addr);
+    /* write called when data written to phy */
+    void (*write)(void *opaque, unsigned addr, unsigned data);
+};
+
+extern void mdio_bb_init(struct mdio_bb *bb);
+
+extern void mdio_bb_update(struct mdio_bb *s,
+                           bool mdc, bool mdo);
+    
+#endif /* MDIO_BB_H */
-- 
2.37.2.352.g3c44437643


