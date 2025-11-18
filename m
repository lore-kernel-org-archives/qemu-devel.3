Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4902CED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQxa-0008LJ-42; Tue, 18 Nov 2025 14:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxW-0008Kc-Ay
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:47 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxF-00061H-FH
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:01:46 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso41149475e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492487; x=1764097287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ok/ItGqyIFjLquLTm5tPFckGPKjD2Kp3ocnHaYbZ5ZY=;
 b=gi+zZfrdRRyVWU8m412vixUlxqZ4GOPwFdkySo1NOHPXRXaIDFn1P4R9R6B+4PRLLB
 N2wsg4TIodQNrnzcwMWQTHEV8i0Hv3g8fpghGMF75mXtwvBiTYr1g6qwMI6z7QSH0w4w
 YcWL++NfmLrQuZYNaMoBnDm8FjiWRVyNjhL7/8bYoWJUyban2tbFjPUcbqUNV+uUpBNo
 2ES5GMgujtKVuT+XT7acnGTK6ktS95dumOmrBVo/D41yJt6qZIDvUB7Oxh2v5qC3SGuL
 5qvBuZtW632MVCNauyT7pCsOtvImXx+COQAsonMXwuNLoIh6op3Bp8tfHDKjP2k2LLA6
 I1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492487; x=1764097287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ok/ItGqyIFjLquLTm5tPFckGPKjD2Kp3ocnHaYbZ5ZY=;
 b=fXIBX38WXuO95dVtN1X3cS47y91pYV3YEOGhFYhC+JF8tT61xfYA/yPWD0EpL701zv
 CZK+3uGzqBo1NKhDcdeUtrlUF6bYOfoVYtAOow7JRt7ZQpSFRLv3zQtHaBYidKOlLNtx
 WjLTYSn1hFJAnVgnCGdTePvdChc8B6ntEzwICwESKThMOM5NnESDa7ScswmhGpAdToHf
 YOm2eS323RJe1p3tyCTJ/OYqjhGUrfsUsK/A3+yQmnX1NOXuHpyVV26UWxYf0WfCUxWN
 hiZV0x6Z4UGqR4XPbrTOmOlvyLOpB6ut6qAiyJ02KRRmXtKyLDPsPCXnQngxSlWGQpxi
 mXOg==
X-Gm-Message-State: AOJu0YwTnjpIpUdrzV/UQRHwNovCYo9jkgv5fb1CayhSn3qhxL51W4g5
 b70BbM5xONcm/pmnc5SzZ+RzcTbvELL88hh4H27iO1QaM1+ROKfL2ISr71OErCdLhizBLatE1B+
 SoYZlErwsKT50
X-Gm-Gg: ASbGncuoDrqIdC0F/bCPDKFaQx2HBeKlB+jINywmjIrwjAwf1E1rUhWSuIlkJIxfTiJ
 VS1fxflgLr7JfGIVZpGDsQou1lkorOLCooAdOs+of93kQjOxOX/5ba43h3MwoBZuOyPK/G6ItLg
 Lr0UJh+2/vLNkY4I2WG7fIeA6xCtZYD1uUy4CbvWvDZ/lhwr4zMD6ClOsmnV+ebVd55QRIAkOJA
 8UKx4fuJqca9oqoCyqCINYt7AuCKe7rfQbzyt9ORIkz5qDcplzoMsZ5APzQMzSrED/+D54Sr47n
 CIM8iGHQNThH5agAh+XTUTltKFESHMf3GVt49PQNU+HDCxRo4HvXMBqUIcKkC2OHGXGHOuVZtUp
 /bN4Ovqddc9HCU2DagNkxamAlEyeIsCZEGlnaVKUUSocTmBnAQvT/h55vdCT2s8U+15lO9IrPEH
 nRALuPWhuurrlEIgzA8YTOICDBiLocnK4mygV2JpJpdkf9aOer+PW/saZ6OIFTYKVcJq8DJPLIx
 GOq8IcJLw==
X-Google-Smtp-Source: AGHT+IGw6Xu8KrZbLXHP2Jy49Df/Reg4BZcu0hQhzVtNZyQaOqrakiKTO8YzP7/uooSfalDKHyb70A==
X-Received: by 2002:a05:600c:4714:b0:477:8ba7:fe0a with SMTP id
 5b1f17b1804b1-4778feaa8ffmr161157095e9.24.1763492487134; 
 Tue, 18 Nov 2025 11:01:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1035c78sm4971755e9.11.2025.11.18.11.01.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:01:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/18] hw/sd: Fix incorrect idle state reporting in R1 response
 for SPI mode
Date: Tue, 18 Nov 2025 20:00:39 +0100
Message-ID: <20251118190053.39015-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Since commit b66f73a0 ("hw/sd: Add SDHC support for SD card SPI-mode"),
the CARD_POWER_UP bit in the OCR register has been set after reset.
Therefore, checking this bit against zero in sd_response_r1_make() to
determine the card’s idle state is incorrect in SPI mode. As a result,
QEMU makes the U-Boot mmc-spi driver believe the card never leaves the
reset state.

Fixes: 1585ab9f ("hw/sd/sdcard: Fill SPI response bits in card code")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2945
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251110110507.1641042-2-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9c86c016cc9..5aae5413636 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -789,8 +789,7 @@ static size_t sd_response_size(SDState *sd, sd_rsp_type_t rtype)
 static void sd_response_r1_make(SDState *sd, uint8_t *response)
 {
     if (sd_is_spi(sd)) {
-        response[0] = sd->state == sd_idle_state
-                   && !FIELD_EX32(sd->ocr, OCR, CARD_POWER_UP);
+        response[0] = sd->state == sd_idle_state;
         response[0] |= FIELD_EX32(sd->card_status, CSR, ERASE_RESET) << 1;
         response[0] |= FIELD_EX32(sd->card_status, CSR, ILLEGAL_COMMAND) << 2;
         response[0] |= FIELD_EX32(sd->card_status, CSR, COM_CRC_ERROR) << 3;
-- 
2.51.0


