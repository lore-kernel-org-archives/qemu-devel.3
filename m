Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC0CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQ31-0006mV-TH; Mon, 10 Nov 2025 06:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPi1-0002Jr-4c
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:22 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1vIPhz-0003h7-9J
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:05:16 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-29516a36affso26429365ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762772714; x=1763377514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaPRV3m2ug6rViwh4fj+exaEjkJN6PuQ+MHs9M0qPJg=;
 b=FWOurqUrNaXbhsgQfnTtPh6i1CiiBIN47m+y8pX9mXE+NdCkhExNi3HV0pV7w0gdyC
 27kuzBaxEuga2qJwyYLXcrZ2DryiYUL0zETKW8pRx5TEpBJqf1FWDh5c/Zd08R/z5brg
 Wksmdq441MX1LXK03BN9Q21wT/ePzvwvPXclOH4AgF9phhxsit7oxhmei1mHq4d9XemH
 TYVW4v2L2YfESv4NVPdH6jgMPpN3vY+eOIlzDyMXNc0UVRcpwWj01u5LG8EJdmq9ar74
 E/yvcKN3t7PhTQ63AN9xyZBcFUb61jJWA66FZM3tN8LEXHAgeR+sQLKoWu5uA78jnrIB
 +PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762772714; x=1763377514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaPRV3m2ug6rViwh4fj+exaEjkJN6PuQ+MHs9M0qPJg=;
 b=sF0m3cVFPawuRnhLijetzP9qJr9CiFrfKN2bkj9f1jOqZQI61Z5XhtwhiSeAxxpJkQ
 bLDuo0M1nNf15ZKtboDpoIcgjPT1BaNLwRmWNSTKLG3EG0uru6Znlu+6AlBayShTPPrw
 r63TdHxrv0MKTU9uAb6L8Hzl9UKTFBzUCEIHUZRJ35FPeVZMGQbSpQkfB23KQ4lcL6LD
 hUHev92KHQnKmSszg19IEOK4QaIMiiVp+abh+BdXSNV8gUUJf+6RVcij13/XmUN6dWu1
 SlguwDSl8vtndJbWkJ8KxRdV/xv5r37bSL8IAQFsCtraPRjgbQT5Zfh9RG8bDXU9YFmK
 hQkQ==
X-Gm-Message-State: AOJu0YzLpxnNtp/9qIL3Qz4yN3rUJAkizZdKNPM9dzgEZgbalj5kLsy9
 LAoUIEG6hMFykrmRy+LomGx1Jxu2FCrfJbb8AZ/+3Jn6BKTu2VEe6MshNOdZ866cV0o=
X-Gm-Gg: ASbGnct3n3LPo/cbK3i2rQRTSHZYZaIJsqtkLak3/xc+3ky9usZEedefM9oH3OKW4RG
 nts6iW7Cs6b4B/AOPlRJubUVbAHEQVIm9Aa2ab5ZZsScFbsUttYroe1isYNysc9jk1SDjJpBSiG
 EXhj4dFhKXxERcH7hqT/UP1bJL8yL9LC+exu0DiPAUf85yXIYlxCWwQp/s9L+VmQgQhk/ooDM3+
 X6Z4Z5V28R/wimTlFjEknV7P/aOE1I1igmmvA3GnCvB9FO4QU4j4YVkuKK43MJnIrSK4TjIN65j
 LoQGx2EhiPHG9sZsLMSfmCLUb9ONmVctluj8vIj5RmMqLHcAehlAvUxJTYjzEMtIitGOvkL0Uue
 Qqa9GoYH5rSsnGaSTpXiWicOjTiuPm3mr8YKdPg4DCoxx51X1d4gOFKd18YA2tnDxwA8z7xvacx
 BmD8yNow==
X-Google-Smtp-Source: AGHT+IHW3Fp9tgZVbPsRDikj71R5JdyK7nwYS4hO5MSis4IhWXyi4VX8TfoBGVs1iuclVAecSavGnA==
X-Received: by 2002:a17:903:244a:b0:295:82b5:73e9 with SMTP id
 d9443c01a7336-297e56c9927mr98181715ad.35.1762772713605; 
 Mon, 10 Nov 2025 03:05:13 -0800 (PST)
Received: from ubuntu.. ([111.196.133.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29651ca1b8csm145706605ad.85.2025.11.10.03.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:05:13 -0800 (PST)
From: Bin Meng <bmeng.cn@gmail.com>
To: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] hw/sd: Fix incorrect idle state reporting in R1 response
 for SPI mode
Date: Mon, 10 Nov 2025 19:05:06 +0800
Message-Id: <20251110110507.1641042-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110110507.1641042-1-bmeng.cn@gmail.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---

 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 9c86c016cc..5aae541363 100644
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
2.34.1


