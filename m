Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF7D1C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFU-0005gn-H7; Fri, 31 Jan 2025 16:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFJ-0004GY-7c
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:14 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyFH-00081l-I7
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:13 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1588553f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357689; x=1738962489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8oFzU0KJNpu3qZQuyVEhKtfFAAIRsXmhtD1aPMM/s0s=;
 b=s1isZdHwFPbBDVMdH/KjesIftd6tKDIGafZVp4jtESUZnsRE6uASXAyf2NkL3cSd50
 ionYtTgfCRoR8bC2x50kBtNnYMu+jaP0f/JfgVbOuANVZKvlVGKB1nVEtPdDXZdTTtvm
 9Oi2OAsYzSKAtelQ8pQR3IMp/xre+7S4yd/10K6wtqztCHnWFbPTgdaEyeKSrGumoMrd
 KC7iBoaKwvKY1CziQDIxG1mFW13Qbr2+WX8HOEyYbBNagUfX+jjGVIeoIXpiVQasIN0n
 T7HcrUuX+tmoOBy4BWXs3vuOR+ttBTMaCX2KymfXXdsBXyyYsSqtTRNQOpPjq/WdPGeG
 brnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357689; x=1738962489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8oFzU0KJNpu3qZQuyVEhKtfFAAIRsXmhtD1aPMM/s0s=;
 b=jt8dsrDcMUWxmbWQkqSdWCGqynMDSrMnLhI6HMKDazHR8e7JeXUWRriVCR9qrffYLD
 sdBnxmAIxdZ6xaYvqC6CwaCaRF+CYo91O7lB69c/WVoPtkFcOvrKfIEv1I/843VHNvEk
 treGRCe/1hSb0gRfMZ6IaZmKS+/wYmgyFDOorUKgoD82krXQYX2X198dBjnvklVGUuBt
 xrhiEbc/5Njx+EDErPJLG2xtEL7OxPAx/aqeBykBbbi+crlsUzF4022bchVJr00vwyjl
 zSX7KkUEN1coAszxOvQRc6cKwskE8tW0Dp8dE4t4Ys+ukznhHPoRQWag/MC9Z37VzPLA
 qRuw==
X-Gm-Message-State: AOJu0YxRuJOay9/8D2Ce/IT+9Ttp5tsc8Iop69ZyZnsHle6GvaLy/6xU
 h9cckMq5FxOOBO2xwB2UlPBQHy7zeatzz6x5/rIn9plKXOP837VzXllv446ModGOGbw3TdFnj9n
 LQ9U=
X-Gm-Gg: ASbGncsOPIMGE39XNomKPVZdAl8PQrVbvBR3Dl71KY0sQQvLWZSQ17xvCcAfjsgXHlK
 LTO8CWGVa/yyCQCkjWYiiZFJjZ9ALdsUPyZ/ovUnNvVqKT50CLNkcd8HhnYfzhxACgWMi8dTXPV
 8QWS356rMpgL0PyiD8BkXllqvTmRpRIBioICYSxruqA8qgQuxD8sqlI+fkMn95Z/jJVVvKn43e8
 JqJ7ZNcMoJJ2grycifYdBCyPLhpKStsIP8v6qpgAIYdY8bgHxhFWiPzhRaWllnNH/la7QOf9Y8/
 ptfhG3nyUL4tsn4o4FCikeDuMr32P2w/v2DQaJY0ao8tKcVNc96HNIVNFfCqddYfzw==
X-Google-Smtp-Source: AGHT+IHI3T5INQLLSw7qsxGnER9K2y4WIPvrk+tcQNrn1JrB1/AC4IIrqhTgPDsOswqNjeeUj8iP4w==
X-Received: by 2002:a5d:584b:0:b0:38a:8b2c:53ad with SMTP id
 ffacd0b85a97d-38c51e91b14mr12618716f8f.39.1738357689555; 
 Fri, 31 Jan 2025 13:08:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2ede0sm102340385e9.21.2025.01.31.13.08.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:08:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/36] hw/sd: Remove unused 'enable' method from SDCardClass
Date: Fri, 31 Jan 2025 22:05:17 +0100
Message-ID: <20250131210520.85874-35-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The SDCardClass has an 'enable' method, but nothing actually invokes it.
The underlying implementation is sd_enable(), which is documented
in sdcard_legacy.h as something that should not be used and was only
present for the benefit of the now-removed nseries boards. Unlike
all the other method pointers in SDCardClass, this one doesn't have
an sdbus_foo() function wrapper in hw/sd/core.c.

Remove the unused method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-10-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


