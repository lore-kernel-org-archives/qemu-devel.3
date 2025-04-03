Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827F3C36014
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0USk-0004r8-Gd; Thu, 03 Apr 2025 19:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USi-0004mU-A8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:08 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0USg-0002Vp-IU
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:59:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso8414365e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724745; x=1744329545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RQZgbk3//J3BzxedrkZtFYJhqEG+znG9jdEhZN1pWQ=;
 b=O0pfH07YSLjXQdFVyrD79VkkVzRYrq2wQmI3i9Z4f2aSUJfUgjwLVKlQh2jRdIjuJ2
 OM5P2KnpFsFvtXegjNKDmHvIwn9Zl4XRTrOIBTHBy+33H4vi5pN3hSLv0KiN3/yx1vtZ
 yBuiNOA1GagOJ2xxxc7brC31LXzka5Sx1LsUBtAzbyWrDYIzfUpNI/qGXo09D182Y2Zv
 o/wuZ0Rp8u5UyV4hiWjGhtXjcuH/qu7NezryNXMsyPQdwhVskrinilozvkmZ8rSaSNpN
 zHzBrhaD6ac/yyBkv7A5KKv2WAXVtDq1jogqleWs6HmAwl4Fc8+s6T3tYfYflVKKb3yl
 L+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724745; x=1744329545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RQZgbk3//J3BzxedrkZtFYJhqEG+znG9jdEhZN1pWQ=;
 b=UrgUScRqs0xw49d7rcI6+tK0FlAfB4qiNR7c/E0mh7ExMHUV9KwoJON7SYON0hTI3Z
 dAKpLoO9epeSGVtK6diIVfWwHzaQNaoDEVZxnke7nr/wCwBqrY5bbvGanL8PISm4yRKr
 4oUwmSXJesipKNX7MeEgIO2dY8gCSSQApJYnE7gmb+2rd4f6qIM8wOHvHP29C5BR3avX
 5lhsco6A7idCMHhavmeYgIcRms3+VmzduE0ZlVVssIjVq/j1oCnz9VOJdB1MDUfb9xHr
 zORRUayCGy/bUBpdq8ufb9yP1kRQSDa8kHmGRCzdFz6hn7pstzKcoGU+Lq1Mqxi0MTnV
 Rqmw==
X-Gm-Message-State: AOJu0Yx48qrI7tnAcBVwncfQVCU2BpFTeawgEmKjxjXyD0eEEQMVizDh
 mPEjous7iyJsypuCJ+NI7e5gW0YlSGC7SqrLSJDMeL0MqidaVESd2mrgIHV4cAo/xKhDoCgzzRY
 g
X-Gm-Gg: ASbGncu2iVjii15sNUW2PzHeDPJrrbfjwWT1GEyE2nsBkXw1QJrFNN6HJWCNaDTy2wS
 HWc5iXIhixxhO5zAPuV51QsJ+9unDBDEqt3e/9WYm8o64B257bvglR9HTc17SH7m6zws39hAD+8
 pHrH/NyvODS3eV4uPSvSoYbwjSJtGqUm9eZ1upXYQuBz6T7fkMWxS02HHAprPNTIlmJSlg7piyz
 /t1icGl/mq97RYLvscz3+RrOtwZpGQC52GKZ9hcuNBDvp+CfWwMPP64N/IvNurKFyH6XGH/yOrL
 MQkrsxbmaiZv1kXrlKcVCM9kFI6bGp15b7RIZGJmx/gv4VT3OXtTqRT1W9MO7NaOGSKTRfcSPmH
 fufXPAEZltuyFBAW6J9vqRKoO5AJpLA==
X-Google-Smtp-Source: AGHT+IHzajYn7ecC5K9sSIAnhnhniAYoy1nuFxnIYcUuwETz6twoh8Wq0ws5ZYVnXEACQWYDkZ5SzQ==
X-Received: by 2002:a05:600c:470d:b0:43d:94:2d1e with SMTP id
 5b1f17b1804b1-43ecf89d169mr5826665e9.13.1743724744629; 
 Thu, 03 Apr 2025 16:59:04 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d66csm3067173f8f.63.2025.04.03.16.59.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 06/39] hw/arm/aspeed: Build objects once
Date: Fri,  4 Apr 2025 01:57:48 +0200
Message-ID: <20250403235821.9909-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 hw/arm/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 09b1cfe5b57..f76e7fb229f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,15 +39,15 @@ arm_common_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'x
 arm_common_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
-arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
+arm_common_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
+  'aspeed_ast27x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-arm_common_ss.add(when: ['CONFIG_ASPEED_SOC', 'TARGET_AARCH64'], if_true: files('aspeed_ast27x0.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
 arm_common_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
 arm_common_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
-- 
2.47.1


