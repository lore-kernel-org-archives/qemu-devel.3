Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E14C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 08:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZnkH-00074t-RB; Fri, 02 Aug 2024 04:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkE-0006xk-34
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:39 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sZnkC-0006P7-6y
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 04:34:37 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-81fbbd4775bso168216139f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587674; x=1723192474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IsCJyZsrG5LF3/HsWTJH1euxbYkgtabKBhddbes0+Do=;
 b=g1XmlxjCRLbCQSvbacubx2frwaK6z5JCamJMeSfrOfUjN7j+sx8qMJAYIL8mKFBI+p
 lFYRMzB8+TekwKdhZYfgPdOrY0AnG+BS/WUm9Hswyt0tIKClwC3YeC7KRyY+3psoZ7NZ
 6enRBajXP41dwoU+ngGjHL0i9kSnGxUXSLRWlzBV+hgMCat53gFR+oXzvUCKKiujPU1J
 t07Lz2QS5tOY6Rxh+Zcm4Z+xOAu/hsdvGYQtvOphhtyAKt2aPtGQ+UqQbLu+zJGI/fDE
 zMkPaBGPNzv3R0lntUZMqN67rgWzjRpOsj3VJ1j68qsaTftpbEXE8GIEPc3purvRf4Xx
 4iNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587674; x=1723192474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IsCJyZsrG5LF3/HsWTJH1euxbYkgtabKBhddbes0+Do=;
 b=jj38hwH7KVGL7u07A/ziZDXsy53GXX6ac6ZeHYyuI0BEeeyB9xtDoBVniWC58oQbc/
 ZrQ5IYJFaJqMV3R5QHJURUmXC5sQ01VtnWsIxSP88+Xj6ckX8rhQBW5Fe6fpNkksPwca
 HH5WGEDEK4HJWNothF7R0GuM3pjN1HELrcQkHmhfFgVGPt51fBc19IxTmOW7eH5Qdyrs
 b5cAJznYVSnJEPlVu8UcxAAiKbms7Vlc021CcBMSI3XTrcaG5TRgc1LM2+QbNSr+8XM1
 4zgP5eQyD8bC7gF3KjnpTYU3xFObakO6bgw7j4vxVhRDp4+XRtIBWizL13h9ccnV5BP1
 T/bg==
X-Gm-Message-State: AOJu0Yx6LIngqdP9DP8rC8a02owHNUqreVOpS5h6ZEJ9qT6WBGm/bVro
 1I2vHWmJwU3jhGuCC1rE3ATqPv/hWuV7jrMljZmi8hg+pS/YmuQtrC2RjU8F
X-Google-Smtp-Source: AGHT+IEufeUdlwrLb5Hpgk7EnysoLU/7I5Mb4Y5I69mW82xmiVARatig35xHm5KGNqvuV/ewpFgzgQ==
X-Received: by 2002:a92:d38d:0:b0:375:9ff9:7cf4 with SMTP id
 e9e14a558f8ab-39b1fb78dffmr30073415ab.4.1722587674430; 
 Fri, 02 Aug 2024 01:34:34 -0700 (PDT)
Received: from localhost.localdomain ([203.87.101.91])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec06a25sm951673b3a.33.2024.08.02.01.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 01:34:33 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH 00/18] bsd-user: Comprehensive RISCV support
Date: Fri,  2 Aug 2024 18:34:05 +1000
Message-Id: <20240802083423.142365-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=itachis6234@gmail.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch series provides support for the RISC-V 64-bit architecture,
enabling signal processing, system call handling, threading, and memory
management tailored to RISC-V.

Mark Corbin (16):
  bsd-user: Implement RISC-V CPU initialization and main loop
  bsd-user: Add RISC-V CPU execution loop and syscall handling
  bsd-user: Implement RISC-V CPU register cloning and reset functions
  bsd-user: Implement RISC-V TLS register setup
  bsd-user: Add prototype for RISC-V TLS register setup
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
 bsd-user/riscv/target_arch_elf.h      |  48 ++++++++
 bsd-user/riscv/target_arch_reg.h      |  88 +++++++++++++
 bsd-user/riscv/target_arch_signal.h   |  75 ++++++++++++
 bsd-user/riscv/target_arch_sigtramp.h |  46 +++++++
 bsd-user/riscv/target_arch_sysarch.h  |  41 +++++++
 bsd-user/riscv/target_arch_thread.h   |  47 +++++++
 bsd-user/riscv/target_arch_vmparam.h  |  53 ++++++++
 bsd-user/riscv/target_syscall.h       |  38 ++++++
 configs/targets/riscv64-bsd-user.mak  |   4 +
 14 files changed, 833 insertions(+)
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


