Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E64ED1CDDC
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CYs-0001jK-9m; Tue, 22 Oct 2024 06:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYo-0001i7-3c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:22 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYl-0001y7-5G
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:21 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso812827466b.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594576; x=1730199376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=COpfR9RLf2CLdazvbIhqB2YmojRnRaS7PX4PKuRZwh4=;
 b=a/r+TFJeohAszKlrJAQYJQIca0/J4Jx9WRu/poB0S996Jc+T358xq0O910gFkJSDj9
 svyqfRQgupCOy9JBhYyC/kAmKedkWDdvfro+ek1AFGjIRWE7vzWo6WnkRuYBHxHvUD5o
 7RE8XOh8H6CLYtnE/93msiAVOL89W0cy0xrbYCfznMHOUJle621Ad1dhBm3OI98mI7Ak
 RZvCOoakctgrl+BF9yb5DxFW1LtKGvnnmAn/vltS/3A1Bn0mMNVsrEgnj5sxlNaT/oXq
 V042NOoJVvtNOzxfaffAY5nPU2KknwtrplFAHgNQ5gc4UQv4ay7WRuTKyS6wpP3ttXG4
 2sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594576; x=1730199376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=COpfR9RLf2CLdazvbIhqB2YmojRnRaS7PX4PKuRZwh4=;
 b=CnvxcXlXc/i6D0Tg5BwwsvByKGUtyFuEiIztswNpH8N2K1iz7d2bsNwx/2p5/1ykyK
 lPk8RkCCBjQV7SZwMXahBV1lVEDKfMejewmgar6EhT/EJ72ANXoSvxUqhskENLwuNfQa
 yUl8GH8W8h+htpCwSTPF/AZZea12nxo9JwewJ/Qg0+YXY/a30J+52kV577nY8K60O3HW
 nKLr8dD8+MD928oQygy9r6LksEpPiQ7ToNWo3uvfmM23i3Bny+48EqSX+GEw6ZMXt6AD
 WwBrKryrS4DtPakNkTIAsJ2yrVN0MyRnkP71OCz3lCQkdaNLMWFy0+iYti15jlIkpi53
 rDgQ==
X-Gm-Message-State: AOJu0YzuqkT36Abn63Pn3G8cx3R/u5vXatsbIHUBwb4bchE3pf4j1geK
 hyU/okpKpvvwzj/T0FYIzZnbMdqL2Av0n1UN9OP5DBHzSpnuNEU6qkM1nj+xlJw=
X-Google-Smtp-Source: AGHT+IFvyKkyeRPJrAKRyY3MStdAXndUKfD+I3lEe2ovrB6KLCkuexA+w8IhgFRYygmb+9drojBW0Q==
X-Received: by 2002:a17:906:c150:b0:a9a:47a:8908 with SMTP id
 a640c23a62f3a-a9aace2551cmr208312266b.9.1729594576427; 
 Tue, 22 Oct 2024 03:56:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edc33sm321447866b.58.2024.10.22.03.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8D0D5F89C;
 Tue, 22 Oct 2024 11:56:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 00/20] maintainer updates (testing, gdbstub, plugins)
Date: Tue, 22 Oct 2024 11:55:54 +0100
Message-Id: <20241022105614.839199-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

This is an aggregation of three of my maintainer trees which you can
also get from their respective branches (testing/next, gdbstub/next
and plugins/next). I didn't include the plugins on the last post as I
hadn't had a chance to do my sweep through patches before travelling.
I've also updated MAINTAINERS to point at my next trees.

For testing we have mostly tweaks and cleanups. I've included some
tracepoints tweaks for cpu_loop_exit_atomic purely as there was no
where else to but it. There are also some cleanups to the tsan support
from Pierrick. The mipsel tweaks have already been applied directly to
the tree.

For gdbstub more cleanups as well as fixing some gdbstub breakage of
the untested aarch64-be linux-user target. I've added a very basic
some test to prevent silly regressions in the future.

For plugins again more cleanups. The GDB trigger patch will probably
not get merged and should be considered an experimental hack for now.

The following still need review:

  plugins: add ability to register a GDB triggered callback
  tests/tcg: enable basic testing for aarch64_be-linux-user
  config/targets: update aarch64_be-linux-user gdb XML list
  MAINTAINERS: mention my gdbstub/next tree
  gitlab: make check-[dco|patch] a little more verbose
  scripts/ci: remove architecture checks for build-environment updates
  MAINTAINERS: mention my testing/next tree
  tests/docker: add NOFETCH env variable for testing
  MAINTAINERS: mention my plugins/next tree

Alex Bennée (10):
  tests/docker: add NOFETCH env variable for testing
  MAINTAINERS: mention my testing/next tree
  scripts/ci: remove architecture checks for build-environment updates
  accel/tcg: add tracepoints for cpu_loop_exit_atomic
  gitlab: make check-[dco|patch] a little more verbose
  MAINTAINERS: mention my gdbstub/next tree
  config/targets: update aarch64_be-linux-user gdb XML list
  tests/tcg: enable basic testing for aarch64_be-linux-user
  MAINTAINERS: mention my plugins/next tree
  plugins: add ability to register a GDB triggered callback

Gustavo Romero (2):
  tests/tcg/aarch64: Use raw strings for regexes in test-mte.py
  testing: Enhance gdb probe script

Ilya Leoshkevich (2):
  tests/docker: Fix microblaze atomics
  tests/tcg/x86_64: Add cross-modifying code test

Pierrick Bouvier (6):
  meson: hide tsan related warnings
  docs/devel: update tsan build documentation
  dockerfiles: fix default targets for debian-loongarch-cross
  meson: build contrib/plugins with meson
  contrib/plugins: remove Makefile for contrib/plugins
  plugins: fix qemu_plugin_reset

 MAINTAINERS                                   |  3 +
 docs/devel/testing/main.rst                   | 26 +++++-
 configure                                     | 23 ++---
 Makefile                                      | 10 ---
 configs/targets/aarch64_be-linux-user.mak     |  2 +-
 meson.build                                   | 14 ++-
 include/qemu/plugin-event.h                   |  1 +
 include/qemu/qemu-plugin.h                    | 16 ++++
 plugins/plugin.h                              |  9 ++
 accel/tcg/plugin-gen.c                        |  4 +
 accel/tcg/user-exec.c                         |  2 +-
 plugins/api.c                                 | 18 ++++
 plugins/core.c                                | 37 ++++++++
 tests/tcg/aarch64_be/hello.c                  | 35 ++++++++
 tests/tcg/plugins/mem.c                       | 11 ++-
 tests/tcg/x86_64/cross-modifying-code.c       | 80 +++++++++++++++++
 accel/tcg/ldst_atomicity.c.inc                |  9 ++
 .gitlab-ci.d/check-dco.py                     |  9 +-
 .gitlab-ci.d/check-patch.py                   |  9 +-
 accel/tcg/trace-events                        | 12 +++
 contrib/plugins/Makefile                      | 87 -------------------
 contrib/plugins/meson.build                   | 23 +++++
 plugins/qemu-plugins.symbols                  |  1 +
 scripts/ci/setup/ubuntu/build-environment.yml |  2 -
 scripts/probe-gdb-support.py                  | 75 ++++++++--------
 tests/docker/Makefile.include                 |  5 +-
 .../dockerfiles/debian-loongarch-cross.docker |  4 +-
 .../build-toolchain.sh                        |  8 ++
 .../dockerfiles/debian-toolchain.docker       |  7 ++
 tests/tcg/Makefile.target                     |  7 +-
 tests/tcg/aarch64/gdbstub/test-mte.py         |  4 +-
 tests/tcg/aarch64_be/Makefile.target          | 17 ++++
 tests/tcg/x86_64/Makefile.target              |  4 +
 33 files changed, 397 insertions(+), 177 deletions(-)
 create mode 100644 tests/tcg/aarch64_be/hello.c
 create mode 100644 tests/tcg/x86_64/cross-modifying-code.c
 delete mode 100644 contrib/plugins/Makefile
 create mode 100644 contrib/plugins/meson.build
 create mode 100644 tests/tcg/aarch64_be/Makefile.target

-- 
2.39.5


