Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9152D2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9M-00077o-5t; Tue, 22 Oct 2024 23:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S94-0006zd-DT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S8v-0008Kc-OT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:50 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36daso321752b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654474; x=1730259274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dGHEwIIzB23tpzx5mvuqbcFlOnyFHekDP8qTyxIn24Y=;
 b=r080wC7s7UH+MKfuJMNAslwPRj9J6MIoAxi16YpJYZwHfegRNDq2cmez73lPOMkkd8
 l6DWXDjB8/WNirUVBBn/cl+4lOSlwM+ERnt4c9sju5Wi2bcsOCloI7JA3UFblP5yBs4X
 M21SBr8UbczUuForG5dyKlgI74sWuPNMNtprZZ5+RUuIKAfhDEHtw2+V1SA0nY6lodM3
 9JNgKqgCdy0ws5yBAdt50qolHlyORuHux5Q2HInbAN98rSlzT5HWd77qAGmPJpjor4Hw
 53fnlMP704fk1rlz2vFXaWv/MXLzkRRDeCY31MmSw7ZpLdeL6rLPpjQCRVtBmBya5wKF
 SOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654474; x=1730259274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dGHEwIIzB23tpzx5mvuqbcFlOnyFHekDP8qTyxIn24Y=;
 b=ZNITWrWpU0y06TSjYXfsVLuz5vif0BMJ7NZ+7sOThB8W32x5XJkIn7lkQEP00MBANc
 1JawOdDTSpT3CNKxKgYMQLxpmgas89SJR8g+4am2vkn+4j9yN7Fu6GNpnsZ3807tFbYq
 spXxkw50gciwQYk26uneedHz0V3ROWJQDL+gq80GJCnxYPs+nE/VgSrJNr9wWfaxO5Z5
 fY6I6jdbg24UBVVrIpoFGbVlBocCShJNYIAiTty5g2K/k5JvTowAvHsB5KUs/VGZn/5e
 iRfHz5C2r2Qm6w82ckgMKEYlzn9FRT0Xe8wuG7XU77SBmtHM5NBLIQsOM5CZ4ypttf0Y
 bjHg==
X-Gm-Message-State: AOJu0YxZ0mCn+9ZzgAV/n9XC9kedfN50ANcLQgr4TZAd1dY8UfZtKssT
 KVu5XQI3QZSWS6c6Y/HwVz5DlWiyrd9Zjv11VsbFxJNVwwdu+Wt3pOK5m/JXRr9ea3oJ/+4oIrs
 O
X-Google-Smtp-Source: AGHT+IGt6ugYxhAORmhOmPY6URDJLkHhpHhJzOmu1bck0sOhzJ7sVTdfKJWybDqv+yfwWnIOd2fBew==
X-Received: by 2002:aa7:8d9a:0:b0:71e:7258:c69b with SMTP id
 d2e1a72fcca58-71edc1f79e1mr7408117b3a.14.1729654473532; 
 Tue, 22 Oct 2024 20:34:33 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 00/24] tcg + linux-user patch queue
Date: Tue, 22 Oct 2024 20:34:08 -0700
Message-ID: <20241023033432.1353830-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972d5:

  Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu into staging (2024-10-21 17:12:59 +0100)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241022

for you to fetch changes up to 310df7a9fe400f32cde8a7edf80daad12cd9cf02:

  linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN (2024-10-22 13:45:03 -0700)

----------------------------------------------------------------
tcg: Reset data_gen_ptr correctly
tcg/riscv: Implement host vector support
tcg/ppc: Fix tcg_out_rlw_rc
target/i386: Walk NPT in guest real mode
target/i386: Use probe_access_full_mmu in ptw_translate
linux-user: Fix build failure caused by missing __u64 on musl
linux-user: Emulate /proc/self/maps under mmap_lock
linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN
linux-user/ppc: Fix sigmask endianness issue in sigreturn

----------------------------------------------------------------
Alexander Graf (1):
      target/i386: Walk NPT in guest real mode

Dani Szebenyi (1):
      tcg/ppc: Fix tcg_out_rlw_rc

Huang Shiyuan (1):
      tcg/riscv: Add basic support for vector

Ilya Leoshkevich (3):
      linux-user: Emulate /proc/self/maps under mmap_lock
      linux-user/ppc: Fix sigmask endianness issue in sigreturn
      linux-user: Trace rt_sigprocmask's sigsets

Richard Henderson (6):
      tcg: Reset data_gen_ptr correctly
      disas/riscv: Fix vsetivli disassembly
      tcg/riscv: Accept constant first argument to sub_vec
      include/exec: Improve probe_access_full{, _mmu} documentation
      target/i386: Use probe_access_full_mmu in ptw_translate
      target/i386: Remove ra parameter from ptw_translate

TANG Tiancheng (10):
      util: Add RISC-V vector extension probe in cpuinfo
      tcg/riscv: Implement vector mov/dup{m/i}
      tcg/riscv: Add support for basic vector opcodes
      tcg/riscv: Implement vector cmp/cmpsel ops
      tcg/riscv: Implement vector neg ops
      tcg/riscv: Implement vector sat/mul ops
      tcg/riscv: Implement vector min/max ops
      tcg/riscv: Implement vector shi/s/v ops
      tcg/riscv: Implement vector roti/v/x ops
      tcg/riscv: Enable native vector support for TCG host

Yao Zi (2):
      linux-user: Fix build failure caused by missing __u64 on musl
      linux-user/riscv: Fix definition of RISCV_HWPROBE_EXT_ZVFHMIN

 disas/riscv.h                        |   2 +-
 host/include/riscv/host/cpuinfo.h    |   2 +
 include/exec/exec-all.h              |  29 +-
 include/tcg/tcg.h                    |   6 +
 linux-user/syscall_defs.h            |   6 +-
 tcg/riscv/tcg-target-con-set.h       |   9 +
 tcg/riscv/tcg-target-con-str.h       |   3 +
 tcg/riscv/tcg-target.h               |  78 +--
 tcg/riscv/tcg-target.opc.h           |  12 +
 disas/riscv.c                        |   2 +-
 linux-user/ppc/signal.c              |   2 +-
 linux-user/strace.c                  |  88 +++-
 linux-user/syscall.c                 |   6 +-
 target/i386/tcg/sysemu/excp_helper.c |  45 +-
 tcg/tcg.c                            |   2 +-
 util/cpuinfo-riscv.c                 |  34 +-
 linux-user/strace.list               |   3 +-
 tcg/ppc/tcg-target.c.inc             |   4 +-
 tcg/riscv/tcg-target.c.inc           | 994 ++++++++++++++++++++++++++++++++---
 19 files changed, 1152 insertions(+), 175 deletions(-)
 create mode 100644 tcg/riscv/tcg-target.opc.h

