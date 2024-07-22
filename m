Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11F6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqq7-0005af-Dx; Mon, 22 Jul 2024 07:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq4-0005TS-AB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:20 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq2-0002R9-3n
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:20 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a79f9a72a99so925259866b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646256; x=1722251056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8mwWesMelRm+DkK/zQIQiqzyehUGEfnqgx8ImE9NQCg=;
 b=NF1u8LqgU5OXFxycDqf2imK0IsHPjVybBcckw75b1LUNVnKa5h44mYIln2TVCo1mHO
 upx/uumLCuwv5Qcd3SpSO4u8JX12M+DdAAO+OnvqsXXnzLVXMCf360/3jsk9co92s7Ze
 wSF73bRJXPPHcmnQujwGcY6iS4af0FCHIoJzVCqVHie2a7pTWwxfIUcFRCqwrIr8vjBY
 mlHAo3jwkTNZQkNCbH6T1ztfsTYWMLUZHGxzgMoEHNWdYIEPZEFRkdQk9B8DUlXcniWD
 u+2dCrz85JYqFwAGfbCgCsJPwC0V+N1/LzPX5UiORhjOK+YJCuSjVV7OXd5X0naqXkLY
 GZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646256; x=1722251056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mwWesMelRm+DkK/zQIQiqzyehUGEfnqgx8ImE9NQCg=;
 b=kcxGmjX7Qyjm3LCkoPwNYo++bK69i7RGUqONKJgeXOn1/177hv3CM282LezEyhGIGI
 AFSM6Gq6wnn3MoWwgI9/8+MWLXtnLB7P8a7ac9mhWY8VsSnmOrKeBLAVIV5H3dlOV9Gk
 XmUsccLvJJrxz4BCXBaAvNTNDviglehGmUGFMGtydLmdHgVQc2qzB0vRdR2DBZPDWKS/
 BEgn7oZ1YtApIi7o9OvYyKB47I2eGs43/Pz3MEKHJp9sfRU+KCNK28QBc3drMbnnDioQ
 rBX8OF3akLN/Kwhf9A5KgoBZHxUKg15k+NmI9Bgk/whicZIZPY3qXZ8he/9/7cRp+9tt
 4Yzg==
X-Gm-Message-State: AOJu0YxCp8crmAH90jMV61Pv985sGxNpkQlQ98cOHqX1Z0DwtYNuZzSq
 Sexsev2yVi189iPG+RgXSHaor77iI3EKlJuOc0LWfymeyvjTlRQ9QNTe8DlPHrk=
X-Google-Smtp-Source: AGHT+IEN/TKx0Av8Wq4BgsA53uWmm8ILmH3I38v3nN7TKH3Gx+nefBSiSBat/lrlentw0G0XOlJoWQ==
X-Received: by 2002:a17:906:e297:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a7a0f0ffe2amr1327497466b.8.1721646255297; 
 Mon, 22 Jul 2024 04:04:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c922296sm416720366b.179.2024.07.22.04.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BE945F8B1;
 Mon, 22 Jul 2024 12:04:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
Date: Mon, 22 Jul 2024 12:03:57 +0100
Message-Id: <20240722110413.118418-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x636.google.com
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

warn: No match for commit c135d5eaafe7aa2533da663d8e5a34a424b71eb9 found at https://gitlab.com/stsquad/qemu.git
warn: Are you sure you pushed 'pull-target-arm-20240711-209-gc135d5eaaf' there?
The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git pull-target-arm-20240711-209-gc135d5eaaf

for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:

  tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0100)

----------------------------------------------------------------
Alex Bennée (3):
      testing: bump to latest libvirt-ci
      gdbstub: Re-factor gdb command extensions
      tests/plugins: use qemu_plugin_outs for inline stats

Frédéric Pétrot (1):
      plugins/execlog.c: correct dump of registers values

Philippe Mathieu-Daudé (8):
      semihosting: Include missing 'gdbstub/syscalls.h' header
      target/m68k: Add semihosting stub
      target/mips: Add semihosting stub
      target/m68k: Restrict semihosting to TCG
      target/mips: Restrict semihosting to TCG
      target/riscv: Restrict semihosting to TCG
      target/xtensa: Restrict semihosting to TCG
      semihosting: Restrict to TCG

Pierrick Bouvier (1):
      plugins: fix mem callback array size

Richard Henderson (1):
      tests/tcg/aarch64: Fix test-mte.py

Simon Hamelin (1):
      plugins/stoptrigger: TCG plugin to stop execution under conditions

Thomas Huth (1):
      tests/avocado: Remove non-working sparc leon3 test

 MAINTAINERS                               |   1 -
 docs/devel/tcg-plugins.rst                |  22 +++++
 include/gdbstub/commands.h                |  19 ++--
 include/semihosting/syscalls.h            |   2 +
 target/arm/internals.h                    |   4 +-
 accel/tcg/plugin-gen.c                    |   3 +-
 contrib/plugins/execlog.c                 |   2 +-
 contrib/plugins/stoptrigger.c             | 151 ++++++++++++++++++++++++++++++
 gdbstub/gdbstub.c                         | 141 ++++++++++++++++------------
 target/arm/gdbstub.c                      |  16 +---
 target/arm/gdbstub64.c                    |  11 +--
 target/m68k/semihosting-stub.c            |  15 +++
 target/mips/tcg/sysemu/semihosting-stub.c |  15 +++
 tests/plugin/inline.c                     |  58 +++++++-----
 .gitlab-ci.d/cirrus/freebsd-13.vars       |   2 +-
 contrib/plugins/Makefile                  |   1 +
 semihosting/Kconfig                       |   1 +
 target/m68k/Kconfig                       |   2 +-
 target/m68k/meson.build                   |   5 +-
 target/mips/Kconfig                       |   2 +-
 target/mips/tcg/sysemu/meson.build        |   6 +-
 target/riscv/Kconfig                      |   4 +-
 target/xtensa/Kconfig                     |   2 +-
 tests/avocado/machine_sparc_leon3.py      |  37 --------
 tests/lcitool/libvirt-ci                  |   2 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |   2 +-
 tests/vm/generated/freebsd.json           |  14 +--
 27 files changed, 370 insertions(+), 170 deletions(-)
 create mode 100644 contrib/plugins/stoptrigger.c
 create mode 100644 target/m68k/semihosting-stub.c
 create mode 100644 target/mips/tcg/sysemu/semihosting-stub.c
 delete mode 100644 tests/avocado/machine_sparc_leon3.py

-- 
2.39.2


