Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C697C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeI0-0005ed-17; Mon, 26 Feb 2024 11:57:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHn-0005Yw-87
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:03 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reeHZ-0007bA-Dl
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:57:03 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512e568607aso3193293e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966607; x=1709571407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OBKvAyeuOak/xVMAWz7/PRRd31WTVLMEySVDeUYbhrU=;
 b=z1ixVZEcMs44d++yWQq28iwKALwFvgkUtlqK8z6IszscXSUe95m/9/lM1AvaMoYW70
 MkX3hr3d+9JBGvJX1XLQWPQrcdoUX4+S/khzK5T/c5kil60XyFa3yk+rMjAsNTBu7fOi
 KqRGvyv2eRO05p0kTe4iPx38hNuKYo+90U9RJzFYMPo+ivkxwOWu0nxl+dXHs2+Hy3Zl
 an0WHPBNcSwvEOjBgkBJzwtetkA+7gtEsdt2Ma6eX9mo3+iAs4BVR++sP6QWSk/khnGV
 R75jZ0BftR+C/4urR5tcIjzFlmvkLPU8aQAqKnGRKbnsL48gq3UXVKLq34PKnJi/oBEo
 Lktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966607; x=1709571407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBKvAyeuOak/xVMAWz7/PRRd31WTVLMEySVDeUYbhrU=;
 b=kSPX2KBTKCrFddx8l1QQ0RL83Wg9+5lnocvTwfIfpb0W76RAXm5liOGIFodMW39bYA
 3nOF9LOR4jHYeuZxHeMG25M/xGrn2x0g1VLScclIgHI6vB+GIlTnW3ZslA94yHH31IOH
 vdY8ettGqYZxjza/qnuT/4oaCXM/I5p0T72wpiwvQi9nkmYal/FRtz/3CC6kXJDoTWQd
 7kzhQnq6LWu+Yg5CoTD471ljcWAbSH2vwBuFtz0QLUknEB3vrM88TtdbBqBXIaTNDObY
 QpkPqwgJ/LRKZClI8ihZW/y20TbvSzorEGgL8AWFkktIpObgRpUgP1G5dgsX1P42NiLG
 6m0A==
X-Gm-Message-State: AOJu0YyYOJIaRPq+O/+bzMWlHAW7uBCaZe4ZUkZ0ts62DI0nqgIJHkPm
 DbsMqQH+GPdR4AMqD+/ReBFq2SSlhmkdK0BY7iztb0d0xK0MS5ROCLoGPKp8U9Y=
X-Google-Smtp-Source: AGHT+IHFOb7reSV82WHmlYGXcsOszkUxki9SBTxwstz5K4eG6w5KaTAZ2UKy3C2xDw9Gqt+/mxIbqA==
X-Received: by 2002:ac2:4e04:0:b0:512:cebf:e8d5 with SMTP id
 e4-20020ac24e04000000b00512cebfe8d5mr5503899lfr.23.1708966607419; 
 Mon, 26 Feb 2024 08:56:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b0040ecdd672fasm8666361wmb.13.2024.02.26.08.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 08:56:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A427B5F714;
 Mon, 26 Feb 2024 16:56:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 00/27] maintainer updates for 9.0 pre-PR (tests,
 plugin register support)
Date: Mon, 26 Feb 2024 16:56:19 +0000
Message-Id: <20240226165646.425600-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The test patch is a simple house keeping one to clean up some
inadvertent GPLv3 tagging to GPLv2-or-later. I've also increased the
timeout for check-tcg due to TCI timesouts.

The main bulk of this series is register reading support for TCG
plugins. The main change to the API is that the get/read_register
functions are now implicitly vCPU context only so have dropped the
vcpu index parameter and use current_cpu instead. This avoids the need
for locking the gdbstub structures in case there is a cross-vCPU
access.

I've pulled in some patches from Pierrick's inline enhancement series
that allow this to happen (making sure the init callback is in the
vCPU context).

Changes for v3:

Now we just use GINT_TO_POINTER to wrap the gdb_regnum with a comment
this might become and opaque structure later. Either way the plugin
shouldn't treat it like anything other than an anonymous handle.

The following still need review:

  tests/tcg: expand insn test case to exercise register API
  gdbstub: expose api to find registers

But I'd like to get this merged soon so its not a mad rush before soft
freeze and so we can get the new inline support stabilised and merged.

Alex.

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

Alex Bennée (11):
  tests/tcg: update licenses to GPLv2 as intended
  tests/tcg: bump TCG test timeout to 120s
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

 docs/devel/multi-thread-tcg.rst               |   1 +
 docs/devel/tcg-plugins.rst                    |  72 +++-
 accel/tcg/plugin-helpers.h                    |   3 +-
 include/exec/gdbstub.h                        |  43 ++-
 include/hw/core/cpu.h                         |  18 +-
 include/qemu/plugin.h                         |  14 +
 include/qemu/qemu-plugin.h                    |  59 +++-
 include/qemu/typedefs.h                       |   1 +
 plugins/plugin.h                              |   6 +-
 target/arm/cpu.h                              |  27 +-
 target/arm/internals.h                        |  14 +-
 target/hexagon/internal.h                     |   4 +-
 target/microblaze/cpu.h                       |   4 +-
 target/ppc/cpu-qom.h                          |   1 +
 target/ppc/cpu.h                              |   5 +-
 target/riscv/cpu.h                            |   5 +-
 target/s390x/cpu.h                            |   2 -
 tests/tcg/aarch64/semicall.h                  |   4 +-
 tests/tcg/arm/semicall.h                      |   4 +-
 tests/tcg/multiarch/float_helpers.h           |   4 +-
 tests/tcg/riscv64/semicall.h                  |   4 +-
 accel/tcg/plugin-gen.c                        |  46 ++-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/execlog.c                     | 318 +++++++++++++++---
 gdbstub/gdbstub.c                             | 169 ++++++----
 hw/core/cpu-common.c                          |  19 +-
 linux-user/nios2/cpu_loop.c                   |   1 +
 plugins/api.c                                 |  97 ++++--
 plugins/core.c                                |  28 +-
 target/arm/cpu.c                              |   2 -
 target/arm/cpu64.c                            |   1 -
 target/arm/gdbstub.c                          | 230 ++++++-------
 target/arm/gdbstub64.c                        | 122 +++----
 target/avr/cpu.c                              |   1 -
 target/hexagon/cpu.c                          |   4 +-
 target/hexagon/gdbstub.c                      |  10 +-
 target/i386/cpu.c                             |   2 -
 target/loongarch/cpu.c                        |   2 -
 target/loongarch/gdbstub.c                    |  13 +-
 target/m68k/cpu.c                             |   1 -
 target/m68k/helper.c                          |  26 +-
 target/microblaze/cpu.c                       |   6 +-
 target/microblaze/gdbstub.c                   |  14 +-
 target/ppc/cpu_init.c                         |   7 -
 target/ppc/gdbstub.c                          | 114 ++++---
 target/riscv/cpu.c                            |  15 -
 target/riscv/gdbstub.c                        | 145 ++++----
 target/rx/cpu.c                               |   1 -
 target/s390x/cpu.c                            |   1 -
 target/s390x/gdbstub.c                        | 105 +++---
 tests/plugin/insn.c                           |  21 ++
 .../multiarch/arm-compat-semi/semiconsole.c   |   4 +-
 .../multiarch/arm-compat-semi/semihosting.c   |   4 +-
 tests/tcg/multiarch/float_convd.c             |   4 +-
 tests/tcg/multiarch/float_convs.c             |   4 +-
 tests/tcg/multiarch/float_madds.c             |   4 +-
 tests/tcg/multiarch/libs/float_helpers.c      |   4 +-
 plugins/qemu-plugins.symbols                  |   5 +-
 scripts/feature_to_c.py                       |  14 +-
 tests/tcg/Makefile.target                     |   9 +-
 tests/tcg/i386/system/boot.S                  |   6 +-
 tests/tcg/x86_64/system/boot.S                |   6 +-
 62 files changed, 1228 insertions(+), 654 deletions(-)

-- 
2.39.2


