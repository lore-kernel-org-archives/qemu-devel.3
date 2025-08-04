Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F03FC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwgs-00028V-Sp; Mon, 04 Aug 2025 11:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKz-0000rM-Km
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivKw-00008Q-N2
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:34:49 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b782cca9a0so2470736f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314484; x=1754919284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WtdHwUd8/n4K5YgHaAzZsrPouzhCc7s7XT6kmarPt8=;
 b=mfa2tYz90uVCw3a72qmD8y0oWIMnQPUwJKCT2SyTdF50nhESunjucdnnMaG0+EJf6W
 R+KNGGKy+IrBBNOdgpEsy0vNiTbKuFZ9F1bv9EqL3mtE+j1p2oxmE/oYaFIgHQFULzi7
 ck+pW9rPDI8EHGMckhaXnwPnKJs2l1zzerdiu0Us+4hLeGt9UAMm66PCtftqRbyu7HAf
 DZRJ937LhSuJ7PcqhWOAQBrahwIz9KJgCqUC5YH+idcycvx2M7KPICeP+cGjUacQ1+3R
 y9nYpDLcSE2swMZaL6vcy4c4t6iygbD+n8nsdmk9qHeY0AbmdHf01/pU4x1Ndvf5jwvb
 rRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314484; x=1754919284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WtdHwUd8/n4K5YgHaAzZsrPouzhCc7s7XT6kmarPt8=;
 b=X5t7QdRuPcmIfGOMXxw4l5V4SKXbZZHS5PB72wxkt1SjgcIYhVkCFMExXjlONx7spr
 DJxEXc0JK9igC8Mo7cRZ5YMTHBOM7W0g4yrw/1xZ/P8E14zzPFHvjQwrEnlv73uam+GB
 4TsYuH3aVMFWVO37w9kqHgQIW4fMOnh8XogOpA2bV99TWrlRmwXsc6t69Fk36T0aAAmF
 wsyOoaJ3M26pQaczxBKg1JX8Qo7Zjc/uzPQdnUPWxWQJd5HhJ+Neb1TkHOD6Yh/Q+4Aq
 2enQO9nAQfc1ND2ikxOhex79O3oBVmwqpGK9JGfpdJV3LP23WgMJ9CTzDOpWyofL8Fi7
 Achw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCWVg8LQZpttI8Z2Hqs7f+GilQ/ioiruEiVc5OpAmh8/Y9/E1ZrpaenS0EDm0FY/VA7X6DRG6Vnm2s@nongnu.org
X-Gm-Message-State: AOJu0Yz7cIWg1zf+GJlOenVrJvhYLVCLGbku5wlAYHjEX02nHAhuoC76
 XDzBaiWIt9cl55/oXuuPAwlP2bWLVWQO8Esra6dcpGwEK8mnEeiXTHi+BB34vwSlBOA=
X-Gm-Gg: ASbGnctR5L5dx5nxDauz14dNN8sL40FZX9ZTMvhDQoT/in3CpGLKibPyuo6AkAU80ax
 OgasvCs6dEBQu3uRLavjI+tdIEIoyOnUFt34ZvAAsc5QlBhc3sb6jWfo0DiUX6jFR9ajiUskJzY
 KIs6Tkh1Mm5vhIavUUiyWrY9GaLPxGfpjWcIr22sYL9g3HE8DBp5uQE6OsNSjsPiojoUjKEBgV7
 LLgHZzUgOVL6Cptg+aRWhdRrT5oqrYjJnsRkdaJDXzIbYPYkcXxGMOHu5yJ+/WFl0v7t11EVIuI
 zqi93s99SmkQm6lymY2rjhl727agG0NBR5asyVcY/KnQdRKoebpDfZ28E85oYMLtFrSAI1QLiJP
 UCRuEgAh4R8Ju0Bh2iG7iQgHoXvAqIJvuPZFhbebaN/uppLu18pyJWCNi0uvPAS1pkv69Og+Bgs
 9jrAXzBmw=
X-Google-Smtp-Source: AGHT+IE7qGoOMREcolZT+b5z8oOJEXZ+ULPFeJUzvhUlbvrwHIlImWuNOVp/7/tR+H+SHpXvM4Bs1w==
X-Received: by 2002:a05:6000:2902:b0:3b7:895c:1562 with SMTP id
 ffacd0b85a97d-3b8d94649f4mr8060629f8f.11.1754314483968; 
 Mon, 04 Aug 2025 06:34:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c47ca5fsm15355970f8f.63.2025.08.04.06.34.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:34:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH-for-10.1 v2 07/11] hw/sd/sdcard: Allow using SWITCH_FUNCTION
 in more SPI states
Date: Mon,  4 Aug 2025 15:34:01 +0200
Message-ID: <20250804133406.17456-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

In SPI mode, SWITCH_FUNCTION is valid in all mode
(except the IDLE one).

Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index df2a272c6a2..a9efa158594 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1488,8 +1488,14 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     if (sd->mode != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
+    if (sd_is_spi(sd)) {
+        if (sd->state == sd_idle_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+    } else {
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
     }
 
     sd_function_switch(sd, req.arg);
-- 
2.49.0


