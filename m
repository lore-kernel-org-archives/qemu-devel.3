Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1F5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 13:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewpZ-00006i-OJ; Fri, 16 Aug 2024 09:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewpW-00005o-K9
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:17:24 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewpT-0006ju-4u
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 09:17:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso13606395e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723814236; x=1724419036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3s5jOdTrAiEUgXbaiSvG7TfWdlhfq0DM9hXaeA8tn/4=;
 b=XKT07/kE/9Ca6CxTlPoFaf78HpTgI6Ii/L/km1bIgsqgCB6ZObY8q/KYHikwbh+16I
 HD5vJRHCkjxkx5s3FmJrsFOboUg9m8ZDeZ0EXJPWocwEi9gsS2lKVx51Wo1sA00NvebL
 z6PZ6W1VTCCTDO3P96mbY7V7lYw/z3pUL2HVAM6ZMir91bNJfiQEFwIrXaP0cfWA7TCW
 nT1Zga4aR2Igct0LkJyP4CVqxyNc4ezOJp3zkw+uvzXXX/qCUOAc68joER3moqnSfl2C
 1pFF/dAaUbIVeQSbERH43QHMKIkz8/cKM2il7FUXFcHSrp9naE5rc5e+xBtteuilh/iY
 JXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723814236; x=1724419036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3s5jOdTrAiEUgXbaiSvG7TfWdlhfq0DM9hXaeA8tn/4=;
 b=mu+TEXR6pe/Ej6gYbe1h7nkghqZxQ4+8ieAJ7seIn0kXZvvg3WwgRD3PfTiFPvjIVP
 5qpUWgeP8n3VHDLUAnFrrYKgKgTnUPriUQckp+iQWEwCR+hllEkFGhu6RkAZGJYl8bbj
 GcUtumxppS1qZR1arDSptM0hZ5Li25lc57vgNZ1jciVL0CX27KYsvIAbIjE+xBZBNkzz
 0wODhuecFifTbDoi9iYq98lIgbhrEvT4CsrRKk/tgKrtnBQJPegJzMIm9sZr25Lvcy1c
 86Ctw06IvH7bgT/yeKoHh+9YF2pfu+IgJH/paeMCX8UZcpwG6Pm89C0WIZKzfBoSksXN
 Upgg==
X-Gm-Message-State: AOJu0YxskBizvBF0Aqkv5+hYYx6d48k3ebEHPgr1F5TBoqTnWbcbzpuY
 Qm+PkWyccVwkLleQfdQF/AcHBTrAeV5yj76KFGPGrMZT9uPTMaQhldDBpSGMlOE/uQHmMvpp0bk
 c
X-Google-Smtp-Source: AGHT+IGbGMXjFdQGhn8XAMcbQCY74O/GEuQtrtky9F/tATwKQir39//ozYT3Ehi83xFKu4vHHMnesw==
X-Received: by 2002:a05:600c:3552:b0:426:593c:9351 with SMTP id
 5b1f17b1804b1-429ed7a5f31mr19968005e9.6.1723814235573; 
 Fri, 16 Aug 2024 06:17:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429eeadfafbsm18223025e9.47.2024.08.16.06.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 06:17:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF6B35F867;
 Fri, 16 Aug 2024 14:17:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v2 for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay, docs,
 plugins)
Date: Fri, 16 Aug 2024 14:17:13 +0100
Message-Id: <20240816131713.2321664-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

The following changes since commit ecdfa31beb1f7616091bedba79dfdf9ee525ed9d:

  Merge tag 'pull-request-2024-08-16' of https://gitlab.com/thuth/qemu into staging (2024-08-16 18:18:27 +1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc3-160824-1

for you to fetch changes up to 278035fc81510bd88501afb78bd5ab652beffa76:

  plugins: fix race condition with scoreboards (2024-08-16 14:13:07 +0100)

----------------------------------------------------------------
Some fixes for 9.1-rc3 (build, replay, docs, plugins)

  - re-enable gdbsim-r5f562n8 test
  - ensure updates to python deps re-trigger configure
  - tweak configure detection of GDB MTE support
  - make checkpatch emit more warnings on updating headers
  - allow i386 access_ptr to force slow path for plugins
  - fixe some replay regressions
  - update the replay-dump tool
  - better handle muxed chardev during replay
  - clean up TCG plugins docs to mention scoreboards
  - fix plugin scoreboard race condition

----------------------------------------------------------------
Alex Bennée (2):
      Makefile: trigger re-configure on updated pythondeps
      target/i386: allow access_ptr to force slow path on failed probe

Gustavo Romero (3):
      configure: Fix arch detection for GDB_HAS_MTE
      configure: Avoid use of param. expansion when using gdb_version
      configure: Fix GDB version detection for GDB_HAS_MTE

Nicholas Piggin (10):
      scripts/replay-dump.py: Update to current rr record format
      scripts/replay-dump.py: rejig decoders in event number order
      tests/avocado: excercise scripts/replay-dump.py in replay tests
      replay: allow runstate shutdown->running when replaying trace
      Revert "replay: stop us hanging in rr_wait_io_event"
      tests/avocado: replay_kernel.py add x86-64 q35 machine test
      chardev: set record/replay on the base device of a muxed device
      virtio-net: Use replay_schedule_bh_event for bhs that affect machine state
      virtio-net: Use virtual time for RSC timers
      savevm: Fix load_snapshot error path crash

Philippe Mathieu-Daudé (2):
      tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
      buildsys: Fix building without plugins on Darwin

Pierrick Bouvier (2):
      docs/devel: update tcg-plugins page
      plugins: fix race condition with scoreboards

Stefan Weil (1):
      docs: Fix some typos (found by typos) and grammar issues

Stefano Garzarella (1):
      scripts/checkpatch: more checks on files imported from Linux

 docs/about/emulation.rst                  |  49 +++++++--
 docs/devel/migration/uadk-compression.rst |   4 +-
 docs/devel/tcg-plugins.rst                |  13 ++-
 docs/interop/qemu-ga.rst                  |   2 +-
 docs/tools/qemu-vmsr-helper.rst           |   4 +-
 configure                                 |   8 +-
 Makefile                                  |   3 +-
 qapi/rocker.json                          |   4 +-
 include/exec/memory.h                     |   2 +-
 include/sysemu/replay.h                   |   5 -
 include/sysemu/runstate.h                 |   1 +
 accel/tcg/tcg-accel-ops-rr.c              |   2 +-
 chardev/char.c                            |  71 +++++++++----
 hw/arm/smmu-common.c                      |   2 +-
 hw/net/virtio-net.c                       |  17 +--
 migration/savevm.c                        |   1 +
 plugins/core.c                            |  43 +++++---
 qga/main.c                                |   2 +-
 replay/replay.c                           |  23 +---
 system/runstate.c                         |  31 +++++-
 target/i386/tcg/access.c                  |  27 +++--
 plugins/meson.build                       |  50 ++++-----
 scripts/checkpatch.pl                     |  24 +++++
 scripts/replay-dump.py                    | 167 ++++++++++++++++++++----------
 tests/avocado/machine_rx_gdbsim.py        |   2 -
 tests/avocado/replay_kernel.py            |  31 +++++-
 tests/avocado/replay_linux.py             |  10 ++
 27 files changed, 406 insertions(+), 192 deletions(-)

-- 
2.39.2


