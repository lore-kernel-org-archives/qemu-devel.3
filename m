Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27FCCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnhn-0007Z5-B6; Fri, 31 Oct 2025 07:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhh-0007XB-MX
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vEnhT-0005xC-NQ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:54:01 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so295801666b.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761911615; x=1762516415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Kvqp/yK6yd3XuiA/r5cHrubfTwXvhi0oqiGH3m5YoE=;
 b=eYksc9cTzXFH2B3+01P0d3iCCpthwfL5TXLspdy8NqqMfeM1Qfi0EeY8CgKIOtyxLE
 JnNUbOlBoYkEmDv/azXqY9fwSfMfO+8Cbng+CY3ElvnlK6IyYQNfqPN68xSTn3RvefP7
 9eEAK8xMo/YM0/AyQJdXtp0nriiTxSwYPepzZZP4w5euOnvfjgQI0BwaAn1JcmKhHNip
 Bvm6Kjq2+8NkDzN5olwoZay9TSdP6qmcWPgJSceAMjVjQW2GVy7C+RY0uWWOMxbwCfjt
 LHXxrgxR+j1KEwSaobO0NvUhVxbbW4RbNq2LCmsfwcnnwDqBNoP6ua2gFUuzqbiUtQ06
 q2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761911615; x=1762516415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Kvqp/yK6yd3XuiA/r5cHrubfTwXvhi0oqiGH3m5YoE=;
 b=RfH9YmW9iJVe/5GRix0zAi33FGHuJO8OGgFgC70G5qtUSu0kh4umRxQhdYMCeMG5AM
 VQ1m9Zln2BwhaCwIAkNiiiQoPekaxAcpI1b5W1YjPWBlggByYzVfHI343kBFx/gtIHKt
 s+4u64FGPPjNFpcNL/UdUGOoitJEnTDjYYTpfu7r7aP8W8Qkn5aBaxsE2+kEXU8uL3Hp
 ZFjb08AzDshloKTNBGZx1nFw4Qql9tTAlZT0K+D15NA9o375rZxCQQYPeijVPpn0frjn
 qIopTmhGwK9StwmHc5+Xy9XSgBrCTA2IxQTd9p4vkfI2KbF/D3KjuPRYExuujfeLAx6G
 rpqg==
X-Gm-Message-State: AOJu0YxhpdLrbkWH0xZv8Tz8sS//Omxwz5uLfHMfBFwifnlboLkRI1w5
 /oFO5N0yvLX1biUH/ABloQyaQZxu6TMX8K5Lyyy5QjYSufefVF1RT2U+ZYzgh2byZBoOMz9xYmF
 xGImcFjM=
X-Gm-Gg: ASbGncswzbCYAC1sAAaqLClU0llAS47GbJpSra/jNNjvy9JLqeqaY8YKAEZL3MA/7VX
 Ww5vAmmpB5qbvqOGMO1xPf2hDzzmzyEijk9gT9bI3VIJ/YCLEbzzbxU7r3oCioWqLO+8W7BKHkk
 cpCZrqTDPWBk7jQAHIIBEKMjvDmcynFaejmLigX1/U43mlyoFQvXnlBuT916PsxuzLBlYEDw+xX
 yG82JJXXBAonuNPqGzJ/IXx/mO6vwZ9KCi4ygx5FJhZ2izv1Ne+C758xPEWq7AnwSdIupCo3sbH
 dYsTeMZlJSujiQxxMc+TMY7W5PMK/Gi0vDKGftNeHlhABtlVK+H17n4B9FA8V0LbLDKx9Cd7H0A
 iC6lPmdCZmyWVCwrwqD3Vfg+VyibmfiD49H9zFesGd4+AYZQFPlhG4LEgF/5I3UD8DBFfxRTbP2
 ZxR4xa1X/meoCygtOjW7hjKSbtR9OJVu76GtJUbwPQ
X-Google-Smtp-Source: AGHT+IHDPiK3i2V4q1Fp5s04yz/a3kKFF3UHck+srViYLLKVDxEWMWbOwLOESNpth958nt6KnbtJ8w==
X-Received: by 2002:a17:906:eecc:b0:aff:fe6:78f0 with SMTP id
 a640c23a62f3a-b707089ecf7mr336703266b.54.1761911615285; 
 Fri, 31 Oct 2025 04:53:35 -0700 (PDT)
Received: from stoup.. (C3239BBB.static.ziggozakelijk.nl. [195.35.155.187])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077975dcbsm158078366b.14.2025.10.31.04.53.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 04:53:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] tcg/linux-user/test patch queue
Date: Fri, 31 Oct 2025 12:53:28 +0100
Message-ID: <20251031115334.368165-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

The following changes since commit 3728de31925ae9658e2ce3d1ff9b63c83609f310:

  Merge tag 'single-binary-20251030' of https://github.com/philmd/qemu into staging (2025-10-31 10:26:34 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-misc-20251031

for you to fetch changes up to 0db2de22fcbf90adafab9d9dd1fc8203c66bfa75:

  linux-user: permit sendto() with NULL buf and 0 len (2025-10-31 12:50:15 +0100)

----------------------------------------------------------------
linux-user: permit sendto() with NULL buf and 0 len
tests/functional: Mark the MIPS replay tests as flaky
tests/functional: Mark the MIPS Debian Wheezy tests as flaky
accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
tcg: Simplify extract2 usage in tcg_gen_shifti_i64

----------------------------------------------------------------
Peter Maydell (1):
      linux-user: permit sendto() with NULL buf and 0 len

Philippe Mathieu-Daudé (2):
      tests/functional: Mark the MIPS replay tests as flaky
      tests/functional: Mark the MIPS Debian Wheezy tests as flaky

Richard Henderson (2):
      accel/tcg: Introduce and use MO_ALIGN_TLB_ONLY
      tcg: Simplify extract2 usage in tcg_gen_shifti_i64

 include/exec/memop.h                     | 43 +++++++++++++++-----------------
 target/arm/tcg/translate.h               |  4 +--
 accel/tcg/cputlb.c                       | 13 +---------
 linux-user/syscall.c                     | 25 +++++++++++--------
 target/arm/ptw.c                         |  2 +-
 target/arm/tcg/translate-a64.c           | 10 +++-----
 target/arm/tcg/translate-neon.c          |  2 +-
 tcg/tcg-op.c                             | 22 +++-------------
 tcg/tcg.c                                | 10 +++++---
 tests/functional/mips/test_malta.py      |  2 ++
 tests/functional/mips/test_replay.py     |  2 ++
 tests/functional/mips64/test_malta.py    |  2 ++
 tests/functional/mips64el/test_malta.py  |  1 +
 tests/functional/mips64el/test_replay.py |  2 ++
 tests/functional/mipsel/test_malta.py    |  2 ++
 15 files changed, 64 insertions(+), 78 deletions(-)

