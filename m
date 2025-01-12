Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADFEE7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6IK-0000TU-05; Sun, 12 Jan 2025 17:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IC-0008Uc-4v
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:51 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IA-0006SY-Cv
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:47 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so42821545e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720324; x=1737325124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A5/QTsgFaeb0rXegtfTvFnFX4bMeOUBeCuDa9RC3KRI=;
 b=wcaXHS11r02PTU4Vf/83fCYAEe4BhNa6bHGrhLzovv9y6Dg+bMmlJfEKIIUVGdtMFU
 dH8N7PBLG+Z3is3MAyGOvRGuY7t8lREYnwVBcv45zvS33l4jBcUS3DRh1wsR+lAdUEg2
 YHUu+Acm3yieTjn4b/oP/yS9SU6v6/jKT1PX0Kkf1ssDYmo0tYMKH6TwgaX3sKKu+kUI
 7KXVfDsI0axA5wGG7Hc6WP0riTkg+DSyjgONa8lbb9nOFVNY89sFbG7CkAiPfdVMBrFc
 Uv8DyjKazytsnNl77qWFIZB8Jw6hCbJb0rvGNh7KDhLXnOu6jXycv1EcHiadudUfVr+C
 f/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720324; x=1737325124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5/QTsgFaeb0rXegtfTvFnFX4bMeOUBeCuDa9RC3KRI=;
 b=ITQaHATnHjBbwA+eaTYuUlyUwk2ZwyhplgQp3xeQ2erqYsX5CfIC16Ama/3yfRvpVU
 /lq3h19pYE4Wgqs2NH6KRqKTD/OUi79j967P2te1GqgKIoRTNQ317yiDP8h08jvjwQDn
 +f46xE5pzgMNltSHdUFVLMdv4dlnexN8k6NVt/u/iJXqaOSpkIMMFttFRLq2vRCIcXBy
 ksjpFuVkGJ0u57MKrZt4Bo50idiqrbqC7dfpXFUOAfLIsHi36NcVxi15Q8oaRPL5TPYM
 A3PKIJt5asncc3SFY4IdKJyA7meswHganHOpmIS/GKgAFNaoCJDwqk2BnMriu8DGmBsF
 kZAQ==
X-Gm-Message-State: AOJu0YzbJBTGLL4qgGO4lYzD8vPw/mzlTfulcnkzMUuvku+jJr1fovdO
 j5lgDNUeZOHyJKE9/QKKe0OYMD3TXvU/nGAxESZEN7MM/DlUsuNy8z+0Y2rjmVkPxYFB5ouHl2+
 9OSU=
X-Gm-Gg: ASbGncueYyYJEWp2bpPidp4jNxMv/AsqqY0wh+i5gi2m1e2wBYE3Q569siOVd8JgZDN
 ebj+NzxYdSEshg+kqwPiZH91WxY3KgvvQLAai29by2bkoOq/nYvrmpaCUmcxx3RT32O6N5AL9xD
 GMwy1gURYwbXVZOeejVgWrv2EshqtyIhG+V2zUmu+b9XK4L5ilVugQitYeSGQWLZ8gfh4e0ImWR
 Tt7+Eg/AKBN97EdGUqmGDoIehAXlr7kjVuaZCvPzXTSux3B56xCIB3cLc9etyADUScR5HnxKrBB
 yGu1xpIAU81dyvyhp6PSNG721szFWFY=
X-Google-Smtp-Source: AGHT+IEn6n7BHMpPFQRfQBV7YiZtk0FY25+wKzh8XgqeeyrG443T85udAvd9v+1ufBbvfDG8OQN7LA==
X-Received: by 2002:a05:600c:511f:b0:436:1b96:7072 with SMTP id
 5b1f17b1804b1-436e26867f6mr185333775e9.5.1736720324251; 
 Sun, 12 Jan 2025 14:18:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f8bsm122319065e9.23.2025.01.12.14.18.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 15/49] hw/net/xilinx_ethlite: Map TX_LEN as MMIO
Date: Sun, 12 Jan 2025 23:16:51 +0100
Message-ID: <20250112221726.30206-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Declare TX registers as MMIO region, split it out
of the current mixed RAM/MMIO region.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007f7 (prio 0, i/o): ethlite.tx[0]io
    00000000810007f8-0000000081000ff3 (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f8
    0000000081000ff4-0000000081000ff7 (prio 0, i/o): ethlite.tx[1]io
    0000000081000ff8-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000000ff8
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-17-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 73 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 9ac81ca1e06..5dac44fa688 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -41,11 +41,11 @@
 #define R_TX_BUF0     0
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
-#define R_TX_LEN0     (0x07f4 / 4)
+#define A_TX_BASE0     0x07f4
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
-#define R_TX_LEN1     (0x0ff4 / 4)
+#define A_TX_BASE1     0x0ff4
 #define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
@@ -54,6 +54,11 @@
 #define A_RX_BASE1     0x1ffc
 #define R_MAX         (0x2000 / 4)
 
+enum {
+    TX_LEN =  0,
+    TX_MAX
+};
+
 enum {
     RX_CTRL = 0,
     RX_MAX
@@ -66,6 +71,7 @@ enum {
 #define CTRL_S     0x1
 
 typedef struct XlnxXpsEthLitePort {
+    MemoryRegion txio;
     MemoryRegion rxio;
 
     struct {
@@ -125,6 +131,52 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+    case TX_LEN:
+        r = s->port[port_index].reg.tx_len;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
+                          unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+
+    switch (addr >> 2) {
+    case TX_LEN:
+        s->port[port_index].reg.tx_len = value;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps eth_porttx_ops = {
+        .read = port_tx_read,
+        .write = port_tx_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+};
+
 static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
@@ -189,11 +241,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->port[port_index].reg.tx_gie;
             break;
 
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            r = s->port[port_index].reg.tx_len;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -239,11 +286,6 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         /* Keep these native.  */
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            s->port[port_index].reg.tx_len = value;
-            break;
-
         case R_TX_GIE0:
             s->port[port_index].reg.tx_gie = value;
             break;
@@ -332,6 +374,13 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_io(&s->port[i].txio, OBJECT(dev),
+                              &eth_porttx_ops, s,
+                              i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
+                              4 * TX_MAX);
+        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
+                                    &s->port[i].txio);
+
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
-- 
2.47.1


