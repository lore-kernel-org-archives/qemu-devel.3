Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C997EC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welFw-0005ge-DG; Tue, 30 Jun 2026 23:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFq-0005fI-TB
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFn-0002mj-1F
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-37fad5eca09so935314a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875085; x=1783479885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/SGysHL0tHY5nuKtNT/6ZJIQ+bDCVVtRXZiayTu4xco=;
 b=lQNYq9IhwEdKnw8NfyRRg1rz1OECkA2IBT5L4Go3uTKkhiVzxuwjimfthTSxZ5OGDk
 U6mtYsWmFoqYXklPA86azRPNXNKFfiY0BAWfh3X0X97QVVGySsf+4YotDXAeziQEeCGG
 +PKqLRFWOn0rknuAi3+oWVq2XqPm/Q+0QkJf7/Dy3k2jCa15kgTlXlAFUMTcY09WwI7s
 afG3qP6rqOgwAz/CWAfwGH7Kw3RhAmOiWB8EU64XF/vWWsvvZ6p2RJhMpueKIDzR7SJA
 57DV/XjKu73dkJLUyPaZaCMTIE3JIM7O6lo676vpQscSi1pPAZW+nZ8LDYp8wlwRyzlk
 feUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875085; x=1783479885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/SGysHL0tHY5nuKtNT/6ZJIQ+bDCVVtRXZiayTu4xco=;
 b=dgwPvJlHnfyZB70jdyMRTApnxjd/Y3cK+IMy7irU6RGd8HORRrwi8qdskvEQEK8NIz
 1ednJcTtXLlNyAxzmr0TccMRw+mCPAxOyHogjYIN8ZJQTNSlKykmYr4qkvIbMJoRUFUF
 hcUHLoMaMVnu2Q7kktpaQP8d5Ap8tb5SRwkjHE/jakl/Nv271jh4kqXhC5ryzZlsmKY+
 PLcFjzH58a42GBReaBpCBQUstjpNB4mfeNQeHKIRUf+u6sriz+ORxm8WH7fXftBXV0g4
 PNuz0JTMaJ89e4iFyfmKBbJPr7SO7vxncpv3AN9X+ODVksYTnQdenvTZb5cvgihFbhPq
 MNpg==
X-Gm-Message-State: AOJu0YxmHR2qWZ7MVC9XQXsO8fPs9UsL7yyVsBCAyhHsP2O2+AxpIokT
 GkiNXXRGBEIPgYvrOUSWudJUrMoKpar0xtXoe7W2atq2zUl6yYdvN1IISLvXCoaJiXSWQUs9+w6
 taaKM
X-Gm-Gg: AfdE7clf4NHODWVNH23ogvbkM1aVN88OKTaYHjXdKx0XcYeZEUttxQeSeNM+XS4EtOB
 ID+mDvl31f88Wc8WMoav3Qig/lhnyCDiCGcci6KK4YUcbARsqLv2/8mXJXOtsDSeFCbkD8IjSh9
 Dpzw9TvdmKhRds4bjfjvb+CGek+V0Ot4ds8W/ZYfV4TCvbRrOQumJsv3P7YQzYO5LA7eQO7GuKG
 sIK3NYxwEF1nIKPPCeX2rbmoUOWMKEawfR1gUwP4JCDCW/FIe4fNNFbKNDKMMZcA++6xVUMpYWE
 Odrurm+QkydLymJ06U9hAyI6oB1j0avyb08V7EypvvwxRNI0CJB80EhPGGiysaHN1wJnL/Bu2Cu
 c8nNlQlcbMAlBDEeOPZGXUjW/cez8WQZY86Pb/CQIJqaTOUhj9KDU8uHFmzLFMf8UiNHvtuEkFd
 qHHhc0K+izFJ+91E/F2h+tjsABeZCJy4g0evaewAtuvAD2rnrmwg==
X-Received: by 2002:a17:902:f642:b0:2b0:badc:c9cf with SMTP id
 d9443c01a7336-2ca448b0478mr33221795ad.13.1782875085092; 
 Tue, 30 Jun 2026 20:04:45 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 00/17] accel/tcg: Use IntervalTree for breakpoints and
 watchpoints
Date: Tue, 30 Jun 2026 20:04:26 -0700
Message-ID: <20260701030443.1382447-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Follow-up to 20260630171555.114844-1-shivangu@linux.ibm.com
("[RFC PATCH 0/2] change cpu->breakpoints to a GTree")

Beyond using interval-tree for breakpoints:

  - Pass the matching breakpoint to the target debug hook,
  - Allow the target to record an id/index for each BP or WP
    so that the target doesn't have to search for which item
    triggered, so that the target doesn't have to search again.
  - Convert both BP and WP to IntervalTree.


r~


Richard Henderson (17):
  accel/tcg: Pass CPUBreakpoint to debug_check_breakpoint
  accel/tcg: Constify CPUWatchpoint for debug_check_watchpoint
  cpu: Move cpu_breakpoint_test out of line
  exec/breakpoint: Move BP declarations from hw/core/cpu.h
  qemu/typedefs: Declare CPUBreakpoint and CPUWatchpoint globally
  *: Add missing include of exec/breakpoint.h
  hw/core/cpu: Remove exec/breakpoint.h include
  exec/breakpoint: Introduce BP_CPU_ID_SHIFT
  target/arm: Split is_wp out of bp_wp_matches
  target/arm: Set ID for watchpoints and breakpoints
  target/arm: Use bp argument in arm_debug_check_breakpoint
  target/arm: Use wp argument in arm_debug_check_watchpoint
  target/riscv: Set ID for watchpoints and breakpoints
  target/riscv: Use bp argument in riscv_cpu_debug_check_breakpoint
  target/riscv: Use bp argument in riscv_cpu_debug_check_watchpoint
  target/xtensa: Use BP_CPU_ID_SHIFT
  cpu: Use interval-tree for CPUBreakpoint

 include/accel/tcg/cpu-ops.h         |   4 +-
 include/exec/breakpoint.h           |  39 ++++++++--
 include/hw/core/cpu.h               |  39 +---------
 include/qemu/typedefs.h             |   2 +
 target/arm/internals.h              |   4 +-
 target/ppc/internal.h               |   4 +-
 target/riscv/debug.h                |   4 +-
 target/xtensa/cpu.h                 |   2 +-
 accel/tcg/cpu-exec.c                |  48 ++++++------
 accel/tcg/tcg-accel-ops.c           |   1 +
 cpu-common.c                        |  54 ++++++++-----
 gdbstub/system.c                    |   1 +
 gdbstub/user.c                      |   1 +
 hw/core/cpu-common.c                |   1 -
 linux-user/main.c                   |  13 +++-
 system/watchpoint.c                 |   1 +
 target/arm/tcg/debug.c              |  76 ++++--------------
 target/i386/cpu.c                   |   1 +
 target/i386/kvm/kvm.c               |   1 +
 target/i386/machine.c               |   1 +
 target/i386/tcg/system/bpt_helper.c |   1 +
 target/i386/tcg/tcg-cpu.c           |   2 +-
 target/ppc/cpu.c                    |   1 +
 target/ppc/tcg-excp_helper.c        |   4 +-
 target/riscv/debug.c                | 116 ++++++----------------------
 target/xtensa/dbg_helper.c          |  19 ++---
 target/xtensa/helper.c              |   1 +
 27 files changed, 174 insertions(+), 267 deletions(-)

-- 
2.43.0


