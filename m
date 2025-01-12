Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20DDE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6IM-0000X6-Bo; Sun, 12 Jan 2025 17:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6II-0000LW-DF
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:54 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IF-0006Sy-1J
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso25675245e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720329; x=1737325129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ/yRHFRw+pRRef+zyQSK+jFDarKIc/XCW+pBv+XSCs=;
 b=aUVBvZvaZy/pU7shbKIaZuZ/6Rg2NH+pd2ufL8sYJ7V0a7ov5hfcHUji1dXWvc3+dB
 cWOgU1MiL0Dx2aYznUpQeSGADsA5h9R4Vmvqbe2Q5fvgN8OdVLWiCbE+q3FzDjXU/2y9
 EJcdDBY4UZgHuWkAm1QnFRG/N43SR8QqR4qNijcP4tBJI8reZQU8BYnnqND8Dska9KWT
 OUqPOkKs+BN8mrtMc/U8XotBxvjEHYt8v9bq6vdTnllsuBpqD6STrrI16nSNvlOsexPv
 QYdeN8Unl5eAYcc0jxq7/lkFuhUksPuaQhsz3meC1Vop9xLdO7vIQVW9JdPUfWP9bzHF
 nzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720329; x=1737325129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQ/yRHFRw+pRRef+zyQSK+jFDarKIc/XCW+pBv+XSCs=;
 b=esiLCnI2atiNxMe2oguqXR6tlQ6+1KcgKeKSfcunDqZLGA4FX4B8Boa0ghZOuiT4oK
 N6rPyYc1QynePfyh2qWZC6WymfQU329TTfLvFLwOzT8s/5Y8FsPVFE0Y2FOXZC1KsB7I
 fJmGRpIpYs9In8WmUlS1QUsSnhNGBT3S0lmMhPLdtkJZLVH530Yc4MjIMBuLzRVi+/NX
 Sbpk0qD6AkwPRIWn4wgo74s97aFlxhq7uB2QdYqUIRk2lWdBBihkWvdeIkk9DNA1AU9b
 2DuetdSLm7fa49KkDsgAZpVy/rNBW+2v103tNgLvQbULQL2ylIKyrUJnkkPKmanCYkS1
 Aq4w==
X-Gm-Message-State: AOJu0YzB8l0bAJsHFFPqI5hc6msFtNx0ZOIinxG24uMC1NuduG8eDBvo
 tuRJ6HF863bk1ji9Hcr8MEQpDxfKZfdlRhhiZBgPqKQRbWgX/zt8NhnPyHOik7uAcx9qTULd3Nx
 WHF4=
X-Gm-Gg: ASbGncvJxU3u55vm8tDeApSsk15QyJw/BW3G+bqskb3IIPMpezku2gioTt6xGijNRq+
 8NmXWvg9Itw+hQrYXlaZi/XhPLcL+dd2IQ3+xn5EDI8FUu+g9wIlOSGD7MzyhqpR1zYjSZasjez
 gKeJZab1n40O7SpUw84r+KNnC4V7TCjjQECxazHgkHAtTt20uYiXQvhz0lbtLoetDiCTWBncees
 ZYpfQDpkxa6w/EZiA+ah6vYO908sEVV3Vmd13dLTPq3AoFGZbTCZj6SD51Y6iXhoAcPFJ5JftON
 kcgYxO9YJoT0Fz8qiwERNx/auPsua+Q=
X-Google-Smtp-Source: AGHT+IE9uw1bV2hNE5nVNSFkXjjuM8J9wxMt9MaBHcHssIuh8w8Xb4av5z6rh3Kt2PZF4hGgMVZDcQ==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-436e2699dfbmr185976455e9.14.1736720329124; 
 Sun, 12 Jan 2025 14:18:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66fcsm158823095e9.6.2025.01.12.14.18.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 16/49] hw/net/xilinx_ethlite: Map TX_GIE as MMIO
Date: Sun, 12 Jan 2025 23:16:52 +0100
Message-ID: <20250112221726.30206-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Add TX_GIE to the TX registers MMIO region.

Before TX_GIE1 was accessed as RAM, with no effect.
Now it is accessed as MMIO, also without any effect.

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007fb (prio 0, i/o): ethlite.tx[0]io
    00000000810007fc-0000000081000ff3 (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007fc
    0000000081000ff4-0000000081000ffb (prio 0, i/o): ethlite.tx[1]io
    0000000081000ffc-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000000ffc
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-18-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 5dac44fa688..898c09b3981 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -42,7 +42,6 @@
 #define BUFSZ_MAX      0x07e4
 #define A_MDIO_BASE    0x07e4
 #define A_TX_BASE0     0x07f4
-#define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1     0x0ff4
@@ -56,6 +55,7 @@
 
 enum {
     TX_LEN =  0,
+    TX_GIE =  1,
     TX_MAX
 };
 
@@ -141,6 +141,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
     case TX_LEN:
         r = s->port[port_index].reg.tx_len;
         break;
+    case TX_GIE:
+        r = s->port[port_index].reg.tx_gie;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -158,6 +161,9 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
     case TX_LEN:
         s->port[port_index].reg.tx_len = value;
         break;
+    case TX_GIE:
+        s->port[port_index].reg.tx_gie = value;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -237,10 +243,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
     switch (addr)
     {
-        case R_TX_GIE0:
-            r = s->port[port_index].reg.tx_gie;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -285,11 +287,6 @@ eth_write(void *opaque, hwaddr addr,
             s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
             break;
 
-        /* Keep these native.  */
-        case R_TX_GIE0:
-            s->port[port_index].reg.tx_gie = value;
-            break;
-
         default:
             s->regs[addr] = tswap32(value);
             break;
-- 
2.47.1


