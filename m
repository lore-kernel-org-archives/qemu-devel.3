Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CCAC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 03:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXC28-0007I7-Kt; Mon, 05 Feb 2024 22:22:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXC26-0007Hv-Fk
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:22:02 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXC22-0006ns-Mo
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 22:22:01 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso4348320a12.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707189717; x=1707794517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ7TAIEkqypJIeEATccuqHqaPyk3GSqOpN9PXndGqCo=;
 b=Jo9Yl2/3sIoCiGoXy+l6dhduQFoPL4fDVhDMeJMk7XYiPCdQcWWZKCzxBXCgzzocbz
 LnrVNtXizSBO7/R8VQjyo0t42PZJPYN5ckDJCuWHyAOqh43TsJoFQEqUUqYKy0wURCic
 jas1wWTsBvsB8HGweMouC8n+lnEDPgGpRY0XaGdTfUNw7cWsYy/XU06N1WdRQiI1Q9f/
 DjBDRCiry/9m2+HdY54kxz7WoX4OXMzY1wB68giNzyXiZ3IylJt9x+k6dFW3os674pbT
 W+AbShA7+7PaDu0aqPThTiLqMOG9EFrFp9NExYCTSXJWYk7wPuStKu/3NTUaAsMdBkBm
 qb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707189717; x=1707794517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ7TAIEkqypJIeEATccuqHqaPyk3GSqOpN9PXndGqCo=;
 b=dILJrXucvOLdAjGSZSwglTUq+giBYEQjsKdb5y3wtgIDc/AgXzz8FPXmbmoS9NuAh5
 L7JeuMr9ESYotYbP8rURnMlW9lYMivhm9GjF4DosjWs17slem58vTwfkWGg//wOY8EPZ
 IHZUg3H6Q+nuDFZ3qPoPy7KZsOp86sRmF07XdsVFVrgFzlPVL4LVudOQxEps5gSzXCLH
 XfAk+kbv/fqHYgbRVkDnTZBYBIpY8gc6Nggqg1drM9WniigrJXrToth+n1/C+Ra67LPu
 XCW781qR3JjpNaInuA/8BKn72f0gb4r/8DeRlp+TMHrrS4EJhqKniTwO0FGP72Nl+sFA
 461w==
X-Gm-Message-State: AOJu0Yy8YcWx6tJQaQ5vnRJQAlxdFJVzhJy/rjbINBZ6izIlh98KGjNB
 MiA+k4a1Zo95A3C3ajMwnmOA/Tj3RBjSgkgMljh+tsjOkRgP0X4zQTT621Kis+H2pjwrS6I2Jij
 P7d4=
X-Google-Smtp-Source: AGHT+IHZvJD/S+mqS4Wz+HlSmFLeyzVVwXhBPENyHtj3eYxQgGEmW2keLzmH5WXGbJx+prP53V2oZg==
X-Received: by 2002:a05:6a20:43ab:b0:19e:97ee:af55 with SMTP id
 i43-20020a056a2043ab00b0019e97eeaf55mr613221pzl.1.1707189716616; 
 Mon, 05 Feb 2024 19:21:56 -0800 (PST)
Received: from stoup.. ([43.252.112.200]) by smtp.gmail.com with ESMTPSA id
 gz22-20020a17090b0ed600b00290ae3bf8d7sm264152pjb.21.2024.02.05.19.21.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 19:21:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/39] tcg patch queue
Date: Tue,  6 Feb 2024 13:21:50 +1000
Message-Id: <20240206032151.174516-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

v2: Fix rebase error in patch 38 (tcg/s390x: Support TCG_COND_TST{EQ,NE}).


r~


The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205-2

for you to fetch changes up to 23c5692abc3917151dee36c00d751cf5bc46ef19:

  tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-05 22:45:41 +0000)

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

 docs/devel/tcg-ops.rst           |   2 +
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

