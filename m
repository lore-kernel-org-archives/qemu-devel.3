Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5491ECD11BF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romFX-0002iL-9G; Mon, 25 Mar 2024 11:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFV-0002hz-HD
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:33 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFT-0000EL-P2
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4148ca200a7so401995e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711380510; x=1711985310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TCoF0Ik2WJOdiDikaxpQR9jUBlogBxY6ArmfBRiXluk=;
 b=F3+kZXesV0U7HLq97j6uR1pPmQIwFdk/6BIVMoBjd2pC7PbcN+HfsJOmgpPZMQFFuW
 k0MlIlgK7kmBT5d+CUHqDmKcwBfIpLMar79bVQBXhsKf0uVaNThf3MUbgCr5gf44wkxG
 K6V612JhtH6kkRwZqCYxQuBVExhgVXc2CHN9my1Ko+lPg8beZO8MGxMTc4GqzdlONBZi
 UzRjyXrTRZOvWYK8I3rXwVM/f8hUXpeez0OVh+Im3JHsb7kzWsuRivaWTyJlBnNEuRRw
 acycl64UWHiTYyoSnLVL+p0DGm4WBxfdJ/+NbPPPxQhaLzB8zs5wjZ42dCTZIR6AO0AU
 Expw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380510; x=1711985310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TCoF0Ik2WJOdiDikaxpQR9jUBlogBxY6ArmfBRiXluk=;
 b=ejKHesYKmr7kPnPCYaLLlBGh6HVhJupSgLGAdIAddwBMTvqBzJmpxGaHj1IKEwdjOD
 PR0+4oyyPdY+/3lkVkwcRSumHQ8vJUKXTJj0jyy0v0/24B1kgVZMLdPsnasHY1VbBiqy
 HkIh99rHIhojS+eRQYa1NYNRyQD/hzqRMJn9/AbJt63TMueDBuPSIQOwnhqD3AXC2ueE
 yxn9KbjWJqCkrJb/UMLRfcH+5nPXYrWiIZBs62RbPuPowM0WlqQEpdXachWDRl6qzf63
 ictfuIob2m3Roc6kkGDzhn9RpWXDq0BeegwLQQ45LbuX6wJxvu0NP18Kg3q4TpGf8e/r
 PmWA==
X-Gm-Message-State: AOJu0YwXvfm1tNy+X2lWxpPw5WVzgr4AB62qU98kivcOaWvuAdp9vIQq
 RL0mOUr3+PBNoBFV7CQOBfGQAZBLgWmJNUgeI1s/pUuXQqFHd+WevdvsBL9+2oTkmv4PGz8E8Ob
 G/R4=
X-Google-Smtp-Source: AGHT+IFPbnQi8nZLrkF/W7wtVL6ILis6jKJ6ES9goxOOqichZ/EJtEQnWe626R3+BCSxzmPLDqQjcQ==
X-Received: by 2002:a05:600c:1386:b0:414:9fa:1da2 with SMTP id
 u6-20020a05600c138600b0041409fa1da2mr5053391wmf.15.1711380509796; 
 Mon, 25 Mar 2024 08:28:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adfcd8d000000b0033eab3520a9sm9740497wrj.43.2024.03.25.08.28.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 08:28:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v3 0/3] hw/clock: Propagate clock changes when
 STM32L4X5 MUX is updated
Date: Mon, 25 Mar 2024 16:28:23 +0100
Message-ID: <20240325152827.73817-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Since v2:
- Simpler approach

Since v1:
- Rework API to only propagate when both clock_set
  and clock_set_mul_div modified the clock params
  (Peter & Luc).
- Use that in zynq_slcr.

Per https://www.qemu.org/docs/master/devel/clocks.html#clock-multiplier-and-divider-settings:

  Note that clock_set_mul_div() does not automatically call
  clock_propagate(). If you make a runtime change to the
  multiplier or divider you must call clock_propagate() yourself.

Fix what we forgot to do that in recent commit ec7d83acbd
("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")

Arnaud Minier (1):
  hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock

Philippe Mathieu-Daudé (2):
  hw/clock: Let clock_set_mul_div() return a boolean value
  hw/misc/stm32l4x5_rcc: Inline clock_update() in clock_mux_update()

 docs/devel/clocks.rst   | 4 ++++
 include/hw/clock.h      | 4 +++-
 hw/core/clock.c         | 8 +++++++-
 hw/misc/stm32l4x5_rcc.c | 9 +++++++--
 4 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.41.0


