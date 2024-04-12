Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17DFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJRr-0001tf-LA; Fri, 12 Apr 2024 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRp-0001sf-UL
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:17 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRm-0004ZL-9G
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-417c339d261so8016705e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938092; x=1713542892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cdQqFsNDDUWJxTigPswVdc5hROMiTrrzC++GHPfi+hc=;
 b=AuiXPQN2j4iL6pyuzDGTlCYrlv0Z73vrU8HQJrnvmR0Lv/Zhlsauhe1pgbVr+r6SXb
 9t34wueF5gmR5OSAePd74OV+22Us0aHbOe88pirJlcBU8w+ohQuV3yPFriONBMMHW14T
 4roY4ixPkRphxD0YAGAofC2rhgsfoIekpcn47vOAgmkA97+3I2yFZNJ2xwc6hRvKmD1h
 bCSxJx2me3ILyPlfoVD4tdTvptKnxlvRgnYBedY196ys047ulU6vjkNfcMc1YnexZ149
 VLrp9ArW18ChZa33sNzQe2qJpefgztcKBV4VfdmcKFMUwB2dG4t0hUQwqWrHcSOeWPI4
 QGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938092; x=1713542892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cdQqFsNDDUWJxTigPswVdc5hROMiTrrzC++GHPfi+hc=;
 b=mMQ52E+oQc8b+9ckR3oMnjzs8VKKitqMm8QWPBVW+jErqs7L1w4BmQUn5UOIRQL+Re
 qYchUp10bLxuaz9tM/e1uRRwAuHQWZaUY2P/dp9wmTBUHSERmMMbnSkhf9a6NwhXmdZA
 WsKE0dEQHysrXTnF/dJ+nBbKSR4qD1068+5PW31bwo9PEdjt+kjcDnlVW2jzGRAgJ10/
 XGX3gLvuDmxPGkuoVQgGBpj15RLKST/nw7s8m/T5ftIqzbGrQyBWej1tCHTZmzDlFdm9
 wkP6kIo6YlSzac5dhz919/mZNwe/JCHAHJB2vZeqpot9EGfZqYf2ZYHTgyQEEzus0OtY
 fgYg==
X-Gm-Message-State: AOJu0YznWsoQkUR6ktfLb+bHpNa/VwDa3nXwGH+oN2iJi5vA6FCBuT9o
 LF2VDjOpEA+qgMkaGlz+SIQjZmwNEf6UfjiEfvbQQWVy5u3y5vVikohlCXuy+8Q8+1WSCoimYIV
 g
X-Google-Smtp-Source: AGHT+IHmc+UfwJ85J6tZVeJu3eQ/MN0uyHTXS2jWyS4pvhzwzfMmGUAVc/Pl/ANJ4eTkr37+/2J/Fw==
X-Received: by 2002:a05:6000:1ace:b0:346:251a:396d with SMTP id
 i14-20020a0560001ace00b00346251a396dmr2509725wry.51.1712938092128; 
 Fri, 12 Apr 2024 09:08:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cr12-20020a05600004ec00b00341ce80ea66sm4582371wrb.82.2024.04.12.09.08.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 09:08:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] allwinner-i2c,
 adm1272: Use device_cold_reset() for software-triggered reset
Date: Fri, 12 Apr 2024 17:08:05 +0100
Message-Id: <20240412160809.1260625-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412160809.1260625-1-peter.maydell@linaro.org>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Rather than directly calling the device's implementation of its 'hold'
reset phase, call device_cold_reset(). This means we don't have to
adjust this callsite when we add another argument to the function
signature for the hold and exit reset methods.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/allwinner-i2c.c | 3 +--
 hw/sensor/adm1272.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index 8abcc39a5c2..96c20c86372 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -385,8 +385,7 @@ static void allwinner_i2c_write(void *opaque, hwaddr offset,
         break;
     case TWI_SRST_REG:
         if (((value & TWI_SRST_MASK) == 0) && (s->srst & TWI_SRST_MASK)) {
-            /* Perform reset */
-            allwinner_i2c_reset_hold(OBJECT(s));
+            device_cold_reset(DEVICE(s));
         }
         s->srst = value & TWI_SRST_MASK;
         break;
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 1f7c8abb838..a19557ec9ea 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -386,7 +386,7 @@ static int adm1272_write_data(PMBusDevice *pmdev, const uint8_t *buf,
         break;
 
     case ADM1272_MFR_POWER_CYCLE:
-        adm1272_exit_reset((Object *)s);
+        device_cold_reset(DEVICE(s));
         break;
 
     case ADM1272_HYSTERESIS_LOW:
-- 
2.34.1


