Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D50C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj7V-0002Qu-7F; Tue, 28 Jan 2025 05:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj6E-0001B3-Ux
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:48 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj66-0003a2-Ck
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:42 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso40570275e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061131; x=1738665931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P84lmvWRoPuZSyE7d4+2LbnhWUe5f771b5Xano3sRNQ=;
 b=OQ3aaO2wabwlC+BpjNqzVUObLquPwFMMt1Pp53vcDoOjZJ75SvT4Q2ov2CzqDE2cm1
 mHS5miJyb0dfd+Yz3ITcs6DNSssPhO6SrbeDJ/zlxHuYMjVWcJDWB6qmxR0/8Rfx13z1
 1hLY74PKeqUEBFH833plgPMxvDGqVaKJdsSUa7keXQVvASzLpdEmOXmss/CdOPmaY/DH
 hb0yKcjaFeHONxyEUlgzA9Zrzq+kdF1Dhl/BtrNty9UH02RnlBCYiPLie1WlSdLmw7H7
 aiR989cnHWl3FQQwu3iVUq4Ku3mKHN7P1bFeQ8sdSoxiCdEC84uiTJ6YSLafnU4dLqA0
 6wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061131; x=1738665931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P84lmvWRoPuZSyE7d4+2LbnhWUe5f771b5Xano3sRNQ=;
 b=YZB+QQAgBIBCAilBlGAk0CxH4OGoc3hTL7ejo71R5lxuIXtfQYQXwbkeQQxWvt9YkZ
 RIpPyw/wixGFfdrjVc23xRlOpbJdlPILFh74gzsv+RZz/xgnXTWh3eyLkZ6pBJW3zyWP
 P/h5RChzLZNRhmC+RLGkRHRt4cPwcCAXm/qFe/G+X2CuScAzz+BfWEueBMi6jc0eOlJr
 V2QULR3PrPapvmI3N14kXXOIraFDE5oiJt6UODUQzZHfYSCfFcAcE0q5uajQc6KZ7xij
 Kd56cEEz4eJOt4pMLXc9+hUq+eNqls1vWBfhZnTKHKguW1SXMcJ3+dIX9FN99L0iemQ0
 0dPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXicfR5gwNACaKNBxO8BnuS4CbsWtkTgqWuYagR89kf0ZrMcq0xQiSxb5m+MtUhKypl0S3asNA0UyKt@nongnu.org
X-Gm-Message-State: AOJu0Yxe7I16MgGQdm3/QpDrCzQaPuuQ7jLMCwMoOmW7JSilew1mPosJ
 nI9w7ok8zJLeLM67uqgMvgVJG6S2f1X8hrq8eHOLMoIi2rS2GmtcWrUkLObqtPM=
X-Gm-Gg: ASbGncumxY3BX7fvGG2r8gzOxf/hVDtmOfrQv9KYuyGwj8LX2dlaJPaaCh3rG3JqXOj
 SBHl/qSuqJ8miiYHMKig64SI/Fjrf9wbvtj3RaYXSMU8uDTZ3oNtJKoh2cnyPjqPTSzdmNgvNxx
 t+DZADCjt1L9f4E2d4GV+CuBU8IhdH5l1GvZ7gIuiR9ql0O7lDsIAP1HT08AsxPdOrJLTbSnUD1
 jVTHltQ2UaCHzeOrUHODszbwnL2rHakeZURr/Fc4s/PP+uDVeE4rJ461jLc/n4OGWtb/KP7g9mj
 zdFtP8gJzKC6BtOip2XI
X-Google-Smtp-Source: AGHT+IFonOX6TnBpot7YarpaWUBW3BkQbxl0LzUrH82xtOvIOM4gdE1qr1Z/XplpzqqMgUOvIQBRcA==
X-Received: by 2002:adf:fb84:0:b0:385:e328:8908 with SMTP id
 ffacd0b85a97d-38c49a5d44dmr1754140f8f.29.1738061131513; 
 Tue, 28 Jan 2025 02:45:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 09/11] hw/sd: Remove unused 'enable' method from SDCardClass
Date: Tue, 28 Jan 2025 10:45:17 +0000
Message-Id: <20250128104519.3981448-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The SDCardClass has an 'enable' method, but nothing actually invokes it.
The underlying implementation is sd_enable(), which is documented
in sdcard_legacy.h as something that should not be used and was only
present for the benefit of the now-removed nseries boards. Unlike
all the other method pointers in SDCardClass, this one doesn't have
an sdbus_foo() function wrapper in hw/sd/core.c.

Remove the unused method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index f2458f37b3c..d6bad175131 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -119,7 +119,6 @@ struct SDCardClass {
     void (*set_voltage)(SDState *sd, uint16_t millivolts);
     uint8_t (*get_dat_lines)(SDState *sd);
     bool (*get_cmd_line)(SDState *sd);
-    void (*enable)(SDState *sd, bool enable);
     bool (*get_inserted)(SDState *sd);
     bool (*get_readonly)(SDState *sd);
     void (*set_cid)(SDState *sd);
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 0330d432fd0..f781fd1641d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2831,7 +2831,6 @@ static void sdmmc_common_class_init(ObjectClass *klass, void *data)
     sc->read_byte = sd_read_byte;
     sc->receive_ready = sd_receive_ready;
     sc->data_ready = sd_data_ready;
-    sc->enable = sd_enable;
     sc->get_inserted = sd_get_inserted;
     sc->get_readonly = sd_get_readonly;
 }
-- 
2.34.1


