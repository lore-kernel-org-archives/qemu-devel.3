Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5152EC021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6K-0007eR-Bf; Sat, 15 Feb 2025 19:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5z-0007aK-2S
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:15 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS5w-0006F0-LV
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:14 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so2375877a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664071; x=1740268871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4I9Ub8xov2qHlCWqjvABuHSTVCrjKnAAT3Fdj+wxB7E=;
 b=sX6Y2OOsGothMNbf2Ip39ygDLMuyja4EcOq2JBErkRcpvFQCFj365G80RjYYyuLK/N
 jg5axv985vMSFOfdTMAOD1pUmDXgkDEf1beoLAI1EwUX05wwwFM5OtoDNBdgIoHJUcoV
 PSUicc316Nzkhq9pv9cFd5GM7GDIlm5d0R//pODHHdo997BUQM5PgWhapGx6nWGHiApl
 lugSxkiB0r1fWGdJPzzTkb2orbbHbzALB7UlkiNCdLrOIA69JYAud70Z/zpr/E83ZyAJ
 073C5EKWCCeFGxV8M9EfDxLYcYVsPPv+CnSs12YIelvcbSia4R5M4F0v0BYQZCklxWYj
 DQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664071; x=1740268871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4I9Ub8xov2qHlCWqjvABuHSTVCrjKnAAT3Fdj+wxB7E=;
 b=r14blemllB89AZEw9PCWLxIjkV6OGIFIpPYYQO18ZNr1vNduQ06Yo1hTXrkwWPw5ly
 YllLtE4ddFd6LymRSBRac5ylmBd7uAStc/sHe24WB6xZzjSuHDgMHo1ZH1KI9qWgO5pH
 +BwdhXlB6RehJjJctxS6J/VjZB+EHJSbMxKE51zlDAVjmlGwDYWJh6X8B6qeZ6mPkO9f
 uN4C+Bz1a6urgoi65OcoNYQfVC/NvyFMNGnCIByY+03mqP4XulJFVOotzx0NtTKzh7Xg
 nkrTnk3mSUX0jCGbe2BByB0koShFb9ewG6EdcCzJYaK8RHavdxyxuAsGgWqolm7qLu9m
 I4FA==
X-Gm-Message-State: AOJu0Yy9siAEaSE3ZSkxn3LQM0OQKHs77YW6tH4RDyP/BmTFbR4wLNJx
 B6hhGloa1r4MANLKpCoZYdNnUDSTDUv25DTW/dUt4RidJWSAKxuQ20J6zz7t45GBF7GwOE1rLrh
 L
X-Gm-Gg: ASbGnctvk++F6LdAVeO67j5W+RJpkVChzq28sSMSuddcW8msAbms7Ms80orzfc8eiEU
 gzevigIg1j6reoHtnH7pJDHfZbeAFTMzw8CTJfmcAvtKWiS/nVdjR4HNEWxaTPfr9qPf5qYnbE6
 V5yAWRod0Jwb+1JN0AAxe6I1NW8vvRn6HUPX+sdNOshdpH8g7E9OF6d2jLlgH7kx9ndut6PooXc
 B00Yc+eo64loX7+LEEv0a5TBa0tmGXrZ0DcSEMOkbpQnskFGsNJ2QdMLWR1JTsJme4M/MQsN7yI
 MVToN8hhvdWf9Xq1Yd5PEZkZoxBFMd+Ky3U8jGunzCgneRg=
X-Google-Smtp-Source: AGHT+IE6kWk/VxxNZucZ2DiXdDU3vVJl7T6ckA77WqoSxPmjzu8mg6ye51rdW5RzaGQbMhodwLL2Bg==
X-Received: by 2002:a17:90b:4a49:b0:2f2:a796:26b with SMTP id
 98e67ed59e1d1-2fc40d14ad0mr6874063a91.1.1739664070652; 
 Sat, 15 Feb 2025 16:01:10 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] tcg patch queue
Date: Sat, 15 Feb 2025 16:00:44 -0800
Message-ID: <20250216000109.2606518-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

With a couple of linux-user and target/sparc patches thrown in for good measure.

r~


The following changes since commit 495de0fd82d8bb2d7035f82d9869cfeb48de2f9e:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-02-14 08:19:05 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20250215

for you to fetch changes up to 2132751069134114814c7e1609e9cf644f077aad:

  target/sparc: fake UltraSPARC T1 PCR and PIC registers (2025-02-15 12:04:13 -0800)

----------------------------------------------------------------
tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
tcg: Cleanups after disallowing 64-on-32
tcg: Introduce constraint for zero register
linux-user: Move TARGET_SA_RESTORER out of generic/signal.h
linux-user: Fix alignment when unmapping excess reservation
target/sparc: Fix register selection for all F*TOx and FxTO* instructions
target/sparc: Fix gdbstub incorrectly handling registers f32-f62
target/sparc: fake UltraSPARC T1 PCR and PIC registers

----------------------------------------------------------------
Andreas Schwab (1):
      linux-user: Move TARGET_SA_RESTORER out of generic/signal.h

Artyom Tarasenko (1):
      target/sparc: fake UltraSPARC T1 PCR and PIC registers

Fabiano Rosas (1):
      elfload: Fix alignment when unmapping excess reservation

Mikael Szreder (2):
      target/sparc: Fix register selection for all F*TOx and FxTO* instructions
      target/sparc: Fix gdbstub incorrectly handling registers f32-f62

Richard Henderson (19):
      tcg: Remove last traces of TCG_TARGET_NEED_POOL_LABELS
      tcg: Remove TCG_OVERSIZED_GUEST
      tcg: Drop support for two address registers in gen_ldst
      tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
      tcg/arm: Drop addrhi from prepare_host_addr
      tcg/i386: Drop addrhi from prepare_host_addr
      tcg/mips: Drop addrhi from prepare_host_addr
      tcg/ppc: Drop addrhi from prepare_host_addr
      tcg: Replace addr{lo,hi}_reg with addr_reg in TCGLabelQemuLdst
      plugins: Fix qemu_plugin_read_memory_vaddr parameters
      accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
      include/exec: Change vaddr to uintptr_t
      include/exec: Use uintptr_t in CPUTLBEntry
      tcg: Introduce the 'z' constraint for a hardware zero register
      tcg/aarch64: Use 'z' constraint
      tcg/loongarch64: Use 'z' constraint
      tcg/mips: Use 'z' constraint
      tcg/riscv: Use 'z' constraint
      tcg/sparc64: Use 'z' constraint

 include/exec/tlb-common.h             |  10 +-
 include/exec/vaddr.h                  |  16 ++--
 include/qemu/atomic.h                 |  18 +---
 include/tcg/oversized-guest.h         |  23 -----
 include/tcg/tcg-opc.h                 |  28 ++----
 include/tcg/tcg.h                     |   3 +-
 linux-user/aarch64/target_signal.h    |   2 +
 linux-user/arm/target_signal.h        |   2 +
 linux-user/generic/signal.h           |   1 -
 linux-user/i386/target_signal.h       |   2 +
 linux-user/m68k/target_signal.h       |   1 +
 linux-user/microblaze/target_signal.h |   2 +
 linux-user/ppc/target_signal.h        |   2 +
 linux-user/s390x/target_signal.h      |   2 +
 linux-user/sh4/target_signal.h        |   2 +
 linux-user/x86_64/target_signal.h     |   2 +
 linux-user/xtensa/target_signal.h     |   2 +
 tcg/aarch64/tcg-target-con-set.h      |  12 +--
 tcg/aarch64/tcg-target.h              |   2 +
 tcg/loongarch64/tcg-target-con-set.h  |  15 ++-
 tcg/loongarch64/tcg-target-con-str.h  |   1 -
 tcg/loongarch64/tcg-target.h          |   2 +
 tcg/mips/tcg-target-con-set.h         |  26 +++---
 tcg/mips/tcg-target-con-str.h         |   1 -
 tcg/mips/tcg-target.h                 |   2 +
 tcg/riscv/tcg-target-con-set.h        |  10 +-
 tcg/riscv/tcg-target-con-str.h        |   1 -
 tcg/riscv/tcg-target.h                |   2 +
 tcg/sparc64/tcg-target-con-set.h      |  12 +--
 tcg/sparc64/tcg-target-con-str.h      |   1 -
 tcg/sparc64/tcg-target.h              |   3 +-
 tcg/tci/tcg-target.h                  |   1 -
 accel/tcg/cputlb.c                    |  32 ++-----
 accel/tcg/tcg-all.c                   |   9 +-
 linux-user/elfload.c                  |   4 +-
 plugins/api.c                         |   2 +-
 target/arm/ptw.c                      |  34 -------
 target/riscv/cpu_helper.c             |  13 +--
 target/sparc/gdbstub.c                |  18 +++-
 target/sparc/translate.c              |  19 ++++
 tcg/optimize.c                        |  21 ++---
 tcg/tcg-op-ldst.c                     | 103 +++++----------------
 tcg/tcg.c                             |  97 +++++++++----------
 tcg/tci.c                             | 119 +++++-------------------
 docs/devel/multi-thread-tcg.rst       |   1 -
 docs/devel/tcg-ops.rst                |   4 +-
 target/sparc/insns.decode             |  19 ++--
 tcg/aarch64/tcg-target.c.inc          |  86 +++++++----------
 tcg/arm/tcg-target.c.inc              | 104 ++++++---------------
 tcg/i386/tcg-target.c.inc             | 125 +++++++------------------
 tcg/loongarch64/tcg-target.c.inc      |  72 ++++++---------
 tcg/mips/tcg-target.c.inc             | 169 +++++++++++-----------------------
 tcg/ppc/tcg-target.c.inc              | 164 ++++++++-------------------------
 tcg/riscv/tcg-target.c.inc            |  56 +++++------
 tcg/s390x/tcg-target.c.inc            |  40 +++-----
 tcg/sparc64/tcg-target.c.inc          |  45 ++++-----
 tcg/tci/tcg-target.c.inc              |  60 +++---------
 57 files changed, 536 insertions(+), 1089 deletions(-)
 delete mode 100644 include/tcg/oversized-guest.h

