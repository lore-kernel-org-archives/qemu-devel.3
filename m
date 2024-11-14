Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5709D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyQ-0001Yn-0v; Thu, 14 Nov 2024 16:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxl-0000hj-Ni
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:22 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxk-00081Q-7Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:13 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-382171e1a83so779688f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618069; x=1732222869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vs9ivF9siaWRamWv2mgjjJCogSIQAiZCiYH/706wGI=;
 b=CES7arhhgG9nZYxKTyw324Pcg3sZRE2UhT17gN8kxW3ZXcOU3tTWvbXqaS23CtZ/+d
 twbkQzaoHbHiGaoI2hyk3RotoUhQ71np4Fk5CIaK9VrSLUXxgh1HnThJhKwgCqnAyr2B
 XxxR+Omk6wahPzTl/oknfd1epaJmn9hz/KVHgvhMRrqvJ6fYUNwkqYV9Za4vFMiv5p13
 gryqhuOZ2t2mLXT9Jx8VGtwZYrvPcryWaQgenUtXoBIN7Dwrw8dD+WLGv709lu9OK5gI
 NS/Ewfkmo4NegJeFBU0CSXLoEZwu8LyLieO0CxH+GPDw9qCjhuv+SkQ7T0es0FXCpDcZ
 Q7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618069; x=1732222869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7vs9ivF9siaWRamWv2mgjjJCogSIQAiZCiYH/706wGI=;
 b=hXx6pUim4JavA3v3rcfxByC0OKjihUc/hmi8GFNOjrnT08HLPxR4g9Oh2MRS5Mjkhw
 2SNlfF122YYr3NjHbduvBjcXNReLYUagNi0BJXVIJFKfhy6QxP40uTxui0Nd9QCy4LgU
 7uy1vdvT7gDKUVTs0mZ2YwglOolV+nM3qnrnDVfM+Kl7Lww1xguMjMXwIOlIXDSnKgai
 vdWBzzoGd+mH0fA4eyZ1b+YYSIaPwy2OL9sR0C+1cfBc9vUP9ng7/aFT5iix2mkIb6FM
 7HMMfNFwR+wY4p6h4nOpICkOBUCGQK12J+f2TFcKUY4ITwBnn4zGyRn8N6pGQH7tESer
 2uug==
X-Gm-Message-State: AOJu0YwmTRD4tITpVa/KupJ69mH8gKRSxnaaE+ked39tywkZcSIIETLf
 iJyLsG53VhuPZCwyIvaydo+jJePJCrzD9+UFgB7lzo4axRNfSx/sF8F/49Gwd25HiqTFSWFJe1N
 F
X-Google-Smtp-Source: AGHT+IFsjAgr97KhP0yXG1qxjOW6cOncELUy4xaLIMAqSVhZYcoM4DnvziXq4ehAO9vhma4bhtyysw==
X-Received: by 2002:a5d:59af:0:b0:37d:43d1:2064 with SMTP id
 ffacd0b85a97d-38224fd2443mr330814f8f.30.1731618068708; 
 Thu, 14 Nov 2024 13:01:08 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae154c3sm2442016f8f.67.2024.11.14.13.01.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:07 -0800 (PST)
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
Subject: [PATCH RESEND v2 07/19] hw/net/xilinx_ethlite: Rename rxbuf ->
 port_index
Date: Thu, 14 Nov 2024 21:59:58 +0100
Message-ID: <20241114210010.34502-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

'rxbuf' is the index of the dual port RAM used.
Rename it as 'port_index'.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 8de3131408..7a14f4edea 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -73,8 +73,7 @@ struct XlnxXpsEthLite
 
     uint32_t c_tx_pingpong;
     uint32_t c_rx_pingpong;
-    unsigned int txbuf;
-    unsigned int rxbuf;
+    unsigned int port_index; /* dual port RAM index */
 
     UnimplementedDeviceState mdio;
     uint32_t regs[R_MAX];
@@ -184,7 +183,7 @@ static const MemoryRegionOps eth_ops = {
 static bool eth_can_rx(NetClientState *nc)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
 }
@@ -192,7 +191,7 @@ static bool eth_can_rx(NetClientState *nc)
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
     XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
-    unsigned int rxbase = s->rxbuf * (0x800 / 4);
+    unsigned int rxbase = s->port_index * (0x800 / 4);
 
     /* DA filter.  */
     if (!(buf[0] & 0x80) && memcmp(&s->conf.macaddr.a[0], buf, 6))
@@ -215,7 +214,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     }
 
     /* If c_rx_pingpong was set flip buffers.  */
-    s->rxbuf ^= s->c_rx_pingpong;
+    s->port_index ^= s->c_rx_pingpong;
     return size;
 }
 
@@ -223,7 +222,7 @@ static void xilinx_ethlite_reset(DeviceState *dev)
 {
     XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
-    s->rxbuf = 0;
+    s->port_index = 0;
 }
 
 static NetClientInfo net_xilinx_ethlite_info = {
-- 
2.45.2


