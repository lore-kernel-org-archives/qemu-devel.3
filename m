Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397D9E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6I1-00081Q-Lw; Sun, 12 Jan 2025 17:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hx-0007w7-JH
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:33 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hw-0006Rh-3v
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso1948846f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720310; x=1737325110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Bp5G8urywZcUZ8mpuup1anSVqL83TQbEqLWjAWe4bw=;
 b=qw7ghaXu9+NLWQnDA1s1+6oVv2S7ofC80BYaT6pMvxjcUKSffJFjTV7JGM7OMz1ZyO
 LXOsRoJzgsxqfYtwqk+QLkpP993bLHp2S/1vV293GNXaMQY5TkVCcRXjzldDPW7h1Y6x
 Xh/XydVPJ0PCLqmAMor+SHDkBx69T1UoDpIVppM6HRmmVfcH1ZU7GsSFUUdK0KmLER1k
 Ga93hUF4VAXHb87ekHjvOc1iXP1sEPeQtXEpXpLVBN1vAXL2U/JRX4pwba3BaA4Kr5/D
 9qnlcUns6jg9430G6ORQQWkj2mz8p5BTAiuklG9lR/j+niHfOl1wRmxg3284Qgpic517
 L+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720310; x=1737325110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Bp5G8urywZcUZ8mpuup1anSVqL83TQbEqLWjAWe4bw=;
 b=ad8owRIlu/O4wlZG8Kz+OqaSF7na8zEUmzlgbV+2VuZxQWmZnIhZust7frSp0MwUPz
 3eKP+DMKwBrcFLQRdqavj70+o7Nnflf6dY1y0uE0mtQL0pPuCnq5Uyicxn/AEgvutx2D
 fhia04LiN55XHj2Y6lCeWGO0c5m7xJiWYOqEVIzQTn2qEwAoH/b3kd57ZJH6EbNyyKR8
 s9JnJ8daP675BlUO2vTlolFxxGF/aZbtDzJABSumqJTuhkyaz3HFqxfKAoW+T9aRh7rq
 76EPU8DY9Khm2h50CytbtxsfIkCkS9/TxuIhvliWowfPGj2HOxMkeXNLa++mxelAxF7u
 +0gQ==
X-Gm-Message-State: AOJu0YyF81YDl8mmysbK3aKwV8s8GXUQfuh5zXFn3CICcTbNRal8OW1H
 OVhWxT/j42QyahmJj0Rrv5bUJpwAvTxhXwaRVsYwMyowPwpteaOwBL9Eo2Mti69+dsnmqZWPQNg
 nJE8=
X-Gm-Gg: ASbGnctNw7ZKUBuIHX+SMmzTmHRGVtZIaHdgwT1xYQ78TdanmIBWy6LT9GIlYduNkEI
 7ccvqwRdTvXf7wLOeyl+SdBoaQW63dUlY4ednT8nsERcIea0583qia2XtvH5qKPLjGKdZ19kRP7
 0w43RM8mBKBzeQg98ZerTl2SQvvt1qxnJsWwjsPk0giQS8fTdZTulo/U+JPcVz7Rfqi4zE1iynD
 lLKuXYMwH8pl/2afjp/FkhCvZ5O/hmxTiOvKu/uGhagEt1gP3M1s+xRhZPu6V54ojgfQvi+Yt6p
 TntMibiF4R65u8CwQy8KBv1zwapM5QQ=
X-Google-Smtp-Source: AGHT+IGJkclleepvreufuPp8vOTdG6Olgod30XGrsr521xnDdZrn7mGr4KWPU9Byt8lCMl8XIIZ7YA==
X-Received: by 2002:a5d:584d:0:b0:386:4a16:dad7 with SMTP id
 ffacd0b85a97d-38a872d2a33mr17436794f8f.10.1736720309997; 
 Sun, 12 Jan 2025 14:18:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383654sm10762987f8f.30.2025.01.12.14.18.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 12/49] hw/net/xilinx_ethlite: Access TX_LEN register for each
 port
Date: Sun, 12 Jan 2025 23:16:48 +0100
Message-ID: <20250112221726.30206-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_LEN. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_LEN0] and s->regs[R_TX_LEN1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-14-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 3252c9d508a..ce9555bd1e2 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -62,6 +62,7 @@
 
 typedef struct XlnxXpsEthLitePort {
     struct {
+        uint32_t tx_len;
         uint32_t tx_gie;
 
         uint32_t rx_ctrl;
@@ -133,6 +134,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
         case R_TX_LEN0:
         case R_TX_LEN1:
+            r = s->port[port_index].reg.tx_len;
+            break;
+
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->regs[addr];
@@ -170,7 +174,7 @@ eth_write(void *opaque, hwaddr addr,
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  txbuf_ptr(s, port_index),
-                                 s->regs[base + R_TX_LEN0]);
+                                 s->port[port_index].reg.tx_len);
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
@@ -195,7 +199,7 @@ eth_write(void *opaque, hwaddr addr,
 
         case R_TX_LEN0:
         case R_TX_LEN1:
-            s->regs[addr] = value;
+            s->port[port_index].reg.tx_len = value;
             break;
 
         case R_TX_GIE0:
-- 
2.47.1


