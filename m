Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C9BC19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWf-0002Oz-BP; Thu, 25 Apr 2024 06:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWX-00023N-S4
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:17 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWV-0007E0-Pd
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:17 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-34b1e35155aso940123f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041614; x=1714646414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VCI8k2+9/ICoqj/E8reGAYIBlYDi3yFxDCuQaY0oqJg=;
 b=oWtVe8kqOKvx1mb1CUVGSPYmsElUzI+sUjuUbP/0XJ68Qknwhhyqo/zHCd2YV+YFeF
 AdCP03z7mUTvOxR91N10tJXQ8yDBtuZvcV2YqgU3ZWTkus1fYiF4ODrD6VysEhWK/xkc
 rjeNGjLL6QcZFmD/94HdBJegXwmuc7cdovd5RX8tzUNWN3UgS/8b2MVWugKkLxsIeOIC
 QlDm8gDrdLT/KEPjlrIS7oMFC1l1nVgHJsoCI8mMbH95+4H+P4NOs+9/5PEt8aLkFXFn
 PSxKirUfxGXfT/K/6xNuplWQittjrqCwuGfV58nQl8qrCFI85Bgw4YyvnbqO2NxqlmBN
 4YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041614; x=1714646414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCI8k2+9/ICoqj/E8reGAYIBlYDi3yFxDCuQaY0oqJg=;
 b=wGG4KZSvSRXvkI2TEpxF597Ii4dbB8ElSem5bI7s2nIhL0dUv1KbRWFPtLASFEDQ5f
 l6coq6Mwkg/7r2CCeny70ZdwsvNuu6lsSo/17o1vpQsmis2qf+agQQwwMaOUIAyMebm4
 AD4eAOhT60Ugtk7gYVx7bTtHOGpCTX3RWFaNUY2ndnRsnL0H3dkFwJxovRlEvsfUnILD
 CWq/TbpnIdW9efrY/DlzKDPscL7XHDSNMYArHBDb9qA7tES7+ALwIBv4ndKCYZlC2cqV
 ZikNLXdLdfko1th6tCumnzoycXXAnFl5p2rN+oKn/dWNUujFOmdJB6PnlhclZt5ItevF
 804Q==
X-Gm-Message-State: AOJu0Yx5RT0shAr0ySaWkslf6qggWrAzQyyZMgMTv49BhW/yyisgA4s6
 +zgSX0X/6Iv7XQMCwQ28fhTwrzJvAP0xVFNU/hCfeL4rA1oY2eWhkI4kke2TA/PtlrXJE57748X
 O
X-Google-Smtp-Source: AGHT+IFF54hDTgIQrz26/ZQmWmX6FYAO8P7vcp0OmfXBS4q25tJSnB1vU3Rkzm+lPZDoKV5GnGiG3w==
X-Received: by 2002:a5d:4746:0:b0:349:f83f:9ebf with SMTP id
 o6-20020a5d4746000000b00349f83f9ebfmr4958412wrs.5.1714041614439; 
 Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/37] allwinner-i2c,
 adm1272: Use device_cold_reset() for software-triggered reset
Date: Thu, 25 Apr 2024 11:39:49 +0100
Message-Id: <20240425103958.3237225-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20240412160809.1260625-3-peter.maydell@linaro.org
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


