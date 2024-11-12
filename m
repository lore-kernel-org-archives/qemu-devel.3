Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA49D42BBF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNZ-0007IK-Ot; Tue, 12 Nov 2024 13:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNS-0006zE-L1
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:36 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNR-00022w-7w
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:34 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37d808ae924so3716100f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435151; x=1732039951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/na/cFd3aGI4M5zTw4TKo5y0iNxB1Ymp8TI8i+fEV4=;
 b=mVAq81diIYIPsWNGD4GYQZVsLHBv29LZSXAZJYOz3Fs723pcHU1Mzw8pSGIZ2Bgp2v
 Zr4Q+LE9GkRNgVapqz3Q0hikuPEz7wxoltYnj9HiMOKB10NeIrZfAmzw+pqEAYXCmO7L
 OiB0qrKD3gCbsC3kuuRHLguIhRFoByio8pYbHmdHmIojHtOx0iD7fcf4U6TD8G38eLT1
 nLgj3rbOLiKXK6k1ESM1lY1wqj9hdLyyOBEaet8Tr/y5SqbVwwolCvawMkH4JNPvgnga
 uMYOSIMJqkiSINXZIWjuzds3tLUIFtKCfsxh6qS1SVeOIAZQuzA168px3Zg9nIgvL8AZ
 nrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435151; x=1732039951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u/na/cFd3aGI4M5zTw4TKo5y0iNxB1Ymp8TI8i+fEV4=;
 b=To04jvILIdxtti2hjb64QZbDdaDGMNXVsLTHj8YD7iSlUUV6EzwnJj/C8GJYdgcPKc
 dEideNLmK/xGxUUAh0y1x9tpK6R7h4kS3qzcbvvL0J9rf3BaCMPtTQoFfeqeKx6m8drL
 OPo19HAgSgcQwwQvV08VtKLRUa1K7457zeTVZzITAmHmH0ji+3JnMsNSg3UgtZxsEnVm
 +uLnBuVyxCIHIZRPCMt3mnenk8A7Nz/nTMi5JsTKC80h9HpLPRo/CbtdNJ+zqVZbbcHB
 3ZfXSjiLTxljpQ2ZQuxyriXv9d25yN76FkdqFb3Q9uHp/eXfzSveBM2L/Ipyg6QQ7X5b
 /Dsw==
X-Gm-Message-State: AOJu0YxWB+KCNsN1+3e/zKu0i3U9N46DiX7RkWoJokpG6zSqMZ/Hfuas
 p5n6RaKIj3SiwGJYn6frEqCW1dd1pnWjMefCoh7c2pAnN0duw80VhN+nY1xQ8D/PZiCLicktZZN
 B
X-Google-Smtp-Source: AGHT+IFSHtChdk7z1pSOZh0Fr7pHPMBzU0V4S2O75NrqFDCrY4iRQDDDZoigLKDeSRtAyQmAqaJGdQ==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21e9 with SMTP id
 ffacd0b85a97d-381f4432614mr9957024f8f.0.1731435151389; 
 Tue, 12 Nov 2024 10:12:31 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9ea3cbsm16209684f8f.74.2024.11.12.10.12.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/20] hw/net/xilinx_ethlite: Map TX_GIE as MMIO
Date: Tue, 12 Nov 2024 19:10:41 +0100
Message-ID: <20241112181044.92193-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Add TX_GIE to the TX registers MMIO region.

Before TX_GIE1 was accessed as RAM, with no effect.
Now it is accessed as MMIO, also without any effect.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 159b2b0c64..f7a5b1620a 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -39,7 +39,6 @@
 
 #define R_TX_BUF0     0
 #define A_TX_BASE0    0x07f4
-#define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
 #define A_TX_BASE1    0x0ff4
@@ -55,6 +54,7 @@
 
 enum {
     TX_LEN =  0,
+    TX_GIE =  1,
     TX_MAX
 };
 
@@ -140,6 +140,9 @@ static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
         case TX_LEN:
             r = s->port[port_index].reg.tx_len;
             break;
+        case TX_GIE:
+            r = s->port[port_index].reg.tx_gie;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -156,6 +159,9 @@ static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
         case TX_LEN:
             s->port[port_index].reg.tx_len = value;
             break;
+        case TX_GIE:
+            s->port[port_index].reg.tx_gie = value;
+            break;
         default:
             g_assert_not_reached();
     }
@@ -233,10 +239,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
     switch (addr)
     {
-        case R_TX_GIE0:
-            r = s->port[port_index].reg.tx_gie;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -281,11 +283,6 @@ eth_write(void *opaque, hwaddr addr,
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
2.45.2


