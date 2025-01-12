Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386DBC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6sX-000723-DU; Sun, 12 Jan 2025 17:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sV-00071Q-U2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6sU-0001Yb-58
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:56:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so38191365e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736722576; x=1737327376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IOAYRcEECAAnm/ibPu65QtP1Fqg4u5OgmCZcVVc+/O8=;
 b=ZYyrTqSC3piZlIWUd9Y7/IiU46oz1PK4EWkGKuJfLVR6T8IRFl7wnSRdT6OOpVeqjj
 DR9fSrAjPeD5wdeL+tX/qAJSIAlTiMnmy0W4HKnIYo0xL9x3kcsQsutp0XvhcBTYWNWJ
 11ERdy9bsm+T62pmz3hC1zRfPAW4QdZnHxcmgEF9maBvjtpeb+XRScGi7rD0Pw/ObyeE
 pQHHcPxMV3tpd/FanpRwE8Q/vlVEHKFjp2XDn/bT4h/BvsPC47dNLDutnb4Y87451XlF
 DeZDpUl/GXsCpetWbncmvTZkaspAu/FgvyZywdqdzfjmd0R5EdE7cY5UjCG4miYB/928
 xeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736722576; x=1737327376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IOAYRcEECAAnm/ibPu65QtP1Fqg4u5OgmCZcVVc+/O8=;
 b=ujnQm2hMGewpzZrIevGLJ3RKf1Y75ehw0HSseFsF8oRYpywpzDpMvz/tGaEs9sKkw/
 YAZ8Ab662X1QhfvROmxyglCivEn4D4UqZHOs4hfvUixXD6rGY5FkmCUc5XrFX9Q5H2xJ
 XPEDxYIa8Ib/lNRSoBpUoxQzf91mEFGr1Rppy2xfLP2Aez6vRK8dYO4Dv4scI9JQxuV5
 XIRUWdXeYMM3Cuu4Wc3j7o0QtHlTUuyhy+b3fJfYc5N+dhZQ+1dgnyX9Y6kDa63U20f5
 Sc+QNeWWlm0a3fp3fj5wco9v0TVAmUpneamQJzX71LcntOis3hZYNtpPWzGxGAAQ9XdT
 /qZg==
X-Gm-Message-State: AOJu0Yxc2BlAh9SSKnuR13fxQM80/roB2Dp/Nww/dWtchu/ngh5rL0S6
 tLaPRysQIM4L6gmvFzGbat8cE6EYqrBwvdM7xkpFfMqPYXtdy9291uJ5BHZCpubNsSOExqNUMMz
 gsNw=
X-Gm-Gg: ASbGncsAogPYVWxwZnAi1IvwzCEVKQaS699tZ4EOlAG34GpzjPJTaGokVk8harugpkY
 mBP+JAjUmkHJHDKapRi/qijZsEqDlGYMoycVyU5wiysR1tSL/diaI7I/RneIcj7I209a7pNmv+G
 1zn4tPR3OtLEH4LT1gR4A/5143M4kChBpkulrQ3sWoID9M75h9qEUDYhzTvKJImby/4FczulpUg
 MVh67aQ2W5/1n1wgtEopWQ0JjLEqschU0BAte2B9HVEeLpvHphRLRm/A5i4Vgnugs3dG4LpShk0
 +gxBcbwd4zHiOk3G7ykbPeLOLxb4L+E=
X-Google-Smtp-Source: AGHT+IFhqSyD3TibCWU6/Rtu3pQ4Mb7OE2keVFEmXrJAOwPax8fMcVIBNzJ2HWgAMEMmHKDVfOmlsw==
X-Received: by 2002:a05:600c:1c1a:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-436e2679a94mr177277555e9.7.1736722576040; 
 Sun, 12 Jan 2025 14:56:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da65a3sm160930895e9.7.2025.01.12.14.56.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:56:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Felipe Balbi <balbi@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] hw/arm/v7m: Remove Cortex-M &first_cpu uses
Date: Sun, 12 Jan 2025 23:56:11 +0100
Message-ID: <20250112225614.33723-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

After renaming a pair of fields in NRF51 & Stellaris boards,
remove the &first_cpu global uses in Cortex-M boards.

Rational is &first_cpu is going to be restricted to generic
accelerator code, then be removed. Similarly the global
'cpus_queue' containing target-agnostic CPUs is going to be
restricted to generic accelerator, thus hw/ won't have direct
access to it anymore.

Note, Cortex-A boards already have been dealt with in
https://lore.kernel.org/qemu-devel/20231212162935.42910-1-philmd@linaro.org/
"hw/cpu/arm: Remove one use of qemu_get_cpu() in A7/A15 MPCore priv"

Philippe Mathieu-Daudé (3):
  hw/arm/nrf51: Rename ARMv7MState 'cpu' -> 'armv7m'
  hw/arm/stellaris: Add 'armv7m' local variable
  hw/arm/v7m: Remove use of &first_cpu in machine_init()

 include/hw/arm/nrf51_soc.h |  2 +-
 hw/arm/b-l475e-iot01a.c    |  2 +-
 hw/arm/microbit.c          |  2 +-
 hw/arm/mps2-tz.c           |  2 +-
 hw/arm/mps2.c              |  2 +-
 hw/arm/msf2-som.c          |  2 +-
 hw/arm/musca.c             |  2 +-
 hw/arm/netduino2.c         |  2 +-
 hw/arm/netduinoplus2.c     |  2 +-
 hw/arm/nrf51_soc.c         | 18 +++++++++---------
 hw/arm/olimex-stm32-h405.c |  2 +-
 hw/arm/stellaris.c         | 23 ++++++++++++-----------
 hw/arm/stm32vldiscovery.c  |  2 +-
 13 files changed, 32 insertions(+), 31 deletions(-)

-- 
2.47.1


