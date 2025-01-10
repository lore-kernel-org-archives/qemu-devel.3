Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06FDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTJ-0007Kz-PL; Fri, 10 Jan 2025 11:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSe-0007DM-RP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:14 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSc-0004Aj-0V
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1935924f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524927; x=1737129727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/TSOi3MOBYvnCM2gvvOyUyt5uwexAoG6kvoI2QdXq6E=;
 b=ZChRfpNxDrRIm2JHr9s3rL1ybp/GPDWyksB0tuk5iiyMPhNjQBqIDFysB1/9Zuvxa2
 rmKKIIp6dS+/XtnfXUUSt+kUQqKoYpSwJKPhirnXEgeaIYh8pLgieKwcFa2a7o+oqHaE
 FFlGq56GtX7LpVkaTR35Gn4dcQUSH4ko0oCMMOFxPWYjFFHjEmX/sPFe9tuRPn+peJUu
 3ymSuJMQk3rU6UJ142pOl4eBa3LGWFFL9UHCuZZLA3b/UaeEmFif8uyLSp15iWPvcUvw
 Mm60KiPDp1+fAfLNxXeONNil2S6yiaXQEokOXHBd0MDPLBiHRTXXlQnMGKHmc16eMKFO
 bgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524927; x=1737129727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/TSOi3MOBYvnCM2gvvOyUyt5uwexAoG6kvoI2QdXq6E=;
 b=eXxruDlLG472t/MEGNv+57yzgAGtFYXuDGRUsc2BDZQCGrVqAr/p/lDzMCSH3KYHlZ
 oc8cNNW2tSwOUvrblswURcLZZ0ejN6719nngFojHZp1GiMAonUyxW2If9rbvdFIXnxqQ
 JZhvkjpVt5QOdkCsPO2NI1K2eje7/9WggsY3V36JLJKZUr7+nXH/c7Ea89Jg1bpjMRws
 CrSsE2L72uuVT/ZCiYz//mYiamquGdeac42kO5zRLyNFWR65cmwIXQfz6SrVBJtIMAcj
 FLWfYznjsm3ex3cOJPP0yUY7h3P3b0ByAHhYss6ducsCDlvgg+1rZggTwV+zHnEC+06E
 wkXA==
X-Gm-Message-State: AOJu0YyJ9wA4IahIV8C4YhAkxr773nVpPQ24Y9GzHPPf5NdX/OeGoZSG
 4l73PmjXM+ez1WpDMLWwDY6qhrUXd7qNIe2xZ/8cOzrOirsZg1/hMQu9Kswd24AgewPTjiGdHJn
 sPf4=
X-Gm-Gg: ASbGncuG0Mbe26H+Zb0+ExWFigSkh68+hSnDtusoHYHZbhDmaZSO3yeL7yqi9o42Xj0
 lsVUoDUmm4b3UAqZZpQpXVUGWHKtDY8EW9FPQIEJmPmdJMe5RLCcCmHzK1/Dkgv8J1AqKSDGbia
 U0pm5g3IokMfd1izOPC5YAj+YUgm03MAe7i/ZNFOl3VSGz+uM0M+TVULd8/k050MomXYYVQ5rhc
 h3ZvkvayoZGajkhSkPxRwi5xjoRYm8ABWwStvXbRv0/ltnyCcWYWTgPthk+/nEYx95/dL1Yof9H
 nXyL22HBypetQlTSy93+k/wtxz4I3Jg=
X-Google-Smtp-Source: AGHT+IEBl8k8F51KXl7yR0agjBSBtephXQ5vomKafW6+Vcj8D6DFyV5rxuN4A3vndrLWszmZoHmzNA==
X-Received: by 2002:a5d:5885:0:b0:382:5141:f631 with SMTP id
 ffacd0b85a97d-38a872ebcb0mr9745005f8f.29.1736524925875; 
 Fri, 10 Jan 2025 08:02:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38397csm4792939f8f.24.2025.01.10.08.02.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] hw/arm/stellaris: Fix overwritten IRQs and cleanups
Date: Fri, 10 Jan 2025 17:01:55 +0100
Message-ID: <20250110160204.74997-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

- Remove invalid unimplemented I2C#0
- Add DEVCAP() macro to check DeviceCapability registers
- Check DEVCAP() before creating devices
- Use 4 inputs for ADC, wire each timer output properly
- Improve documentation

Philippe Mathieu-Daudé (9):
  hw/arm/stellaris: Link each board schematic
  hw/arm/stellaris: Constify read-only arrays
  hw/arm/stellaris: Remove incorrect unimplemented i2c-0 at 0x40002000
  hw/arm/stellaris: Replace magic numbers by definitions
  hw/arm/stellaris: Use DEVCAP macro to access DeviceCapability
    registers
  hw/arm/stellaris: Map both I2C controllers
  hw/arm/stellaris: Only create MPU when available
  hw/arm/stellaris: Only map existing devices as unimplemented
  hw/arm/stellaris: Wire GPTM[#n] output to ADC input #n

 hw/arm/stellaris.c | 146 +++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 44 deletions(-)

-- 
2.47.1


