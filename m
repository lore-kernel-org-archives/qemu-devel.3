Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6E6CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL25-0001Al-BZ; Mon, 27 Oct 2025 07:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1g-0000lL-Mj
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:38 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1O-0005aE-PK
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:04:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61feb87fe26so7826405a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563026; x=1762167826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZxOmv1h9X+NtE8CrFVjihKiw1E4S/yG+7YAk6GJ2BI=;
 b=ux+8I8pEsCSkzMAI/oEQ1jFvolUvgt/AuUBDJSPwsiVRq+WgnZykTGJEVxTa2b5SDb
 RZPIaXwInKY6WPAobmJwn+YWnevKVhW9EbNdFewOiP894mkoHuC4LzokPoiCsGjzAUeu
 ViMft+y+k8riXU5J8++/l/C2aCetmFcA2w4IRmLLkuNi7rTy0mEp/PfGqKVTK2NEY3fh
 9l8t7+nfZSQiyXpj6c2iQw+a884sQYjgOcwBnkl7Yi/Ttkol4Vs4rISQhMa20iXxRhXe
 QGiQ4D6dwhA3KzZwR2/yyRoiQoVmVcV5zewR/r+Tl/XTRbyixv5fIk9rySp1nhcFBecP
 FolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563026; x=1762167826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZxOmv1h9X+NtE8CrFVjihKiw1E4S/yG+7YAk6GJ2BI=;
 b=bLz2BG4JEIMkxL0X+bGKCVdOBQvNfHUEBn9vXSdYmoMcSqDkbAe2dwyhS3yd5tFrNi
 Ez0wKdad/R5DjO+tyae0a+grqkBRqcWo+0A3leuYdRsdJ3yIrUM5JSuyQvU4nXOECw48
 5prpsSh7OhlFf5x/EaN56KKtKfi49dDXC+zDQkld/sPk+vWEpkMmBANbUk5EM6UuUz7x
 8YPEVtZy9p/9OsCXwedqL9aVzekWDB/Or537Kul3g8niN0PEkE5Y9wwJilJF28f5HHAp
 AMnh5ZOAmiF0NoMa4qya5dEHs2CVFzDABsk9YzpWCELrnbtychQYUspR7I7eAppwcWYv
 qa3w==
X-Gm-Message-State: AOJu0YxJ8t2f8jhTPdFnsBppwdyiEz1cgriD+8jObiCWgLObIhr6rwhB
 dOe8F841rqjj7sUxrZ9TEOUebKxY9c1uywmycx+rDrJlCsvaDcR4OqMJ2ttLOoU8Nu8=
X-Gm-Gg: ASbGnctt2YC+Ss2bohK9WjRFJREPzivTCKki7QhVhPRsFCA1sxCbNVZDAYEwiBJkv2d
 5MmQC5r/xZJ2Q4XK8614MZBNA6BKmxfR27EGvssvRZbcweyE5hmUhVjKFaz1dShn/fzKG9iJoU9
 V15/fBsfB+7fvPbYIkw5a5GLHnTVRC9ueNYqB5oMLugIuMiHo5uIUARHNWXpOmEI2dLqHJqHMSi
 ODIglmP1X+VXaPVw2JlK7dmHT8sXe5gVRLgcJptzCi26HFov2ZB0Ry9u9gLSKvbGGs0EZuPmmC7
 2E7SKr7QufSXONZAFx+4GhQHWaXWBKu8zP95ac9F+84L+XsUB7VD7Y0kXmL3Qi2FziPc8d0mHox
 6O0D3fi0bm4pC5LHjI7nOnAGLA9IMlWk6piivb1Xac003gFZ2rzQVcqv/BiZ06KHLdRMmVLhWld
 qm
X-Google-Smtp-Source: AGHT+IEjdh5wekeDnj/JN/hpImq3PiBtRv+N6Y50dWW99nPrapeBSLqmnoWMTqOiYMColqDL85c1Jg==
X-Received: by 2002:a05:6402:34d1:b0:636:7e05:b6c0 with SMTP id
 4fb4d7f45d1cf-63e5fa7473amr9185535a12.0.1761563025832; 
 Mon, 27 Oct 2025 04:03:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e8036cdd4sm5887848a12.22.2025.10.27.04.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1DCEB5F8CD;
 Mon, 27 Oct 2025 11:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 00/35] maintainer updates for 8.2 softfeeeze (ci, plugins,
 semihosting) pre-PR
Date: Mon, 27 Oct 2025 11:03:07 +0000
Message-ID: <20251027110344.2289945-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

Hi,

This should be my final pull-request before softfreeze on the 4th of
November. As I'll be travelling I intend to send it out by the end of
the week.

The CI changes are mostly cleanups for the ansible scripts. I've
dropped the final testing/next patch which enables the ppc64le custom
runner as I don't think I'll have time to debug that before the
freeze.

The plugin updates are already well reviewed and should make more
richer plugins giving semantic info on the type of discontinuities you
can see.

There are a few other minor fixes including come missing CFI tags for
some plugin callbacks and fixing the minimal -no-tcg build.

The following still need review:

  scripts/ci: modify gitlab runner deb setup
  tests/lcitool: generate a yaml file for the ppc64le runner
  scripts/ci: allow both Ubuntu or Debian to run upgrade
  scripts/ci: move build-environment.yaml up a level
  scripts/ci/setup: regenerate yaml
  ci: clean-up remaining bits of armhf builds.

Alex.

Alex Bennée (8):
  ci: clean-up remaining bits of armhf builds.
  scripts/ci/setup: regenerate yaml
  scripts/ci: move build-environment.yaml up a level
  scripts/ci: allow both Ubuntu or Debian to run upgrade
  tests/lcitool: generate a yaml file for the ppc64le runner
  scripts/ci: modify gitlab runner deb setup
  plugins/core: add missing QEMU_DISABLE_CFI annotations
  configs: drop SBSA_REF from minimal specification

Julian Ganz (25):
  plugins: add types for callbacks related to certain discontinuities
  plugins: add API for registering discontinuity callbacks
  plugins: add hooks for new discontinuity related callbacks
  contrib/plugins: add plugin showcasing new dicontinuity related API
  target/alpha: call plugin trap callbacks
  target/arm: call plugin trap callbacks
  target/avr: call plugin trap callbacks
  target/hppa: call plugin trap callbacks
  target/i386: call plugin trap callbacks
  target/loongarch: call plugin trap callbacks
  target/m68k: call plugin trap callbacks
  target/microblaze: call plugin trap callbacks
  target/mips: call plugin trap callbacks
  target/openrisc: call plugin trap callbacks
  target/ppc: call plugin trap callbacks
  target/riscv: call plugin trap callbacks
  target/rx: call plugin trap callbacks
  target/s390x: call plugin trap callbacks
  target/sh4: call plugin trap callbacks
  target/sparc: call plugin trap callbacks
  target/tricore: call plugin trap callbacks
  target/xtensa: call plugin trap callbacks
  tests: add plugin asserting correctness of discon event's to_pc
  tests: add test for double-traps on rv64
  tests: add test with interrupted memory accesses on rv64

Sean Anderson (2):
  gdbstub: Fix %s formatting
  semihosting: Fix GDB File-I/O FLEN

 docs/about/emulation.rst                      |   8 +
 docs/devel/testing/ci-jobs.rst.inc            |   7 -
 configs/devices/aarch64-softmmu/minimal.mak   |   1 -
 include/qemu/plugin-event.h                   |   3 +
 include/qemu/plugin.h                         |  13 ++
 include/qemu/qemu-plugin.h                    |  60 +++++
 target/arm/internals.h                        |   1 +
 contrib/plugins/traps.c                       |  83 +++++++
 gdbstub/syscalls.c                            |   2 +-
 plugins/core.c                                |  58 +++++
 plugins/loader.c                              |   1 +
 semihosting/arm-compat-semi.c                 |   5 +-
 target/alpha/helper.c                         |  13 ++
 target/arm/helper.c                           |  24 ++
 target/arm/tcg/m_helper.c                     |   5 +
 target/avr/helper.c                           |   3 +
 target/hppa/int_helper.c                      |  17 ++
 target/i386/tcg/excp_helper.c                 |   3 +
 target/i386/tcg/seg_helper.c                  |   4 +
 target/loongarch/tcg/tcg_cpu.c                |   4 +
 target/m68k/op_helper.c                       |  22 ++
 target/microblaze/helper.c                    |  10 +
 target/mips/tcg/system/tlb_helper.c           |  11 +
 target/openrisc/interrupt.c                   |  15 ++
 target/ppc/excp_helper.c                      |  41 ++++
 target/riscv/cpu_helper.c                     |   9 +
 target/rx/helper.c                            |  12 +
 target/s390x/tcg/excp_helper.c                |   8 +
 target/sh4/helper.c                           |   4 +
 target/sparc/int32_helper.c                   |   7 +
 target/sparc/int64_helper.c                   |  10 +
 target/tricore/op_helper.c                    |   5 +
 target/xtensa/exc_helper.c                    |   6 +
 target/xtensa/xtensa-semi.c                   |   3 +
 tests/tcg/plugins/discons.c                   | 221 ++++++++++++++++++
 .../custom-runners/ubuntu-24.04-aarch64.yml   |   2 -
 contrib/plugins/meson.build                   |   2 +-
 .../setup/{ubuntu => }/build-environment.yml  |  32 +--
 .../ci/setup/debian/debian-13-ppc64le.yaml    | 134 +++++++++++
 scripts/ci/setup/gitlab-runner.yml            |   6 +-
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-
 tests/lcitool/refresh                         |   1 +
 tests/tcg/plugins/meson.build                 |   2 +-
 tests/tcg/riscv64/Makefile.softmmu-target     |  12 +
 tests/tcg/riscv64/doubletrap.S                |  73 ++++++
 tests/tcg/riscv64/interruptedmemory.S         |  97 ++++++++
 47 files changed, 1031 insertions(+), 37 deletions(-)
 create mode 100644 contrib/plugins/traps.c
 create mode 100644 tests/tcg/plugins/discons.c
 rename scripts/ci/setup/{ubuntu => }/build-environment.yml (63%)
 create mode 100644 scripts/ci/setup/debian/debian-13-ppc64le.yaml
 create mode 100644 tests/tcg/riscv64/doubletrap.S
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

-- 
2.47.3


