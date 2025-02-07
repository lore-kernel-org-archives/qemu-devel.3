Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6FBC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 15:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgQLS-0000s2-Sn; Fri, 07 Feb 2025 10:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQKI-00087G-Og
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:32 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tgQK7-0003xh-QP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 10:31:29 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5dcd8d6f130so4399198a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738942275; x=1739547075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BHAvJx/1Vz+igKzL2c7Y1/bIDeuP9E0Jy4GRXSWgIfA=;
 b=oWWmjcpudy18N8BfIxnoHWg9/+GJUIW6vv0VLLpgT6WHV2/vETbyH4JgGkro2mV181
 NDXmhvCgc+1lE4ML5nQq0dIcyhUMxQcq/UlagLqXVf1gzXK1UfeHnO1PzB/4jFkgidAT
 5vukppCvUrWLq5ZGZ9a3cTW5HKnrTKMy1E8lwZy6EBmZASiqRii/wCw8zCw1QJ/dkUwb
 8kAkg8XI5Rfy9OkAOkv3GbNGA2a5Tw5HigyawErT2EP8qtOpMy7HV2eYAXX3fzoJqzY8
 iGBanNKVkBHgB17UnEPd9h13RNqD3o3Tcq5r2yGGx5owsPOt4DbyArRU+BMcflSzAmiP
 pnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738942275; x=1739547075;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BHAvJx/1Vz+igKzL2c7Y1/bIDeuP9E0Jy4GRXSWgIfA=;
 b=wr8UOiIWKQMSBOxY4z8m+++Xk75gnE6v+SLHO5663crY1+DgZ+voM8rTlvjhN8KvvG
 TGfBBsCMjUCLbuBHHRJC7cmE83Pp0BdSyQWqM6yw/8B3JsVl+AhG7loJWQ/IqdDJo/7I
 EziGMgwCipYS8WbOYUXXzwngbXgqpZcCUoM2ikdZNz7w31BXoWGeQwm+78fbS+4nTIWx
 Lmd2911LkGEsu29eVOAg59wqP9+jGnk8CC5MzA1v3dpEhf+kTwfemY/qtpQToL79aA1l
 UllC8JPQQo+3hzy82tEwb17vfrBYgtIUYsKm9mUKG8KsLeZ4UjRKbCAAhGxX1qeo3vAr
 9bPQ==
X-Gm-Message-State: AOJu0YxhSIRzRAevBi0zWQ1dpYeV8KoFZ7hnSkeWNBEnkyRHIyfENN2a
 N9WY1c7HSxBhbdNfy+bkYtI2nFOChm7WqUB0+rzqdBwpC7Oq+wCWqjqXz6mWHYo=
X-Gm-Gg: ASbGnctCdRcFCXXyvkzqlY7RYRRh+OMjjzumLz4zuMg0VdcNTWp9wlD2uKfVR+nwtAd
 V8GwZlJlhO4TKXT4YmH4N9n0QQ4GraDYUZw1QDVy7z5ANvZX2FpOYPFdG7GW4I1bZr0toH4Ht5x
 Mmx7Cfh5GYlk2X3xAILQqhWqPuulPfXpb3t8MqpliMHtZj8MkBoPiN6yn3WYAGTxuygYFk7yY/j
 V00t9A77b1MvJYLBH07GTgSI8EjFChr2T1/mnipwOLdYBtTqfYFuDEFt+4cKsRsu7gJ5NpBoddO
 X9PRD3LjhgqmaNtj5g==
X-Google-Smtp-Source: AGHT+IHUwmh/B5QTik6iZToAwN5afHbwX0SSkUtxPo4tTmHmaTllrYi7H0eim9qAzr4AhqDD5Yhf6w==
X-Received: by 2002:a05:6402:e97:b0:5dc:88fe:dcd1 with SMTP id
 4fb4d7f45d1cf-5de45047a40mr4572791a12.12.1738942275257; 
 Fri, 07 Feb 2025 07:31:15 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f9b3sm2705473a12.59.2025.02.07.07.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 07:31:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 679795F76B;
 Fri,  7 Feb 2025 15:31:12 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 00/17] maintainer updates for feb25 (qtest, gdbstub,
 plugins) pre-PR
Date: Fri,  7 Feb 2025 15:30:55 +0000
Message-Id: <20250207153112.3939799-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Another month and another set of updates from across my maintainer
trees. They include:

  * qtest set/step clock cleanups

It seems the earlier patch to avoid deadlock when shutting down was
overly broad. So in this series after a little clean-up to the qtest
reply code we tighten up some checks for steps that make no sense and
eventually revert the original deadlock avoiding patch.

  * reducing migration test scope depending on accel

Fabino's continued work on the migration tests and avoiding them
taking too much of the overall test execution time. KVM guests still
get the full range and we smoke test TCG guests.

  * gdbstub late attachment

These are Ilya's patches to make it easier to debug heavily
multi-process linux-user invocations. Comes with documentation and
a test case ;-)

  * plugins

Fix a compiler false positive.

I intend to send the PR next week, the following patches still need review:

  tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
  tests/qtest: don't attempt to clock_step while waiting for virtio ISR
  tests/docker: replicate the check-rust-tools-nightly CI job

Alex.

Alex Bennée (7):
  tests/docker: replicate the check-rust-tools-nightly CI job
  tests/qtest: don't attempt to clock_step while waiting for virtio ISR
  tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
  tests/qtest: simplify qtest_process_inbuf
  tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
  tests/qtest: tighten up the checks on clock_step
  Revert "util/timer: avoid deadlock when shutting down"

Fabiano Rosas (2):
  tests/qtest/migration: Add --full option
  tests/qtest/migration: Pick smoke tests

Ilya Leoshkevich (8):
  gdbstub: Allow the %d placeholder in the socket path
  gdbstub: Try unlinking the unix socket before binding
  user: Introduce user/signal.h
  user: Introduce host_interrupt_signal
  osdep: Introduce qemu_kill_thread()
  gdbstub: Allow late attachment
  docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
  tests/tcg: Add late gdbstub attach test

 MAINTAINERS                                |   1 +
 docs/user/main.rst                         |  16 ++-
 bsd-user/signal-common.h                   |   1 -
 include/qemu/osdep.h                       |   9 ++
 include/system/qtest.h                     |   1 -
 include/user/signal.h                      |  25 ++++
 linux-user/signal-common.h                 |   1 -
 tests/qtest/migration/framework.h          |   1 +
 bsd-user/main.c                            |   1 -
 bsd-user/signal.c                          |  13 ++
 gdbstub/user.c                             | 150 ++++++++++++++++-----
 hw/ppc/spapr_rtas.c                        |   1 -
 hw/riscv/riscv_hart.c                      |   1 -
 linux-user/main.c                          |   1 -
 linux-user/signal.c                        |  26 +++-
 linux-user/syscall.c                       |   1 +
 stubs/monitor-fd.c                         |   9 ++
 system/qtest.c                             |  59 +++-----
 tests/qtest/libqos/virtio-pci-modern.c     |   6 +-
 tests/qtest/libqos/virtio-pci.c            |   6 +-
 tests/qtest/migration-test.c               |  25 ++++
 tests/qtest/migration/compression-tests.c  |  15 ++-
 tests/qtest/migration/cpr-tests.c          |   6 +
 tests/qtest/migration/file-tests.c         |  19 ++-
 tests/qtest/migration/misc-tests.c         |  16 ++-
 tests/qtest/migration/postcopy-tests.c     |  14 +-
 tests/qtest/migration/precopy-tests.c      |  23 +++-
 tests/qtest/migration/tls-tests.c          |  14 +-
 tests/qtest/npcm7xx_timer-test.c           |   1 -
 tests/tcg/multiarch/late-attach.c          |  41 ++++++
 util/oslib-posix.c                         |  15 +++
 util/qemu-timer.c                          |  16 +--
 stubs/meson.build                          |   2 +
 tests/docker/Makefile.include              |   3 +
 tests/docker/test-rust                     |  21 +++
 tests/guest-debug/run-test.py              |  15 ++-
 tests/qtest/meson.build                    |  11 +-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 ++++
 util/meson.build                           |   2 +
 40 files changed, 490 insertions(+), 135 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 stubs/monitor-fd.c
 create mode 100644 tests/tcg/multiarch/late-attach.c
 create mode 100755 tests/docker/test-rust
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py

-- 
2.39.5


