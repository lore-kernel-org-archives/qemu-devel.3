Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF64C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 05:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB3nb-0003Gh-PF; Mon, 28 Sep 2026 01:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3nY-0003Fp-Np
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:21:08 -0400
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xB3nW-0007k5-AN
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 01:21:08 -0400
Received: by mail-dl2-x0f.google.com with SMTP id
 a92af1059eb24-1450541ab50so1033149c88.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 22:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790572864; x=1791177664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NvshXUOr2IQtXKfXwv89ZrMkSxwNPRaw3H3bo793SuY=;
 b=lAdk2hG+xAcZhovm27JbxSorwGQDbAU6T7/qv9lYZA+Y4siAyXrhlIEhbnkqVM3y1Z
 WwrI7PaztUqVzZ3ILbz0J/YrtqTgXCgZUjwBe19IfO6i1v/8mxsJfm9jQi4lSGBQUbev
 VWBdb4KIk53p2PX9w4nZ8uYgIBaxsunn8Zd2h9Lwo0i1JJZmFAKV0i6c926epJtwr4IG
 cZILUZQ+jZZQrzj7uGCh07TMrxvG9Y03ilYjnG6QUPPlnSPCijW6EjDDG7jkKXjN7Awm
 Dk4aN25hrZ5R3/4tbEzyJFoDZju2tmau6lgWI36MHpCgm4JC+E/b29xBxkhU/YYIZG/v
 Fjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790572864; x=1791177664;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NvshXUOr2IQtXKfXwv89ZrMkSxwNPRaw3H3bo793SuY=;
 b=RFLynR0MMtC5xfWWhdvl5mBbbbGwog8OvvzoqtoLq7jVGFSOY+Vb1U3ywR9OyzVOyj
 8ktIfDivCDBBcDDIFqUcifr9Bmq1S6T9PgnTzZU+oaxLcyplyTjnO57d7z8aPw2FA7ne
 M4GufCq4WCk8wTxzVG/JgPVIBT45LnYo2g0zR0BeOEukIflZJTceAb9AtfLtTYEiYNXd
 Yl9Ffte6UZtbFYAyNmp0i+doID76FGM7nyeLMC9Wtnm65aYU+SW3M0+n6MaMeMcdtxvO
 OjXPiWL52g0k8tqqQ75zhSPW+t6pRxpA6fnaUPaZDo1dTOmOpzZF6CnurkHRjTiW+SjD
 EH0w==
X-Gm-Message-State: AFuF++m0PVjX0y6E/j0I2Rb3R8PdKmXyuesM2wneBJ2NBdx1wQ0aa7fS
 bBGEHWEK0Vkja853CWT9fS7+b354mxz5jkKy3xoblAXiqqFeK072vjWiF+OlojEf1wA=
X-Gm-Gg: AYBFou0CBLJVe2ehENUWUrASbSFIl2hwlrNmnE8KwocQC/r5nvvDJ2Uzv9gHK9aonr0
 Lu2Fgr0fMy6BkI+EnbOI3QRz30sfpQp02H4Rw5CI2Fm3M/H2jrJFZj3gMWvocXLYjXHQCkY/B+z
 YM6xS+KTVVP+eyrmQy6rw+vgBHKTPAfL5hOFZpwPnsSWl7VCLVIqZ4gMIWtVMjTWLr4KlaveB6B
 9o6eW/KJ+mqgM2eu/bVL29vVvwQoYh9wMzSmR+WkbYnDAAyJHQUsAi3njVi/GadW6+QVfvKTMpt
 Bg0VhxbmZuKIoadfLOKe7rIUBBfJZyIV9keOSR4KkLCS/GaGasYw9W60W+IHc+ygZ/mP7GQwGD6
 JKvp9BuD4upUWT6UVs0D6xzSnT2eUO10F/r+Hej6939jsSiu3hYDDuhZR2/oKNlKGD+9WVS40pZ
 QhsLf5kocWbuoAIgeori2HFf6D25zSMylmfmBFdKdHiMySBLEMDfj4jsxudKGbnnSEGYoKsBUsP
 0tyHkd+DWoHo43B0BSktsXO7zKSuG3sWfqGc+jxxw==
X-Received: by 2002:a05:701b:4292:20b0:143:298d:c1eb with SMTP id
 a92af1059eb24-146d096b191mr8949288c88.43.1790572863981; 
 Sun, 27 Sep 2026 22:21:03 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-146bb6551d9sm14726248c88.9.2026.09.27.22.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 22:21:02 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Brian Cain <brian.cain@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Stafford Horne <shorne@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Glenn Miles <milesg@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Song Gao <17746591750@163.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org
Subject: [PATCH v2 00/24] accel/tcg: share raise_excp across TCG targets
Date: Mon, 28 Sep 2026 13:20:26 +0800
Message-ID: <20260928052051.251-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:38::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl2-x0f.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Many TCG targets copy the same two-line raise: set cs->exception_index and call
cpu_loop_exit_restore. They also copy DEF_HELPER_2(raise_exception, ...).
helper_raise_exception is a global C symbol, so a unified binary cannot keep
that name on more than one target.

This series adds a shared C exit and two shared TCG helpers, then converts one
target per commit. Joiners call gen_helper_raise_excp or
gen_helper_raise_excp_restore and drop the copied DEF. Leftover TCG helpers that
still do extra work take an arch prefix. C wrappers keep the short name as
static inline where that is enough. The shared helpers only touch CPUState.
Translate may store arch state (error_code, PC) first. Guest trap numbers stay
below 0x10000. TCG loop codes such as EXCP_INTERRUPT start at 0x10000.

- Move helper_exit_atomic into cpu-exec-common.c with its DEF_HELPER, so the new
  helpers can sit beside it.
- Add cpu_loop_exit_excp next to cpu_loop_exit_restore. Set
  cpu->exception_index, then restore and exit the same way as
  cpu_loop_exit_restore.
- Add TCG raise_excp and raise_excp_restore next to cpu_loop_exit_excp.
  raise_excp exits with host_pc 0. raise_excp_restore exits with GETPC(). Each
  helper does one thing.
- Name RX and SH4 guest traps RX_EXCP_* and SH4_EXCP_* in their own commits,
  then convert the raises. Join privilege and illegal on RX through
  raise_excp_restore, and BRK and INT through raise_excp. Join illegal and
  FPU-disable on SH4. Keep SH4 sleep, trapa, and exclusive.
- Convert the remaining joiners one arch per commit: m68k, or1k, microblaze,
  sparc, loongarch, hppa, alpha, s390x, xtensa, avr, arm exception_internal,
  mips, and ppc. Store error_code or PC in translate where needed, then call the
  shared helper. loongarch and the mips 2-arg path use raise_excp_restore.
- Add gen_yield before the xtensa conversion. Fold gen_exception_nip into
  gen_exception_err_nip before the ppc conversion.
- Prefix leftover TCG helpers that still do extra work: riscv_raise_exception
  and hexagon_raise_exception. Tricore raise_exception_sync does not join.

v1: https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/

Changes v1 -> v2:

- Move helper_exit_atomic into cpu-exec-common.c. Split the restore flag into
  raise_excp and raise_excp_restore, and define both there.
- Drop the helper-gen nested-extern change.
- Shorten the cpu_loop_exit_excp comment. Drop the generic EXCP_INTERRUPT note
  on the RX and SH4 trap enums, and put those enums in their own commits.
- Split xtensa gen_yield and the ppc gen_exception_nip fold out of the
  conversion commits.
- Omit the i386 conversion, the rx, mips, and hexagon helper_wait renames, and
  the arm raise_exception rename.

Yonggang Luo (24):
  accel/tcg: move helper_exit_atomic next to cpu_loop_exit_atomic
  accel/tcg: add cpu_loop_exit_excp
  accel/tcg: add raise_excp and raise_excp_restore helpers
  target/rx: name guest trap numbers RX_EXCP_*
  target/rx: convert raises to raise_excp
  target/sh4: name guest trap numbers SH4_EXCP_*
  target/sh4: convert raises to raise_excp
  target/m68k: convert raises to raise_excp
  target/or1k: convert exception to raise_excp
  target/microblaze: convert raise_exception to raise_excp
  target/sparc: convert raise_exception to raise_excp
  target/loongarch: convert raise_exception to raise_excp
  target/hexagon: convert raise_exception to hexagon_raise_exception
  target/hppa: convert excp to raise_excp
  target/alpha: convert excp to raise_excp
  target/s390x: convert exception to raise_excp
  target/xtensa: add gen_yield for EXCP_YIELD
  target/xtensa: convert exception to raise_excp
  target/avr: convert debug/break/sleep to raise_excp
  target/arm: convert exception_internal to raise_excp
  target/riscv: convert raise_exception to riscv_raise_exception
  target/mips: convert raise_exception to raise_excp
  target/ppc: fold gen_exception_nip into gen_exception_err_nip
  target/ppc: convert raise_exception to raise_excp

 MAINTAINERS                                   |  1 +
 accel/tcg/cpu-exec-common.c                   | 28 +++++++
 accel/tcg/cpu-exec-common.h                   |  4 +
 accel/tcg/tcg-runtime.c                       |  8 --
 accel/tcg/tcg-runtime.h                       |  2 -
 include/accel/tcg/cpu-loop.h                  | 12 +++
 include/exec/helper-gen-common.h              |  4 +
 include/exec/helper-proto-common.h            |  4 +
 target/alpha/helper.c                         | 11 ---
 target/alpha/helper.h                         |  1 -
 target/alpha/translate.c                      |  8 +-
 target/arm/tcg/helper-defs.h                  |  1 -
 target/arm/tcg/m_helper.c                     |  3 +-
 target/arm/tcg/op_helper.c                    | 33 ++------
 target/arm/tcg/translate.c                    |  2 +-
 target/avr/helper.c                           | 24 ------
 target/avr/helper.h                           |  3 -
 target/avr/translate.c                        |  4 +-
 target/hexagon/cpu.c                          | 13 +--
 target/hexagon/cpu.h                          |  2 +-
 target/hexagon/helper.h                       |  3 +-
 target/hexagon/internal.h                     |  5 --
 target/hexagon/macros.h                       |  2 +-
 target/hexagon/op_helper.c                    | 29 +++----
 target/hexagon/translate.c                    | 11 +--
 target/hppa/helper.h                          |  2 -
 target/hppa/op_helper.c                       | 15 +---
 target/hppa/sys_helper.c                      |  4 +-
 target/hppa/translate.c                       |  2 +-
 target/loongarch/tcg/helper.h                 |  2 -
 target/loongarch/tcg/op_helper.c              |  6 --
 target/loongarch/tcg/tcg_cpu.c                |  4 +-
 target/loongarch/tcg/translate.c              |  2 +-
 target/m68k/helper.c                          | 12 +--
 target/m68k/helper.h                          |  1 -
 target/m68k/op_helper.c                       | 19 -----
 target/m68k/translate.c                       |  2 +-
 target/microblaze/helper.c                    |  3 +-
 target/microblaze/helper.h                    |  2 -
 target/microblaze/op_helper.c                 | 22 +----
 target/microblaze/translate.c                 |  2 +-
 target/mips/helper.h                          |  4 -
 target/mips/tcg/exception.c                   | 20 +----
 target/mips/tcg/fpu_helper.c                  |  6 +-
 target/mips/tcg/translate.c                   |  9 +-
 target/or1k/exception.c                       | 31 -------
 target/or1k/exception.h                       |  7 +-
 target/or1k/exception_helper.c                | 13 +--
 target/or1k/helper.h                          |  1 -
 target/or1k/meson.build                       |  1 -
 target/or1k/translate.c                       |  2 +-
 target/ppc/cpu.h                              |  3 -
 target/ppc/helper.h                           |  2 -
 target/ppc/internal.h                         |  9 ++
 target/ppc/misc_helper.c                      |  1 +
 target/ppc/tcg-excp_helper.c                  | 21 -----
 target/ppc/timebase_helper.c                  |  1 +
 target/ppc/translate.c                        | 20 ++---
 target/riscv/helper.h                         |  2 +-
 target/riscv/tcg/insn_trans/trans_rvi.c.inc   |  6 +-
 .../tcg/insn_trans/trans_rvzicfiss.c.inc      |  3 +-
 target/riscv/tcg/op_helper.c                  |  5 +-
 target/riscv/tcg/translate.c                  | 10 ++-
 target/rx/cpu.h                               | 10 +++
 target/rx/helper.c                            | 16 ++--
 target/rx/helper.h                            |  5 --
 target/rx/op_helper.c                         | 44 +---------
 target/rx/translate.c                         | 13 ++-
 target/s390x/helper.h                         |  1 -
 target/s390x/tcg/mem_helper.c                 |  2 +-
 target/s390x/tcg/misc_helper.c                | 10 ---
 target/s390x/tcg/translate.c                  |  2 +-
 target/sh4/cpu.h                              | 21 +++++
 target/sh4/helper.c                           | 82 ++++++++++---------
 target/sh4/helper.h                           |  4 -
 target/sh4/op_helper.c                        | 43 ++--------
 target/sh4/translate.c                        | 12 ++-
 target/sparc/helper.c                         | 21 +----
 target/sparc/helper.h                         |  2 -
 target/sparc/translate.c                      |  6 +-
 target/xtensa/cpu.h                           |  1 +
 target/xtensa/exc_helper.c                    | 13 ++-
 target/xtensa/helper.h                        |  1 -
 target/xtensa/translate.c                     |  8 +-
 target/xtensa/win_helper.c                    | 12 +--
 85 files changed, 287 insertions(+), 537 deletions(-)
 create mode 100644 accel/tcg/cpu-exec-common.h
 delete mode 100644 target/or1k/exception.c

-- 
2.52.0.windows.1


