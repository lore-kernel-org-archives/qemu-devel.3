Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B72CED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQxi-0000F7-2T; Tue, 18 Nov 2025 14:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxX-0008Kq-HS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:47 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxU-00061S-Oj
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:47 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso38932245e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492494; x=1764097294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4jRE2E0E1RV6lKHnV+cCA8THnOd68pefsVHATt1ZwL8=;
 b=MU6Z2XB3BD+v6dibdIk4OBE3PHcoQ0ykFmhP9vQGnoxlu2YC0jsM+q4fN//d1ng+MP
 KMKg9bmMnW2z3XVe9N5MV1chY+ZVMNNKh0lVrAvaszrCdqnmhWN+T7tPu+X/N24Cup3F
 ulvOvymH5g/sXLqjtv+oZ/ijtuSJ3K7BkVo0N8oY/tpBV+NRrZiwOiNykA5eHEuJO0/t
 iNyKZdpOz0ePrSQlHnOYabqbnI/VBzjMc35opr2Om7r9F2UHKDPZ7OKIXZ8qqlA0KxAZ
 gsNKs0UbuDzTPGGCNDnqds0ofMPZeeVkGTLmMZ/ifJxIuSr9omBK6JW4rKYpzcRbloFZ
 pBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492494; x=1764097294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4jRE2E0E1RV6lKHnV+cCA8THnOd68pefsVHATt1ZwL8=;
 b=KuT2ZlN1QY0IscgWtrVKkskvfREtJbIa4x5fhT6DumUWwymesHCBRS0kAmjjec1c/4
 Qcr4ovUXV6E+x88DIDzLIufG2AyrAOXQvvryGPMz/WoW9BOkV0QrcosjTXvWj+fFzSmK
 RH7UgGnVwGW+30EAl5fj1Yoe17Y/fTZ+3nk8tiRg/Lu4dy8kkcxbDEW9wLL0ZEUeD4aG
 jm9KO/lL46mpkVleFWaIxw8a533kd4fy7MfmCFxov8fynR/qyNeuiJM3WM/OGLjmhUin
 BOjfBmfsBy69zp1igPSZYGJj+28WPGLGiZgGYp5N85ft9yRe6EXqdiDUsUflMTF5AaY/
 /a7A==
X-Gm-Message-State: AOJu0YzprrrCuGC0OQfO7FnoUGK1bdcgLBPfrM9e6vxma+ZlW26UjmXc
 0DZrOI85IDxBR4p4NS08zbwmVYXzpTlzPomgcxXvG/nMJ/4+uc8AxId17wBU4iSp1WXhdwI684j
 EtlXM+xZiX55h
X-Gm-Gg: ASbGncvSCT6s+tgQTlNqur6DDjOdKGzo0G6FwDDTLSKhYPwelbskcs8dpoy3HAVWHHT
 O187vzHzMLdvk7dokNLFnVc/9+Qy2536KhgymgRYsiwfKFGA9/tH0+Av0B8v52XXpQnRFD6qodV
 qITi2e4ubDb+kk/vcojecT+V4SUbXax6lGNqkpWg39jHuR7y9UdpTkyD4XjevhK2u/g+vQEQ+zH
 7Q29EmwR47Yda6jwzm9qai7MKx6l1NVHLPMO7KSLiJ+01PJQRfWSrPACprVEyeXFa33WIzih3DH
 utobJiwpQATxFgbTD2dBTv3C7RSaB/TSSzYSm23F4vkrzmJ6LTvGQsQfCQTxZAy+L4qUfjQIMEL
 qv77pQN/m8i8hNBpFTcN9DtMCdkmelPTJ+fhBSMEXgxxphpQ85JbShZr/RfJRpnTswFkeX1GxlE
 kz3xrteDBaljUnSE8CKrZtGMYIEyhBv4eZKAWbMb/v771c0ZaJvzQ1bvyDaV3O
X-Google-Smtp-Source: AGHT+IHAdgsCMibwmO1vsPIlksPhc3WPrh4OnVpMy5zg6aXppbIJXnQX/rI77A9h4PzmXnAvSX27JA==
X-Received: by 2002:a05:600c:1f12:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-4778fe9b44dmr175047615e9.21.1763492494437; 
 Tue, 18 Nov 2025 11:01:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10260adsm5156005e9.7.2025.11.18.11.01.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] hw/sd: Fix ACMD41 state machine in SPI mode
Date: Tue, 18 Nov 2025 20:00:40 +0100
Message-ID: <20251118190053.39015-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

From: Bin Meng <bmeng.cn@gmail.com>

In SPI mode, the ACMD41 argument only defines bit 30 (HCS); all other
bits are reserved. The current implementation incorrectly checks the
voltage window bits even in SPI mode, preventing the state machine
from transitioning to the READY state. As a result, the U-Boot
mmc-spi driver falls into an endless CMD55/ACMD41 loop.

Fixes: 3241a61a ("hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2945
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251110110507.1641042-3-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 5aae5413636..df5a36fad9d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2289,20 +2289,21 @@ static sd_rsp_type_t sd_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
         }
     }
 
-    if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
-        /*
-         * We accept any voltage.  10000 V is nothing.
-         *
-         * Once we're powered up, we advance straight to ready state
-         * unless it's an enquiry ACMD41 (bits 23:0 == 0).
-         */
-        sd->state = sd_ready_state;
-    }
-
     if (sd_is_spi(sd)) {
+        sd->state = sd_ready_state;
         return sd_r1;
+    } else {
+        if (FIELD_EX32(sd->ocr & req.arg, OCR, VDD_VOLTAGE_WINDOW)) {
+            /*
+             * We accept any voltage.  10000 V is nothing.
+             *
+             * Once we're powered up, we advance straight to ready state
+             * unless it's an enquiry ACMD41 (bits 23:0 == 0).
+             */
+            sd->state = sd_ready_state;
+        }
+        return sd_r3;
     }
-    return sd_r3;
 }
 
 /* ACMD42 */
-- 
2.51.0


