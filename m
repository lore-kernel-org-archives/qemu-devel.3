Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63E3C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAwW-0004oA-85; Fri, 28 Jun 2024 08:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwU-0004n3-F0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:06 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwQ-0005eh-Rj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:06 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d15b85a34so664338a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578581; x=1720183381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=950bvrnXU/W+RliUBgLvg0wluQPzz+2hnnbWsXrLYh8=;
 b=DudtucJdgnQBiwoA5B/LkdTrkHLLYamTWchdKw7nBhBtQibpX/Ai6x8P/FvdRWn8AG
 EBppPQILNyzmYH/iKEt9F0KSFCxlQ6pUJFu6+KQ66yzDI6Ig9LY0OaK4qTAMPoFecmVp
 gY4Z25rhALdIacatVDJUbT7rabII2nauuykVLOMuY5XJXc94elFcCYNes1J7FvrRE+rZ
 /nQ5mDxydkb34P1gD1DxOS5JaSFd0yZ5KnQnwqm7e+yhU8vSRFb8in8LqQbMrmDCNKKz
 w8yJusbOwJbl8vK5bTzdnuBDZ48Zgw7zpWSBhYblRDp1UeMzzd0Y+jDaG84gPBigMGUn
 ci0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578581; x=1720183381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=950bvrnXU/W+RliUBgLvg0wluQPzz+2hnnbWsXrLYh8=;
 b=SoznFpWQURhFP8Gfk07b+CeMKZiNqrcm0ZlMjTS4SUg7uMclKgcaePwV6YPDNxkQwO
 ZUaCrMBEqOM+WxB949nf42EcvlehoTfe8OezC7TsUIDBXpE5THes59ZEO0GYE4/rifmS
 KkgZqvTujtAmZPtlDJF8pjlXTrymTmYzrjdglBkwwXCWkKipz8oXB+ZzTSVmobeAqeOo
 IHCdfrLyLTDskm5kn0GvfQrttferBuAB7warwiyoLgmfZ5UC+hcRSppBbWZOh8SGv1Eu
 vhN3Bus40agS0F/ZS7r9ET4WEsEiMkNFZG4U4XqhrBWrF750Q7g6PajOmrg1L6A3I+Q6
 XzRQ==
X-Gm-Message-State: AOJu0YyXJ0Q4I3NkvXFOL5VFfOH6Ll+U6V1jfEDupBKCvYtP6n1mYB3E
 zCTHEGbmsZFqU40L5NbipvZn7t2wakut91cbJ3Fb00nk4m2tS2RCJZbPKfW0VwI=
X-Google-Smtp-Source: AGHT+IGmFwU+hhB/a9dGQSg3U60mmErLQACeIzO+poqp8CBPCIVvFAKdSSGd4eelBgPWvisiYrcf5g==
X-Received: by 2002:a17:907:d311:b0:a72:762a:eee1 with SMTP id
 a640c23a62f3a-a72762af002mr777017766b.10.1719578580414; 
 Fri, 28 Jun 2024 05:43:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab090575sm75776466b.184.2024.06.28.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 002B55F7A1;
 Fri, 28 Jun 2024 13:42:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 00/23] July maintainer updates (32bit, testing, plugins,
 gdbstub)
Date: Fri, 28 Jun 2024 13:42:35 +0100
Message-Id: <20240628124258.832466-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

Hi,

This is a grab bag of fixes and clean-ups as we swiftly approach the
soft freeze deadline. The i386 TCG fix came about when re-enabling the
32 bit host build and finding a regression which was masked by KVM's
presence. As a result I decided to disable KVM in the build anyway as
its TCG most likely to get tripped up by 32/64 bit issues.

The plugins fixes are mostly tweaks I made while hunting the above
bug.

I've also included Gustavo's gdbstub MTE support.

The following still need review:

  tests/tcg/aarch64: Add MTE gdbstub tests
  gdbstub: Add support for MTE in user mode
  gdbstub: Use true to set cmd_startswith
  plugins/lockstep: clean-up output
  plugins/lockstep: mention the one-insn-per-tb option
  plugins/lockstep: make mixed-mode safe
  plugins/lockstep: preserve sock_path
  test/plugins: preserve the instruction record over translations
  test/plugin: make insn plugin less noisy by default
  tracepoints: move physmem trace points
  testing: restore some testing for i686
  target/i386: fix gen_prepare_size_nz condition
  tests/lcitool: fix debian-i686-cross toolchain prefix

Akihiko Odaki (2):
  tests/docker: Specify --userns keep-id for Podman
  tests/tcg/arm: Fix fcvt result messages

Alex Bennée (10):
  tests/lcitool: fix debian-i686-cross toolchain prefix
  target/i386: fix gen_prepare_size_nz condition
  testing: restore some testing for i686
  tracepoints: move physmem trace points
  test/plugin: make insn plugin less noisy by default
  test/plugins: preserve the instruction record over translations
  plugins/lockstep: preserve sock_path
  plugins/lockstep: make mixed-mode safe
  plugins/lockstep: mention the one-insn-per-tb option
  plugins/lockstep: clean-up output

Gustavo Romero (11):
  gdbstub: Clean up process_string_cmd
  gdbstub: Move GdbCmdParseEntry into a new header file
  gdbstub: Add support for target-specific stubs
  target/arm: Fix exception case in allocation_tag_mem_probe
  target/arm: Make some MTE helpers widely available
  target/arm: Factor out code for setting MTE TCF0 field
  gdbstub: Make hex conversion function non-internal
  gdbstub: Pass CPU context to command handler
  gdbstub: Use true to set cmd_startswith
  gdbstub: Add support for MTE in user mode
  tests/tcg/aarch64: Add MTE gdbstub tests

 configure                                     |   4 +
 configs/targets/aarch64-linux-user.mak        |   2 +-
 gdbstub/internals.h                           |  23 -
 include/gdbstub/commands.h                    | 103 +++
 linux-user/aarch64/mte_user_helper.h          |  32 +
 linux-user/aarch64/target_prctl.h             |  22 +-
 target/arm/internals.h                        |   6 +
 target/arm/tcg/mte_helper.h                   |  66 ++
 contrib/plugins/lockstep.c                    |  23 +-
 gdbstub/gdbstub.c                             | 341 ++++++----
 gdbstub/syscalls.c                            |   7 +-
 gdbstub/system.c                              |   7 +-
 gdbstub/user-target.c                         |  25 +-
 gdbstub/user.c                                |   7 +-
 linux-user/aarch64/mte_user_helper.c          |  35 +
 linux-user/syscall.c                          |   9 -
 system/physmem.c                              |   6 +-
 target/arm/cpu.c                              |   1 +
 target/arm/gdbstub.c                          |  46 ++
 target/arm/gdbstub64.c                        | 223 +++++++
 target/arm/tcg/mte_helper.c                   |  48 +-
 target/i386/tcg/translate.c                   |   2 +-
 tests/plugin/insn.c                           | 112 +++-
 tests/tcg/aarch64/mte-8.c                     |  98 +++
 tests/tcg/arm/fcvt.c                          |   2 +-
 .gitlab-ci.d/crossbuilds.yml                  |  11 +
 gdb-xml/aarch64-mte.xml                       |  11 +
 linux-user/aarch64/meson.build                |   2 +
 system/trace-events                           |   6 +
 tests/docker/Makefile.include                 |   7 +-
 .../dockerfiles/debian-i686-cross.docker      |   2 +-
 tests/lcitool/refresh                         |   2 +-
 tests/tcg/aarch64/Makefile.target             |  14 +-
 tests/tcg/aarch64/fcvt.ref                    | 604 +++++++++---------
 tests/tcg/aarch64/gdbstub/test-mte.py         |  86 +++
 trace-events                                  |   5 -
 36 files changed, 1401 insertions(+), 599 deletions(-)
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 linux-user/aarch64/mte_user_helper.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 linux-user/aarch64/mte_user_helper.c
 create mode 100644 tests/tcg/aarch64/mte-8.c
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py

-- 
2.39.2


