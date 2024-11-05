Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA42D1268A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbV-0004bW-Sr; Tue, 05 Nov 2024 06:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbR-0004Zv-Vh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbI-00078b-HF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so41103405e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805594; x=1731410394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=38EGQ1h0hACahyl0oXRU0siZ/g2UnItojGbOd1JPD7Q=;
 b=i6e5NRehCJxmnSjFWwSLXKIJrD4siRw4xkRkhikCByF99GypWIALo1P0Mn+3V0aeSM
 Ow/Ey/nsS0rjhgFtUJAq+07/xgH2wyAMnWjwv5mflMh1Ow8HOblp5wgem0SvJJh+HIrM
 49Zymotv/qeLEGtrzOOpYGoQzyWWa91CpYs1nuxt/lhTbQqz1LT/C0G5q+NJB1h5s46D
 IQphFIe530Hwgv1Kf0+l5bzGC5ipT0tvnmZoIAdphL8d+WozCPmr273Rm3XPJfuD3nm1
 RHZ84kNh+JbV/ghNo0N2wRXGgrUT1wfJufHB2sHc/LpQILnVFKQn+iBHJ86XlsWFul/C
 VFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805594; x=1731410394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=38EGQ1h0hACahyl0oXRU0siZ/g2UnItojGbOd1JPD7Q=;
 b=SVJd/QtjO4Yaou73Sbu6z3H6U7+F7XHF6nb/1pXcq1/I6UI0YgO/zgMg0UgsX8sjvs
 K5cs/qYhM8MXZy392TPVdyV9a1G2dOxhhVt0iMZ8SfeZUC2ekI3UJmunG7Wwb5K7s4VP
 A83y7gV9LNNn4Q+ug+k+3OTsl2CjHsaeseDEp4PPJzuFGBalGEW88SNhjaOWjPF0kQqE
 x2aUeUfsxo7+XV/0mhhCADhGKkjS6xm7L4NxO+/Ou9R614CXkhI8jL0Npzo5smbV7g3b
 Ly03LDjeBOVkG7te/neJ3REPf8FpPlC/QGJMDc1u9iWc4gYsQT7mGyn0ZbIExKCEfOTT
 lB5g==
X-Gm-Message-State: AOJu0Yy+XP4wD+SZdOXrrFp8PMO5tTbqpL6YOzn7oGt8c4H7CasgC7LL
 1N4JcAEKI9UhVXEyr3eipkk/5axhA+q5e3gsDmb/s4Jr453RorbRe+Ex+trtU5GilYCGwgIVq0s
 c
X-Google-Smtp-Source: AGHT+IEOEY22p5fkqapkj0FyVSZMonZpdg4ChxlBjpbkRwYEFlKQpRc9hA4UV0bj1PAmLjNJb3ThlQ==
X-Received: by 2002:a05:600c:1385:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-431bb977328mr197556815e9.7.1730805593793; 
 Tue, 05 Nov 2024 03:19:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/31] hw/watchdog/wdt_imx2: Remove redundant assignment
Date: Tue,  5 Nov 2024 11:19:32 +0000
Message-Id: <20241105111935.2747034-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

The same statement is executed unconditionally right before the if statement.

Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241103143330.123596-4-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_imx2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index be63d421da1..8162d58afaf 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -39,7 +39,6 @@ static void imx2_wdt_expired(void *opaque)
 
     /* Perform watchdog action if watchdog is enabled */
     if (s->wcr & IMX2_WDT_WCR_WDE) {
-        s->wrsr = IMX2_WDT_WRSR_TOUT;
         watchdog_perform_action();
     }
 }
-- 
2.34.1


