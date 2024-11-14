Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEEBD6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyR-0001iC-5E; Thu, 14 Nov 2024 16:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyO-0001Xb-5J
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:52 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgyM-00086T-BK
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:51 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d4b0943c7so725096f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618108; x=1732222908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8zvUlfKjuVL1gQONPCLSNzp6FDlA5idGOeDaT6LkvA=;
 b=fwqkHPnevinQ5zkPmmwuHieP7VzqLULaY+cdqLvhbdsEg0iew3+KwYZZ1M3zpIZva7
 fhZEigj34ZWx22W6e2XyQJJHnWtgy/e+8Xfl2pjjSNhMRUc8M0yFVlTyXLf8HmbDFs3a
 thyUn41JY/PPmi7jVzTKZMF4BzW6BCwaf247mpKOUR6hal7BzPIyG8qXU52z8/iugNfT
 PYCvPCFBdTDUwIxUSzkfCfA0rXxf2BswpxUAIvnNtC7+5xJGsooasPxktfTtxviKxmLj
 +XHlLQcD0ueIoV6INjz73gIWE+TAdf27d5jhXVyzzw2DqWygzUix55nGbxVxu22tLGd1
 3Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618108; x=1732222908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8zvUlfKjuVL1gQONPCLSNzp6FDlA5idGOeDaT6LkvA=;
 b=l463czOGPFVlbvMGyhxSsyQWyrlnpErWOfr1LEvZhRkOTNPBOBSjLT8kztnNrmVlAv
 RrsRz7dHCsz3gP1n1PxqURW9kXCD1Gt4TFEzl5X7p0BIA5zDNW/z+H/UVG7rfYdv/vez
 1yzmPZ+SWGahT+lFocUh6hJ31sGI0nOVBsviyBZsZwk64VcspvxEyfg3hje8hZTdRZaT
 I7cxR5tUhT14l9kt1UKcq2Djnud14UzhkshHtNxEY0DIIueQuhw9JiktjkfZbwaezoGN
 dzY7qBnWVEiWoDjHGwnZb1Xb1LB7uW8JJYWTYukqa1KKE9ZxMLQdAWCz3+rBQ6IEY+cQ
 pVEw==
X-Gm-Message-State: AOJu0YyEsblOrLSDYynLsr47wt6D9Yk1SkSE747S6+iFJw2208/x8GxD
 jARKJmecP9Wn8Ye5cf3Qm85cId707O4SfP4nPw/uCd5IyFuKlPUQs+qRL7CdwARp+7b0kKfPaP8
 e
X-Google-Smtp-Source: AGHT+IF+FFFK9yiHSJq6OvB83pV2IJp2J7JUki8nw2tdM/kl/0NJX+qq4EHLB99QVx+6xaelXrtfLA==
X-Received: by 2002:a5d:5f91:0:b0:381:f443:21ca with SMTP id
 ffacd0b85a97d-38225ab4db7mr129227f8f.58.1731618108071; 
 Thu, 14 Nov 2024 13:01:48 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adadba4sm2423628f8f.24.2024.11.14.13.01.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:45 -0800 (PST)
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
Subject: [PATCH RESEND v2 12/19] hw/net/xilinx_ethlite: Access TX_CTRL
 register for each port
Date: Thu, 14 Nov 2024 22:00:03 +0100
Message-ID: <20241114210010.34502-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
region as indexed register, declare a per-port TX_CTRL. This
will help to map the RAM as RAM (keeping MMIO as MMIO) in few
commits.

Previous s->regs[R_TX_CTRL0] and s->regs[R_TX_CTRL1] are now
unused. Not a concern, this array will soon disappear.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 06da940303..674f805d76 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -65,6 +65,7 @@ typedef struct XlnxXpsEthLitePort
     struct {
         uint32_t tx_len;
         uint32_t tx_gie;
+        uint32_t tx_ctrl;
 
         uint32_t rx_ctrl;
     } reg;
@@ -140,7 +141,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
         case R_TX_CTRL1:
         case R_TX_CTRL0:
-            r = s->regs[addr];
+            r = s->port[port_index].reg.tx_ctrl;
             break;
 
         case R_RX_CTRL1:
@@ -161,7 +162,6 @@ eth_write(void *opaque, hwaddr addr,
 {
     XlnxXpsEthLite *s = opaque;
     unsigned int port_index = addr_to_port_index(addr);
-    unsigned int base = 0;
     uint32_t value = val64;
 
     addr >>= 2;
@@ -169,24 +169,23 @@ eth_write(void *opaque, hwaddr addr,
     {
         case R_TX_CTRL0:
         case R_TX_CTRL1:
-            if (addr == R_TX_CTRL1)
-                base = 0x800 / 4;
-
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  txbuf_ptr(s, port_index),
                                  s->port[port_index].reg.tx_len);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
                 memcpy(&s->conf.macaddr.a[0], txbuf_ptr(s, port_index), 6);
-                if (s->regs[base + R_TX_CTRL0] & CTRL_I)
+                if (s->port[port_index].reg.tx_ctrl & CTRL_I) {
                     eth_pulse_irq(s);
+                }
             }
 
             /* We are fast and get ready pretty much immediately so
                we actually never flip the S nor P bits to one.  */
-            s->regs[addr] = value & ~(CTRL_P | CTRL_S);
+            s->port[port_index].reg.tx_ctrl = value & ~(CTRL_P | CTRL_S);
             break;
 
         /* Keep these native.  */
-- 
2.45.2


