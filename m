Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDBACD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbcN-0005BZ-Oi; Tue, 19 Mar 2024 11:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcM-00059z-BI
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbcE-0004kz-PN
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:43:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-413f76fcf41so42876995e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710862981; x=1711467781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0tiLh1c9fdX0ozVWgoqbQG0Frf7N65+ls807ekbVUqA=;
 b=bEqyQRb5Gj///JhmP2mf0YfkyoR2jO/gM2yRqo4PWTjjdT+zs/kvG7z8PAYRygCbfW
 fJYOs9n4nth8A35pswTuysO5smFO25daF/65g1zFsSabGzuGjUNf9O4YrPjtDU4/v2bN
 rPfq+bWEXLL8y+zSLqYYlbt5DnGdqY4oBNnjHt2/iRxOKs333+Qu3ZMI3PaTTaaNqHxD
 +8lRLrg5wiTaYuVZBOZJ1dBwij5L6rahcDNBGCPflQ3i3RUW6O1sOIALCPp+TVCp4BY6
 uAoiSL4sTqvfO8GvT1TXne13RGLCwZWhbva0kN1YYhPAMAsS9HG9Z7LtCk9eNR3ksbN8
 wEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710862981; x=1711467781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tiLh1c9fdX0ozVWgoqbQG0Frf7N65+ls807ekbVUqA=;
 b=tznI0r1NH5TjpD3ZhT/f/h9bZd/ghwOLjph8b20xMnBk+EAgXnPPGXLvpiLSvWEhe5
 Ed272dm9J/ldI2cDU+GaEbPchlalimzT0oryF3Bdx0GX/1ezzVVesxrq92O4Dtvihj5G
 5E4Jqo70HsDJEmCrM6RdxC6bJWT8XO3ojOSY0zWISeK1hAIog301wmQIQbMZPDlC/il1
 zqQS7ttJWncAsGQpFLgyNgvAJ9pitdcZ8Gf1ZkOsH3u7wygyJxaznHJCVGMsSRRQxm/Q
 oseINo+T/3MzbuNUXyquJzGSnEc1D/X0LrzxXWbl6eB6IGk3EZRun3j0xfQPp5rAHySb
 GlZg==
X-Gm-Message-State: AOJu0YxNZrAHRHcdIcPMVmP/pdby+DaV8Q9E749bn2dzpB+4j2deVKbn
 WM/Ot4KbK/9wUhZG2ktvv1Ul6PU2cAmcAKZQHQVtT6Oi2Cd7z5hS1J9FWJn7p0/ioYe5+O8aLg8
 F
X-Google-Smtp-Source: AGHT+IE2XzNhCUd00BF5YenimZX5CddAflUPFBIK1hBFOI89NYbzh3UoqatFnN7UAE0Vm/BOfzhXPw==
X-Received: by 2002:adf:ffc5:0:b0:33e:7cc8:bd68 with SMTP id
 x5-20020adfffc5000000b0033e7cc8bd68mr1946703wrs.31.1710862980859; 
 Tue, 19 Mar 2024 08:43:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 bv16-20020a0560001f1000b00341798ba0a8sm4440386wrb.87.2024.03.19.08.42.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:43:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 00/27] accel/tcg: Introduce TCGCPUOps::get_cpu_state()
 handler
Date: Tue, 19 Mar 2024 16:42:29 +0100
Message-ID: <20240319154258.71206-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

This series introduce a generic get_cpu_state() handler in
TCGCPUOps and convert each target to it.

This is required to get a single cpu_get_tb_cpu_state()
for heterogeneous emulation (since this method is called
by accel/tcg/).

Regards,

Phil.

Philippe Mathieu-Daudé (27):
  accel/tcg: Ensure frontends define restore_state_to_opc handler
  accel/tcg: Introduce TCGCPUOps::get_cpu_state() handler
  target/alpha: Convert to TCGCPUOps::get_cpu_state()
  target/arm: Restrict TCG-specific declarations
  target/arm: Convert to TCGCPUOps::get_cpu_state()
  target/avr: Convert to TCGCPUOps::get_cpu_state()
  target/cris: Convert to TCGCPUOps::get_cpu_state()
  target/hexagon: Convert to TCGCPUOps::get_cpu_state()
  target/hppa: Convert to TCGCPUOps::get_cpu_state()
  target/i386: Convert to TCGCPUOps::get_cpu_state()
  target/loongarch: Convert to TCGCPUOps::get_cpu_state()
  target/m68k: Convert to TCGCPUOps::get_cpu_state()
  target/microblaze: Convert to TCGCPUOps::get_cpu_state()
  target/mips: Convert to TCGCPUOps::get_cpu_state()
  target/nios2: Convert to TCGCPUOps::get_cpu_state()
  target/openrisc: Convert to TCGCPUOps::get_cpu_state()
  target/ppc: Indent ppc_tcg_ops[] with 4 spaces
  target/ppc: Convert to TCGCPUOps::get_cpu_state()
  target/riscv: Convert to TCGCPUOps::get_cpu_state()
  target/rx: Convert to TCGCPUOps::get_cpu_state()
  target/s390x: Restrict TCG-specific declarations
  target/s390x: Convert to TCGCPUOps::get_cpu_state()
  target/sh4: Convert to TCGCPUOps::get_cpu_state()
  target/sparc: Convert to TCGCPUOps::get_cpu_state()
  target/tricore: Convert to TCGCPUOps::get_cpu_state()
  target/xtensa: Convert to TCGCPUOps::get_cpu_state()
  accel/tcg: Remove check on TARGET_HAS_CPU_GET_TB_CPU_STATE

 accel/tcg/internal-target.h             |   2 +
 include/hw/core/tcg-cpu-ops.h           |   3 +
 target/alpha/cpu.h                      |  11 ---
 target/arm/cpu.h                        |   3 -
 target/arm/internals.h                  |   6 +-
 target/avr/cpu.h                        |  18 ----
 target/cris/cpu.h                       |  10 ---
 target/hexagon/cpu.h                    |  12 ---
 target/hppa/cpu.h                       |  42 ---------
 target/i386/cpu.h                       |  14 ---
 target/loongarch/cpu.h                  |  12 ---
 target/m68k/cpu.h                       |  16 ----
 target/microblaze/cpu.h                 |   8 --
 target/mips/cpu.h                       |   9 --
 target/mips/tcg/tcg-internal.h          |   2 +
 target/nios2/cpu.h                      |  12 ---
 target/openrisc/cpu.h                   |  10 ---
 target/ppc/cpu.h                        |  14 +--
 target/riscv/cpu.h                      |   3 -
 target/rx/cpu.h                         |   9 --
 target/s390x/cpu.h                      |  28 ------
 target/s390x/s390x-internal.h           |   4 +
 target/sh4/cpu.h                        |  15 ----
 target/sparc/cpu.h                      |  35 +-------
 target/tricore/cpu.h                    |  12 ---
 target/xtensa/cpu.h                     |  68 ---------------
 accel/tcg/cpu-exec.c                    |   6 +-
 accel/tcg/translate-all.c               |   8 ++
 target/alpha/cpu.c                      |  12 +++
 target/arm/cpu.c                        | 110 ++++++++++++++++++++++++
 target/arm/helper.c                     | 109 -----------------------
 target/arm/tcg-stubs.c                  |   4 -
 target/arm/tcg/cpu-v7m.c                |   1 +
 target/avr/cpu.c                        |  19 ++++
 target/cris/cpu.c                       |  11 +++
 target/hexagon/cpu.c                    |  13 +++
 target/hppa/cpu.c                       |  43 +++++++++
 target/i386/cpu.c                       |   2 +-
 target/i386/tcg/tcg-cpu.c               |  15 ++++
 target/loongarch/cpu.c                  |  15 ++++
 target/m68k/cpu.c                       |  17 ++++
 target/microblaze/cpu.c                 |   9 ++
 target/mips/cpu.c                       |   1 +
 target/mips/tcg/translate.c             |   9 ++
 target/nios2/cpu.c                      |  13 +++
 target/openrisc/cpu.c                   |  11 +++
 target/ppc/cpu_init.c                   |  27 +++---
 target/ppc/helper_regs.c                |  13 +--
 target/riscv/cpu.c                      |   2 +-
 target/riscv/cpu_helper.c               |  87 -------------------
 target/riscv/tcg/tcg-cpu.c              |  88 +++++++++++++++++++
 target/rx/cpu.c                         |  10 +++
 target/s390x/cpu.c                      |   1 +
 target/s390x/tcg/mem_helper.c           |   2 +-
 target/s390x/tcg/translate.c            |  23 +++++
 target/sh4/cpu.c                        |  16 ++++
 target/sparc/cpu.c                      |   1 +
 target/sparc/translate.c                |  33 +++++++
 target/tricore/cpu.c                    |  13 +++
 target/xtensa/cpu.c                     |  69 +++++++++++++++
 target/riscv/insn_trans/trans_rvv.c.inc |   2 +-
 61 files changed, 611 insertions(+), 582 deletions(-)

-- 
2.41.0


