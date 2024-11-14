Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92323D6A230
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyc-0002PG-7I; Thu, 14 Nov 2024 16:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyX-0002A9-1B
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:01 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyU-000888-Oz
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:00 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d4fd00574so649567f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618115; x=1732222915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMLXteKzNxHurRj29HFY+TepUdXjvjn4u+eJ/Foyx5Y=;
 b=QXR8PiYRp/nNe2kza3DZTzPsMSADTAzU5bqFSK3aZZFKmCPQ7sd4ucNt96VS+HkZuI
 KhDgueRTCFK5cFAUUG8PNaVfcYRJhh94bNW2f8pbAFkYMlkLhicWQj/6DzsjaBqI2QpH
 kGIJ/yEsWXgBui0cUVnMIj84SKFMu9P75XVwW30MnEn7z/97UvgQxB/hNLQZUmxt+8rr
 0vMY/N2AMeQwoImM1s28G/q4A92bQo6WfxPmlRs7sm/u68r2lRzOLgjCFdLZcpCtx2Vu
 7Z80rwsmt+C4DJx4OZz6/MobKKFlIXiHl/WfMz0SVv9YHcRNC8RLF5O3Lr42hcWivyz9
 x3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618115; x=1732222915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMLXteKzNxHurRj29HFY+TepUdXjvjn4u+eJ/Foyx5Y=;
 b=pjMYLxAx5p8S/d/X8J5JDzAQLbkFqvW7OsnvjRhxiikehKoKZvF/Z1puRDHN31Xac/
 8fQJO1uDARz1hE/+sIZk7+06rHyI/C+Kxje+PBA9/VoVaAYYPz5bg2te7Qay9eqxPZ3y
 G2Suqr1Q5neNPtKKojGpiJD/VQiyt/x+n2BxuDA898waj1W6KWzpV1Y8wVim6ymrOYfO
 L2PpctJBXlut4N6/kC9Say7BmDmZn87dZ5pCro0uMlonq71FfTLc4ZUGS2m+E61Ihtk9
 WG/ZQ2qmAooM2qPGd1exBa74EnKKSPfzQZaitwgkyjtXmXZ196s3JwSh+1kt5XKCCYHK
 /vLA==
X-Gm-Message-State: AOJu0YzePl4MwJbUSzTk1zCkI878vCwWpMrwSxICJiEHBAlUQM0OZM0s
 bMfvUXoyApI9AFV9OLLzZgRr3VZqwmvnPtvqcll/OjkG8WvamVawN8X4EYKSMtD/wxg2wYmXtfn
 D
X-Google-Smtp-Source: AGHT+IHoLPkYj3ixkchBmqbX+P8UnWlwrC9BxjR0Wmo7HouXQoUd7C+0hBboIwyUTOthH8jNuhi03w==
X-Received: by 2002:a5d:5c0f:0:b0:37c:ffdd:6d5a with SMTP id
 ffacd0b85a97d-38224e54560mr447248f8f.6.1731618115295; 
 Thu, 14 Nov 2024 13:01:55 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821d0ea3e2sm2085593f8f.109.2024.11.14.13.01.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 13/19] hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
Date: Thu, 14 Nov 2024 22:00:04 +0100
Message-ID: <20241114210010.34502-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/net/xilinx_ethlite.c | 82 +++++++++++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 15 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 674f805d76..d8f5a06182 100644
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
@@ -62,6 +67,8 @@
 
 typedef struct XlnxXpsEthLitePort
 {
+    MemoryRegion rxio;
+
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
@@ -119,6 +126,55 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+        case RX_CTRL:
+            r = s->port[port_index].reg.rx_ctrl;
+            break;
+        default:
+            g_assert_not_reached();
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
+        case RX_CTRL:
+            if (!(value & CTRL_S)) {
+                qemu_flush_queued_packets(qemu_get_queue(s->nic));
+            }
+            s->port[port_index].reg.rx_ctrl = value;
+            break;
+        default:
+            g_assert_not_reached();
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
@@ -144,11 +200,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
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
@@ -189,14 +240,6 @@ eth_write(void *opaque, hwaddr addr,
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
@@ -289,6 +332,15 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
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
2.45.2


