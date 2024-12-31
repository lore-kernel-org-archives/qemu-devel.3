Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F30FE77197
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSim6-0003GF-OM; Tue, 31 Dec 2024 15:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSim4-0003Fw-UU
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSim3-0000sW-Cw
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so116414345e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676609; x=1736281409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BigQsrri04m3/+lBK80umChQDK82DoGxTPyI0a/+No=;
 b=dhwYBEtv/rRKJ/pWOCNu3ebknCZZ+B8eU5y251Z0rQENA+gkm1tZ1BLda0Q5QmXYc+
 xyZ6p7/w0sM6asUAiGzHmJuuqlXwSITkpJuF6FPzCR+6FJsmXKxnx6PFvTsQ2OkxCyaN
 WNb0ULtwU7qz7BqVGSvgjjwxo9YMgWw4OgD2nxEFONdAg57GAVyu6cS4vgu2Km2+dRPN
 0rmPC2PDElAqc321pEJ8LYLPwx1CUVAkSKOjBv7UvcAtM8GPxE93Pm9vdTYulfIzw4mI
 5BEQnxggqbBYUaMswvqjdlneEfuTyIucfYsnpEXVYRGygdIUo5j3+s5bF6A+DmrLe95p
 kEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676609; x=1736281409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BigQsrri04m3/+lBK80umChQDK82DoGxTPyI0a/+No=;
 b=DnvzTqGNxHSp5YuF9iRTpIrVlpei4nz3NpjtvKtpXc7Q/obURKQA2MwUNxNOk9nldo
 99Qvg5mEDiE0hK9bmt6RgDSal+9t+ccyLnvd0qOMB9QSvlZ4OzPkPONwKSgPm4LijO4o
 LaPpsaHEXq+ZBNq6AR/pudF8M60UfRyn0LjA7eFeH4xa7SlRN0ihE3DGWIbAAdWwpHwC
 AxEFHRHdURo6kb34IZZoEGNEWyC9edsQXKU9UPykl1vLVHkPFNFSUgFFHUAUvbwqcIhn
 jIid9OAxhzwvlNclTo7uHbxp6PMwRBQ3K1fY/ryX/yPjA9PpoIfZ26Y7vMyITqBRX2ig
 0ELg==
X-Gm-Message-State: AOJu0YwC9SWUSFaAj5tGeglYh+p7IysMDqF8nsuQSwuBipIEezygb2ye
 O3d+7jnVBLY2LwjN+/N0iBljXfLxeFS0ve5AOCyIdIcQprW19Tqn7jJx1tfMNeXhk8YF2PpX3FS
 dZhw=
X-Gm-Gg: ASbGncvD/VgiAXzMWVFgbdTqUDUmSiOohYRYFfk5YmJ5c2jVuOsu6AT03rvALS37EAW
 N+y3XhSe6iL0cQYAr3p4URwJ3TISqwOfVGPrHV9cI7uiWyeqxHWcGWmSlae5XRqRLYhtMfV+z81
 88m6K37nab3Tea5Ke42fpfeXjaXbriP3937drzv7aHV2eGrEnehLMFwaV8KDJ97Nlaaq4z3b2Kl
 riONBOC1h1IzDdMejhRe2De/GTjzQXWpLTnm309+6Jv36vPm2WKupUDuzFeqlRjUyWPs2FSfGF0
 RsGSwhg8AL1nq7PJg5aIwf7M1IIgD3w=
X-Google-Smtp-Source: AGHT+IFKYRLXT0EFDV0CHtldyUBIpNS0COskpKwXmn11K0VUbpIh2F7xhSZYask2X4bsjbbBGLLDdQ==
X-Received: by 2002:a05:600c:450b:b0:434:f804:a992 with SMTP id
 5b1f17b1804b1-43668b93b7bmr296080235e9.32.1735676609039; 
 Tue, 31 Dec 2024 12:23:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828cc8sm33551122f8f.17.2024.12.31.12.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 12/29] hw/net/xilinx_ethlite: Remove unuseful debug logs
Date: Tue, 31 Dec 2024 21:22:11 +0100
Message-ID: <20241231202228.28819-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-4-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index c38a71c71be..4626a55b069 100644
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
 
@@ -199,7 +192,6 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    D(qemu_log("%s %zd rxbase=%x\n", __func__, size, rxbase));
     if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
-- 
2.47.1


