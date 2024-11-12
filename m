Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D5D42BBF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMu-0005It-0G; Tue, 12 Nov 2024 13:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMh-0005DK-Im
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMg-0001x1-2L
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:47 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53d8c08cfc4so3391520e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435104; x=1732039904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFxTKFQ0DGptUkzLtcja4XwpDLueVdiea1brksjZQow=;
 b=hmIDoznQjUOntY30qHd+u9u0vWrBM7JY1B/Zq4203nsO6EQXBuKZ/TPTc+eEE8mt6D
 NK2ADtpA5rJ2fwSiDnUD/Jm2jnKybOkoM+1/S+kY40FuCqW66E3c9s1vi2JHvcevDDTE
 6qzrl3s1/Xdo8tcOTmG18i2aaGVq8REx4huk9JIT+nimxVp/ZOOeQ26znMKAZF5psznc
 9nVdn3cM0sEuce4xLxFc7sZuyCoWPQQk1IWfFDFXKun055ILPAw80xz82VhsiFDWFujv
 aBzVXfbPQtxMSUg5Sq8l9Cu6KtqO5c2jDCqJ+gYpbMf2lV7/6Lg9BrA1SjfM5VIJhlev
 sp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435104; x=1732039904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFxTKFQ0DGptUkzLtcja4XwpDLueVdiea1brksjZQow=;
 b=CRqYFwvd5SGgPctT0tvR8v4Y7tloJj1zqCostETnoMLzAxBEie3RwHuUN2ufWF5FzQ
 ZbHQ1PXwWjRZpHD0YKWvv1LA82yFur3CWG0cxaAwoh3cN7J+u1IlTs1obdhDs4upJVDW
 Smo7ullX7JuRFaeYOjH9Doqd1+ffIZMumAwJUz5IfvhjNcvwVgE1u7USQDCTJ1t6mfWo
 ipAvaWcKK31XPF0oRO8Hk73IhPQgioYdk9HTrLMSmo3zT1/8aqd5aO4cEbOaCZ7P0LR5
 hXMm4loi/muEYFpXLVA334n6VoFWMaIqRVJzGXpvu1c9G4ADp2mePWcakRTsNs99PGbZ
 c9wg==
X-Gm-Message-State: AOJu0YwGQXm+B1yKUd2HScZG8mEtqsDq7+aY46C9r18bM5yc5KaZHOrb
 reE5L0x4VIK8qCLUhJwoKeY/xfpv48QFnUYaHArutDWGFORLQiXleKWNOIyE+QdtcwUwb7ryw3I
 Q
X-Google-Smtp-Source: AGHT+IF3xa6t9VNRXlcqWORMc1/5N0s9zi/mCbru/ds8eBKeP5mJw67TesIirzkRpQWS+paKeTr3Qg==
X-Received: by 2002:a05:6512:b09:b0:536:a695:9429 with SMTP id
 2adb3069b0e04-53d862cd111mr7578226e87.10.1731435103570; 
 Tue, 12 Nov 2024 10:11:43 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a234sm257606015e9.34.2024.11.12.10.11.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:42 -0800 (PST)
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
Subject: [PATCH 09/20] hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
Date: Tue, 12 Nov 2024 19:10:33 +0100
Message-ID: <20241112181044.92193-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

txbuf_ptr() points to the beginning of a (RAM) TX buffer
within the device state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index fe91891310..d4882f43f7 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -87,12 +87,18 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
     }
 }
 
-__attribute__((unused))
 static unsigned addr_to_port_index(hwaddr addr)
 {
     return extract64(addr, 11, 1);
 }
 
+static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
+{
+    unsigned int rxbase = port_index * (0x800 / 4);
+
+    return &s->regs[rxbase + R_TX_BUF0];
+}
+
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
@@ -125,6 +131,7 @@ eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
+    unsigned int port_index = addr_to_port_index(addr);
     unsigned int base = 0;
     uint32_t value = val64;
 
@@ -138,12 +145,12 @@ eth_write(void *opaque, hwaddr addr,
 
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
-                                 (void *) &s->regs[base],
+                                 txbuf_ptr(s, port_index),
                                  s->regs[base + R_TX_LEN0]);
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
-                memcpy(&s->conf.macaddr.a[0], &s->regs[base], 6);
+                memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             }
-- 
2.45.2


