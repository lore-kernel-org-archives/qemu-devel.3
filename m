Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39BCC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebmz-0003Bn-6s; Thu, 15 Aug 2024 10:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-00036w-MQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmv-0000Bl-1I
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5b5b67d0024so1288614a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733354; x=1724338154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g1i8FNivYpeAFOmR72AaEwCVagScAYeMii2EtYMaJis=;
 b=iLmgrHX+bWuABFrlGnArDYmHgzLwqanxR8J1kxvPqHw2uaW21WUnGgHs1ohWI7NhnQ
 Ea2kxTbwKIo94Azbq+md4m5a9IdmGQefGy53FQ7/h3krnnZalDDISGsMyw0kZFirl5S6
 +PbZMVH3KORqhFpSkauPyF0yL9HojwYNXPF6jkZo4rNLrMi9S+K7JWa5OhpkddRUTuNL
 WiJK+0nTs+PD+lQTkl42ynlMxG3jKCMx1e95+GcQKvXjBEKXUh4VgfIm4sQUQH2USirm
 S7edz0625KSKSMBP0Bh1sq0txVB2atrESvMnDhUcYbGh/CPkLGUV36ZLRICwOrAzHduv
 Rpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733354; x=1724338154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g1i8FNivYpeAFOmR72AaEwCVagScAYeMii2EtYMaJis=;
 b=NsMC2axEAFqVn024uzQ1p+XYvh01ZBSTgkH5jMZ7HJUs2/C2Igwvsrl7jBgp07ueUu
 beBHsvof70HbPdh1pUB0ZWY1ORto0ovRwWnoj8chkY+vRTfaYJDCtroski/0sdA+0Ice
 MlsXgRDc/sZ9SlZipsnwQwILW3iUO8RL7Z+ZtZZDgL8XrrgjpcG1w4Pkom804cYZDCmp
 kDfmDaJJclPGH9vpnr4P4nI+LCV1JoV5YcpymuU1nwMCdriQKq9EmwicKh2gQmN4nGQ/
 RuwWf4rL493SRBWig2MCwFgR/b3m/TDW4TlJCzPo/SI5uPeJommTauajZNv76TD2BAD9
 MkBQ==
X-Gm-Message-State: AOJu0Yxy531Jn5Qq6pDLvIuFmUBNqN1PzPN43Uc4FJiOZnO+mSMjlqwT
 jRkkypYMTP0F7w76TqztbYfO3cuLGaEt1PsQA+WC/ioLn7su/mFXEeXvdcDtML7p+UYd3dy9D3Y
 t
X-Google-Smtp-Source: AGHT+IHDvXkObiTdTJwVJ3dFxyHIU/YdViq7mE9ieuIaFIynktTZw1Vt/GAGdyS7ZSOXvCn4S5fzoQ==
X-Received: by 2002:a17:907:f74b:b0:a77:bfca:da57 with SMTP id
 a640c23a62f3a-a8367058e51mr456332866b.44.1723733354181; 
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6998sm113683866b.19.2024.08.15.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B37975F8E4;
 Thu, 15 Aug 2024 15:49:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL for 9.1 00/21] Some fixes for 9.1-rc3 (build, replay, docs,
 plugins)
Date: Thu, 15 Aug 2024 15:48:50 +0100
Message-Id: <20240815144911.1931487-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

The following changes since commit b0d6c037ea0a825192285f149af72a73a1baaa04:

  Update version for v9.1.0-rc2 release (2024-08-15 20:32:37 +1000)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-9.1-rc3-150824-1

for you to fetch changes up to f39cbfc9f8dcb17e8168735acb6fb75638d9904f:

  plugins: fix race condition with scoreboards (2024-08-15 12:10:23 +0100)

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


