Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BBFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcIM-00031f-1b; Mon, 24 Jun 2024 01:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIK-000318-TJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:12 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLcIH-0004XD-4o
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:31:12 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7eb5dd9f994so140878439f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719207067; x=1719811867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6qMIabyzReTYtnz2ctTAi3uRfHEGT9rkNoJ1Jc8AvYQ=;
 b=Q11as8q7GFmEAgknALcRIRzJLZCpTyzq1g4p2mmd50OetEnGVIyquk0HdeueCyc+uI
 u11zonqPuTZg0VqhHKLlf3+bF4WsS4COQdSD6yMACKtLuiNH2psahBodthmE6MEIiqAC
 4ensQ50+ewyWHlPqaVnRWCvfJI55YDSNmUQqOBduoLcmhNdzO+Q45HN069Q6fMurxATr
 1w++xvt0OutRFz7PiO6sYU9WrmooQdKw9EKdst5Gda2p9MjFN1KhdVmwhsk+jYiqwfSN
 rzQYhellXUL1NS73H9QLvA3bG5tx8ZXjpeDxvYIPnX7W+h45uHPNPHysTb4vbeiJ0b7B
 oJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207067; x=1719811867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qMIabyzReTYtnz2ctTAi3uRfHEGT9rkNoJ1Jc8AvYQ=;
 b=tkU/gh8tc1jBpFSZxyGEERz5Ht4c9Q3T5lbejP/sZkrNh2dYNNsbcQZ2H6w5LxJWD2
 or63PpqklJc2FfzMtytZdZdSDD8l/iXNvQpYUyW0ZJXs0e6at606STTd6AfA/Z/kD20H
 ArnSfwlHwnU7Ar6fMTUr0r2bZftGm9daG7DsNE4fuIURMsGPy4RBhGVz+U1gI/Ak4cMT
 6djH/gGtGLWIq6VI+VMgbn3i6j3cF3h04LJeSrIVoQSenb5vN5983wu2L5xsY3kRIMZo
 JYg40R24QuevtUc1Io+eRhZoWSRq8VQKXkZbC1EwrkQHZsuiwYCg88u4uLBSmtOVgc5d
 eWTw==
X-Gm-Message-State: AOJu0Yz29XYtvHBQpyQtiSP6d579QKmKP9D+8Zg+L0y8mleZbnjb+2wu
 4yCpc44b31B5Iol1UTlmQhEl9+TSqmS09kVy6Pm5y6uy/adSC4T54h+VR5K6YJPuGloOn85b+GF
 b
X-Google-Smtp-Source: AGHT+IGhRiRfqMI3WNgIxJM5hu7JMrZqJ61dJXYTVNRTWksM/S13swfIE7hW/HfhkXZ/1HYpo8Oztw==
X-Received: by 2002:a05:6e02:b47:b0:376:3e9c:d9a8 with SMTP id
 e9e14a558f8ab-3763e9cddffmr46035665ab.9.1719207066997; 
 Sun, 23 Jun 2024 22:31:06 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a73183sm3953601a12.39.2024.06.23.22.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 22:31:06 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 0/9] Add MTE stubs for aarch64 user mode
Date: Mon, 24 Jun 2024 05:30:37 +0000
Message-Id: <20240624053046.221802-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-io1-xd36.google.com
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
 
v3:
 - Moved stubs to gdbstub64.c
 - Fixed build for BSD target
 - Fixed license tags in the new header files
 - Use of only function prototypes in mte_helpers.h
 - Added prefix to arm_set_mte_tcf0 and marked it inline
 - Moved target/arm/mte.h -> target/arm/tcg/mte_user_helper.h
 - Cleaned up leftover in mte-8 test
 
v4:
 - Don't run tests when GDB < 15 (i.e., lacks most recent MTE changes) (Alex's review)
 - Added g_assert()s in new gdb_extend_* API functions to ensure all CPUs have the same features/query/set tables (Alex's review)
 - Move load_tag1 and store_tag1 to mte_helpers.h marking them as "static inline" (Richard's review)
 - Move mte_user_helper.h to linux-user/aarch64/ and include it from gdbstub64.c (Richard's review)


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
 configure                              |  11 ++
 gdb-xml/aarch64-mte.xml                |  11 ++
 gdbstub/gdbstub.c                      | 254 +++++++++++++++----------
 gdbstub/internals.h                    |  24 ---
 gdbstub/syscalls.c                     |   7 +-
 gdbstub/system.c                       |   7 +-
 gdbstub/user-target.c                  |  25 +--
 gdbstub/user.c                         |   7 +-
 include/exec/gdbstub.h                 |   5 +
 include/gdbstub/commands.h             | 102 ++++++++++
 linux-user/aarch64/mte_user_helper.h   |  38 ++++
 linux-user/aarch64/target_prctl.h      |  22 +--
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   |  46 +++++
 target/arm/gdbstub64.c                 | 219 +++++++++++++++++++++
 target/arm/internals.h                 |   6 +
 target/arm/tcg/mte_helper.c            |  57 +-----
 target/arm/tcg/mte_helper.h            |  74 +++++++
 tests/tcg/aarch64/Makefile.target      |  14 +-
 tests/tcg/aarch64/gdbstub/test-mte.py  |  86 +++++++++
 tests/tcg/aarch64/mte-8.c              |  98 ++++++++++
 22 files changed, 900 insertions(+), 216 deletions(-)
 create mode 100644 gdb-xml/aarch64-mte.xml
 create mode 100644 include/gdbstub/commands.h
 create mode 100644 linux-user/aarch64/mte_user_helper.h
 create mode 100644 target/arm/tcg/mte_helper.h
 create mode 100644 tests/tcg/aarch64/gdbstub/test-mte.py
 create mode 100644 tests/tcg/aarch64/mte-8.c

-- 
2.34.1


