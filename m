Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1814DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reygN-0005EX-An; Tue, 27 Feb 2024 09:43:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygK-0005Dh-FG
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:44 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reygF-0001x2-Bj
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:43:43 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2d22b8801b9so71648761fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045016; x=1709649816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWUgYgGbBq0Rftb97XkjY8209ZR6PASvKOfa7J1VRq0=;
 b=DsEusL3mp+pNDNgSdfIXipYTEHMwIv1C5wv+x6tYby4+6Z6oTuRIBmYCbEPnhVnQbp
 vl2d8JKa5sXyKEXX60tkipRD30kIV3DYiA3hwZvembxZrB3cF2QE+K5QXGub2Izf8x2/
 wBXWolq+TG5VNirEHyNkwtW2uOhiQ0l4E6bvin842+U8HYBOXm7Qli7OMsnHpagxzSf6
 AG1EbaEZ8o5AAtXCwCeUwowCSlcV4MApJyzH2JLyKkQ2J6B0/3zcpSOLV8xuqwMLM3Ux
 nWHNPiSwih9ILpiMpxhruUA4+4AtjP5RAiaTc7RwqsrPqbcnSpYTjO4GzOLCI9QHAiar
 gEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045016; x=1709649816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWUgYgGbBq0Rftb97XkjY8209ZR6PASvKOfa7J1VRq0=;
 b=twfUvLRHeqxbMijX+njwMN0L0egqFUxd0dfgvNzyoLSVcEstGhOxU72u0Tdpvw6MQQ
 Tz3GnhwxgUsmrTs44xIi1A6EhQdrb0BBESLP5px1HjQ6yK4T9qJ9IrkFmAploQ0Nwky5
 YYVD3hUq9kE4ARjw8xRonOtHzyxtfTHrYyXj/ofp1qjSdyd9dCw0BSn8GOCc/ALP8mmc
 bISKLe7Ifg4hl0DFab9r8ShTcCqMQWkc+f9Obc3bc4f+ETFjIuMiU5kDL5WJWQSNXnVU
 KovxME5247GCasnvma9UnDB06ku32/PQWoeRqyN/6vRLf1f+xilINqizU7qMMC0mLKBf
 D10A==
X-Gm-Message-State: AOJu0YxCT22BgPO6xRPQBZOdaUKAzTDhYbnfndznlJID63FpI+/Pw7XS
 SMNpcfUDtmZkUUbvBNYFTx2sVivq6K7MEyrqabCcbCvfKfqMW9uz+tkRs5J00ik=
X-Google-Smtp-Source: AGHT+IHiWkm0zLvHy0VujHECXA+/T4fBxoW067Z6kPSf83rVULgXuztBLmC3PPGLPkr26yR47wOHkw==
X-Received: by 2002:a2e:a9a6:0:b0:2d2:4348:766 with SMTP id
 x38-20020a2ea9a6000000b002d243480766mr3771768ljq.19.1709045016097; 
 Tue, 27 Feb 2024 06:43:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00411a6ce0f99sm11515764wmo.24.2024.02.27.06.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:43:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 641355F753;
 Tue, 27 Feb 2024 14:43:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v4 00/29] maintainer updates for 9.0 pre-PR (tests,
 plugin register support)
Date: Tue, 27 Feb 2024 14:43:06 +0000
Message-Id: <20240227144335.1196131-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

The test patch is a simple house keeping one to clean up some
inadvertent GPLv3 tagging to GPLv2-or-later. I've also increased the
timeout for check-tcg due to TCI timeouts.

The main bulk of this series is register reading support for TCG
plugins. The main change to the API is that the get/read_register
functions are now implicitly vCPU context only so have dropped the
vcpu index parameter and use current_cpu instead. This avoids the need
for locking the gdbstub structures in case there is a cross-vCPU
access.

I've pulled in some patches from Pierrick's inline enhancement series
that allow this to happen (making sure the init callback is in the
vCPU context).

Changes for v4

Addressed final comments from Akihiko
Added BSD changes

Changes for v3:

Now we just use GINT_TO_POINTER to wrap the gdb_regnum with a comment
this might become and opaque structure later. Either way the plugin
shouldn't treat it like anything other than an anonymous handle.

The following still need review:

  tests/tcg: expand insn test case to exercise register API
  gdbstub: expose api to find registers
  tests/vm: update openbsd image to 7.4 (0 acks, 1 sobs, 1 tbs)
  tests/vm: avoid re-building the VM images all the time

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
 plugins/api.c                                 |  96 ++++--
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
 tests/vm/Makefile.include                     |   2 +-
 tests/vm/basevm.py                            |   4 +-
 tests/vm/openbsd                              |   9 +-
 65 files changed, 1235 insertions(+), 661 deletions(-)

-- 
2.39.2


