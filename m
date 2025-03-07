Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D2C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:14:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIM-0000xJ-Fd; Fri, 07 Mar 2025 10:07:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIF-0000ut-9C
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIC-00088q-7D
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:18 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso12251155e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360033; x=1741964833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ax9lo+5LO9nqphkjDcLTd5Bed2QycwqilQUSdbsZcjg=;
 b=gzx/jtq+rZrL8jxs9ejS4ESwLWIYKYKFh8eRdLTypuv/OehGZAwfQrp5NYYnasJSBn
 EC5BW57aBaykCIzEYHLUkccx0OAcB3wOFDrqKbmdM4QU8J7dXTi+mV6AaCjWoYyG83n5
 vZNs2+InAU58YjQKC+QUoHHicBd7dwpZBzFcshts5fv8IFzEBNxYeCyzQrHHiGOXSJP8
 /1dDkvmctZY/ljIIq5eBcRco2Qw9k/E/8FZ5dQ0wGTRYjDmwF1McGfncTBnSiT9G7Dew
 zcbz8j7gLROJfRZ0O1LcZiKWH2ZI0jdgxhn84NLyXQcSCJdt5KgWJOBIeMaZkeuMGMV9
 mPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360033; x=1741964833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ax9lo+5LO9nqphkjDcLTd5Bed2QycwqilQUSdbsZcjg=;
 b=KqV3uLD0oph5gw38apfkRP3vwDigP3UnwojcS7A8u/buM1VV7f8E/W6pUUZ0n+AeL4
 ZchGhA9f/Z9nKsiToIQTcbmVn/NB81mCQVoq7fG5VmD9vd09Xq1ZVRbVtipr22oe9XhM
 DGEogWgQWmJ30JBIPDIyfh9Ody0KIugxbg7+Egc70gTqFHh/+c5yebcBhcoDxdR4bplC
 WzLtADpHjtPNn941MqPt5imIdK4JKxHURLZiqKpKVBCc48W/Ffx1gB2pUza1uY1Md4HJ
 w7IevlkKO30lEa899uXA4FQT3b7fwFE8kq4Ig4k/MbGtKhFUW/4uISfQKUuLJ5Ro1VoY
 UXrg==
X-Gm-Message-State: AOJu0YxXPPeY+tFQ5UvgOoEaVzHc+a4ZLl2S3B2QxGOcd/hILdFmxAzL
 2l5ISiG7L3V3i8dDLR3hnAG7q0TxK3RlLNnI13LoIZOl9BZn5TdZTRtFszrrViHmdcaEcguaxlX
 Z
X-Gm-Gg: ASbGncs5cbTjh0IRhDGWdQsxW+3GHl0wwRhP4I+utjb7itswp/sH6w8UxCIPap+ddTm
 vRYz4RKqQ91UjtTRk4F3n/FUVJJvOn78dqeCgqFjo5hPaYn0XEKRRbxH/YzP6Wkw7xTXWK62Nhq
 7dDlMY/5S6MciASDq2i2EXcxg+Y0Y8lMtKfzKpvxNW97q8C+XDnaiC7lsXc95/QSUyiQZUTjhJ3
 qWddzyX66/NNN65QgWY3jpiBo4VEsknyiLvelgahtTRPQWgOSUeD3egpFucUguq6J6dKBJW8yHJ
 u0Z6jU4PZ+XXupmNBM82tne0Ld/8opVt9djcwTKyx82GE7m7C8w=
X-Google-Smtp-Source: AGHT+IGMqjy1Xd3OrpdpH5pDvgamygcOa6FZisw+pmEd3ZWpE1Hm1iv7B6rwQH5ZQIWkTaUuz/W/BQ==
X-Received: by 2002:a5d:6d8e:0:b0:390:e535:8770 with SMTP id
 ffacd0b85a97d-39132d7ba76mr2535028f8f.14.1741360031461; 
 Fri, 07 Mar 2025 07:07:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] target-arm queue
Date: Fri,  7 Mar 2025 15:06:47 +0000
Message-ID: <20250307150708.3222813-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi; here's a target-arm pullreq to go in before softfreeze.
This is actually pretty much entirely bugfixes (since the
SEL2 timers we implement here are a missing part of a feature
we claim to already implement).

thanks
-- PMM

The following changes since commit 98c7362b1efe651327385a25874a73e008c6549e:

  Merge tag 'accel-cpus-20250306' of https://github.com/philmd/qemu into staging (2025-03-07 07:39:49 +0800)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20250307

for you to fetch changes up to 0ce0739d46983e5e88fa9c149cb305689c9d8c6f:

  target/rx: Remove TCG_CALL_NO_WG from helpers which write env (2025-03-07 15:03:20 +0000)

----------------------------------------------------------------
target-arm queue:
 * hw/arm/smmu-common: Remove the repeated ttb field
 * hw/gpio: npcm7xx: fixup out-of-bounds access
 * tests/functional/test_arm_sx1: Check whether the serial console is working
 * target/arm: Fix minor bugs in generic timer register handling
 * target/arm: Implement SEL2 physical and virtual timers
 * target/arm: Correct STRD, LDRD atomicity and fault behaviour
 * target/arm: Make dummy debug registers RAZ, not NOP
 * util/qemu-timer.c: Don't warp timer from timerlist_rearm()
 * include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN
 * hw/arm/smmu: Introduce smmu_configs_inv_sid_range() helper
 * target/rx: Set exception vector base to 0xffffff80
 * target/rx: Remove TCG_CALL_NO_WG from helpers which write env

----------------------------------------------------------------
Alex Bennée (4):
      target/arm: Implement SEL2 physical and virtual timers
      target/arm: Document the architectural names of our GTIMERs
      hw/arm: enable secure EL2 timers for virt machine
      hw/arm: enable secure EL2 timers for sbsa machine

JianChunfu (2):
      hw/arm/smmu-common: Remove the repeated ttb field
      hw/arm/smmu: Introduce smmu_configs_inv_sid_range() helper

Keith Packard (2):
      target/rx: Set exception vector base to 0xffffff80
      target/rx: Remove TCG_CALL_NO_WG from helpers which write env

Patrick Venture (1):
      hw/gpio: npcm7xx: fixup out-of-bounds access

Peter Maydell (11):
      target/arm: Apply correct timer offset when calculating deadlines
      target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
      target/arm: Make CNTPS_* UNDEF from Secure EL1 when Secure EL2 is enabled
      target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02 accesses
      target/arm: Refactor handling of timer offset for direct register accesses
      target/arm: Correct LDRD atomicity and fault behaviour
      target/arm: Correct STRD atomicity
      target/arm: Drop unused address_offset from op_addr_{rr, ri}_post()
      target/arm: Make dummy debug registers RAZ, not NOP
      util/qemu-timer.c: Don't warp timer from timerlist_rearm()
      include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN

Thomas Huth (1):
      tests/functional/test_arm_sx1: Check whether the serial console is working

 MAINTAINERS                      |   1 +
 hw/arm/smmu-internal.h           |   5 -
 include/exec/memop.h             |   8 +-
 include/hw/arm/bsa.h             |   2 +
 include/hw/arm/smmu-common.h     |   7 +-
 target/arm/cpu.h                 |   2 +
 target/arm/gtimer.h              |  14 +-
 target/arm/internals.h           |   5 +-
 target/rx/helper.h               |  34 ++--
 hw/arm/sbsa-ref.c                |   2 +
 hw/arm/smmu-common.c             |  21 +++
 hw/arm/smmuv3.c                  |  19 +--
 hw/arm/virt.c                    |   2 +
 hw/gpio/npcm7xx_gpio.c           |   3 +-
 target/arm/cpu.c                 |   4 +
 target/arm/debug_helper.c        |   7 +-
 target/arm/helper.c              | 324 ++++++++++++++++++++++++++++++++-------
 target/arm/tcg/op_helper.c       |   8 +-
 target/arm/tcg/translate.c       | 147 +++++++++++-------
 target/rx/helper.c               |   2 +-
 util/qemu-timer.c                |   4 -
 hw/arm/trace-events              |   3 +-
 tests/functional/test_arm_sx1.py |   7 +-
 23 files changed, 455 insertions(+), 176 deletions(-)

