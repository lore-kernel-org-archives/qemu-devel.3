Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF013C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:09:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJk-00038f-3B; Fri, 21 Jun 2024 04:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJi-00030v-VJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:19 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJh-0000G0-An
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-361b376236fso1360213f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957295; x=1719562095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrM3efyRCu1QkbrTwevnMmKic+tLELy+xxKVC8SkWoM=;
 b=AUgC+bQW7p3JbY6N072B346iISSL8atQfujr3DFDIvIdghVX0q8ncbvT0W0YxZz8Hs
 KNK/TfHLDxNb/yxHgyovUnmw9+B1eNEFbHoCSAR8kQEkUtvH86V4QzRMJiUV3foyNX8l
 La9ozZqQ5noS0PdgSkMJMMNc0bfaT6BgzmW7RZZcdvdZbbk42a7aweKgyWosT9uQNFGn
 h3PhrnFCr4v3YZyZO+rFaNHxpWLZSqCag0zouCd/83FHuvL4vwfcI44bk4PIGTQ1OIg0
 hffD5sVOKlzfIYrnSbEygWhagctgwCBKxwTONLOGXIYLSSPonZKZ6CnTnL4a7S9phyYv
 tEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957295; x=1719562095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrM3efyRCu1QkbrTwevnMmKic+tLELy+xxKVC8SkWoM=;
 b=EayiECJ5UoehaJJ0p2U5Ft6Iy+vsl6me1nd3PXrKhNSVRZBo7KPw/9ZWsYxzYACb5m
 4q5wyU6psdVAgTU6WVtJk/qw1V2yeRzsIq8OGy5O2vnCWYXyjx976A0Mb1DG/imzKvWg
 ES9wroB7EFumUb30+DwHrj+djp0U6c+7545ibefRSxY9RPXOZxxonE76wG/a111x5Q06
 6QBpV7qRs+nDpVJAgnQWEHia1JoSc+NO2ZOO5JQ6fniPXSLKkYscNqij1SyA86QCG2Lm
 zXiJgWFbbLOAvGhjEKo/UFKwmuGU48+7R/HtdjUhFVIY+lKRtkqx21uwr0N0JsIgHng0
 c2NA==
X-Gm-Message-State: AOJu0YwrCbisWQHzT+hesIuKmBTVs+CtLRPwVEFQ/HHxlAzVQlvB2mtc
 hPuYsxJ3nqh60t++weips94wjfO3CrAqhSNA7cALenUlrzshXZzimGWP37Uw6Hjny4BOap3PuRR
 A
X-Google-Smtp-Source: AGHT+IEcHYEoyqhybdTGHtCZvNI0/lSR1E3tQrPwQw8kmuEc56BKpn3N+cApRVJk/2a++N7ZqvQ1Wg==
X-Received: by 2002:adf:f24a:0:b0:35f:10a0:9b7 with SMTP id
 ffacd0b85a97d-363195b2213mr5220400f8f.46.1718957295460; 
 Fri, 21 Jun 2024 01:08:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9bd0fsm974292f8f.52.2024.06.21.01.08.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:08:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 23/23] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
Date: Fri, 21 Jun 2024 10:05:54 +0200
Message-ID: <20240621080554.18986-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Per sections 3.6.1 (SD Bus Protocol), 4.3.4 "Data Write"
and 7.3.2 (Responses):

  In the CMD line the Most Significant Bit is transmitted first.

Use the stl_be_p() helper to store the value in big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 601a6908aa..5d572ad13c 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1659,8 +1659,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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


