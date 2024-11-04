Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47078D132AC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7uhg-0001ub-Hl; Mon, 04 Nov 2024 05:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhc-0001uE-QY
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:52:57 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7uhb-0003iI-03
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:52:56 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43158625112so34807815e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717572; x=1731322372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uXg6I8+Mf7JKf5rDCZkbMm0QzGm5w0BG1ynSEr7i7rQ=;
 b=Qr39WXAV5U0sPzkjaexA7tE+jFg3GQRfNYFCYnVgGo+SB2XUwpJkbFTsZqpwwDs+ol
 lx6qPkZDyEK3TEhwu+A9g4v4SY0gyCLDlrAx89CqX0yZka44TQ/0JDGsc5lM5IGt1hFE
 4T9rWzC5izo1maUTr6ssJ2SFWxU+mQO+PjQvKjI//2CE7lwtnIInhTk7/FaxOEMHwSjh
 8AcEPzYXY2mwUg/3VYdyPAqV50vUfM0lKERDL2P/gjlhOatww3oH6NgrojX1RZpL0Hyf
 Db9MA02qWD3STAq0r7Smra7P8MiYi1V3l81C0y3daFVTEg3L+IikB0kvopswWPmQbXxc
 2LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717572; x=1731322372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXg6I8+Mf7JKf5rDCZkbMm0QzGm5w0BG1ynSEr7i7rQ=;
 b=XPCZKrZOqhTpb48ewolnNI6SkamfNkOJOdJfXrW8cjXP1WyPJX3zvjIs4ULFDRbV2b
 0iL81HfQEqRj0SqdG/ncS01d8u4h4SBOn7XN10NOEwTEq6lUfDwhlPAdPsPdWNWO52q2
 QtK1GtHdESJ/YscUgilaNtYj4wX88/Ka4u2J/La+hYxK9WLOjqgjndgfTwlr7OMcksj6
 OtnhdWFejByMmI7HPjFyqMYtox5dTWwk8Qi5SVXBYtGPsU5PNxz2OYYOAmX5MiLhrA08
 nS/NRHivgze2jLy1HpAZq2zBxmCerIMlUnYPZOTJuiNNXW7jpdl4JfRuQ7FEUrcIZN6h
 xCUw==
X-Gm-Message-State: AOJu0YycwzWSYECY7m4+EJpoZcIuMpojYyOle1gCewbgkgYkuKfk7KT9
 Y7ODznms4zuBwLXrcI/nHIRxQvmipZJ9WJ4YbS/lONAPHculbQS3BtVFQw8K5/v4jpUKdBUpFc5
 k2sE=
X-Google-Smtp-Source: AGHT+IE8aQ6unZOwXmVYTEvz5C8xDBJrY0PMVQJSCP3x59c0toOTh9uJasLhvXtStoGM0bM9+FqKSw==
X-Received: by 2002:a05:600c:1909:b0:431:542d:2592 with SMTP id
 5b1f17b1804b1-4328327eba3mr95842405e9.27.1730717572212; 
 Mon, 04 Nov 2024 02:52:52 -0800 (PST)
Received: from localhost.localdomain ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm179491605e9.21.2024.11.04.02.52.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Nov 2024 02:52:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/14] MIPS patches for 2024-11-04
Date: Mon,  4 Nov 2024 11:52:44 +0100
Message-ID: <20241104105250.57818-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:

  Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/mips-20241104

for you to fetch changes up to a144a3baa61e3fca1a7946685128c349dd92c76f:

  target/mips: Remove unused CPUMIPSState::current_fpu field (2024-11-03 05:52:49 -0300)

----------------------------------------------------------------
MIPS patches queue

- Migrate missing CP0 TLB MemoryMapID register (Yongbok)
- Enable MSA ASE for mips32r6-generic (Aleksandar)
- Convert Loongson LEXT opcodes to decodetree (Philippe)
- Introduce ase_3d_available and disas_mt_available helpers (Philippe)

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


