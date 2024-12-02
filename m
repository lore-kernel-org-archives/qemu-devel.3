Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09C8E69E86
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIC58-0005m8-Rd; Mon, 02 Dec 2024 14:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4r-0005il-DP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:26 -0500
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1tIC4n-0001u3-Kk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:27:24 -0500
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 575241804B4
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2024 20:27:12 +0100 (CET)
Received: (qmail 7087 invoked by uid 990); 2 Dec 2024 19:27:12 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 02 Dec 2024 20:27:12 +0100
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>
Subject: [RFC PATCH v3 00/11] tcg-plugins: add hooks for discontinuities
Date: Mon,  2 Dec 2024 20:26:41 +0100
Message-ID: <cover.1733063076.git.neither@nut.email>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1)
 R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=lhp/MzIhcQwQgKNSdC0sX2veCqSwD9bp274LH0tKfMo=;
 b=C+hLkkvZSYegywm++I5e4yctqswLk6sFQPI6z+7ebske4ee+HnD0d5tgbVAjQElL4f8LLFGGwE
 bL0Hn9yc9wYy++k8J4RGbD5YW2ZsWjhu+vAE90s2yd8UlMglpQJPdcl2QqlqCfB9LqS3kii29SPp
 VYrPYb4KYXmp5IYlTuZeBtynLViye83kdVd6OVjIGsiOVmg+hg4nQBd2PJEio0M3AVRUQ0zf0wEQ
 RO8Cl1FMElhPk9FpltLEU+vo8e6de+zx3g4EJiSYcsd0fdtoaZP16NwLud9kjigY2ED8m5ffnPQ4
 B3VTxo/6oHvR1c3X50pMUdRDPr5IvhK+4zuUKFFL9hyV6ddWPOGvqrDGlVkTaCcaM0XOyZ9a/E6B
 ULNQ8ZgH5VaD8vVgtygwZDOn87dbCbX6KKgrvkYFTddGTt+zyWK9keS2e/unZtRhLi3p0sB3HAF9
 X05KYn48624+OXnUeIXbI4Xq1DXUCP0LAB2Wi8Z1yyU6sSpV/X44x8feenYG1WYkfrHJ0nBiVrc9
 l/5Dsfw5qtRi+9IRcd5ySczAVhgCyuhF1jervJiCk571g2CTTtEqGkRFkqFjqAzT0owzRM90qwHF
 CyJ5in4adhTFOtd3XhaBLsuT5YO6bgVkXfrQZIhxiuktV/jHMY3QE+cGiWBQfFGL5yiBw8lscafg
 U=
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
showcasing the new API. Patches 5 through 6 call the hooks for a
selection of architectures, mapping architecture specific events to the
three categories defined in patch 1. Future non-RFC patchsets will call
these hooks for all architectures (that have some concept of trap or
interrupt). Finally, patch 11 supplies a test plugin asserting that the
next PC provided to the plugin points to the next instruction executed.

Sidenote: I'm likely doing something wrong for one architecture or
the other. These patches are untested for most of them.

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

Julian Ganz (11):
  plugins: add types for callbacks related to certain discontinuities
  plugins: add API for registering discontinuity callbacks
  plugins: add hooks for new discontinuity related callbacks
  contrib/plugins: add plugin showcasing new dicontinuity related API
  target/alpha: call plugin trap callbacks
  target/arm: call plugin trap callbacks
  target/avr: call plugin trap callbacks
  target/mips: call plugin trap callbacks
  target/riscv: call plugin trap callbacks
  target/sparc: call plugin trap callbacks
  tests: add plugin asserting correctness of discon event's to_pc

 contrib/plugins/meson.build         |  3 +-
 contrib/plugins/traps.c             | 96 +++++++++++++++++++++++++++++
 include/qemu/plugin-event.h         |  3 +
 include/qemu/plugin.h               | 13 ++++
 include/qemu/qemu-plugin.h          | 58 +++++++++++++++++
 plugins/core.c                      | 67 ++++++++++++++++++++
 target/alpha/helper.c               | 12 ++++
 target/arm/helper.c                 | 25 ++++++++
 target/arm/tcg/m_helper.c           | 18 ++++++
 target/avr/helper.c                 |  3 +
 target/mips/tcg/sysemu/tlb_helper.c | 11 ++++
 target/riscv/cpu_helper.c           |  9 +++
 target/sparc/int32_helper.c         |  7 +++
 target/sparc/int64_helper.c         | 10 +++
 tests/tcg/plugins/discons.c         | 95 ++++++++++++++++++++++++++++
 tests/tcg/plugins/meson.build       |  2 +-
 16 files changed, 430 insertions(+), 2 deletions(-)
 create mode 100644 contrib/plugins/traps.c
 create mode 100644 tests/tcg/plugins/discons.c

-- 
2.45.2


