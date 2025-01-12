Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FBEE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6Hm-0007gw-1f; Sun, 12 Jan 2025 17:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hk-0007du-39
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:20 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Hf-0006Qv-9u
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:18:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de59c1a0so1809026f8f.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720293; x=1737325093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FcvQxHKjjfdSZc8glJoiGuaRFxkcd8Ym5IYtsN/6Jw=;
 b=FgosoUDYBZS2aq8EEArShRNojN2x4C+eAhk08xRTICbxfyJeYp3c8afii0poe5L4Jp
 QCXgEJMyrQFZrnmY8WZwVSo0Bi8utW5CIVSbypU+PlhbLsLr0ChVT/y2clScCAijGC2v
 19jWGBZYFp4+lC+4gxQhPk/9pxyAsT7rXqIaUeqwu+M2F+5MVLxYeboJ8FZDfpxUgLeV
 C/FO8/zF6FqwcK2JdyDIYuuxSFmPRV3i32Ib7GrDORuf+bk72IVafNKZ7dRFzx0LrM38
 581BgpRQT4gOsi9ekYQKicZrGFN03vLNvR65wSdWxBXbPg0FjNpdvmcLR4Rms+zamkYg
 InrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720293; x=1737325093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FcvQxHKjjfdSZc8glJoiGuaRFxkcd8Ym5IYtsN/6Jw=;
 b=jfYi8idkMMhl9UjOOM+fn7O41yqingqOk0b28YUDGBnExwsUaDS5LGSut3jjQQRCzl
 p7NP0qQQB5KCh3aoLFPNbz4c+1i0NjRBO8zc27S9Um1zIBHCcZzA39YxrdfgLan8z66s
 d6tic3MIeesU7daDxFuxfe+alDTw3LeH9XgAsfL+daU9dQCvsxV54LWcvRg2qnHzHkze
 wWsyLBJMy3vsYoVfNHtd5MWjh40hkWmJbAAmFNoQPoQ0EHcZHOrbBBrpq70bT0XG/+w+
 IoMNmygFfqzrTxJckzqqmXJr/bS97LmcKOZeDExr4txqdFg1OA5pzTXPzOPxbmxbvaHB
 +VQA==
X-Gm-Message-State: AOJu0YzEg6/F0npX1iveEhhxN6JLPqN/9O5dapxs3GelN6EmRZN4deCe
 EY6uHALPSxSfiDgUy69rbXaDY45GPzRPLaon7VcQ9MuB7ad5oVPgQpgR+Zbro7KRzKETWa7Qp4I
 IMp4=
X-Gm-Gg: ASbGncvKXNnvQ8PAESlscuQRvETeW3veXDfaY/bM/EQNNrlvzbXvGf0m1ZLNrda3Q4R
 kZzFr7UFgCSkewgqPBBSPfkwOZs5xcLJbQLXZ08IIPm4FaCu9rejOvD5cNJvqf4qinvNoZrBGXl
 L6XGADgK2XTlyy4fzlJKW4xvSCYtpXu9GyPG90I1jZjXrldtvt0miDld9k3QdOmthb8ZYI4dXuZ
 qf2ocIaS0h3xfzGxiCzmeC4HRpsSzUBF/jQJlAUIDP3RzJ/gbf8CC2WbBZIx5eW7wgWT75NQLx6
 X+4bBgF874gzMev4eXYK3H1GhSEmqRg=
X-Google-Smtp-Source: AGHT+IH3bqSbUAruzXc56V4Hy0Yn4C1LLUKrLg6qcWOrQi6Y05J9mxjzwJOd+iD96pdDuADCwD9MEw==
X-Received: by 2002:a5d:5f82:0:b0:385:e1a8:e28e with SMTP id
 ffacd0b85a97d-38a872faed5mr17067468f8f.10.1736720293328; 
 Sun, 12 Jan 2025 14:18:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1dc6sm10634910f8f.96.2025.01.12.14.18.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:18:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 09/49] hw/net/xilinx_ethlite: Introduce txbuf_ptr() helper
Date: Sun, 12 Jan 2025 23:16:45 +0100
Message-ID: <20250112221726.30206-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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
Message-Id: <20241112181044.92193-10-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 442467abeb8..8df621904a1 100644
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
2.47.1


