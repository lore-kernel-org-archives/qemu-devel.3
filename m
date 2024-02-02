Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE19C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb6-0000Nj-Fl; Fri, 02 Feb 2024 10:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb3-0000L0-Bn
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:53 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb1-0004Vb-0k
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:52 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40ef64d8955so19935335e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888209; x=1707493009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0ckJcvEZZioCWfSyoKKpMeIjUpIBSh7xStPy/wW7duI=;
 b=K3/xOFgS7m2TX0kCCBQJ7EAfKIRUl6oZRxlCwIGps9nW34w6pWBvLl2euAj6ZPmSU3
 ZPh6iLC7Ku383Jqs0BUdjTcIyjTspDaR2XOWERrP088pvTG+C8gGJ/2H6ZfxLgQ//1av
 lg/ENYj57fZdsqZujToAiEVsIkEu9JWrvTi2CkOR28unJUT92/i+ywBCs+/89DjFHaSn
 4IEODlZX3QdkwqV03ukbhalfYRUQ5R7+GRX+ojVQ3YII+EeQT/eQ0XiiWwdW20kNypdu
 J4wu+UADBc83cAYFHb3x6LQMLZO7rYtSZrKDjvPEE6CXB0QfW+NMXdY/so4KRZjLAqgN
 UbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888209; x=1707493009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ckJcvEZZioCWfSyoKKpMeIjUpIBSh7xStPy/wW7duI=;
 b=hoNzaokKff51zXcVDu0qh2eKbgj3dxIr6/Rd1thx2TT7zzvLFJYuW+tZvlKOcjDy1g
 RhZ4ovXYqqKELPA2tp0eZdsBllErZ3ZUmd5hWGlqxeBoINn8wSOXawwdzSbf2+LrHrbi
 bcUgkuSWTNhfazUiv/4AUMtRzRf1upPUXNAO1DGTqfU9sfADRxyj5nsXZHORgHDXi5vH
 XUQ9UN3tKatBeFEzFStxF42aCK7VpvK0lXJ2V/tg7lpTDf/Lmmr8gQsHoCsp00yfur2e
 QhuN7nVggDo6YMGgILBYLL1q3FinRuABMYxK8O67J96Bz/MDmR9kKMrmg7wfIrKgpnTy
 MF1Q==
X-Gm-Message-State: AOJu0Yw5ogFTsu7W1efwhOerHIcks0IWbf2kHxrfP094KZQ/RQJjO0e4
 vQl1rhC/S8DYAb6TwEsBMJA5gspfrQj1e8TeKNiIlkp3gN55tD8RjD3b1WSblCyCeaIa+vHghJL
 Z
X-Google-Smtp-Source: AGHT+IEve3ErRb438/blgbLsuASqlGGbOAddwHvvWzX/ZxMXR2sOXKvI2DfFGfwVMUOFE8xGUn+Emw==
X-Received: by 2002:a05:600c:3107:b0:40f:86:fea with SMTP id
 g7-20020a05600c310700b0040f00860feamr6376123wmo.13.1706888209632; 
 Fri, 02 Feb 2024 07:36:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/36] hw/arm/z2: convert DPRINTF to trace events and guest
 errors
Date: Fri,  2 Feb 2024 15:36:25 +0000
Message-Id: <20240202153637.3710444-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. DPRINTFs that report guest errors are logged with
LOG_GUEST_ERROR.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 799c5141c5751cf2341e1d095349612e046424a8.1706544115.git.manos.pitsidianakis@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/z2.c         | 27 ++++++++-------------------
 hw/arm/trace-events |  7 +++++++
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index a67fba2cfd2..eb2ff8dbc84 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -27,13 +27,7 @@
 #include "exec/address-spaces.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-
-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
@@ -119,6 +113,8 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
 {
     ZipitLCD *z = ZIPIT_LCD(dev);
     uint16_t val;
+
+    trace_z2_lcd_reg_update(z->cur_reg, z->buf[0], z->buf[1], z->buf[2], value);
     if (z->selected) {
         z->buf[z->pos] = value & 0xff;
         z->pos++;
@@ -126,22 +122,19 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
     if (z->pos == 3) {
         switch (z->buf[0]) {
         case 0x74:
-            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
             z->cur_reg = z->buf[2];
             break;
         case 0x76:
             val = z->buf[1] << 8 | z->buf[2];
-            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
             if (z->cur_reg == 0x22 && val == 0x0000) {
                 z->enabled = 1;
-                printf("%s: LCD enabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("enabled");
             } else if (z->cur_reg == 0x10 && val == 0x0000) {
                 z->enabled = 0;
-                printf("%s: LCD disabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("disabled");
             }
             break;
         default:
-            DPRINTF("%s: unknown command!\n", __func__);
             break;
         }
         z->pos = 0;
@@ -211,14 +204,12 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
 
     s->buf[s->len] = data;
     if (s->len++ > 2) {
-        DPRINTF("%s: message too long (%i bytes)\n",
-            __func__, s->len);
+        trace_z2_aer915_send_too_long(s->len);
         return 1;
     }
 
     if (s->len == 2) {
-        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
-                s->buf[0], s->buf[1]);
+        trace_z2_aer915_send(s->buf[0], s->buf[1]);
     }
 
     return 0;
@@ -228,14 +219,12 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event event)
 {
     AER915State *s = AER915(i2c);
 
+    trace_z2_aer915_event(s->len, event);
     switch (event) {
     case I2C_START_SEND:
         s->len = 0;
         break;
     case I2C_START_RECV:
-        if (s->len != 1) {
-            DPRINTF("%s: short message!?\n", __func__);
-        }
         break;
     case I2C_FINISH:
         break;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7c569432150..0ff41e6c780 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -58,3 +58,10 @@ smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
+
+# z2.c
+z2_lcd_reg_update(uint8_t cur, uint8_t i_0, uint8_t i_1, uint8_t i_2, uint32_t value) "cur_reg = 0x%x, buf = [0x%x, 0x%x, 0x%x], value = 0x%x"
+z2_lcd_enable_disable_result(const char *result) "LCD %s"
+z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
+z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
+z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
-- 
2.34.1


