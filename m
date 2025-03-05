Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA8CC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdX3-0007kd-Qc; Tue, 04 Mar 2025 20:26:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdV5-00047S-Sp
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:47 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdV3-0007HI-Qw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:43 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390cf7458f5so5799657f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137880; x=1741742680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSWq8OG1UJ3+TSUQoJxemZJrVqGEUCcwykT7a0JIQRg=;
 b=WFxCohIRaRdVAQHNJBEeEMHs8j2N1qAySc2y1z9aOAstpHGcQZtL3Ju+B/gQ+NRYLr
 GEh5dttlhtSX+jV2hA6j+B9s8U3hv28+jyNU9DIJlctiOJxchbRkwWGuSneZNcVuikij
 hJ9ih8lvYtKUJtibiwCg2avBYctzfJ2ssZfGrnxQpEP71Jxd0gIoPGigJl2Bvk7O44zJ
 3QoWSmhWksqGsaiSm8+IPfaeakaG7EMdi/prGEouDUqF9UnqWJMzxkAtBtHcZtVRhdRQ
 W4D9KAHLd6hHtkS8BtQi2m0OBZv0iI5Y5a49mO4B55zUIzHG3sKhyRLL3LMmaWwDdpEg
 Zx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137880; x=1741742680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSWq8OG1UJ3+TSUQoJxemZJrVqGEUCcwykT7a0JIQRg=;
 b=CdTXGn4FUdaWsPSkNyWyt5UKDFWWWCzqTrdsN59eDsG5Uh8aVrt1mNHhEfnUEzfYIg
 J7w59huGS962/TvffIMJGe5JbN7c7WedxdCKOxikSG2NBfSfU3VyTHA02R1bKNkMWJTg
 HgzYbYIH9QZ+AVAzm4LHy7Fyyoh79ZHiX3pRRom6ZH18wOmhSn31dYH8UGSKYsxNkpSz
 n9TONh7FFCiJuofSIQq6vw0PdABFUc0dZjVgo36mYlR9JfHrrkGG6n5n5qkmM6L176X3
 dFV4iaKcCoUO4I/rwFAepsU+letV5zIJP+2YbO6suKc9IL7im5PWG8sn60Ctz4YFbZi3
 nFxg==
X-Gm-Message-State: AOJu0Yx/lfLozwPS/KV7WqpPBQr8TN0ipy45nlS2jaXaLCH0t42J9ih1
 XqIm+eZSYiwnqADyoRK8U4KF4O6stjWZCAOosNstasN4nnEtrrjkwKDE7BHI4mCXeifztvcG8N6
 RMYk=
X-Gm-Gg: ASbGnctbIuExWCa0EDWLuxyzJ704zHNJ0v2f4H8gTbRbIauhhRmmuAbmBavdXd/TtCR
 Uji+/v1B9aSsnka/zSj4+Vc4zHFnED+xngZYYuw6RK1Nh9eDHhqrBJR/MNiUt7s/aa8aAFwQsIc
 4YLede25j132zSH8CpueJmv+LmjkNkoe9Pvij8MRYXkZGXIiceP4YnZtghzEUVXLXXv4x8p8oQ5
 LQtNP+KWXlleTSjjnhuP+ldaRkmOIy/6leqY9FKm7gb7m/HqqSwa8V8Ux1t05w1pRwZ9f8tWjgw
 gDMtZrWlpOnBZl15lduky88x+1BZmGOAZHN3oUtdgYoelqqjb6rg2Hu46d2TUjy8b17ib4rQo2Q
 MXX6dKi7UXkiEW59vCmI=
X-Google-Smtp-Source: AGHT+IFBGJZqSVCmDqv59QnAKo6/f3VyL+ZmoFRmoxKd1kQoPqqYdDRJilPCcFXmWJSxHVhZ6OJhwA==
X-Received: by 2002:a05:6000:401f:b0:391:4f9:a048 with SMTP id
 ffacd0b85a97d-3911f724a16mr570929f8f.4.1741137879989; 
 Tue, 04 Mar 2025 17:24:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292144sm2027895e9.13.2025.03.04.17.24.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/41] hw/arm/omap1: Convert raw printfs to qemu_log_mask()
Date: Wed,  5 Mar 2025 02:21:48 +0100
Message-ID: <20250305012157.96463-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

omap1.c is very old code, and it contains numerous calls direct to
printf() for various error and information cases.

In this commit, convert the printf() calls that are for either guest
error or unimplemented functionality to qemu_log_mask() calls.

This leaves the printf() calls that are informative or which are
ifdeffed-out debug statements untouched.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250227170117.1726895-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


