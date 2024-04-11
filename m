Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A93BCD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurUK-0005JV-1d; Thu, 11 Apr 2024 06:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTp-00058u-5a
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:31 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rurTg-0007UT-1O
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:16:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34665dd7744so1303453f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712830577; x=1713435377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MCcGHhKA7wPhoBY3l6p9Olu+doueLftUh6GAPbrfFo=;
 b=OSb52WSY0B2mZTlTPa51sMidfmq+eaI6IArXxnW6ZQBxwoqvhQP5jryhgCXSXQc8PL
 p/lBeOKhVGgbQRll8N0Fb3EiunFeqMiXsOnxGrIkeyDGji2xjyc6oAQ/CGJJ5eRCADNA
 u2XxT1q4+lFAx68Hfp5tQ4MqgwvRjh1OIVGiRXVAXc5xzs6xyw1IJBaBiQ8h3zlvjlSw
 L6hJr3dwWdIHfs4/GTloxSeJS/LWOkTIjadIxUtAhQvHpjfGSSiT1rMAVe7Eu1lxs4uS
 07wGXhtecaogZBZkVFridO2JiUWf0KYI+EXexT/CcUytBuqttjzDuVntNEXCY6nAiFQ5
 7a6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712830577; x=1713435377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MCcGHhKA7wPhoBY3l6p9Olu+doueLftUh6GAPbrfFo=;
 b=CW8L/GFP99C/gWgff8wOX5SNkYfoMIaJroOJVHNkeCosRxDGJ6jsxKVJlrS+ndlXkV
 7zer7J5FmxTl/rb+9fbkWweeoQOWSuMcikgCOdEx6qCWssrhW0yBCrjCKEoSMzjy8po4
 aIQQMndp9Kd4ThIevojyE2ii8b2JsayR/pbb3tR1VsZFPTXjZmI6dHOLsXd+uEb+cJbs
 SSNGa/HKVqB6peVlXI/3yT1zQbHOQPEicCng61434fFcXbvM5ZRMZe16cWM1AVr4HHNs
 p7hHG86vAXjFe3BpIYNkXYXZ8JYgE/gaLN5WG6sJpPmLhLPnpujwAC7HsnGTzvmExDkh
 UACQ==
X-Gm-Message-State: AOJu0YwwIPQsOi2874+4V3TjT/a38LP3PYs3FjcSLYHRX+KsUo/dIPzl
 TnIUZ9DSTS/0zT02pknOHj+2GiuJqcu+indGDX1JxemwbSOFM1usFi4YuWNBHKu7M8BgQnpJoMl
 zrEE=
X-Google-Smtp-Source: AGHT+IE1XZFffVamGkaISdsLeS03pdk/2Hl5TfVLkxg2EG/LL60TBqhAjliiXh4ShbVrYS0mBCau6A==
X-Received: by 2002:adf:e702:0:b0:346:305c:d34a with SMTP id
 c2-20020adfe702000000b00346305cd34amr3676036wrm.20.1712830577088; 
 Thu, 11 Apr 2024 03:16:17 -0700 (PDT)
Received: from localhost.localdomain
 (137.red-88-29-174.dynamicip.rima-tde.net. [88.29.174.137])
 by smtp.gmail.com with ESMTPSA id
 dl5-20020a0560000b8500b00345fb949c28sm1404822wrb.100.2024.04.11.03.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Apr 2024 03:16:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 04/13] hw/mips/malta: Add re-usable rng_seed_hex_new()
 method
Date: Thu, 11 Apr 2024 12:15:40 +0200
Message-ID: <20240411101550.99392-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240411101550.99392-1-philmd@linaro.org>
References: <20240411101550.99392-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Extract common code from reinitialize_rng_seed() and
load_kernel() to rng_seed_hex_new().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index af74008c82..9fc6a7d313 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -850,15 +850,24 @@ static void G_GNUC_PRINTF(3, 4) prom_set(uint32_t *prom_buf, int index,
     va_end(ap);
 }
 
-static void reinitialize_rng_seed(void *opaque)
+static char *rng_seed_hex_new(void)
 {
-    char *rng_seed_hex = opaque;
     uint8_t rng_seed[32];
+    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
 
     qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
     for (size_t i = 0; i < sizeof(rng_seed); ++i) {
         sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
     }
+
+    return g_strdup(rng_seed_hex);
+}
+
+static void reinitialize_rng_seed(void *opaque)
+{
+    g_autofree char *rng_seed_hex = rng_seed_hex_new();
+
+    strcpy(opaque, rng_seed_hex);
 }
 
 /* Kernel */
@@ -870,8 +879,7 @@ static uint64_t load_kernel(void)
     uint32_t *prom_buf;
     long prom_size;
     int prom_index = 0;
-    uint8_t rng_seed[32];
-    char rng_seed_hex[sizeof(rng_seed) * 2 + 1];
+    g_autofree char *rng_seed_hex = rng_seed_hex_new();
     size_t rng_seed_prom_offset;
 
     kernel_size = load_elf(loaderparams.kernel_filename, NULL,
@@ -946,10 +954,6 @@ static uint64_t load_kernel(void)
     prom_set(prom_buf, prom_index++, "modetty0");
     prom_set(prom_buf, prom_index++, "38400n8r");
 
-    qemu_guest_getrandom_nofail(rng_seed, sizeof(rng_seed));
-    for (size_t i = 0; i < sizeof(rng_seed); ++i) {
-        sprintf(rng_seed_hex + i * 2, "%02x", rng_seed[i]);
-    }
     prom_set(prom_buf, prom_index++, "rngseed");
     rng_seed_prom_offset = prom_index * ENVP_ENTRY_SIZE +
                            sizeof(uint32_t) * ENVP_NB_ENTRIES;
-- 
2.41.0


