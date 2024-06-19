Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88079C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PP-0002A8-MN; Wed, 19 Jun 2024 16:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PN-00029i-GE
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:59:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PL-0000In-Mv
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:59:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f47f07aceaso1562965ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830793; x=1719435593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6FCd5B0d5KfZC3gKhzPC9nYshGIgSmIDt+OkN/PetLU=;
 b=n7ZXfbEmfXeWtz9y19Vl/dHTMrv1B7yA6oGNSlezE6b71PV+lpgU7hc2wqUANdghUT
 YQgPpuON8L0BYQe8NwNhvjvEez2+wOqdEnPlFuY04mUMBrpuDlASU6xhGHop12SCcHnu
 r6ArJkza6UvKrS7+cEWYqDXfNzw47DYNBdV+8BWD8+xmjpzE1EM8G1p+lbf2XbB9NbkB
 UDA9ppvgbToncaQ5dLwUunEcuU3/0EUwbeM+xr1vXeMP6AmjsWWKogiIubvHaUHMbF3O
 JEhFdi/aWgTsHEi9bDzSL+GxywXvnIE8+/W9eY4m13L6nXSCbUtoNzOg9tNzpmbKMGqT
 FdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830793; x=1719435593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FCd5B0d5KfZC3gKhzPC9nYshGIgSmIDt+OkN/PetLU=;
 b=ZRdTZ0wHozeoUlPBpv0BfmIyrYn1wAe8Rz1ebQKnIvCR34Ax5eE562bcJoylx2RiKD
 flvWFlha0znkss3nn6rmwONCzrG3Qy/rLceqJUEjNen1R6f/6EkFGME4XmwJGAoQjEyO
 x3o5B2AndWNyK7160rvY5pntcEh2iBDPFJQaKdHgp3sA1kAFJHtHMPVXg2EMEyGJpEJY
 24j6Z2M/SPXXH/jd+Cwbkysmm6e0RITkNF2Zr5fCiz9Kedzza1gkoDDlOepbqvmdkW3b
 GbGCo8BuA6Wg1RnZwBncyrotMvMMxSXhYnOr48qZA1xVmNqRhZ0Wqc+eciPhaOZJJJAh
 zubw==
X-Gm-Message-State: AOJu0Yzr3e/AigwwDwhqqrRjgmhWZ0J9FBpViiXyJtmDrxag51uFti+C
 E+9XYTEkY+//A2qxt7jucXp5O8Rx0LjGF9zRLqiOa0nVBlyeCFET7LWIPclwoeEY0qGNp+mmsfX
 F
X-Google-Smtp-Source: AGHT+IFigQFDVUs2y+LYeDAPZiPMvvWn6uZS3wNAYbWbbD28SjD8nycssiz9bBXnNAsQ4fwzAwTaFA==
X-Received: by 2002:a17:902:8bc6:b0:1f6:ff48:1cf7 with SMTP id
 d9443c01a7336-1f9aa47d307mr31894245ad.69.1718830793486; 
 Wed, 19 Jun 2024 13:59:53 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] tcg patch queue
Date: Wed, 19 Jun 2024 13:59:28 -0700
Message-Id: <20240619205952.235946-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The following changes since commit 223696363bb117241ad9c2facbff0c474afa4104:

  Merge tag 'edgar/xilinx-queue-2024-06-17.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-06-18 13:08:01 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240619

for you to fetch changes up to 521d7fb3ebdf88112ed13556a93e3037742b9eb8:

  tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers (2024-06-19 13:50:22 -0700)

----------------------------------------------------------------
tcg/loongarch64: Support 64- and 256-bit vectors
tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers
util/bufferiszero: Split out host include files
util/bufferiszero: Add loongarch64 vector acceleration
accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded
target/sparc: use signed denominator in sdiv helper
linux-user: Make TARGET_NR_setgroups affect only the current thread

----------------------------------------------------------------
Anton Johansson (1):
      accel/tcg: Fix typo causing tb->page_addr[1] to not be recorded

Clément Chigot (1):
      target/sparc: use signed denominator in sdiv helper

Ilya Leoshkevich (1):
      linux-user: Make TARGET_NR_setgroups affect only the current thread

Richard Henderson (21):
      tcg/loongarch64: Import LASX, FP insns
      tcg/loongarch64: Use fp load/store for I32 and I64 into vector regs
      tcg/loongarch64: Handle i32 and i64 moves between gr and fr
      tcg/loongarch64: Support TCG_TYPE_V64
      util/loongarch64: Detect LASX vector support
      tcg/loongarch64: Simplify tcg_out_dup_vec
      tcg/loongarch64: Support LASX in tcg_out_dup_vec
      tcg/loongarch64: Support LASX in tcg_out_dupm_vec
      tcg/loongarch64: Use tcg_out_dup_vec in tcg_out_dupi_vec
      tcg/loongarch64: Support LASX in tcg_out_dupi_vec
      tcg/loongarch64: Simplify tcg_out_addsub_vec
      tcg/loongarch64: Support LASX in tcg_out_addsub_vec
      tcg/loongarch64: Split out vdvjvk in tcg_out_vec_op
      tcg/loongarch64: Support LASX in tcg_out_{mov,ld,st}
      tcg/loongarch64: Remove temp_vec from tcg_out_vec_op
      tcg/loongarch64: Split out vdvjukN in tcg_out_vec_op
      tcg/loongarch64: Support LASX in tcg_out_vec_op
      tcg/loongarch64: Enable v256 with LASX
      util/bufferiszero: Split out host include files
      util/bufferiszero: Add loongarch64 vector acceleration
      tcg/loongarch64: Fix tcg_out_movi vs some pcrel pointers

 host/include/loongarch64/host/cpuinfo.h          |    1 +
 tcg/loongarch64/tcg-target.h                     |    4 +-
 accel/tcg/tb-maint.c                             |    4 +-
 linux-user/syscall.c                             |   10 +-
 target/sparc/helper.c                            |    2 +-
 util/bufferiszero.c                              |  191 +-
 util/cpuinfo-loongarch.c                         |    1 +
 host/include/aarch64/host/bufferiszero.c.inc     |   76 +
 host/include/generic/host/bufferiszero.c.inc     |   10 +
 host/include/i386/host/bufferiszero.c.inc        |  124 +
 host/include/loongarch64/host/bufferiszero.c.inc |  143 +
 host/include/x86_64/host/bufferiszero.c.inc      |    1 +
 tcg/loongarch64/tcg-insn-defs.c.inc              | 6181 ++++++++--------------
 tcg/loongarch64/tcg-target.c.inc                 |  601 ++-
 14 files changed, 2838 insertions(+), 4511 deletions(-)
 create mode 100644 host/include/aarch64/host/bufferiszero.c.inc
 create mode 100644 host/include/generic/host/bufferiszero.c.inc
 create mode 100644 host/include/i386/host/bufferiszero.c.inc
 create mode 100644 host/include/loongarch64/host/bufferiszero.c.inc
 create mode 100644 host/include/x86_64/host/bufferiszero.c.inc

