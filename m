Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886D7C531FC
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmu-00025T-Pg; Fri, 24 Jul 2026 21:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTG-0006vi-Fv
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:30 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTE-0000nH-HX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:30 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-736eea06c3eso384505137.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940147; x=1785544947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EQn31arufhUjZ3pCn24I7+iIrepCZMV83TWFpTHNTGU=;
 b=PqXbtJfzDxT09VXf8diXNW93VpXTQ9JPdL6+h/SRaOEjfiVWvQ781F27VDD0VcLoaq
 OsWMo2qmecHitkygWiwewE2g/dwK/s9HkDGyZha0DagG36MRSwmJtMXEOumuGZO4mySd
 EFIsv/4boZU7H9YTnqepkyf6g41wlwsn405YCsyUx5+5nzalhkyVnRclcxGG0UJbTYIg
 L6Q5q9l5tPTUvsvyoL/NRhCdlKjML6DeDV6Ulnf27yvtzfG+xuDVoYFKWz///LCYvXUe
 IH1BKaWtMfU6RKF3wqdoREjLojRY4S5YcMC8bW05Xvug3TpnjvnPV/txkV8S4WYhweUK
 MSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940147; x=1785544947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EQn31arufhUjZ3pCn24I7+iIrepCZMV83TWFpTHNTGU=;
 b=HGPX2c428Uig+Ije06tk2jeWT5TAxDbO3qxbJaAViBa2/1d3myCq7OHqrO+4iwgZtT
 vBamPVvz2I72a5uxf7kpm3BBoXCkPh9HSeG0002Pmwiedl3JJcFSnoEKtnXlPcc9vnf3
 yXtZUwPjBhCXoV6Per1cFTxddQb667mwSuiiVMMLlfccU+sEzBtpSt+2moIHxYEI18+k
 pV1V+dM35ZFNsxj/4rcLKGWlTIeqADxXvHg7kyig/lPTOgxhdTsZqLA8g79wmUhsnssK
 QWTHmlRTek7zAydsZoeUwM9DdPWqDDYmC1ee9akcZZGKvIBfjd3+05P5B2zkuWVgAU0S
 0gSA==
X-Gm-Message-State: AOJu0YzE69OgPTlqEwnq0+Pp/5du48cy3RadFhMDRFhdhDBAiwzB3oaK
 C4VhNwdpPZiDaPdY0oq9uYJFiic1t89OdYfMn0KWDFL94YDCaeyuHhHAHREZgF2t
X-Gm-Gg: AR+sD13Q2cUoBA7bXuBFeZmm0ndSGFHE4wkhctR1mrGm6BM34IAJ5bTSmJt+uuAoK9T
 cFWnoHnDQMDFUh5bNHX6tS5b+MyYsFrZFfaI+CvY0z2LQrEUnmLgzRjfNQXqIlh5ObbwUjBDjXR
 c57GQbMT8TwPSKyXvD6OIyKZnyuRNe+Ah7d5+NHuXJhEQl2E/+0G1+FnuHM3RIerkkswpD0hYgc
 W9jb/ISJPWKXdS2Q9yDy5aglQgutf99ZZUp5vas0dYe6V0RuR3COVoeaR3rgklq97+EuAg0pDGk
 99AaJJYh1QN2Z0vTgo51Hix1ViNAACP4d8qpqIYtMnJndJlf+t6++tp4WSiHtIo27RwSTD5hwue
 8Ihyzgfn2q3hrSdd6bRm6cWb337PCwsu4mpt45kwHVqZaVmWU7RM0Ckr01sxPZBwsfHbLXwuvkP
 2wCDtpfGbzWCb+RX8oE4gGQxR1Ju60vJpgZC+/e3gL4vI=
X-Received: by 2002:a05:6102:4190:b0:631:28c1:154c with SMTP id
 ada2fe7eead31-7503e76ef85mr772118137.9.1784940147350; 
 Fri, 24 Jul 2026 17:42:27 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:26 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 05/19] hw/net/bcm2838_genet: add GENET register structs,
 part 1/4
Date: Fri, 24 Jul 2026 20:42:04 -0400
Message-ID: <20260725004219.66222-6-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe2c.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add the SYS, GR_BRIDGE, EXT, INTRL0, and INTRL1 register block
layouts and the top-level BCM2838GenetRegs/BCM2838GenetState
structs, plus REG32/FIELD accessors for the revision-control and
interrupt-status registers.

Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
networking series (patchwork series 829638, posted to qemu-devel in
2024, never merged). Carried forward and completed by Marcelo Manzo.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c         | 37 ++++++++++++++++
 include/hw/net/bcm2838_genet.h | 77 +++++++++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 2ff93a34..ff6602c1 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -15,10 +15,47 @@
 #include "hw/core/irq.h"
 #include "net/checksum.h"
 #include "system/dma.h"
+#include "hw/core/registerfields.h"
 #include "hw/core/resettable.h"
 #include "hw/net/bcm2838_genet.h"
 #include "trace.h"
 
+REG32(GENET_SYS_REV_CTRL,              0)
+FIELD(GENET_SYS_REV_CTRL, GPHY_REV,    0, 16)
+FIELD(GENET_SYS_REV_CTRL, MINOR_REV,   16, 4)
+FIELD(GENET_SYS_REV_CTRL, RSVD_20_23,  20, 4)
+FIELD(GENET_SYS_REV_CTRL, MAJOR_REV,   24, 4)
+FIELD(GENET_SYS_REV_CTRL, RSVD_28_31,  28, 4)
+
+REG32(GENET_INTRL_0,                0)
+FIELD(GENET_INTRL_0, SCB,           0, 1)
+FIELD(GENET_INTRL_0, EPHY,          1, 1)
+FIELD(GENET_INTRL_0, PHY_DET_R,     2, 1)
+FIELD(GENET_INTRL_0, PHY_DET_F,     3, 1)
+FIELD(GENET_INTRL_0, LINK_UP,       4, 1)
+FIELD(GENET_INTRL_0, LINK_DOWN,     5, 1)
+FIELD(GENET_INTRL_0, UMAC,          6, 1)
+FIELD(GENET_INTRL_0, UMAC_TSV,      7, 1)
+FIELD(GENET_INTRL_0, TBUF_UNDERRUN, 8, 1)
+FIELD(GENET_INTRL_0, RBUF_OVERFLOW, 9, 1)
+FIELD(GENET_INTRL_0, HFB_SM,        10, 1)
+FIELD(GENET_INTRL_0, HFB_MM,        11, 1)
+FIELD(GENET_INTRL_0, MPD_R,         12, 1)
+FIELD(GENET_INTRL_0, RXDMA_MBDONE,  13, 1)
+FIELD(GENET_INTRL_0, RXDMA_PDONE,   14, 1)
+FIELD(GENET_INTRL_0, RXDMA_BDONE,   15, 1)
+FIELD(GENET_INTRL_0, TXDMA_MBDONE,  16, 1)
+FIELD(GENET_INTRL_0, TXDMA_PDONE,   17, 1)
+FIELD(GENET_INTRL_0, TXDMA_BDONE,   18, 1)
+FIELD(GENET_INTRL_0, RSVD_19_22,    19, 4)
+FIELD(GENET_INTRL_0, MDIO_DONE,     23, 1)
+FIELD(GENET_INTRL_0, MDIO_ERROR,    24, 1)
+FIELD(GENET_INTRL_0, RSVD_25_31,    25, 4)
+
+REG32(GENET_INTRL_1,              0)
+FIELD(GENET_INTRL_1, TX_INTRS,    0, 16)
+FIELD(GENET_INTRL_1, RX_INTRS,    16, 16)
+
 
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 91cf1773..af5e8abd 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -19,7 +19,82 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MINOR         0
 
 typedef struct {
-    uint8_t stub_area[0x10000]; /* temporary stub */
+    uint32_t rev_ctrl;
+    uint32_t port_ctrl;
+    uint32_t rbuf_flush_ctrl;
+    uint32_t tbuf_flush_ctrl;
+    uint32_t reserved_0x10[12];
+} BCM2838GenetRegsSys;
+
+typedef struct {
+    uint32_t reserved_0x0[16];
+} BCM2838GenetRegsGrBridge;
+
+typedef struct {
+    uint32_t pwr_mgmt;
+    uint32_t reserved_0x4[2];
+    uint32_t rgmii_oob_ctrl;
+    uint32_t reserved_0x10[3];
+    uint32_t gphy_ctrl;
+    uint32_t reserved_0x20[24];
+} BCM2838GenetRegsExt;
+
+typedef struct {
+    uint32_t stat;
+    uint32_t set;
+    uint32_t clear;
+    uint32_t mask_status;
+    uint32_t mask_set;
+    uint32_t mask_clear;
+    uint32_t reserved_0x18[10];
+} BCM2838GenetRegsIntrl0;
+
+typedef struct {
+    uint32_t stat;
+    uint32_t set;
+    uint32_t clear;
+    uint32_t mask_status;
+    uint32_t mask_set;
+    uint32_t mask_clear;
+    uint32_t reserved_0x18[10];
+} BCM2838GenetRegsIntrl1;
+
+typedef struct {
+    uint32_t ctrl;
+    uint32_t reserved_0x4[2];
+    uint32_t status;
+    uint32_t reserved_0x10;
+    uint32_t chk_ctrl;
+    uint32_t reserved_0x18[31];
+    uint32_t ovfl_cnt;
+    uint32_t err_cnt;
+    uint32_t energy_ctrl;
+    uint32_t reserved_0xA0[5];
+    uint32_t size_ctrl;
+    uint32_t reserved_0xB8[18];
+} BCM2838GenetRegsRbuf;
+
+typedef struct {
+    uint32_t ctrl;
+    uint32_t reserved_0x4[2];
+    uint32_t bp_mc;
+    uint32_t reserved_0x10;
+    uint32_t energy_ctrl;
+    uint32_t reserved_0x18[58];
+} BCM2838GenetRegsTbuf;
+
+typedef struct {
+    BCM2838GenetRegsSys sys;
+    BCM2838GenetRegsGrBridge gr_bridge;
+    BCM2838GenetRegsExt ext;
+    uint32_t reserved_0x100[64];
+    BCM2838GenetRegsIntrl0 intrl0;
+    BCM2838GenetRegsIntrl1 intrl1;
+    uint32_t reserved_0x280[32];
+    BCM2838GenetRegsRbuf rbuf;
+    uint32_t reserved_0x400[128];
+    BCM2838GenetRegsTbuf tbuf;
+    uint32_t reserved_0x700[64];
 } BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.47.1


