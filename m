Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DFC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMrvc-0008VA-BY; Thu, 27 Jun 2024 12:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvQ-0007oD-G3
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:44 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrvA-0000gx-Ri
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:44 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ee4ae13aabso9346341fa.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505466; x=1720110266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUpbb+xwTJn80OMiSW9qrPEenBatfvxaYEHBd94Y0+o=;
 b=T8f37Yzuh+Rkkz6gi45k+5bkgO7ImEb2laGIZVWd3PTj0uQf+EBXS+S8LzLJiio9hE
 Th5jushr+e+qu3V/MrN4Iz1v7R9jVgeZWssYPFqT0XS2K5JbPiznYxUC55/ZZ4axhS9k
 y3sViUmv55vLfdLkFXaVbLYUShY1+hI2hBo3cfupDdlEPP9fVWaUFg90phx1aw8qQUqc
 5USdhpHnSXbmU48HTUIN0qaJQDxLDaTxD7hdGbzpR3rDeOKrUETNd3eOuGFzsjQ1bh4M
 E6b6UYxaGEZ5qgwxk34zUD30lQqZ6wByHR5HY/11EsvwslsVxXsYkx6Ez4454W8DdJdI
 2Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505466; x=1720110266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUpbb+xwTJn80OMiSW9qrPEenBatfvxaYEHBd94Y0+o=;
 b=CtyoexJoM5ZC8OwdcYO0yNt9twMYv52j8Ll55A2NFIXmuQ+NVSbhUtHZbQGzJRldUY
 1wccF7sPszBe0L5Nz4RRMuNyhEumiofeTg9bAxeCkVhGniJxxj3aKXuKrZv9KL/JF0+o
 0xnHDbMMHT/WV5826vouQG/tLE3YZw/vxJPpp/8jW1qikRg2e7/Wtxda4waAPOzp8baG
 M5Cz+ExsCammcmYL3XA5xxrb9NSjinlyxbz1gt6wOkGAWg909rQXdg60LZWPJ+vrOfif
 UIilTG6H6jWEGXm4PqR2JaHHrWCwR8DpXQ8+B7NX0j7SPuWocvVmofcrMNnQF+5WtN78
 l0sA==
X-Gm-Message-State: AOJu0YxNpwtIx/em6STYrZo0n1y4tFpJ6kSZj8AsNCerPamwot9PfBF1
 x4URQ8bkBEBFUc+meOh7DT6YUSQCbddQbgIlk0z+NO4HeB3roNYu2r10bhJ5ThYyPOz9V4ZB2Pc
 ZeFA=
X-Google-Smtp-Source: AGHT+IEl7GF1fSXgPe17ScBV5waF0VuRjYe8+w5nLlve1Eg8XwNTXQbvEMTps4Woz/fkGkqWHDXBcA==
X-Received: by 2002:a05:651c:1991:b0:2ec:5bb2:c230 with SMTP id
 38308e7fff4ca-2ec5bb2c26bmr114074301fa.12.1719505466214; 
 Thu, 27 Jun 2024 09:24:26 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564a4da40sm36326085e9.5.2024.06.27.09.24.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:24:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 08/17] hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first
 (ACMD22)
Date: Thu, 27 Jun 2024 18:22:23 +0200
Message-ID: <20240627162232.80428-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


