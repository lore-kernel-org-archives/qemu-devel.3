Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD1CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwT7-0000Gu-6A; Fri, 31 Oct 2025 17:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwT5-0000Gg-Cx
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:31 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwT2-0001x1-91
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:15:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so813551f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945320; x=1762550120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1JCNmCeXKwVK6R9M/MpOAZqMdQ/Z7uwpqnv+fcT8EZU=;
 b=nwjG/ahDU5Lezl1yfNJNtRtMUOVu5afVNx9crTe8ZoRVBY75EDDDu0XfGnZwOia63c
 ZAhULTPrkBmVSzyKkazXhRGvGx41o1qSnxXvapod53p5Ui1gam747PXGhaCwloYd9x9U
 4a26WOYFD++mu1s0rkunCXDhY/dNm9cPpiHVej9zW6jnOw0Zd/WJToFx9F2r3tUauaZQ
 VYowrdhc5RJPbkZjTKiEJ08l5NqPn6YLFBh0LpYdc0OJWD2yAh6NUNe/DD4hhXQruMYk
 Gym/88LTZMAH+plchBj7RDeWnOY3WT4lsxDKVb3kL2IHHSM3pN2FgtTG7ccGt4ijSHLv
 0Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945320; x=1762550120;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JCNmCeXKwVK6R9M/MpOAZqMdQ/Z7uwpqnv+fcT8EZU=;
 b=vN4jkNO/tdvi5VuJopx7WMJeCp94ublxYDJH8DLE4V3ZClPPbYQ0kba2krxnV110ei
 h87kCUgTf1UwdvAAe5aXhyTuo1EpeDPGOWZNYHUdDGoAkhC09P8J882Q6xrZ3QqGrRbz
 nJYq+9qTL97Ftzhi3a0tZc0vjzPiu/KSmfRzxV2VM7Uj+vOFEiZOsj8ePso8lo3RvbPz
 P7KBf3kYTbdEcEvIVx/JEKcCV4hyaChWQUxdIwH7bKT1JxrMD1RotAjBrN4lEM+V3F5c
 ZFom16XS7rVWSJDv1Xe0Uah1uSbgSSr3WUlhT8l2CJKIcNy8LPo23VKSEqsJHyOyLYAU
 nJCw==
X-Gm-Message-State: AOJu0YwsLN6z+LaxXlyE+JauU4l+PvI+YZZnlHuLJJzBs++toK9FQjcL
 BPi0c5zNFqDlk9YFv/Cf937K4T6No99nwNdT/HV1CbffAO5Ybs10vXsae2XzxUkfMYMsJvhrZh2
 2DDpdZmE24B1c
X-Gm-Gg: ASbGnctiN5clqr+J4YnBysCcxJFAnAcVVEYBk8eg0CwBnAB2AdQK446k05NQHSE8iVp
 558MT3qT8KDaW+hPhQlXz2iQPToI/TiTqai6dTF8eoYe/y5KJ6QiEki7NsN1Du5g7teV2w62ol+
 XFsT8Lp52U1P58U9k9ExBv8Y4On6IFiRZGulUHggDGpN8kRbnxAFnv01rSsFAIz79JsDUyCRF4a
 hrgSz2IEk1AR0Hg/DtG7wC1RQYDRkMkyVp8EOeZf+lIoapwaNuVIJAxTisyWXPTuDfgXkW2pjFZ
 vrHv3Ao30zCmbTesCuu+dRiJoTHsJs5VaKVsd4ljH/Jp6BU3XMLq/5kXH2yHn2ggwcZvQ9asgP3
 jvxO6IdGeTvkVmIOSeohSUzcjniwImjYektz9CpRUNCifc7pdYr5YyXSHSPydqU149KvaGDWym3
 FK4+qkXNGScf+SUbcUHJ5i0ZUYjKBg0sGwfCmFvJdUxqC4Iw5cSvzKuFO+ZK8BHkrW
X-Google-Smtp-Source: AGHT+IG5MK3usWKT1kItrPg4KUJFSk+5dwFtGTlNC6ZP0ZhjJol0uvaYSYALSbHHJjIViLqE9dm7yg==
X-Received: by 2002:a05:6000:490b:b0:427:666:f9d6 with SMTP id
 ffacd0b85a97d-429bd6a660fmr4264872f8f.39.1761945320327; 
 Fri, 31 Oct 2025 14:15:20 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13eae16sm5354145f8f.32.2025.10.31.14.15.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:15:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Accelerators & CPU patches for Halloween 2025
Date: Fri, 31 Oct 2025 22:15:09 +0100
Message-ID: <20251031211518.38503-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

The following changes since commit c494afbb7d552604ad26036127655c534a2645e5:

  Merge tag 'pull-nvme-20251030' of https://gitlab.com/birkelund/qemu into staging (2025-10-31 12:56:05 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-cpus-20251031

for you to fetch changes up to 0da6099730dbd44a6a96ad18774e5553d1ca7d21:

  rx: cpu: fix interrupts check in rx_cpu_do_interrupt() (2025-10-31 22:10:50 +0100)

Following checkpatch.pl error ignored:

  8/9 Checking commit 46f767bd6814 (tests/unit: add unit test for qemu_hexdump())
  ERROR: unnecessary whitespace before a quoted newline
  #59: FILE: tests/unit/test-cutils.c:3662:
  +            "s is \n";

  total: 1 errors, 0 warnings, 56 lines checked

----------------------------------------------------------------
Generic CPUs / accelerators patch queue

- Access CPUState::thread_kicked atomically
- Make async_safe_run_on_cpu() safe on HVF
- Fix bql_locked status with condvar APIs
- Document cpu_memory_rw_debug()
- Rename init_clocks() -> qemu_init_clocks() to avoid name clashing
- Fix QEMU_HEXDUMP_LINE_WIDTH logic
- Fix interrupts check in rx_cpu_do_interrupt()
----------------------------------------------------------------

Alex Bennée (1):
  timers: properly prefix init_clocks()

Igor Mammedov (1):
  rx: cpu: fix interrupts check in rx_cpu_do_interrupt()

Peter Xu (1):
  bql: Fix bql_locked status with condvar APIs

Philippe Mathieu-Daudé (4):
  cpus: Access CPUState::thread_kicked atomically
  accel/hvf: Make async_safe_run_on_cpu() safe
  accel/tcg: Use cpu_is_stopped() helper to access CPUState::stopped
  exec/cpu: Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and
    document

Vladimir Sementsov-Ogievskiy (2):
  util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic
  tests/unit: add unit test for qemu_hexdump()

 include/exec/cpu-common.h         |  4 ---
 include/hw/core/cpu.h             | 20 ++++++++++++++
 include/qemu/main-loop.h          | 18 +++++++++++++
 include/qemu/timer.h              |  5 ++--
 util/qemu-thread-common.h         |  7 +++++
 accel/tcg/tcg-accel-ops-rr.c      |  2 +-
 stubs/iothread-lock.c             |  9 +++++++
 system/cpus.c                     | 18 ++++++++++---
 target/arm/hvf/hvf.c              |  2 ++
 target/i386/hvf/hvf.c             |  2 ++
 target/rx/helper.c                | 45 ++++++++++++++-----------------
 tests/unit/test-aio-multithread.c |  2 +-
 tests/unit/test-cutils.c          | 45 +++++++++++++++++++++++++++++++
 util/hexdump.c                    | 38 ++++++++++++++++----------
 util/main-loop.c                  |  2 +-
 util/qemu-timer.c                 |  2 +-
 16 files changed, 168 insertions(+), 53 deletions(-)

-- 
2.51.0


