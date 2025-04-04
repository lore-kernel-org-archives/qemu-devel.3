Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17376C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pdo-0000iG-GX; Fri, 04 Apr 2025 18:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdU-0000fy-S8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdK-0007x7-UN
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:35:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so15914985e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806126; x=1744410926; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9ViK4onZQCmZHc18fMKix+clvnP/93dzPnAUQK4f1Vg=;
 b=MuVy3gbT3Yzsibf/knShuo82w75HspRxoAXUpQqlyQ1Uz/ZvUrRPK99HLW0L3Gp2PC
 dEtMwvSoRc2AVT1Zc3EMwLA9UJtFM3azm8XfWM6u4vRJoT2XSWfG30vFsgGrxt2dZBEH
 98T0peYsxz2nWT99wDy9O4PYII9Zcn4ORhiuu9sZ+5RTfNaQnst+pVCMs7rW3tdnRiqe
 ZodXYnWnj0juAN8u1TQYcWG21MWbtsq8UnvNvIbpuMxMA8fZ//gfkfWhVKgAkHKAPuvW
 fx/W46eT9r1oBKzGdKOcHandpWRc5eefNn3mvtGMv+RjmgS4oduJquWjNLYufQmyosFd
 BAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806126; x=1744410926;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9ViK4onZQCmZHc18fMKix+clvnP/93dzPnAUQK4f1Vg=;
 b=ehFBLBW5DFN7czuxmzdj6X3oru5xJLAIRR7zfyXCb8XYb5Vs1cTvzYty9Ufko5jBW/
 xJxdpkTIRLYQn4zzUw9BYOeEnvPwttEeqZ/3gMpwwWmbp1NyeYGh3ZRTzDsv/ofVE5kM
 rfACBEOQduXaD5DY7CQ87G/Bb0Oh2ebWA0bWBBvoqJ3TeenKHj0mVbHx0kqSFO5ln0ar
 i0Pgw/nWlgpctxNThng7hzKwJ2/B9c+2QdQFjwsCyhKq30WOCfrtFQYjOoRuHHxBF2rf
 D9bHFfKqNzlCKEpidut572rYx/P/fM+B8pZaLj3NfcOyFiLvYZLjhV+Juar2yxtKo65L
 Clpw==
X-Gm-Message-State: AOJu0YxdL0tZPQj6QJjh7DEcmP23eed+4JhII8q0cyWoNCs8VLu7ZVnr
 O7qybI9JtVd+YtbBt+beQHfjZAA2LwWXxkivb/gpQ9cIVnmCq9CUbU6C5FmsphUw1d5FeYCuy7V
 G
X-Gm-Gg: ASbGncsENU7hV7CENWyEKlEjmWDmbe7dROuzy7Yep6BCmMJplWNmXc3AhRxqD5D2Sz7
 HOeKdcVPNN2FrqFelYvhip/kCmFrdWuKAC+Ltx2VYGQ33sO/ySB8hYnR/ugJ+PRVsPwic2O5clk
 AuEpU3p4Xq78J4kbPYz/hXESNNFRrmxCUBhJvILQYbU77GoKjss6FJlvmCY+WBZXZrpAPt3RbY2
 GROo8DNi5BEQxmkZXKM4Xn+xtBHvybAFAb12BPC4tNIEnObRcKr4dbLwefXX+OcQkxdH5Xa+A/x
 AN1wZ8Sw40pBa6SZB3z3+RBmXZPsm7iGBiLCgHsjR5jAI8YWCoiM6CqJwCGmJj+41Qx54qNGD/0
 ijgDatF0jXV3+2Dnv3pkqsdj6
X-Google-Smtp-Source: AGHT+IHbAFWFP8e5EsIoqgZmrTyEv0bn34fIjqh+KBs+DikDmpn17MjqKM6As6B0Dj6J3tRoubln9Q==
X-Received: by 2002:a7b:c398:0:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-43ebef8f615mr76695675e9.11.1743806124624; 
 Fri, 04 Apr 2025 15:35:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm59985425e9.9.2025.04.04.15.35.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:35:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 0/9] target/arm: Remove some TARGET_AARCH64 uses (MTE
 & gdbstub)
Date: Sat,  5 Apr 2025 00:35:12 +0200
Message-ID: <20250404223521.38781-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

We'd like to reduce the use on TARGET_$arch definitions.
This series convert few to runtime checks, mostly in
MTE and gdbstub.

Philippe Mathieu-Daudé (9):
  target/arm: Remove uses of TARGET_AARCH64 in arch_dump.c
  target/arm: Remove use of TARGET_AARCH64 in dump.c
  target/arm: Remove use of TARGET_AARCH64 in arm_cpu_initfn()
  target/arm/mte: Include missing headers for GETPC()
  target/arm/mte: Reduce address_with_allocation_tag() scope
  target/arm/mte: Rename 'mte_helper.h' as generic 'mte.h'
  target/arm/mte: Restrict MTE declarations
  linux-user/arm: Implement MTE stubs for 32-bit user emulation
  target/arm: Build Aarch64 gdbstub helpers indistinctly

 linux-user/aarch64/mte_user_helper.h |  27 +---
 linux-user/arm/mte_user_helper.h     |  34 +++++
 target/arm/internals.h               | 128 +-----------------
 target/arm/tcg/mte.h                 | 190 +++++++++++++++++++++++++++
 target/arm/tcg/mte_helper.h          |  66 ----------
 target/arm/tcg/sve_ldst_internal.h   |   1 +
 linux-user/arm/mte_user_helper.c     |  13 ++
 target/arm/arch_dump.c               |   6 -
 target/arm/cpu.c                     |  38 +++---
 target/arm/gdbstub.c                 |   4 -
 target/arm/gdbstub64.c               |   2 +-
 target/arm/tcg/helper-a64.c          |   1 +
 target/arm/tcg/mte.c                 | 175 ++++++++++++++++++++++++
 target/arm/tcg/mte_helper.c          | 170 ++----------------------
 target/arm/tcg/sve_helper.c          |   1 +
 target/arm/tcg/translate-a64.c       |   1 +
 target/arm/tcg/translate-sve.c       |   1 +
 linux-user/arm/meson.build           |   2 +
 target/arm/meson.build               |   2 +-
 target/arm/tcg/meson.build           |   1 +
 20 files changed, 450 insertions(+), 413 deletions(-)
 create mode 100644 linux-user/arm/mte_user_helper.h
 create mode 100644 target/arm/tcg/mte.h
 delete mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 linux-user/arm/mte_user_helper.c
 create mode 100644 target/arm/tcg/mte.c

-- 
2.47.1


