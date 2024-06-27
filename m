Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B32C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 07:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMjHs-0006JU-Ir; Thu, 27 Jun 2024 03:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHn-0006HU-TE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMjHm-0004qp-6V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 03:11:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4255fc43f1cso8944855e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 00:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719472266; x=1720077066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BvAUzJDJRk95OJML/aybeF+xlz5tOaGkq6qYevEQMg=;
 b=odl2hVqZAzT4ztk9XKmoSDcebJxiBsFJhuVLEUWdqZXw+jvyFMAHHirsgDf0nTbdSa
 lI1EPkVEFQFLj42/GamEyhPQOk4B9DzkuTtqLDmpPsuq9sVFdZkyH5xAnv+HCT53VkeF
 Rr04wQNkgGUxS8LO4weWGvO4S8bQuIWkMzdiu6IM948mp4QV5YcI4E3JevKDjEU7JHVg
 Stjur+uIeBlReiRDxoLZedtq4mAZ52La3t4KsPAW/nQQEDhMqirg2te/g+uxtESPyEVm
 Nkm7hduc2TMr3R5TWfQOC0FPLmlH14FUazu/c8lSejXv+HA9rwTLaqoMPm8bm1AMssZ7
 Yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719472266; x=1720077066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1BvAUzJDJRk95OJML/aybeF+xlz5tOaGkq6qYevEQMg=;
 b=nrTfwlntEvLSnz8ET2vI6s7z79H0GT8hXALnPDj6Hesfd790eNiokRgsuUB58GWtTu
 lIp1KPf9hh6EEzlYs5UQGprDd8EMelJ2Nn7pKecthLxkinlnCC/oKRsl+qj9VyVJriK+
 N74JcBljD9f/lqKLSAhoKDyx1vxOMPY0qo+ukBi0pDrJ3qxjrG+AU878G7+uHm8xgdj1
 4Iqj2pi6JpjLnLLFI6wVK00YGjyK0t9h0v85GITZblObjutn9VQCAkFjjKlMdMFkDb8+
 5pfsl87or1nx7It9djKculUBYDmPUFgvtblhdE/dLFJ7Vvkz8MwSZGBljwrVc1hfxxPb
 kXJQ==
X-Gm-Message-State: AOJu0Yy+DZpvwlbMAPQhKYUNVeebVjAiLJWH21dftDIXDARf/lqdEsAD
 MxPyzrF/FbOcSArUv4t35Rl+sCGMYyhno6RpdKj/UnBou5MNUc3TtjIfKtX7quYhwPUENf2Md21
 llVs=
X-Google-Smtp-Source: AGHT+IFuzwL9+Ud6NHoY1okbe19bVu2ehNQ2veeCej8S5qR6kvWCvUQnRFRIybf9+7CfNs1TB8TT7Q==
X-Received: by 2002:a05:600c:3ac3:b0:424:9593:29e5 with SMTP id
 5b1f17b1804b1-42495932ab4mr68789885e9.40.1719472266339; 
 Thu, 27 Jun 2024 00:11:06 -0700 (PDT)
Received: from localhost.localdomain (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564b7b7a5sm12282925e9.24.2024.06.27.00.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 00:11:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 devel@lists.libvirt.org, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 2/3] hw/sd/sdcard: Use spec v3.01 by default
Date: Thu, 27 Jun 2024 09:10:38 +0200
Message-ID: <20240627071040.36190-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627071040.36190-1-philmd@linaro.org>
References: <20240627071040.36190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Recent SDHCI expect cards to support the v3.01 spec
to negociate lower I/O voltage. Select it by default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a48010cfc1..d0a1d5db18 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2280,7 +2280,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
 static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
-                      spec_version, SD_PHY_SPECv2_00_VERS),
+                      spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
     /* We do not model the chip select pin, so allow the board to select
      * whether card should be in SSI or MMC/SD mode.  It is also up to the
-- 
2.41.0


