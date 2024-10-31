Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34360E68958
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Mgu-0006WB-IR; Thu, 31 Oct 2024 00:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mgt-0006W2-2w
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:21:47 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6Mgr-0006pF-31
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:21:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so531673e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348502; x=1730953302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M7oPehoUXUYuGOIvRvIXcbR6GBA549zaEK6MYXZJM+E=;
 b=aLQCCBvl/+vc3lKNvwtN9fujlKyHllVmbjYl+m1nXan391pfCQeYe/kCJvlobA+IYQ
 5orJRfe757b+QbrI4yZmchiDiOdGhKDbvKxLfSrNqOUebPvaIB6lFH2yVk6Z5XJ6HvYp
 96rlNptqhi3n2CsnZ1sc56hteGumEcXyrFung70iQyoqiggjjsu4TXICyz82SBWkquO8
 TUZe1WICW5wAm7/olQQM0bUflq7T7/syGdX+l9/xtUBLDgG6rj8/0wYHdDJ5abME/wD8
 FCQvWRjlc1tfGIdfAbsqeOrlbHetTSFMK786Wce7slKK3GhYdBJaI7kmGFD/3R9FzOyT
 /IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348502; x=1730953302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7oPehoUXUYuGOIvRvIXcbR6GBA549zaEK6MYXZJM+E=;
 b=h7MWrsb+KP2l9dVPVWCignmanHDEL5Ir3OHmniyXNXdHVkE0SDlX+fPpOk5r/cCmjy
 X2FuBkiOAdvrGhT0GjOfm3HYeHkDeHs/UbHw7zXnVjm3EF/77DwXiuv7Hv3U1Fvk1ADo
 DfjeLivyhnQJDk2Q+/L+MHrlpZIbnf6hJk0TgPB3xyQWwfz7bJw7E/F1BqJhoqEicFuD
 2WP/qj8zmckMLp8lTOXD5v18uSC28xvKFulizMaZQ8GBI4jSBt1E4kJE+eubNMBzOO7q
 dplHlA4yTdpb2Vcv/U3WYttgQcxCUxzLERY2PvUk9DMhVYIyqPdeq8ZTeB7IpeVypaAz
 W0rg==
X-Gm-Message-State: AOJu0YyULF9nRzai/B+ieaIRCr4nTLKB57BbEU4F0+Svi4sHK1oyCqGV
 zR6KmfbrZp3DktvzkqmtYfr9mp5NOIeVd1bActrVvDXNI/uLsdcGtKLUoVgzgQZJVbvkDDapyyP
 2
X-Google-Smtp-Source: AGHT+IFsFvDghagLR1lbVoDQd8RunamCI4uB7id5/ZbNBnE7xyHFQ0TPCNMkgxwcY3k9GsNjyCGe+w==
X-Received: by 2002:a05:6512:3e11:b0:535:66ff:c681 with SMTP id
 2adb3069b0e04-53b34a1b681mr8728786e87.48.1730348502235; 
 Wed, 30 Oct 2024 21:21:42 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bdcf1e0sm74685e87.216.2024.10.30.21.21.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:21:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] MIPS patches for 2024-10-31
Date: Thu, 31 Oct 2024 01:21:16 -0300
Message-ID: <20241031042130.98450-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f29:

  Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into staging (2024-10-29 14:00:43 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20241031

for you to fetch changes up to dcc3c68c844fef7bc018ab53f0993b8d44137d77:

  target/mips: Remove unused CPUMIPSState::current_fpu field (2024-10-31 00:48:45 -0300)

----------------------------------------------------------------
MIPS patches queue

- Migrate missing CP0 TLB MemoryMapID register (Yongbok)
- Enable MSA ASE for mips32r6-generic (Aleksandar)
- Convert Loongson LEXT opcodes to decodetree (Phil)
- Introduce ase_3d_available and disas_mt_available helpers (Phil)

----------------------------------------------------------------

Aleksandar Markovic (1):
  target/mips: Enable MSA ASE for mips32r6-generic

Philippe Mathieu-Daudé (12):
  target/mips: Extract decode_64bit_enabled() helper
  target/mips: Simplify Loongson MULTU.G opcode
  target/mips: Re-introduce OPC_ADDUH_QB_DSP and OPC_MUL_PH_DSP
  target/mips: Convert Loongson DDIV.G opcodes to decodetree
  target/mips: Convert Loongson DIV.G opcodes to decodetree
  target/mips: Convert Loongson [D]DIVU.G opcodes to decodetree
  target/mips: Convert Loongson [D]MOD[U].G opcodes to decodetree
  target/mips: Convert Loongson [D]MULT[U].G opcodes to decodetree
  target/mips: Remove unreachable 32-bit code on 64-bit Loongson Ext
  target/mips: Introduce ase_3d_available() helper
  target/mips: Introduce disas_mt_available()
  target/mips: Remove unused CPUMIPSState::current_fpu field

Yongbok Kim (1):
  target/mips: Migrate TLB MemoryMapID register

 target/mips/cpu.h                         |   7 +-
 target/mips/mips-defs.h                   |   2 -
 target/mips/tcg/translate.h               |   8 +
 target/mips/tcg/godson2.decode            |  27 ++
 target/mips/tcg/loong-ext.decode          |  28 ++
 target/mips/sysemu/machine.c              |   9 +-
 target/mips/tcg/loong_translate.c         | 271 ++++++++++++++
 target/mips/tcg/translate.c               | 415 +++++-----------------
 target/mips/cpu-defs.c.inc                |  16 +-
 target/mips/tcg/micromips_translate.c.inc |   5 +-
 target/mips/tcg/meson.build               |   3 +
 11 files changed, 452 insertions(+), 339 deletions(-)
 create mode 100644 target/mips/tcg/godson2.decode
 create mode 100644 target/mips/tcg/loong-ext.decode
 create mode 100644 target/mips/tcg/loong_translate.c

-- 
2.45.2


