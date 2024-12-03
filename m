Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAEBE64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIR89-00004r-KZ; Tue, 03 Dec 2024 06:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR87-0008WI-04
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:47 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIR85-0000YI-4t
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:31:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a95095efso37362225e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733225503; x=1733830303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+dqC6y4lBqZOktJ3iXowIEuPu5elXZcaIUE++eBTpus=;
 b=uGfaQra1nZ4aSR7ZDDJ5BoP1Po9JIKI9ChMpKkzzrCuqae+zYS1y2gAVpt/YBSdlKH
 a1JyIsHVDAumZd4F9GndkGlqNkVZdA/3h/tglGFb7ZVb4IHOWjL3CtH/WU4TZObHp3oz
 P3oYFgISOhaZMy+r0vy5UusuZ7qhBytsq2Jq7DScO/OAdBQBJswmnnehYpGQgO/djb+X
 +WyY6dQoXE4/q2RkCrlXd3wAO5pSV7tgyLhFADSb9v5HMk7h2yfc4g5w3Z2aeYpc/skR
 4qRVrJHbPvsrpTTStNFPuXGlQYFKdLPCLbHXAM0f7s4S6gvyrdN54polZP8PXqH4HaWo
 kWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733225503; x=1733830303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dqC6y4lBqZOktJ3iXowIEuPu5elXZcaIUE++eBTpus=;
 b=w8vnWvIwv/TZVWl7bQ8BcqIlT0wQPh2y1l2YpoDPM+xiVsBJ3INRTWISHoEHKOYAFK
 fs951gorsYvM2f2zzuZfkkyZ9DAdO3k7GkWYeBrqYHHoVHdZopq77e09ByUSzkCr8F+Z
 u3khxZWWlEsj+4I1OTpJCCbYwKIAiinImqm3BZuMcZvBJRdo95VHqjW1n3ckGyaSGeMn
 TwzT8XzHiSwihJvMcjTxliEDKJDzRJOp/KeOVYzkqGvQuF9sCDJ5L4M+WriFuES5GLEY
 Pv3iR1rB8CTuHSTZTL/o9b4gh7Y1qd4EGwc0TTJfjbtBKNA2GpQVNUm2f7VXO4R1gAgE
 mQNg==
X-Gm-Message-State: AOJu0Yx7jCH2IDAHijHXEtlrneGBzZzAaeEdCin5r+97ANd5kOqqedtp
 Hn+uPa0xDNpoMnLRPrmnBtXW+Keq1EGOjzubwJKozQEIoK9WyaKJkNyOmAc0K/NNHTZa2r/c9xI
 fZP0=
X-Gm-Gg: ASbGncsXQ+4DdkTcmJ6Dona+8CCVOf0HYEuDeQdIN2DHrPWPVOi8JUCm8Hjrpyk8sub
 E/GEKvajdV+J3PO06xPdJFDpHohieRJMIJfjM5RgIHNuv+aOLitv8dAdjBqb9X4LDeAPLpVshlJ
 7ZfDXrC7OXOp2GpXDGBvOU5EXO6UJCGyc5Ow8JIL/tL/XI84n+3gEBhTKByoznWnqPv1IzxrNe+
 x4U7Nuk5l4pR98E+X0gd0sPLngLCjqhvIEO+oEfYisboveG+OUa2l8s60eK6fRfLVuTXy2d
X-Google-Smtp-Source: AGHT+IEVy/ETINDDUHuVp/URP0xWGkcG9L/2vQlCSNOYQy/8qUAhFF776rpifuwIf75yQB5NqT0zbQ==
X-Received: by 2002:a05:600c:4fcc:b0:42c:b67b:816b with SMTP id
 5b1f17b1804b1-434afb8dea4mr194514275e9.1.1733225502886; 
 Tue, 03 Dec 2024 03:31:42 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7d29fbsm220616585e9.29.2024.12.03.03.31.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 03:31:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/13] Misc fixes for 2024-12-03
Date: Tue,  3 Dec 2024 12:31:27 +0100
Message-ID: <20241203113140.63513-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b52938:

  Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu into staging (2024-12-02 16:16:15 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20241203

for you to fetch changes up to 964d2a0cf8136cdafc07f6fd847ebf897965dc35:

  system: Select HVF by default when no other accelerator is available (2024-12-03 12:28:06 +0100)

----------------------------------------------------------------
Misc fixes for QEMU v9.2.0

----------------------------------------------------------------

Ahmad Fatoum (1):
  hw/openrisc/openrisc_sim: keep serial@90000000 as default

Bibo Mao (1):
  MAINTAINERS: add myself as the maintainer for LoongArch VirtMachine

Brian Cain (1):
  MAINTAINERS: update email addr for Brian Cain

Daniel P. Berrangé (4):
  hw/core/machine: diagnose wrapping of maxmem
  hw/virtio: fix crash in processing balloon stats
  tests/qtest: drop 'fuzz-' prefix from virtio-balloon test
  tests/qtest: add test for querying balloon guest stats

Joel Holdsworth (1):
  hw/openrisc: Fixed undercounting of TTCR in continuous mode

Peter Maydell (1):
  target/riscv: Avoid bad shift in riscv_cpu_do_interrupt()

Philippe Mathieu-Daudé (4):
  ui/cocoa: Temporarily ignore annoying deprecated declaration warnings
  meson: Add missing SDL dependency to system/main.c
  hw/display/vga: Do not reset 'big_endian_fb' in vga_common_reset()
  system: Select HVF by default when no other accelerator is available

 MAINTAINERS                            |  4 +-
 meson.build                            |  4 +-
 hw/core/machine.c                      | 10 ++++-
 hw/display/vga.c                       |  2 +-
 hw/openrisc/cputimer.c                 | 26 +++++++-----
 hw/openrisc/openrisc_sim.c             | 26 +++++++++---
 hw/virtio/virtio-balloon.c             | 16 +++++++-
 system/vl.c                            |  3 ++
 target/riscv/cpu_helper.c              |  8 ++--
 tests/qtest/fuzz-virtio-balloon-test.c | 37 -----------------
 tests/qtest/virtio-balloon-test.c      | 57 ++++++++++++++++++++++++++
 .mailmap                               |  2 +
 tests/qtest/meson.build                |  2 +-
 ui/cocoa.m                             |  5 +++
 14 files changed, 137 insertions(+), 65 deletions(-)
 delete mode 100644 tests/qtest/fuzz-virtio-balloon-test.c
 create mode 100644 tests/qtest/virtio-balloon-test.c

-- 
2.45.2


