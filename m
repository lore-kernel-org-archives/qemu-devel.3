Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1892C27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8g-0000c1-0E; Thu, 13 Jun 2024 13:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8f-0000bj-8Y
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sHo8d-0005ky-I6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:29 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f6f031549bso12450715ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718299285; x=1718904085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I149T4C+5ssCOKtt/AFJ3NZCnAND2yp6hqtNiSQOCGI=;
 b=Qm2OHirJqY4aCKYS7fNk3avopa4efWDIMBxqcjGE+WroRjAInpDWUn6CIWjWcAhduu
 qgOlEsqmOmRPhalTvuJmSZXaMC71vfpvqyewzim6d14cT4u6r1ASBHhPouAd15mINXkz
 IXWOS/6lhbCPPuTcC0WZcPINLCCnmVXqzvuEKd0TtYsKas4B2SQUFvkZ3rDEhFOshM2H
 KcU5jFrcx//nymbYU4I+8aurJKTGo4BkP+cWWdhN8vLY5Jzvu3lszFbSwgSd3q3L0k1I
 batDJHdflkYvEWWmDGeHPe19v8qQ2Ck9fpCqPLoT/D7/lTiY4PzjwKnSGtAjUs4ouwaJ
 kr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718299285; x=1718904085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I149T4C+5ssCOKtt/AFJ3NZCnAND2yp6hqtNiSQOCGI=;
 b=vW0UT59idLPV6oIaHlx51u0NjSUP1VOcCny7oQYaWyoG6j9wzRKqikGRGvX6u2DcIu
 7G/8omqaiEq5w+jitEaVLxbxp5Zi/G7h6wy3zJH4xaF+0HNboihmT6UcZSeK2Dvvudyx
 3iOrISgZ8jx0UeOw+uz2+NvMSCdBJpDoaXdvWY+itcuvLZOkKF/x+6aOMaBdaFzKo/6/
 LJwyRYib8Y/m5Nj77vtKdbH4EMQAjtEoHYJB6M+3Dd/MG/VkR9RMNo8+p25oxnULHtcy
 995K6mqq3PvjWJII7g+3fxKHKaZKqbrTDNbWE8hmlYUjyAUmxIoy7chE/H6X9dFMW945
 xFaQ==
X-Gm-Message-State: AOJu0Yz89NEhZROGfBwzxTBQiGUb07CRTo2IK8CllcPt7TZLRdegz+Tf
 xgfaa0/JZ2GJOsEv1G+7G14BC1Gt3y3xDrBtImodXxd13Zbp0ChY4Aav23oxySpGkFnekwssUcX
 I
X-Google-Smtp-Source: AGHT+IFoBRalF436LQCFctQmx5g0YUfmo7KwyddkjeYWcLZRfZwB+HWtFymw97OjFrkEEHPAydYm7w==
X-Received: by 2002:a17:903:32d2:b0:1f7:234b:4f3d with SMTP id
 d9443c01a7336-1f8627e193cmr3907785ad.39.1718299284876; 
 Thu, 13 Jun 2024 10:21:24 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:8dcb:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm16443885ad.32.2024.06.13.10.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 10:21:24 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: gustavo.romero@linaro.org
Subject: [PATCH v2 0/9] Add MTE stubs for aarch64 user mode
Date: Thu, 13 Jun 2024 17:20:54 +0000
Message-Id: <20240613172103.2987519-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This patchset adds the stubs necessary to support GDB memory tagging
commands on QEMU aarch64 user mode.

These new stubs handle the qIsAddressTagged, qMemTag, and QMemTag
packets, which allow GDB memory tagging subcommands 'check',
'print-allocation-tag', and 'set-allocation-tag' to work. The remaining
memory tagging commands ('print-logical-tag' and 'with-logical-tag')
will also work, but they don't rely on any stub because they perform
local operations.

Since the memory tagging stubs are not common to all architectures, this
patchset also introduces three functions: gdb_extend_qsupported_features,
gdb_extend_query_table, and gdb_extend_set_table. These functions can be
used to extend the target-specific 'qSupported' feature string and the
handlers for the 'q' (query) and 'Q' (set) packets. These new functions
are used to add the MTE stubs for the aarch64 gdbstub.
 
Note that this patchset requires a GDB that supports the
qIsAddressTagged packet (recently added to GDB), so the gdbstub MTE
tests introduced by it must be run using GDB's master branch, since the
GDB in the distros hasn't picked up the change yet.

Once GDB is built and installed locally, the tests can be exercised, for
example, this way:

make GDB=~/.local/bin/gdb run-tcg-tests-aarch64-linux-user -j 32

v2:
 - Addressed comments from Richard, Phil, and Alex
 - Made the series more granular by splitting it into more patches
 - Moved gdbstub command-specific structs and functions into a new header, gdbstub/commands.h
 - Fixed exception in allocation_tag_mem_probe()
 - Used MTE helpers ({store,load}_tag1 and allocation_tag_mem_probe) in the MTE stubs
 - Factored out MTE code to set TCF0, avoiding duplication (both prctl and gdbstub code use it)
 - Hoisted sscanf() out of loop in handle_Q_memtag stub and use gdb_hextomem instead
 - Rebased this series on Alex's gdb/next branch


Cheers,
Gustavo

Gustavo Romero (9):
  gdbstub: Clean up process_string_cmd
  gdbstub: Move GdbCmdParseEntry into a new header file
  gdbstub: Add support for target-specific stubs
  target/arm: Fix exception case in allocation_tag_mem_probe
  target/arm: Make some MTE helpers widely available
  target/arm: Factor out code for setting MTE TCF0 field
  gdbstub: Make get cpu and hex conversion functions non-internal
  gdbstub: Add support for MTE in user mode
  tests/tcg/aarch64: Add MTE gdbstub tests

 configs/targets/aarch64-linux-user.mak |   2 +-
 gdb-xml/aarch64-mte.xml                |  11 ++
 gdbstub/gdbstub.c                      | 211 +++++++++++----------
 gdbstub/internals.h                    |  24 ---
 gdbstub/syscalls.c                     |   7 +-
 gdbstub/system.c                       |   7 +-
 gdbstub/user-target.c                  |  25 +--
 gdbstub/user.c                         |   7 +-
 include/exec/gdbstub.h                 |   5 +
 include/gdbstub/commands.h             | 102 ++++++++++
 linux-user/aarch64/target_prctl.h      |  22 +--
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   | 253 +++++++++++++++++++++++++
 target/arm/internals.h                 |   2 +
 target/arm/mte.h                       |  53 ++++++
 target/arm/tcg/mte_helper.c            | 181 +-----------------
 target/arm/tcg/mte_helper.h            | 211 +++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target      |  11 +-
 tests/tcg/aarch64/gdbstub/test-mte.py  |  86 +++++++++
 tests/tcg/aarch64/mte-8.c              | 102 ++++++++++
 20 files changed, 975 insertions(+), 348 deletions(-)
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 target/arm/mte.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

-- 
2.34.1


