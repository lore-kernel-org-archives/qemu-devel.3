Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F4AC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTce-0001VK-Lv; Tue, 05 Mar 2024 07:10:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTca-0001Qn-3W
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTcW-0001BO-LX
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:10:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412e6bdd454so12020195e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709640606; x=1710245406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YBobDIzjq+FEEKLq7A1VHLIqtIHgR7MyyrYSn6xZbDo=;
 b=w7zRn/D9rx9AhfpAYQoTFcXTC8jmvkZXoNXRADP7YHVxaxHpLhiLM86INNNiRXZ6gd
 Q2rLkbHEUhOwkMDF+uH8RKjdFQFInUTd364olch/V/DTHFyDsBCIEuauYo94pDOn9dF3
 zOhCAwfChlaHPvVh6ThqOdT4d951Hy35NpC/qVKf5FeKNPbsE0OBBLU2cVllVr0DiJgB
 8ASTqh24neco4OxkY/XQ32nmRlwmkyazdHEvQ0ve8XEhmswWEQnI/1RkPqD3Fav6PUe5
 NsWc+MAjRKJoOg4uPxCulqY8qSq8LC34COxDe4HnFXc1/ZXKBF3/VRmsWSsxJe70UsNd
 Daxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709640606; x=1710245406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YBobDIzjq+FEEKLq7A1VHLIqtIHgR7MyyrYSn6xZbDo=;
 b=abKAfJ/DWJnQ3omzLOiZRdm53IWwT9vN4IXOd+rmUjJfqt51sStVf53Jngn1HxkLF5
 9/vzbJnShOmpkbH9oXTmjQLVfrEyHqA5WYZfQ5CUhVtaaa8JEFxVdd4WOUlrrqklEfsR
 UU/EqcpmkbZqLVOXzE2yZ+fRIU33aG0KUMfnqQWTC1i8T0uAAZLHSfVxzrENWmNwPbaH
 /4fQ0ut8Cu4plTg8z5Ny7mLzigCDGu99qNr0EAkNvyppfypTKllmXgBR0lVsXDRvIGkc
 ew6n/+Y/45KwEogaOk1jrnCzHCQiMk2gOBwgqXCY1tsY2V644LfgJbQ/ESTcmTXswwOC
 xDDQ==
X-Gm-Message-State: AOJu0YzJUQ+DCLq+g7yKR8PGmXsA9Hqm03+6YqqLwn1tSQpmm+YX6EVA
 muxonOv2d7wpKv+KvUkgfyrsW/hmMKWbIEJDrn+FzIV6BwU5yycahsv7NRML/2A=
X-Google-Smtp-Source: AGHT+IFDKYE6yJWytxr9qvikD5AWAyVoktcEIDgwF1iQqXHkXh4CSMiS+ydvc2XhqXcVyR33VzWksw==
X-Received: by 2002:a05:600c:46ce:b0:412:6c5f:d971 with SMTP id
 q14-20020a05600c46ce00b004126c5fd971mr9104153wmo.11.1709640606285; 
 Tue, 05 Mar 2024 04:10:06 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c350900b00412de55135dsm7789729wmq.41.2024.03.05.04.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:10:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6AB685F7B5;
 Tue,  5 Mar 2024 12:10:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 00/29] maintainer/next for 9.0 (testing, gdbstub, plugins,
 disas)
Date: Tue,  5 Mar 2024 12:09:36 +0000
Message-Id: <20240305121005.3528075-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

As I'm going to be away for most of the tree stabilisation period I'm
trying to be proactive clearing my maintainer backlog before the
softfreeze. With that in mind heres what is ready to go in:

Testing

Most stuff is being directly applied as downstreams stop working (c.f.
BSD and MacOS breakage). So all I have left is a fix for qos-tests
that shows up when LTO is enabled.

GDBStub

These are Ilya's fork follow mode patches for gdbstub. I hope to
include Gustavo's signal handling stuff if it is fixed this week.

Plugins

This introduces Pierrick's work to have thread-safe inline counters
via the concept of a vcpu indexed scoreboard. There will be further
work over the next cycle to enable more efficient instrumentation and
address more of the missing pieces people have been asking for.

Finally there are a few cosmetic patches to ensure the disassembly
that plugins get don't include opcodes which plugins can get another
way. They are the only patches that need review:

  target/riscv: honour show_opcodes when disassembling
  target/loongarch: honour show_opcodes when disassembling
  disas/hppa: honour show_opcodes
  disas: introduce show_opcodes

Hopefully I can get the PR for this rolled later this week.

Alex.

Alex Bennée (5):
  tests: bump QOS_PATH_MAX_ELEMENT_SIZE again
  disas: introduce show_opcodes
  disas/hppa: honour show_opcodes
  target/loongarch: honour show_opcodes when disassembling
  target/riscv: honour show_opcodes when disassembling

Ilya Leoshkevich (12):
  gdbstub: Support disablement in a multi-threaded process
  {linux,bsd}-user: Introduce get_task_state()
  {linux,bsd}-user: Update ts_tid after fork()
  gdbstub: Introduce gdbserver_fork_start()
  {linux,bsd}-user: Pass pid to fork_end()
  {linux,bsd}-user: Pass pid to gdbserver_fork()
  gdbstub: Call gdbserver_fork() both in parent and in child
  gdbstub: Introduce gdb_handle_query_supported_user()
  gdbstub: Introduce gdb_handle_set_thread_user()
  gdbstub: Introduce gdb_handle_detach_user()
  gdbstub: Implement follow-fork-mode child
  tests/tcg: Add two follow-fork-mode tests

Pierrick Bouvier (12):
  plugins: scoreboard API
  plugins: define qemu_plugin_u64
  plugins: implement inline operation relative to cpu_index
  plugins: add inline operation per vcpu
  tests/plugin: add test plugin for inline operations
  tests/plugin/mem: migrate to new per_vcpu API
  tests/plugin/insn: migrate to new per_vcpu API
  tests/plugin/bb: migrate to new per_vcpu API
  contrib/plugins/hotblocks: migrate to new per_vcpu API
  contrib/plugins/howvec: migrate to new per_vcpu API
  plugins: remove non per_vcpu inline operation from API
  plugins: cleanup codepath for previous inline operation

 bsd-user/bsd-file.h                           |   2 +-
 bsd-user/freebsd/os-proc.h                    |   6 +-
 bsd-user/qemu.h                               |   7 +-
 gdbstub/internals.h                           |   3 +
 include/disas/dis-asm.h                       |   8 +
 include/gdbstub/user.h                        |  10 +-
 include/qemu/plugin.h                         |   7 +
 include/qemu/qemu-plugin.h                    | 142 +++++++---
 include/user/safe-syscall.h                   |   2 +-
 linux-user/m68k/target_cpu.h                  |   2 +-
 linux-user/qemu.h                             |   5 +
 linux-user/signal-common.h                    |   2 +-
 linux-user/user-internals.h                   |   2 +-
 plugins/plugin.h                              |  17 +-
 tests/qtest/libqos/qgraph.h                   |   2 +-
 accel/tcg/plugin-gen.c                        |  69 ++++-
 bsd-user/main.c                               |   9 +-
 bsd-user/signal.c                             |  20 +-
 contrib/plugins/hotblocks.c                   |  50 ++--
 contrib/plugins/howvec.c                      |  53 ++--
 disas/disas.c                                 |   1 +
 disas/hppa.c                                  |   8 +-
 disas/riscv.c                                 |  28 +-
 gdbstub/gdbstub.c                             |  29 ++-
 gdbstub/user-target.c                         |   4 +-
 gdbstub/user.c                                | 244 +++++++++++++++++-
 linux-user/aarch64/cpu_loop.c                 |   2 +-
 linux-user/arm/cpu_loop.c                     |   4 +-
 linux-user/arm/signal.c                       |   2 +-
 linux-user/cris/cpu_loop.c                    |   2 +-
 linux-user/elfload.c                          |   2 +-
 linux-user/hppa/signal.c                      |   2 +-
 linux-user/linuxload.c                        |   2 +-
 linux-user/m68k/cpu_loop.c                    |   2 +-
 linux-user/main.c                             |   8 +-
 linux-user/mips/cpu_loop.c                    |   2 +-
 linux-user/ppc/signal.c                       |   4 +-
 linux-user/riscv/cpu_loop.c                   |   2 +-
 linux-user/signal.c                           |  30 +--
 linux-user/syscall.c                          |  32 +--
 linux-user/vm86.c                             |  18 +-
 linux-user/xtensa/signal.c                    |   2 +-
 plugins/api.c                                 | 100 +++++--
 plugins/core.c                                |  79 +++++-
 semihosting/arm-compat-semi.c                 |   8 +-
 target/loongarch/disas.c                      |  13 +-
 tests/plugin/bb.c                             |  63 ++---
 tests/plugin/inline.c                         | 186 +++++++++++++
 tests/plugin/insn.c                           | 106 ++++----
 tests/plugin/mem.c                            |  46 ++--
 tests/tcg/multiarch/follow-fork-mode.c        |  56 ++++
 plugins/qemu-plugins.symbols                  |  13 +-
 tests/plugin/meson.build                      |   2 +-
 tests/tcg/Makefile.target                     |   2 +-
 tests/tcg/multiarch/Makefile.target           |  17 +-
 .../gdbstub/follow-fork-mode-child.py         |  40 +++
 .../gdbstub/follow-fork-mode-parent.py        |  16 ++
 57 files changed, 1257 insertions(+), 338 deletions(-)
 create mode 100644 tests/plugin/inline.c
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

-- 
2.39.2


