Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C655CC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpco-0000fM-TF; Tue, 30 Jul 2024 12:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcn-0000YZ-1I
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:57 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpci-0003Zk-Sj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:56 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52f04c29588so8631011e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356571; x=1722961371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pT3wxysinP1/vqZhzz3VG4XyPoJuCBoPuep2wbRBO8w=;
 b=W+ouXKcvLChFzxtAVpv6ujlJCxLf3CUlvMwy/UYUXKzM9zxzelnCC2tEo8IDMavEW8
 530P5HUAoOh1PhXcvGVs+UGxmIQNzMOeuoAkQZOlPx9/3UeWWh45LpNrE+FuQmwGcDA4
 Hortf/RCGLu4tTj28HEV3dK6+THAQ6OIlWbbytpyJgjY24MzituPsaJnlVZLzdaSng5p
 9EQhQwPduNeo8gKON9US7TgP9fltY1Im+ALTUKQoQdhEtCeQ//7YN4OTrjEZU6tus1m8
 QWvW+4eUyrTihdJuGcEZBz9t5gsm9wBQTST6I6SJ1sfE/vGXd5/0GzySi7fTYemFR6xC
 0QZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356571; x=1722961371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pT3wxysinP1/vqZhzz3VG4XyPoJuCBoPuep2wbRBO8w=;
 b=NhvHXU5/g6xMuXA8fDAEN5Nxb/bYOGuK9ZHSdBhn9kXE9PfWHW4B+hP84X3jWo7EO7
 AhSS6z6DgrjvO7cjyOy0PZP51fy6cfck49Ua0rp0vODiJMba2KTnl6/mD0GSiRnbSadl
 m0t93075Yhg9qrobb2ByQ4YJhuvUhXlLJ4ZzyLl2yVcDKaw5YC4oi02BLyWCK+FqwVRz
 UO7NsugW50r/e4SnfXtFRsdygkoZFZVFyzHK81iLOgfPdOkthR+DAqVAPFsQayQUuwkz
 hk/LE97H2geLK+Ndu8isoWMwtjB+KfUVi5mRlXoO8Sz9I2Y/o3q7fv2vYgM0XE63SsyV
 dI2A==
X-Gm-Message-State: AOJu0Yz74+/ZJdlfSZ4NgLbW9ipQNGOjKJWOFHQJrWi7iZmQRKkN+GrA
 5rEimprWH6V8eaxMR9WgjhUi5Acdid4FHAlkcyZopPdxrQ85ug6/mc45kqnG814=
X-Google-Smtp-Source: AGHT+IEZhyi194Demoa/E7n3meFMW/oNuIYxRajP7klPTWQTZj+iut+xtXTt81udSoSRKrXecPcmTw==
X-Received: by 2002:a19:5f42:0:b0:52f:cdb0:11c0 with SMTP id
 2adb3069b0e04-5309b279e5cmr6089892e87.21.1722356570521; 
 Tue, 30 Jul 2024 09:22:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90130sm673004366b.144.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB2185FA08;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/14] docs: split TCG plugin usage from devel section
Date: Tue, 30 Jul 2024 17:22:33 +0100
Message-Id: <20240730162237.1425515-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

The devel section is getting quite messy with the breakdown of the
example plugins which should be usable by users. As we mention plugins
in the emulation section along with semihosting move the overview
there leaving the development section about the details of writing
plugins.

While we are at make the headings nicer and convert the option lists
into nicely formatted tables.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-11-alex.bennee@linaro.org>

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3bfe8cc14a..c03033e4e9 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -95,9 +95,6 @@ depending on the guest architecture.
     - Yes
     - A configurable 32 bit soft core now owned by Cadence
 
-A number of features are only available when running under
-emulation including :ref:`Record/Replay<replay>` and :ref:`TCG Plugins`.
-
 .. _Semihosting:
 
 Semihosting
@@ -182,3 +179,567 @@ for that architecture.
   * - Xtensa
     - System
     - Tensilica ISS SIMCALL
+
+TCG Plugins
+-----------
+
+QEMU TCG plugins provide a way for users to run experiments taking
+advantage of the total system control emulation can have over a guest.
+It provides a mechanism for plugins to subscribe to events during
+translation and execution and optionally callback into the plugin
+during these events. TCG plugins are unable to change the system state
+only monitor it passively. However they can do this down to an
+individual instruction granularity including potentially subscribing
+to all load and store operations.
+
+See the developer section of the manual for details about
+:ref:`writing plugins<TCG Plugins>`.
+
+Usage
+~~~~~
+
+Any QEMU binary with TCG support has plugins enabled by default.
+Earlier releases needed to be explicitly enabled with::
+
+  configure --enable-plugins
+
+Once built a program can be run with multiple plugins loaded each with
+their own arguments::
+
+  $QEMU $OTHER_QEMU_ARGS \
+      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
+      -plugin contrib/plugin/libhotblocks.so
+
+Arguments are plugin specific and can be used to modify their
+behaviour. In this case the howvec plugin is being asked to use inline
+ops to count and break down the hint instructions by type.
+
+Linux user-mode emulation also evaluates the environment variable
+``QEMU_PLUGIN``::
+
+  QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
+
+Example Plugins
+~~~~~~~~~~~~~~~
+
+There are a number of plugins included with QEMU and you are
+encouraged to contribute your own plugins plugins upstream. There is a
+``contrib/plugins`` directory where they can go. There are also some
+basic plugins that are used to test and exercise the API during the
+``make check-tcg`` target in ``tests/tcg/plugins`` that are never the
+less useful for basic analysis.
+
+Empty
+.....
+
+``tests/tcg/plugins/empty.c``
+
+Purely a test plugin for measuring the overhead of the plugins system
+itself. Does no instrumentation.
+
+Basic Blocks
+............
+
+``tests/tcg/plugins/bb.c``
+
+A very basic plugin which will measure execution in coarse terms as
+each basic block is executed. By default the results are shown once
+execution finishes::
+
+  $ qemu-aarch64 -plugin tests/plugin/libbb.so \
+      -d plugin ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  bb's: 2277338, insns: 158483046
+
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Basic Block plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter. Not per-cpu and not
+      thread safe.
+  * - idle=true|false
+    - Dump the current execution stats whenever the guest vCPU idles
+
+Instruction
+...........
+
+``tests/tcg/plugins/insn.c``
+
+This is a basic instruction level instrumentation which can count the
+number of instructions executed on each core/thread::
+
+  $ qemu-aarch64 -plugin tests/plugin/libinsn.so \
+      -d plugin ./tests/tcg/aarch64-linux-user/threadcount
+  Created 10 threads
+  Done
+  cpu 0 insns: 46765
+  cpu 1 insns: 3694
+  cpu 2 insns: 3694
+  cpu 3 insns: 2994
+  cpu 4 insns: 1497
+  cpu 5 insns: 1497
+  cpu 6 insns: 1497
+  cpu 7 insns: 1497
+  total insns: 63135
+
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Instruction plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
+  * - sizes=true|false
+    - Give a summary of the instruction sizes for the execution
+  * - match=<string>
+    - Only instrument instructions matching the string prefix
+
+The ``match`` option will show some basic stats including how many
+instructions have executed since the last execution. For
+example::
+
+   $ qemu-aarch64 -plugin tests/plugin/libinsn.so,match=bl \
+       -d plugin ./tests/tcg/aarch64-linux-user/sha512-vector
+   ...
+   0x40069c, 'bl #0x4002b0', 10 hits, 1093 match hits, Δ+1257 since last match, 98 avg insns/match
+   0x4006ac, 'bl #0x403690', 10 hits, 1094 match hits, Δ+47 since last match, 98 avg insns/match
+   0x4037fc, 'bl #0x4002b0', 18 hits, 1095 match hits, Δ+22 since last match, 98 avg insns/match
+   0x400720, 'bl #0x403690', 10 hits, 1096 match hits, Δ+58 since last match, 98 avg insns/match
+   0x4037fc, 'bl #0x4002b0', 19 hits, 1097 match hits, Δ+22 since last match, 98 avg insns/match
+   0x400730, 'bl #0x403690', 10 hits, 1098 match hits, Δ+33 since last match, 98 avg insns/match
+   0x4037ac, 'bl #0x4002b0', 12 hits, 1099 match hits, Δ+20 since last match, 98 avg insns/match
+   ...
+
+For more detailed execution tracing see the ``execlog`` plugin for
+other options.
+
+Memory
+......
+
+``tests/tcg/plugins/mem.c``
+
+Basic instruction level memory instrumentation::
+
+  $ qemu-aarch64 -plugin tests/plugin/libmem.so,inline=true \
+      -d plugin ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  inline mem accesses: 79525013
+
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Memory plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter
+  * - callback=true|false
+    - Use callbacks on each memory instrumentation.
+  * - hwaddr=true|false
+    - Count IO accesses (only for system emulation)
+
+System Calls
+............
+
+``tests/tcg/plugins/syscall.c``
+
+A basic syscall tracing plugin. This only works for user-mode. By
+default it will give a summary of syscall stats at the end of the
+run::
+
+  $ qemu-aarch64 -plugin tests/plugin/libsyscall \
+      -d plugin ./tests/tcg/aarch64-linux-user/threadcount
+  Created 10 threads
+  Done
+  syscall no.  calls  errors
+  226          12     0
+  99           11     11
+  115          11     0
+  222          11     0
+  93           10     0
+  220          10     0
+  233          10     0
+  215          8      0
+  214          4      0
+  134          2      0
+  64           2      0
+  96           1      0
+  94           1      0
+  80           1      0
+  261          1      0
+  78           1      0
+  160          1      0
+  135          1      0
+
+Hot Blocks
+..........
+
+``contrib/plugins/hotblocks.c``
+
+The hotblocks plugin allows you to examine the where hot paths of
+execution are in your program. Once the program has finished you will
+get a sorted list of blocks reporting the starting PC, translation
+count, number of instructions and execution count. This will work best
+with linux-user execution as system emulation tends to generate
+re-translations as blocks from different programs get swapped in and
+out of system memory.
+
+If your program is single-threaded you can use the ``inline`` option for
+slightly faster (but not thread safe) counters.
+
+Example::
+
+  $ qemu-aarch64 \
+    -plugin contrib/plugins/libhotblocks.so -d plugin \
+    ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  collected 903 entries in the hash table
+  pc, tcount, icount, ecount
+  0x0000000041ed10, 1, 5, 66087
+  0x000000004002b0, 1, 4, 66087
+  ...
+
+
+Hot Pages
+.........
+
+``contrib/plugins/hotpages.c``
+
+Similar to hotblocks but this time tracks memory accesses::
+
+  $ qemu-aarch64 \
+    -plugin contrib/plugins/libhotpages.so -d plugin \
+    ./tests/tcg/aarch64-linux-user/sha1
+  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
+  Addr, RCPUs, Reads, WCPUs, Writes
+  0x000055007fe000, 0x0001, 31747952, 0x0001, 8835161
+  0x000055007ff000, 0x0001, 29001054, 0x0001, 8780625
+  0x00005500800000, 0x0001, 687465, 0x0001, 335857
+  0x0000000048b000, 0x0001, 130594, 0x0001, 355
+  0x0000000048a000, 0x0001, 1826, 0x0001, 11
+
+The hotpages plugin can be configured using the following arguments:
+
+.. list-table:: Hot pages arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - sortby=reads|writes|address
+    - Log the data sorted by either the number of reads, the number of writes, or
+      memory address. (Default: entries are sorted by the sum of reads and writes)
+  * - io=on
+    - Track IO addresses. Only relevant to full system emulation. (Default: off)
+  * - pagesize=N
+    - The page size used. (Default: N = 4096)
+
+Instruction Distribution
+........................
+
+``contrib/plugins/howvec.c``
+
+This is an instruction classifier so can be used to count different
+types of instructions. It has a number of options to refine which get
+counted. You can give a value to the ``count`` argument for a class of
+instructions to break it down fully, so for example to see all the system
+registers accesses::
+
+  $ qemu-system-aarch64 $(QEMU_ARGS) \
+    -append "root=/dev/sda2 systemd.unit=benchmark.service" \
+    -smp 4 -plugin ./contrib/plugins/libhowvec.so,count=sreg -d plugin
+
+which will lead to a sorted list after the class breakdown::
+
+  Instruction Classes:
+  Class:   UDEF                   not counted
+  Class:   SVE                    (68 hits)
+  Class:   PCrel addr             (47789483 hits)
+  Class:   Add/Sub (imm)          (192817388 hits)
+  Class:   Logical (imm)          (93852565 hits)
+  Class:   Move Wide (imm)        (76398116 hits)
+  Class:   Bitfield               (44706084 hits)
+  Class:   Extract                (5499257 hits)
+  Class:   Cond Branch (imm)      (147202932 hits)
+  Class:   Exception Gen          (193581 hits)
+  Class:     NOP                  not counted
+  Class:   Hints                  (6652291 hits)
+  Class:   Barriers               (8001661 hits)
+  Class:   PSTATE                 (1801695 hits)
+  Class:   System Insn            (6385349 hits)
+  Class:   System Reg             counted individually
+  Class:   Branch (reg)           (69497127 hits)
+  Class:   Branch (imm)           (84393665 hits)
+  Class:   Cmp & Branch           (110929659 hits)
+  Class:   Tst & Branch           (44681442 hits)
+  Class:   AdvSimd ldstmult       (736 hits)
+  Class:   ldst excl              (9098783 hits)
+  Class:   Load Reg (lit)         (87189424 hits)
+  Class:   ldst noalloc pair      (3264433 hits)
+  Class:   ldst pair              (412526434 hits)
+  Class:   ldst reg (imm)         (314734576 hits)
+  Class: Loads & Stores           (2117774 hits)
+  Class: Data Proc Reg            (223519077 hits)
+  Class: Scalar FP                (31657954 hits)
+  Individual Instructions:
+  Instr: mrs x0, sp_el0           (2682661 hits)  (op=0xd5384100/  System Reg)
+  Instr: mrs x1, tpidr_el2        (1789339 hits)  (op=0xd53cd041/  System Reg)
+  Instr: mrs x2, tpidr_el2        (1513494 hits)  (op=0xd53cd042/  System Reg)
+  Instr: mrs x0, tpidr_el2        (1490823 hits)  (op=0xd53cd040/  System Reg)
+  Instr: mrs x1, sp_el0           (933793 hits)   (op=0xd5384101/  System Reg)
+  Instr: mrs x2, sp_el0           (699516 hits)   (op=0xd5384102/  System Reg)
+  Instr: mrs x4, tpidr_el2        (528437 hits)   (op=0xd53cd044/  System Reg)
+  Instr: mrs x30, ttbr1_el1       (480776 hits)   (op=0xd538203e/  System Reg)
+  Instr: msr ttbr1_el1, x30       (480713 hits)   (op=0xd518203e/  System Reg)
+  Instr: msr vbar_el1, x30        (480671 hits)   (op=0xd518c01e/  System Reg)
+  ...
+
+To find the argument shorthand for the class you need to examine the
+source code of the plugin at the moment, specifically the ``*opt``
+argument in the InsnClassExecCount tables.
+
+Lockstep Execution
+..................
+
+``contrib/plugins/lockstep.c``
+
+This is a debugging tool for developers who want to find out when and
+where execution diverges after a subtle change to TCG code generation.
+It is not an exact science and results are likely to be mixed once
+asynchronous events are introduced. While the use of -icount can
+introduce determinism to the execution flow it doesn't always follow
+the translation sequence will be exactly the same. Typically this is
+caused by a timer firing to service the GUI causing a block to end
+early. However in some cases it has proved to be useful in pointing
+people at roughly where execution diverges. The only argument you need
+for the plugin is a path for the socket the two instances will
+communicate over::
+
+
+  $ qemu-system-sparc -monitor none -parallel none \
+    -net none -M SS-20 -m 256 -kernel day11/zImage.elf \
+    -plugin ./contrib/plugins/liblockstep.so,sockpath=lockstep-sparc.sock \
+    -d plugin,nochain
+
+which will eventually report::
+
+  qemu-system-sparc: warning: nic lance.0 has no peer
+  @ 0x000000ffd06678 vs 0x000000ffd001e0 (2/1 since last)
+  @ 0x000000ffd07d9c vs 0x000000ffd06678 (3/1 since last)
+  Δ insn_count @ 0x000000ffd07d9c (809900609) vs 0x000000ffd06678 (809900612)
+    previously @ 0x000000ffd06678/10 (809900609 insns)
+    previously @ 0x000000ffd001e0/4 (809900599 insns)
+    previously @ 0x000000ffd080ac/2 (809900595 insns)
+    previously @ 0x000000ffd08098/5 (809900593 insns)
+    previously @ 0x000000ffd080c0/1 (809900588 insns)
+
+
+Hardware Profile
+................
+
+``contrib/plugins/hwprofile.c``
+
+The hwprofile tool can only be used with system emulation and allows
+the user to see what hardware is accessed how often. It has a number of options:
+
+.. list-table:: Hardware Profile arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - track=[read|write]
+    - By default the plugin tracks both reads and writes. You can use
+      this option to limit the tracking to just one class of accesses.
+  * - source
+    - Will include a detailed break down of what the guest PC that made the
+      access was. Not compatible with the pattern option. Example output::
+
+        cirrus-low-memory @ 0xfffffd00000a0000
+         pc:fffffc0000005cdc, 1, 256
+         pc:fffffc0000005ce8, 1, 256
+         pc:fffffc0000005cec, 1, 256
+
+  * - pattern
+    - Instead break down the accesses based on the offset into the HW
+      region. This can be useful for seeing the most used registers of
+      a device. Example output::
+
+        pci0-conf @ 0xfffffd01fe000000
+          off:00000004, 1, 1
+          off:00000010, 1, 3
+          off:00000014, 1, 3
+          off:00000018, 1, 2
+          off:0000001c, 1, 2
+          off:00000020, 1, 2
+          ...
+
+
+Execution Log
+.............
+
+``contrib/plugins/execlog.c``
+
+The execlog tool traces executed instructions with memory access. It can be used
+for debugging and security analysis purposes.
+Please be aware that this will generate a lot of output.
+
+The plugin needs default argument::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so -d plugin
+
+which will output an execution trace following this structure::
+
+  # vCPU, vAddr, opcode, disassembly[, load/store, memory addr, device]...
+  0, 0xa12, 0xf8012400, "movs r4, #0"
+  0, 0xa14, 0xf87f42b4, "cmp r4, r6"
+  0, 0xa16, 0xd206, "bhs #0xa26"
+  0, 0xa18, 0xfff94803, "ldr r0, [pc, #0xc]", load, 0x00010a28, RAM
+  0, 0xa1a, 0xf989f000, "bl #0xd30"
+  0, 0xd30, 0xfff9b510, "push {r4, lr}", store, 0x20003ee0, RAM, store, 0x20003ee4, RAM
+  0, 0xd32, 0xf9893014, "adds r0, #0x14"
+  0, 0xd34, 0xf9c8f000, "bl #0x10c8"
+  0, 0x10c8, 0xfff96c43, "ldr r3, [r0, #0x44]", load, 0x200000e4, RAM
+
+Please note that you need to configure QEMU with Capstone support to get disassembly.
+
+The output can be filtered to only track certain instructions or
+addresses using the ``ifilter`` or ``afilter`` options. You can stack the
+arguments if required::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
+
+This plugin can also dump registers when they change value. Specify the name of the
+registers with multiple ``reg`` options. You can also use glob style matching if you wish::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
+
+Be aware that each additional register to check will slow down
+execution quite considerably. You can optimise the number of register
+checks done by using the rdisas option. This will only instrument
+instructions that mention the registers in question in disassembly.
+This is not foolproof as some instructions implicitly change
+instructions. You can use the ifilter to catch these cases::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,ifilter=msr,ifilter=blr,reg=x30,reg=\*_el1,rdisas=on
+
+Cache Modelling
+...............
+
+``contrib/plugins/cache.c``
+
+Cache modelling plugin that measures the performance of a given L1 cache
+configuration, and optionally a unified L2 per-core cache when a given working
+set is run::
+
+  $ qemu-x86_64 -plugin ./contrib/plugins/libcache.so \
+      -d plugin -D cache.log ./tests/tcg/x86_64-linux-user/float_convs
+
+will report the following::
+
+    core #, data accesses, data misses, dmiss rate, insn accesses, insn misses, imiss rate
+    0       996695         508             0.0510%  2642799        18617           0.7044%
+
+    address, data misses, instruction
+    0x424f1e (_int_malloc), 109, movq %rax, 8(%rcx)
+    0x41f395 (_IO_default_xsputn), 49, movb %dl, (%rdi, %rax)
+    0x42584d (ptmalloc_init.part.0), 33, movaps %xmm0, (%rax)
+    0x454d48 (__tunables_init), 20, cmpb $0, (%r8)
+    ...
+
+    address, fetch misses, instruction
+    0x4160a0 (__vfprintf_internal), 744, movl $1, %ebx
+    0x41f0a0 (_IO_setb), 744, endbr64
+    0x415882 (__vfprintf_internal), 744, movq %r12, %rdi
+    0x4268a0 (__malloc), 696, andq $0xfffffffffffffff0, %rax
+    ...
+
+The plugin has a number of arguments, all of them are optional:
+
+.. list-table:: Cache modelling arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - limit=N
+    - Print top N icache and dcache thrashing instructions along with
+      their address, number of misses, and its disassembly. (default: 32)
+  * - icachesize=N
+      iblksize=B
+      iassoc=A
+    - Instruction cache configuration arguments. They specify the
+      cache size, block size, and associativity of the instruction
+      cache, respectively. (default: N = 16384, B = 64, A = 8)
+  * - dcachesize=N
+    - Data cache size (default: 16834)
+  * - dblksize=B
+    - Data cache block size (default: 64)
+  * - dassoc=A
+    - Data cache associativity (default: 8)
+  * - evict=POLICY
+    - Sets the eviction policy to POLICY. Available policies are:
+      ``lru``, ``fifo``, and ``rand``. The plugin will use
+      the specified policy for both instruction and data caches.
+      (default: POLICY = ``lru``)
+  * - cores=N
+    - Sets the number of cores for which we maintain separate icache
+      and dcache. (default: for linux-user, N = 1, for full system
+      emulation: N = cores available to guest)
+  * - l2=on
+    - Simulates a unified L2 cache (stores blocks for both
+      instructions and data) using the default L2 configuration (cache
+      size = 2MB, associativity = 16-way, block size = 64B).
+  * - l2cachesize=N
+    - L2 cache size (default: 2097152 (2MB)), implies ``l2=on``
+  * - l2blksize=B
+    - L2 cache block size (default: 64), implies ``l2=on``
+  * - l2assoc=A
+    - L2 cache associativity (default: 16), implies ``l2=on``
+
+Stop on Trigger
+...............
+
+``contrib/plugins/stoptrigger.c``
+
+The stoptrigger plugin allows to setup triggers to stop emulation.
+It can be used for research purposes to launch some code and precisely stop it
+and understand where its execution flow went.
+
+Two types of triggers can be configured: a count of instructions to stop at,
+or an address to stop at. Multiple triggers can be set at once.
+
+By default, QEMU will exit with return code 0. A custom return code can be
+configured for each trigger using ``:CODE`` syntax.
+
+For example, to stop at the 20-th instruction with return code 41, at address
+0xd4 with return code 0 or at address 0xd8 with return code 42::
+
+  $ qemu-system-aarch64 $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libstoptrigger.so,icount=20:41,addr=0xd4,addr=0xd8:42 -d plugin
+
+The plugin will log the reason of exit, for example::
+
+  0xd4 reached, exiting
+
+Other emulation features
+------------------------
+
+When running system emulation you can also enable deterministic
+execution which allows for repeatable record/replay debugging. See
+:ref:`Record/Replay<replay>` for more details.
+
diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 954623f9bf..d8725c2854 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -8,38 +8,6 @@
 QEMU TCG Plugins
 ================
 
-QEMU TCG plugins provide a way for users to run experiments taking
-advantage of the total system control emulation can have over a guest.
-It provides a mechanism for plugins to subscribe to events during
-translation and execution and optionally callback into the plugin
-during these events. TCG plugins are unable to change the system state
-only monitor it passively. However they can do this down to an
-individual instruction granularity including potentially subscribing
-to all load and store operations.
-
-Usage
------
-
-Any QEMU binary with TCG support has plugins enabled by default.
-Earlier releases needed to be explicitly enabled with::
-
-  configure --enable-plugins
-
-Once built a program can be run with multiple plugins loaded each with
-their own arguments::
-
-  $QEMU $OTHER_QEMU_ARGS \
-      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
-      -plugin contrib/plugin/libhotblocks.so
-
-Arguments are plugin specific and can be used to modify their
-behaviour. In this case the howvec plugin is being asked to use inline
-ops to count and break down the hint instructions by type.
-
-Linux user-mode emulation also evaluates the environment variable
-``QEMU_PLUGIN``::
-
-  QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
 
 Writing plugins
 ---------------
@@ -191,479 +159,6 @@ which means callbacks may still occur after the uninstall operation is
 requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
-Example Plugins
-===============
-
-There are a number of plugins included with QEMU and you are
-encouraged to contribute your own plugins plugins upstream. There is a
-``contrib/plugins`` directory where they can go. There are also some
-basic plugins that are used to test and exercise the API during the
-``make check-tcg`` target in ``tests\plugins``.
-
-- tests/plugins/empty.c
-
-Purely a test plugin for measuring the overhead of the plugins system
-itself. Does no instrumentation.
-
-- tests/plugins/bb.c
-
-A very basic plugin which will measure execution in course terms as
-each basic block is executed. By default the results are shown once
-execution finishes::
-
-  $ qemu-aarch64 -plugin tests/plugin/libbb.so \
-      -d plugin ./tests/tcg/aarch64-linux-user/sha1
-  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
-  bb's: 2277338, insns: 158483046
-
-Behaviour can be tweaked with the following arguments:
-
- * inline=true|false
-
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
-
- * idle=true|false
-
- Dump the current execution stats whenever the guest vCPU idles
-
-- tests/plugins/insn.c
-
-This is a basic instruction level instrumentation which can count the
-number of instructions executed on each core/thread::
-
-  $ qemu-aarch64 -plugin tests/plugin/libinsn.so \
-      -d plugin ./tests/tcg/aarch64-linux-user/threadcount
-  Created 10 threads
-  Done
-  cpu 0 insns: 46765
-  cpu 1 insns: 3694
-  cpu 2 insns: 3694
-  cpu 3 insns: 2994
-  cpu 4 insns: 1497
-  cpu 5 insns: 1497
-  cpu 6 insns: 1497
-  cpu 7 insns: 1497
-  total insns: 63135
-
-Behaviour can be tweaked with the following arguments:
-
- * inline=true|false
-
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
-
- * sizes=true|false
-
- Give a summary of the instruction sizes for the execution
-
- * match=<string>
-
- Only instrument instructions matching the string prefix. Will show
- some basic stats including how many instructions have executed since
- the last execution. For example::
-
-   $ qemu-aarch64 -plugin tests/plugin/libinsn.so,match=bl \
-       -d plugin ./tests/tcg/aarch64-linux-user/sha512-vector
-   ...
-   0x40069c, 'bl #0x4002b0', 10 hits, 1093 match hits, Δ+1257 since last match, 98 avg insns/match
-   0x4006ac, 'bl #0x403690', 10 hits, 1094 match hits, Δ+47 since last match, 98 avg insns/match 
-   0x4037fc, 'bl #0x4002b0', 18 hits, 1095 match hits, Δ+22 since last match, 98 avg insns/match 
-   0x400720, 'bl #0x403690', 10 hits, 1096 match hits, Δ+58 since last match, 98 avg insns/match 
-   0x4037fc, 'bl #0x4002b0', 19 hits, 1097 match hits, Δ+22 since last match, 98 avg insns/match 
-   0x400730, 'bl #0x403690', 10 hits, 1098 match hits, Δ+33 since last match, 98 avg insns/match 
-   0x4037ac, 'bl #0x4002b0', 12 hits, 1099 match hits, Δ+20 since last match, 98 avg insns/match 
-   ...
-
-For more detailed execution tracing see the ``execlog`` plugin for
-other options.
-
-- tests/plugins/mem.c
-
-Basic instruction level memory instrumentation::
-
-  $ qemu-aarch64 -plugin tests/plugin/libmem.so,inline=true \
-      -d plugin ./tests/tcg/aarch64-linux-user/sha1
-  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
-  inline mem accesses: 79525013
-
-Behaviour can be tweaked with the following arguments:
-
- * inline=true|false
-
- Use faster inline addition of a single counter. Not per-cpu and not
- thread safe.
-
- * callback=true|false
-
- Use callbacks on each memory instrumentation.
-
- * hwaddr=true|false
-
- Count IO accesses (only for system emulation)
-
-- tests/plugins/syscall.c
-
-A basic syscall tracing plugin. This only works for user-mode. By
-default it will give a summary of syscall stats at the end of the
-run::
-
-  $ qemu-aarch64 -plugin tests/plugin/libsyscall \
-      -d plugin ./tests/tcg/aarch64-linux-user/threadcount
-  Created 10 threads
-  Done
-  syscall no.  calls  errors
-  226          12     0
-  99           11     11
-  115          11     0
-  222          11     0
-  93           10     0
-  220          10     0
-  233          10     0
-  215          8      0
-  214          4      0
-  134          2      0
-  64           2      0
-  96           1      0
-  94           1      0
-  80           1      0
-  261          1      0
-  78           1      0
-  160          1      0
-  135          1      0
-
-- contrib/plugins/hotblocks.c
-
-The hotblocks plugin allows you to examine the where hot paths of
-execution are in your program. Once the program has finished you will
-get a sorted list of blocks reporting the starting PC, translation
-count, number of instructions and execution count. This will work best
-with linux-user execution as system emulation tends to generate
-re-translations as blocks from different programs get swapped in and
-out of system memory.
-
-If your program is single-threaded you can use the ``inline`` option for
-slightly faster (but not thread safe) counters.
-
-Example::
-
-  $ qemu-aarch64 \
-    -plugin contrib/plugins/libhotblocks.so -d plugin \
-    ./tests/tcg/aarch64-linux-user/sha1
-  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
-  collected 903 entries in the hash table
-  pc, tcount, icount, ecount
-  0x0000000041ed10, 1, 5, 66087
-  0x000000004002b0, 1, 4, 66087
-  ...
-
-- contrib/plugins/hotpages.c
-
-Similar to hotblocks but this time tracks memory accesses::
-
-  $ qemu-aarch64 \
-    -plugin contrib/plugins/libhotpages.so -d plugin \
-    ./tests/tcg/aarch64-linux-user/sha1
-  SHA1=15dd99a1991e0b3826fede3deffc1feba42278e6
-  Addr, RCPUs, Reads, WCPUs, Writes
-  0x000055007fe000, 0x0001, 31747952, 0x0001, 8835161
-  0x000055007ff000, 0x0001, 29001054, 0x0001, 8780625
-  0x00005500800000, 0x0001, 687465, 0x0001, 335857
-  0x0000000048b000, 0x0001, 130594, 0x0001, 355
-  0x0000000048a000, 0x0001, 1826, 0x0001, 11
-
-The hotpages plugin can be configured using the following arguments:
-
-  * sortby=reads|writes|address
-
-  Log the data sorted by either the number of reads, the number of writes, or
-  memory address. (Default: entries are sorted by the sum of reads and writes)
-
-  * io=on
-
-  Track IO addresses. Only relevant to full system emulation. (Default: off)
-
-  * pagesize=N
-
-  The page size used. (Default: N = 4096)
-
-- contrib/plugins/howvec.c
-
-This is an instruction classifier so can be used to count different
-types of instructions. It has a number of options to refine which get
-counted. You can give a value to the ``count`` argument for a class of
-instructions to break it down fully, so for example to see all the system
-registers accesses::
-
-  $ qemu-system-aarch64 $(QEMU_ARGS) \
-    -append "root=/dev/sda2 systemd.unit=benchmark.service" \
-    -smp 4 -plugin ./contrib/plugins/libhowvec.so,count=sreg -d plugin
-
-which will lead to a sorted list after the class breakdown::
-
-  Instruction Classes:
-  Class:   UDEF                   not counted
-  Class:   SVE                    (68 hits)
-  Class:   PCrel addr             (47789483 hits)
-  Class:   Add/Sub (imm)          (192817388 hits)
-  Class:   Logical (imm)          (93852565 hits)
-  Class:   Move Wide (imm)        (76398116 hits)
-  Class:   Bitfield               (44706084 hits)
-  Class:   Extract                (5499257 hits)
-  Class:   Cond Branch (imm)      (147202932 hits)
-  Class:   Exception Gen          (193581 hits)
-  Class:     NOP                  not counted
-  Class:   Hints                  (6652291 hits)
-  Class:   Barriers               (8001661 hits)
-  Class:   PSTATE                 (1801695 hits)
-  Class:   System Insn            (6385349 hits)
-  Class:   System Reg             counted individually
-  Class:   Branch (reg)           (69497127 hits)
-  Class:   Branch (imm)           (84393665 hits)
-  Class:   Cmp & Branch           (110929659 hits)
-  Class:   Tst & Branch           (44681442 hits)
-  Class:   AdvSimd ldstmult       (736 hits)
-  Class:   ldst excl              (9098783 hits)
-  Class:   Load Reg (lit)         (87189424 hits)
-  Class:   ldst noalloc pair      (3264433 hits)
-  Class:   ldst pair              (412526434 hits)
-  Class:   ldst reg (imm)         (314734576 hits)
-  Class: Loads & Stores           (2117774 hits)
-  Class: Data Proc Reg            (223519077 hits)
-  Class: Scalar FP                (31657954 hits)
-  Individual Instructions:
-  Instr: mrs x0, sp_el0           (2682661 hits)  (op=0xd5384100/  System Reg)
-  Instr: mrs x1, tpidr_el2        (1789339 hits)  (op=0xd53cd041/  System Reg)
-  Instr: mrs x2, tpidr_el2        (1513494 hits)  (op=0xd53cd042/  System Reg)
-  Instr: mrs x0, tpidr_el2        (1490823 hits)  (op=0xd53cd040/  System Reg)
-  Instr: mrs x1, sp_el0           (933793 hits)   (op=0xd5384101/  System Reg)
-  Instr: mrs x2, sp_el0           (699516 hits)   (op=0xd5384102/  System Reg)
-  Instr: mrs x4, tpidr_el2        (528437 hits)   (op=0xd53cd044/  System Reg)
-  Instr: mrs x30, ttbr1_el1       (480776 hits)   (op=0xd538203e/  System Reg)
-  Instr: msr ttbr1_el1, x30       (480713 hits)   (op=0xd518203e/  System Reg)
-  Instr: msr vbar_el1, x30        (480671 hits)   (op=0xd518c01e/  System Reg)
-  ...
-
-To find the argument shorthand for the class you need to examine the
-source code of the plugin at the moment, specifically the ``*opt``
-argument in the InsnClassExecCount tables.
-
-- contrib/plugins/lockstep.c
-
-This is a debugging tool for developers who want to find out when and
-where execution diverges after a subtle change to TCG code generation.
-It is not an exact science and results are likely to be mixed once
-asynchronous events are introduced. While the use of -icount can
-introduce determinism to the execution flow it doesn't always follow
-the translation sequence will be exactly the same. Typically this is
-caused by a timer firing to service the GUI causing a block to end
-early. However in some cases it has proved to be useful in pointing
-people at roughly where execution diverges. The only argument you need
-for the plugin is a path for the socket the two instances will
-communicate over::
-
-
-  $ qemu-system-sparc -monitor none -parallel none \
-    -net none -M SS-20 -m 256 -kernel day11/zImage.elf \
-    -plugin ./contrib/plugins/liblockstep.so,sockpath=lockstep-sparc.sock \
-    -d plugin,nochain
-
-which will eventually report::
-
-  qemu-system-sparc: warning: nic lance.0 has no peer
-  @ 0x000000ffd06678 vs 0x000000ffd001e0 (2/1 since last)
-  @ 0x000000ffd07d9c vs 0x000000ffd06678 (3/1 since last)
-  Δ insn_count @ 0x000000ffd07d9c (809900609) vs 0x000000ffd06678 (809900612)
-    previously @ 0x000000ffd06678/10 (809900609 insns)
-    previously @ 0x000000ffd001e0/4 (809900599 insns)
-    previously @ 0x000000ffd080ac/2 (809900595 insns)
-    previously @ 0x000000ffd08098/5 (809900593 insns)
-    previously @ 0x000000ffd080c0/1 (809900588 insns)
-
-- contrib/plugins/hwprofile.c
-
-The hwprofile tool can only be used with system emulation and allows
-the user to see what hardware is accessed how often. It has a number of options:
-
- * track=read or track=write
-
- By default the plugin tracks both reads and writes. You can use one
- of these options to limit the tracking to just one class of accesses.
-
- * source
-
- Will include a detailed break down of what the guest PC that made the
- access was. Not compatible with the pattern option. Example output::
-
-   cirrus-low-memory @ 0xfffffd00000a0000
-    pc:fffffc0000005cdc, 1, 256
-    pc:fffffc0000005ce8, 1, 256
-    pc:fffffc0000005cec, 1, 256
-
- * pattern
-
- Instead break down the accesses based on the offset into the HW
- region. This can be useful for seeing the most used registers of a
- device. Example output::
-
-    pci0-conf @ 0xfffffd01fe000000
-      off:00000004, 1, 1
-      off:00000010, 1, 3
-      off:00000014, 1, 3
-      off:00000018, 1, 2
-      off:0000001c, 1, 2
-      off:00000020, 1, 2
-      ...
-
-- contrib/plugins/execlog.c
-
-The execlog tool traces executed instructions with memory access. It can be used
-for debugging and security analysis purposes.
-Please be aware that this will generate a lot of output.
-
-The plugin needs default argument::
-
-  $ qemu-system-arm $(QEMU_ARGS) \
-    -plugin ./contrib/plugins/libexeclog.so -d plugin
-
-which will output an execution trace following this structure::
-
-  # vCPU, vAddr, opcode, disassembly[, load/store, memory addr, device]...
-  0, 0xa12, 0xf8012400, "movs r4, #0"
-  0, 0xa14, 0xf87f42b4, "cmp r4, r6"
-  0, 0xa16, 0xd206, "bhs #0xa26"
-  0, 0xa18, 0xfff94803, "ldr r0, [pc, #0xc]", load, 0x00010a28, RAM
-  0, 0xa1a, 0xf989f000, "bl #0xd30"
-  0, 0xd30, 0xfff9b510, "push {r4, lr}", store, 0x20003ee0, RAM, store, 0x20003ee4, RAM
-  0, 0xd32, 0xf9893014, "adds r0, #0x14"
-  0, 0xd34, 0xf9c8f000, "bl #0x10c8"
-  0, 0x10c8, 0xfff96c43, "ldr r3, [r0, #0x44]", load, 0x200000e4, RAM
-
-Please note that you need to configure QEMU with Capstone support to get disassembly.
-
-The output can be filtered to only track certain instructions or
-addresses using the ``ifilter`` or ``afilter`` options. You can stack the
-arguments if required::
-
-  $ qemu-system-arm $(QEMU_ARGS) \
-    -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
-
-This plugin can also dump registers when they change value. Specify the name of the
-registers with multiple ``reg`` options. You can also use glob style matching if you wish::
-
-  $ qemu-system-arm $(QEMU_ARGS) \
-    -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
-
-Be aware that each additional register to check will slow down
-execution quite considerably. You can optimise the number of register
-checks done by using the rdisas option. This will only instrument
-instructions that mention the registers in question in disassembly.
-This is not foolproof as some instructions implicitly change
-instructions. You can use the ifilter to catch these cases:
-
-  $ qemu-system-arm $(QEMU_ARGS) \
-    -plugin ./contrib/plugins/libexeclog.so,ifilter=msr,ifilter=blr,reg=x30,reg=\*_el1,rdisas=on
-
-- contrib/plugins/cache.c
-
-Cache modelling plugin that measures the performance of a given L1 cache
-configuration, and optionally a unified L2 per-core cache when a given working
-set is run::
-
-  $ qemu-x86_64 -plugin ./contrib/plugins/libcache.so \
-      -d plugin -D cache.log ./tests/tcg/x86_64-linux-user/float_convs
-
-will report the following::
-
-    core #, data accesses, data misses, dmiss rate, insn accesses, insn misses, imiss rate
-    0       996695         508             0.0510%  2642799        18617           0.7044%
-
-    address, data misses, instruction
-    0x424f1e (_int_malloc), 109, movq %rax, 8(%rcx)
-    0x41f395 (_IO_default_xsputn), 49, movb %dl, (%rdi, %rax)
-    0x42584d (ptmalloc_init.part.0), 33, movaps %xmm0, (%rax)
-    0x454d48 (__tunables_init), 20, cmpb $0, (%r8)
-    ...
-
-    address, fetch misses, instruction
-    0x4160a0 (__vfprintf_internal), 744, movl $1, %ebx
-    0x41f0a0 (_IO_setb), 744, endbr64
-    0x415882 (__vfprintf_internal), 744, movq %r12, %rdi
-    0x4268a0 (__malloc), 696, andq $0xfffffffffffffff0, %rax
-    ...
-
-The plugin has a number of arguments, all of them are optional:
-
-  * limit=N
-
-  Print top N icache and dcache thrashing instructions along with their
-  address, number of misses, and its disassembly. (default: 32)
-
-  * icachesize=N
-  * iblksize=B
-  * iassoc=A
-
-  Instruction cache configuration arguments. They specify the cache size, block
-  size, and associativity of the instruction cache, respectively.
-  (default: N = 16384, B = 64, A = 8)
-
-  * dcachesize=N
-  * dblksize=B
-  * dassoc=A
-
-  Data cache configuration arguments. They specify the cache size, block size,
-  and associativity of the data cache, respectively.
-  (default: N = 16384, B = 64, A = 8)
-
-  * evict=POLICY
-
-  Sets the eviction policy to POLICY. Available policies are: :code:`lru`,
-  :code:`fifo`, and :code:`rand`. The plugin will use the specified policy for
-  both instruction and data caches. (default: POLICY = :code:`lru`)
-
-  * cores=N
-
-  Sets the number of cores for which we maintain separate icache and dcache.
-  (default: for linux-user, N = 1, for full system emulation: N = cores
-  available to guest)
-
-  * l2=on
-
-  Simulates a unified L2 cache (stores blocks for both instructions and data)
-  using the default L2 configuration (cache size = 2MB, associativity = 16-way,
-  block size = 64B).
-
-  * l2cachesize=N
-  * l2blksize=B
-  * l2assoc=A
-
-  L2 cache configuration arguments. They specify the cache size, block size, and
-  associativity of the L2 cache, respectively. Setting any of the L2
-  configuration arguments implies ``l2=on``.
-  (default: N = 2097152 (2MB), B = 64, A = 16)
-
-- contrib/plugins/stoptrigger.c
-
-The stoptrigger plugin allows to setup triggers to stop emulation.
-It can be used for research purposes to launch some code and precisely stop it
-and understand where its execution flow went.
-
-Two types of triggers can be configured: a count of instructions to stop at,
-or an address to stop at. Multiple triggers can be set at once.
-
-By default, QEMU will exit with return code 0. A custom return code can be
-configured for each trigger using ``:CODE`` syntax.
-
-For example, to stop at the 20-th instruction with return code 41, at address
-0xd4 with return code 0 or at address 0xd8 with return code 42::
-
-  $ qemu-system-aarch64 $(QEMU_ARGS) \
-    -plugin ./contrib/plugins/libstoptrigger.so,icount=20:41,addr=0xd4,addr=0xd8:42 -d plugin
-
-The plugin will log the reason of exit, for example::
-
-  0xd4 reached, exiting
-
 Plugin API
 ==========
 
-- 
2.39.2


