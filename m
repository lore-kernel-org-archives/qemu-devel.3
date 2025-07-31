Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CDBC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb8r-0000F6-V7; Thu, 31 Jul 2025 17:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapZ-0001uM-7E
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapW-0007xx-So
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:28:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-458a84e2917so3880485e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997329; x=1754602129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s7mVqzkbs28pCgNpi8SZYEC1s3rbOHdivZGAjYGLV1c=;
 b=jZKRDNrnFwLB9pE6JVTge48BHOxQsZrtCWdzFKlTH+5IGa+5nxjqeu/vGymhtLvOHX
 nz2eFbURjYJ8vTpXoUD9PcVUyzjXZMyxNc8u6JCRR/rNaaQ3t/v/rwWNE2M2VZZIaIcZ
 mzSsLbdFXNePDunqrRKhHp8xgjAHc6hPLJZhNVC+uIg5R1S19T0liiHLgNgm+5eARnI4
 Ii7QVmHQHNz0qMbpr66Yj78QhAs6e5SssIy2th5M94RqoRhDptQGdAe6/mO8QkZiIuAH
 lsz2sxvr4fECqa07T0zC9UteWQgR4S+hteHcGn1FQxVAjAu7t2IATokjpsO9ycBv7AZW
 RbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997329; x=1754602129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s7mVqzkbs28pCgNpi8SZYEC1s3rbOHdivZGAjYGLV1c=;
 b=W8p6FYc8OTQboaEuyWC3PADdU513GQfaODjwm/ZQCtJfpo4nS9Z9fdbTeyyICmIzUh
 EsAc9ZTKMKMWsX09E3qi74Ni0/Eu2368YJh63qBwBBwgZXUnaHTXJgK/mvBQns43rWvh
 kRXyaMlWr1DwJwkTe2x3nxrmVurRmT6fT7RZu5BhAkhgB4JzlZzljBvswnp/jxa853AH
 GOplNWC5GzovcvjklahLoMD8ffAemUgM6g+Y5kvnOljvt5w/defbiGVNUkaKAOqyq4TA
 xgxAW01XsVueK2eCdHA06D8BAbGj0DqvIMNvvVFzZ9dIIOpv9JgbZJgBq2xEY19UlPxN
 TVRQ==
X-Gm-Message-State: AOJu0Yx2BuVu0y6pUDhVMJEVrgoRurm8Y8HuwZa5v/hXKod3pOjC5gHQ
 RXvtWqkF+ZbHVUjj5NDjYmPRgygHXyvclHquR4hRTd+JBU1LiG2mADwXE6FdbIIWeoAB3gHCbv7
 dTMIw
X-Gm-Gg: ASbGnctn7/dzRq8BDKAX1cNK6VN9yStE4mKZCwEEpQQo1MT6zn/IPMSwTyX/Eryb0fA
 ATaLIFwucRAPtEwA0/Q487mxViOahoND40ki3kfh1/eIL8GMzny7sjp3K1uO1W4ffEnjXszZVlU
 vim4/e3Z0ADjseUBZPGoQmad/LCIju+XYFAscevhOCfSUNIAQrZQ1NfJzB/XAgZ3ldLSZEOrSDw
 8hcu/4CvxtdOKewcRhOStTPNnj8dT6ZBEHU4BJCiOqNMM6vgJkmNA6CkY7RUKDUpm0wgxChIaez
 fKq24c/baLCOw2fEPTnMW4Pmfs/LLuLK7DlPL1U0fAITs3yJyozoEx6crmQzlTYMn4y/kNrfRBD
 8o49Foe6nCoB1F4mj969b+EKCcNvkh0Z1j1R6RqkicXLOG6ZHj5tX0oauknkvDS+YBfrxmGSG
X-Google-Smtp-Source: AGHT+IFCPNBycVrXvv6jP5Sb1x+FI6TNUlsCxeMHh2pnFyPN9SeeEM1PguaW6827RS0lOXuzANFKTQ==
X-Received: by 2002:a05:600c:1388:b0:456:25e7:bed with SMTP id
 5b1f17b1804b1-4589af5ba2fmr76998555e9.14.1753997329028; 
 Thu, 31 Jul 2025 14:28:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee4f164sm39164505e9.17.2025.07.31.14.28.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:28:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 07/11] hw/sd/sdcard: Allow using SWITCH_FUNCTION in
 more SPI states
Date: Thu, 31 Jul 2025 23:28:02 +0200
Message-ID: <20250731212807.2706-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In SPI mode, SWITCH_FUNCTION is valid in all mode
(except the IDLE one).

Fixes: 775616c3ae8 ("Partial SD card SPI mode support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index d6493d44734..04b3a1651c0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1476,8 +1476,14 @@ static sd_rsp_type_t sd_cmd_SWITCH_FUNCTION(SDState *sd, SDRequest req)
     if (sd->mode != sd_data_transfer_mode) {
         return sd_invalid_mode_for_cmd(sd, req);
     }
-    if (sd->state != sd_transfer_state) {
-        return sd_invalid_state_for_cmd(sd, req);
+    if (sd_is_spi(sd)) {
+        if (sd->state == sd_idle_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
+    } else {
+        if (sd->state != sd_transfer_state) {
+            return sd_invalid_state_for_cmd(sd, req);
+        }
     }
 
     sd_function_switch(sd, req.arg);
-- 
2.49.0


