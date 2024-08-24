Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD303C5472C
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2024 04:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shipW-0005nm-4V; Sat, 24 Aug 2024 00:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipU-0005nF-Nn
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:48 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1shipT-0002EC-58
 for qemu-devel@nongnu.org; Sat, 24 Aug 2024 00:56:48 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2689e7a941fso2161326fac.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 21:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724475405; x=1725080205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7FCmXNdbxtrobSWcjfDOip3lv0JjlwBkpbj1XF+lIk8=;
 b=WajzUcTjovbs59jiJzbhhMW15RUyAdvzWHzQ4pxUW/Tx6LD3Lo5L6e7yIbdHlthE3s
 GXw5nH7gbOF87CE9TUsj2FPi/Cn3VY+WmTW8FB+91Pc8Jbu2tRbemChNn7ouwWxR8zFy
 vhqTn7dld8YWkLs5hoqjXoD3+oQTA2IbY4UlHJ5C4wKywxYXqXaEO+RnkygPcH3MkOeP
 46rbTw+IMzKFUbuis+xGUon5n6BUVbUqsv7q6NzDdSHcYGGSNDpbSMju6Y4BtyEy4Mr5
 UkbRijberQ41hbUIuX+FUJ/OAd+ZMaY07cu3kVaGBnVSK202gYkJex1nDlFtntYc3d8v
 LOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724475405; x=1725080205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7FCmXNdbxtrobSWcjfDOip3lv0JjlwBkpbj1XF+lIk8=;
 b=KgGIedFzy0mldc98IjqGQpiueRZHkwrLXRvqAuzp2KCm18CAs4I5JDVyJIbSSkbC9G
 RPoC4zV92A8RP/Xi7S0dgCSztU/4g/wWJjrInYxQ6byuPREFUPwgTOR5dYAW1Jy2SG8r
 CdK03nBANl2NobsYVqIpzKcZZGlxTktxVZNvmvwr2zFyaDA+WDCgciJOcJcUXQdSut8g
 KnPbmEGztF2qcJDh3u5H1WG1fyYFzTn/TcQDZedGe2k9JVeF+3IcvxSEvFEsa/99MEBN
 1GgNfr0APmGHpbofpeRcNGDSdmQ6gIlok+8qFxK8/8YMXeYJmVY9qHIFIy22PnmMPWG/
 wzFg==
X-Gm-Message-State: AOJu0YxdkE3OwjUV1TvNfw3B9VN33O25uWo96RdwwlPA2x+shSy/W5qV
 nDdf++xrWJLNOZiAIDh3oMw7tJPWdePyj0nI1kNjtJrR4LV0ZO3M5CHHTaDG
X-Google-Smtp-Source: AGHT+IGaX89AA5i/CpTAtAof9mb5o8zkDzwT1IEpTwHCCWW6QwCK/0lLloj/nZrLwieEzx0aAHNavw==
X-Received: by 2002:a05:6870:819c:b0:270:52c3:adcb with SMTP id
 586e51a60fabf-273e64dfb25mr5238489fac.24.1724475405270; 
 Fri, 23 Aug 2024 21:56:45 -0700 (PDT)
Received: from localhost.localdomain ([220.253.126.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7143422ecedsm3805934b3a.25.2024.08.23.21.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 21:56:44 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark@dibsco.co.uk>,
 Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v3 00/17] bsd-user: Comprehensive RISCV Support
Date: Sat, 24 Aug 2024 14:56:18 +1000
Message-Id: <20240824045635.8978-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=itachis6234@gmail.com; helo=mail-oa1-x35.google.com
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

Key Changes Compared to Version 2:
Patch 1: changed loop conditions to avoid setting r0
Patch 7: replaced manual byte swapping with const_le32
Patch 9: used ROUND_DOWN to align the stack

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


