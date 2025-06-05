Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E4CC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQl-00071q-PP; Thu, 05 Jun 2025 12:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQj-00070R-UU
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:01 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQd-0007vZ-GQ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:01 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-606b58241c9so1820777a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140813; x=1749745613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BXAP2vb5uRbaZ8O92X29Nd0hkT0H+IppWgz5fueqjZc=;
 b=YqSuMfJJ4OvYGLht1nRSbn+FzzN6NLSIZ0dWz8NWTgulqIyBpi/7X2CJqYtVfNtpdr
 9P8eTsilGfae2mAVPYwV1fS0xmiylXC9m2UHPcfe9ynmJ1w9UwbJ7GiOK7fJ+6HQ9vBQ
 vQiitD3TaxmQUYMvmnmjlkqqAUi/6sI+ZbrNMf9QZfX5bGHYn0LPCw3zK6wp7tX/62Hv
 ZXjXuh1rVTmIIhp3ONcvtndQXllqTU4rSJAbaiUy9A6j6iFS0nktfWCjaCKt5w5aP9d7
 hDQKXQp4MOXyJ52Yb63KabXV2Niy1N+hCLZAjXI356B/Vt6ifR9f0L3d619rQDvxytN+
 qS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140813; x=1749745613;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BXAP2vb5uRbaZ8O92X29Nd0hkT0H+IppWgz5fueqjZc=;
 b=P/ZJTjkLaCyzwPSsQ3a3LyDD3S+KnZihFeUsO7WOBtNQFbFeWqA2kO0OUPqNVCP3XF
 yzEvvgJ6xWqiUb5kkiwxh3TBEYpmXdJDcDcHc2502Wk92vmal+Rrc4uGOo9J0klbaKA/
 6ROJ8ktQYEzl7ecFO6Dcb2KCEa1JFiax6CY1iDplFpuh7C9ETnLWeWtyDY1KG2dO5lS9
 YaK+6DsTT3Hjr2zH2W+kVOx+MBiRKW57KJY9pl3OIceD3o6uqIDAxN0mfcWDkcWBTVY9
 Qu94RJ5WGy3JY4QdxxQ8FSIPPQRh7NECa3X5u4iMcHmAJCQVlxTWqQRJIlx0SOYJ5cAt
 Bwog==
X-Gm-Message-State: AOJu0YxBqTNxqUl5PjYVRrgVOGd5EdRf7Y+c63XsA7U1CzjROw4LOoq0
 TQvhp1LvtxQquelQKfdqOZ89mtjsok6CjtsQ/WwhXsFQELi17XygFW38mQuCxfOmcovcY0vI0eU
 izjLTLJI=
X-Gm-Gg: ASbGncvP/EeqXA0FwZA/H3mHE8nqvTLLtSIEMfVhKcD15gJMt6qZ+8Jqw155hiMubDQ
 1vQBqZitq6yhyS/13WnqPGZfYJOHPuvXnijFZxlAvFZp+UVzVV/FwF9hd663/o1Ik6ZXc18N//j
 RK9xO6xmV1aNUqAjhHMg/QMX7zwf8OgfGLTV2C9fD/gwNChmBYr6AoTK1rku/5+aSNxLXlFXQjd
 yEooC96Rq1VwB/kAAF4OVOe83fG8LxSleFREjQF0TzXDCbMpdeKa/yqC06+kasc2pgY8AfdW8UD
 yK0Deeho4EXAEyucX+GUYqauKwTtNapkR8mljSUrPA+3Edk5llnw
X-Google-Smtp-Source: AGHT+IFSMKLzosT42oRabg90x2V0Zd0HTlSSRnC8iGbe3QqcMFShOE/kwNevmExlaIigTMXVSqRXyw==
X-Received: by 2002:a05:6402:2696:b0:607:35d8:4cf8 with SMTP id
 4fb4d7f45d1cf-60735d855c3mr2089144a12.11.1749140812902; 
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60613d1d2bbsm6374585a12.29.2025.06.05.09.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5ABE55F782;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/17] maintainer updates for May (testing, plugins, virtio-gpu)
Date: Thu,  5 Jun 2025 17:26:33 +0100
Message-ID: <20250605162651.2614401-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 09be8a511a2e278b45729d7b065d30c68dd699d0:

  Merge tag 'pull-qapi-2025-06-03' of https://repo.or.cz/qemu/armbru into staging (2025-06-03 09:19:26 -0400)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.1-maintainer-may-2025-050625-1

for you to fetch changes up to 66835968ca7246d385218be9776a80a5136563b7:

  gdbstub: update aarch64-core.xml (2025-06-05 13:47:37 +0100)

----------------------------------------------------------------
Maintainer updates for May 2025:

  - expose ~/.cache/qemu to container builds
  - disable debug info in CI
  - allow boot.S to handle target el mode selection
  - new arguments for ips plugin
  - update virtio-gpu MAINTAINERS
  - re-factoring of blob MemoryRegion handling
  - remove extra draw call causing corruption
  - support Venus fence contexts
  - cleanup assets in size_memop
  - fix include guard in gdbstub
  - introduce qGDBServerVersion gdbstub query
  - update gdb aarch64-core.xml to support bitfields

----------------------------------------------------------------
Alex Bennée (11):
      tests/docker: expose $HOME/.cache/qemu as docker volume
      gitlab: disable debug info on CI builds
      tests/tcg: make aarch64 boot.S handle different starting modes
      contrib/plugins: add a scaling factor to the ips arg
      contrib/plugins: allow setting of instructions per quantum
      MAINTAINERS: add myself to virtio-gpu for Odd Fixes
      MAINTAINERS: add Akihiko and Dmitry as reviewers
      hw/display: re-arrange memory region tracking
      include/exec: fix assert in size_memop
      include/gdbstub: fix include guard in commands.h
      gdbstub: assert earlier in handle_read_all_regs

Dominik 'Disconnect3d' Czarnota (1):
      gdbstub: Implement qGDBServerVersion packet

Dongwon Kim (1):
      ui/gtk-gl-area: Remove extra draw call in refresh

Manos Pitsidianakis (2):
      virtio-gpu: refactor async blob unmapping
      gdbstub: update aarch64-core.xml

Nabih Estefan (1):
      tests/qtest: Avoid unaligned access in IGB test

Yiwei Zhang (1):
      virtio-gpu: support context init multiple timeline

 MAINTAINERS                               |   5 +-
 docs/about/emulation.rst                  |   4 +
 include/exec/memop.h                      |   4 +-
 include/gdbstub/commands.h                |   2 +-
 include/system/memory.h                   |   1 +
 contrib/plugins/ips.c                     |  49 ++++++++-
 gdbstub/gdbstub.c                         |  19 +++-
 hw/display/virtio-gpu-virgl.c             | 102 +++++++++++++-----
 tests/qtest/libqos/igb.c                  |   4 +-
 ui/gtk-gl-area.c                          |   1 -
 .gitlab-ci.d/buildtest-template.yml       |   1 +
 gdb-xml/aarch64-core.xml                  |  52 ++++++++-
 tests/docker/Makefile.include             |  10 +-
 tests/tcg/aarch64/Makefile.softmmu-target |   3 +-
 tests/tcg/aarch64/system/boot.S           | 172 +++++++++++++++++++++++++++++-
 15 files changed, 382 insertions(+), 47 deletions(-)

-- 
2.47.2


