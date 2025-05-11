Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D964EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6WF-0006SP-BI; Sun, 11 May 2025 09:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6WC-0006PW-AA
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:00 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6W8-0006ly-Da
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:15:00 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 26F5C17FFF6
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:14:46 +0200 (CEST)
Received: (qmail 25898 invoked by uid 990); 11 May 2025 13:14:46 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:14:45 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [PATCH v4 00/23] tcg-plugins: add hooks for discontinuities
Date: Sun, 11 May 2025 15:13:52 +0200
Message-ID: <cover.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=e6KHa/Xmv1nsUlyWySfGruFBuLXGJykI37IGodFAdkg=;
 b=t1FmbuTER7jXl1qmgUYz9dFvYMu3pJpE8C6mCFAMC92xYfyEdc63WO7YQT9TSmemLk87E8+C+p
 SqWkAqmWMX47tThAX57+S6AQpWNluvmYDmE+N1yM1P9TsJ+dW3g1QPO7OQp1NvrJqRfSPB4TVHZQ
 gjA9t5aMxCAM+LVghWuYCdGJTTqbS8SO7NvV6nDfHoZ0qU5UkOPQIGv/YWRVltO4VVQ7tyBtCqb8
 LgniOkqhh7ZMp+ZHqSazxnGuPpYWLTl18S/cdJ3tZvKBvTDE9nw6TihgwXq0lHxmCbUyUL4dnwTw
 ddpnL/IHGKniaDdZULPpQmiZjm75DD2iD0OXWmc4Ud14k/7J7LNdRueeI5UesZa6/UQVwwpmbPbP
 mfmdYRgxFj4Wzs1BoPXoaofxk3g43fWyrSXC056BSLI6Au2B5ACWo07QVQ12XLlMeDswe6KMDWdQ
 ACadUwI5UTqbs9GiSIZ/fuOf1DCxvFFJRJnEDjNd8uxMk6IlzpK9SBmCUn03KFfVbyjrhaEiKW9/
 +53i65TzDYjPKoWHSAnWTdryErGWU1ne1R+AQXPp5zraDsJpV391E5YFWKGOhpsNBhkFD3XJ9tRa
 yCKFhOJDm9P30TqUPuQtgyT+3KkSQOUZoA61cQZHcjZj33GtPXCpoyj2WW/Lre+lYw22Xagy5Z77
 E=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Some analysis greatly benefits, or depends on, information about
certain types of dicontinuities such as interrupts. For example, we may
need to handle the execution of a new translation block differently if
it is not the result of normal program flow but of an interrupt.

Even with the existing interfaces, it is more or less possible to
discern these situations, e.g. as done by the cflow plugin. However,
this process poses a considerable overhead to the core analysis one may
intend to perform.

These changes introduce a generic and easy-to-use interface for plugin
authors in the form of a callback for discontinuities. Patch 1 defines
an enumeration of some trap-related discontinuities including somewhat
narrow definitions of the discontinuity evetns and a callback type.
Patch 2 defines the callback registration function. Patch 3 adds some
hooks for triggering the callbacks. Patch 4 adds an example plugin
showcasing the new API. Patches 5 through 20 call the hooks for a
selection of architectures, mapping architecture specific events to the
three categories defined in patch 1. Patch 21 supplies a test plugin
asserting some behavior of the plugin API w.r.t. the PCs reported by the
new API. Finally, patches 22 and 23 add new tests for riscv which serve
as test-cases for the test plugin.

Sidenote: I'm likely doing something wrong for one architecture or
the other. These patches are untested for most of them. I did skip some
architectures. Those will be added in the next patch series.

Until now, I also did not collect any Signed-off-by or Reviewed-by
lines as the series was in an RFC state and most patches were still in
flux for one reason or another.

Since v3 (RFC):
  - Switched to shifting 1 notation for qemu_plugin_discon_type values
    (as requested by Pierrick Bouvier)
  - Added missing documentation of function parameters of function
    pointer type qemu_plugin_vcpu_discon_cb_t
  - Added missing documentation of function parameters of
    qemu_plugin_register_vcpu_discon_cb
  - Eliminated "to" argument from hooks called from target specific
    code, i.e. qemu_plugin_vcpu_interrupt_cb and friends, determine "to"
    address using CPUClass::get_pc
  - Replaced comment declaring switch-case unreachable with
    g_assert_not_reached()
  - Call qemu_plugin_register_vcpu_discon_cb with QEMU_PLUGIN_DISCON_ALL
    rather than QEMU_PLUGIN_DISCON_TRAPS in "traps" example plugin
  - Take max_vcpus from qemu_info_t in "traps" example plugin, don't
    determine it based on VCPU activation
  - Added a description of the "traps" example plugin (as requested by
    Pierrick Bouvier)
  - Added section for the "traps" example plugin in documentation's
    "Emulation" chapter
  - Fixed messed-up switch-case in alpha_cpu_do_interrupt
  - Added hooks for PA-RISC, x86, loongarch, Motorola 68000, MicroBlaze,
    OpenRISC, Power PC, Renesas Xtreme, IBM System/390 and xtensa
    targets.
  - Made "discon" test plugin check PCs in vcpu_discon callback (as
    requested by Pierrick Bouvier)
  - Added parameter to "discon" test plugin for controlling which
    address bits are compared to cope with TBs being used under
    different virtual addresses
  - Added parameter to "discon" test plugin for printing a full
    instruction trace for debugging purposes
  - Made "discon" test plugin abort by default on address mismatches
  - Added test-cases for RISC-V

Since v2 (tcg-plugins: add hooks for interrupts, exceptions and traps):
  - Switched from traps as core concept to more generic discontinuities
  - Switched from semihosting to hostcall as term for emulated traps
  - Added enumeration of events and dedicated callback type
  - Make callback receive event type as well as origin and target PC
    (as requested by Pierrick Bouvier)
  - Combined registration functions for different traps into a single
    one for all types of discontinuities (as requested by Pierrick
    Bouvier)
  - Migrated records in example plugin from fully pre-allocated to a
    scoreboard (as suggested by Pierrick Bouvier)
  - Handle PSCI calls as hostcall (as pointed out by Peter Maydell)
  - Added hooks for ARM Cortex M arches (as pointed out by Peter
    Maydell)
  - Added hooks for Alpha targets
  - Added hooks for MIPS targets
  - Added a plugin for testing some of the interface behaviour

Since v1:
  - Split the one callback into multiple callbacks
  - Added a target-agnostic definition of the relevant event(s)
  - Call hooks from architecture-code rather than accel/tcg/cpu-exec.c
  - Added a plugin showcasing API usage

Julian Ganz (23):
  plugins: add types for callbacks related to certain discontinuities
  plugins: add API for registering discontinuity callbacks
  plugins: add hooks for new discontinuity related callbacks
  contrib/plugins: add plugin showcasing new dicontinuity related API
  target/alpha: call plugin trap callbacks
  target/arm: call plugin trap callbacks
  target/avr: call plugin trap callbacks
  target/hppa: call plugin trap callbacks
  target/i386: call plugin trap callbacks
  target/loongarch: call plugin trap callbacks
  target/m68k: call plugin trap callbacks
  target/microblaze: call plugin trap callbacks
  target/mips: call plugin trap callbacks
  target/openrisc: call plugin trap callbacks
  target/ppc: call plugin trap callbacks
  target/riscv: call plugin trap callbacks
  target/rx: call plugin trap callbacks
  target/s390x: call plugin trap callbacks
  target/sparc: call plugin trap callbacks
  target/xtensa: call plugin trap callbacks
  tests: add plugin asserting correctness of discon event's to_pc
  tests: add test for double-traps on rv64
  tests: add test with interrupted memory accesses on rv64

 contrib/plugins/meson.build               |   3 +-
 contrib/plugins/traps.c                   | 100 ++++++++++
 docs/about/emulation.rst                  |   8 +
 include/qemu/plugin-event.h               |   3 +
 include/qemu/plugin.h                     |  13 ++
 include/qemu/qemu-plugin.h                |  60 ++++++
 plugins/core.c                            |  68 +++++++
 target/alpha/helper.c                     |  13 ++
 target/arm/helper.c                       |  24 +++
 target/arm/tcg/m_helper.c                 |  18 ++
 target/avr/helper.c                       |   3 +
 target/hppa/int_helper.c                  |  44 +++++
 target/i386/tcg/excp_helper.c             |   3 +
 target/i386/tcg/seg_helper.c              |   4 +
 target/loongarch/cpu.c                    |   4 +
 target/m68k/op_helper.c                   |  24 +++
 target/microblaze/helper.c                |   8 +
 target/mips/tcg/system/tlb_helper.c       |  11 ++
 target/openrisc/interrupt.c               |  13 ++
 target/ppc/excp_helper.c                  |  42 +++++
 target/riscv/cpu_helper.c                 |   9 +
 target/rx/helper.c                        |  12 ++
 target/s390x/tcg/excp_helper.c            |   8 +
 target/sparc/int32_helper.c               |   7 +
 target/sparc/int64_helper.c               |  10 +
 target/xtensa/exc_helper.c                |   6 +
 tests/tcg/plugins/discons.c               | 219 ++++++++++++++++++++++
 tests/tcg/plugins/meson.build             |   2 +-
 tests/tcg/riscv64/Makefile.softmmu-target |  12 ++
 tests/tcg/riscv64/doubletrap.S            |  73 ++++++++
 tests/tcg/riscv64/interruptedmemory.S     |  67 +++++++
 31 files changed, 889 insertions(+), 2 deletions(-)
 create mode 100644 contrib/plugins/traps.c
 create mode 100644 tests/tcg/plugins/discons.c
 create mode 100644 tests/tcg/riscv64/doubletrap.S
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

-- 
2.49.0


