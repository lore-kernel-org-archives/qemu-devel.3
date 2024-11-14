Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8114CD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfCG-0004gc-Rl; Thu, 14 Nov 2024 14:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfCF-0004d9-Ly
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:08:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBfCE-0005Z0-1C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:08:03 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-37d49ffaba6so657654f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731611276; x=1732216076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yTK4l6Ykvzc6k9RKpIP/b45MtLRJEjbQSCPD8FRx8u8=;
 b=ezAM2rTg5pEXstch3YjJO60KdLwSiX4IKSBYMZnZjmiXKIjqJte8+tC/30BlRQpyOs
 dpCGzb3cchV7s/pVFc9Ex+5aH7G+BXLCL5n5YJL45tiSSwHT/gtE6IZ/mEPwMjzvHH2Z
 p/ovp3KAS4Mo+5cP8MRTZjn2VB8w78iLSXBljXe8ZxXtnvUboAutVDRC6c36AqnW2Uyv
 K5zcubeJz1GqDwvGyo3KCDmbu9LngOegJyf/2BqugZZXBi0Mx9B9lYLvEtG2m5N6WgZQ
 WZhGjvVjPlrnji3K8/EgfDnzF9CQSqFChxBU9w5ONKeJ6f3aAqQEYTTPDqusafEH3GCL
 sr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611276; x=1732216076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTK4l6Ykvzc6k9RKpIP/b45MtLRJEjbQSCPD8FRx8u8=;
 b=KYaWmWakhT3pbUK5hBqd7RY4/1fGvfYqNk5lABqXf3EMXdNZwG3fUVfF6Uic/aWl05
 u9chlg9wCrwUPYqU3YnBU6SmUAS4lJ2YpDcAAQphHllJqjFdC8ph/mkSp8PvTL0w2g8h
 2wnR+vnB+zZxFOzFl7OD0F6Y6+nR2mFv+h8Z6EldWvnkwnBnUB4fbehFMB9lAc4tFlV7
 7Va2LBZQWOIgj7RII19bqF+X5a05x7hRUYvEjB1eufaOX7JhD6nhl7eQSR9Yta8m5D3q
 ej9KeRqV33bfBJH++1la8nQmEDsXwY135Q6qCOhgVojanVRnBsWSM4ki4ttLRFg7Uo2E
 MNrQ==
X-Gm-Message-State: AOJu0YyQha4tr2C04/E2ZCo9VrMbXTQJqjso+1kLuOwtxJZFvn8kEIsO
 7sse6/iUNgjhiVCd/OJl/ILFaca3gnfBViHB466xSzVpxjXWbxeYsRUCeHU4KTF2FFf/BCA5rC0
 m
X-Google-Smtp-Source: AGHT+IFk1fHHYT54q5QtdRl1SYFYT73aOdvrv3217DOEj9nerCJ7kekLMixMzyT41tOHqD7NMee+QQ==
X-Received: by 2002:a05:6000:1567:b0:374:c17a:55b5 with SMTP id
 ffacd0b85a97d-3820810fdb5mr10354120f8f.14.1731611276643; 
 Thu, 14 Nov 2024 11:07:56 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313a8sm2176218f8f.105.2024.11.14.11.07.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 11:07:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 03/19] hw/net/xilinx_ethlite: Remove unuseful debug logs
Date: Thu, 14 Nov 2024 20:07:17 +0100
Message-ID: <20241114190733.33902-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114190733.33902-1-philmd@linaro.org>
References: <20241114190733.33902-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index bb330a233f..2b52597f03 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -32,7 +32,6 @@
 #include "net/net.h"
 #include "trace.h"
 
-#define D(x)
 #define R_TX_BUF0     0
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
@@ -100,7 +99,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
         case R_RX_CTRL1:
         case R_RX_CTRL0:
             r = s->regs[addr];
-            D(qemu_log("%s " HWADDR_FMT_plx "=%x\n", __func__, addr * 4, r));
             break;
 
         default:
@@ -126,13 +124,10 @@ eth_write(void *opaque, hwaddr addr,
             if (addr == R_TX_CTRL1)
                 base = 0x800 / 4;
 
-            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
-                       __func__, addr * 4, value));
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  (void *) &s->regs[base],
                                  s->regs[base + R_TX_LEN0]);
-                D(qemu_log("eth_tx %d\n", s->regs[base + R_TX_LEN0]));
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
@@ -156,8 +151,6 @@ eth_write(void *opaque, hwaddr addr,
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_GIE0:
-            D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
-                       __func__, addr * 4, value));
             s->regs[addr] = value;
             break;
 
@@ -203,7 +196,6 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
     if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
-- 
2.45.2


