Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BB0C3601B
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UT1-0005Tn-2m; Thu, 03 Apr 2025 19:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USu-0005K0-RT
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USt-0002YD-DC
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:20 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso9328725e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724757; x=1744329557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MCDIwE5yiT5/YaudRHiQiWyT+TmWH+fJEge5GlDyh2k=;
 b=kBHaxrD4rxnJG5eJr19MWuAqd06lQJmES3VbvCCljXhMObCh8rbrrVdBlEZlWnehwb
 5mYDaLr2SFw1In8Pb5GMUGMlmQ4eiinveYVW+sC8MRHQOC/L45HP+Y/rLw2o98g8vp3U
 yeFmXeN1/3uRREp2EaR8jO+kNAfTHyQmXLZpDA8WBnoz3lpgBYnnmQUgtJBirM8A2T/l
 zbsKR0QCBmmRChcp5tc1+q9ytG1Em4GwaLYne1aNNvQ5LUGKSEURTiZg7vBXQ+hb46Dg
 ABlMH2MqWnYCPRXwp05e5tM1aPvVxFtlVE7WBKuHoptCfejDM9k15qG1nVsIr/oZtALu
 Q0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724757; x=1744329557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCDIwE5yiT5/YaudRHiQiWyT+TmWH+fJEge5GlDyh2k=;
 b=PqHwYSR8qKNzd5atJQbc/h0p2aGvncHUs584NowlYIPX3pmQGscWD9EAf+1kXA5ySn
 qmag4fIEDwg8zFpo6hCXNLkirYMhnuSYu6IMdeYwwdo8Q7sWb3DRsaQvRsf0BoGpYcQ1
 mM/+2+OesBOHbfG6tcfX4fgbR+69N6YFqkkHDgBrKtNzBhQPBuGEO9nUZeZCt1Qxb+fb
 lU7NUQ4mtTnfqRf6Wxw4+OWe9hOejivQqI9R9on4QBP9y+Fl4P8qRz7aFWYcnhJBSVO0
 EqDzxqlFTODt7816XhCZnzwwsRKB1sofBPhjZ6NSiThZYMaVqfdez8mOk59Ff5c0Ta4a
 QyEg==
X-Gm-Message-State: AOJu0YwdFcvmBqJGtNqNf43DGPkMv0saaWuY9zbRHiAeL+9b0Ar4NZ/A
 Ja369nmDXcfO67IcQGhm87lrmmkbGAJZniezxN9Oy6ZjBN+4F37/HU2jZBtRo40QvPgVPWoXHfd
 Y
X-Gm-Gg: ASbGnctVLMZCjH9SJiKCjdqJWv013FEph3YynoU+yqBFXs71MO79wZGMtk35NYslQJp
 hX/lHjYvawSQ/ZTtOQDbx6mKQhHvoZEjh8qv2YtI9SMeoECb32FAx+Wgy6yxSNdtefAbReCMzpi
 o0yXDS34E5z7ghXben76sWESuZo/1i6VqBEXb3PrtH+vlLNOYyD58loFmVNUi+apWE5B+mBQqX4
 6wqq34ft+1/e6qGNt7qiUHuXQvvLEP0hjNr284F2xOS6z0/gb+a8sPwGfhDDwLP9KV8S5rNQwwg
 QslSarG3X0401lUeUe8YxfwIM6wGtImtsubYKncoVm49zPaaG25eXxDmQ0r14FarjKDPkNDaF0O
 U1i3FRFjI8Cf1X7ROPCc=
X-Google-Smtp-Source: AGHT+IHVkd8k/wNmjZAWLJUcLA0poKGBSPgk0nN4+HT7fbyw1978bs9JLLV19Gh9IutZYmK2yNE+dw==
X-Received: by 2002:a05:6000:2406:b0:39c:12f2:4b7e with SMTP id
 ffacd0b85a97d-39cb357588emr865665f8f.9.1743724757538; 
 Thu, 03 Apr 2025 16:59:17 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34bf258sm30605645e9.23.2025.04.03.16.59.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 08/39] hw/arm/raspi: Build objects once
Date: Fri,  4 Apr 2025 01:57:50 +0200
Message-ID: <20250403235821.9909-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/meson.build | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f76e7fb229f..f52034ff6a2 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -27,8 +27,12 @@ arm_common_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_common_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
-arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_common_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_common_ss.add(when: 'CONFIG_RASPI', if_true: files(
+  'bcm2836.c',
+  'bcm2838.c',
+  'raspi.c',
+  'raspi4b.c',
+))
 arm_common_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_common_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
-- 
2.47.1


