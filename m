Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415C6C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxh-00025M-6U; Tue, 28 Jan 2025 15:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxe-00024X-EU
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxb-0001Ym-UR
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4368a293339so69453915e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095202; x=1738700002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xIPqvChCUfqOgMcD+7liBSkFzj/Qghi4LvOlrz81nwo=;
 b=BHUaxAIHOQxf8L9EtAQkYls9ZRhuMh4QJPZAwxsoL9SmBR4gc93946kNtrrRBHA982
 Dld/d2kPRphgbn3nEg+4d11Yf5M2wBlSm5LO+2ZN6GiT86/GSzCZVV7T+uyhsVnOAiHu
 NSdzPeGZM45Y0iF6/d/M1wv5dU6m0FL4gMmSTzw+QCiF/jmJszVgqRm52WxLx1XW2CEY
 syZj5K1k5BaSzF/ce1V4rtmxAoB5Zke2kS5ONd/Ly5ZCtjD6RrSBum95VGAZfCKxPOGY
 IgxU2xq3Qc5dkXUGI75xnBd8nMuShcXL5pvNfVKmYP6CWCpy4BlJBv8bkupLp1P0jr4q
 cLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095202; x=1738700002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIPqvChCUfqOgMcD+7liBSkFzj/Qghi4LvOlrz81nwo=;
 b=ngdUBYQ8vFpR+Ycp6HiIf/1yrDBq7xjaQUIseqWSB3jTsgYXZy7HSy4hbgnuJHmuIB
 YBivNb3DqV7kPaWmZk/e/woQQJAPGylf8K2eSAHxnKGBPtgRFUwGJTeTRNQGjExoqqE5
 PIH+rQG4dhiAwjEuPiFspC4hJSKyByWgCmOTr78ZE4benGYkHuMEmjpgFdOixlhuo7ep
 pEDH5IE4bicyMhCHkoSW/PBeikySW6iUVuVxq05bzj9US1E2cqqdC69r1GiXK2ZYXJ5M
 NlfAC+O3G21bGpTsJKokuVPdrNKbBp55l8qBJGzjq/InIP2/VEZPkVh2uGf72N+WZXpY
 LsiQ==
X-Gm-Message-State: AOJu0YyLE+EW9p7nwoCsThnvRgh/YhsysLyKRE+MAs8wm7Dx681TT/f4
 smwzcnhBVvaCiUtQad3WuQ0Klf9d98a4gDMrUvVLqsjKE6qHG+shftsa/bDR65UlJpm915QAdlw
 d
X-Gm-Gg: ASbGncv1STT3V3v+NpPQRGeMQqNQIqKxa0RzxBYb1iF3iGIVduuzO7QDxg/FwUyl6Pz
 Tz4A/YN5xqIL5xLh6UIoUJnPrwTc6iVSaDFraURL1KhbttPD3n8viTaWRHSJTgHdhRc7Fi/n45H
 oCOkMCrB4Ap/JA3fMvXYeH2yrVcodGoZFYEIWBAXhoKZyewgvLB7DLtfPUIlCXdLgbk9EqdHwLu
 PYgJNcoqmWTqczkPZXIRAFnMwLGa/k4+OJ36CRwxIKCvQhrn47OpbOGUfpftm+V3b0FJZSV6p+h
 VGai6ZY66DkPEqv6v8C6xtI71f28Yu5X
X-Google-Smtp-Source: AGHT+IGCM0Op2TXJCBEzQWlFxOpxPHAOSFQf1mNefKkExikmhNim6zAjepU8Qg0thJAL3/i5c/GjiA==
X-Received: by 2002:a05:600c:1e20:b0:438:a1f4:3e9d with SMTP id
 5b1f17b1804b1-438dc3c405dmr2360735e9.9.1738095202028; 
 Tue, 28 Jan 2025 12:13:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/36] hw/char/imx_serial: Update all state before restarting
 ageing timer
Date: Tue, 28 Jan 2025 20:12:43 +0000
Message-Id: <20250128201314.44038-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

Fixes characters to be "echoed" after each keystroke rather than after every
other since imx_serial_rx_fifo_ageing_timer_restart() would see ~UTS1_RXEMPTY
only after every other keystroke.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/imx_serial.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index cb6761d40e4..38b4865157e 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -401,14 +401,14 @@ static void imx_put_data(void *opaque, uint32_t value)
     if (fifo32_num_used(&s->rx_fifo) >= rxtl) {
         s->usr1 |= USR1_RRDY;
     }
-
-    imx_serial_rx_fifo_ageing_timer_restart(s);
-
     s->usr2 |= USR2_RDR;
     s->uts1 &= ~UTS1_RXEMPTY;
     if (value & URXD_BRK) {
         s->usr2 |= USR2_BRCD;
     }
+
+    imx_serial_rx_fifo_ageing_timer_restart(s);
+
     imx_update(s);
 }
 
-- 
2.34.1


