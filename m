Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0707AE6FE2F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbDA-00088c-Ur; Fri, 06 Sep 2024 11:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbD8-000880-Kf
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:22 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbD6-0008Aa-SK
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so2347984a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637759; x=1726242559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub8tZ79/fRaGRCH8Xhob5KBKMKk2ELdx+VDpRNkwtNw=;
 b=vI8mI/FNZEN7vNeyqLFQo5ITlF1dolcsFGJgd7T6c7ZJpn3YeESjM17iGFLK/XL402
 jgLLyBApU2EoTji5gifvH9FYvcrLUzBmQx6dRgMyxEXR7C7DfbI51+0Jx2EexgNgvE0y
 vSsMRiYBSybV8ARwHE9DBVelhF00ZFYWc99ZO2E2wU2QrmDAqPvRfJbgiPxUtqYV0uJd
 AzX/KwtAChBs6tTY1HlzvLQwhODl2kvdLHHaj6r1+l2+DdhU995Fsud730/veAux+auG
 hsR5aCwSLUITf/neJhveItjJDeodNzM8XkCpnK1+mp1WTuZkNYdLIJF76h9q7dJs0Gv7
 /d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637759; x=1726242559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub8tZ79/fRaGRCH8Xhob5KBKMKk2ELdx+VDpRNkwtNw=;
 b=NiX+mBpRE9wBujqyhooHRFpQwpmfmhunJ8ZT0OHO/lOErdjUZ4DjSeI1QnB+V9GkaH
 01O4240dj8FPIchTolLGIR9bUtzI7Tbn4arZEXQbVa7b4pv3viaopW7j6/ZBtU6/4YUb
 6KnmE8VkTpbdHaPjy+kPFKyvXFMrIhUf+PMAmtNG3AyStytojA7uI50UkF0wg1ikULsK
 bk9BjkV83f6oDDE+XA8I/fSjVBMF+lYA/UqdXGMALqb9PKq0BvAXwHbUdPKJR2oMiMXF
 LYbKodFom6g2x7/sfHzkcBagAXWBeCbvNDOVjcd/TWDV233XYOyi0p5dj39d+wJj0THg
 4dSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5fUYCA2jaDWu+mkMouIHBGJBCa2isvNgiPpjO45O1PduJFgf0EMwpg7O6ZJTqwQ2bzyJTxznXFecW@nongnu.org
X-Gm-Message-State: AOJu0YwQZt5nAZgOi8ufx/dHSPNeW4G92+YtcOpBB9p7dXjUDcSnDA4w
 7VMD2o1ameft0ZXKC3HHhr1SX7NArZf+125/otfo3EeI0dHsmAJbp7WtlT/9UbQ=
X-Google-Smtp-Source: AGHT+IF4eGPfOBxwsUAKqlT46HgHb7uaSlU6vBDPuV3cz03+JF21Ql9B6TLmNjRhk4uM7WCG3oLxMA==
X-Received: by 2002:a05:6402:348d:b0:5c2:4740:939d with SMTP id
 4fb4d7f45d1cf-5c3dc7baf09mr2029890a12.26.1725637759197; 
 Fri, 06 Sep 2024 08:49:19 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc529241sm2571799a12.11.2024.09.06.08.49.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 1/5] hw/sensor/tmp105: Coding style fixes
Date: Fri,  6 Sep 2024 17:49:07 +0200
Message-ID: <20240906154911.86803-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
References: <20240906154911.86803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

Coding style asks for no space between variable and "++". The next patch
in this series will change one of those assignments. Instead of changing
just one with that patch, change all of them for consistency.

While at it, also fix other coding style problems reported by checkpatch.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index a8730d0b7f..ad97c9684c 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -29,16 +29,17 @@
 
 static void tmp105_interrupt_update(TMP105State *s)
 {
-    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));	/* POL */
+    qemu_set_irq(s->pin, s->alarm ^ ((~s->config >> 2) & 1));   /* POL */
 }
 
 static void tmp105_alarm_update(TMP105State *s)
 {
-    if ((s->config >> 0) & 1) {					/* SD */
-        if ((s->config >> 7) & 1)				/* OS */
-            s->config &= ~(1 << 7);				/* OS */
-        else
+    if ((s->config >> 0) & 1) {                                 /* SD */
+        if ((s->config >> 7) & 1) {                             /* OS */
+            s->config &= ~(1 << 7);                             /* OS */
+        } else {
             return;
+        }
     }
 
     if (s->config >> 1 & 1) {
@@ -89,7 +90,8 @@ static void tmp105_get_temperature(Object *obj, Visitor *v, const char *name,
     visit_type_int(v, name, &value, errp);
 }
 
-/* Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
+/*
+ * Units are 0.001 centigrades relative to 0 C.  s->temperature is 8.8
  * fixed point, so units are 1/256 centigrades.  A simple ratio will do.
  */
 static void tmp105_set_temperature(Object *obj, Visitor *v, const char *name,
@@ -118,30 +120,30 @@ static void tmp105_read(TMP105State *s)
 {
     s->len = 0;
 
-    if ((s->config >> 1) & 1) {					/* TM */
+    if ((s->config >> 1) & 1) {                                 /* TM */
         s->alarm = 0;
         tmp105_interrupt_update(s);
     }
 
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
-        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 8);
-        s->buf[s->len ++] = (((uint16_t) s->temperature) >> 0) &
-                (0xf0 << ((~s->config >> 5) & 3));		/* R */
+        s->buf[s->len++] = (((uint16_t) s->temperature) >> 8);
+        s->buf[s->len++] = (((uint16_t) s->temperature) >> 0) &
+                (0xf0 << ((~s->config >> 5) & 3));              /* R */
         break;
 
     case TMP105_REG_CONFIG:
-        s->buf[s->len ++] = s->config;
+        s->buf[s->len++] = s->config;
         break;
 
     case TMP105_REG_T_LOW:
-        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 8;
-        s->buf[s->len ++] = ((uint16_t) s->limit[0]) >> 0;
+        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 8;
+        s->buf[s->len++] = ((uint16_t) s->limit[0]) >> 0;
         break;
 
     case TMP105_REG_T_HIGH:
-        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 8;
-        s->buf[s->len ++] = ((uint16_t) s->limit[1]) >> 0;
+        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 8;
+        s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 0;
         break;
     }
 }
@@ -153,18 +155,20 @@ static void tmp105_write(TMP105State *s)
         break;
 
     case TMP105_REG_CONFIG:
-        if (s->buf[0] & ~s->config & (1 << 0))			/* SD */
+        if (s->buf[0] & ~s->config & (1 << 0)) {                /* SD */
             printf("%s: TMP105 shutdown\n", __func__);
+        }
         s->config = s->buf[0];
-        s->faults = tmp105_faultq[(s->config >> 3) & 3];	/* F */
+        s->faults = tmp105_faultq[(s->config >> 3) & 3];        /* F */
         tmp105_alarm_update(s);
         break;
 
     case TMP105_REG_T_LOW:
     case TMP105_REG_T_HIGH:
-        if (s->len >= 3)
+        if (s->len >= 3) {
             s->limit[s->pointer & 1] = (int16_t)
                     ((((uint16_t) s->buf[0]) << 8) | s->buf[1]);
+        }
         tmp105_alarm_update(s);
         break;
     }
@@ -175,7 +179,7 @@ static uint8_t tmp105_rx(I2CSlave *i2c)
     TMP105State *s = TMP105(i2c);
 
     if (s->len < 2) {
-        return s->buf[s->len ++];
+        return s->buf[s->len++];
     } else {
         return 0xff;
     }
@@ -215,7 +219,7 @@ static int tmp105_post_load(void *opaque, int version_id)
 {
     TMP105State *s = opaque;
 
-    s->faults = tmp105_faultq[(s->config >> 3) & 3];		/* F */
+    s->faults = tmp105_faultq[(s->config >> 3) & 3];            /* F */
 
     tmp105_interrupt_update(s);
     return 0;
-- 
2.45.2


