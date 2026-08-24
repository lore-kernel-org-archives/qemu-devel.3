Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8AAC5DF98
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNY8-0001Ea-OR; Mon, 24 Aug 2026 01:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXm-0001Bc-AV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNXg-0001eI-R1
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso42927395ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550499; x=1788155299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNNxXaJ+Or2i1Q1aGVJVXL9TXSX4iTkeTCQgBWZpiug=;
 b=OlimQ48hWXjuKRGYnnzUUOsEg4jm4zO0NTu7AzqQUAL91QesSJeOBpWFZSiuRya0yW
 ZbuqvWE2RLIv9/hHQH2UY1QYAFMhSIIuZj3wOsJcTqfzAxJzxCmgQpTe0zeBAFekDI3I
 8D3Kh6zBp8H2XJU/G7U8HQdkiWvQe1BPUmdQxMIL2vbX4opCC7dBL/Gg1Tgi8zb0i/Z/
 jAU0M7/bQqkZJ/+aJFsd772IUabda1qetS3chJdQmMlTBqxruRD3y08i3BEvFAs/9I9I
 o3r4R5pmYjpfh/cSPAtbCX6HY43TH8clPBaWoQga0RYW3ABiqHxLW/9L+hx/EEZBwLjL
 va3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550499; x=1788155299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HNNxXaJ+Or2i1Q1aGVJVXL9TXSX4iTkeTCQgBWZpiug=;
 b=Lj7vs7V2pZneRiToyb7/1mJXqSbf19PucCiD4KOqifDo6rg5MMpRAUihI1Mn8MEZZw
 QHElj/e0ooz8UZ9NIzZMhJWgI2qOhDxcxPAVPt0J6aHvtSsfNuqIYbylLQYCGmd2r/jM
 gByVFHRioPwqNN4AMmB3cMBUoEPmx1IEwKKkba9hqvRO/pRleALAZQh9LzksiWa2PaBF
 5pFzIOGaJJEWWS1kY8a2ylfwJrw0BSvuqs/Uu8OfZzBZ/MPvdF07qmOO1XBzQZcAeLRh
 BMfRqEylAXfHTaHmlk7nUKhkCHMF8XRxGmVcF1GyHlvZD01yUaK+GMv82d769zfN6oms
 7aig==
X-Gm-Message-State: AFuF++ky5UISaWnHypqi94M1RkuGSyjQEKYLcBzy7vQO41zfZXTs5T6Y
 AaXn/FT768inSMS1LdU7wNi3JkPxkbaZbx+arOmvMWWnJXL3Nm7hggyXaICCfw==
X-Gm-Gg: AR+sD12vh+osK0B9Nta44G8HIuPRI/DwvSApufzBzyezN+T26QeIYaE6ULt0Z8h81QZ
 AxBFZSurjT+MQDfR0Qox0tZiRMdEp8n8aDdi7Bpe9tpUkB/CJYCsIg/yftJiGbh8/gV5+1ICexa
 +rhHvDzIljm7YmzdfX4HAqw4LQopeslbsooLfaWAaKIjT4Zg5YcukMvZXHwVUmK8hNhWJZKXRMF
 ismW75dP1ztWKdv/XNHYYcgp1VUBabj1wQubXINGAsUVDXyk081yTmwLKGZVaZ3Ell4wLPyN5hL
 hclE7IrBwr0F7m0lhg/WSMKa/crf+FPTSlYEjwhDvx75PhcYjxhF8hIMdGoMk7T6xN7uaVsGg+c
 oDIZc1uT6ujc32Me3HI3jqPyZC7KRAo7zcTOi5YphrNZKgMvkGEQwYC7SahMXM0QiygFU3pSMHv
 4Ab5yz7YzVqWG4vYx2Wabgbujj3bg3XcgKMcxcrPjfPllmzAfk3Iv7iELQyvnhWv8j9QGAtdKqO
 WpKEw==
X-Received: by 2002:a17:90b:5823:b0:38e:c232:9d2c with SMTP id
 98e67ed59e1d1-395c4bde19amr22145368a91.2.1787550498915; 
 Sun, 23 Aug 2026 22:48:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Junze Cao <caojunze424@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 01/96] hw/misc: Add K230 DDR controller and PHY models
Date: Mon, 24 Aug 2026 15:46:31 +1000
Message-ID: <20260824054806.2790041-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
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

From: Junze Cao <caojunze424@gmail.com>

The K230 SDK U-Boot SPL programs K230 DDRC CFG and K230 DDR PHY
registers before DRAM can be used.

Add separate SysBus devices for both register ranges. Model controller
reset values, DFI and software-update handshakes. For the PHY, model
register ownership, the training mailbox, and DFI completion.

Include migration state for both devices.

Signed-off-by: Junze Cao <caojunze424@gmail.com>
Suggested-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260807-k230-ddr-v2-v2-1-c531308ae819@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                |   2 +
 include/hw/misc/k230_ddr.h |  59 ++++
 hw/misc/k230_ddr.c         | 556 +++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build        |   1 +
 4 files changed, 618 insertions(+)
 create mode 100644 include/hw/misc/k230_ddr.h
 create mode 100644 hw/misc/k230_ddr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 08017f4786..cc0879c868 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1844,8 +1844,10 @@ M: Chao Liu <chao.liu@processmission.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: docs/system/riscv/k230.rst
+F: hw/misc/k230_ddr.c
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
+F: include/hw/misc/k230_ddr.h
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: tests/functional/riscv64/test_k230.py
diff --git a/include/hw/misc/k230_ddr.h b/include/hw/misc/k230_ddr.h
new file mode 100644
index 0000000000..d912e8e1b0
--- /dev/null
+++ b/include/hw/misc/k230_ddr.h
@@ -0,0 +1,59 @@
+/*
+ * Kendryte K230 DDR controller and PHY models
+ *
+ * Device state and type declarations for the K230 DDRC CFG and K230 DDR PHY
+ * registers.
+ *
+ * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_K230_DDR_H
+#define HW_MISC_K230_DDR_H
+
+#include "hw/core/sysbus.h"
+
+#define K230_DDRC_MMIO_SIZE    0x02000000
+#define K230_DDR_PHY_MMIO_SIZE 0x00400000
+
+#define K230_DDRC_REG_SIZE  0x328
+#define K230_DDRC_REG_COUNT (K230_DDRC_REG_SIZE / sizeof(uint32_t))
+
+#define K230_DDR_PHY_ANIB_COUNT             10
+#define K230_DDR_PHY_DBYTE_COUNT             4
+#define K230_DDR_PHY_NIBBLES_PER_DBYTE       2
+
+#define TYPE_K230_DDR_CFG "riscv.k230.ddr-cfg"
+OBJECT_DECLARE_SIMPLE_TYPE(K230DDRCfgState, K230_DDR_CFG)
+
+#define TYPE_K230_DDR_PHY "riscv.k230.ddr-phy"
+OBJECT_DECLARE_SIMPLE_TYPE(K230DDRPhyState, K230_DDR_PHY)
+
+struct K230DDRCfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    K230DDRPhyState *phy;
+    uint32_t regs[K230_DDRC_REG_COUNT];
+    bool initialized;
+};
+
+struct K230DDRPhyState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    uint16_t atx_impedance[K230_DDR_PHY_ANIB_COUNT];
+    uint16_t tx_impedance_ctrl1[K230_DDR_PHY_DBYTE_COUNT]
+                                [K230_DDR_PHY_NIBBLES_PER_DBYTE];
+    uint16_t tx_odt_drv_stren[K230_DDR_PHY_DBYTE_COUNT]
+                             [K230_DDR_PHY_NIBBLES_PER_DBYTE];
+    uint16_t dfi_init_complete;
+    uint16_t vref_in_global;
+    uint16_t micro_cont_mux_sel;
+    bool training_trigger_seen;
+    bool training_complete;
+    bool mailbox_message_pending;
+};
+
+#endif
diff --git a/hw/misc/k230_ddr.c b/hw/misc/k230_ddr.c
new file mode 100644
index 0000000000..dac700b201
--- /dev/null
+++ b/hw/misc/k230_ddr.c
@@ -0,0 +1,556 @@
+/*
+ * Kendryte K230 DDR controller and PHY models
+ *
+ * Models the K230 DDRC CFG registers and K230 DDR PHY registers exercised
+ * by the K230 SDK U-Boot SPL.
+ *
+ * Copyright (c) 2026 Junze Cao <caojunze424@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+#include "hw/core/registerfields.h"
+#include "hw/core/resettable.h"
+#include "hw/misc/k230_ddr.h"
+
+/* DDRC CFG registers */
+
+enum K230DDRCOperatingMode {
+    K230_DDRC_MODE_INIT = 0,
+    K230_DDRC_MODE_NORMAL = 1,
+};
+
+REG32(K230_DDRC_MSTR, 0x000)
+
+REG32(K230_DDRC_STAT, 0x004)
+    FIELD(K230_DDRC_STAT, OPERATING_MODE, 0, 3)
+
+REG32(K230_DDRC_PWRCTL, 0x030)
+
+REG32(K230_DDRC_RFSHCTL0, 0x050)
+
+REG32(K230_DDRC_RFSHTMG, 0x064)
+
+REG32(K230_DDRC_RFSHTMG1, 0x068)
+
+REG32(K230_DDRC_INIT0, 0x0d0)
+
+REG32(K230_DDRC_INIT2, 0x0d8)
+
+REG32(K230_DDRC_INIT3, 0x0dc)
+
+REG32(K230_DDRC_INIT5, 0x0e4)
+
+REG32(K230_DDRC_DRAMTMG0, 0x100)
+#define R_K230_DDRC_DRAMTMG(index) \
+    (R_K230_DDRC_DRAMTMG0 + (index))
+
+REG32(K230_DDRC_ZQCTL0, 0x180)
+
+REG32(K230_DDRC_ZQCTL1, 0x184)
+
+REG32(K230_DDRC_ZQCTL2, 0x188)
+
+REG32(K230_DDRC_ZQSTAT, 0x18c)
+
+REG32(K230_DDRC_DFITMG0, 0x190)
+
+REG32(K230_DDRC_DFITMG1, 0x194)
+
+REG32(K230_DDRC_DFIUPD0, 0x1a0)
+
+REG32(K230_DDRC_DFIUPD1, 0x1a4)
+
+REG32(K230_DDRC_DFIUPD2, 0x1a8)
+
+REG32(K230_DDRC_DFIMISC, 0x1b0)
+    FIELD(K230_DDRC_DFIMISC, DFI_INIT_COMPLETE_EN, 0, 1)
+    FIELD(K230_DDRC_DFIMISC, DFI_INIT_START, 5, 1)
+
+REG32(K230_DDRC_DFITMG2, 0x1b4)
+
+REG32(K230_DDRC_DFISTAT, 0x1bc)
+    FIELD(K230_DDRC_DFISTAT, DFI_INIT_COMPLETE, 0, 1)
+
+REG32(K230_DDRC_ODTCFG, 0x240)
+
+REG32(K230_DDRC_SWCTL, 0x320)
+    FIELD(K230_DDRC_SWCTL, SW_DONE, 0, 1)
+
+REG32(K230_DDRC_SWSTAT, 0x324)
+    FIELD(K230_DDRC_SWSTAT, SW_DONE_ACK, 0, 1)
+
+static const uint32_t k230_ddrc_reset_values[K230_DDRC_REG_COUNT] = {
+    [R_K230_DDRC_MSTR]      = 0x01040000,
+    [R_K230_DDRC_RFSHCTL0]  = 0x00210000,
+    [R_K230_DDRC_RFSHTMG]   = 0x0062008c,
+    [R_K230_DDRC_RFSHTMG1]  = 0x0000008c,
+    [R_K230_DDRC_INIT0]     = 0x0002004e,
+    [R_K230_DDRC_INIT3]     = 0x00000510,
+    [R_K230_DDRC_INIT5]     = 0x00100000,
+    [R_K230_DDRC_DRAMTMG(0)]  = 0x0f101b0f,
+    [R_K230_DDRC_DRAMTMG(1)]  = 0x00080414,
+    [R_K230_DDRC_DRAMTMG(2)]  = 0x0305060d,
+    [R_K230_DDRC_DRAMTMG(3)]  = 0x00004000,
+    [R_K230_DDRC_DRAMTMG(4)]  = 0x05040405,
+    [R_K230_DDRC_DRAMTMG(5)]  = 0x05050403,
+    [R_K230_DDRC_DRAMTMG(6)]  = 0x02020005,
+    [R_K230_DDRC_DRAMTMG(7)]  = 0x00000202,
+    [R_K230_DDRC_DRAMTMG(8)]  = 0x03034405,
+    [R_K230_DDRC_DRAMTMG(9)]  = 0x0004040d,
+    [R_K230_DDRC_DRAMTMG(10)] = 0x001c180a,
+    [R_K230_DDRC_DRAMTMG(11)] = 0x440c021c,
+    [R_K230_DDRC_DRAMTMG(12)] = 0x00020610,
+    [R_K230_DDRC_DRAMTMG(13)] = 0x1c200004,
+    [R_K230_DDRC_DRAMTMG(14)] = 0x000000a0,
+    [R_K230_DDRC_DRAMTMG(16)] = 0x05100404,
+    [R_K230_DDRC_ZQCTL0]    = 0x02000040,
+    [R_K230_DDRC_ZQCTL1]    = 0x02000100,
+    [R_K230_DDRC_DFITMG0]   = 0x07020002,
+    [R_K230_DDRC_DFITMG1]   = 0x00000404,
+    [R_K230_DDRC_DFIUPD0]   = 0x00400003,
+    [R_K230_DDRC_DFIUPD1]   = 0x00010001,
+    [R_K230_DDRC_DFIUPD2]   = 0x80000000,
+    [R_K230_DDRC_DFIMISC]   = 0x00000001,
+    [R_K230_DDRC_DFITMG2]   = 0x00000202,
+    [R_K230_DDRC_ODTCFG]    = 0x04000400,
+    [R_K230_DDRC_SWCTL]     = 0x00000001,
+    [R_K230_DDRC_SWSTAT]    = 0x00000001,
+};
+
+/* K230 DDR PHY CSRs use byte offset = CSR index * 4. */
+#define K230_DDR_PHY_CSR_OFFSET(index) ((index) * 4)
+#define K230_DDR_PHY_MASTER_CSR(reg) \
+    K230_DDR_PHY_CSR_OFFSET(0x20000 + (reg))
+#define K230_DDR_PHY_APBONLY_CSR(reg) \
+    K230_DDR_PHY_CSR_OFFSET(0xd0000 + (reg))
+
+#define K230_DDR_PHY_ATX_IMPEDANCE_RESET UINT32_C(0x03ff)
+
+REG32(K230_DDR_PHY_MICRO_CONT_MUX_SEL,
+      K230_DDR_PHY_APBONLY_CSR(0x000))
+    FIELD(K230_DDR_PHY_MICRO_CONT_MUX_SEL, MICRO_CONT_MUX_SEL, 0, 1)
+
+REG32(K230_DDR_PHY_TRAINING_STATUS,
+      K230_DDR_PHY_APBONLY_CSR(0x004))
+    FIELD(K230_DDR_PHY_TRAINING_STATUS, MAILBOX_EMPTY, 0, 1)
+
+REG32(K230_DDR_PHY_TRAINING_ACK,
+      K230_DDR_PHY_APBONLY_CSR(0x031))
+
+REG32(K230_DDR_PHY_TRAINING_MESSAGE,
+      K230_DDR_PHY_APBONLY_CSR(0x032))
+
+REG32(K230_DDR_PHY_TRAINING_TRIGGER,
+      K230_DDR_PHY_APBONLY_CSR(0x099))
+
+#define K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET UINT32_C(0x0fff)
+
+REG32(K230_DDR_PHY_DFI_INIT_COMPLETE,
+      K230_DDR_PHY_MASTER_CSR(0x0f9))
+    FIELD(K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 0, 1)
+
+REG32(K230_DDR_PHY_VREF_IN_GLOBAL,
+      K230_DDR_PHY_MASTER_CSR(0x0b2))
+#define K230_DDR_PHY_VREF_IN_GLOBAL_RESET UINT32_C(0x0200)
+
+static void k230_ddr_cfg_update_state(K230DDRCfgState *s)
+{
+    bool dfi_complete = false;
+    unsigned int operating_mode = K230_DDRC_MODE_INIT;
+
+    if (s->phy) {
+        dfi_complete = FIELD_EX32(s->phy->dfi_init_complete,
+                                  K230_DDR_PHY_DFI_INIT_COMPLETE,
+                                  DFI_INIT_COMPLETE);
+    }
+
+    ARRAY_FIELD_DP32(s->regs, K230_DDRC_DFISTAT,
+                     DFI_INIT_COMPLETE, dfi_complete);
+    ARRAY_FIELD_DP32(s->regs, K230_DDRC_SWSTAT, SW_DONE_ACK,
+                     ARRAY_FIELD_EX32(s->regs, K230_DDRC_SWCTL, SW_DONE));
+
+    if (dfi_complete &&
+        ARRAY_FIELD_EX32(s->regs, K230_DDRC_DFIMISC,
+                         DFI_INIT_COMPLETE_EN)) {
+        s->initialized = true;
+    }
+
+    if (s->initialized) {
+        operating_mode = K230_DDRC_MODE_NORMAL;
+    }
+
+    ARRAY_FIELD_DP32(s->regs, K230_DDRC_STAT,
+                     OPERATING_MODE, operating_mode);
+}
+
+static uint64_t k230_ddr_cfg_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    K230DDRCfgState *s = opaque;
+    uint64_t value = 0;
+
+    if (addr < K230_DDRC_REG_SIZE) {
+        k230_ddr_cfg_update_state(s);
+        value = s->regs[addr / sizeof(uint32_t)];
+    }
+
+    return value;
+}
+
+static void k230_ddr_cfg_write(void *opaque, hwaddr addr, uint64_t value,
+                               unsigned int size)
+{
+    K230DDRCfgState *s = opaque;
+    uint32_t val = value;
+
+    if (addr >= K230_DDRC_REG_SIZE) {
+        return;
+    }
+
+    switch (addr) {
+    case A_K230_DDRC_STAT:
+    case A_K230_DDRC_DFISTAT:
+    case A_K230_DDRC_ZQSTAT:
+    case A_K230_DDRC_SWSTAT:
+        return;
+    case A_K230_DDRC_PWRCTL:
+        s->regs[R_K230_DDRC_PWRCTL] = val & MAKE_64BIT_MASK(0, 9);
+        break;
+    case A_K230_DDRC_ZQCTL2:
+        /* ZQ reset completes immediately and the W1S bit self-clears. */
+        s->regs[R_K230_DDRC_ZQCTL2] = 0;
+        s->regs[R_K230_DDRC_ZQSTAT] = 0;
+        break;
+    case A_K230_DDRC_DFIMISC:
+        s->regs[R_K230_DDRC_DFIMISC] =
+            val & (MAKE_64BIT_MASK(0, 6) | MAKE_64BIT_MASK(8, 5));
+        if (s->phy && s->phy->training_complete &&
+            FIELD_EX32(val, K230_DDRC_DFIMISC, DFI_INIT_START)) {
+            s->phy->dfi_init_complete = FIELD_DP32(
+                s->phy->dfi_init_complete,
+                K230_DDR_PHY_DFI_INIT_COMPLETE, DFI_INIT_COMPLETE, 1);
+        }
+        break;
+    case A_K230_DDRC_SWCTL:
+        s->regs[R_K230_DDRC_SWCTL] =
+            val & R_K230_DDRC_SWCTL_SW_DONE_MASK;
+        break;
+    default:
+        s->regs[addr / sizeof(uint32_t)] = val;
+        break;
+    }
+
+    k230_ddr_cfg_update_state(s);
+}
+
+static bool k230_ddr_phy_decode_anib(hwaddr addr, unsigned int *anib)
+{
+    uint32_t csr = addr / sizeof(uint32_t);
+
+    if ((csr & 0xfff) != 0x043) {
+        return false;
+    }
+
+    *anib = csr >> 12;
+    return *anib < K230_DDR_PHY_ANIB_COUNT;
+}
+
+static bool k230_ddr_phy_decode_dbyte(hwaddr addr, uint32_t reg,
+                                     unsigned int *dbyte,
+                                     unsigned int *nibble)
+{
+    uint32_t csr = addr / sizeof(uint32_t);
+    uint32_t block_offset;
+
+    if (csr < 0x10000) {
+        return false;
+    }
+
+    csr -= 0x10000;
+    *dbyte = csr >> 12;
+    if (*dbyte >= K230_DDR_PHY_DBYTE_COUNT) {
+        return false;
+    }
+
+    block_offset = csr & 0xfff;
+    *nibble = block_offset >> 8;
+    return *nibble < K230_DDR_PHY_NIBBLES_PER_DBYTE &&
+           (block_offset & 0xff) == reg;
+}
+
+static uint64_t k230_ddr_phy_read(void *opaque, hwaddr addr,
+                                  unsigned int size)
+{
+    K230DDRPhyState *s = opaque;
+    unsigned int dbyte;
+    unsigned int nibble;
+    unsigned int anib;
+    uint64_t value = 0;
+
+    switch (addr) {
+    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
+        value = s->micro_cont_mux_sel;
+        break;
+    case A_K230_DDR_PHY_TRAINING_STATUS:
+        value = s->mailbox_message_pending ? 0 :
+                R_K230_DDR_PHY_TRAINING_STATUS_MAILBOX_EMPTY_MASK;
+        break;
+    case A_K230_DDR_PHY_TRAINING_MESSAGE:
+        value = s->training_complete ? 0x07 : 0;
+        break;
+    case A_K230_DDR_PHY_TRAINING_ACK:
+    case A_K230_DDR_PHY_TRAINING_TRIGGER:
+        break;
+    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
+        value = s->dfi_init_complete;
+        break;
+    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
+        value = s->vref_in_global;
+        break;
+    default:
+        if (k230_ddr_phy_decode_anib(addr, &anib)) {
+            value = s->atx_impedance[anib];
+        } else if (k230_ddr_phy_decode_dbyte(addr, 0x049,
+                                            &dbyte, &nibble)) {
+            value = s->tx_impedance_ctrl1[dbyte][nibble];
+        } else if (k230_ddr_phy_decode_dbyte(addr, 0x04d,
+                                            &dbyte, &nibble)) {
+            value = s->tx_odt_drv_stren[dbyte][nibble];
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: unimplemented DDR PHY read at offset 0x%"
+                          HWADDR_PRIx ", returning 0\n",
+                          __func__, addr);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void k230_ddr_phy_write(void *opaque, hwaddr addr, uint64_t value,
+                               unsigned int size)
+{
+    K230DDRPhyState *s = opaque;
+    uint16_t val = value;
+    unsigned int dbyte;
+    unsigned int nibble;
+    unsigned int anib;
+
+    switch (addr) {
+    case A_K230_DDR_PHY_MICRO_CONT_MUX_SEL:
+        s->micro_cont_mux_sel =
+            val & R_K230_DDR_PHY_MICRO_CONT_MUX_SEL_MICRO_CONT_MUX_SEL_MASK;
+        return;
+    case A_K230_DDR_PHY_TRAINING_STATUS:
+    case A_K230_DDR_PHY_TRAINING_MESSAGE:
+        return;
+    case A_K230_DDR_PHY_TRAINING_ACK:
+        if (val == 0) {
+            s->mailbox_message_pending = false;
+        }
+        return;
+    case A_K230_DDR_PHY_TRAINING_TRIGGER:
+        if (val != 0) {
+            s->training_trigger_seen = true;
+        } else if (s->training_trigger_seen) {
+            /* Abstract the loaded firmware run to its final mailbox message. */
+            s->training_trigger_seen = false;
+            s->training_complete = true;
+            s->mailbox_message_pending = true;
+        }
+        return;
+    default:
+        break;
+    }
+
+    if (FIELD_EX32(s->micro_cont_mux_sel,
+                   K230_DDR_PHY_MICRO_CONT_MUX_SEL,
+                   MICRO_CONT_MUX_SEL)) {
+        return;
+    }
+
+    switch (addr) {
+    case A_K230_DDR_PHY_DFI_INIT_COMPLETE:
+        s->dfi_init_complete =
+            val & R_K230_DDR_PHY_DFI_INIT_COMPLETE_DFI_INIT_COMPLETE_MASK;
+        return;
+    case A_K230_DDR_PHY_VREF_IN_GLOBAL:
+        s->vref_in_global = val & UINT16_C(0x7fff);
+        return;
+    default:
+        break;
+    }
+
+    if (k230_ddr_phy_decode_anib(addr, &anib)) {
+        s->atx_impedance[anib] = val & UINT16_C(0x03ff);
+        return;
+    }
+
+    if (k230_ddr_phy_decode_dbyte(addr, 0x049, &dbyte, &nibble)) {
+        s->tx_impedance_ctrl1[dbyte][nibble] = val & UINT16_C(0x0fff);
+        return;
+    }
+
+    if (k230_ddr_phy_decode_dbyte(addr, 0x04d, &dbyte, &nibble)) {
+        s->tx_odt_drv_stren[dbyte][nibble] = val & UINT16_C(0x0fff);
+        return;
+    }
+
+    qemu_log_mask(LOG_UNIMP,
+                  "%s: unimplemented DDR PHY write at offset 0x%"
+                  HWADDR_PRIx ", value 0x%" PRIx64 "\n",
+                  __func__, addr, value);
+}
+
+static const MemoryRegionOps k230_ddr_cfg_ops = {
+    .read = k230_ddr_cfg_read,
+    .write = k230_ddr_cfg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static const MemoryRegionOps k230_ddr_phy_ops = {
+    .read = k230_ddr_phy_read,
+    .write = k230_ddr_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void k230_ddr_cfg_init(Object *obj)
+{
+    K230DDRCfgState *s = K230_DDR_CFG(obj);
+
+    memory_region_init_io(&s->mmio, obj, &k230_ddr_cfg_ops, s,
+                          "k230-ddr-cfg", K230_DDRC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void k230_ddr_phy_init(Object *obj)
+{
+    K230DDRPhyState *s = K230_DDR_PHY(obj);
+
+    memory_region_init_io(&s->mmio, obj, &k230_ddr_phy_ops, s,
+                          "k230-ddr-phy", K230_DDR_PHY_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void k230_ddr_cfg_reset_enter(Object *obj, ResetType type)
+{
+    K230DDRCfgState *s = K230_DDR_CFG(obj);
+
+    s->initialized = false;
+    memcpy(s->regs, k230_ddrc_reset_values, sizeof(s->regs));
+}
+
+static void k230_ddr_phy_reset_enter(Object *obj, ResetType type)
+{
+    K230DDRPhyState *s = K230_DDR_PHY(obj);
+    unsigned int dbyte;
+    unsigned int nibble;
+    unsigned int anib;
+
+    memset(s->tx_odt_drv_stren, 0, sizeof(s->tx_odt_drv_stren));
+
+    for (anib = 0; anib < ARRAY_SIZE(s->atx_impedance); anib++) {
+        s->atx_impedance[anib] = K230_DDR_PHY_ATX_IMPEDANCE_RESET;
+    }
+
+    for (dbyte = 0; dbyte < ARRAY_SIZE(s->tx_impedance_ctrl1); dbyte++) {
+        for (nibble = 0;
+             nibble < ARRAY_SIZE(s->tx_impedance_ctrl1[dbyte]); nibble++) {
+            s->tx_impedance_ctrl1[dbyte][nibble] =
+                K230_DDR_PHY_TX_IMPEDANCE_CTRL1_RESET;
+        }
+    }
+
+    s->dfi_init_complete = 0;
+    s->vref_in_global = K230_DDR_PHY_VREF_IN_GLOBAL_RESET;
+    s->micro_cont_mux_sel = 0;
+    s->training_trigger_seen = false;
+    s->training_complete = false;
+    s->mailbox_message_pending = false;
+}
+
+static const VMStateDescription vmstate_k230_ddr_cfg = {
+    .name = "k230-ddr-cfg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, K230DDRCfgState, K230_DDRC_REG_COUNT),
+        VMSTATE_BOOL(initialized, K230DDRCfgState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const VMStateDescription vmstate_k230_ddr_phy = {
+    .name = "k230-ddr-phy",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16_ARRAY(atx_impedance, K230DDRPhyState,
+                             K230_DDR_PHY_ANIB_COUNT),
+        VMSTATE_UINT16_2DARRAY(tx_impedance_ctrl1, K230DDRPhyState,
+                               K230_DDR_PHY_DBYTE_COUNT,
+                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
+        VMSTATE_UINT16_2DARRAY(tx_odt_drv_stren, K230DDRPhyState,
+                               K230_DDR_PHY_DBYTE_COUNT,
+                               K230_DDR_PHY_NIBBLES_PER_DBYTE),
+        VMSTATE_UINT16(dfi_init_complete, K230DDRPhyState),
+        VMSTATE_UINT16(vref_in_global, K230DDRPhyState),
+        VMSTATE_UINT16(micro_cont_mux_sel, K230DDRPhyState),
+        VMSTATE_BOOL(training_trigger_seen, K230DDRPhyState),
+        VMSTATE_BOOL(training_complete, K230DDRPhyState),
+        VMSTATE_BOOL(mailbox_message_pending, K230DDRPhyState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void k230_ddr_cfg_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = k230_ddr_cfg_reset_enter;
+    dc->vmsd = &vmstate_k230_ddr_cfg;
+}
+
+static void k230_ddr_phy_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = k230_ddr_phy_reset_enter;
+    dc->vmsd = &vmstate_k230_ddr_phy;
+}
+
+static const TypeInfo k230_ddr_types[] = {
+    {
+        .name = TYPE_K230_DDR_CFG,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(K230DDRCfgState),
+        .instance_init = k230_ddr_cfg_init,
+        .class_init = k230_ddr_cfg_class_init,
+    },
+    {
+        .name = TYPE_K230_DDR_PHY,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(K230DDRPhyState),
+        .instance_init = k230_ddr_phy_init,
+        .class_init = k230_ddr_phy_class_init,
+    },
+};
+
+DEFINE_TYPES(k230_ddr_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 858ca845a2..cbeecbf1e0 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -29,6 +29,7 @@ system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 system_ss.add(when: 'CONFIG_VIRT_CTRL', if_true: files('virt_ctrl.c'))
 
 # RISC-V devices
+system_ss.add(when: 'CONFIG_K230', if_true: files('k230_ddr.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
 system_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
-- 
2.54.0


