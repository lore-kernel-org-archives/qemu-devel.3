Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3266C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtSR-0003GO-5C; Fri, 01 Aug 2025 13:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3D-0002cc-Bd
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhs3B-0000xy-G8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:52:07 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso1515308f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754063523; x=1754668323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=j8xIikgm9Tf5bJV+xJmg+Nhbl8A3VdoUNRUi6ceNZdY=;
 b=ecDL25jLnHfPDlV8eDu5izR8unv1qHK7WpJy7bzASAex0yUyqQIYe5Q2Kq95ECBHHv
 xNimeF+0ow6ytBu2PcjIQRCsGwCdxSy9r0zrqfDkT7utQBS+Ix9Z9U3NjG/X0NjpB7XG
 MTDO+JD/nF6FW2Q1QswTcD7Z5mEybfZkf9of1Z+/uLYBaLb34vgtqY2cEznOoZUUEBNa
 NPNT+dEb3YnltqSkBUK8dGKowAIcnqwYIF8QN0gof0qkqvCH7CtID1df9ftRkYtGwQXh
 5RR1KMCv8XuL/DKkMhMnbLf4vd5nKFQcwJ7HvJ7/PoJTdGSrCzgnRNSwuy9ECL1eJ32V
 AIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754063523; x=1754668323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j8xIikgm9Tf5bJV+xJmg+Nhbl8A3VdoUNRUi6ceNZdY=;
 b=E2AL2S+t/aZvelWFXt5+p2mNCx7M0hmchd5soFg0nXKmd7fAY+Bb9rwlYjNGYB8D4S
 hrS2BZEx9TSSlZoHsDsChrEPzKsUg/SaB4/lXAQufQTrnWJnExI8KYmnX2+Atji+HUI5
 jJWhNlWacAuQqGiTNMOKkKDCRKcLx2Ou7TxfiZuZ9au+472uwmoMTpxj22T/5qlKNRG5
 +8tRX/D6J+FYHLWA43Z0JXJN0by7gsgB7YUlq9mC1fYrYgukHERvEuSlCVy+MXGb2w1F
 BeUoarUhPdidR/ZYkLPxL1oKzJzsRJR07PskqKiJuQ9RTOT3Bb+14oj7pVjb3d5ahHWS
 n+aw==
X-Gm-Message-State: AOJu0Yzps2Cvgao5lc2zAc5jYhZDWBQjRYe2HFPSJyovi3f1jQQBBGWJ
 6/oeR7MHy5qxXb7+iKpcOhUhHXb5um5u/Hf6AcDG9Gk6MCIeOED8JT0hlIqzIn6wwcYOI/fu+oM
 g9u/M
X-Gm-Gg: ASbGnctySN1D8dyjlh/L8QUN/rRBNo3W9yKvylo0ageNb6OuQT+2ZsqAl3s1I36EIlc
 DgVx3b4SA5zcGbneZyaVGXx5SdnuuNv2he1/6Kj6sNjBXiaP4TOALO0KqSJEKit8yzMmLTSu+bu
 8aYx7RZ1dieslKC5jLFVbXKd1USc7IGD2XjxfJcE4sbjLh32JlPL+0zREfECwtHWEErkvnvgogd
 INnvNd4gZjtoIw+rkCTttheDbmP20YIFO6BJx04NPbokXBlUHS+KVb7cPUDDBxyoToAqTTXWMBM
 f2ZyJUK4BMKLYgCdYh7BUqeryKgb4Kwjm0+5lsFB7Maq6u5TdtCl7n329t73L+Uw/xpv8zKi5ZI
 izJEwutLAgz7QvLz6Lt0YWv6hwt4N
X-Google-Smtp-Source: AGHT+IEY2AOpk93UbwC6/cKfOSPfIb+RQ25/vh6yu4ttvZMYE5kzclmQaUDRgwgy4C0m9tRVaACreA==
X-Received: by 2002:a05:6000:1a88:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3b8d94c3709mr250242f8f.39.1754063522948; 
 Fri, 01 Aug 2025 08:52:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4a2f03sm6176670f8f.72.2025.08.01.08.52.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 08:52:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] target-arm queue
Date: Fri,  1 Aug 2025 16:51:51 +0100
Message-ID: <20250801155159.400947-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

Hi; here's the target-arm pullreq for rc2; contents are
just some small bug fixes.

thanks
-- PMM

The following changes since commit 4e06566dbd1b1251c2788af26a30bd148d4eb6c1:

  Merge tag 'pull-riscv-to-apply-20250730-2' of https://github.com/alistair23/qemu into staging (2025-07-30 09:59:30 -0400)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20250801

for you to fetch changes up to 676ab6a21117858393a4440e4cdc3d314277cf20:

  tests/tcg: Fix run for tests with specific plugin (2025-08-01 16:48:50 +0100)

----------------------------------------------------------------
target-arm queue:
 * Add missing 64-bit PMCCNTR in AArch32 mode
 * Reinstate bogus AArch32 DBGDTRTX register for migration compat
 * fix big-endian handling of AArch64 FPU registers in gdbstub
 * fix handling of setting SVE registers from gdbstub
 * hw/intc/arm_gicv3_kvm: fix writing of enable/active/pending state to KVM
 * hw/display/framebuffer: Add cast to force 64x64 multiply
 * tests/tcg: Fix run for tests with specific plugin

----------------------------------------------------------------
Alex Richardson (1):
      target/arm: add support for 64-bit PMCCNTR in AArch32 mode

Gustavo Romero (1):
      tests/tcg: Fix run for tests with specific plugin

Peter Maydell (2):
      hw/display/framebuffer: Add cast to force 64x64 multiply
      target/arm: Reinstate bogus AArch32 DBGDTRTX register for migration compat

Vacha Bhavsar (2):
      target/arm: Fix big-endian handling of NEON gdb remote debugging
      target/arm: Fix handling of setting SVE registers from gdb

Zenghui Yu (2):
      hw/intc/arm_gicv3_kvm: Remove writes to ICPENDR registers
      hw/intc/arm_gicv3_kvm: Write all 1's to clear enable/active

 hw/display/framebuffer.c                           |  6 ++--
 hw/intc/arm_gicv3_kvm.c                            |  6 ++--
 target/arm/cpregs-pmu.c                            | 29 ++++++++++++++----
 target/arm/debug_helper.c                          | 29 ++++++++++++++++++
 target/arm/gdbstub64.c                             | 35 +++++++++++++++++-----
 tests/tcg/Makefile.target                          | 20 +++++++++++--
 tests/tcg/multiarch/Makefile.target                |  2 +-
 tests/tcg/multiarch/system/Makefile.softmmu-target |  2 +-
 tests/tcg/x86_64/Makefile.softmmu-target           |  2 +-
 9 files changed, 106 insertions(+), 25 deletions(-)

