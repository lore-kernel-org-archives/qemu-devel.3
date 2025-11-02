Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934E3CCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 18:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFcam-0004F4-NP; Sun, 02 Nov 2025 13:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFcaj-0004Ee-UE
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 13:14:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFcah-0001Sk-O5
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 13:14:13 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-474975af41dso27869845e9.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 10:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762107249; x=1762712049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=23XP/6n983J9ctvEeKNU+wOyan2UhCB5Hi0WEowM0Tc=;
 b=RzoTDtcO6YlyR7jPEqjN+j/OlUv9voGky4DHP9nHYn6dtVE8/V0jZ1/Wo8wc5xXY6+
 ytsR0KpJHO+33CW3sorG8tzn+R03+uEbymedcBJSdCnpgYOc+7m1sjHWu2bsE5Dgzzt6
 rePF9MLzI/LWCum/HiZdSNlGhmUh1nCwFFhc2lSSppVXm6BsR6bgf+lowtmnX9Em+ycb
 mY5VXlnwR/vbacqKNq+VPGWUNWXEq1hTcxbktrAoBzCPO6VOCaqoA9TkcwQsZ09YlVtd
 lpvU7/DR2Ai5as6h3S4DBWf/TB2qnzKSbMpjMC/GUt+GMM4NBwYVD0+3ZWMdeOlF5Dn4
 8Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762107249; x=1762712049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23XP/6n983J9ctvEeKNU+wOyan2UhCB5Hi0WEowM0Tc=;
 b=bE+nEHklyhVVg1qKqYLK+tWyXW45C5cpRHeSupP64UOr7OaSvoJrUTYXuAi2LYcEmY
 fJBgvJl6MjIW/OqSs7vj/L5HUIPVmVsTNkgkq/Di8olNsFl0rijIxjpx5A3z+jI02E4n
 pln/AJcLSO2HEXgyMYzIBPK/VdwYswqypLtxHjBKeBFLY2sJwyPRnyeIUQX2vlYSBQj4
 ym/hzYLJjVaZT37f5EaLWxwtYZXa9yzZxy1y7rlrDhxsM7KMsXRkzHj3Dbb1kWZMerYv
 bDU1NfmhYMXaDX68NNUMhZWKgWo9qvRVELGFPxEsI7L+rWhQVU22PMVpkdDLzzFhgMUn
 XUSw==
X-Gm-Message-State: AOJu0YyG1P9Q7hpNMTtafqKo2aPw+3T3EVq1NiUUh0FbdS+hwzyOWKjY
 d4/UAIhfoDdrcL4LZdNSNjKlrQ6IAxwm8f4nKJXcNbRZAJ3UL+M3RzpxwdZiRLNe/7Mig2wk5vS
 XwqYXOhiZZXBF
X-Gm-Gg: ASbGnctgJSIplP/sP09LlBuZnsum8fLNyomnHAI8g8gSnS0Gxnszdq9q1vn8iq2uNNu
 3PFajScrPWzW7pNRmMGgY4zbuMni5AVyWQVweAVBF1KWVy51f1vyV1X42GVdhmRDCilCjLI33kq
 XoUs+IRc1+1sjS4kC9ZdpnB3VPzHwY26vuXmFEIlkVToI8+kOuC2sWRceqsg7hUWgOKPZUyqRbw
 bpMYnut1CNlXFhvjh5fYN4q3qd2Jpkh5yfYFbkJA9EUt08j4w+KfMEYm2YD3dDzdxZBKzkxQdTu
 9bJm2lWo6tqTwSGCH0g33rWaBNgQArD/20S/Bp8AptrLZfJwlpWSfPzN1S77x9O0zlevoJ9vICe
 mbb/sMmzQR8Z3LNKSe+yqahP6302Gy8X7ccaYDKpoqz7bG74Q7AdkhRqqmbyGHzfq1WH8yUPww6
 QDBvJcisT2uHPVvY+A0K4x88i1wdXhxeOjVJqRIuV1vVM+ujpA1+h9vkurAYaxTAanM/OT2A==
X-Google-Smtp-Source: AGHT+IEIGaSDjPUNa9kvSXIkKAuaNvRnjUCWsWaeBN8EKY7x0fCeq0NtLDC8urglaMTc53Sz+ltvrw==
X-Received: by 2002:a05:600c:820e:b0:475:e007:baf2 with SMTP id
 5b1f17b1804b1-477308b6d72mr89923395e9.41.1762107248814; 
 Sun, 02 Nov 2025 10:14:08 -0800 (PST)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff1besm15705536f8f.9.2025.11.02.10.14.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 02 Nov 2025 10:14:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/8] Accelerators & CPU patches for 2025-11-02
Date: Sun,  2 Nov 2025 19:14:06 +0100
Message-ID: <20251102181406.51160-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

The following changes since commit 53b41bb78950912ba2d9809eef6b45e4df30c647:

  Merge tag 'pull-target-arm-20251031' of https://gitlab.com/pm215/qemu into staging (2025-11-01 10:52:48 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/accel-cpus-20251102

for you to fetch changes up to 9d01b8efc6e9621166791417f7688383f54e829f:

  rx: cpu: fix interrupts check in rx_cpu_do_interrupt() (2025-11-02 19:11:57 +0100)

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
 target/rx/helper.c                | 45 ++++++++++++++-----------------
 tests/unit/test-aio-multithread.c |  2 +-
 tests/unit/test-cutils.c          | 45 +++++++++++++++++++++++++++++++
 util/hexdump.c                    | 38 ++++++++++++++++----------
 util/main-loop.c                  |  2 +-
 util/qemu-timer.c                 |  2 +-
 14 files changed, 164 insertions(+), 53 deletions(-)

-- 
2.51.0


