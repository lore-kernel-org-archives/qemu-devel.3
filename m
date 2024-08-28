Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB9FC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 09:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjFMR-0001wU-N4; Wed, 28 Aug 2024 05:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFML-0001v7-1Y
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:53:01 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sjFMF-0001nX-R7
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 05:52:59 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-26ff21d82e4so4355126fac.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724838773; x=1725443573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EE1QkjLPwFEzkKKd92oIU7Nm3YjCkIS+kjLwjmt37PQ=;
 b=D/t7UqHBU1gMwpGNhXO4Xz6zbh7KvfPsop5jOY18Zll+Zan2AIN6aXHfu16wu0Uzdr
 vx5kDyLHuCfoaaRrD9yUcC8HDHg0V9vDuLej58GJIkGVxUBF2bstOUtEng/R+e74F7dy
 qxz+kfGAvbHBqEyAuMZtH/f7W1FNvEP8t/lPeeSQVzSBE6A4HinuoYW7Tac2BR2SCx4/
 F98uR6GcpPQsHtRIdc8yRgV7wLEsbzINlFEogB262PCCWbothMt4bbMW7He8gzvk5XEt
 xY5nu5TvZKmlPDaVHgYVCl2HjKtUmIteNy/COZ26+IzpPpHGr8oN/RdA1T6gQ9rv50nt
 VUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838773; x=1725443573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EE1QkjLPwFEzkKKd92oIU7Nm3YjCkIS+kjLwjmt37PQ=;
 b=U18ozctNZcT+7gogdYTeIePNE4AX+1hAuEPN+nzrARfsC+0g0BW2yup0Cxvva1/7uR
 I90vnbtb/ZzIwS7snavuBgQMitWuJaBrYXjiw35bDi4nOTBFx8ZMGOsdjsTuPEcstMXo
 FvT5zGLhML+fgdqipKJyMlSfOVAVHlZQXH2DhEjCVoa8Rf55+2gy38hCiWytPzdusEqZ
 qCMeXxqj0tnWr4y2/n7cpVfYXqBT1Z3uafgFU+yIqBjORuHLtfrxIpBBsvMImrpjNFMv
 b1ikg064oGM60usVIeMbiSsMJD7KDS+VgAwsTXyhDsRAzfj1GLx03uXQm3P6SlY3gU6G
 6G7w==
X-Gm-Message-State: AOJu0YzgExn7PAOD47HuQYRB1BnQIqVp/peW6tRfXVt9YZjfiKT3WDQO
 WX3JIYDWugriqFwQ6OMk8DUXf56NJkYZ3kic571Oa8ZRA95z9Pk9FhzZ4w==
X-Google-Smtp-Source: AGHT+IEFdwRCRQCJ+CSRbAlOyRqShOHoRPW5Gb9U+KUHY+YET3ZwojKYLwnPusWHroy5DPBw0oUAlw==
X-Received: by 2002:a05:6870:c68f:b0:270:16d3:40b3 with SMTP id
 586e51a60fabf-273e64e27fdmr18133767fac.16.1724838773181; 
 Wed, 28 Aug 2024 02:52:53 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143430f6e7sm9787508b3a.160.2024.08.28.02.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 02:52:52 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Mark Corbin <mark@dibsco.co.uk>, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v4 00/17] bsd-user: Comprehensive RISCV Support
Date: Wed, 28 Aug 2024 19:52:26 +1000
Message-Id: <20240828095243.90491-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=itachis6234@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Key Changes Compared to Version 3:
Minor comment changes and all the patches
have been reviewed by Richard Henderson
<richard.henderson@linaro.org>

Mark Corbin (15):
  bsd-user: Implement RISC-V CPU initialization and main loop
  bsd-user: Add RISC-V CPU execution loop and syscall handling
  bsd-user: Implement RISC-V CPU register cloning and reset functions
  bsd-user: Implement RISC-V TLS register setup
  bsd-user: Add RISC-V ELF definitions and hardware capability detection
  bsd-user: Define RISC-V register structures and register copying
  bsd-user: Add RISC-V signal trampoline setup function
  bsd-user: Implement RISC-V sysarch system call emulation
  bsd-user: Add RISC-V thread setup and initialization support
  bsd-user: Define RISC-V VM parameters and helper functions
  bsd-user: Define RISC-V system call structures and constants
  bsd-user: Define RISC-V signal handling structures and constants
  bsd-user: Implement RISC-V signal trampoline setup functions
  bsd-user: Implement 'get_mcontext' for RISC-V
  bsd-user: Implement set_mcontext and get_ucontext_sigreturn for RISCV

Warner Losh (2):
  bsd-user: Add generic RISC-V64 target definitions
  bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files

 bsd-user/riscv/signal.c               | 170 ++++++++++++++++++++++++++
 bsd-user/riscv/target.h               |  20 +++
 bsd-user/riscv/target_arch.h          |  27 ++++
 bsd-user/riscv/target_arch_cpu.c      |  29 +++++
 bsd-user/riscv/target_arch_cpu.h      | 147 ++++++++++++++++++++++
 bsd-user/riscv/target_arch_elf.h      |  42 +++++++
 bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
 bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
 bsd-user/riscv/target_arch_sigtramp.h |  42 +++++++
 bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
 bsd-user/riscv/target_arch_thread.h   |  47 +++++++
 bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
 bsd-user/riscv/target_syscall.h       |  38 ++++++
 configs/targets/riscv64-bsd-user.mak  |   4 +
 14 files changed, 823 insertions(+)
 create mode 100644 bsd-user/riscv/signal.c
 create mode 100644 bsd-user/riscv/target.h
 create mode 100644 bsd-user/riscv/target_arch.h
 create mode 100644 bsd-user/riscv/target_arch_cpu.c
 create mode 100644 bsd-user/riscv/target_arch_cpu.h
 create mode 100644 bsd-user/riscv/target_arch_elf.h
 create mode 100644 bsd-user/riscv/target_arch_reg.h
 create mode 100644 bsd-user/riscv/target_arch_signal.h
 create mode 100644 bsd-user/riscv/target_arch_sigtramp.h
 create mode 100644 bsd-user/riscv/target_arch_sysarch.h
 create mode 100644 bsd-user/riscv/target_arch_thread.h
 create mode 100644 bsd-user/riscv/target_arch_vmparam.h
 create mode 100644 bsd-user/riscv/target_syscall.h
 create mode 100644 configs/targets/riscv64-bsd-user.mak

-- 
2.34.1


