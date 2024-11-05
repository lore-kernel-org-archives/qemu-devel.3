Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0ACD1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Hbb-0004hW-Kh; Tue, 05 Nov 2024 06:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbW-0004bw-1e
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:10 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbI-00078V-E8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:09 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso6096714e87.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805593; x=1731410393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ciRtNVI6sFcbqWWtUz/mMIIqmwEx3shGcliHftq7lkk=;
 b=Ut0k6Y10/ymhIpwto6+WUTGTyWxzI8Qc5CqsVefj5t78S9hX1WIAFlxlneQyJcWdlQ
 qh+9Vu2jG6g1x6Xs5oMzLf1xU1VHLU1624HlGp4qjkJeaEcZGh6NTQ9J+HWHfJZKNpg9
 QMhxkq+jxZmxVvHon9JKLqFwqbLo5RWeZuLN5/1ERkJAFCCRm9mO1nfu401sr59zstOe
 n1oozx8DEa/j5fcPSxxe9Ond66ohcJ8lT4muq3KAbsTOO80DBfiBJqVf1+rYzHpHRoBj
 R7sPgw5TWNWgpHiNZo4/kDIY0Yv0FTxtGDo9Zq74n9GlOlEmoM8uPGDwAA0pzm08igMA
 PDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805593; x=1731410393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciRtNVI6sFcbqWWtUz/mMIIqmwEx3shGcliHftq7lkk=;
 b=BlS/Ym+8Dtaxe30imaFhqPb+OVC55CK9MLFjTUXlFEpEGI7oml9UrpyGlG68flIzvK
 c7zE29db+6we4hOVyUbKUnk5MwjBi13PS93e3X0v+iDGlkz8FnaDTQrvv5gI8JyiOuca
 i42dbACYnqWMmzs/qu1gF7qn/4ge5Sa/w/ZMxgL/wnpTrEX56or7A93b6iuEbP/Sb2Hz
 k630rZR0eUosC5q3iup+tGIUw1rucDOg5AaulwM81J2/iNRRH1kdTZ+6kVW0trW01aPZ
 eaHPV6pgmLpdojbxRsxKvjaJ3//IcqMFHP6BmBGmZJYkbeNuDbS48mqPMxqFuqqpSNqu
 MLCg==
X-Gm-Message-State: AOJu0Yylq/9U3YzQRWMYgpVqVBDLWhF+GoI6WlyCq4CUNQ5K8Pb+FkB/
 +b/wwedIXetXf/XrGKDQbdGgYaoNkZzxyAqLoMP+LaC+D9MdzQrbkX9z3pf3Jm9+mlI/JdZau35
 Y
X-Google-Smtp-Source: AGHT+IGeljwmhzCIX3Kbq6AgMw+8NOyiXJJ6cflgxphH7sDAcixaSH/cdlrnaPIFgxIY+ZFjnIH/7Q==
X-Received: by 2002:a05:6512:2397:b0:539:9746:2d77 with SMTP id
 2adb3069b0e04-53b34c35fe0mr14791325e87.61.1730805593156; 
 Tue, 05 Nov 2024 03:19:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/31] hw/timer/imx_gpt: Convert DPRINTF to trace events
Date: Tue,  5 Nov 2024 11:19:31 +0000
Message-Id: <20241105111935.2747034-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20241103143330.123596-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/imx_gpt.c    | 18 +++++-------------
 hw/timer/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 23b3d79bdb8..2663a9d9ef4 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -18,19 +18,12 @@
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 #ifndef DEBUG_IMX_GPT
 #define DEBUG_IMX_GPT 0
 #endif
 
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_GPT) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_GPT, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
-
 static const char *imx_gpt_reg_name(uint32_t reg)
 {
     switch (reg) {
@@ -145,7 +138,7 @@ static void imx_gpt_set_freq(IMXGPTState *s)
     s->freq = imx_ccm_get_clock_frequency(s->ccm,
                                           s->clocks[clksrc]) / (1 + s->pr);
 
-    DPRINTF("Setting clksrc %d to frequency %d\n", clksrc, s->freq);
+    trace_imx_gpt_set_freq(clksrc, s->freq);
 
     if (s->freq) {
         ptimer_set_freq(s->timer, s->freq);
@@ -317,7 +310,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    DPRINTF("(%s) = 0x%08x\n", imx_gpt_reg_name(offset >> 2), reg_value);
+    trace_imx_gpt_read(imx_gpt_reg_name(offset >> 2), reg_value);
 
     return reg_value;
 }
@@ -384,8 +377,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
     IMXGPTState *s = IMX_GPT(opaque);
     uint32_t oldreg;
 
-    DPRINTF("(%s, value = 0x%08x)\n", imx_gpt_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx_gpt_write(imx_gpt_reg_name(offset >> 2), (uint32_t)value);
 
     switch (offset >> 2) {
     case 0:
@@ -485,7 +477,7 @@ static void imx_gpt_timeout(void *opaque)
 {
     IMXGPTState *s = IMX_GPT(opaque);
 
-    DPRINTF("\n");
+    trace_imx_gpt_timeout();
 
     s->sr |= s->next_int;
     s->next_int = 0;
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index f48a712801e..5cfc369fba4 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -49,6 +49,12 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# imx_gpt.c
+imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %u to %u Hz"
+imx_gpt_read(const char *name, uint64_t value) "%s -> 0x%08" PRIx64
+imx_gpt_write(const char *name, uint64_t value) "%s <- 0x%08" PRIx64
+imx_gpt_timeout(void) ""
+
 # npcm7xx_timer.c
 npcm7xx_timer_read(const char *id, uint64_t offset, uint64_t value) " %s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
 npcm7xx_timer_write(const char *id, uint64_t offset, uint64_t value) "%s offset: 0x%04" PRIx64 " value 0x%08" PRIx64
-- 
2.34.1


