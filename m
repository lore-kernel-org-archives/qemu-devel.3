Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6DEC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIYk-0005nY-L3; Wed, 28 Feb 2024 06:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYi-0005kw-8G
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYb-0005hb-Oa
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:11 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso450601f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121423; x=1709726223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=efuqfbv9c2ySr88w/wsdQ/uMosUS+4dqBnAf3tbxrrQ=;
 b=rfLedKGQHlgHHxZ8Jzj7hIj8ov5q2Etgc+JLkeIiUYzbkcOPPLxfYUyTo1/nSKH4RF
 +ziu+7w3GSf/5oELywlOhftCieM+/YVJEm3Oe6r6W/Cv9bvR+YU34sKAxnTCL0Vb4Fjo
 kJ6lQF/Fn6lYiyBnVTON6/7UxY+ilhwe1hYihn5J+dCEvqUxaSy7CIjMH9Dk9klBh6AY
 AHW/cWXUw7ogoPIQvGnDKMjbmjH2aMHXgGnVSDejD6H9EZ8cBXhV+8+8Q6XKtIXliptQ
 i9lyzNcyUwTDAM4ahcTGKGO6Q5IBJ4Y+6e03AgGjPZ0FnNy432PFm2hMLz8dk5mpeGf/
 kUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121423; x=1709726223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efuqfbv9c2ySr88w/wsdQ/uMosUS+4dqBnAf3tbxrrQ=;
 b=j7gZ4N78XFNgoxwxaSz6NZ0Pccir0fGis9O9B6Gu9BJwXtCpHbwjiyiuGR9xHBfFJ+
 oBHk4Ed+DseTl0c9M8mSJZ2J0ycrYMPNtPU+NTzj2Ft0r+cLFNE4/kM2kzxCfCYcS4DS
 9nDOvZcwuzJkLStUEC6gR/VYWvmn/sQkxkOgEZer4kmwvmPMvacFJkqXGxIFP4RGd7/e
 j3g0GKkl7bXUzNpgwbKFpRGplxMM46Yy7i5Sieiw7Faox/DNBK/j0ISeagghdd5pwpyk
 n21uSGfTHAFCsqNF+0FLoZr7GNJt/lEKbXILbanADmXW0TlTMkb2FznKUABaj5wXT0TX
 Yggw==
X-Gm-Message-State: AOJu0YxWWOYnbCsYXMjX4fYDHs8PEV11bNDZ7IpxDIAxE6TR3F49sMW3
 39BXiGw2F1L5b7bBwXn9fs4vQ1ptheJJ2B65xp3gLfzbod/+oQs0XONITYzSCfGz1NTuflYi96D
 +
X-Google-Smtp-Source: AGHT+IFMNiPo0SU2DUGwtQ0THWYDvCGoLD4U8lmP3TSIrAKoI3zZhUs8hkXwewsPn79sryRljz5RmQ==
X-Received: by 2002:a05:6000:1374:b0:33d:c0c3:fe0a with SMTP id
 q20-20020a056000137400b0033dc0c3fe0amr2827369wrz.0.1709121422947; 
 Wed, 28 Feb 2024 03:57:02 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bs17-20020a056000071100b0033df8854f0dsm2536504wrb.26.2024.02.28.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D7C285F7DF;
 Wed, 28 Feb 2024 11:57:01 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/29] testing, gdbstub and plugin updates
Date: Wed, 28 Feb 2024 11:56:32 +0000
Message-Id: <20240228115701.1416107-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 158a054c4d1a40179f5e83cd7e1cfe65de457b92:

  Merge tag 'pull-target-arm-20240227-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-02-27 15:34:41 +0000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-280224-1

for you to fetch changes up to 02ca5ec15089c8717d435d8a842360f15afa7d20:

  docs/devel: plugins can trigger a tb flush (2024-02-28 09:11:42 +0000)

----------------------------------------------------------------
Testing, gdbstub and plugin updates:

  - fix some test/tcg license headers to GPLv2+
  - bump up check-tcg timeout to 120s
  - avoid re-building VM images too often
  - update OpenBSD to 7.4
  - use GDBFeature to build gdbstub XML
  - unify plugin vcpu count under qemu_plugin_num_vcpus
  - avoid spurious idle/resume callbacks on new vCPUs
  - ensure nios2-linux-user processes async work
  - call vcpu_init plugin callback through async work
  - define plugin helpers when registers being read
  - add plugin API for reading register values
  - add support for register tracking to execlog
  - update plugin docs with assumptions
  - mention plugins can trigger tb_flush in mttcg design doc

----------------------------------------------------------------
Akihiko Odaki (11):
      target/arm: Use GDBFeature for dynamic XML
      target/ppc: Use GDBFeature for dynamic XML
      target/riscv: Use GDBFeature for dynamic XML
      gdbstub: Use GDBFeature for gdb_register_coprocessor
      gdbstub: Use GDBFeature for GDBRegisterState
      gdbstub: Change gdb_get_reg_cb and gdb_set_reg_cb
      gdbstub: Simplify XML lookup
      gdbstub: Infer number of core registers from XML
      hw/core/cpu: Remove gdb_get_dynamic_xml member
      gdbstub: Add members to identify registers to GDBFeature
      plugins: Use different helpers when reading registers

Alex Bennée (13):
      tests/tcg: update licenses to GPLv2 as intended
      tests/tcg: bump TCG test timeout to 120s
      tests/vm: avoid re-building the VM images all the time
      tests/vm: update openbsd image to 7.4
      linux-user: ensure nios2 processes queued work
      gdbstub: expose api to find registers
      plugins: create CPUPluginState and migrate plugin_mask
      plugins: add an API to read registers
      tests/tcg: expand insn test case to exercise register API
      contrib/plugins: fix imatch
      contrib/plugins: extend execlog to track register changes
      docs/devel: lift example and plugin API sections up
      docs/devel: document some plugin assumptions

Pierrick Bouvier (5):
      plugins: remove previous n_vcpus functions from API
      plugins: add qemu_plugin_num_vcpus function
      plugins: fix order of init/idle/resume callback
      cpu: call plugin init hook asynchronously
      docs/devel: plugins can trigger a tb flush

 docs/devel/multi-thread-tcg.rst                   |   1 +
 docs/devel/tcg-plugins.rst                        |  72 ++++-
 accel/tcg/plugin-helpers.h                        |   3 +-
 include/exec/gdbstub.h                            |  43 ++-
 include/hw/core/cpu.h                             |  18 +-
 include/qemu/plugin.h                             |  14 +
 include/qemu/qemu-plugin.h                        |  61 ++++-
 include/qemu/typedefs.h                           |   1 +
 plugins/plugin.h                                  |   6 +-
 target/arm/cpu.h                                  |  27 +-
 target/arm/internals.h                            |  14 +-
 target/hexagon/internal.h                         |   4 +-
 target/microblaze/cpu.h                           |   4 +-
 target/ppc/cpu-qom.h                              |   1 +
 target/ppc/cpu.h                                  |   5 +-
 target/riscv/cpu.h                                |   5 +-
 target/s390x/cpu.h                                |   2 -
 tests/tcg/aarch64/semicall.h                      |   4 +-
 tests/tcg/arm/semicall.h                          |   4 +-
 tests/tcg/multiarch/float_helpers.h               |   4 +-
 tests/tcg/riscv64/semicall.h                      |   4 +-
 accel/tcg/plugin-gen.c                            |  46 +++-
 contrib/plugins/cache.c                           |   2 +-
 contrib/plugins/execlog.c                         | 318 ++++++++++++++++++----
 gdbstub/gdbstub.c                                 | 169 +++++++-----
 hw/core/cpu-common.c                              |  19 +-
 linux-user/nios2/cpu_loop.c                       |   1 +
 plugins/api.c                                     |  96 +++++--
 plugins/core.c                                    |  28 +-
 target/arm/cpu.c                                  |   2 -
 target/arm/cpu64.c                                |   1 -
 target/arm/gdbstub.c                              | 230 ++++++++--------
 target/arm/gdbstub64.c                            | 122 +++++----
 target/avr/cpu.c                                  |   1 -
 target/hexagon/cpu.c                              |   4 +-
 target/hexagon/gdbstub.c                          |  10 +-
 target/i386/cpu.c                                 |   2 -
 target/loongarch/cpu.c                            |   2 -
 target/loongarch/gdbstub.c                        |  13 +-
 target/m68k/cpu.c                                 |   1 -
 target/m68k/helper.c                              |  26 +-
 target/microblaze/cpu.c                           |   6 +-
 target/microblaze/gdbstub.c                       |  14 +-
 target/ppc/cpu_init.c                             |   7 -
 target/ppc/gdbstub.c                              | 114 ++++----
 target/riscv/cpu.c                                |  15 -
 target/riscv/gdbstub.c                            | 145 +++++-----
 target/rx/cpu.c                                   |   1 -
 target/s390x/cpu.c                                |   1 -
 target/s390x/gdbstub.c                            | 105 ++++---
 tests/plugin/insn.c                               |  21 ++
 tests/tcg/multiarch/arm-compat-semi/semiconsole.c |   4 +-
 tests/tcg/multiarch/arm-compat-semi/semihosting.c |   4 +-
 tests/tcg/multiarch/float_convd.c                 |   4 +-
 tests/tcg/multiarch/float_convs.c                 |   4 +-
 tests/tcg/multiarch/float_madds.c                 |   4 +-
 tests/tcg/multiarch/libs/float_helpers.c          |   4 +-
 plugins/qemu-plugins.symbols                      |   5 +-
 scripts/feature_to_c.py                           |  14 +-
 tests/tcg/Makefile.target                         |   9 +-
 tests/tcg/i386/system/boot.S                      |   6 +-
 tests/tcg/x86_64/system/boot.S                    |   6 +-
 tests/vm/Makefile.include                         |   2 +-
 tests/vm/basevm.py                                |   4 +-
 tests/vm/openbsd                                  |   9 +-
 65 files changed, 1237 insertions(+), 661 deletions(-)

-- 
2.39.2


