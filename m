Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95628CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 20:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxB2V-0006F4-1n; Sat, 05 Oct 2024 16:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2T-0006EW-Jx
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:05 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxB2R-0001hg-KG
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 16:06:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20bb92346caso20346165ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728158762; x=1728763562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=irfgPGGIAUHZVTJOmBvNpfB+bdbCcTVofkC/LEnkZY0=;
 b=dX/WTlZwAjAIn6QJe49vS10p5cBHMO6/Th3ib15WpJfX0Hs55vNC2Km6sueXMsozMc
 gMqEH1DY+JukhPiQaUAGxIO36A5wqEPlwXdoTJumIm7Ilj8rFmM7uVgASCcc56pOe/Ip
 Eabq9dRFsRm7X58J/QKulV0RHkWrwQI+OrT+wtf+CYaZ+sdRjMtDK9NhHytT3pzsg8Mi
 o1TXtuBkUekLVOxzar/hPnetub3Edd/XVNl0IYGlIJzrUifSnGjrBRlPTcKnwmtooUl8
 08Sdsvz4RZkJD1DatKLrURQhjJayXrLCSIFq5Bz/4JeQwFqETgbiLJDGx0KqqC2soCgz
 ZAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728158762; x=1728763562;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=irfgPGGIAUHZVTJOmBvNpfB+bdbCcTVofkC/LEnkZY0=;
 b=EdWqclTQX9CD+cOr7j4ziY96vZOo7Lm4RZt6KWIjjbDKQHaizgXAN5G9SAUXdsxyTe
 WUb13u4ikuv1T5W2xHqKhT1nGObpNHPCx9yRjxwrLOaL6jDo8izElZwuHlDJz7g9/aWS
 MdUP+VQnU1QJtMOJM7RhCWC0bc67l+fqpw090eEwEr4uLGS1jPSuNN178zXBKIDuPo9/
 8Tjicdgeolda/kX/t1m9y7HZ4KlM7GiVa/GIqGcJvsJV8iiK6eFGsNlPi4f2yuK3wNfi
 u6Y2dounjD0GmvVP1yLXZJx2kiczL8f+/Ma6mvXpoGjkHTCaCF9XIE1eS4FWZEgDDIHd
 70UQ==
X-Gm-Message-State: AOJu0YzW/qpQ5GWxmjb5/rwudDNUpdYxcmyF2TXUOwRFa6DMxFG2oZYB
 zqFTg44M2up5EnL16DKV6/hAYKjI8EIfUMiUYqdGfRXirzwZRKXRXYU7MhKkFn4m+3s6dJ3MxtR
 0
X-Google-Smtp-Source: AGHT+IGlIkcvQfqVVvHm809F9YqIElrzZKmax9yY2qA+GJ4yr0P9fW+0xTJH3k0gj6+vRVcrDX719A==
X-Received: by 2002:a17:903:2349:b0:20b:a9b2:b558 with SMTP id
 d9443c01a7336-20be199e341mr163370935ad.28.1728158761815; 
 Sat, 05 Oct 2024 13:06:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13931055sm16493405ad.139.2024.10.05.13.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 13:06:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v2 00/21] accel/tcg: Introduce tlb_fill_align hook
Date: Sat,  5 Oct 2024 13:05:39 -0700
Message-ID: <20241005200600.493604-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This new hook will allow targets to recognize an alignment
fault with the correct priority with respect to other faults
that can be raised by paging.

This should fix several hppa fault priority issues, most
importantly that access permissions come before alignment.

[ Helge, I find that my old hppa system images would not boot,
  and a scratch re-install of debian 12 failed (networking error?).
  Would you please test?  It would be nice to have a self-contained
  regression test for this, using a port of the multiarch/system
  minilib, but that's a larger job.]

This should fix the documented error in the Arm alignment
fault due to memory type.

[ Also untested.  I should be possible to leverate aarch64/system/boot.S
  to manage this, but it's still tricky. ]

Changes for v2:
  - Include the arm_cpu_tlb_fill_align patch.  Oops!
  - Improve some commentary in target/arm/ptw.c.


r~


Richard Henderson (21):
  accel/tcg: Assert noreturn from write-only page for atomics
  accel/tcg: Expand tlb_fill for 3 callers
  include/exec/memop: Move get_alignment_bits from tcg.h
  include/exec/memop: Rename get_alignment_bits
  include/exec/memop: Introduce memop_atomicity_bits
  hw/core/tcg-cpu-ops: Introduce tlb_fill_align hook
  accel/tcg: Use the tlb_fill_align hook
  target/hppa: Add MemOp argument to hppa_get_physical_address
  target/hppa: Perform access rights before protection id check
  target/hppa: Fix priority of T, D, and B page faults
  target/hppa: Handle alignment faults in hppa_get_physical_address
  target/hppa: Add hppa_cpu_tlb_fill_align
  target/arm: Pass MemOp to get_phys_addr
  target/arm: Pass MemOp to get_phys_addr_with_space_nogpc
  target/arm: Pass MemOp to get_phys_addr_gpc
  target/arm: Pass MemOp to get_phys_addr_nogpc
  target/arm: Pass MemOp through get_phys_addr_twostage
  target/arm: Pass MemOp to get_phys_addr_lpae
  target/arm: Move device detection earlier in get_phys_addr_lpae
  target/arm: Add arm_cpu_tlb_fill_align
  target/arm: Fix alignment fault priority in get_phys_addr_lpae

 include/exec/memop.h           |  47 +++++++++++
 include/hw/core/tcg-cpu-ops.h  |  25 ++++++
 include/tcg/tcg.h              |  23 ------
 target/arm/internals.h         |   9 ++-
 target/hppa/cpu.h              |   5 +-
 accel/tcg/cputlb.c             | 142 +++++++++++++++++----------------
 accel/tcg/user-exec.c          |   4 +-
 target/alpha/cpu.c             |   1 +
 target/arm/cpu.c               |   1 +
 target/arm/helper.c            |   4 +-
 target/arm/ptw.c               | 141 ++++++++++++++++++--------------
 target/arm/tcg/cpu-v7m.c       |   1 +
 target/arm/tcg/m_helper.c      |   8 +-
 target/arm/tcg/tlb_helper.c    |  27 ++++++-
 target/arm/tcg/translate-a64.c |   4 +-
 target/avr/cpu.c               |   1 +
 target/hppa/cpu.c              |   1 +
 target/hppa/int_helper.c       |   2 +-
 target/hppa/mem_helper.c       |  50 ++++++++----
 target/hppa/op_helper.c        |   2 +-
 target/i386/tcg/tcg-cpu.c      |   1 +
 target/loongarch/cpu.c         |   1 +
 target/m68k/cpu.c              |   1 +
 target/microblaze/cpu.c        |   1 +
 target/mips/cpu.c              |   1 +
 target/openrisc/cpu.c          |   1 +
 target/ppc/cpu_init.c          |   1 +
 target/riscv/tcg/tcg-cpu.c     |   1 +
 target/rx/cpu.c                |   1 +
 target/s390x/cpu.c             |   1 +
 target/sh4/cpu.c               |   1 +
 target/sparc/cpu.c             |   1 +
 target/tricore/cpu.c           |   1 +
 target/xtensa/cpu.c            |   1 +
 target/xtensa/translate.c      |   2 +-
 tcg/tcg-op-ldst.c              |   6 +-
 tcg/tcg.c                      |   2 +-
 tcg/arm/tcg-target.c.inc       |   4 +-
 tcg/sparc64/tcg-target.c.inc   |   2 +-
 39 files changed, 329 insertions(+), 199 deletions(-)

-- 
2.43.0


