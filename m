Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1544EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodh5-0003xL-U7; Thu, 12 Sep 2024 02:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodh3-0003rw-Oy
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodh1-0003Ow-SW
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:52:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so4614775e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123958; x=1726728758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=930EOxitUPSbWDmKCRCTZhjU+xHgrO7ejJVauC14yVw=;
 b=NOxrXpFgxqcO2+LzMprcOOts1kj2pJwsJRrp9QdOOGq8rBHE9FMbfwBSMeX/HQ7EIk
 HdD40ILENyvmHpS8FCwMr5MN46JG4Bt2ZaxPsJ1sCoOIegSKSyrp5dd7LGCoFvUCL5Lu
 e09yAuNgTc8VtwWn8Dl9WbQtR+O5bSgk9Li/SsHpubSl9J4O0syab/c+BIKLv8tG5qIC
 tpBUWAjnf4I+Ey2TKlMUCP1kuzafMcCgesG55ueSP6HIWr8GKJzx+ijGc/+zoPzJMLBA
 ZM6vr0q5aVzEJEvcjJ2Yi4HyD+/Dzhb+UxtVXLYhoXsPcK/C+u8kwSU8imBvdH6MhmoS
 kLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123958; x=1726728758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=930EOxitUPSbWDmKCRCTZhjU+xHgrO7ejJVauC14yVw=;
 b=CmbF1ZioOScJ4EFUbL2nhlev5ko2IENOc7VhWr7Z6u8ftutstLvGhtnnNSXv2DTlNN
 iFeCEA71uL/p0tjUzQsV9tkKJwCjd6p3L1p7n8AOZjMq3jps0Uq8I/AxZ45L0KJXyjlU
 q55v6HHHmMyYipBx3z8nMDh4efSPtIE+DzvfziNvTTuupTd7Xlqk9bJe5lvm6gj0kxFG
 zA2XdifyU/NnQ4ui65rmE2uM4w9hFk/rELoENWamhl/lALrV0bEAAQcKfVwLh1yGTii6
 mDGWGN8CbRy+e+02ToHUPIEjthyRJKqraZNsRRpadI/Zz3PKdG9P7ojDmmtBLKPPLzTg
 20OQ==
X-Gm-Message-State: AOJu0Yze5k3XOpbaL+cKk7by2xSD8GC0tINOWaEDpmUiv8kfRMvMvYE7
 mzd+rIa8butjzQs64oRmNf/OEpkURqmPTWQWPpfIBDcUiKHFihGS+n/001y/QrzlAoUN3O4sQPw
 I
X-Google-Smtp-Source: AGHT+IGlEsJl//RNO9vTLfGC+zCJkX2ckS27xeQhcxOJunfM7jABBGS3H3qEwUWbuwGRrVFLoYecWQ==
X-Received: by 2002:a05:600c:1c04:b0:42c:bd5a:9479 with SMTP id
 5b1f17b1804b1-42cdb54cf2amr14877375e9.18.1726123957154; 
 Wed, 11 Sep 2024 23:52:37 -0700 (PDT)
Received: from m1x-phil.lan (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675b7esm13427501f8f.50.2024.09.11.23.52.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 23:52:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 44/61] hw/sensor/tmp105: Coding style fixes
Date: Thu, 12 Sep 2024 08:52:15 +0200
Message-ID: <20240912065227.67848-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240912065227.67848-1-philmd@linaro.org>
References: <20240912065227.67848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Guenter Roeck <linux@roeck-us.net>

Coding style asks for no space between variable and "++". The next patch
in this series will change one of those assignments. Instead of changing
just one with that patch, change all of them for consistency.

While at it, also fix other coding style problems reported by checkpatch.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20240906154911.86803-2-philmd@linaro.org>
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


