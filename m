Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB1E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6II-0000Kf-Ga; Sun, 12 Jan 2025 17:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6I6-0008Ty-Vv
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:43 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6I5-0006SB-60
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:42 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385dece873cso1777885f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720319; x=1737325119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7W7S4fRmwH0o3LlR3Rkb17HVQ8y9jsuH8Ex5UdLq6I=;
 b=wJ2NapqNXwMLxkYCfIYuLIJKlla8aGxvDDVCVO9nLQHJuuntk3YGHMhjxAp2XxVAUb
 o5IwYz614KZAEOY4ukRH5kTSJ8kbmu/XL9iVk9epvNMI6cEs5Z5RzA+/BnNmRmy2Aa4Y
 VUPDdBcQw+H5wylP8NPpTgwUlwB890GDWK/HZFkUdiNlqpiKC309eD9yLo26aWJTp6Xq
 Uj/2QE/4iplwSmfHC9CCLWqojbFlcBuWx5+w6hon/MqC1MoW5bg5VesQ8XooZlqQQ6VJ
 DJ/JX53xcVHIrbsDz2EZE5U+Jye0Qp8qTuGItR3xbs6rtrhZxCrz7RriRbW2/97/QOf2
 WqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720319; x=1737325119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7W7S4fRmwH0o3LlR3Rkb17HVQ8y9jsuH8Ex5UdLq6I=;
 b=Jzmo/2B6NlSkNFEH3hjr1/45PYt7pXzO03qgJmt0D+IQsQWhBUGLcfCJufYOlf/p8S
 tA1I8Xsf4/gX2/78IShkMJi0KdYAAV3I2H9kl8hu7AptdWOeoTCTzp/405t4nDWvb7lW
 X4jJZhuN6FEZ4pCGmwSepD6wJnbLFOlisshpdC359rf3fhxpsis+zJ1PwplPl2BR3qkL
 IdDr+xkA+Gk2RxGAfNjA0zKA3kC4B0pYdYADqxX6LJ7MT8O0L2KPY2sSVtT9RM7Ka9Oy
 OfiJEn8GrW8+rmF1BVrDaD0CqKG23z3Ui2wYjUB1X6jqENgmw4IanTgBPoi45jjuz97K
 nxng==
X-Gm-Message-State: AOJu0YxqFp4n8OKziK91RM2f4vFgojCFqGFPhA5ePA8X+Plg9l8mASom
 8JerAxReKrXmPN+5U1gBGz94oEy5zes3/beCEYR9ewyHMrwmkisfGZffT7KCBQnH5UECdo4oDpK
 UyuE=
X-Gm-Gg: ASbGncuTRrQpIS3ezuKbCCjf45z6/t8QnLb3YR3WXhVJ594KNw27SkLu5fwkz5w1kOm
 pxvb+do9tx58oMzdwGzHh9ozPhvq+k8xRDINmpOfzVL0SnkZQVsZU7yUe3he1106cQtdg88eU2Y
 1fO7FewaQeMmuD16ZLsd6foINmU+NpD0tMt98RccK9pYFAt4eBnaGxCPaV099yqUDNwjWU2PVyv
 WvZxlTAjMFS03FYN+EhpSoMAemMC7ytEzmmPy60BzJA3Xe0XvOxCPmRtuo9oMaBJ1ckMjkLCzwk
 TJVv1EitclGZxECjTIo3Y48NB5EhISU=
X-Google-Smtp-Source: AGHT+IHyW1PYx+ai9MT74ex8CP90xktnjIWGZU9HOs3wp8SGI0tDFIVkMYF/x9USHNN2FWUxLGSbpw==
X-Received: by 2002:a05:6000:1a85:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-38a872f6f22mr14729476f8f.7.1736720319021; 
 Sun, 12 Jan 2025 14:18:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd1682e4sm97919235e9.1.2025.01.12.14.18.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 14/49] hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
Date: Sun, 12 Jan 2025 23:16:50 +0100
Message-ID: <20250112221726.30206-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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

Declare RX registers as MMIO region, split it out
of the current mixed RAM/MMIO region.
The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241112181044.92193-16-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 82 +++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index f8b01fe9a62..9ac81ca1e06 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -49,11 +49,16 @@
 #define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
-#define R_RX_CTRL0    (0x17fc / 4)
+#define A_RX_BASE0     0x17fc
 #define R_RX_BUF1     (0x1800 / 4)
-#define R_RX_CTRL1    (0x1ffc / 4)
+#define A_RX_BASE1     0x1ffc
 #define R_MAX         (0x2000 / 4)
 
+enum {
+    RX_CTRL = 0,
+    RX_MAX
+};
+
 #define GIE_GIE    0x80000000
 
 #define CTRL_I     0x8
@@ -61,6 +66,8 @@
 #define CTRL_S     0x1
 
 typedef struct XlnxXpsEthLitePort {
+    MemoryRegion rxio;
+
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
@@ -118,6 +125,55 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+    case RX_CTRL:
+        r = s->port[port_index].reg.rx_ctrl;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static void port_rx_write(void *opaque, hwaddr addr, uint64_t value,
+                          unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+
+    switch (addr >> 2) {
+    case RX_CTRL:
+        if (!(value & CTRL_S)) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
+        }
+        s->port[port_index].reg.rx_ctrl = value;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps eth_portrx_ops = {
+        .read = port_rx_read,
+        .write = port_rx_write,
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
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -143,11 +199,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->port[port_index].reg.tx_ctrl;
             break;
 
-        case R_RX_CTRL1:
-        case R_RX_CTRL0:
-            r = s->port[port_index].reg.rx_ctrl;
-            break;
-
         default:
             r = tswap32(s->regs[addr]);
             break;
@@ -188,14 +239,6 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         /* Keep these native.  */
-        case R_RX_CTRL0:
-        case R_RX_CTRL1:
-            if (!(value & CTRL_S)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
-            s->port[port_index].reg.rx_ctrl = value;
-            break;
-
         case R_TX_LEN0:
         case R_TX_LEN1:
             s->port[port_index].reg.tx_len = value;
@@ -288,6 +331,15 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
+    for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
+                              &eth_portrx_ops, s,
+                              i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
+                              4 * RX_MAX);
+        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
+                                    &s->port[i].rxio);
+    }
+
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id,
-- 
2.47.1


