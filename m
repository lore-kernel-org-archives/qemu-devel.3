Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0251FC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzLC-0003WK-Id; Tue, 25 Feb 2025 13:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJc-00008A-Sd
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJW-0002KL-Tq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:54 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4398738217aso51925765e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506748; x=1741111548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tb2z/iCBDw+9Y/MjKpZH7HRISmiI4M+r/On2sHYXwd8=;
 b=woGqJns1t8osTEGxTxkIr4D5patN8YB35O8YuhW/xFFtr5VXS2mzhqgfaDAthAFb6X
 of6GRdpKW9I3n0l/RPNcW1B/BiLKDD2ne7ad19Ox3LeUMWDZUJmZ3vS8WVRXkfEoqcch
 XD/d6dOMCsyAVMzN54EWYl4nAL7ieSmCQfy+0iF2aXlh8zNR3VSNkYEytsA8sPz+8Ols
 F3/DNLYQfy/RbqWv6Rjx0hN9mLkwdKAtBGiHRwXkBnFLgRHXMpsbHjI0wrR8MwyQp2vk
 dl+AQx6Uiu7KluZFYJ5XeKoWjNCg+pdKd0qj1xGCi4Mgy4weubIs9NTz0Baot7wdNMg/
 rKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506748; x=1741111548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tb2z/iCBDw+9Y/MjKpZH7HRISmiI4M+r/On2sHYXwd8=;
 b=bxZSQbwGfgnZH7MmDE0HaYNK9TMgGsRY41My+M6jf58J1f/UasG0MwXzZ8CpV95g/3
 eE8soXpA5mcWL2tqbOuVSmDR0k144Spw4HvAeTgMTLrSGHT7DK3NWs1ltooOhsvtRZuj
 +FudJQ2aKpkPQmfld9Hz842B+GO3GU0tfshmrj8HVHYbHmiz52QHqG9O+R8W+l7NkyUC
 Cs8Uo5hhVBHrP8bKrJv1iWLv4qPGD20YJ3aD/pAuLU48+YU5ddqs26X6WrWthaBStj66
 RYOapeqKn7kOsBcuqlASxev5NuQ5FyjQtFTtfFSrFr72vxZAfDEg7lsEfujogBtaEO/J
 uzbw==
X-Gm-Message-State: AOJu0Ywj1BYteYkzwiaqeBGpepe7i7NFLeldGVR2aCwxpZ70dcl4SKBv
 v98adk0KX5s5E83emIStcPbojtk8kiUuFkN8exikI9oRQWA7TFSReluovaf5ihI57n89HcGgYHg
 4
X-Gm-Gg: ASbGnctK3MEYlxr3HlNHRyiRhzFY5Zfue73hBahjN94L6ZdZvhDpevUYUE/cIbeoHKO
 uofDrhqvCACQ7P5UAwpvi/fl99Ka+nge99WxMjr7CMaFx77lJdmcP0MTQhBnDdj+jvApv7m73us
 IeIW47IHcT1rJM7GNtGN09Y+5dqexs/mUSJeR87LvWxJtF5P/udnESeVSA7mhQ9OE41wFU2HmY3
 kEAD2Ur7bZZWDTohkCmtk2tFjDQbIMfWiL7hflvVT0YfdzgvVFyITLPqnxPWBDQXtGmqOSfD51I
 gApJixfNKeaaudXnM2Q0vlF3m4Q+S7J3
X-Google-Smtp-Source: AGHT+IEnA8zcZn3yiQzzQVUbKi1AgxW3E3uckNpzWcuWMKxBO5pJUsYVb2wo5VQi1FLmXqEwl1yp+A==
X-Received: by 2002:a05:600c:190e:b0:439:689b:99eb with SMTP id
 5b1f17b1804b1-43ab8fd8768mr4906095e9.7.1740506747063; 
 Tue, 25 Feb 2025 10:05:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] hw/gpio/pca955*: Move Kconfig switches next to
 implementations
Date: Tue, 25 Feb 2025 18:04:56 +0000
Message-ID: <20250225180510.1318207-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The move of the Kconfig bits to hw/gpio is fixing a bug in 6328d8ffa6cb9d
("misc/pca955*: Move models under hw/gpio"), which moved the code but forgot to
move the Kconfig sections.

Fixes: 6328d8ffa6cb9d "misc/pca955*: Move models under hw/gpio"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-4-shentey@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/gpio/Kconfig | 8 ++++++++
 hw/misc/Kconfig | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index c423e10f59f..a209294c20c 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,6 +16,14 @@ config SIFIVE_GPIO
 config STM32L4X5_GPIO
     bool
 
+config PCA9552
+    bool
+    depends on I2C
+
+config PCA9554
+    bool
+    depends on I2C
+
 config PCF8574
     bool
     depends on I2C
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c3..4271e2f4ac9 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -30,14 +30,6 @@ config EDU
     default y if TEST_DEVICES
     depends on PCI && MSI_NONBROKEN
 
-config PCA9552
-    bool
-    depends on I2C
-
-config PCA9554
-    bool
-    depends on I2C
-
 config I2C_ECHO
     bool
     default y if TEST_DEVICES
-- 
2.43.0


