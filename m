Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFACC4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEX-0001zw-Qc; Sun, 04 Feb 2024 16:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEW-0001yC-P5
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:00 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEU-0003UL-T3
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:00 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7232dcb3eso27233895ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082857; x=1707687657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=BO7ye0I5KwmMd79Dh/cCt2byDtv4Iy/BkUn+Jt/H9/o=;
 b=V4SHaXQbBrCV6rXhn5PPgoqFMpAfKi7o4Ti+sfKrkLGgvKJUwmiQ67t7x9v1CUBZZ3
 n6dxANtYeYhJAUDX9UWyqWi5Lw9y+mYTq84Z34PTQSL0qTC/20vEJkc6QNzHEAfLjLwF
 hzuvlOwHy5CSNYDd2TQz1uRZyu4urOd1YCGRVmqsP/8l2xJgSzKxggKrG16jR78W0DPK
 mTNQjunhDuWBCNE9j11RtuMaeXhPWL82GE8xLr3NiwhrIoEzEZuul57S46BxVSfYPL1V
 vsaXYfZuAn4vxU2JtDj/BQqRFX0ut8XwNAuaT6av7YDfDr3LeXm9LIw6JxG+f0/saQMb
 qr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082857; x=1707687657;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BO7ye0I5KwmMd79Dh/cCt2byDtv4Iy/BkUn+Jt/H9/o=;
 b=EWWdyy8B0Amo6wbwVHzr5aux6iBi9+kwAN8KKi+GcifGFZ9Uj2JAwcwL9mf8GlI903
 eAhLYGhZscQF6sFZ2Gr+jnvflsEhXiAZpslKabL7oo+8l9B8mvQBpZe0z3LleifbeZ+v
 cMo3t43QdIq/osXm0K52+dKCsLwtfYtfiNivn00HToKwWsKC0z3XJkA9dr/4kVDuCtAJ
 aWmaG1FgX6uDMryF7eGTYNns1i9mwSDZsReDyIAN+wvG3qWtSWGwVRtbE1QlNrOgQtsD
 OehoSyYYmY/CDOzYco/mfLMh2oNYpdeo5+Gt+EXsCzduhqP9g+7CbwdUuiHdxBvfz2TY
 Or5Q==
X-Gm-Message-State: AOJu0YyWg9VleSkyvjpQ3AXXI/lkF/0xNkwRKYZ6NpwFK1Py+U2fLc1y
 xr+JkkVtUbnVwhEjhAvm6qPYPEG4Xpht5JCQAQp8SiBCh1k4I+76UZgjCLASV+/y8hwYnM/hRT1
 6xJ8=
X-Google-Smtp-Source: AGHT+IGZFC8tSK7hLuhfrtbKrI1rBMq5DyKzsZnRlcSH9Fdmt8+D+AcJBzTCxnY1xsr1UjddVUlHtQ==
X-Received: by 2002:a17:903:22c4:b0:1d9:8cd8:acff with SMTP id
 y4-20020a17090322c400b001d98cd8acffmr5585384plg.62.1707082856789; 
 Sun, 04 Feb 2024 13:40:56 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.40.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:40:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/39] tcg patch queue
Date: Mon,  5 Feb 2024 07:40:13 +1000
Message-Id: <20240204214052.5639-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205

for you to fetch changes up to 867db6870a6f5d4e0915822d6a84e665bec1f22e:

  tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-03 23:53:49 +0000)

----------------------------------------------------------------
tcg: Introduce TCG_COND_TST{EQ,NE}
target/alpha: Use TCG_COND_TST{EQ,NE}
target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
target/s390x: Improve general case of disas_jcc

----------------------------------------------------------------
Paolo Bonzini (1):
      tcg/i386: Use TEST r,r to test 8/16/32 bits

Philippe Mathieu-Daudé (1):
      tcg/aarch64: Massage tcg_out_brcond()

Richard Henderson (37):
      tcg: Introduce TCG_COND_TST{EQ,NE}
      tcg: Introduce TCG_TARGET_HAS_tst
      tcg/optimize: Split out arg_is_const_val
      tcg/optimize: Split out do_constant_folding_cond1
      tcg/optimize: Do swap_commutative2 in do_constant_folding_cond2
      tcg/optimize: Handle TCG_COND_TST{EQ,NE}
      tcg/optimize: Lower TCG_COND_TST{EQ,NE} if unsupported
      target/alpha: Pass immediate value to gen_bcond_internal()
      target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
      target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
      target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
      target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
      target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
      target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
      target/s390x: Improve general case of disas_jcc
      tcg: Add TCGConst argument to tcg_target_const_match
      tcg/aarch64: Support TCG_COND_TST{EQ,NE}
      tcg/aarch64: Generate TBZ, TBNZ
      tcg/aarch64: Generate CBNZ for TSTNE of UINT32_MAX
      tcg/arm: Split out tcg_out_cmp()
      tcg/arm: Support TCG_COND_TST{EQ,NE}
      tcg/i386: Pass x86 condition codes to tcg_out_cmov
      tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
      tcg/i386: Support TCG_COND_TST{EQ,NE}
      tcg/i386: Improve TSTNE/TESTEQ vs powers of two
      tcg/sparc64: Hoist read of tcg_cond_to_rcond
      tcg/sparc64: Pass TCGCond to tcg_out_cmp
      tcg/sparc64: Support TCG_COND_TST{EQ,NE}
      tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
      tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
      tcg/ppc: Tidy up tcg_target_const_match
      tcg/ppc: Add TCG_CT_CONST_CMP
      tcg/ppc: Support TCG_COND_TST{EQ,NE}
      tcg/s390x: Split constraint A into J+U
      tcg/s390x: Add TCG_CT_CONST_CMP
      tcg/s390x: Support TCG_COND_TST{EQ,NE}
      tcg/tci: Support TCG_COND_TST{EQ,NE}

 include/tcg/tcg-cond.h           |  74 ++++--
 tcg/aarch64/tcg-target-con-set.h |   5 +-
 tcg/aarch64/tcg-target-con-str.h |   1 +
 tcg/aarch64/tcg-target.h         |   2 +
 tcg/arm/tcg-target.h             |   2 +
 tcg/i386/tcg-target-con-set.h    |   6 +-
 tcg/i386/tcg-target-con-str.h    |   1 +
 tcg/i386/tcg-target.h            |   2 +
 tcg/loongarch64/tcg-target.h     |   2 +
 tcg/mips/tcg-target.h            |   2 +
 tcg/ppc/tcg-target-con-set.h     |   5 +-
 tcg/ppc/tcg-target-con-str.h     |   1 +
 tcg/ppc/tcg-target.h             |   2 +
 tcg/riscv/tcg-target.h           |   2 +
 tcg/s390x/tcg-target-con-set.h   |   8 +-
 tcg/s390x/tcg-target-con-str.h   |   3 +-
 tcg/s390x/tcg-target.h           |   2 +
 tcg/sparc64/tcg-target.h         |   2 +
 tcg/tcg-internal.h               |   2 +
 tcg/tci/tcg-target.h             |   2 +
 target/alpha/translate.c         |  94 ++++----
 target/m68k/translate.c          |  74 +++---
 target/s390x/tcg/translate.c     | 100 +++------
 target/sparc/translate.c         |   4 +-
 tcg/optimize.c                   | 474 ++++++++++++++++++++++++++++++---------
 tcg/tcg.c                        |  40 +++-
 tcg/tci.c                        |  14 ++
 docs/devel/tcg-ops.rst           |   2 +
 tcg/aarch64/tcg-target.c.inc     | 166 +++++++++++---
 tcg/arm/tcg-target.c.inc         |  62 +++--
 tcg/i386/tcg-target.c.inc        | 201 ++++++++++++-----
 tcg/loongarch64/tcg-target.c.inc |   3 +-
 tcg/mips/tcg-target.c.inc        |   3 +-
 tcg/ppc/tcg-target.c.inc         | 294 ++++++++++++++++++------
 tcg/riscv/tcg-target.c.inc       |   3 +-
 tcg/s390x/tcg-target.c.inc       | 246 +++++++++++++-------
 tcg/sparc64/tcg-target.c.inc     |  65 ++++--
 tcg/tci/tcg-target.c.inc         |   3 +-
 38 files changed, 1379 insertions(+), 595 deletions(-)

