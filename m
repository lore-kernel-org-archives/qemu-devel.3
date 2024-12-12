Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD41C3ABA0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoK1-0004bg-8y; Thu, 12 Dec 2024 13:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoK0-0004bX-7k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:54:00 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoJx-0006WO-SS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:53:59 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef89dbd8eeso631507a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029632; x=1734634432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YmhSLELNDZOYP7FpGoXWoYAisIFfjK8kEBl0i/Kwy8w=;
 b=bK4jOhMyIrbGiUPdl6XnalzSqObDXXS4DhFS0nLcZqUXpXOuWnoR/ILkwqR5shmLeT
 gEogR9u0Pw6s4iNLuJC9VliCWmFZgQ+SqhJuccXNGj+SrBViWu9R+jpmJBQwlyyLvk5o
 X1HjGXBOZ0xTzxvB+o78LZgKPK6ywZJgCBbJ2IMm5ImIrZb8c1x07VLWDlF2e2vlw9jA
 S/TDtB8vwrGnHvAVRB4IlzG0mGTeOalFm0gf/sU/DY4g0EHvyYn3PAdL9G86B8TcVoLs
 OYCud1if4hcd+1+vedKzsg44YlqGlnEagdJoANyQNTlq2aiAlQcNy3UmiC7VrWeKKxav
 UVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029632; x=1734634432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YmhSLELNDZOYP7FpGoXWoYAisIFfjK8kEBl0i/Kwy8w=;
 b=i7OePxpnNuIQOTmUm0/Qezb14QJiBhBECc+SwA5+QWNhN1APVYbdqodljFhDHbnYGM
 ucF9ZK/8bFBuIszAX8ac5RMtpnHJp+tnmGUbdrA473I4rFBaahQB56fj8QLKi19q9Td8
 VutzA/XOtSk4+gljsXpBLb7YWb84rcnPvmTCE3C40XrCa8vseAnZYULAq8glB29k4++w
 /CMAeHLphYQVVjvqItcwS1aFa6AtAoszcxkZD3ncUwUtAr55msLb7wdBIc/OnPdKW8+X
 I571rFI1a0ndnwlHF46NjrDbcc68Cqaxvd6BzravMJ2K2rKha+KKjXviWCUtxB3Tv1ME
 do5Q==
X-Gm-Message-State: AOJu0YxBhTX3sslI/wpY3NIJ6uLL4YpqpfI8BGq4BVVSTFSfaPPmf3Tk
 tGeIftyydcMeqqIFBNzEGdkAKg73tvqrSvX0Dmn4Ur3QKLrvtbHUy4XkirtP8HC5mZyL1+BqRhM
 2
X-Gm-Gg: ASbGnctkp6fVe90BiZyXPW+j0nZZhJphelUhSBRhMovvsvD8ykLaq8mNGe9+pI47kjv
 wiW0NFgLRxaAx7vLXHLstjprGHRnPPcn5WRqqZL/22ZwLMe8clSrlngUpZnqIaIWg8biJKXg/Rn
 LgpPv7OgQ8PJWwJWP+0TPSdb4lZCDByUCt4+NU3OmVUOZhmXKBWCIt1E0H8kHP/Eds8CKRQhHsO
 wveV+MijilNSrYpCFLtjqH9ne/8isL9qJWYBWGjGVqhwhWrQmabJW104eOnuQGePAVuBiXRd33l
X-Google-Smtp-Source: AGHT+IHl/VmTyPjN4MTnb5/S6OpW1glD56ur8Xc4dFlz9+QS/scalZEIf/UhCX3DMOat0rxh4BmOPQ==
X-Received: by 2002:a17:90b:4b88:b0:2ee:5691:774e with SMTP id
 98e67ed59e1d1-2f13925ac9dmr7120215a91.2.1734029631915; 
 Thu, 12 Dec 2024 10:53:51 -0800 (PST)
Received: from localhost.localdomain ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142de3473sm1604990a91.24.2024.12.12.10.53.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:53:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/18] accel/tcg: Extract user APIs out of 'exec/[cpu,
 exec]-all.h'
Date: Thu, 12 Dec 2024 19:53:23 +0100
Message-ID: <20241212185341.2857-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102c.google.com
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

The goal of this series is to clarify user emulation APIs,
and clean the mixed bag of exec/foo-all.h headers.

Move user specific declarations out of the generic
- "exec/cpu-all.h",
- "exec/cpu_ldst.h",
- "exec/exec-all.h" and
- "exec/translate-all.h"
to the generic:
- "accel/tcg/tb-internal.h" and
- "exec/page-protection.h"
and the user specific:
- "user/cpu_loop.h",
- "user/guest-host.h" and
- "user/page-protection.h"

Philippe Mathieu-Daudé (18):
  exec: Introduce 'user/guest-host.h' header
  linux-user/aarch64: Include missing 'user/abitypes.h' header
  include: Include missing 'qemu/clang-tsa.h' header
  accel/tcg: Declare mmap_[un]lock() in 'exec/page-protection.h'
  accel/tcg: Use tb_page_addr_t type in page_unprotect()
  accel/tcg: Move page_[un]protect() to 'user/page-protection.h'
  system: Remove unnecessary 'exec/translate-all.h' include
  accel/tcg: Move 'exec/translate-all.h' -> 'tb-internal.h'
  accel/tcg: Un-inline log_pc()
  accel/tcg: Move TranslationBlock declarations to 'tb-internal.h'
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (1/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (2/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (3/4)
  accel/tcg: Move user-related declarations out of 'exec/cpu-all.h'
    (4/4)
  user: Forward declare target_cpu_copy_regs structure
  user: Move 'linux-user/cpu_loop-common.h' -> 'user/cpu_loop.h'
  user: Declare cpu_loop() once in 'user/cpu_loop.h'
  user: Move various declarations out of 'exec/exec-all.h'

 accel/tcg/internal-target.h          |  43 +---------
 accel/tcg/tb-internal.h              |  53 +++++++++++++
 bsd-user/bsd-mem.h                   |   1 +
 bsd-user/qemu.h                      |   3 +-
 include/block/block_int-common.h     |   1 +
 include/exec/cpu-all.h               | 112 +--------------------------
 include/exec/cpu_ldst.h              |  47 +----------
 include/exec/exec-all.h              |  72 +----------------
 include/exec/page-protection.h       |  24 ++++++
 include/exec/translate-all.h         |  33 --------
 include/user/cpu_loop.h              |  90 +++++++++++++++++++++
 include/user/guest-host.h            |  87 +++++++++++++++++++++
 include/user/page-protection.h       |  99 +++++++++++++++++++++++
 linux-user/aarch64/mte_user_helper.h |   2 +
 linux-user/cpu_loop-common.h         |  31 --------
 linux-user/qemu.h                    |   1 +
 linux-user/user-internals.h          |   1 -
 accel/tcg/cpu-exec.c                 |  13 ++++
 accel/tcg/cputlb.c                   |   3 +-
 accel/tcg/tb-maint.c                 |   6 +-
 accel/tcg/translate-all.c            |   4 +-
 accel/tcg/translator.c               |   1 +
 accel/tcg/user-exec.c                |   6 +-
 accel/tcg/watchpoint.c               |   3 +-
 block/create.c                       |   1 +
 bsd-user/main.c                      |   1 +
 bsd-user/mmap.c                      |   1 +
 bsd-user/signal.c                    |   2 +
 cpu-target.c                         |   2 +-
 linux-user/aarch64/cpu_loop.c        |   4 +-
 linux-user/alpha/cpu_loop.c          |   4 +-
 linux-user/arm/cpu_loop.c            |   5 +-
 linux-user/elfload.c                 |   2 +-
 linux-user/flatload.c                |   1 +
 linux-user/hexagon/cpu_loop.c        |   4 +-
 linux-user/hppa/cpu_loop.c           |   4 +-
 linux-user/i386/cpu_loop.c           |   4 +-
 linux-user/loongarch64/cpu_loop.c    |   4 +-
 linux-user/m68k/cpu_loop.c           |   4 +-
 linux-user/main.c                    |   3 +-
 linux-user/microblaze/cpu_loop.c     |   4 +-
 linux-user/mips/cpu_loop.c           |   4 +-
 linux-user/mmap.c                    |   1 +
 linux-user/openrisc/cpu_loop.c       |   4 +-
 linux-user/ppc/cpu_loop.c            |   4 +-
 linux-user/riscv/cpu_loop.c          |   4 +-
 linux-user/s390x/cpu_loop.c          |   4 +-
 linux-user/sh4/cpu_loop.c            |   4 +-
 linux-user/signal.c                  |   2 +
 linux-user/sparc/cpu_loop.c          |   4 +-
 linux-user/syscall.c                 |   3 +-
 linux-user/xtensa/cpu_loop.c         |   4 +-
 system/physmem.c                     |   1 -
 target/arm/helper.c                  |   1 +
 target/arm/tcg/helper-a64.c          |   3 +
 target/arm/tcg/mte_helper.c          |   4 +
 target/arm/tcg/sve_helper.c          |   3 +
 target/hppa/op_helper.c              |   3 +
 target/s390x/tcg/mem_helper.c        |   4 +-
 target/sparc/ldst_helper.c           |   3 +
 tests/unit/test-bdrv-drain.c         |   1 +
 tests/unit/test-block-iothread.c     |   1 +
 util/qemu-thread-posix.c             |   1 +
 63 files changed, 467 insertions(+), 382 deletions(-)
 create mode 100644 accel/tcg/tb-internal.h
 delete mode 100644 include/exec/translate-all.h
 create mode 100644 include/user/cpu_loop.h
 create mode 100644 include/user/guest-host.h
 create mode 100644 include/user/page-protection.h
 delete mode 100644 linux-user/cpu_loop-common.h

-- 
2.45.2


