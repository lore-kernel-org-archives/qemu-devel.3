Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F0E7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6IY-0000qL-PI; Sun, 12 Jan 2025 17:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IO-0000fX-NH
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IK-0006Ty-7R
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:59 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso36065515e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720334; x=1737325134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SFoahiPSgH64KUxCBuOvqcnFDOzpDhwSVqu05ihWUQw=;
 b=cm1+Z/RDJdSQdCAxa8iZDvgsuMkA8PSC9bs+O78ftPn3c4NlYFF0Wzpu2A7Yzsp2bZ
 Lt6LXzT+bj28dJWO/gydvCViFkKYdybwZynFIxo8Gc0njKz+JvDmKrMPxoLaVVpnlK/5
 xa9mHVUwTlvBvRST+w7sSUfdH5Q/mZsjFkP68VN3pYwZhP+uZMQczpmjMvewcLjHtwC1
 UD9mhpFFjy/Qa0bqCsTkuxWGZR+JqB01DeiXINDok47ycTaXzEcqlwnsTrdb+TQxH1rC
 pwOMlwLlwQEn6JXh/xkiikkjrdGIa4jOlvVqYjbOLaGZmPMUJsBy+8QjTZbPJV1ErN8U
 f3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720334; x=1737325134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SFoahiPSgH64KUxCBuOvqcnFDOzpDhwSVqu05ihWUQw=;
 b=s1oDwhwXaVyD7zPAAImkkyCTHOr/7/Zb6qSzf0D71MEaafsAuZMsmpA6CH9dTYOrYF
 ZAvlzJDwNcwLwulFBfkPSQ4JawnI0CmRd9y38mSJsSVV2QepdKyqHTthc/x/nF9m21/b
 O6I5gan66Wk0WUy0PiX1JRpZ2Iy6cW2zGmueS5vmkSMjPk4BJwHzHQYDkJb2my8gSKY6
 e3GQQFDHxg8dxg7HOhwwP3v1R1mqPRvvoQsQJI48vIk1OB6jxiYz/jnjMaajbFcbz7Av
 5FzdSn21m8Ufi+iCdFMJJfNiNkxvOOQXPM6p06PtlXUMnbGaEq2fqu2pTE2rDwrHOSCy
 I6BQ==
X-Gm-Message-State: AOJu0Yw0Ohjp9ya2E2GgEPmyKsWkXHQFCtUNZXImJvy9S+opU/AaH0Ux
 wDzFAbJ1rSdHbyveJaJ1Np5enYxUouVI172VVmHQvJ89KhzvWa5mKWQu/5CuHstBgMXXrAAVhV6
 oPcg=
X-Gm-Gg: ASbGncuuY/U8ZFvKtB1BUbwwuCRUNy6+2GKb5NcWmC+xz8gjCyL0ZUoi8uiWaD3/LrL
 Os71vyqP2Qq+y2/rQNvXAPyvIvKxABHEdkC4PyfESrpLqcB9PXr38fyS5ImRiMPw2AZCW7s8n5n
 7+jBFnf8SpZuj6tYO1MRQCSPKfQeJQR5mEMHzdQrnLYkGYvi4QrQccIGY9zFVf1hi/G2mJAhPfQ
 zbS00qiQ00O2QFGbsBJI0cPSlBibodlmNT/Jt6un2/4qldle1IGzgMM60lrg+tjIkXNE/G5IlpH
 aDKqSWF+c3AlFP5byMbFI96g/tE2qbM=
X-Google-Smtp-Source: AGHT+IF6TIbdUK7lxTRbkwRSQineo3vAt0dP+zAIwijC8UcCADfRmk6XZnTVDzoYGq1a080w258dVA==
X-Received: by 2002:a05:600c:4745:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-436e26c4218mr180634545e9.11.1736720334426; 
 Sun, 12 Jan 2025 14:18:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc08bbsm156785245e9.12.2025.01.12.14.18.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 17/49] hw/net/xilinx_ethlite: Map TX_CTRL as MMIO
Date: Sun, 12 Jan 2025 23:16:53 +0100
Message-ID: <20250112221726.30206-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-Id: <20241112181044.92193-19-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 54 ++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 898c09b3981..5ab8ae43b2b 100644
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
 
@@ -144,6 +143,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
     case TX_GIE:
         r = s->port[port_index].reg.tx_gie;
         break;
+    case TX_CTRL:
+        r = s->port[port_index].reg.tx_ctrl;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -164,6 +166,26 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
     case TX_GIE:
         s->port[port_index].reg.tx_gie = value;
         break;
+    case TX_CTRL:
+        if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
+            qemu_send_packet(qemu_get_queue(s->nic),
+                             txbuf_ptr(s, port_index),
+                             s->port[port_index].reg.tx_len);
+            if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                eth_pulse_irq(s);
+            }
+        } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
+            memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
+            if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
+                eth_pulse_irq(s);
+            }
+        }
+        /*
+         * We are fast and get ready pretty much immediately
+         * so we actually never flip the S nor P bits to one.
+         */
+        s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -236,18 +258,12 @@ static uint64_t
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
@@ -260,33 +276,11 @@ eth_write(void *opaque, hwaddr addr,
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
2.47.1


