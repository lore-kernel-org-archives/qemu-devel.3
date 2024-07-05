Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF48C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3q-0004b0-9Q; Fri, 05 Jul 2024 18:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3o-0004WX-UD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:44 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3n-0007kI-Ae
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:44 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so25813021fa.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217141; x=1720821941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1jfIIRixH/o9kg5Ph3jE8g2N5lQ7LfdnVdUl4+XtOc=;
 b=WhW/yklyoExYYGpH6HetoLIDCKF2J5yLSKXAutbjpLeQ10YF0F+lLSNAnKTQj4o6po
 nIzNsbiWZesDW2HFZo61kqcuk70/m1l4qMGtxfP5Vm2+Ug77nFxvj5MLrbeGTb/aLq7J
 EBWWZ2d7U177xDpu8lVfpxCJi8MozLniIcHIY0ktvW/FkeKlteqE+NB3Z6L3BULy0pRK
 HKzDl/RZtsIgeEn8qDOFcpEr8YtfCqWyLWSWDRBroLYUghmA6W3+j7TGeWbVbI8nx5nl
 vugGD/LY8gbGmXd5hD83Fnr5hQqNQ3RYao2AbJT6kfu1fVgD6eb20wVKz8X7I/Sle5Nr
 jjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217141; x=1720821941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1jfIIRixH/o9kg5Ph3jE8g2N5lQ7LfdnVdUl4+XtOc=;
 b=EnE70VakZF/zH1vjxjv45Q2tr5pfvuNACUjyb+VU21LCRCxSwYmAtwbN3iXhZuf4xi
 OwUrnA1Uc7vz/ZVqpVpEQMk9kqYtDwOtEmjKfhO3GnER6Rjq8tFA+Lt7rLmsUyUr8Ws2
 jThKXn7LK6tk2iOsuzroM79g0IsXDf+9QYYeGZ+XaAV1hrbB2TKBu+F3MgfjXVAeYwEc
 UL8gCKTT/vH2x3tuEnYQHzneVkUD6fl8YO76whwDOz+eN+4xoTy2/wKcZAPfOIWhV9Eg
 rPZVjKmCJ1Edv7ZrqpaMJIArUIrF2JLWK9TgUQysa+dbSl40buFapYDikTGZTYdKA8ci
 rjuQ==
X-Gm-Message-State: AOJu0Yzr8o3OLoF+TEcJl61GcfWKuO7shzZcVPXRtQQDfrxQl8EJx2Lg
 U6CwYqGCD17zsemPLHC04YAwFrYcbj8COXn1s7hD6weVrdGASNojH2Noavuvlsk8OlJhc4ZaXwg
 i
X-Google-Smtp-Source: AGHT+IH6Bkuz1Ip4Fu2EbV+7A8VHZV4fZOS1RGmI8WbH0LK4N0zELBAIy028Yg5s/mPBYjcAEZQlxA==
X-Received: by 2002:a2e:b049:0:b0:2ec:56d2:de6e with SMTP id
 38308e7fff4ca-2ee8edf1be2mr39205461fa.46.1720217140899; 
 Fri, 05 Jul 2024 15:05:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1e727asm74016985e9.18.2024.07.05.15.05.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 12/16] hw/sd/sdcard: Remove default case in read/write on DAT
 lines
Date: Sat,  6 Jul 2024 00:04:30 +0200
Message-ID: <20240705220435.15415-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

All read/write on DAT lines are explicitly handled.
Reaching this point would be a programming error:
replace by an assertion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-79-philmd@linaro.org>
---
 hw/sd/sd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index bc1a574b62..3f495f91fe 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1949,7 +1949,6 @@ int sd_do_command(SDState *sd, SDRequest *req,
         /* Valid command, we can update the 'state before command' bits.
          * (Do this now so they appear in r1 responses.)
          */
-        sd->current_cmd = req->cmd;
         sd->card_status = FIELD_DP32(sd->card_status, CSR,
                                      CURRENT_STATE, last_state);
     }
@@ -2014,6 +2013,8 @@ send_response:
     qemu_hexdump(stderr, "Response", response, rsplen);
 #endif
 
+    sd->current_cmd = rtype == sd_illegal ? 0 : req->cmd;
+
     return rsplen;
 }
 
@@ -2167,8 +2168,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        break;
+        g_assert_not_reached();
     }
 }
 
@@ -2234,8 +2234,7 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: unknown command\n", __func__);
-        return 0x00;
+        g_assert_not_reached();
     }
 
     return ret;
-- 
2.41.0


