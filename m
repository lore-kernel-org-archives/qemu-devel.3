Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31DEC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 16:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb16m-0004WX-Ik; Fri, 16 Feb 2024 11:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb16k-0004Ul-DW
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:30:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb16c-00028z-88
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:30:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d152a34c7so621642f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708101027; x=1708705827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1QZylUdoK1CPpHNhgsAqnHF8U+9dY96/ygWB3FaVuLE=;
 b=OyiWrtEeaFqtwNfcwG6CIpE3AAwPxXOwFvnui+G7BgxOrNCAHGVQwTpC+JkRHZ6CwB
 u1+PB+ImlvSpcc3oo2QG8jF/aqT+iSP25jU+cWF0Oi8VhWiAT62BMneJPvolvflFUZb2
 hrX7EvxtbSpw+2VOysCcq/ekYmOYBuvPUCT/hDMQ0qQZROFtXT76IJmq6nAvgIrkbNzl
 ZDslhCDwInh0uf/R8SdrOmyg9b6wRSxXFKomkzj9tzU/q2ld/RXI1ZDmmhRdJss+h4wO
 mPcjHorLExfwfaQZi3ThPDm37Hz4gYOJ8Fw87y3MR2T8p+YUK2PGmZj1eB46ugP9UvK6
 SCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101027; x=1708705827;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1QZylUdoK1CPpHNhgsAqnHF8U+9dY96/ygWB3FaVuLE=;
 b=SJHd1SMOdAmeOR69qRDuDBEX2mgbwjL+hah1rJQbUMak/+uwAIcl+GAohiz53OAJ91
 3JZKYS3IjfKfXS+acZkR7/7z2hiB6lIqV+PlNfuqJNWKKQ7WS7o6Ts4VsfQauaq/ToXB
 TQ4X0EtDI/T25F1tIF+fxOATkBonosZl+PxeSxE3zo5/wLDr6gRTpSy2Hp80mzRjXbF7
 xuV/2vT66r2bcUmCMQEGof1vm+Q3fCo2Yig67JtEQ27tvCoK2QqUmqLcw9pkhex9/Z8c
 LbNybyuF5AlgLo03kbd/9FIWUfp0jeBh1JKjNezej+ev6lZLoipqvfZCQ/3xX94C5BMw
 s84Q==
X-Gm-Message-State: AOJu0YyPGnzpR/vwa3Vz5sdZC79kuphYVpo/jpV+qpkntHHxv4b+dAY4
 ZH4xUTmfvI7Swy3YZ5Dl7NC1NyjZW4l/HDqYvoRTHGqvapoUJRAKmwhq3dqD6rY=
X-Google-Smtp-Source: AGHT+IGfQbBI/6bGngCEopMdkEfBzEr6z1ZD/jSgME7olQ7jS4tO6fHe6dxc5sPDaZfTZ8pA+lVqGw==
X-Received: by 2002:adf:a199:0:b0:33b:353f:6b8f with SMTP id
 u25-20020adfa199000000b0033b353f6b8fmr3801365wru.20.1708101026681; 
 Fri, 16 Feb 2024 08:30:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u10-20020a5d6daa000000b0033d170a5d6dsm2642195wrs.98.2024.02.16.08.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:30:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB44F5F83F;
 Fri, 16 Feb 2024 16:30:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 00/23] maintainer updates for 9.0 pre-PR (tests,
 plugin register support)
Date: Fri, 16 Feb 2024 16:30:02 +0000
Message-Id: <20240216163025.424857-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
inadvertent GPLv3 tagging to GPLv2-or-later.

The main bulk of this series is register reading support for TCG
plugins. The main change to the API is that the get/read_register
functions are now implicitly vCPU context only so have dropped the
vcpu index parameter and use current_cpu instead. This avoids the need
for locking the gdbstub structures in case there is a cross-vCPU
access.

I've pulled in some patches from Pierrick's inline enhancement series
that allow this to happen (making sure the init callback is in the
vCPU context).

The following still need review:

  contrib/plugins: extend execlog to track register changes
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

Alex Bennée (7):
  tests/tcg: update licenses to GPLv2 as intended
  gdbstub: expose api to find registers
  plugins: add an API to read registers
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
 include/hw/core/cpu.h                         |   7 +-
 include/qemu/plugin.h                         |   1 +
 include/qemu/qemu-plugin.h                    |  59 +++-
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
 accel/tcg/plugin-gen.c                        |  43 ++-
 contrib/plugins/cache.c                       |   2 +-
 contrib/plugins/execlog.c                     | 318 +++++++++++++++---
 gdbstub/gdbstub.c                             | 169 ++++++----
 hw/core/cpu-common.c                          |  14 +-
 plugins/api.c                                 | 148 ++++++--
 plugins/core.c                                |  15 +-
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
 target/microblaze/gdbstub.c                   |   9 +-
 target/ppc/cpu_init.c                         |   7 -
 target/ppc/gdbstub.c                          | 114 ++++---
 target/riscv/cpu.c                            |  15 -
 target/riscv/gdbstub.c                        | 145 ++++----
 target/rx/cpu.c                               |   1 -
 target/s390x/cpu.c                            |   1 -
 target/s390x/gdbstub.c                        | 105 +++---
 .../multiarch/arm-compat-semi/semiconsole.c   |   4 +-
 .../multiarch/arm-compat-semi/semihosting.c   |   4 +-
 tests/tcg/multiarch/float_convd.c             |   4 +-
 tests/tcg/multiarch/float_convs.c             |   4 +-
 tests/tcg/multiarch/float_madds.c             |   4 +-
 tests/tcg/multiarch/libs/float_helpers.c      |   4 +-
 plugins/qemu-plugins.symbols                  |   5 +-
 scripts/feature_to_c.py                       |  14 +-
 tests/tcg/i386/system/boot.S                  |   6 +-
 tests/tcg/x86_64/system/boot.S                |   6 +-
 58 files changed, 1216 insertions(+), 635 deletions(-)

-- 
2.39.2


