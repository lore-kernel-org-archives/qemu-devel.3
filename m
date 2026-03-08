Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B84FF55126
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8PK-0006Z6-9q; Sun, 08 Mar 2026 03:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PI-0006Uf-BX
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:32 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PG-0001Az-13
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:32 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be1ab1fa7dso2551814eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954308; x=1773559108; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fmZqlQRY3q+Q09U7YaMY5vQxloXjdCuaPjzxDBldTsU=;
 b=eHz30zvPL+P2PRdQobhREVKqpeJdQEDojXqDdUHCHm7pbFRm9FaJEJ9azobjP8szuV
 5x9IXqJ9CQp4fgOApn7qvQKypC1fr+2SnLh8kUtJb0SzQDSBeQYDZIeuc5XZ67gjccgs
 iKjcv5P19HlInERVmf4oOMn0elk7pNRupqCSomG1hyq7cLS9qENysKsA0qfkkmajtbAs
 7HzW93lodW69pWrSRx/h80Q1BktQtPJyAPWKGKRnG4HX13OqjBBQvK1ovi8/xDkKJS/9
 FMUIIey4C3wVb3+bZFAqfMj/jZX8O18gn2JQZkd6+OgQqpyIBRk4KSI0YCbQVHDQgYVu
 dejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954308; x=1773559108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmZqlQRY3q+Q09U7YaMY5vQxloXjdCuaPjzxDBldTsU=;
 b=nOJ7DHvC5peY+ZPsstZX78+nIfoNjbXUmk9TvtBZY9NljozdMzwD8gtM9SjDZCanmp
 WaYhrdiDDxvehkcQZjizv1SbVElXLiBmrbOCy++hZtA3rDYQv2rVYBkswF03qF1AC0Et
 R1afAH2p/KjWxwqDtSVGd1VWDB5A7yHiT1LErtJjB25q0RB9Kts7oRiNSRoRdj6qfFu+
 Ye2bIkRimNmvN97Pz5xdRjqwEI2sYvZhVxX6HhUj7G9itycLBuwjSc7Lm2B4a9XGVqKf
 waOZuLM52nB7T9tn49H53yZA88e3jSLenSbgY4ZslG2VVu2uEvTncxjTNn53GCOoNQvt
 2Gdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMJvY6O+49GqPr3XRHY7DNXh24QbU9HcbO4TdwJg7Mm0ejFMorIO5M5xRnZXgq0GFuWXmc8mRG9oee@nongnu.org
X-Gm-Message-State: AOJu0YxCwajd87yc1gDKOxQSzpfrBIhkecoNOiWKHLFIAej8nHnBZjpf
 p7+teAi8tKbueeemTPzEr+YOnq5K3qsfazaDXjBeIDrq6iqjBcOu+rWe
X-Gm-Gg: ATEYQzzWop9L50ajzAiO+f3++Lyc+zxQn3dsPk8SgmERe3UYEWVuUC3EqwVJ78fU3Kw
 088h4efvuAg5hQuH/9t2fKwxbo5SEwwpzAyCud7mmLhIMTzhDbCOylh+DeomSr1g8oekKV5pP1d
 KcrpGl4mkeivdXA4S7GDf2ctdkOt5CPqNNCncJj3eALAugOfAR+oMVpH7gRllH87awzIXLhte5I
 2QohjNtcOFlyU5CZLNbFijxqRqfo7D+/r/fhvIkX1/4fPiDvQJSBSN3iyGOF7iRsP5zF1v+/hKO
 I/WDXVP7IT/ZBZfAaVPxf2vt/aKrFB5uBMfal6LU4r9xPwMH2b3q2JdYbKI9B/WZ3nxneTgZsUU
 nk+EkJ3rGQKdZzNv7cgsFLIdU9qWkk4PGlN/O5hkxkxc8+QiGO1jOq2pceFCz5q393qXMqv+DXq
 kCQoYP3INnEERT8lqdhrthDH8a1cBs3dlFCcS1cUDMdKUezeFotZ0jwJ2h2uHTHJqxbR09fsm7x
 5loJk/Lnyvo8q0tLEKE0LRADJw=
X-Received: by 2002:a05:7301:2b08:b0:2b7:f28d:c8c1 with SMTP id
 5a478bee46e88-2be4dd6b838mr2879681eec.0.1772954307669; 
 Sat, 07 Mar 2026 23:18:27 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:26 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 00/28] RISC-V Debug Module support
Date: Sun,  8 Mar 2026 15:17:03 +0800
Message-ID: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds a RISC-V Debug Module model and wires it into
target/riscv and the virt machine.

It depends on two earlier patch sets:
- Max's Zvfbfa v5 series, which introduces the EXT_TB flags
  mechanism reused here;
- the Sdext debug extension v5 series, which adds the base
  debug-mode support that this series builds on.

The architectural reference for this work is the RISC-V Debug
Specification v1.0 (ratified 2025-02-21):

  https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

The implementation takes design cues from spike's debug module.
The focus is the Debug Module itself and the execution-based
debug flow around it. In practice, this means:

- target/riscv gains the plumbing needed to keep a hart in Debug
  Mode while it executes from a DM ROM, and to route haltreq,
  reset-haltreq, single-step completion, ebreak, exceptions, and
  trigger-based debug entry through that ROM flow;
- hw/riscv gains a QOM Debug Module device with a DMI-style MMIO
  window, a ROM work area, per-hart state tracking, run-control,
  abstract register access, and system bus access;
- virt wires CPUs to the DM and exposes a stable layout for the
  DMI window and ROM alias;
- qtest adds both protocol-level coverage and TCG-backed
  execution tests for the full bring-up path on rv32 and rv64.

The series intentionally focuses on board-visible DM behavior.
It does not add a JTAG DTM frontend, authentication, or other
transport-side pieces. The result is a usable DM model for virt,
with enough target-side support to exercise the main spec-driven
debug flows and enough qtest coverage to keep the behavior
regression-resistant.

Current implementation status:

+-------------------+---------+---------+---------------------------+
| Area              | Req/Opt | Status  | Notes                     |
+-------------------+---------+---------+---------------------------+
| Debug entry       | req     | done    | haltreq, reset-haltreq,   |
|                   |         |         | ebreak, step, exceptions, |
|                   |         |         | triggers                  |
+-------------------+---------+---------+---------------------------+
| DM device         | req     | done    | riscv-dm QOM, DMI MMIO,   |
|                   |         |         | ROM work area, reset      |
+-------------------+---------+---------+---------------------------+
| Hart state        | req     | done    | halted, resumeack,        |
|                   |         |         | havereset, haltsum0/1,    |
|                   |         |         | hart selection            |
+-------------------+---------+---------+---------------------------+
| Run-control       | req     | done    | haltreq, resumereq,       |
|                   |         |         | hartreset, ndmreset,      |
|                   |         |         | reset-haltreq             |
+-------------------+---------+---------+---------------------------+
| Abstract cmds     | req     | done    | Access Register           |
|                   |         |         | (GPR/CSR/FPR), DATA,      |
|                   |         |         | PROGBUF, ABSTRACTAUTO     |
+-------------------+---------+---------+---------------------------+
| SBA               | opt     | done    | SBCS, SBADDRESS, SBDATA,  |
|                   |         |         | sticky errors, auto-inc   |
+-------------------+---------+---------+---------------------------+
| virt wiring       | --      | done    | DM address map, CPU       |
|                   |         |         | hookup, ROM propagation   |
+-------------------+---------+---------+---------------------------+
| ndmreset scope    | req     | partial | resets harts only, not    |
|                   |         |         | other devices             |
+-------------------+---------+---------+---------------------------+
| haltsum2/3        | opt     | stub    | present but read zero;    |
|                   |         |         | only for >1024 harts      |
+-------------------+---------+---------+---------------------------+
| Quick Access      | opt     | no      | cmdtype=1                 |
+-------------------+---------+---------+---------------------------+
| Access Memory     | opt     | no      | cmdtype=2                 |
+-------------------+---------+---------+---------------------------+
| DTM / JTAG        | opt     | no      | transport-side, outside   |
|                   |         |         | this series               |
+-------------------+---------+---------+---------------------------+
| Authentication    | opt     | no      | authdata absent;          |
|                   |         |         | authenticated=1           |
+-------------------+---------+---------+---------------------------+
| Hart/resume       | opt     | no      | dmcs2 absent, no group    |
| groups            |         |         | halt/resume               |
+-------------------+---------+---------+---------------------------+
| External triggers | opt     | no      | DM ext-trigger I/O not    |
|                   |         |         | wired                     |
+-------------------+---------+---------+---------------------------+
| keepalive         | opt     | no      | set/clrkeepalive ignored  |
+-------------------+---------+---------+---------------------------+
| ackunavail /      | opt     | no      | sticky unavail not        |
| stickyunavail     |         |         | tracked                   |
+-------------------+---------+---------+---------------------------+
| confstrptr        | opt     | stub    | always 0                  |
+-------------------+---------+---------+---------------------------+
| Multi-DM/nextdm   | opt     | stub    | always 0, single DM only  |
+-------------------+---------+---------+---------------------------+
| 128-bit access    | opt     | no      | aarsize=4, sbaccess128    |
+-------------------+---------+---------+---------------------------+
| Custom registers  | opt     | no      | regno 0xC000-0xFFFF       |
+-------------------+---------+---------+---------------------------+
| Cmds on running   | opt     | no      | abstract cmds require     |
| harts             |         |         | halted hart               |
+-------------------+---------+---------+---------------------------+
| Sub-word reg      | opt     | no      | aarsize 8/16-bit not      |
| access            |         |         | supported                 |
+-------------------+---------+---------+---------------------------+

The main design choice is to follow the execution-based Debug
Module model described by the spec: the hart stays in Debug Mode,
enters a ROM park loop, and the DM coordinates state changes and
abstract command execution through mailbox words and generated
ROM snippets. This keeps the DM behavior explicit in the machine
model and avoids inventing a separate QEMU-only debug protocol.

The patches are split into three layers:
- patches 1-14 build the target/riscv side of the ROM-based
  Debug Mode flow and make trigger-driven stops preserve the
  right cause information;
- patches 15-23 add the Debug Module device model, per-hart
  state tracking, run-control, register infrastructure, abstract
  commands, system bus access, and virt integration;
- patches 24-28 add qtest coverage for the DMI register surface
  and the TCG execution paths.

This series is also expected to help advance rvsp-ref machine
support, since Sdext is a required instruction extension for
rvsp-soc.

Thanks Tao Tang for running CI on this series:

  https://gitlab.com/TaoTang/qemu/-/pipelines/2370872174

The resulting series has been validated with:
- `TMPDIR=/tmp QTEST_QEMU_BINARY=./build/qemu-system-riscv32 \
   ./build/tests/qtest/riscv-dm-test`
- `TMPDIR=/tmp QTEST_QEMU_BINARY=./build/qemu-system-riscv64 \
   ./build/tests/qtest/riscv-dm-test`

Thanks,
Chao


Chao Liu (28):
  target/riscv: track pending Debug Module halt requests
  target/riscv: keep Debug Mode active when a DM ROM is present
  target/riscv: enter Debug Mode from pending DM halt requests
  target/riscv: route in-debug exceptions back to the DM ROM
  target/riscv: re-enter the DM ROM after single-step completion
  target/riscv: let ebreak enter the DM ROM
  target/riscv: restart the DM ROM on debug-mode ebreak
  target/riscv: track the exact breakpoint trigger hit
  target/riscv: track the exact watchpoint trigger hit
  target/riscv: send trigger debug-mode actions to the DM ROM
  target/riscv: suppress itrigger TB state in Debug Mode
  target/riscv: tighten itrigger privilege and count checks
  target/riscv: allow debug-mode actions for itrigger
  target/riscv: stop consuming itrigger counts in Debug Mode
  hw/riscv: add an initial Debug Module device model
  hw/riscv/dm: track per-hart debug state
  hw/riscv/dm: add hart run-control operations
  hw/riscv/dm: queue reset halts from the reset work item
  hw/riscv/dm: add DMI register declarations and ROM entry program
  hw/riscv/dm: add register handlers and update state management
  hw/riscv/dm: add abstract command execution
  hw/riscv/dm: add system bus access
  hw/riscv/virt: integrate the Debug Module
  tests/qtest: add initial RISC-V Debug Module tests
  tests/qtest: extend DM register semantics coverage
  tests/qtest: add DM abstract command and halt/resume tests
  tests/qtest: add DM TCG halt and register access tests
  tests/qtest: add DM TCG single-step and trigger tests

 MAINTAINERS                 |    1 +
 hw/riscv/Kconfig            |    5 +
 hw/riscv/dm.c               | 2017 +++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build        |    2 +
 hw/riscv/trace-events       |   14 +
 hw/riscv/virt.c             |   21 +-
 include/hw/riscv/dm.h       |  139 +++
 target/riscv/cpu.c          |   68 ++
 target/riscv/cpu.h          |    8 +
 target/riscv/cpu_bits.h     |    1 +
 target/riscv/cpu_helper.c   |   60 +-
 target/riscv/debug.c        |  249 ++---
 target/riscv/machine.c      |    2 +
 target/riscv/op_helper.c    |   15 +
 target/riscv/tcg/tcg-cpu.c  |   12 +-
 tests/qtest/meson.build     |    7 +-
 tests/qtest/riscv-dm-test.c | 1914 +++++++++++++++++++++++++++++++++
 17 files changed, 4410 insertions(+), 125 deletions(-)
 create mode 100644 hw/riscv/dm.c
 create mode 100644 include/hw/riscv/dm.h
 create mode 100644 tests/qtest/riscv-dm-test.c

--
2.53.0


