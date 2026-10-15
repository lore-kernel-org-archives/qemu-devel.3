Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2082CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHBz7-0006a7-P6; Wed, 14 Oct 2026 23:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBz2-0006Z2-I1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:21 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xHBz0-0006cJ-Lp
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:18:20 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3ab3f899c8aso738716a91.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792034297; x=1792639097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sPBtmxH5jV8PDqQVU7hPP1VXAxscw7SqT5X6IIHfEKU=;
 b=edut6yJ7bG01agtIsDfcBzn3M/Ob6T+W+HAFaP70V+bfTHbJSscHgW8rBvdabnhRB2
 7gNyeGKaoUvATA8IDxQsv6kammLKrMIWwdsCYwPgR7q7WG6JiNB3MqGg0+E86E3FDz3t
 09JU5ipcmzEJH2lzMrEIEJW3KcRZW6bRd/UKCpmrGUkZ8vSYa6vMvI+mCqrl3hRwRo3m
 LKmXoMDhkYwSLQhwyk5K1ViKXqumIXWCxYbhIdlzHkcWd2Yc+KJZ8R+UVNJ3VBPtYMzE
 czhy3EZZ9LzzcIw5Gt3IhKcUy6k3MNYvgPrdRmxGO8OE592PYj+Y8CEazJwF7wVxlzxI
 qOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792034297; x=1792639097;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sPBtmxH5jV8PDqQVU7hPP1VXAxscw7SqT5X6IIHfEKU=;
 b=zMylPRrdGHZQdGr+cEeI/ByHf/uFFsBrFz5uw8vi99hl09BZv5M29a7St0HjzRSb0U
 ru3/XudIFK72u2zrXo34QNEQygOBqIpVu8ujIKrKARrSjOzH6BqRuS1iQ8RCrqEdrpcx
 6KP687a4YoYElXmq7sLZP4l3FatjrxTD0v5rz0RXTUg3wDpea8FevEXhohdcL5kQDaTQ
 NEYk3m+hcmxEVc99gs4wKTh6X0vgfWYs+ovtje4+QvxJCHAbJOqmPUrAfHvXXhYYJUzf
 ZCiQ/pFfn1rV/Z8vMt6m2voQtMIjMYisqHr+2T/Y59SY7Uz3qQvpxS/A9Obg9bq9Bm7x
 cMhA==
X-Gm-Message-State: AFq9FYJs+mTI2zdv69zYXxatGId+7lKfiSKgWUPcW1JT3xp1EtvXnatN
 edkZJ3Y1DqBuDEzGVfvr8TnTuCHqP2ekrJH3/pPglqZfZbkwa6kPHjbpEid6/upLzgQsDvQpPpB
 8Tf45d3I=
X-Gm-Gg: AYBFou3fgVq2IQuBLi5WZ1uPPEnAk8gsyT4xh2nDsOQ2fRJGeZlObrIlvDb2ORIbOOd
 L81JH6JBs9Su3wTnZB+mATA+m41pBlMxxb7xDIx8nPwYLR/655Vy5xfM4A4v/WvFUMKo0SzP2HL
 v2YuyMDLq8sq7Md4vq2LLs7fbQsgzJhC/2ZyLCnCAHW06iEcxbwK3/MLyxL8Q+Y8qULq3K0JpzX
 3e5OdROE/tiJhpiCzRUcOuLKjG9qNQAlWcjFUpB27iphW+OAleiDmWASn7pGRxPlY40n0GAj9+w
 R0ceJ0ZG8gEnzAfke5sxUAgoX62lEIMhNi/CGB/7/ygoiEwhvanLqcaiAnf80NCj6clluqfyDJs
 Aa1HH6NK5OSNEeG/gtl/Z+pE7916uqBc0MIYrcInPL6CrrPzBhuKfC12imYkdIncHbKxDsddyYU
 jESFxGc1Wmn29UIsWnMvu1ilM9xTyXeKJQApCV9KmGr4gbjj683scOZn5XtsweCHUnSSfSN5OLY
 R29dh+S4F15RSIIyzpwJy5HupevXBOm1CY7PPBlAlCdCnc=
X-Received: by 2002:a17:90b:5345:b0:3ac:9e5e:d1a5 with SMTP id
 98e67ed59e1d1-3ac9e5ed355mr808243a91.6.1792034294802; 
 Wed, 14 Oct 2026 20:18:14 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac93049ec2sm1321725a91.1.2026.10.14.20.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 20:18:14 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>
Subject: [PATCH 00/12] Add the RCPU to Tenstorrent Atlantis
Date: Thu, 15 Oct 2026 13:17:52 +1000
Message-ID: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=portias@tenstorrent.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Atlantis includes a 32-bit RISC-V core (RCPU) used for boot, low-level
control, and ongoing system management [1]. This series is the first step in
adding the RCPU to the tt-atlantis machine. The RCPU shares access to most
peripherals with the Ascalon cores. However, the RCPU has a different memory view.
This requires a different memory map and a private memory container that the
SoC aliases the shared devices into, at the addresses the RCPU expects.

On hardware, the RCPU is responsible for loading images from the boot medium
into DRAM and releasing the Ascalon cores from reset, via the CPL. This
functionality is not implemented in these changes. The images for the Ascalon
cores continue to be loaded directly into DRAM via command line arguments and
the Ascalon cores start executing at reset.

With these changes, running tt-atlantis with rcpu=on will create a separate
CPUCluster with the RCPU, giving gdb two inferiors. If no bootrom is provided,
the RCPU hart will be held powered off. With a bootrom provided,
via tt-atlantis,rcpu=on,bootrom=, the RCPU will execute the image and console
output is on the second command line serial. This series does not provide a
binary to test on the RCPU, it is in active development and not publicly
available. The QEMU tests are updated to test booting of the Ascalon cores with
and without the RCPU modeled. The machine properties related to the cpus, smp
count and cpu-type, apply to the Ascalon cluster. The RCPU is an auxiliary
core and is not configurable.

See docs/system/riscv/tt_atlantis.rst for usage.

[1] https://github.com/tenstorrent/atlantis-soc-docs/blob/main/data_sheet/atl_soc_data_sheet.pdf

Joel Stanley (1):
  machine: Support extra board CPUs outside -smp

Portia Stephens (11):
  hw/riscv/atlantis: Set valid_cpu_types for Atlantis machine
  hw/riscv/atlantis: Update fdt functions to take generic parameters
  hw/riscv/atlantis: Move Ascalon into cluster struct
  hw/riscv/atlantis: Store Ascalon memory in cluster struct
  hw/riscv/atlantis: Create CPU cluster for Atlantis cpus
  target/riscv: Add Tenstorrent Real-time CPU
  hw/riscv/atlantis: Add the RCPU to the Atlantis SoC
  hw/riscv/atlantis: Back RCPU memory region by unimplemented device
  hw/riscv/atlantis: Load the RCPU bootrom
  tests/functional/riscv64: Add rcpu to tt-atlantis tests
  docs/atlantis: Update Atlantis documentation to include the RCPU

 MAINTAINERS                                  |   1 +
 accel/tcg/tcg-all.c                          |   2 +-
 docs/system/gdb.rst                          |   2 +
 docs/system/riscv/tt_atlantis.rst            |  30 +
 hw/riscv/Kconfig                             |   2 +
 hw/riscv/tt_atlantis.c                       | 613 +++++++++++++++----
 include/hw/core/boards.h                     |   4 +
 include/hw/riscv/tt_atlantis.h               |  81 ++-
 target/riscv/cpu-qom.h                       |   1 +
 target/riscv/cpu.c                           |  28 +
 target/riscv/tcg/csr.h                       |   3 +
 target/riscv/tcg/meson.build                 |   1 +
 target/riscv/tcg/tt_csr.c                    |  58 ++
 tests/functional/riscv64/test_tt_atlantis.py |  10 +-
 14 files changed, 709 insertions(+), 127 deletions(-)
 create mode 100644 target/riscv/tcg/tt_csr.c

-- 
2.43.0


