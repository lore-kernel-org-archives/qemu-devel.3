Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8956FE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimK-0003zB-VT; Tue, 31 Dec 2024 15:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimJ-0003nU-5s
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:47 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimH-0000tv-AN
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso3056299f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676622; x=1736281422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvYdTYMW+dIfPF+uKcm/HE6zS5JfQaQKVI9r227X6ME=;
 b=YKPz9dAzPV5iJAf7q80r9sh9FkGmrA5vm5yviKyHbojPyaayRqTDsSWigj9z/mliYG
 ePgfUFbDMQnMLk5pYhF00JmHG5Gs4+OAQHDFGoupZ64w1kAlhNfwZinGweQ0+voGr4FM
 S/xKcir8pckAIRINEJfVauhISbD0XaGaTorRI+4jYOS83F8/+t03hjVb5Rd8FlJnHwSl
 wffIgndi4bbRLaBR1i7pLvveVkaaaC0OhRAfcCRuyTXiKNLwTJrIg0cqn+A5QdBv1S+h
 +KA8o9bNvJpIIBvtak/rTK11eCdiBcXlBlsGKywVo/1cS0Yu2YEiMIfz02GKKxe/gS5q
 wc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676622; x=1736281422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvYdTYMW+dIfPF+uKcm/HE6zS5JfQaQKVI9r227X6ME=;
 b=iDYqCEeKoUyvgFhCHbZx0w40cUPgEgMoV1pCx7adsu2gFZEThjd80hFnK4e+T9/YO2
 rXG8DjwgN1WZARNfzF+2gNThK5TWumT2bFrlkf2DNzHFt/5UuUyEAoOhI9f8qRCMiZEr
 AKJ6+KzEtweVUqampdJVO/sbGBuIGbxc1eqcVP1ic5JWQi2+GAa4Ugtzkhr3h0P/cI2y
 furRS5y5IfnsFMoMjx1uILnPETUF7kuDa9ZjSph/hounHB1HV8xLcT3YPtqU7M7lsgWi
 BV81Pu5AG1iIcAYo4rC7V+/waW6xu4IXwu1NF3H0OvJ6B3+SczN6luut+GKYnuQZoL+a
 /gBg==
X-Gm-Message-State: AOJu0YxSmX8X+UUlrBdTlvSdo7jTF9xc3fQyPbz0g90gJup7HOX8oQzQ
 oP9B6mK/nuWdtl3vlkPTbMP0m/kJeQabdUgOC4M43qjGkC9+Jt6UlEyFjLYzou+iuLyGG6a277e
 yvf8=
X-Gm-Gg: ASbGncvXmVwIkZfSbb8yjozMRM5eraVXB8lPwZLZsVgtRW47WeqzRnf7pJfgJtIIq9N
 HRG/rSXD/KYjn1SokJfCKafLS5467DKpSLQtt7BI6VpjqPLrOoHUsoRKINQfRHtvdjoCstRhDv+
 Z7AVpgGIRGXKXO7Ddx0+Wwwts30FXfD9Z4/f3ql7wfilpByHtiNx+qNor4Q0B3wNNi5cKAmpgYy
 cQv/PrZ4ryufIqkOh96esFf/ytMeAipxfuggXViGSemAGW8IkTiM7xhtEv50lZf8qovIPmtHh6x
 r1D99z7avsUVam+/NCz8hKBHx3vyZJ4=
X-Google-Smtp-Source: AGHT+IEH7qKkI+flyOyn32YzbOA2/N3Ste+JB1XmAKRtFqmsRqqjQf8XpnyIExqcfIR+lTB8F2BrYw==
X-Received: by 2002:a05:6000:4615:b0:386:3328:6106 with SMTP id
 ffacd0b85a97d-38a222019d8mr38061343f8f.35.1735676622460; 
 Tue, 31 Dec 2024 12:23:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008b1sm395392315e9.15.2024.12.31.12.23.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 15/29] hw/net/xilinx_ethlite: Rename rxbuf -> port_index
Date: Tue, 31 Dec 2024 21:22:14 +0100
Message-ID: <20241231202228.28819-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

'rxbuf' is the index of the dual port RAM used.
Rename it as 'port_index'.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241112181044.92193-8-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index d54f96df243..4c0c7fcae3e 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -70,8 +70,7 @@ struct XlnxXpsEthLite
 
     uint32_t c_tx_pingpong;
     uint32_t c_rx_pingpong;
-    unsigned int txbuf;
-    unsigned int rxbuf;
+    unsigned int port_index; /* dual port RAM index */
 
     uint32_t regs[R_MAX];
 };
@@ -176,7 +175,7 @@ static const MemoryRegionOps eth_ops = {
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
 }
@@ -184,7 +183,7 @@ static bool eth_can_rx(NetClientState *nc)
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
@@ -207,7 +206,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* If c_rx_pingpong was set flip buffers.  */
-    s->rxbuf ^= s->c_rx_pingpong;
+    s->port_index ^= s->c_rx_pingpong;
     return size;
 }
 
@@ -215,7 +214,7 @@ static void xilinx_ethlite_reset(DeviceState *dev)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
-    s->rxbuf = 0;
+    s->port_index = 0;
 }
 
 static NetClientInfo net_xilinx_ethlite_info = {
-- 
2.47.1


