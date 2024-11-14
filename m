Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF879D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyQ-0001eK-6e; Thu, 14 Nov 2024 16:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyJ-0001HB-Pm
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:47 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyH-00085p-Rw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:47 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38221500c2bso437193f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618100; x=1732222900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=trKZIqBS/vvTexwy29kgOKpXSiuRtzrN3KiHsscp0eY=;
 b=UOncNcMaWl/KXWMQBfS2aIgL0IwvIvIq5XxjwrQLB9tOI1LqwH4f3DLyhGbaIlyH3X
 XwIqBtl0ib2/Bq0E7xK7RrAt+OFxs3Pg4nOm8yYGtDM9GnmdciVJWTPqZQSNoioYEdvb
 4kGMCFk/0WCLorP5eDyBR3DUpJGZdXrOWjGVBptvU43r/lTUwAwP98JotOWHuiPD87KF
 vF4kGbgC+e/w7nDuEIng5RIIYse/eWbi7iJa4XiArMIMN018iM6cYNmmc7abMzy0O03W
 xj0EmN5q1t8+BGeDfVdY5bTCui9VpciwZqtpoqdCNDXORMu81lpCQ5JwVhQUpimcyrsz
 vSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618100; x=1732222900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=trKZIqBS/vvTexwy29kgOKpXSiuRtzrN3KiHsscp0eY=;
 b=Kaha2pSl54dGdYBRi09SB2fwW9Dqx4lNzg7W+BaEgE+KUJB1lwAiRTIvl/qdaD/hz9
 BPOIRXYrHGrwkmbmzGPKQ4YBvBk4A/MsXjykY0nKDrvyLYNof2xFCCUFbK+UKZgY2xNA
 zzvvdtTZxjVkBJOzbzRiW6lbE/jmAnSTuMx0cTlW/CzvmJmK2KJeX4TGaylYfarFX0WL
 shWvntkz83C+ohfBmoujOmpYeR8jq3vBWWzZIaoUuXcbZl+g8htnPHiu6cDHq+iA4EuX
 uuY/odQRN2OKRcHDB0Yc8hB6A7JlBMUjyjsjz+fhZDv+AYaAkMewL6e4imYwYD9d826q
 mRNw==
X-Gm-Message-State: AOJu0YyHxgV9od+o8BgFD6+6E56ozs6ckE2WzA2ZS4GAVCVpEc7Yh1k/
 yvpqs28QycJI90Ww1rloUFK5xSnE837eKBEAVjis2l9Ngp48fGMWLDBOjSumAcJ3SB3lon/MNLk
 o
X-Google-Smtp-Source: AGHT+IEtrPq30bJ7JygfII/EZNYCQoR6LrRs133Wu9MriRWug5cBSB+CJNfGNQP6F0Q6eKlgIplIsQ==
X-Received: by 2002:a05:6000:691:b0:37c:cc7c:761c with SMTP id
 ffacd0b85a97d-38224e531b7mr487963f8f.3.1731618099808; 
 Thu, 14 Nov 2024 13:01:39 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbbbbdsm2441261f8f.50.2024.11.14.13.01.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:38 -0800 (PST)
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
Subject: [PATCH RESEND v2 11/19] hw/net/xilinx_ethlite: Access TX_LEN register
 for each port
Date: Thu, 14 Nov 2024 22:00:02 +0100
Message-ID: <20241114210010.34502-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Rather than accessing the registers within the mixed RAM/MMIO
region as indexed register, declare a per-port TX_LEN. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_LEN0] and s->regs[R_TX_LEN1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 36ac8097af..06da940303 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -63,6 +63,7 @@
 typedef struct XlnxXpsEthLitePort
 {
     struct {
+        uint32_t tx_len;
         uint32_t tx_gie;
 
         uint32_t rx_ctrl;
@@ -134,6 +135,9 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
         case R_TX_LEN0:
         case R_TX_LEN1:
+            r = s->port[port_index].reg.tx_len;
+            break;
+
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->regs[addr];
@@ -171,7 +175,7 @@ eth_write(void *opaque, hwaddr addr,
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  txbuf_ptr(s, port_index),
-                                 s->regs[base + R_TX_LEN0]);
+                                 s->port[port_index].reg.tx_len);
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
@@ -196,7 +200,7 @@ eth_write(void *opaque, hwaddr addr,
 
         case R_TX_LEN0:
         case R_TX_LEN1:
-            s->regs[addr] = value;
+            s->port[port_index].reg.tx_len = value;
             break;
 
         case R_TX_GIE0:
-- 
2.45.2


