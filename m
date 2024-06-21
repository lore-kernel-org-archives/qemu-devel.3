Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE0EC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZI7-0005Gn-Vj; Fri, 21 Jun 2024 04:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZI4-0005Bo-EY
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:36 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZI2-0008Iy-TU
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:36 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cd790645eso283956e87.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957193; x=1719561993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=724kW79TXJGwyxkrPpGmpC8jMcTbNAzL87slxzj18o8=;
 b=z4ZdYyxHEcoC5Km3cyQh/tWqGz61JDUhMzY/mAAIUiTw/FyFoXlWUXyfKPWWhWBa2Z
 rE8Q/7HwYpnTH0aJS+uGEsIs/lZC2hiP0vrm6UExuG5DCc7G6233Y2CqLgIwx5hwIegK
 c6egxQpnofpiH2fRpyM9jskAByMKYTtHfwXkSdKSULJnWgMQ3mlNfVxAdyq1+Pbs6PnH
 Jq5nfoj25R1N6c1a5eOiXzb1bk7QwJNqO4LpdsgIlwuwVSajpN4MUjpCdJ1U/1TgDVqM
 vF7qMdITnTj1DDfFHFBD1LPrvhYKoI0cFOZTrd93CuPLF/7Q8AJZndyTgtBp6oVFeaS6
 WFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957193; x=1719561993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=724kW79TXJGwyxkrPpGmpC8jMcTbNAzL87slxzj18o8=;
 b=ZMkBq7cbN0mG2FPeZbRr9Wm03dOiJCWe/DfXj6zPZDQV3PZrdbXQ9ky3x9QvF66min
 Ekm+iMqHEzRMh0v4Q5mn0Cex971e+0ofUgCePUxRQq0MVhiEgGUV3T3LCUvbKyvqUDj9
 kvfENNsrp8fVjPJPisHC9frj0wdaLyCOcw2cJOnztRG5oq2QAxVFJA06zHo3UuL45R14
 avGMMUigEI1UUa8sIem/VtDwyCkPTe3EyC5cI07WI3b7hFMiABR6qVcemeRMROGgy46X
 xj19oxA2k2KSx8/MdyjhEez//YVoG/2XbScRqFcy714hPqpdV3gk+C2HdDUIrOPF7HrB
 RTTw==
X-Gm-Message-State: AOJu0YwE+/1X4gSGv4tBf+x+brRzZ5AJ9c/a8KalLxcGpc3FXO8Nrz+V
 iRKSGJLzphJQsIGBOoq5Xp/Imeef9oWfzEXjHUu7z3VzUlgLxVTWJWiPocxeaxiyJO21xQNUgAy
 b
X-Google-Smtp-Source: AGHT+IGF+RXH6ISxE641vWAocQv7AwcSVCSODQbtcRZUwnMSOBm0UvFeguDTovwJ67ffv527nJtiSg==
X-Received: by 2002:ac2:558e:0:b0:52c:c953:3c1c with SMTP id
 2adb3069b0e04-52ccaa600dfmr4509217e87.36.1718957192959; 
 Fri, 21 Jun 2024 01:06:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f6f36sm968427f8f.71.2024.06.21.01.06.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:06:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 06/23] hw/sd/sdcard: Use Load/Store API to fill some CID/CSD
 registers
Date: Fri, 21 Jun 2024 10:05:37 +0200
Message-ID: <20240621080554.18986-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The ld/st API helps noticing CID or CSD bytes refer
to the same field. Multi-bytes fields are stored MSB
first in CID / CSD.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 24415cb9f0..b0cd30c657 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -393,10 +393,7 @@ static void sd_set_cid(SDState *sd)
     sd->cid[6] = PNM[3];
     sd->cid[7] = PNM[4];
     sd->cid[8] = PRV;       /* Fake product revision (PRV) */
-    sd->cid[9] = 0xde;      /* Fake serial number (PSN) */
-    sd->cid[10] = 0xad;
-    sd->cid[11] = 0xbe;
-    sd->cid[12] = 0xef;
+    stl_be_p(&sd->cid[9], 0xdeadbeef); /* Fake serial number (PSN) */
     sd->cid[13] = 0x00 |    /* Manufacture date (MDT) */
         ((MDT_YR - 2000) / 10);
     sd->cid[14] = ((MDT_YR % 10) << 4) | MDT_MON;
@@ -462,9 +459,7 @@ static void sd_set_csd(SDState *sd, uint64_t size)
         sd->csd[4] = 0x5b;
         sd->csd[5] = 0x59;
         sd->csd[6] = 0x00;
-        sd->csd[7] = (size >> 16) & 0xff;
-        sd->csd[8] = (size >> 8) & 0xff;
-        sd->csd[9] = (size & 0xff);
+        st24_be_p(&sd->csd[7], size);
         sd->csd[10] = 0x7f;
         sd->csd[11] = 0x80;
         sd->csd[12] = 0x0a;
-- 
2.41.0


