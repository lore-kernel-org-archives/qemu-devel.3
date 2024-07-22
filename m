Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F67C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 23:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW24m-0000Zf-3P; Mon, 22 Jul 2024 19:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW24j-0000Yx-KI
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:04:13 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sW24g-0002hL-JO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 19:04:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso34616835e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721689449; x=1722294249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FCxDQ9JzfhNywJ4JOX80Y6BDKJysUMhqpGdP4YFbnVs=;
 b=KBREil/BOxy2bDAe5BWa/ftf72P0/qQ0bm7HcADpbdiGkNheXaHFCC2BNi+vWszqAi
 aQ3oesMRAltI6LYfPZVW4GahpueMhHHmCSx9XxvpOHYTZTLWOGr3QJPSWTo1bbp4Huso
 qhozrBrJTm5OXYsL7qRPDUsf2OLrdB2Mf1gWI8wbLOJR66JEomH/2S1tPu7v2g2UIxjr
 yEI7IYYk9a07QA9zQXD34setYRPAt9dKPzg4EC09cCdsqLr4m2reaK++lTiIqRzT4o4Q
 COyMabaAu7gJwYexpOkuimQdqtKdI7Zi//PzNtoUnqTpcx5NoBDbc9bvbQC07iGpw8jx
 2V/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721689449; x=1722294249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCxDQ9JzfhNywJ4JOX80Y6BDKJysUMhqpGdP4YFbnVs=;
 b=AmIxACPR5nLx7G1O+mlA3kETJwWOHANb4RfFBvBXuWVP4x1YtHPfmRw5g7nj2t4xsc
 nraR8KhLvG2b+IrXbWEojlPLhNNOYDOhzhe9udG4xeOal9O4nCDA5GAe5LaiLLGPxyNe
 gOwoeBteVfyobjc5OmLyEJ146upbszorcDD2x4PbOX+EEv3FeeRAz4tndIkw8+KByPJj
 QNVZkKDMh0wUMu73lK3udnq7PPj6ivM9lBluw9vydIrt2ear6uPLl6KDMew8TtYOCZoQ
 F2eOKjJLpKZ0j87i6j0WvVtaWaFfkuZKEPbBxhyYxXvRhfqEpVss5ayx154UuHzMWIwK
 TtNg==
X-Gm-Message-State: AOJu0YwmrplqmLAf3tL92woxjLskF7HWtG4WF0LiLXAf+07sYhCh+uNB
 iX+PFnhyKO144fj8OKWxV4rTGPKgv1jXjt5c6AkOeXndvv3ippu7PzNwURiFy4eHqSHiXmP2RAr
 7
X-Google-Smtp-Source: AGHT+IEblqzr0iShzKVaWAnol8ZjPa3NCTVufY4KPqd8DsfbCJUdN/FyfUG2CWQKBep4F6s8qgq8MA==
X-Received: by 2002:a05:600c:46d0:b0:426:60e4:c691 with SMTP id
 5b1f17b1804b1-427ecfe03b8mr7043685e9.11.1721689448508; 
 Mon, 22 Jul 2024 16:04:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ef50de6dsm2559225e9.1.2024.07.22.16.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 16:04:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F0C3F5F8B0;
 Tue, 23 Jul 2024 00:04:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 00/16] Final bits for 9.1-rc0 (docker, plugins, gdbstub,
 semihosting)
Date: Tue, 23 Jul 2024 00:04:06 +0100
Message-Id: <20240722230406.369447-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

The following changes since commit a7ddb48bd1363c8bcdf42776d320289c42191f01:

  Merge tag 'pull-aspeed-20240721' of https://github.com/legoater/qemu into staging (2024-07-22 07:52:05 +1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc0-230724-1

for you to fetch changes up to c135d5eaafe7aa2533da663d8e5a34a424b71eb9:

  tests/tcg/aarch64: Fix test-mte.py (2024-07-22 09:38:17 +0100)

----------------------------------------------------------------
Maintainer updates for testing, gdbstub, semihosting, plugins

  - bump python in *BSD images via libvirt-ci
  - remove old unused Leon3 Avocado test
  - re-factor gdb command extension
  - add stoptrigger plugin to contrib
  - ensure plugin mem callbacks properly sized
  - reduce check-tcg noise of inline plugin test
  - fix register dumping in execlog plugin
  - restrict semihosting to TCG builds
  - fix regex in MTE test

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


