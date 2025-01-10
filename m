Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F19E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTq-0007js-H5; Fri, 10 Jan 2025 11:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSx-0007HV-92
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSt-0004FE-Ni
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:29 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4368a293339so25797995e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524945; x=1737129745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNnZwPGg9I7cmBuNCb0r/kiY7/oGOFV7SpkVL4fmHdY=;
 b=YVGt4BFVhvuYPrg9itQb0GUOvcULsk9PmsRaoo0JpjhYCmFyqFTRKKJSadbof25nHI
 ecxHx5RiQHY3Imu7hBXDRi2Lbr9TUY7NKgX9+ZHf2Y3M682STr9g6KBSwhEMUXeI6qUW
 vJ8/KNtXsDSxkcp/WBT7ZpD6iJh1Pt5r6fqnHNeUP9D8yBwbLgm3OmAbJq2F1rqT+iYr
 ywLNfbqz6K1tD4ry6zGTdnIJ+AgDK+eJoDNYXaXzlDdGRxAPrPuRhxXLhXEYpOrgxlHL
 kT3z37Tsqdx1r/RYH2jDn5xJrIb/f6d//r8++ebFUrJGWWECoQeUunZo58hqCDJ9KuRW
 buRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524945; x=1737129745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNnZwPGg9I7cmBuNCb0r/kiY7/oGOFV7SpkVL4fmHdY=;
 b=kPK/i0JQhvpbsLAJzDHWo+aSTsSbQYn0jfzQtNNSVZyLnOWoB3ibjbFsSrjWDVRYYb
 H/F2NdEqUzPK5s2xqjwVLY+7vbPmtLqk4H11COe9/Sj74hpRuJboBBj5MRVttNmpfURX
 QK4xU7ebdbvFD1GNEKWRRpTKtVcu/6VzrT1HsxU34F09nfx7JpmcOIL3FIHNO9Q7k9qZ
 7J70mGN3XxYkzNqygKCQG/gfL6cOvpxF0Sg6lKhIdnc4xPPX3AVe4Tx0sDBQ4XgNospl
 H1h4a+eK4gBFR4GANWCmwnsSAc+ovYNZOZDRtvCWS2K+QpsU9JIx+PwndVIVnMvkj2Ix
 C1Zg==
X-Gm-Message-State: AOJu0YyX10O130xwtYZ68K/cqV0gcvn93fHbpD1RpfgVFVSAidVpQ2N6
 4gLfG4gle7wI8MBuT8j7hUyYwYp5MXcAc9q+l7bk5xFOGKFMOMsBJ12vjllNpL2MO2xm647W2Uv
 Qjuk=
X-Gm-Gg: ASbGnctTQhcARQawaRqbkscbgtufsMARN6ldQyw+oexc8dC6QEPe0oFUMfK2bap/NJe
 rsucZMAFX9RH5L3iqFsahi+pNi1UvwG/BwhJ0yEUt/Nsxzqaq3EV6YVgIZVQP+S4tpRTqhClTPp
 ZLeKmRWmJiRf6Tl8KrtNM6kVUCG/z89MdsNmufHWEgJ8H9Pi/r+HzPnSLjrpnfu86YbSMBCFv/T
 TpY/SYU79OGSd+tIUtBUzEdt7nB9nILWY3hruWqZ8f3xXi+Kpdlj0PiPKEqMEAVw03rXNCyOIwe
 tiBGIwjozN+bvUQk7CIZHQAH4BefS7o=
X-Google-Smtp-Source: AGHT+IFujjUMtRkidsiSlAZX8v29R9gn+9Snc3FHaN4CxP0BTy2RcMlSIkI5GtMo/C7iNWm4yNy9tg==
X-Received: by 2002:a05:600c:1d0c:b0:434:ff25:19a0 with SMTP id
 5b1f17b1804b1-436e2706f7emr92076505e9.21.1736524944309; 
 Fri, 10 Jan 2025 08:02:24 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f62sm55756165e9.22.2025.01.10.08.02.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/9] hw/arm/stellaris: Replace magic numbers by definitions
Date: Fri, 10 Jan 2025 17:01:59 +0100
Message-ID: <20250110160204.74997-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Add definitions for the number of controllers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 254f7a234bf..b4c3412c490 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -49,6 +49,11 @@
 #define NUM_IRQ_LINES 64
 #define NUM_PRIO_BITS 3
 
+#define NUM_GPIO    7
+#define NUM_UART    4
+#define NUM_GPTM    4
+#define NUM_I2C     2
+
 typedef const struct {
     const char *name;
     uint32_t did0;
@@ -989,12 +994,12 @@ static const stellaris_board_info stellaris_boards[] = {
 
 static void stellaris_init(MachineState *ms, stellaris_board_info *board)
 {
-    static const int uart_irq[] = {5, 6, 33, 34};
-    static const int timer_irq[] = {19, 21, 23, 35};
-    static const uint32_t gpio_addr[7] =
+    static const int uart_irq[NUM_UART] = {5, 6, 33, 34};
+    static const int timer_irq[NUM_GPTM] = {19, 21, 23, 35};
+    static const uint32_t gpio_addr[NUM_GPIO] =
       { 0x40004000, 0x40005000, 0x40006000, 0x40007000,
         0x40024000, 0x40025000, 0x40026000};
-    static const int gpio_irq[7] = {0, 1, 2, 3, 4, 30, 31};
+    static const int gpio_irq[NUM_GPIO] = {0, 1, 2, 3, 4, 30, 31};
 
     /* Memory map of SoC devices, from
      * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
@@ -1030,9 +1035,9 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      */
 
     Object *soc_container;
-    DeviceState *gpio_dev[7], *nvic;
-    qemu_irq gpio_in[7][8];
-    qemu_irq gpio_out[7][8];
+    DeviceState *gpio_dev[NUM_GPIO], *nvic;
+    qemu_irq gpio_in[NUM_GPIO][8];
+    qemu_irq gpio_out[NUM_GPIO][8];
     qemu_irq adc;
     int sram_size;
     int flash_size;
@@ -1123,7 +1128,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     } else {
         adc = NULL;
     }
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < NUM_GPTM; i++) {
         if (board->dc2 & (0x10000 << i)) {
             SysBusDevice *sbd;
 
@@ -1157,7 +1162,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
 
 
-    for (i = 0; i < 7; i++) {
+    for (i = 0; i < NUM_GPIO; i++) {
         if (board->dc4 & (1 << i)) {
             gpio_dev[i] = sysbus_create_simple("pl061_luminary", gpio_addr[i],
                                                qdev_get_gpio_in(nvic,
@@ -1178,7 +1183,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         }
     }
 
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < NUM_UART; i++) {
         if (board->dc2 & (1 << i)) {
             SysBusDevice *sbd;
 
-- 
2.47.1


