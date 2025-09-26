Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA67FCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LG-00083u-Eq; Fri, 26 Sep 2025 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LF-00083h-E5
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kq-00041v-SO
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e2e363118so21371745e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892667; x=1759497467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9MrBP/WehAnzW20DTxcVONaqDOfwmmdiFwVtzOXuhTw=;
 b=Bt2KjfDi8wi9J4gbA2tVdr8hJjgGm8hIKc16j3qwqT5J9gyEt7kpJlKhMMgISlnZFy
 0NtYOV7i7TzZpZZfTdR6uoaAThxKfQwxjhHap0EsrDz3B5mL76YhpbNrk1BIJVFUKTb6
 W8JYmaYDvlWpojMPPi5HuMJmEfnn74mStTaEX6PMm59YyX+dEfF3WIJVMpB8GE+DhVGr
 KjbdgilB7x3mzcZuD1zTmJ1k+BWodqjV/JVc+VlLhcWC4PZokgb7cfg04JwsAMGwjb2V
 RpRum2pRNeoUuI6KyBxojQ67KMcmwqGi7fheUdQ8jrkxyNtxUuiOOYLjMQisD8m5sLKY
 mzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892667; x=1759497467;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MrBP/WehAnzW20DTxcVONaqDOfwmmdiFwVtzOXuhTw=;
 b=ockmfC1eGX9J8XzoPfjmmGNxCUGWgib/WxjxEdWTNoKxccxbeIjvwFuUWJB8NVwj9T
 I50cx5xe0OV0xn/Gp3rRTtO/UZ3GClrGxIFrl2N0KYMBxSHzygc1u3MSmRWaZQxPzFfJ
 2ng6VlNZcAt8EqZo3S4dYcIwan5svTe4Un52L0K4fxW9oaCZSJzXSFSJ4gHa5hi3lsdx
 9vdjcOxSF/oWy4mAGmwWMq375CflJ4gpvIbGjZzTn0rpzdGROJLlVyQF7Xf1gUYx8Ak3
 h83FRkOsYMUnJHUrXvrnOTZ/R9EIfqktnd1zR7VHC3ZjBYmnVU2DVWBZF9ffycRlg2/X
 8Glg==
X-Gm-Message-State: AOJu0YwZ36OXLaTwLBWH2gLCT0J4x6D63zVJFQoMWBQWCrZ0Nu5Mwamp
 cjGoDs3JnLP+wT8uBaCOhl4kX7NRW8WJ6or2MpfjDDu4j4tpRo79MGmq3UCMBOxY2VGGAG98MXg
 stpK/6Js=
X-Gm-Gg: ASbGncuNhC3khRL0n/5xkn6gE144rvM+PZyHSfJ1P2FHd9/xYzbm7/oHaZwBXf18thz
 nsorHJUtGHjdgQYnWY6JlhzwMY+i7EFhdLMEqbeEKJ/4OdAjlPB6vdRPfKWb31RRto7VF4dzbz0
 hmJyuF/BhGrH/j7hW7agsfG+posjgHeqaya4PUzkz2UJ4btdCKaW2DcGKUhYQqr+9uUaWPlTnMl
 lv+cQAHrSFkozgABg2QfYeNT42/it/IWa3Qo+7Ml5XAf/welG9i/4D03jjBEMEbRnBX+5Z5mVJJ
 Ujoo5AlidyXwgaYd0s4B1nDp3dt04Tvk/29el7VQF+w8joGzyTozJllBdOY+MID7eY3BFOsA9nG
 ffP9spnc8YzYC2CYDng5gbbI=
X-Google-Smtp-Source: AGHT+IGO2jS7TI8cwIjByobvdlhRxL5k/YcVdqodXZ1MSond6XZlVvzq+1ZjLpjT02xTFojsKvSV3w==
X-Received: by 2002:a05:600c:444d:b0:46e:2638:289d with SMTP id
 5b1f17b1804b1-46e3299f6a9mr79920355e9.5.1758892666516; 
 Fri, 26 Sep 2025 06:17:46 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603365sm7353409f8f.37.2025.09.26.06.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id ACE135F7C3;
 Fri, 26 Sep 2025 14:17:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/24] maintainer updates (scripts, semihosting, plugins)
Date: Fri, 26 Sep 2025 14:17:19 +0100
Message-ID: <20250926131744.432185-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 95b9e0d2ade5d633fd13ffba96a54e87c65baf39:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-09-24 12:04:18 -0700)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-260925-1

for you to fetch changes up to 16b10fbf8bdb71ae20c7f74ab19c78d07c013ac7:

  contrib/plugins/uftrace: add documentation (2025-09-26 10:07:54 +0100)

----------------------------------------------------------------
September maintainer updates (scripts, semihosting, plugins)

 - new gitlab-failure-analysis script
 - tweak checkpath to ignore license in removed lines
 - refactor semihosting to build once
 - add explicit assert to execlog for coverity
 - new uftrace plugin

----------------------------------------------------------------
Alex Bennée (1):
      scripts/ci: add gitlab-failure-analysis script

Nabih Estefan (1):
      checkpatch: Ignore removed lines in license check

Peter Maydell (1):
      contrib/plugins/execlog: Explicitly check for qemu_plugin_read_register() failure

Pierrick Bouvier (21):
      semihosting/syscalls: compile once in system and per target for user mode
      semihosting/syscalls: replace uint64_t with vaddr where appropriate
      semihosting/guestfd: compile once for system/user
      semihosting/arm-compat-semi: change common_semi_sys_exit_extended
      target/riscv/common-semi-target: remove sizeof(target_ulong)
      target/{arm, riscv}/common-semi-target: eradicate target_ulong
      include/semihosting/common-semi: extract common_semi API
      semihosting/arm-compat-semi: eradicate sizeof(target_ulong)
      semihosting/arm-compat-semi: replace target_ulong
      semihosting/arm-compat-semi: eradicate target_long
      semihosting/arm-compat-semi: remove dependency on cpu.h
      semihosting/arm-compat-semi: compile once in system and per target for user mode
      contrib/plugins/uftrace: skeleton file
      contrib/plugins/uftrace: define cpu operations and implement aarch64
      contrib/plugins/uftrace: track callstack
      contrib/plugins/uftrace: implement tracing
      contrib/plugins/uftrace: implement privilege level tracing
      contrib/plugins/uftrace: generate additional files for uftrace
      contrib/plugins/uftrace: implement x64 support
      contrib/plugins/uftrace_symbols.py
      contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst                           | 199 +++++
 include/semihosting/common-semi.h                  |   6 +
 include/semihosting/guestfd.h                      |   7 -
 include/semihosting/semihost.h                     |   2 +
 include/semihosting/syscalls.h                     |  30 +-
 contrib/plugins/execlog.c                          |   1 +
 contrib/plugins/uftrace.c                          | 878 +++++++++++++++++++++
 semihosting/arm-compat-semi-stub.c                 |  19 +
 semihosting/arm-compat-semi.c                      |  63 +-
 semihosting/guestfd.c                              |  26 +-
 semihosting/syscalls.c                             | 109 ++-
 .../{common-semi-target.h => common-semi-target.c} |  22 +-
 .../{common-semi-target.h => common-semi-target.c} |  23 +-
 contrib/plugins/meson.build                        |   3 +-
 contrib/plugins/uftrace_symbols.py                 | 152 ++++
 scripts/checkpatch.pl                              |   3 +-
 scripts/ci/gitlab-failure-analysis                 | 117 +++
 semihosting/meson.build                            |  18 +-
 target/arm/meson.build                             |   4 +
 target/riscv/meson.build                           |   4 +
 20 files changed, 1538 insertions(+), 148 deletions(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100644 semihosting/arm-compat-semi-stub.c
 rename target/arm/{common-semi-target.h => common-semi-target.c} (59%)
 rename target/riscv/{common-semi-target.h => common-semi-target.c} (53%)
 create mode 100755 contrib/plugins/uftrace_symbols.py
 create mode 100755 scripts/ci/gitlab-failure-analysis

-- 
2.47.3


