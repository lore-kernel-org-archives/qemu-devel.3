Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C348DCF537D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uZo-0001AH-Cx; Thu, 24 Oct 2024 05:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZg-00017W-NP
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:12 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZc-0003ls-Q5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:12 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a93c1cc74fdso87097566b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763765; x=1730368565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ubj0KrnDnw0bOLO2d2mSz0oiHM9+bY4+4PII9kohX1c=;
 b=cJwKUZL2skUAAoTE4LnrVXlqYR2DhD13sGPnAUpZ32wdehFB8f3D2DbwEflNOnQxwB
 NpLHJc54DIybX1uXeO2/UMLgUiDUxXARKQjXwo45V6TiIo96/xvY2ow4LmB5q6iW1wV2
 teyheKQyfJkoNvKH8VFkiidpjWkyQwdLWlji/Bo2o9OCwPn24BSf2HE2lMWZo2weVzxR
 SdlKGZP3nHtEx/KDB9hIhjdH6WXWNJpixewokqRTXrs8E/k/zQplX5YTTh9vjO0NMYMk
 9sWz9o5mFgNrzVkBwP2O7piYy4ZXuC+NPN7tRFH/ycbv84qjz05DpcFKKP45uzVq0MN4
 Dybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763765; x=1730368565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ubj0KrnDnw0bOLO2d2mSz0oiHM9+bY4+4PII9kohX1c=;
 b=Qtk1rqJ6a4o0AWRhB5wUX4rpnc0fCRrMTaibClK6LCRbUogxBYyo7wbKAzLIjn3Oxv
 /fjMQh2ioq8DYjakq1taTxxpNy4OUo0AB0/J5RIT9dUbQiySmtws6lYkrmygZOl3REN6
 /GgzRk7HlKlHLfj/oFHKZ9WFBFb8uyd9F82AhE0AZkwOEX/83lopp/NzdTK1owowkTlo
 yoXBp/SJi9oKrpMD6xTMV0Eu8l1y7Rcl3y2abP2C7WqIih1ITEWudyMtnSlUfx+n89P/
 19kUVJr//4YZWiUJOcV9jOW9rHJi4DlIcz8ACh8XwONzjLNdSHcFspxFPy/OStb4e6wg
 YCLw==
X-Gm-Message-State: AOJu0YwgIZY5i8JkOBk0DGF8VuPSfRu+XUidVFbVP/UTlB6k1Q4eUtYh
 SGKujtqchKSJeCrQW1fMkyilLZkv1jU58DSgxyVO1H4HJ2nxdN2pR8PoIgqko0E=
X-Google-Smtp-Source: AGHT+IGAzzwNmhZYU1I2o3o8t8CP6igjGTcpoy6SqdFuEmUZzh3iSG8fTpfDU3aFv99ZE0s/Vai6vw==
X-Received: by 2002:a17:906:f590:b0:a99:f750:bf79 with SMTP id
 a640c23a62f3a-a9abf8aefa7mr554658666b.34.1729763765459; 
 Thu, 24 Oct 2024 02:56:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a91370547sm593197466b.128.2024.10.24.02.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0767C5F897;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/17] testing, gdbstub and plugin updates
Date: Thu, 24 Oct 2024 10:55:46 +0100
Message-Id: <20241024095603.1813285-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-oct-misc-241024-1

for you to fetch changes up to b56f7dd203c301231d3bb2d071b4e32b345f49d6:

  plugins: fix qemu_plugin_reset (2024-10-24 10:04:09 +0100)

----------------------------------------------------------------
testing, gdbstub and plugin updates

  - update MAINTAINERS with pointers to foo/next
  - add NOFETCH to help test custom docker builds
  - update microblaze toolchain with atomic fixes
  - update tsan build and documentation
  - don't restrict build-environment by arch unless needed
  - add cross-modifying code test
  - add tracepoints for cpu_step_atomic fallbacks
  - fix defaults for loongarch cross build
  - make check-[dco|patch] a little more verbose
  - fix gdbstub bug preventing aarch64_be-linux-user starting
  - add basic test for aarch64_be
  - clean up some gdbstub test scripts
  - fix qemu_plugin_reset

----------------------------------------------------------------
Alex Bennée (9):
      tests/docker: add NOFETCH env variable for testing
      MAINTAINERS: mention my testing/next tree
      scripts/ci: remove architecture checks for build-environment updates
      accel/tcg: add tracepoints for cpu_loop_exit_atomic
      gitlab: make check-[dco|patch] a little more verbose
      MAINTAINERS: mention my gdbstub/next tree
      config/targets: update aarch64_be-linux-user gdb XML list
      tests/tcg: enable basic testing for aarch64_be-linux-user
      MAINTAINERS: mention my plugins/next tree

Gustavo Romero (2):
      tests/tcg/aarch64: Use raw strings for regexes in test-mte.py
      testing: Enhance gdb probe script

Ilya Leoshkevich (2):
      tests/docker: Fix microblaze atomics
      tests/tcg/x86_64: Add cross-modifying code test

Pierrick Bouvier (4):
      meson: hide tsan related warnings
      docs/devel: update tsan build documentation
      dockerfiles: fix default targets for debian-loongarch-cross
      plugins: fix qemu_plugin_reset

 MAINTAINERS                                        |  3 +
 docs/devel/testing/main.rst                        | 26 +++++--
 configure                                          |  5 ++
 configs/targets/aarch64_be-linux-user.mak          |  2 +-
 meson.build                                        | 10 ++-
 accel/tcg/plugin-gen.c                             |  4 ++
 accel/tcg/user-exec.c                              |  2 +-
 tests/tcg/aarch64_be/hello.c                       | 35 ++++++++++
 tests/tcg/x86_64/cross-modifying-code.c            | 80 ++++++++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc                     |  9 +++
 .gitlab-ci.d/check-dco.py                          |  5 +-
 .gitlab-ci.d/check-patch.py                        |  5 +-
 accel/tcg/trace-events                             | 12 ++++
 scripts/ci/setup/ubuntu/build-environment.yml      |  2 -
 scripts/probe-gdb-support.py                       | 75 ++++++++++----------
 tests/docker/Makefile.include                      |  5 +-
 .../dockerfiles/debian-loongarch-cross.docker      |  4 +-
 .../debian-microblaze-cross.d/build-toolchain.sh   |  8 +++
 tests/docker/dockerfiles/debian-toolchain.docker   |  7 ++
 tests/tcg/Makefile.target                          |  7 +-
 tests/tcg/aarch64/gdbstub/test-mte.py              |  4 +-
 tests/tcg/aarch64_be/Makefile.target               | 17 +++++
 tests/tcg/x86_64/Makefile.target                   |  4 ++
 23 files changed, 273 insertions(+), 58 deletions(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/x86_64/cross-modifying-code.c
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

-- 
2.39.5


