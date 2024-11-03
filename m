Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E34FD110C1
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bgV-0000RB-5n; Sun, 03 Nov 2024 09:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgT-0000QJ-Tn; Sun, 03 Nov 2024 09:34:29 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7bgS-0001wO-7F; Sun, 03 Nov 2024 09:34:29 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso749538a12.1; 
 Sun, 03 Nov 2024 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730644466; x=1731249266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ok5RrePwcoqcntv1tD1k5HUzA8w6FObnxDW68eOz2w=;
 b=QmQSOl0L8YNP0ghvFZJB5mr77v78+ix8MYvGbhzcbNCEzruP484fM/C57KQtB/jtA1
 KN3dGuS6h0CCJSMRWMbgmaGddwsSDS/nEsnNwPGSN/926sr7Ly4LCFNi4GJrCRFMDGOR
 uIuPEydw0NnjE3ReCqCYr1/8ApygzRvK7yM5xAKupX8oBWcLuqXRZZZG++Vr+Y2gvOCC
 zyascx2/xojeXbFHIk7iwy4UdRpgBnZ6f4Yk2CcRRGnxsvjgsvJbp/5bA4j9NLqnGwhb
 tIjkfCDGR/ISo9JJgWFvaEVdmpINfdgXzo5dKyiVermYlLNlBN7dHN5k/ggro+bYOl+L
 zTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730644466; x=1731249266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ok5RrePwcoqcntv1tD1k5HUzA8w6FObnxDW68eOz2w=;
 b=MzZuNCSGazUoA5ZNIUTTiXRIXlJvyLbXF1kkyNPP64Y19a0w93iEWL7YLAztZWSOiR
 YvkpKgHpeHFtThSKcCqhPaXUvoYPX4yONmk4lL+IS95QUNfN5cGTu++pBOblseDpquQi
 JH2Taon4ZxWpNeSVX4DpjWNZThC82Hzm3FXzzseGYO4vz4eE3QqI4phhHcbdmyyAq4oC
 uQoYU7kGvdriyJ3cj2kfNfcf/lGUKxvON1l9Ur4EcluUOmItO95slh29CECha4ssYHHS
 xifKTeDFeAyqLlfJoMwk0e/Qmi1nu7VPy7SPyXtz4HCYkIIkTxtSJf7vlXjjJLXjLPqv
 dylA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz36IFtwnn1r7Y7cDYCaZWhIZ0u/pANz70+nsamOQApA6JqYBtnD+rMJpURLY3Plqsb5XtdEMAXg==@nongnu.org,
 AJvYcCWf823TqrK+LI0DSnQgYdCQofzpHgwpeL95UrKDuIjYPmthtw1vFlEOBFwiZyNWRb+xad2IiXlJ536imNly@nongnu.org
X-Gm-Message-State: AOJu0YySgRYmpZLwKlTUmEqTBazjTGZgYkw84HyfEFW4fWHbrfHX7vbl
 7A1IITR0YEHr4D2ygsipmVVRsLQhoaGq9cks4z0L83uJgQrKelwAIyS3uQ==
X-Google-Smtp-Source: AGHT+IHm93T2Q+yVmgtClOQVntD7nTrIm0Aiw3sK7UeavoHFd/lAJRizH0EO5/KXwkG4KA43qDQ1ig==
X-Received: by 2002:a05:6402:1c8e:b0:5ce:d264:a2fe with SMTP id
 4fb4d7f45d1cf-5ced264a322mr1549547a12.4.1730644465805; 
 Sun, 03 Nov 2024 06:34:25 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac74c667sm3350723a12.20.2024.11.03.06.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 06:34:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/4] hw/timer/imx_gpt: Convert DPRINTF to trace events
Date: Sun,  3 Nov 2024 15:33:28 +0100
Message-ID: <20241103143330.123596-3-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103143330.123596-1-shentey@gmail.com>
References: <20241103143330.123596-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/timer/imx_gpt.c    | 18 +++++-------------
 hw/timer/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 23b3d79bdb..2663a9d9ef 100644
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
index f48a712801..5cfc369fba 100644
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
2.47.0


