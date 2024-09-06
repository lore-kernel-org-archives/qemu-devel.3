Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D926CCE7B1C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 14:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sma24-0000Ml-E4; Fri, 06 Sep 2024 10:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma22-0000Ls-8n
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:50 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sma20-00072w-EN
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 10:33:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2068acc8b98so19088995ad.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725633226; x=1726238026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KALXkPBTxGDivGnQNyPwRC48F/CKpmU8ry/zplz06X0=;
 b=WQX5ip4be6JTokNNtXAr65elSuNv5UgIJKjT04F3rr6+vf19BoT+8R1ARjWjbVvC8P
 RYswxPQEUbTPXv/X1Hb5A0BWN5wUwU1Bn56/9T31Xzv0u60gPww0h3IMno0TRNarxYTG
 agrr7DIT6EVqp1CmF561j25FQWQ8zbffmMsem4zWpzcPIjx+HHSjfHRpeAzreP+8Ozxa
 2qWTwMipbiQPJQqFuU+YYX63Ps/DZvAKNlIV+C4InT/UxQ6spaHhow5TumE6pK4NlkYD
 IjEh+xUA8aDwZcHtMiBzrODd4qpE6RZ/zbgjIz0++TB4JzLC+I1nEVlUNXnlUWILDGkN
 zePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725633226; x=1726238026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KALXkPBTxGDivGnQNyPwRC48F/CKpmU8ry/zplz06X0=;
 b=TqLU5a1iZPM6GH5DhCoww52yxMcCc/mi+8/8LiNUq+kB/h8PnwYgR1hisnMZ69H/Jm
 OIos7yvZInJmWMQs82M3cZh3CrZi/IBu660VDnpQFCZbHvOl4Yv0heZXn81LAKvxH4J9
 cCiydNx1DFzwLTYG/Y6lt6cTxNQ56nZ9UGtzP7YDvughQRNUusvuq6xcgCmIQNFmGOY1
 7c5J/Y9ZROqrlZaZd5RoWa+5aLZ7XzCv8LM3sZ9RumvC/srB2WMgxgr0jZYRU/kXFvBC
 jk1Gb+GT6zHsJwHIy0w/A/r7UUZbZTMh1K7AW7bWHLUBoJjEwRcW1DXrFOOVxWaTM+D9
 7uIw==
X-Gm-Message-State: AOJu0Yy6/ntTIrw6CsvPlopcUyW9XHl1XDF9bFjBNi3J8+at7jrdfoEY
 eeCI0+/vNUdTHSVvP01xdPbQNeQKsI7fCGzO37aW5OCIGjRz2KtTf50eoa/pqVoaCi4DpqP4Tbb
 a
X-Google-Smtp-Source: AGHT+IF85gMz0CJusqrJfNBOsYauNPSXJCMqSplkpUly6GK5IE3pPsbuBj+XKeURLTYvWAAtt9P2uA==
X-Received: by 2002:a17:902:da88:b0:205:8407:631d with SMTP id
 d9443c01a7336-20584076603mr164499205ad.13.1725633226172; 
 Fri, 06 Sep 2024 07:33:46 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:42a1:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206ae913cf1sm43844425ad.28.2024.09.06.07.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 07:33:45 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v4 0/5] gdbstub: Add support for MTE in system mode
Date: Fri,  6 Sep 2024 14:33:11 +0000
Message-Id: <20240906143316.657436-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62f.google.com
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

This patchset makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode, resolving:

https://gitlab.com/qemu-project/qemu/-/issues/620

For running the tests, a GDB that supports MTE for baremetal targets is
necessary. This support has just landed GDB's master branch.

GDB can be built and installed into a /tmp directory in a simple way:
after cloning GDB's master branch, inside a build directory, configure
GDB and build it:

 $ git clone --depth 1 https://sourceware.org/git/binutils-gdb.git --branch master gdb_master && cd gdb_master
 $ mkdir build && cd build
 $ ../configure --disable-binutils --disable-ld --disable-gold --disable-gas --disable-sim --disable-gprof --disable-gprofng --with-python=python3 --enable-libctf --enable-unit-tests --prefix=/tmp/gdb --with-additional-debug-dirs=/usr/lib/debug --enable-targets=all
 $ make -j 32
 $ make install

Configure QEMU, specifying where GDB is installed. For example:

 $ cd build
 $ ../configure --target-list=aarch64-linux-user,aarch64-softmmu --disable-docs --gdb=/tmp/gdb/bin/gdb
 $ make -j 32
 $ cd..

And finally run the MTE gdbstub tests for QEMU system mode:

 $ make -C build -j 32 run-tcg-tests-aarch64-softmmu

v2:
 - Use of cpu_mmu_index() instead of arm_mmu_idx() (Richard's review)
 - Converted mte.c test to mte.S
 - Set tcr_el1, mair_el1, and sctlr_el1 in mte.S instead of in boot.S
   (Richard's review) 
 - Allowed use of argparse in test scripts to get passed arguments from
   run-test.py (Alex's review)
 - Fixed test output to be stored in run-gdbstub-mte.out instead of
   printed to stdout
 - Added detection of GDB supporting MTE in baremetal
 
v3:
 - No need of ARM_MMU_IDX_COREIDX_MASK with cpu_mmu_index()
   (Richard's review)
 - Define a symbol for mte_page instead of a whole section
   (Richard's review)

v4:
 - Better representation for MiB using M suffix in linker script
   (Phil's review)
 - Improve linker script organization (Richard's review)


Cheers,
Gustavo

Gustavo Romero (5):
  gdbstub: Use specific MMU index when probing MTE addresses
  gdbstub: Add support for MTE in system mode
  tests/guest-debug: Support passing arguments to the GDB test script
  tests/tcg/aarch64: Improve linker script organization
  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 configure                                 |   5 +
 target/arm/gdbstub64.c                    |  21 +++--
 tests/guest-debug/run-test.py             |   6 ++
 tests/guest-debug/test_gdbstub.py         |   5 +
 tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
 tests/tcg/aarch64/system/boot.S           |  11 +++
 tests/tcg/aarch64/system/kernel.ld        |  33 ++++---
 tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
 10 files changed, 266 insertions(+), 47 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.S

-- 
2.34.1


