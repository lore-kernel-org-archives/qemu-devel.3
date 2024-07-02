Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780CAC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhu-000187-Bh; Tue, 02 Jul 2024 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhq-00017X-Sq
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:48 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhm-0006R6-8M
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:45 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ebe785b234so40005991fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912095; x=1720516895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+BJVqbuDB73td3icnKEL+Hn1IcWwELHqxD1Mx9jzZME=;
 b=SN9ZqQb2ehnCRFlBL5bHkWdxGBIhpsiuuNYFscBAzs1Fd+JisZiijgV/OR8iAe2YP3
 rqSOyMpXj3va7W3GCmZhEQAQjfySW37nppdZdmxb38cTLC1OB1W/9ApwTtAJ+kIJMSS7
 qfbgYueMvXnt8pjIKAmt2CoolVcBVwb/GOj7pspDZCO8Ex8MOM+NuNiIkYpE147D929D
 eFR5F2mKLFMCrl40zNDbSzHsTUZMSbQS7RRi9f2Tbkdoe77ePHVqxiFZ24op+OZrQiVQ
 Df53Ko84p/Q41zsfarf1LkAN4aGKtwZB6QX0fOb4z9xMnHsamKsOlScFtwwB5+/SJKBp
 Z0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912095; x=1720516895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+BJVqbuDB73td3icnKEL+Hn1IcWwELHqxD1Mx9jzZME=;
 b=htDGm6ISl4Es3h7u3bAffGLD8kEDQaIbP1XW47QhWhQy8iADKiqcREOkB7JupYlJNe
 uyBKJ2MaK6U6/AWcmQ2oNoEZkAVSNrTkx153b8o6npX4pAVK196sEosKDmyAWr28ZPRn
 OtbGDOfPRpiBSnIGkNo3RuIRwLTEM4KX3Y/2Pz01M5rwQJ+AnmCi5FI9L4ErpkGJBZVB
 WXXo+t/5NzNRhTkByPmV2ZhZafiDoHc65hTScgXGXbc1uMQcqe8rDnq5wOfwyQj3iwtO
 6PmOcTOdBH0qXCGKkQEYl7+Op8IPzkxxrxDAJsgnruw77mxCyzpxgiQ0dkkhOIJhTDSA
 fYVg==
X-Gm-Message-State: AOJu0YzbPNETf2VL8/EVj+nMo2uLILqgVKzKPvy4JSnmtaNNGMVA72Cp
 yvNPmiBp4MINhiKpTHBVlVhoe7c+aTBikIEuc7OvazE4Po1asIN2daaeX224S6zl5uXjiqUTeEU
 T
X-Google-Smtp-Source: AGHT+IFl4hgc/yNQvJmQgunSI2cYavv9Ubr3AySMQQr/t3A4wpxrrHGW7+Yf3Ylnz+5pjaauUWC1uw==
X-Received: by 2002:a2e:9793:0:b0:2ec:5518:9550 with SMTP id
 38308e7fff4ca-2ee5e390c38mr55097991fa.10.1719912095005; 
 Tue, 02 Jul 2024 02:21:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a2bcsm187830895e9.36.2024.07.02.02.21.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 07/67] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
Date: Tue,  2 Jul 2024 11:19:50 +0200
Message-ID: <20240702092051.45754-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Per sections 3.6.1 (SD Bus Protocol), 4.3.4 "Data Write"
and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Fixes: a1bb27b1e9 ("Initial SD card emulation")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240628070216.92609-9-philmd@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1e9530f9ae..54bb0ff1c9 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1669,8 +1669,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
     case 22:  /* ACMD22: SEND_NUM_WR_BLOCKS */
         switch (sd->state) {
         case sd_transfer_state:
-            *(uint32_t *) sd->data = sd->blk_written;
-
+            stl_be_p(sd->data, sd->blk_written);
             sd->state = sd_sendingdata_state;
             sd->data_start = 0;
             sd->data_offset = 0;
-- 
2.41.0


