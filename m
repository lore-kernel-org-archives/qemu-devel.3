Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DECCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuW5-0005dF-6Y; Mon, 03 Nov 2025 08:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuVt-0005YG-3B
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:22:25 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFuVj-0001uY-Vu
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:22:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so2957638f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762176127; x=1762780927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iWJewuDPux2u2awuICD8ofBpDqih1Mqj5tAQcsbhGmg=;
 b=l0o7XlCI0wCJYDfkLyCbaguz61AUiwLVmy/m9AOIwOXDxKzd3A5zxSGTZbYVGHaLAm
 HJ9bv2SUFRiR8B2MyC35FKA3AlIxbE3sF+QDKsTWP6Fy3JWVNC4ixmRQjVQ5VyDYkXKr
 cN+5Vk86x65OJ9GqpSRhdcuLhP3++nP+PJX2fNTQ3028Bmxz7bw/4TLo4OSMvJw/0zLp
 MyW4gQTgZ9z11HaasgC0GfnRc7a00KDM5mdNz8XJErOtIGqnCxrP8EntSExZArdeg/d3
 vHwk2F+RFza2EGC1ArkJR3rPRkQ0uugpgnAPS8osRny1+RfKHYTyY+X4IGDE6QHiL6d+
 hZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762176127; x=1762780927;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iWJewuDPux2u2awuICD8ofBpDqih1Mqj5tAQcsbhGmg=;
 b=TrzPX1fqiyQfr+1jHAgI0O4EGhwGP9DxEVljNNtYPLBIXMTdg+tgk5RkRucb0C62/b
 LSbWVml2aF0vPRL1lSKLbqPX7rDo9ws2j4BJf5RjD0EUXj234KwaznPSmlsgca3N5uVn
 WVypls/hCpb80iQW1cCjYUFwF+Ycu+U3cekf3WPFqj8W9sN5id82SPmpOFISHTCjIATc
 yybLXGwMgr43FKaeGkQS/0MK1YVMjEAQxVj5hyjd+TtG5Axu6DYHuks42cEDz2pptvOH
 RsNIPBSWPOc7IsNaJG0WU1KkyM0ftiCoeyJ0z4/hkf0MWWb19Q675wyO28i+FiptHQPz
 bNZw==
X-Gm-Message-State: AOJu0YyKoHveh9JN6RcpQWd4VOVbxK7OeJREpSXmrbDp1UYPPqPnY+77
 Wrf1sjMIt/XQJfK36lbdI5N27Js4AnnkPatW8SqnVT5vlMS8Lqy8b2XiSYW/GBmyvQGp3T1kSwL
 Y/wQmeUaeA2LT3lY=
X-Gm-Gg: ASbGnctA/RLvW/g5LVjPBYrhVebnQlnozoJomuhh/SEwP2P+ArOzMo33VBwASytqV04
 LFizNtOf4zWyjNQGRfJx6ynvNNQr3p9kFN0wqJilTjlrML6lm7GPa76gj0GOEvuHr448w7m89JZ
 rWbIFEpSQp+WxAfS9BGzfjpEYLI946jgpnBRjxCb+Tk3SUq3G1vUt6zlrYaChD1fd2MEU2aedRU
 TqtbYTDgnHCIGZXIRUvZarHyo4KFrktjpG+ThmP4y8/oRmk980w/cd251/RAFhcctg9Ld7DKcPz
 AzeuMxo0XrKACGNPVf+iEIx+w92ENKouijKRf/mwzZPeEkfqZi+rwyrr1MzKdsmcIoiBtF/dRrS
 RO0CXG0kP4lYrgQu0EQpXa7u66qCJIWFedUwJIYBGOexmkyxU2KOpfQyqOVrlyiajBau7lXEoqf
 iMHssGmftQyq5fteMRPAD43rsLAEQ6ppOhS2KpDWZx5NSlNeOp10zwmUqlD8l/k27SGdGMew==
X-Google-Smtp-Source: AGHT+IGeG4w+OxWAgFf1Enpd+haMQOzNuD6FWU9cVAkzTm+HQEnwAe2V/xYMO1NZhUT1zewX4xDAxA==
X-Received: by 2002:a05:6000:1884:b0:429:d0f0:6dd1 with SMTP id
 ffacd0b85a97d-429d0f06f75mr4329630f8f.58.1762176127394; 
 Mon, 03 Nov 2025 05:22:07 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-156.ptr.icomera.net.
 [185.104.138.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c85ad188sm14247781f8f.20.2025.11.03.05.22.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 05:22:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 0/7] Accelerators & CPU patches for 2025-11-02
Date: Mon,  3 Nov 2025 14:22:05 +0100
Message-ID: <20251103132205.73931-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x443.google.com
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

Since v2:
- Dropped qemu_hexdump() unit test

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-cpus-20251103

for you to fetch changes up to 6c5571e72aed54194a1a07799d8c23c90b5f229e:

  rx: cpu: fix interrupts check in rx_cpu_do_interrupt() (2025-11-03 14:15:57 +0100)

Following checkpatch.pl error ignored:

  8/9 Checking commit 46f767bd6814 (tests/unit: add unit test for qemu_hexdump())
  ERROR: unnecessary whitespace before a quoted newline
  #59: FILE: tests/unit/test-cutils.c:3662:
  +            "s is \n";

  total: 1 errors, 0 warnings, 56 lines checked

----------------------------------------------------------------
Generic CPUs / accelerators patch queue

- Access CPUState::thread_kicked atomically
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

Philippe Mathieu-Daudé (3):
  cpus: Access CPUState::thread_kicked atomically
  accel/tcg: Use cpu_is_stopped() helper to access CPUState::stopped
  exec/cpu: Declare cpu_memory_rw_debug() in 'hw/core/cpu.h' and
    document

Vladimir Sementsov-Ogievskiy (1):
  util/hexdump: fix QEMU_HEXDUMP_LINE_WIDTH logic

 include/exec/cpu-common.h         |  4 ---
 include/hw/core/cpu.h             | 20 ++++++++++++++
 include/qemu/main-loop.h          | 18 +++++++++++++
 include/qemu/timer.h              |  5 ++--
 util/qemu-thread-common.h         |  7 +++++
 accel/tcg/tcg-accel-ops-rr.c      |  2 +-
 stubs/iothread-lock.c             |  9 +++++++
 system/cpus.c                     | 18 ++++++++++---
 target/rx/helper.c                | 45 ++++++++++++++-----------------
 tests/unit/test-aio-multithread.c |  2 +-
 util/hexdump.c                    | 38 ++++++++++++++++----------
 util/main-loop.c                  |  2 +-
 util/qemu-timer.c                 |  2 +-
 13 files changed, 119 insertions(+), 53 deletions(-)

-- 
2.51.0


