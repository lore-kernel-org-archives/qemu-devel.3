Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B6FC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhGv-0005ai-3H; Thu, 27 Feb 2025 12:02:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGY-0005DB-4e
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnhGR-0002L4-5J
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:01:41 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4399d14334aso11614005e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740675682; x=1741280482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BMZ/a2nzPtLYyS89YoqeNcWEmY/c5UQ/LIwoP4jOOso=;
 b=EiZc/z0mqtIgvsJqQTvgu1Jvwut4ug6jSNciof7t/mqrVqg/M93UQEVULflWhHe2dV
 AbBrd8FKZzH4dh3u28CJP/YbfHHtvizihUwI/cKrLcAORBMcq+RFa1m/kg6YfMZdT42y
 Kf1uQsKWhUQSbDi+rn9R6MFtUfOW8jkd+OSZdj6RTNwRTbG41SQ2NwRVBuWzRC6kuUon
 9osPeTtyNMku5/WyhsZHwOlP5I7F7xrZ0cK+hqbZgFXYUoDDQhsrTHSHzptWYrdnyBLC
 ZeDtndY1ooAObYBHj04NcgGZ2G55Xki0vyoJpbcJrRFK7lQ+dtx5Vc2s4j7xKbss0k+h
 wQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740675682; x=1741280482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMZ/a2nzPtLYyS89YoqeNcWEmY/c5UQ/LIwoP4jOOso=;
 b=TPjHXMB+sMkuW731rVI4TAit/BaWheqHvnm/YkawoHpOLK8N6QvFT9kdqB8kzp44x0
 KgU4xaohi4cEpdKR4ErOo2TUdyjjfmItZjr74BEs+HmYSfVVugNbJUPUoSicZE23OMBf
 eSPFAchtqP6CLZuTCjlyaTdbuGH2WX8tSNWVsNxc7px/qKjELlXVbJOnz5SaQqaCsosJ
 OlBS/ydcW9tcAFCghegYIAKXR1FpQl9rdGVZv9JmbWBAkGWcbEYfd3MG9/aur4d+et2g
 5uM9YXGYgWL5Gq8HLKAjKJtjPSl20yrsa1YoIwWPXdcba6zTNUN+vu0kbYFmleTgk80r
 ZMug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJHJ0DX2Ky4442uBzuEVyTnU1nlYS2F1Pps4ZgHQL1/0CIXhM8qmBHjPIs4W/7crNl18TRM+C3crlu@nongnu.org
X-Gm-Message-State: AOJu0YzG/KtaaLyQhoOH+jT73ga3+Xti1wCsvuM6dnjmhZZg0SxJwobG
 anfEqQKsqUll3NWB2asifxqm7YLTL73YTMzo8ysIwt7DFh5hRw0zwj8TGXPhugw=
X-Gm-Gg: ASbGncsd2XxrmCLzckx0rA3+GqDDkCWnyy2422IhXxGO0I18mXFSYvVylBtAtd6E5QN
 0pHgkqsVGRF/bNylAsATR0EgV/Ef0IdvGfNRjU2UCCNt9u96TR+5LvCKXsLgSQP2D4qKg+NdSAf
 qS4B01gNvQNK+KpiECk+KNcdW8dkUzf0BrfWe8TwUOBkPh2RSS2t8MdmBT+fszPl2yRH0s88YFo
 IGaR8HjH7RXFN35gNz+djmrIArAtHIFZOGoqlCOnmNHX2IrhSNCuDGJPn0GgdVc3hyb2Tbx7adD
 ItwU3ktAl/5MXGV14GZzKXVkZ4UM+rgm
X-Google-Smtp-Source: AGHT+IEjUpmp7qH7xrFuzRLwifeW065y+rDLej9Muz6Spa3RsBHNeweZGN1eiaP+Jtm4F+Vqm7QsjA==
X-Received: by 2002:a05:600c:5487:b0:439:9494:318 with SMTP id
 5b1f17b1804b1-43ab8fd04dcmr63498175e9.1.1740675681665; 
 Thu, 27 Feb 2025 09:01:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5871f4sm62747565e9.39.2025.02.27.09.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:01:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/arm/omap1: Convert raw printfs to qemu_log_mask()
Date: Thu, 27 Feb 2025 17:01:13 +0000
Message-ID: <20250227170117.1726895-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227170117.1726895-1-peter.maydell@linaro.org>
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

omap1.c is very old code, and it contains numerous calls direct to
printf() for various error and information cases.

In this commit, convert the printf() calls that are for either guest
error or unimplemented functionality to qemu_log_mask() calls.

This leaves the printf() calls that are informative or which are
ifdeffed-out debug statements untouched.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index ca2eb0d1576..3c0ce5e0979 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -2559,8 +2559,9 @@ static void omap_rtc_interrupts_update(struct omap_rtc_s *s)
 static void omap_rtc_alarm_update(struct omap_rtc_s *s)
 {
     s->alarm_ti = mktimegm(&s->alarm_tm);
-    if (s->alarm_ti == -1)
-        printf("%s: conversion failed\n", __func__);
+    if (s->alarm_ti == -1) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: conversion failed\n", __func__);
+    }
 }
 
 static uint64_t omap_rtc_read(void *opaque, hwaddr addr, unsigned size)
@@ -3024,8 +3025,9 @@ static void omap_mcbsp_source_tick(void *opaque)
 
     if (!s->rx_rate)
         return;
-    if (s->rx_req)
-        printf("%s: Rx FIFO overrun\n", __func__);
+    if (s->rx_req) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Rx FIFO overrun\n", __func__);
+    }
 
     s->rx_req = s->rx_rate << bps[(s->rcr[0] >> 5) & 7];
 
@@ -3070,8 +3072,9 @@ static void omap_mcbsp_sink_tick(void *opaque)
 
     if (!s->tx_rate)
         return;
-    if (s->tx_req)
-        printf("%s: Tx FIFO underrun\n", __func__);
+    if (s->tx_req) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Tx FIFO underrun\n", __func__);
+    }
 
     s->tx_req = s->tx_rate << bps[(s->xcr[0] >> 5) & 7];
 
@@ -3173,7 +3176,7 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
         /* Fall through.  */
     case 0x02:	/* DRR1 */
         if (s->rx_req < 2) {
-            printf("%s: Rx FIFO underrun\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Rx FIFO underrun\n", __func__);
             omap_mcbsp_rx_done(s);
         } else {
             s->tx_req -= 2;
@@ -3278,8 +3281,9 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
             }
             if (s->tx_req < 2)
                 omap_mcbsp_tx_done(s);
-        } else
-            printf("%s: Tx FIFO overrun\n", __func__);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Tx FIFO overrun\n", __func__);
+        }
         return;
 
     case 0x08:	/* SPCR2 */
@@ -3293,8 +3297,11 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
     case 0x0a:	/* SPCR1 */
         s->spcr[0] &= 0x0006;
         s->spcr[0] |= 0xf8f9 & value;
-        if (value & (1 << 15))				/* DLB */
-            printf("%s: Digital Loopback mode enable attempt\n", __func__);
+        if (value & (1 << 15)) {                        /* DLB */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Digital Loopback mode enable attempt\n",
+                          __func__);
+        }
         if (~value & 1) {				/* RRST */
             s->spcr[0] &= ~6;
             s->rx_req = 0;
@@ -3325,13 +3332,19 @@ static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
         return;
     case 0x18:	/* MCR2 */
         s->mcr[1] = value & 0x03e3;
-        if (value & 3)					/* XMCM */
-            printf("%s: Tx channel selection mode enable attempt\n", __func__);
+        if (value & 3) {                                /* XMCM */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Tx channel selection mode enable attempt\n",
+                          __func__);
+        }
         return;
     case 0x1a:	/* MCR1 */
         s->mcr[0] = value & 0x03e1;
-        if (value & 1)					/* RMCM */
-            printf("%s: Rx channel selection mode enable attempt\n", __func__);
+        if (value & 1) {                                /* RMCM */
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Rx channel selection mode enable attempt\n",
+                          __func__);
+        }
         return;
     case 0x1c:	/* RCERA */
         s->rcer[0] = value & 0xffff;
@@ -3412,8 +3425,9 @@ static void omap_mcbsp_writew(void *opaque, hwaddr addr,
             }
             if (s->tx_req < 4)
                 omap_mcbsp_tx_done(s);
-        } else
-            printf("%s: Tx FIFO overrun\n", __func__);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Tx FIFO overrun\n", __func__);
+        }
         return;
     }
 
-- 
2.43.0


