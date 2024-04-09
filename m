Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD80CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruC0v-0006lp-LM; Tue, 09 Apr 2024 09:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC0t-0006km-7C
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:59:51 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruC0r-0004Kr-GZ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:59:50 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5171a529224so2651384e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712671187; x=1713275987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZGqICUxW5wN354pTQBgXCvgubahIrCOAjX9VIoecUc=;
 b=M4Ib1lKzblvBk3t25Mbr00tS8FiB/QWTYg5KT9tuun86kS7RCiBG269KAZzYVLsmhL
 YTW7RwisBwB+jTjNfZdcHeSbDb43B8nZyyr34X/zIZEoPDIfAQfNDN0RAkM9d9yyjOMh
 lYJuWvXgCTNcFaT1xur8Qy2q8peoLxc8dI6lb8MyzVgbjHE8WxfNGvyVbSU79x8U/mH4
 PE6y+EVvuSZcgNN1zxjre21SzYlT4C0e9v1W+iGATSrexjnhjJfQzKPp/FeWMeO0bS44
 Kr07YkxeR6z7zezzxuJOTqLw7VvBzcwQnRble2edtwli55za7K91RvtvesjuyVBxFNKF
 RF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712671187; x=1713275987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZGqICUxW5wN354pTQBgXCvgubahIrCOAjX9VIoecUc=;
 b=adUNE4N3q6TV/DyePUUishi6xtsRLg5FtwP7m+aXaqimk6DgIwulVydXI3hd4snYrz
 oZWUsvxW4bsgaTHy/tmkUVstp5gNVxv0UBXpaErq36vQr0oM/f6mHxEepweMwcTlt3u3
 LvJq7uIxGL1UOgpDUzKAW+1L1pZsiQim38n1H9Go6SlVdszxdL7cKWE2O7XWPrJbwZPt
 0r4m/8fo6JuDGbL88YEp1WLT59ntUmW3ZxPeeuIDl6ue0UP/coDXTYniSqsLN0U/AQEF
 fA+UdAvjwKzr8TGfUIf2jItNV7I5dthjDB7tyshpgAmyu4TwjEeS8JC4Fr3PCvRSTVZs
 Aywg==
X-Gm-Message-State: AOJu0YyayMuDuhyBqaRIftS6IqJENBuz6q0NQ7Bzmqnu3R+xNEhnbiWl
 lvWk981P+wiurwJwqahi2WoFZpVncDMSCEQdW0EB/H9A8Rx4NrT1+zTmM40Cj3GccJdXW6IYEl3
 Z
X-Google-Smtp-Source: AGHT+IEI0oVg30cMyzXRIgqjrsH0EfRvfJ9bp62HVDnJnqjDwr1NieZTQI3fXcE6QXxlvJNoLEoSjA==
X-Received: by 2002:ac2:44ac:0:b0:516:ef63:b7e4 with SMTP id
 c12-20020ac244ac000000b00516ef63b7e4mr4377247lfm.5.1712671187220; 
 Tue, 09 Apr 2024 06:59:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a1709063fce00b00a4e8a47107asm5664475ejj.200.2024.04.09.06.59.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:59:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: Qiang Liu <cyruscyliu@gmail.com>, qemu-block@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 0/3] hw/block/nand: Fix out-of-bound access in NAND
 block buffer
Date: Tue,  9 Apr 2024 15:59:40 +0200
Message-ID: <20240409135944.24997-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Fix for https://gitlab.com/qemu-project/qemu/-/issues/1446

Since v1:
- Addressed Kevin trivial suggestions (unsigned offset)

Philippe Mathieu-Daudé (3):
  hw/block/nand: Factor nand_load_iolen() method out
  hw/block/nand: Have blk_load() take unsigned offset and return boolean
  hw/block/nand: Fix out-of-bound access in NAND block buffer

 hw/block/nand.c | 55 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 17 deletions(-)

-- 
2.41.0


