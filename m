Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA1DE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVkU-0002o4-6L; Wed, 11 Dec 2024 18:04:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkS-0002n6-6k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:04 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkP-0001na-RV
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:03 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so10422f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958240; x=1734563040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pC1Uyy5m1Ql3guGbpj24VXkLZ8MdRFxFFCdpGpXSAVg=;
 b=P/T6VuwNWlXtJOEX3RDL/PKrUcERuFyxG4ImuOx0PuqvgspCsAtMQ/fqGiCVK8+xs/
 gCHtlk6AXpu20J2w3DwbFcnDijRuEGQEzb8OF1CNElRgfXjfuHfiH77ncKIPPm85KQKf
 0Le5gQDAZWbOAh5nBAPeVDZpxj6edtvuuE1XjoSlAKO2Ic2Rrh3zldxZFxnzWXnMmIn3
 3+xULQw7AtRiBXP4gKth6jeTqVnQhwJzg7ybCWU9Fx6DIXsA725srVIeoJqZgdyA5B2q
 u2epJ3xg+nkNZuA3qqsChy7uPVvQyF2KSxCd2U73acVyXTGgQRAJGVrBEjOmWV5v1qnl
 fZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958240; x=1734563040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pC1Uyy5m1Ql3guGbpj24VXkLZ8MdRFxFFCdpGpXSAVg=;
 b=ehhgn7wwBMAfJT2OvyZHDjiy2WY5KdtJt+drWpuUaSN5dxXxqSJPKOXbScVJ7Qg0yU
 71MQCePI4kcBHZ6xjkDPyeZjwXr6peOO8cLXMsee/saX7ONALMeON7Et71rPL4+rPJ3g
 45LmADWNE77dBBlCOzcEcMeCStkZ3XDGYaZ+CF9uCMexTJaqTvaBicHPx1vaH8TnLn30
 zxp8YRh0Z3XmCSUaWzbXyrScI55T3EGuDEY+Dq0nS9+8v7t/2oSdcHJy50uQNMeFOU54
 T0uTM+piYSG9lhidtBUUD1SqOHpvrRyMdOPteb9KtFAxBmSu/Rj8pqvCGdktn08eli0r
 4zJw==
X-Gm-Message-State: AOJu0Yzoc2Xmtty2wiPNKTaZrPJeJGgb4BzY0dl9+K0aQsbx/nTVXXvY
 IFUJyy3009GOQjfiCQfsaUNi78G50W8dA8OCubXaeGFac8uQKfVtgzWQauh6V/j8+HE4VGZOcwW
 L
X-Gm-Gg: ASbGncvhdUntkmUufEeH2pqLEPOT9Xe8GYyq6fKia4IvOk3FGYkhmSzoly+dnd9HVZA
 OAX2BjAGGdTV2kGcmAO1uwN+a1mS3Bh9oXrVEUyj6pEeVXsGAuQzZ6wlBtC+rwfG9/QZPSqmyNj
 iK+S6ntGCimnPLrjDWquT2QNzzofE+J1jEeCdCAFUDxjljPan/w7QpnIY+7rtqeJPgzUHnt4xsE
 qNT5Jb1tN6w7P2l0mRzmJbB79IKw9vkpFzR2e3oGQf5X+ncH+kPBLQn17CiFenBNM5hFbjTH90m
 YxzaauudWA3eJJVCF+aNWVlQjjVgx/ocLw==
X-Google-Smtp-Source: AGHT+IEAZkfQNkPD5tHlDFh2hu7anDtDPdhHzDO8w2R3bo8Lbmb8hCl1xz134FNyvCHQQWxt5+ffhQ==
X-Received: by 2002:a05:6000:4025:b0:386:3958:2ec5 with SMTP id
 ffacd0b85a97d-3878886cb39mr554381f8f.28.1733958239833; 
 Wed, 11 Dec 2024 15:03:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4bb8sm2285775f8f.33.2024.12.11.15.03.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:03:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/9] misc: Reduce 'exec/tswap.h' inclusions
Date: Thu, 12 Dec 2024 00:03:48 +0100
Message-ID: <20241211230357.97036-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Include "exec/tswap.h" where it is needed and remove it from
"exec/cpu-all.h" which is a header included very often.

Philippe Mathieu-Daudé (9):
  target/xtensa: Remove tswap() calls in semihosting simcall() helper
  target/mips: Remove tswap() calls in semihosting uhi_fstat_cb()
  accel/tcg: Include missing 'exec/tswap.h' header in translator.c
  hw/arm: Include missing 'exec/tswap.h' header
  hw/ppc: Include missing 'exec/tswap.h' header
  hw/mips: Include missing 'exec/tswap.h' header
  hw/sh4/r2d: Include missing 'exec/tswap.h' header
  hw/xtensa: Include missing 'exec/tswap.h' header
  exec/cpu-all: Do not include 'exec/tswap.h' header

 hw/xtensa/bootparam.h              |  1 +
 include/exec/cpu-all.h             |  1 -
 accel/tcg/translator.c             |  1 +
 hw/arm/boot.c                      |  1 +
 hw/arm/npcm7xx.c                   |  1 +
 hw/mips/fuloong2e.c                |  1 +
 hw/mips/malta.c                    |  1 +
 hw/ppc/sam460ex.c                  |  1 +
 hw/ppc/spapr.c                     |  1 +
 hw/ppc/virtex_ml507.c              |  1 +
 hw/sh4/r2d.c                       |  1 +
 hw/xtensa/xtfpga.c                 |  1 +
 target/mips/tcg/sysemu/mips-semi.c | 43 +++++++++++++++++++++---------
 target/xtensa/xtensa-semi.c        | 15 ++++-------
 14 files changed, 46 insertions(+), 24 deletions(-)

-- 
2.45.2


