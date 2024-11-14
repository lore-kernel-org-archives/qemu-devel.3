Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E04D6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgz5-0003no-4l; Thu, 14 Nov 2024 16:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyu-0003b2-MW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:26 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgys-0008Au-J8
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:02:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso12256265e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618139; x=1732222939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrNmzpyBj8jJaMk8J310GpURg0YUYlZP1LiDoI08wTo=;
 b=v3XrjUf9km15ZkJA25dcnxJExd5GFZKSBsWoc7BXyWHJpzi6EGmmvao5VqP3Rw0Tem
 iLhzGsQhDbMxj+QthcUnq9zoX3zfnREHcobwZKTixDYkP4hiat9p57/R9W5/JNv0dvEk
 dn/KQNZczglLSSjjbKYu9Aq8+tozus78707dpl9zyfQhJ3IpEWaVJxg8m0Y/kVUXJ8Fp
 Omq8FSufTqTlSjt1VYZw/KrIaaIwHBMGf/RMRiTBX5Li1YyiP8fCHZl4qc6bHvMsUa/r
 5TkBKRBUwgR17JdF4KEPeUL7xcWWeDmWZ46g5KtbRlRi2VG250Rf+IXZYWnhi/NZycUB
 ZfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618139; x=1732222939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YrNmzpyBj8jJaMk8J310GpURg0YUYlZP1LiDoI08wTo=;
 b=w8bAuSCmMULb9an+DliZOKIDwecMP/4Kitpd57jLBax92p5Ga3cRszfp5lThTrpxBH
 sqUxDbEco7RAcCNjPWkLcuoUYmxYd+rZKevYqU/zaTiqpZ5JgPDne/MguFKH5Nk90Kk0
 DcCM66JRq0E2VZVev7npLEB3Qqubf74g60W/S3i8ZyjU4hRiNS9Q6uVIgfiykOI1NOa4
 pA7PJX2MPkdwB0eyfBEgKddtBVBk3KLjZU5NtdlPEmibA9yJ63MXMybJVqzE3ZeT0IrX
 VS5XHjcMjynCHDuzXXl0SI/rT+d/mL8mnH3b4oC/VXcglJ1Obh2afYbkdg7CE7ZSCP5X
 pD+g==
X-Gm-Message-State: AOJu0Yx+KxTBgjQ+AT33swjil2HPrTJpoytUTPzZAFcWYquK+ZGVivoW
 FMwVhiFq3nEo1IdAfwH0BEf5HhKlfxiA/SqJJb0A+0RYxGWjmtOICmGN7PVZLQjj0Jd8IXcvB4O
 c
X-Google-Smtp-Source: AGHT+IHRQz8qs7Y0SOPp8IwCL/CgRi75UUXbkhNzsDZQN5+rcVhSmJwCo03YPc1VzNxAJJCg8qYJPQ==
X-Received: by 2002:a05:600c:1ca9:b0:431:557e:b40c with SMTP id
 5b1f17b1804b1-432df7937bcmr1608075e9.27.1731618139303; 
 Thu, 14 Nov 2024 13:02:19 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3f91sm2493726f8f.4.2024.11.14.13.02.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:02:17 -0800 (PST)
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
Subject: [PATCH RESEND v2 16/19] hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
Date: Thu, 14 Nov 2024 22:00:07 +0100
Message-ID: <20241114210010.34502-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Add TX_CTRL to the TX registers MMIO region.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
    0000000081000800-0000000081000ff3 (prio 0, i/o): xlnx.xps-ethernetlite @0000000000000800
    0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
    0000000081001000-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001000
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 54 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 038e81dcae..c710857cfd 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -42,10 +42,8 @@
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
 #define A_TX_BASE0     0x07f4
-#define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1     0x0ff4
-#define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
 #define A_RX_BASE0     0x17fc
@@ -56,6 +54,7 @@
 enum {
     TX_LEN =  0,
     TX_GIE =  1,
+    TX_CTRL = 2,
     TX_MAX
 };
 
@@ -145,6 +144,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
         case TX_GIE:
             r = s->port[port_index].reg.tx_gie;
             break;
+        case TX_CTRL:
+            r = s->port[port_index].reg.tx_ctrl;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -165,6 +167,26 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         case TX_GIE:
             s->port[port_index].reg.tx_gie = value;
             break;
+        case TX_CTRL:
+            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
+                qemu_send_packet(qemu_get_queue(s->nic),
+                                 txbuf_ptr(s, port_index),
+                                 s->port[port_index].reg.tx_len);
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                    eth_pulse_irq(s);
+                }
+            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
+                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                    eth_pulse_irq(s);
+                }
+            }
+            /*
+             * We are fast and get ready pretty much immediately
+             * so we actually never flip the S nor P bits to one.
+             */
+            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
+            break;
         default:
             g_assert_not_reached();
     }
@@ -237,18 +259,12 @@ static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
-    unsigned port_index = addr_to_port_index(addr);
     uint32_t r = 0;
 
     addr >>= 2;
 
     switch (addr)
     {
-        case R_TX_CTRL1:
-        case R_TX_CTRL0:
-            r = s->port[port_index].reg.tx_ctrl;
-            break;
-
         default:
             r = tswap32(s->regs[addr]);
             break;
@@ -261,33 +277,11 @@ eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
-    unsigned int port_index = addr_to_port_index(addr);
     uint32_t value = val64;
 
     addr >>= 2;
     switch (addr) 
     {
-        case R_TX_CTRL0:
-        case R_TX_CTRL1:
-            if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
-                qemu_send_packet(qemu_get_queue(s->nic),
-                                 txbuf_ptr(s, port_index),
-                                 s->port[port_index].reg.tx_len);
-                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
-                    eth_pulse_irq(s);
-                }
-            } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
-                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
-                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
-                    eth_pulse_irq(s);
-                }
-            }
-
-            /* We are fast and get ready pretty much immediately so
-               we actually never flip the S nor P bits to one.  */
-            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
-            break;
-
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.45.2


