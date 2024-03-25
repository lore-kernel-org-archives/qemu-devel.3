Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC215C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSU-0003Vc-EU; Mon, 25 Mar 2024 09:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokST-0003S8-01
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokSR-0007SW-Ax
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4148c5de23fso609415e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373625; x=1711978425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dmBZnvObELGs1VJCtsjfXQQHR8FYa+eCE52ifx9aDFo=;
 b=TkcmmaY3P9KBxuj/1kMLyKMhfW3tUhND1f2WJ6LAotpmiQgbtWLd2ciexxuvhqhULl
 FqPneXiDxHaTwSwpvq9M26qypu7UeX8SWaOcSQy6VwvAlHD+cqin2OplF/tFgh9tiCsW
 6raBV+s2rXeV/dP6BwR5C+aFrqg3Xfi5e/IFgKlMBIjvdX+lCgHkOUxrNG+24dcTDXFc
 d28to8WWhBfKcmKEBXnVxBz+kqTMNws6kms7t2dCBp2XTKc7iKCe2d91PPri8dJ2XCC7
 NCcSvwmnu9+W6SuLw3PlC8stErZxf92Bd6OaT0ALippppRYDM3GHj46DbSrklmVzrzyw
 jmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373625; x=1711978425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dmBZnvObELGs1VJCtsjfXQQHR8FYa+eCE52ifx9aDFo=;
 b=Er39HNtlC8eDc3af5B/e2FBGU3I9pxc/pWZqWxFdhcpDXPCcgl6KMRH7GsRE73SuVP
 QcyZiIL7Jst0CzAtQucczFQrLRcUP5oXNgonLzUjsLN11YTiRd8js1VegWGxP3T57HwB
 yYe/RwgbuCWZ31439sxi3fKOmoOHHMKfCS1dndGZd+/qlnqdsdYMrNOEvBULdoy9MqZS
 cEbxPd2Mtrq/dvVHDCZ+w+7vKILgPAZDUBz4at96F9OfKth2L+zNJAwWg0OOaP/h/PpV
 IVdGakK1jgPpfyoTy86x4loKgOO4VAjzHMldNzbEy6VPZ0liT7qpA0llsGwA9GbZR7P9
 h2+g==
X-Gm-Message-State: AOJu0Yy5wQSJZkD960vxcsY5m80cRW9VrMHhzXnII+2YvWi1ivfjlmKU
 qevu55lFjn3o0e5fVYuqNDR5mrDnzj8m4guVGCoX6LA7Cxe3RZcOKKOjTpS3nCXcjIPqMauMCrO
 KJ3M=
X-Google-Smtp-Source: AGHT+IFWZ/58Xj/nwYwUTAXrwNX6H0wJoPJCar7qmULOe4KV+pP42L8yH1ezkdLTV9P/Fd7XkQhr/w==
X-Received: by 2002:a05:600c:5121:b0:414:7bd1:4060 with SMTP id
 o33-20020a05600c512100b004147bd14060mr5425135wms.2.1711373625053; 
 Mon, 25 Mar 2024 06:33:45 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 ay41-20020a05600c1e2900b004148c10db66sm809802wmb.26.2024.03.25.06.33.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? v2 7/8] hw/misc/stm32l4x5_rcc: Propagate period when
 enabling a clock
Date: Mon, 25 Mar 2024 14:32:57 +0100
Message-ID: <20240325133259.57235-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

The "clock_set_mul_div" function doesn't propagate the clock period
to the children if it is changed (e.g. by enabling/disabling a clock
multiplexer).
This was overlooked during the implementation due to late changes.

This commit propagates the change if the multiplier or divider changes.

Fixes: ec7d83acbd ("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-ID: <20240317103918.44375-2-arnaud.minier@telecom-paris.fr>
[PMD: Pass argument to clock_set_mul_div()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 8852b434db..166c727e52 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -61,7 +61,7 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
         freq_multiplier = mux->divider;
     }
 
-    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier, NULL);
+    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier, &clk_changed);
     clock_set(mux->out, clock_get(current_source), &clk_changed);
     if (clk_changed) {
         clock_propagate(mux->out);
-- 
2.41.0


