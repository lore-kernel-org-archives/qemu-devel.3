Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB01C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfR-00031a-O7; Tue, 30 Apr 2024 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf5-0002Qd-8G
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:59 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf1-0005dZ-KX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2df83058d48so47134681fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495734; x=1715100534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VFare7ZkADygwn6ondDR3tguZCHt/fs/mvSL2SvbhYg=;
 b=hIIZsEgU28+fVLj/0LHsLmEKIAxvyYKrIgyKkkv+dpsD509bU0sXvHiYz6t89MeFtC
 jUsPMqA+wRRRv9M1Fzru/ixU9CSSsLhw/xNJxRfX2n3PZ0RdE/+b+e4zBBVUPQZmx57z
 yKW4pVuZABIpd2Mnji7zdfPenUWbgUCbMvuMG1/lBTdaZjbQXFvoAuFyixbrchcwq99d
 x5my6UkLCN64FKZZVvbRV5JA1Fsl+Hh6myAU5kWcqHvncPRybnQ+EM3wcYM1ggWZ+vlp
 MINYO6j1rCG2RfCI824eFyg3qqcz0KIIloKEEv8Md1ZK9DqPPQQbGZ5YFP5OenjWXIYr
 90eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495734; x=1715100534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFare7ZkADygwn6ondDR3tguZCHt/fs/mvSL2SvbhYg=;
 b=sPHr9CcCs/pt42lK+eRI58Y32S9pJSzOZT06gKe0aPy8MghtcCVGR1XB19IhVMqpgq
 jCxuaQ5w8BQomxENlXhMGsk9ksy6kJ8jVHVzOnlkkXQWrBeUCvhaM6HFwRRBcYzb+3Px
 LAxwS4TMGOVpQznnoNq+DySUz/Eju2JLq2gMuyzBNkIwrXxxhMCwF8IksLatFyEtaQNj
 GnodHg07/3UV2lSUiQQGp6E+RxAuiwLDCTuQk9/kKd6BKwu1yXneQvGjLWtMTlVb5F+n
 9EEWybMMqxZoLZmLKyhrzsvtmQ4kvXayibNo3jomNvxTZIKYHU5wtLCQOSDV9dk6uOiE
 gDYQ==
X-Gm-Message-State: AOJu0YziQWLjkHrul8270VRzgNtZqMCcq9kOmQpEBS5rC7KvyUNpF9i9
 ibUBT9aZBXdOOVdZtDFxAJ2AN70i+kSRxzJsAFc73Z9Yw33M4KEerYDcRX9peC48gS6fDHXFlIy
 G
X-Google-Smtp-Source: AGHT+IGRgA3mp3Ja3W6GxoVLcSvnn1zXhOR3ow6JgK/xtEEcq9x96CMkVxC0zgLjxUb/qacuOQQP0Q==
X-Received: by 2002:a05:651c:555:b0:2da:49cc:ef39 with SMTP id
 q21-20020a05651c055500b002da49ccef39mr271468ljp.0.1714495733950; 
 Tue, 30 Apr 2024 09:48:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] hw/arm/npcm7xx: Store derivative OTP fuse key in little
 endian
Date: Tue, 30 Apr 2024 17:48:37 +0100
Message-Id: <20240430164842.4074734-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Use little endian for derivative OTP fuse key.

Cc: qemu-stable@nongnu.org
Fixes: c752bb079b ("hw/nvram: NPCM7xx OTP device model")
Suggested-by: Avi Fishman <Avi.Fishman@nuvoton.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240422125813.1403-1-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/npcm7xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cc68b5d8f12..9f2d96c733a 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -24,6 +24,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 #include "target/arm/cpu-qom.h"
@@ -386,7 +387,7 @@ static void npcm7xx_init_fuses(NPCM7xxState *s)
      * The initial mask of disabled modules indicates the chip derivative (e.g.
      * NPCM750 or NPCM730).
      */
-    value = tswap32(nc->disabled_modules);
+    value = cpu_to_le32(nc->disabled_modules);
     npcm7xx_otp_array_write(&s->fuse_array, &value, NPCM7XX_FUSE_DERIVATIVE,
                             sizeof(value));
 }
-- 
2.34.1


