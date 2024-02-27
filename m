Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E41C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexax-00015N-Ff; Tue, 27 Feb 2024 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0000hv-CN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaE-0002py-5F
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so3296056f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040798; x=1709645598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUYripAJz/Vt0PNsUQO402Dv2ocPrItdLSWvRd1GdNE=;
 b=cwGCi443ily7XVIVWp59KAq7nRcAzmQM+FccY0XWArin7gBExrRdBFPpILhY/w2wbe
 VV09vcppShog/HGQ+EXVaemyYprhK2zHvCMwqsTNtP3cOwyj+G3iyGynvyHQZwmCfMxN
 kssTdPKDF0qoUh0aOpIdUk/TEOEF3PJOpcM9+qR56qUouZJWWxQI3Lp9bD5uQr1IbN21
 r1sN1Amxa84gb8tQD8a5w5fNVj9dKuayL5PIegi5HHbJAbc/ahGh8JRunekrSZe3GN6Y
 WALq/AM/Ch98/xbnFWI6+or6S59B19kXoayuY0jYosYmPe3sWk19SCLG9wcPF//oOtWf
 BCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040798; x=1709645598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUYripAJz/Vt0PNsUQO402Dv2ocPrItdLSWvRd1GdNE=;
 b=oKMDklf1nkfjEmNVit25xkTQ+mm2ZVNdgIvrOENjiEiwkQHNxeNjcS4RFCQv4ROxqG
 Xot8CS1YH/DxIsWqd88FMz1PVc66HwqC0SOScQ8GYCzoBPmJPJ5BXDAvJy1A0GAbIiCr
 8hij5gb1NiYNHj3RqH71Bv/o+Ofqcu+QZGfl5pSMlWNNJuvd61JWO0+oyTEp6WxrmGys
 F3XcC4Zg9cBtZnZ43Qvnqb5nkgfmbvqcY6S2wW9ihR3iCJVpcY1/WGyyOB4sCFAR/pM5
 eSYTSiLrordvF+HLtR/yyT3LEZrO4RO3C97IO5V7D2IJf5Um4qaLN0VIO5oorlyZTe1v
 urZg==
X-Gm-Message-State: AOJu0YzdmByJFkz8qimY5urp5vzv3RI5smeNGCMpzcnPivSl9aBtwj1B
 /Vn1kLxLdEgjoCx6x3vGHqFglQ1R+AWBsIDNER/lvC0CmDDb2y3CacorQ8n77CeWpMF9Q8BwpxA
 +
X-Google-Smtp-Source: AGHT+IGiLarSO8Y/078pyBtR0RN6XolgGC6XG3knE6cvg7d+ERF4GSru8dB30biKo8MdWVbjc1XJ4g==
X-Received: by 2002:adf:efc5:0:b0:33d:746b:f377 with SMTP id
 i5-20020adfefc5000000b0033d746bf377mr6914174wrp.45.1709040798714; 
 Tue, 27 Feb 2024 05:33:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/45] misc: pxa2xx_timer: replace qemu_system_reset_request()
 call with watchdog_perform_action()
Date: Tue, 27 Feb 2024 13:32:34 +0000
Message-Id: <20240227133314.1721857-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Abhiram Tilak <atp.exp@gmail.com>

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
Message-id: 20240216192612.30838-5-atp.exp@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/pxa2xx_timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index 6a7d5551f43..6479ab1a8b3 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -18,6 +18,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "sysemu/watchdog.h"
 
 #define OSMR0	0x00
 #define OSMR1	0x04
@@ -417,7 +418,7 @@ static void pxa2xx_timer_tick(void *opaque)
     if (t->num == 3)
         if (i->reset3 & 1) {
             i->reset3 = 0;
-            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            watchdog_perform_action();
         }
 }
 
-- 
2.34.1


