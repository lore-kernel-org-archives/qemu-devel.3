Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB78D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgyI-00011O-BU; Thu, 14 Nov 2024 16:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxs-0000id-Hx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxr-00082H-1J
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-382242cd8bbso159185f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618076; x=1732222876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6+gSXBoOBmz0VjYZ13ccRnCNyVzdwJCJ6CvUinNnmk=;
 b=PlE4oywofk4ddAaqv3b+ARg1DHZbkgWBNhTR6TEAq0jh5WRAzM/CK03j3oSzHXFTnZ
 bL4uACj45+PNJbqNI6GoROV2QjPABkhjTwRBkM6vniILaNqZsF3MCNHnxKujSpfYGEBX
 f/pYQS4Jjs/+gSIe0D9CahCXlvLpGFQHF7szo0gnwIOCvwkkTwINatsetmO4oqDibG8s
 sNvYfYX5BMzkJku1KZv13uKOnvpmYRWtiThSR7JcLqAM3f4QbY9+rgupAdDSOtV23/Sh
 92wOD4mywj8w7XNAEXgIfVOxvfRv8xU9xsxDnyuajq1rhZDi0MxM5l2x6AdgVWmJwpih
 8aQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618076; x=1732222876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6+gSXBoOBmz0VjYZ13ccRnCNyVzdwJCJ6CvUinNnmk=;
 b=fV5vr/JHzpOnVfv6VAxZq5JArDV1TYC97V0bJqYz91Anocwlr2ytXg+bOe/cxoPjfI
 FZDYc9H2OcFN6bUu2GuWn0JH/V4VSq/5Oden2nZon5W0uDNFEqH6PVHipMWeqaurLbLg
 +Fk9X/YK4eRIKB1TYX+Js7BTOPGZOc+z9U+0c9RsqRCK0DF5wLuSTWm0E26AVHi7M65a
 TQamd/Fw6DHLRy7+sM0c7YyjYta/9HZ+x9PNQRkNn3jQGB9jhEm+lBCWTAMl85+WoENn
 STHjWelJmvamCjTqkJsQi7YjyMzmAGTSmpYVCwjYu6Qdb31WHw0vQ4DoK6LaAPwdTY7Z
 7t4w==
X-Gm-Message-State: AOJu0YwpLbj2Yo40zrtgXHBiUKvR7M2s1oAECi9jEdIMUlJ7wwmmSRyI
 cpq4gW3F4WnINd66qAV0HN2vwdEtOfXxs4HN0Il5AWJ/J6IGjzL7Iqt/ikLnc/QevlmqVb7UJEV
 M
X-Google-Smtp-Source: AGHT+IFzKS759KDofNJAb8xtvYBxgE7ro77dDXvOnX07qfJ0GUL3uV3YJIYtO8YYGg2trMmHmh7H/g==
X-Received: by 2002:a05:6000:480d:b0:382:24e6:fce9 with SMTP id
 ffacd0b85a97d-38225ac4abdmr145054f8f.58.1731618076339; 
 Thu, 14 Nov 2024 13:01:16 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae1617bsm2481527f8f.72.2024.11.14.13.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:01:15 -0800 (PST)
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
Subject: [PATCH RESEND v2 08/19] hw/net/xilinx_ethlite: Introduce txbuf_ptr()
 helper
Date: Thu, 14 Nov 2024 21:59:59 +0100
Message-ID: <20241114210010.34502-9-philmd@linaro.org>
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

For a particular physical address within the EthLite MMIO range,
addr_to_port_index() returns which port is accessed.

txbuf_ptr() points to the beginning of a (RAM) TX buffer
within the device state.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 7a14f4edea..21ce2a112c 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -27,6 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
@@ -87,6 +88,18 @@ static inline void eth_pulse_irq(XlnxXpsEthLite *s)
     }
 }
 
+static unsigned addr_to_port_index(hwaddr addr)
+{
+    return extract64(addr, 11, 1);
+}
+
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
@@ -119,6 +132,7 @@ eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
+    unsigned int port_index = addr_to_port_index(addr);
     unsigned int base = 0;
     uint32_t value = val64;
 
@@ -132,12 +146,12 @@ eth_write(void *opaque, hwaddr addr,
 
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


