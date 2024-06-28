Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9789FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5dU-000052-0l; Fri, 28 Jun 2024 03:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dR-0008WO-NT
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:05 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5dP-0006h3-Ny
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:03:05 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-36532d177a0so184140f8f.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558181; x=1720162981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vUpbb+xwTJn80OMiSW9qrPEenBatfvxaYEHBd94Y0+o=;
 b=lQZsuHz4Ro9YM7u+zMnaNtkwXOvAY2d66NHxev0OUD2ZXsjNiYXcjg5C2Xm48611NG
 GEQUO6DubIXqlY8cDrpyoxEAJXL6uS3A1ilG9g/YdpfEi8uz+7hHD7SUeaTlJEyzBEGR
 9h2dDsDdbgISA0r2/aHVGM/CAV6mNwr64S203e0DgC6ZrROSnIY9g6eqzVGdbiJVvfAe
 ZDkJJ+dD4teM12O4IUwBKmyB2Z+4f6YP+NZfWMYbTTFCMp54DNx7j4qUsuvK38y8f6h4
 iIMTBv14Nxh+zStEaN+gutP2Y0knQFK4+qQ0mg8Kw28qKdwbbGstZSwT+X/A5usKI/rP
 yaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558181; x=1720162981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUpbb+xwTJn80OMiSW9qrPEenBatfvxaYEHBd94Y0+o=;
 b=A16cFvp439sVNSf+c61Wx22Tsw6PEOJKYbTM8RdWkBMqOJS2hd22EardEcDCLLR2mF
 ZTKMzj5bLzxlH5Koqoo+OYr/s89BbXPfk467P6a40q8iqPA4Ea2Na2OwBgu2Hu26T41N
 O1TXEkvvBgfv5u6g++LDT6ZQb5vJaT/tysAIoGmOGajC7qU92hug+c5t9K3XGnA+TJdY
 QxzzBBrEyzjvQFXuO5VKL8mqqvtfK23gYDZRlwEe3RjeNRsiRxE7IgnHQIt1G89o3T3e
 zm50DMfQUtp6jrMnNWRYEWsimnjQVkmBDCL4tfe1/nlFtRjCVbxIlCzRKXh46cwBbLkJ
 PHZQ==
X-Gm-Message-State: AOJu0YwBbMY1olkdmfrIjL5cHsGTT5gZAZHNfwwdGIc9jCRu7mWlWt0W
 oLlHR6QmZSOT36UGrZZcyw1gpIzmJ4kA4Z8BOnw/J540CljP4GIx6zr5g/o8Tj+k1/mo0L0Xuw0
 Wx6c=
X-Google-Smtp-Source: AGHT+IHvTRIVnU+N/yC7+6QuGxEUH4dyseByZh1TNJOfenloBTsWHH02iqGK+R9I182zWQBJpnjULQ==
X-Received: by 2002:a5d:598a:0:b0:366:eeea:c4d1 with SMTP id
 ffacd0b85a97d-366eeeb3980mr12256450f8f.35.1719558181679; 
 Fri, 28 Jun 2024 00:03:01 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10307bsm1312973f8f.94.2024.06.28.00.03.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:03:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 08/98] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first
 (ACMD22)
Date: Fri, 28 Jun 2024 09:00:44 +0200
Message-ID: <20240628070216.92609-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC because I'm surprised this has been unnoticed for 17 years
(commit a1bb27b1e9 "initial SD card emulation", April 2007).

Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/sd/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4e09640852..1f37d9c93a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1668,8 +1668,7 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
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


