Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B30AC83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHeh-00060E-0L; Tue, 22 Jul 2025 14:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r6wqbwcc4i8ro92=6w7yk0gruyl3=n1zqx7b4c8dxb0@em483429.getutm.app>)
 id 1ueHFX-00040G-6h
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:57:59 -0400
Received: from a3i638.smtp2go.com ([203.31.38.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.r6wqbwcc4i8ro92=6w7yk0gruyl3=n1zqx7b4c8dxb0@em483429.getutm.app>)
 id 1ueHFR-0006N7-KO
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1753206165; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=6wjTrVKa6BbOpX6RY89JI7BJYDmvF4zYe4NoIoqe3rc=;
 b=IbxxCWdSnqZJ16AwTTNOqNr3jDMxFNcUX3R7rgSXvouTbrpz/WyVod677uFlHpvfp53Hs
 njOcVqScRMVA1c3CfvH2DNzOcmeN/y9KLLVJEn0eL3aaG8As4p9qH6GVjVdJQ8CCnnVdrDk
 ZpP9Rrx62X2kkE+HBhvgwMSYmcTH2Z+RCGta5QfY6nAQLi9qlpkgelRmyXRRd2qrPKD8UQT
 fxaKkCJi3o83YR/GqnNOX8xvT2wTmcoagrKQNVbLAzVNr1fTnSN+sPGRd9Xl/PrfEVZ36Uw
 1+D4VW79QrVKz1QH91qyQMts1BhRa5wwRylXXZwcTUBLJQxtDu6pvrqLtA9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1753206165; h=from : subject :
 to : message-id : date;
 bh=6wjTrVKa6BbOpX6RY89JI7BJYDmvF4zYe4NoIoqe3rc=;
 b=KAUiKb1kVgHdZqIaxKJwV3V55MpwQDE3DWO/JeOViHlR78XceZSXYPmS2oDJTdPDvEWD5
 gyYxet7w1hOvzglCO9zV5SETe0/18OiYK6t4YqtgPBt0bLF+eTa6fb1elfSf60BUMWPXmAT
 TLJRar6xhFQmYCmIDRz20CTVUiP6zD+xUC3I2LOCctODgE4+qeVhXhWnsHyd/AStQ1FEhln
 /saNLDFD9ptY6PulW4cpzqNwZ2tnOnpG0LIkIjVo4NQgEFP6KiOC76ywY91fa73K4ssozFy
 YG8Xags8kG8CXGAA1iDlS6DmaYQ15R1wCgIgKiw+1TcJw0WNiyzcsfhNG4FA==
Received: from [10.159.238.187] (helo=localhost.localdomain)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA512__CHACHA20_POLY1305:256)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1ueH0g-FnQW0hPuqJt-e8US; Tue, 22 Jul 2025 17:42:38 +0000
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Katherine Temkin <k@ktemkin.com>, Joelle van Dyne <j@getutm.app>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/1] tcg/tcti: add TCTI TCG backend for acceleration on
 non-JIT AArch64
Date: Tue, 22 Jul 2025 10:42:06 -0700
Message-ID: <20250722174228.16205-2-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250722174228.16205-1-j@getutm.app>
References: <20250722174228.16205-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429seCHFWXtWj
X-smtpcorp-track: FnIQFimut3vt.kJ_GeWHhS4xo.-nku3wmy68c
Received-SPF: pass client-ip=203.31.38.126;
 envelope-from=bounce.r6wqbwcc4i8ro92=6w7yk0gruyl3=n1zqx7b4c8dxb0@em483429.getutm.app;
 helo=a3i638.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Introduce a new backend TCTI for TCG which pre-compiles gadgets for
every possible TCG op x operands and then "threads" them together at
runtime. This results in huge binary sizes but as a result, the
emulation speed is significantly faster than the TCI interpreter.

Co-authored-by: Katherine Temkin <k@ktemkin.com>
Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 docs/devel/tcg-tcti.rst                       | 1140 +++++++++
 meson.build                                   |   10 +
 include/accel/tcg/getpc.h                     |    6 +-
 include/disas/dis-asm.h                       |    1 +
 include/tcg/tcg-opc.h                         |   12 +
 include/tcg/tcg.h                             |    2 +-
 tcg/aarch64-tcti/tcg-target-con-set.h         |   32 +
 tcg/aarch64-tcti/tcg-target-con-str.h         |   20 +
 tcg/aarch64-tcti/tcg-target-has.h             |  132 +
 tcg/aarch64-tcti/tcg-target-mo.h              |   13 +
 tcg/aarch64-tcti/tcg-target-reg-bits.h        |   16 +
 tcg/aarch64-tcti/tcg-target.h                 |  107 +
 host/include/generic/host/atomic128-cas.h.inc |    3 +-
 tcg/aarch64-tcti/tcg-target-opc.h.inc         |   15 +
 accel/tcg/cputlb.c                            |    3 +-
 accel/tcg/tcg-accel-ops.c                     |    8 +
 tcg/optimize.c                                |    2 +
 tcg/region.c                                  |   11 +-
 tcg/tcg-op.c                                  |   27 +
 tcg/tcg.c                                     |   19 +-
 tcg/aarch64-tcti/tcg-target.c.inc             | 2250 +++++++++++++++++
 meson_options.txt                             |    2 +
 scripts/meson-buildoptions.sh                 |    5 +
 tcg/aarch64-tcti/tcti-gadget-gen.py           | 1192 +++++++++
 tcg/meson.build                               |   71 +-
 25 files changed, 5082 insertions(+), 17 deletions(-)
 create mode 100644 docs/devel/tcg-tcti.rst
 create mode 100644 tcg/aarch64-tcti/tcg-target-con-set.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-con-str.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-has.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-mo.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-reg-bits.h
 create mode 100644 tcg/aarch64-tcti/tcg-target.h
 create mode 100644 tcg/aarch64-tcti/tcg-target-opc.h.inc
 create mode 100644 tcg/aarch64-tcti/tcg-target.c.inc
 create mode 100755 tcg/aarch64-tcti/tcti-gadget-gen.py

diff --git a/docs/devel/tcg-tcti.rst b/docs/devel/tcg-tcti.rst
new file mode 100644
index 0000000000..047f4b8c07
--- /dev/null
+++ b/docs/devel/tcg-tcti.rst
@@ -0,0 +1,1140 @@
+.. _tcg_tcti:
+
+QEMU Tiny-Code Threaded Interpreter (AArch64)
+=============================================
+
+A TCG backend that chains together JOP/ROP-ish gadgets to massively
+reduce interpreter overhead vs TCI. Platform-dependent; but usable when
+JIT isn't available; e.g. on platforms that lack WX mappings. The
+general idea squish the addresses of a gadget sequence into a “queue”
+and then write each gadget so it ends in a “dequeue-jump”.
+
+Execution occurs by jumping into the first gadget, and letting it just
+play back some linear-overhead native code sequences for a while.
+
+Since TCG-TCI is optimized for sets of 16 GP registers and aarch64 has
+30, we could easily keep JIT/QEMU and guest state separate, and since
+16*16 is reasonably small we could actually have a set of reasonable
+gadgets for each combination of operands.
+
+Register Convention
+-------------------
+
+====== =====================
+Regs   Use
+====== =====================
+x1-x15 Guest Registers
+x24    TCTI temporary
+x25    saved IP during call
+x26    TCTI temporary
+x27    TCTI temporary
+x28    Thread-stream pointer
+x30    Link register
+SP     Stack Pointer, host
+PC     Program Counter, host
+====== =====================
+
+In pseudocode:
+
+====== ===================================
+Symbol Meaning
+====== ===================================
+Rd     stand-in for destination register
+Rn     stand-in for first source register
+Rm     stand-in for second source register
+====== ===================================
+
+Gadget Structure
+----------------
+
+End of gadget
+~~~~~~~~~~~~~
+
+Each gadget ends by advancing our bytecode pointer, and then executing
+from thew new location.
+
+.. code:: asm
+
+   # Load our next gadget address from our bytecode stream, advancing it, and jump to the next gadget.
+
+   ldr x27, [x28], #8\n
+   br x27
+
+Calling into QEMU’s C codebase
+------------------------------
+
+When calling into C, we lose control over which registers are used.
+Accordingly, we’ll need to save registers relevant to TCTI:
+
+.. code:: asm
+
+   str x25,      [sp, #-16]!
+   stp x14, x15, [sp, #-16]!
+   stp x12, x13, [sp, #-16]!
+   stp x10, x11, [sp, #-16]!
+   stp x8,  x9,  [sp, #-16]!
+   stp x6,  x7,  [sp, #-16]!
+   stp x4,  x5,  [sp, #-16]!
+   stp x2,  x3,  [sp, #-16]!
+   stp x0,  x1,  [sp, #-16]!
+   stp x28, lr,  [sp, #-16]!
+
+Upon returning to the gadget stream, we’ll then restore them.
+
+.. code:: asm
+
+   ldp x28, lr, [sp], #16
+   ldp x0,  x1, [sp], #16
+   ldp x2,  x3, [sp], #16
+   ldp x4,  x5, [sp], #16
+   ldp x6,  x7, [sp], #16
+   ldp x8,  x9, [sp], #16
+   ldp x10, x11, [sp], #16
+   ldp x12, x13, [sp], #16
+   ldp x14, x15, [sp], #16
+   ldr x25,      [sp], #16
+
+TCG Operations
+--------------
+
+Each operation needs an implementation for every platform; and probably
+a set of gadgets for each possible set of operands.
+
+At 14 GP registers, that means that
+
+1 operand => 16 gadgets 2 operands => 256 gadgets 3 operands => 4096
+gadgets
+
+call
+~~~~
+
+Calls a helper function by address.
+
+| **IR Format**: ``br <ptr address>``
+| **Gadget type:** single
+
+.. code:: asm
+
+       # Get our C runtime function's location as a pointer-sized immediate...
+       "ldr x27, [x28], #8",
+
+       # Store our TB return address for our helper. This is necessary so the GETPC()
+       # macro works correctly as used in helper functions.
+       "str x28, [x25]",
+
+       # Prepare ourselves to call into our C runtime...
+       *C_CALL_PROLOGUE,
+
+       # ... perform the call itself ...
+       "blr x27",
+
+       # Save the result of our call for later.
+       "mov x27, x0",
+
+       # ... and restore our environment.
+       *C_CALL_EPILOGUE,
+
+       # Restore our return value.
+       "mov x0, x27"
+
+br
+~~
+
+Branches to a given immediate address. Branches are
+
+| **IR Format**: ``br <ptr address>``
+| **Gadget type:** single
+
+.. code:: asm
+
+   # Use our immediate argument as our new bytecode-pointer location.
+   ldr x28, [x28]
+
+setcond_i32
+~~~~~~~~~~~
+
+Performs a comparison between two 32-bit operands.
+
+| **IR Format**: ``setcond32 <cond>, Rd, Rn, Rm``
+| **Gadget type:** treated as 10 operations with variants for every
+  ``Rd``/``Rn``/``Rm`` (40,960)
+
+.. code:: asm
+
+   subs Wd, Wn, Wm
+   cset Wd, <cond>
+
+========= ============
+QEMU Cond AArch64 Cond
+========= ============
+EQ        EQ
+NE        NE
+LT        LT
+GE        GE
+LE        LE
+GT        GT
+LTU       LO
+GEU       HS
+LEU       LS
+GTU       HI
+========= ============
+
+setcond_i64
+~~~~~~~~~~~
+
+Performs a comparison between two 32-bit operands.
+
+| **IR Format**: ``setcond64 <cond>, Rd, Rn, Rm``
+| **Gadget type:** treated as 10 operations with variants for every
+  ``Rd``/``Rn``/``Rm`` (40,960)
+
+.. code:: asm
+
+   subs Xd, Xn, Xm
+   cset Xd, <cond>
+
+Comparison chart is the same as the ``_i32`` variant.
+
+brcond_i32
+~~~~~~~~~~
+
+Compares two 32-bit numbers, and branches if the comparison is true.
+
+| **IR Format**: ``brcond Rn, Rm, <cond>``
+| **Gadget type:** treated as 10 operations with variants for every
+  ``Rn``/``Rm`` (2560)
+
+.. code:: asm
+
+   # Perform our comparison and conditional branch.
+   subs Wrz, Wn, Wm
+   br<cond> taken
+
+       # Consume the branch target, without using it.
+       add x28, x28, #8
+
+       # Perform our end-of-instruction epilogue.
+       <epilogue here>
+
+   taken:
+
+       # Update our bytecode pointer to take the label.
+       ldr x28, [x28]
+
+Comparison chart is the same as in ``setcond_i32`` .
+
+brcond_i64
+~~~~~~~~~~
+
+Compares two 64-bit numbers, and branches if the comparison is true.
+
+| **IR Format**: ``brcond Rn, Rm, <cond>``
+| **Gadget type:** treated as 10 operations with variants for every
+  ``Rn``/``Rm`` (2560)
+
+.. code:: asm
+
+   # Perform our comparison and conditional branch.
+   subs Xrz, Xn, Xm
+   br<cond> taken
+
+       # Consume the branch target, without using it.
+       add x28, x28, #8
+
+       # Perform our end-of-instruction epilogue.
+       <epilogue here>
+
+   taken:
+
+       # Update our bytecode pointer to take the label.
+       ldr x28, [x28]
+
+Comparison chart is the same as in ``setcond_i32`` .
+
+mov_i32
+~~~~~~~
+
+Moves a value from a register to another register.
+
+| **IR Format**: ``mov Rd, Rn``
+| **Gadget type:** gadget per ``Rd`` + ``Rn`` combo (256)
+
+.. code:: asm
+
+   mov Rd, Rn
+
+mov_i64
+~~~~~~~
+
+Moves a value from a register to another register.
+
+| **IR Format**: ``mov Rd, Rn``
+| **Gadget type:** gadget per ``Rd`` + ``Rn`` combo (256)
+
+.. code:: asm
+
+   mov Xd, Xn
+
+tci_movi_i32
+~~~~~~~~~~~~
+
+Moves an 32b immediate into a register.
+
+| **IR Format**: ``mov Rd, #imm32``
+| **Gadget type:** gadget per ``Rd`` (16)
+
+.. code:: asm
+
+   ldr w27, [x28], #4
+   mov Wd, w27
+
+tci_movi_i64
+~~~~~~~~~~~~
+
+Moves an 64b immediate into a register.
+
+| **IR Format**: ``mov Rd, #imm64``
+| **Gadget type:** gadget per ``Rd`` (16)
+
+.. code:: asm
+
+   ldr x27, [x28], #4
+   mov Xd, x27
+
+ld8u_i32 / ld8u_i64
+~~~~~~~~~~~~~~~~~~~
+
+Load byte from host memory to register.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldrb Xd, [Xn, x27]
+
+ld8s_i32 / ld8s_i64
+~~~~~~~~~~~~~~~~~~~
+
+Load byte from host memory to register; sign extending.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldrsb Xd, [Xn, x27]
+
+ld16u_i32 / ld16u_i64
+~~~~~~~~~~~~~~~~~~~~~
+
+Load 16b from host memory to register.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldrh Wd, [Xn, x27]
+
+ld16s_i32 / ld16s_i64
+~~~~~~~~~~~~~~~~~~~~~
+
+Load 16b from host memory to register; sign extending.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldrsh Xd, [Xn, x27]
+
+ld32u_i32 / ld32u_i64
+~~~~~~~~~~~~~~~~~~~~~
+
+Load 32b from host memory to register.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldr Wd, [Xn, x27]
+
+ld32s_i64
+~~~~~~~~~
+
+Load 32b from host memory to register; sign extending.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldrsw Xd, [Xn, x27]
+
+ld_i64
+~~~~~~
+
+Load 64b from host memory to register.
+
+| **IR Format**: ``ldr Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   ldr Xd, [Xn, x27]
+
+st8_i32 / st8_i64
+~~~~~~~~~~~~~~~~~
+
+Stores byte from register to host memory.
+
+| **IR Format**: ``str Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   strb Wd, [Xn, x27]
+
+st16_i32 / st16_i64
+~~~~~~~~~~~~~~~~~~~
+
+Stores 16b from register to host memory.
+
+| **IR Format**: ``str Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   strh Wd, [Xn, x27]
+
+st_i32 / st32_i64
+~~~~~~~~~~~~~~~~~
+
+Stores 32b from register to host memory.
+
+| **IR Format**: ``str Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   str Wd, [Xn, x27]
+
+st_i64
+~~~~~~
+
+Stores 64b from register to host memory.
+
+| **IR Format**: ``str Rd, Rn, <signed offset>``
+| **Gadget type:** gadget per ``Rd`` & ``Rn`` (256)
+
+.. code:: asm
+
+   ldrsw x27, [x28], #4
+   str Xd, [Xn, x27]
+
+qemu_ld_i32
+~~~~~~~~~~~
+
+Loads 32b from *guest* memory to register.
+
+| **IR Format**: ``ld Rd, <foreign/guest pointer>, <memory operation>``
+| **Gadget type:** thunk per ``Rd`` into C impl?
+
+qemu_ld_i64
+~~~~~~~~~~~
+
+Loads 64b from *guest* memory to register.
+
+| **IR Format**: ``ld Rd, <foreign/guest pointer>, <memory operation>``
+| **Gadget type:** thunk per ``Rd`` into C impl?
+
+qemu_st_i32
+~~~~~~~~~~~
+
+Stores 32b from a register to *guest* memory.
+
+| **IR Format**: ``st Rd, <foreign/guest pointer>, <memory operation>``
+| **Gadget type:** thunk per ``Rd`` into C impl
+
+qemu_st_i64
+~~~~~~~~~~~
+
+Stores 64b from a register to *guest* memory.
+
+| **IR Format**: ``st Rd, <foreign/guest pointer>, <memory operation>``
+| **Gadget type:** thunk per ``Rd`` into C impl?
+
+Note
+^^^^
+
+See note on ``qemu_ld_i32``.
+
+add_i32
+~~~~~~~
+
+Adds two 32-bit numbers.
+
+| **IR Format**: ``add Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   add Wd, Wn, Wm
+
+add_i64
+~~~~~~~
+
+Adds two 64-bit numbers.
+
+| **IR Format**: ``add Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   add Xd, Xn, Xm
+
+sub_i32
+~~~~~~~
+
+Subtracts two 32-bit numbers.
+
+| **IR Format**: ``add Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   Sub Wd, Wn, Wm
+
+sub_i64
+~~~~~~~
+
+Subtracts two 64-bit numbers.
+
+| **IR Format**: ``sub Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   sub Xd, Xn, Xm
+
+mul_i32
+~~~~~~~
+
+Multiplies two 32-bit numbers.
+
+| **IR Format**: ``mul Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   mul Wd, Wn, Wm
+
+mul_i64
+~~~~~~~
+
+Multiplies two 64-bit numbers.
+
+| **IR Format**: ``mul Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   mul Xd, Xn, Xm
+
+div_i32
+~~~~~~~
+
+Divides two 32-bit numbers; considering them signed.
+
+| **IR Format**: ``div Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   sdiv Wd, Wn, Wm
+
+div_i64
+~~~~~~~
+
+Divides two 64-bit numbers; considering them signed.
+
+| **IR Format**: ``div Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   sdiv Xd, Xn, Xm
+
+divu_i32
+~~~~~~~~
+
+Divides two 32-bit numbers; considering them unsigned.
+
+| **IR Format**: ``div Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   udiv Wd, Wn, Wm
+
+divu_i64
+~~~~~~~~
+
+Divides two 32-bit numbers; considering them unsigned.
+
+| **IR Format**: ``div Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   udiv Xd, Xn, Xm
+
+rem_i32
+~~~~~~~
+
+Computes the division remainder (modulus) of two 32-bit numbers;
+considering them signed.
+
+| **IR Format**: ``rem Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   sdiv    w27, Wn, Wm
+   msub    Wd, w27, Wm, Wn
+
+rem_i64
+~~~~~~~
+
+Computes the division remainder (modulus) of two 64-bit numbers;
+considering them signed.
+
+| **IR Format**: ``rem Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   sdiv    x27, Xn, Xm
+   msub    Xd, x27, Xm, Xn
+
+remu_i32
+~~~~~~~~
+
+Computes the division remainder (modulus) of two 32-bit numbers;
+considering them unsigned.
+
+| **IR Format**: ``rem Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   udiv    w27, Wn, Wm
+   msub    Wd, w27, Wm, Wn
+
+remu_i64
+~~~~~~~~
+
+Computes the division remainder (modulus) of two 32-bit numbers;
+considering them unsigned.
+
+| **IR Format**: ``rem Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   udiv    x27, Xn, Xm
+   msub    Xd, x27, Xm, Xn
+
+not_i32
+~~~~~~~
+
+Logically inverts a 32-bit number.
+
+| **IR Format**: ``not Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   mvn Wd, Wn
+
+not_i64
+~~~~~~~
+
+Logically inverts a 64-bit number.
+
+| **IR Format**: ``not Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   mvn Xd, Xn
+
+neg_i32
+~~~~~~~
+
+Arithmetically inverts (two’s compliment) a 32-bit number.
+
+| **IR Format**: ``not Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   neg Wd, Wn
+
+neg_i64
+~~~~~~~
+
+Arithmetically inverts (two’s compliment) a 64-bit number.
+
+| **IR Format**: ``not Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   neg Xd, Xn
+
+and_i32
+~~~~~~~
+
+Logically ANDs two 32-bit numbers.
+
+| **IR Format**: ``and Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   and Wd, Wn, Wm
+
+and_i64
+~~~~~~~
+
+Logically ANDs two 64-bit numbers.
+
+| **IR Format**: ``and Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   and Xd, Xn, Xm
+
+or_i32
+~~~~~~
+
+Logically ORs two 32-bit numbers.
+
+| **IR Format**: ``or Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   or Wd, Wn, Wm
+
+or_i64
+~~~~~~
+
+Logically ORs two 64-bit numbers.
+
+| **IR Format**: ``or Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   or Xd, Xn, Xm
+
+xor_i32
+~~~~~~~
+
+Logically XORs two 32-bit numbers.
+
+| **IR Format**: ``xor Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   eor Wd, Wn, Wm
+
+xor_i64
+~~~~~~~
+
+Logically XORs two 64-bit numbers.
+
+| **IR Format**: ``xor Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   eor Xd, Xn, Xm
+
+shl_i32
+~~~~~~~
+
+Logically shifts a 32-bit number left.
+
+| **IR Format**: ``shl Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   lsl Wd, Wn, Wm
+
+shl_i64
+~~~~~~~
+
+Logically shifts a 64-bit number left.
+
+| **IR Format**: ``shl Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   lsl Xd, Xn, Xm
+
+shr_i32
+~~~~~~~
+
+Logically shifts a 32-bit number right.
+
+| **IR Format**: ``shr Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   lsr Wd, Wn, Wm
+
+shr_i64
+~~~~~~~
+
+Logically shifts a 64-bit number right.
+
+| **IR Format**: ``shr Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   lsr Xd, Xn, Xm
+
+sar_i32
+~~~~~~~
+
+Arithmetically shifts a 32-bit number right.
+
+| **IR Format**: ``sar Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   asr Wd, Wn, Wm
+
+sar_i64
+~~~~~~~
+
+Arithmetically shifts a 64-bit number right.
+
+| **IR Format**: ``sar Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   asr Xd, Xn, Xm
+
+rotl_i32
+~~~~~~~~
+
+Rotates a 32-bit number left.
+
+| **IR Format**: ``rotl Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   rol Wd, Wn, Wm
+
+rotl_i64
+~~~~~~~~
+
+Rotates a 64-bit number left.
+
+| **IR Format**: ``rotl Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   rol Xd, Xn, Xm
+
+rotr_i32
+~~~~~~~~
+
+Rotates a 32-bit number right.
+
+| **IR Format**: ``rotr Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   ror Wd, Wn, Wm
+
+rotr_i64
+~~~~~~~~
+
+Rotates a 64-bit number right.
+
+| **IR Format**: ``rotr Rd, Rn, Rm``
+| **Gadget type:** gadget per ``Rd``, ``Rn``, ``Rm`` (4096)
+
+.. code:: asm
+
+   ror Xd, Xn, Xm
+
+deposit_i32
+~~~~~~~~~~~
+
+Optional; not currently implementing.
+
+deposit_i64
+~~~~~~~~~~~
+
+Optional; not currently implementing.
+
+ext8s_i32
+~~~~~~~~~
+
+Sign extends the lower 8b of a register into a 32b destination.
+
+| **IR Format**: ``ext8s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxtb Wd, Wn
+
+ext8s_i64
+~~~~~~~~~
+
+Sign extends the lower 8b of a register into a 64b destination.
+
+| **IR Format**: ``ext8s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxtb Xd, Wn
+
+ext8u_i32
+~~~~~~~~~
+
+Zero extends the lower 8b of a register into a 32b destination.
+
+| **IR Format**: ``ext8u Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   and Xd, Xn, #0xff
+
+ext8u_i64
+~~~~~~~~~
+
+Zero extends the lower 8b of a register into a 64b destination.
+
+| **IR Format**: ``ext8u Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   and Xd, Xn, #0xff
+
+ext16s_i32
+~~~~~~~~~~
+
+Sign extends the lower 16b of a register into a 32b destination.
+
+| **IR Format**: ``ext16s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxth Xd, Wn
+
+ext16s_i64
+~~~~~~~~~~
+
+Sign extends the lower 16b of a register into a 64b destination.
+
+| **IR Format**: ``ext16s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxth Xd, Wn
+
+ext16u_i32
+~~~~~~~~~~
+
+Zero extends the lower 16b of a register into a 32b destination.
+
+| **IR Format**: ``ext16u Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   and Wd, Wn, #0xffff
+
+ext16u_i64
+~~~~~~~~~~
+
+Zero extends the lower 16b of a register into a 32b destination.
+
+| **IR Format**: ``ext16u Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   and Wd, Wn, #0xffff
+
+ext32s_i64
+~~~~~~~~~~
+
+Sign extends the lower 32b of a register into a 64b destination.
+
+| **IR Format**: ``ext32s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxtw Xd, Wn
+
+ext32u_i64
+~~~~~~~~~~
+
+Zero extends the lower 32b of a register into a 64b destination.
+
+| **IR Format**: ``ext32s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxtw Xd, Wn
+
+ext_i32_i64
+~~~~~~~~~~~
+
+Sign extends the lower 32b of a register into a 64b destination.
+
+| **IR Format**: ``ext32s Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   sxtw Xd, Wn
+
+extu_i32_i64
+~~~~~~~~~~~~
+
+Zero extends the lower 32b of a register into a 32b destination.
+
+| **IR Format**: ``ext32u Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   and Xd, Xn, #0xffffffff
+
+bswap16_i32
+~~~~~~~~~~~
+
+Byte-swaps a 16b quantity.
+
+| **IR Format**: ``bswap16 Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   rev     w27, Wn
+   lsr     Wd, w27, #16
+
+bswap16_i64
+~~~~~~~~~~~
+
+Byte-swaps a 16b quantity.
+
+| **IR Format**: ``bswap16 Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   rev     w27, Wn
+   lsr     Wd, w27, #16
+
+bswap32_i32
+~~~~~~~~~~~
+
+Byte-swaps a 32b quantity.
+
+| **IR Format**: ``bswap32 Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   rev     Wd, Wn
+
+bswap32_i64
+~~~~~~~~~~~
+
+Byte-swaps a 32b quantity.
+
+| **IR Format**: ``bswap32 Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   rev     Wd, Wn
+
+bswap64_i64
+~~~~~~~~~~~
+
+Byte-swaps a 64b quantity.
+
+| **IR Format**: ``bswap64 Rd, Rn``
+| **Gadget type:** gadget per ``Rd``, ``Rn`` (256)
+
+.. code:: asm
+
+   rev     Xd, Xn
+
+exit_tb
+~~~~~~~
+
+Exits the translation block. Has no gadget; but instead inserts the
+address of the translation block epilogue.
+
+mb
+~~
+
+Memory barrier.
+
+| **IR Format**: ``mb <type>``
+| **Gadget type:** gadget per type
+
+.. code:: asm
+
+   # !!! TODO
+
+.. _note-1:
+
+Note
+^^^^
+
+We still need to look up out how to map QEMU MB types map to AArch64
+ones. This might take nuance.
diff --git a/meson.build b/meson.build
index 8ec796d835..02dc705553 100644
--- a/meson.build
+++ b/meson.build
@@ -53,6 +53,7 @@ bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
   'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
+tcti_supported_cpus = ['aarch64']
 
 cpu = host_machine.cpu_family()
 
@@ -912,6 +913,12 @@ if get_option('tcg').allowed()
   endif
   if get_option('tcg_interpreter')
     tcg_arch = 'tci'
+  elif get_option('tcg_threaded_interpreter')
+    if cpu not in tcti_supported_cpus
+      error('Unsupported CPU @0@ for TCTI, try --enable-tcg-interpreter'.format(cpu))
+    else
+      tcg_arch = '@0@-tcti'.format(cpu)
+    endif
   elif host_arch == 'x86_64'
     tcg_arch = 'i386'
   elif host_arch == 'ppc64'
@@ -2526,6 +2533,7 @@ config_host_data.set('CONFIG_SOLARIS', host_os == 'sunos')
 if get_option('tcg').allowed()
   config_host_data.set('CONFIG_TCG', 1)
   config_host_data.set('CONFIG_TCG_INTERPRETER', tcg_arch == 'tci')
+  config_host_data.set('CONFIG_TCG_THREADED_INTERPRETER', tcg_arch.endswith('tcti'))
 endif
 config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
@@ -4662,6 +4670,8 @@ summary_info += {'TCG support':       config_all_accel.has_key('CONFIG_TCG')}
 if config_all_accel.has_key('CONFIG_TCG')
   if get_option('tcg_interpreter')
     summary_info += {'TCG backend':   'TCI (TCG with bytecode interpreter, slow)'}
+  elif get_option('tcg_threaded_interpreter')
+    summary_info += {'TCG backend':   'TCTI (TCG with threaded-dispatch bytecode interpreter, experimental and slow; but faster than TCI)'}
   else
     summary_info += {'TCG backend':   'native (@0@)'.format(cpu)}
   endif
diff --git a/include/accel/tcg/getpc.h b/include/accel/tcg/getpc.h
index 8a97ce34e7..3060565b05 100644
--- a/include/accel/tcg/getpc.h
+++ b/include/accel/tcg/getpc.h
@@ -13,10 +13,14 @@
 #endif
 
 /* GETPC is the true target of the return instruction that we'll execute.  */
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER)
 extern __thread uintptr_t tci_tb_ptr;
 # define GETPC() tci_tb_ptr
+#elif defined(CONFIG_TCG_THREADED_INTERPRETER)
+extern __thread uintptr_t tcti_call_return_address;
+# define GETPC() tcti_call_return_address
 #else
+/* Note that this is correct for TCTI also; whose gadget behaves like native code. */
 # define GETPC() \
     ((uintptr_t)__builtin_extract_return_addr(__builtin_return_address(0)))
 #endif
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 3b50ecfb54..c68eaa4736 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -412,6 +412,7 @@ typedef struct disassemble_info {
 typedef int (*disassembler_ftype) (bfd_vma, disassemble_info *);
 
 int print_insn_tci(bfd_vma, disassemble_info*);
+int print_insn_tcti(bfd_vma, disassemble_info*);
 int print_insn_big_mips         (bfd_vma, disassemble_info*);
 int print_insn_little_mips      (bfd_vma, disassemble_info*);
 int print_insn_nanomips         (bfd_vma, disassemble_info*);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 5bf78b0764..9f73771149 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -40,7 +40,11 @@ DEF(mb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+DEF(movcond_i32, 1, 4, 1, TCG_OPF_NOT_PRESENT)
+#else
 DEF(movcond_i32, 1, 4, 1, 0)
+#endif
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
 DEF(ld8s_i32, 1, 1, 1, 0)
@@ -105,7 +109,11 @@ DEF(ctpop_i32, 1, 1, 0, 0)
 DEF(mov_i64, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, 0)
 DEF(negsetcond_i64, 1, 2, 1, 0)
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+DEF(movcond_i64, 1, 4, 1, TCG_OPF_NOT_PRESENT)
+#else
 DEF(movcond_i64, 1, 4, 1, 0)
+#endif
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, 0)
 DEF(ld8s_i64, 1, 1, 1, 0)
@@ -183,7 +191,11 @@ DEF(insn_start, 0, 0, DATA64_ARGS, TCG_OPF_NOT_PRESENT)
 
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
+#else
 DEF(goto_ptr, 0, 1, 0, TCG_OPF_BB_EXIT | TCG_OPF_BB_END)
+#endif
 
 DEF(plugin_cb, 0, 0, 1, TCG_OPF_NOT_PRESENT)
 DEF(plugin_mem_cb, 0, 1, 1, TCG_OPF_NOT_PRESENT)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 84d99508b6..74f0c7580e 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -940,7 +940,7 @@ static inline size_t tcg_current_code_size(TCGContext *s)
 #define TB_EXIT_IDXMAX    1
 #define TB_EXIT_REQUESTED 3
 
-#ifdef CONFIG_TCG_INTERPRETER
+#if defined(CONFIG_TCG_INTERPRETER) || defined(CONFIG_TCG_THREADED_INTERPRETER)
 uintptr_t tcg_qemu_tb_exec(CPUArchState *env, const void *tb_ptr);
 #else
 typedef uintptr_t tcg_prologue_fn(CPUArchState *env, const void *tb_ptr);
diff --git a/tcg/aarch64-tcti/tcg-target-con-set.h b/tcg/aarch64-tcti/tcg-target-con-set.h
new file mode 100644
index 0000000000..a0b91bb320
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-con-set.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * TCI target-specific constraint sets.
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * C_On_Im(...) defines a constraint set with <n> outputs and <m> inputs.
+ * Each operand should be a sequence of constraint letters as defined by
+ * tcg-target-con-str.h; the constraint combination is inclusive or.
+ */
+
+// Simple register functions.
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O0_I3(r, r, r)
+//C_O0_I4(r, r, r, r)
+C_O1_I1(r, r)
+C_O1_I2(r, r, r)
+//C_O1_I4(r, r, r, r, r)
+//C_O2_I1(r, r, r)
+//C_O2_I2(r, r, r, r)
+//C_O2_I4(r, r, r, r, r, r)
+
+// Vector functions.
+C_O1_I1(w, w)
+C_O1_I1(w, r)
+C_O0_I2(w, r)
+C_O1_I1(w, wr)
+C_O1_I2(w, w, w)
+C_O1_I3(w, w, w, w)
+C_O1_I2(w, 0, w)
\ No newline at end of file
diff --git a/tcg/aarch64-tcti/tcg-target-con-str.h b/tcg/aarch64-tcti/tcg-target-con-str.h
new file mode 100644
index 0000000000..94d06d3e74
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-con-str.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define TCI target-specific operand constraints.
+ * Copyright (c) 2021 Linaro
+ */
+
+/*
+ * Define constraint letters for register sets:
+ * REGS(letter, register_mask)
+ */
+REGS('r', TCG_MASK_GP_REGISTERS)
+REGS('w', TCG_MASK_VECTOR_REGISTERS)
+
+/*
+ * Define constraint letters for constants:
+ * CONST(letter, TCG_CT_CONST_* bit set)
+ */
+
+// Simple 64-bit immediates.
+CONST('I', 0xFFFFFFFFFFFFFFFF)
diff --git a/tcg/aarch64-tcti/tcg-target-has.h b/tcg/aarch64-tcti/tcg-target-has.h
new file mode 100644
index 0000000000..67b50fcdea
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-has.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+//
+// Supported optional scalar instructions.
+//
+
+// Divs.
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+
+// Extends.
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_extr_i64_i32     0
+
+// Register extractions.
+#define TCG_TARGET_HAS_extrl_i64_i32    1
+#define TCG_TARGET_HAS_extrh_i64_i32    1
+
+// Negations.
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_not_i64          1
+
+// Logicals.
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_nand_i32         1
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_nand_i64         1
+
+// Bitwise operations.
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_tst              0
+
+// Swaps.
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+
+//
+// Supported optional vector instructions.
+//
+
+#define TCG_TARGET_HAS_v64              1
+#define TCG_TARGET_HAS_v128             1
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+
+//
+// Unsupported instructions.
+//
+
+// There's no direct instruction with which to count the number of ones,
+// so we'll leave this implemented as other instructions.
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_ctpop_i64        0
+
+// This operation exists specifically to allow us to provide differing register
+// constraints for 8-bit loads and stores. We don't need to do so, so we'll leave
+// this unimplemented, as we gain nothing by it.
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+#define TCG_TARGET_HAS_qemu_ldst_i128   0
+
+// These should always be zero on our 64B platform.
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_extract2_i64     0
+
+// We don't currently support gadgets with more than three arguments,
+// so we can't yet create movcond, deposit, or extract gadgets.
+#define TCG_TARGET_extract_valid(type, ofs, len)   0
+#define TCG_TARGET_sextract_valid(type, ofs, len)  0
+#define TCG_TARGET_deposit_valid(type, ofs, len)   0
diff --git a/tcg/aarch64-tcti/tcg-target-mo.h b/tcg/aarch64-tcti/tcg-target-mo.h
new file mode 100644
index 0000000000..d246f7fefe
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-mo.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific memory model
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_MO_H
+#define TCG_TARGET_MO_H
+
+// We'll need to enforce memory ordering with barriers.
+#define TCG_TARGET_DEFAULT_MO  (0)
+ 
+#endif
diff --git a/tcg/aarch64-tcti/tcg-target-reg-bits.h b/tcg/aarch64-tcti/tcg-target-reg-bits.h
new file mode 100644
index 0000000000..43cf075f6f
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-reg-bits.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific register size
+ * Copyright (c) 2009, 2011 Stefan Weil
+ */
+
+#ifndef TCG_TARGET_REG_BITS_H
+#define TCG_TARGET_REG_BITS_H
+
+#if UINTPTR_MAX == UINT64_MAX
+# define TCG_TARGET_REG_BITS 64
+#else
+# error Unknown pointer size for tci target
+#endif
+
+#endif
diff --git a/tcg/aarch64-tcti/tcg-target.h b/tcg/aarch64-tcti/tcg-target.h
new file mode 100644
index 0000000000..e41b145158
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target.h
@@ -0,0 +1,107 @@
+/*
+ * Tiny Code Generator for QEMU
+ *
+ * Copyright (c) 2009, 2011 Stefan Weil
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/*
+ * This code implements a TCG which does not generate machine code for some
+ * real target machine but which generates virtual machine code for an
+ * interpreter. Interpreted pseudo code is slow, but it works on any host.
+ *
+ * Some remarks might help in understanding the code:
+ *
+ * "target" or "TCG target" is the machine which runs the generated code.
+ * This is different to the usual meaning in QEMU where "target" is the
+ * emulated machine. So normally QEMU host is identical to TCG target.
+ * Here the TCG target is a virtual machine, but this virtual machine must
+ * use the same word size like the real machine.
+ * Therefore, we need both 32 and 64 bit virtual machines (interpreter).
+ */
+
+#ifndef TCG_TARGET_H
+#define TCG_TARGET_H
+
+#define TCG_TARGET_INSN_UNIT_SIZE        1
+#define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
+
+// We're an interpreted target; even if we're JIT-compiling to our interpreter's
+// weird psuedo-native bytecode. We'll indicate that we're intepreted.
+#define TCG_TARGET_INTERPRETER 1
+
+#include "tcg-target-has.h"
+
+//
+// Platform metadata.
+//
+
+// Number of registers available.
+#define TCG_TARGET_NB_REGS 64
+
+// Number of general purpose registers.
+#define TCG_TARGET_GP_REGS 16
+
+/* List of registers which are used by TCG. */
+typedef enum {
+
+    // General purpose registers.
+    // Note that we name every _host_ register here; but don't 
+    // necessarily use them; that's determined by the allocation order
+    // and the number of registers setting above. These just give us the ability
+    // to refer to these by name.
+    TCG_REG_R0, TCG_REG_R1, TCG_REG_R2, TCG_REG_R3,
+    TCG_REG_R4, TCG_REG_R5, TCG_REG_R6, TCG_REG_R7,
+    TCG_REG_R8, TCG_REG_R9, TCG_REG_R10, TCG_REG_R11,
+    TCG_REG_R12, TCG_REG_R13, TCG_REG_R14, TCG_REG_R15,
+    TCG_REG_R16, TCG_REG_R17, TCG_REG_R18, TCG_REG_R19,
+    TCG_REG_R20, TCG_REG_R21, TCG_REG_R22, TCG_REG_R23,
+    TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
+    TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
+
+    // Register aliases.
+    TCG_AREG0             = TCG_REG_R14,
+    TCG_REG_CALL_STACK    = TCG_REG_R15,
+
+    // Mask that refers to the GP registers.
+    TCG_MASK_GP_REGISTERS = 0xFFFFul, 
+
+    // Vector registers.
+    TCG_REG_V0 = 32, TCG_REG_V1, TCG_REG_V2, TCG_REG_V3,
+    TCG_REG_V4, TCG_REG_V5, TCG_REG_V6, TCG_REG_V7,
+    TCG_REG_V8, TCG_REG_V9, TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
+    // Mask that refers to the vector registers.
+    TCG_MASK_VECTOR_REGISTERS = 0xFFFF000000000000ul, 
+
+} TCGReg;
+
+// We're interpreted, so we'll use our own code to run TB_EXEC.
+#define HAVE_TCG_QEMU_TB_EXEC
+
+void tci_disas(uint8_t opc);
+
+
+#endif /* TCG_TARGET_H */
diff --git a/host/include/generic/host/atomic128-cas.h.inc b/host/include/generic/host/atomic128-cas.h.inc
index 6b40cc2271..6c788450ea 100644
--- a/host/include/generic/host/atomic128-cas.h.inc
+++ b/host/include/generic/host/atomic128-cas.h.inc
@@ -11,7 +11,8 @@
 #ifndef HOST_ATOMIC128_CAS_H
 #define HOST_ATOMIC128_CAS_H
 
-#if defined(CONFIG_ATOMIC128)
+/* FIXME: this doesn't work in TCTI */
+#if defined(CONFIG_ATOMIC128) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
 {
diff --git a/tcg/aarch64-tcti/tcg-target-opc.h.inc b/tcg/aarch64-tcti/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..5382315c41
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target-opc.h.inc
@@ -0,0 +1,15 @@
+/*
+ * Copyright (c) 2019 Linaro
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
+
+DEF(aa64_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(aa64_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..1040af2d22 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2890,7 +2890,8 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
 #include "atomic_template.h"
 #endif
 
-#if defined(CONFIG_ATOMIC128) || HAVE_CMPXCHG128
+/* FIXME: this doesn't work in TCTI */
+#if (defined(CONFIG_ATOMIC128) && !defined(CONFIG_TCG_THREADED_INTERPRETER)) || HAVE_CMPXCHG128
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index d9b662efe3..5564b483a8 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -64,6 +64,14 @@ void tcg_cpu_init_cflags(CPUState *cpu, bool parallel)
 
     cflags |= parallel ? CF_PARALLEL : 0;
     cflags |= icount_enabled() ? CF_USE_ICOUNT : 0;
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+    /*
+     * GOTO_PTR is too complex to emit a simple gadget for.
+     * We'll let C handle it, since the overhead is similar.
+     */
+    cflags |= CF_NO_GOTO_PTR;
+    cpu->cflags_next_tb = CF_NO_GOTO_PTR;
+#endif
     tcg_cflags_set(cpu, cflags);
 }
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f922f86a1d..418c068fe4 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2958,6 +2958,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ld32u_i64:
             done = fold_tcg_ld(&ctx, op);
             break;
+#if !defined(CONFIG_TCG_THREADED_INTERPRETER) /* FIXME: this breaks TCTI */
         case INDEX_op_ld_i32:
         case INDEX_op_ld_i64:
         case INDEX_op_ld_vec:
@@ -2973,6 +2974,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_st_vec:
             done = fold_tcg_st_memcopy(&ctx, op);
             break;
+#endif
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4..70996b5ab1 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -568,7 +568,7 @@ static int alloc_code_gen_buffer_anon(size_t size, int prot,
     return prot;
 }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
 #ifdef CONFIG_POSIX
 #include "qemu/memfd.h"
 
@@ -670,7 +670,7 @@ static int alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
 
 static int alloc_code_gen_buffer_splitwx(size_t size, Error **errp)
 {
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
 # ifdef CONFIG_DARWIN
     return alloc_code_gen_buffer_splitwx_vmremap(size, errp);
 # endif
@@ -710,7 +710,10 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
      */
     prot = PROT_NONE;
     flags = MAP_PRIVATE | MAP_ANONYMOUS;
-#ifdef CONFIG_DARWIN
+#if defined(CONFIG_TCG_INTERPRETER) || defined(CONFIG_TCG_THREADED_INTERPRETER)
+    /* The tcg interpreter does not need execute permission. */
+    prot = PROT_READ | PROT_WRITE;
+#elif defined(CONFIG_DARWIN)
     /* Applicable to both iOS and macOS (Apple Silicon). */
     if (!splitwx) {
         flags |= MAP_JIT;
@@ -816,7 +819,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * Work with the page protections set up with the initial mapping.
      */
     need_prot = PROT_READ | PROT_WRITE;
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
     if (tcg_splitwx_diff == 0) {
         need_prot |= host_prot_read_exec();
     }
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fec6d678a2..e58b3fefd3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1150,7 +1150,18 @@ void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i32(ret, v2);
     } else {
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_negsetcond_i32(cond, t0, c1, c2);
+        tcg_gen_and_i32(t1, v1, t0);
+        tcg_gen_andc_i32(ret, v2, t0);
+        tcg_gen_or_i32(ret, ret, t1);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
+#else
         tcg_gen_op6i_i32(INDEX_op_movcond_i32, ret, c1, c2, v1, v2, cond);
+#endif
     }
 }
 
@@ -3002,8 +3013,23 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
     } else if (cond == TCG_COND_NEVER) {
         tcg_gen_mov_i64(ret, v2);
     } else if (TCG_TARGET_REG_BITS == 64) {
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+        tcg_gen_negsetcond_i64(cond, t0, c1, c2);
+        tcg_gen_and_i64(t1, v1, t0);
+        tcg_gen_andc_i64(ret, v2, t0);
+        tcg_gen_or_i64(ret, ret, t1);
+        tcg_temp_free_i64(t0);
+        tcg_temp_free_i64(t1);
+#else
         tcg_gen_op6i_i64(INDEX_op_movcond_i64, ret, c1, c2, v1, v2, cond);
+#endif
     } else {
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+        /* we do not support 32-bit TCTI */
+        g_assert_not_reached();
+#else
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
 
@@ -3017,6 +3043,7 @@ void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                             TCGV_HIGH(v1), TCGV_HIGH(v2));
 
         tcg_temp_free_i32(t0);
+#endif
     }
 }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index dfd48b8264..229687c0c2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -251,7 +251,7 @@ TCGv_env tcg_env;
 const void *tcg_code_gen_epilogue;
 uintptr_t tcg_splitwx_diff;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
 tcg_prologue_fn *tcg_qemu_tb_exec;
 #endif
 
@@ -956,7 +956,7 @@ static const TCGConstraintSet constraint_sets[] = {
 
 #include "tcg-target.c.inc"
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
 /* Validate CPUTLBDescFast placement. */
 QEMU_BUILD_BUG_ON((int)(offsetof(CPUNegativeOffsetState, tlb.f[0]) -
                         sizeof(CPUNegativeOffsetState))
@@ -1593,7 +1593,7 @@ void tcg_prologue_init(void)
     s->code_buf = s->code_gen_ptr;
     s->data_gen_ptr = NULL;
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
     tcg_qemu_tb_exec = (tcg_prologue_fn *)tcg_splitwx_to_rx(s->code_ptr);
 #endif
 
@@ -1612,7 +1612,7 @@ void tcg_prologue_init(void)
     prologue_size = tcg_current_code_size(s);
     perf_report_prologue(s->code_gen_ptr, prologue_size);
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf, prologue_size);
 #endif
@@ -1649,7 +1649,7 @@ void tcg_prologue_init(void)
         }
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
     /*
      * Assert that goto_ptr is implemented completely, setting an epilogue.
      * For tci, we use NULL as the signal to return from the interpreter,
@@ -2137,6 +2137,12 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     }
 
     switch (op) {
+    case INDEX_op_goto_ptr:
+#if defined(CONFIG_TCG_THREADED_INTERPRETER)
+        return false;
+#else
+        return true;
+#endif
     case INDEX_op_discard:
     case INDEX_op_set_label:
     case INDEX_op_call:
@@ -2145,7 +2151,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_insn_start:
     case INDEX_op_exit_tb:
     case INDEX_op_goto_tb:
-    case INDEX_op_goto_ptr:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_ld_i64:
@@ -6498,7 +6503,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
         return -2;
     }
 
-#ifndef CONFIG_TCG_INTERPRETER
+#if !defined(CONFIG_TCG_INTERPRETER) && !defined(CONFIG_TCG_THREADED_INTERPRETER)
     /* flush instruction cache */
     flush_idcache_range((uintptr_t)tcg_splitwx_to_rx(s->code_buf),
                         (uintptr_t)s->code_buf,
diff --git a/tcg/aarch64-tcti/tcg-target.c.inc b/tcg/aarch64-tcti/tcg-target.c.inc
new file mode 100644
index 0000000000..8b78abe4bb
--- /dev/null
+++ b/tcg/aarch64-tcti/tcg-target.c.inc
@@ -0,0 +1,2250 @@
+/*
+ * Tiny Code Threaded Intepreter for QEMU
+ *
+ * Copyright (c) 2021 Kate Temkin
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+
+// Rich disassembly is nice in theory, but it's -slow-.
+//#define TCTI_GADGET_RICH_DISASSEMBLY
+
+#define TCTI_GADGET_IMMEDIATE_ARRAY_LEN 64
+
+// Specify the shape of the stack our runtime will use.
+#define TCG_TARGET_CALL_STACK_OFFSET    0
+#define TCG_TARGET_STACK_ALIGN          16
+#define TCG_TARGET_CALL_ARG_I32         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64         TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128        TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
+
+#include "tcg/tcg-ldst.h"
+
+// Grab our gadget headers.
+#include "tcti_gadgets.h"
+
+/* Marker for missing code. */
+#define TODO() \
+    do { \
+        fprintf(stderr, "TODO %s:%u: %s()\n", \
+                __FILE__, __LINE__, __func__); \
+        g_assert_not_reached(); \
+    } while (0)
+
+
+/* Enable TCTI assertions only when debugging TCG (and without NDEBUG defined).
+ * Without assertions, the interpreter runs much faster. */
+#if defined(CONFIG_DEBUG_TCG)
+# define tcti_assert(cond) assert(cond)
+#else
+# define tcti_assert(cond) ((void)0)
+#endif
+
+
+/********************************
+ *  TCG Constraints Definitions *
+ ********************************/
+
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
+{
+    switch (op) {
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8s_i32:
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16s_i32:
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld8u_i64:
+    case INDEX_op_ld8s_i64:
+    case INDEX_op_ld16u_i64:
+    case INDEX_op_ld16s_i64:
+    case INDEX_op_ld32u_i64:
+    case INDEX_op_ld32s_i64:
+    case INDEX_op_ld_i64:
+    case INDEX_op_not_i32:
+    case INDEX_op_not_i64:
+    case INDEX_op_neg_i32:
+    case INDEX_op_neg_i64:
+    case INDEX_op_ext8s_i32:
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_bswap16_i32:
+    case INDEX_op_bswap16_i64:
+    case INDEX_op_bswap32_i32:
+    case INDEX_op_bswap32_i64:
+    case INDEX_op_bswap64_i64:
+    case INDEX_op_extrl_i64_i32:
+    case INDEX_op_extrh_i64_i32:
+        return C_O1_I1(r, r);
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_div_i32:
+    case INDEX_op_div_i64:
+    case INDEX_op_divu_i32:
+    case INDEX_op_divu_i64:
+    case INDEX_op_rem_i32:
+    case INDEX_op_rem_i64:
+    case INDEX_op_remu_i32:
+    case INDEX_op_remu_i64:
+    case INDEX_op_add_i32:
+    case INDEX_op_add_i64:
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+    case INDEX_op_mul_i32:
+    case INDEX_op_mul_i64:
+    case INDEX_op_and_i32:
+    case INDEX_op_and_i64:
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+    case INDEX_op_nand_i32:
+    case INDEX_op_nand_i64:
+    case INDEX_op_nor_i32:
+    case INDEX_op_nor_i64:
+    case INDEX_op_or_i32:
+    case INDEX_op_or_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_xor_i32:
+    case INDEX_op_xor_i64:
+    case INDEX_op_shl_i32:
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i32:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i32:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz_i64:
+        return C_O1_I2(r, r, r);
+
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        return C_O0_I2(r, r);
+
+    case INDEX_op_qemu_ld_i32:
+    case INDEX_op_qemu_ld_i64:
+        return C_O1_I2(r, r, r);
+    case INDEX_op_qemu_st_i32:
+    case INDEX_op_qemu_st_i64:
+        return C_O0_I3(r, r, r);
+
+    //
+    // Vector ops.
+    //
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_mul_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_aa64_sshl_vec:
+        return C_O1_I2(w, w, w);
+    case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+        return C_O1_I1(w, w);
+    case INDEX_op_ld_vec:
+    case INDEX_op_dupm_vec:
+        return C_O1_I1(w, r);
+    case INDEX_op_st_vec:
+        return C_O0_I2(w, r);
+    case INDEX_op_dup_vec:
+        return C_O1_I1(w, wr);
+    case INDEX_op_or_vec:
+    case INDEX_op_andc_vec:
+        return C_O1_I2(w, w, w);
+    case INDEX_op_and_vec:
+    case INDEX_op_orc_vec:
+        return C_O1_I2(w, w, w);
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(w, w, w);
+    case INDEX_op_bitsel_vec:
+        return C_O1_I3(w, w, w, w);
+    case INDEX_op_aa64_sli_vec:
+        return C_O1_I2(w, 0, w);
+
+    default:
+        return C_NotImplemented;
+    }
+}
+
+static const int tcg_target_reg_alloc_order[] = {
+
+    // General purpose registers, in preference-of-allocation order.
+    TCG_REG_R8,
+    TCG_REG_R9,
+    TCG_REG_R10,
+    TCG_REG_R11,
+    TCG_REG_R12,
+    TCG_REG_R13,
+    TCG_REG_R0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+    TCG_REG_R6,
+    TCG_REG_R7,
+
+    // Note: we do not allocate R14 or R15, as they're used for our
+    // special-purpose values.
+
+    // We'll use the high 16 vector register; avoiding the call-saved lower ones.
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+};
+
+static const int tcg_target_call_iarg_regs[] = {
+    TCG_REG_R0,
+    TCG_REG_R1,
+    TCG_REG_R2,
+    TCG_REG_R3,
+    TCG_REG_R4,
+    TCG_REG_R5,
+};
+
+static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
+{
+    tcg_debug_assert(kind == TCG_CALL_RET_NORMAL);
+    tcg_debug_assert(slot >= 0 && slot < 128 / TCG_TARGET_REG_BITS);
+    return TCG_REG_R0 + slot;
+}
+
+#ifdef CONFIG_DEBUG_TCG
+static const char *const tcg_target_reg_names[TCG_TARGET_GP_REGS] = {
+    "r00",
+    "r01",
+    "r02",
+    "r03",
+    "r04",
+    "r05",
+    "r06",
+    "r07",
+    "r08",
+    "r09",
+    "r10",
+    "r11",
+    "r12",
+    "r13",
+    "r14",
+    "r15",
+};
+#endif
+
+/*************************
+ *  TCG Emitter Helpers  *
+ *************************/
+
+/* Bitfield n...m (in 32 bit value). */
+#define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
+
+/**
+ * Macro that defines a look-up tree for named QEMU_LD gadgets.
+ */
+#define LD_MEMOP_LOOKUP(variable, arg, suffix) \
+    switch (get_memop(arg) & MO_SSIZE) { \
+        case MO_UB:   variable = gadget_qemu_ld_ub_   ## suffix; break; \
+        case MO_SB:   variable = gadget_qemu_ld_sb_   ## suffix; break; \
+        case MO_UW: variable = gadget_qemu_ld_leuw_ ## suffix; break; \
+        case MO_SW: variable = gadget_qemu_ld_lesw_ ## suffix; break; \
+        case MO_UL: variable = gadget_qemu_ld_leul_ ## suffix; break; \
+        case MO_SL: variable = gadget_qemu_ld_lesl_ ## suffix; break; \
+        case MO_UQ:  variable = gadget_qemu_ld_leq_  ## suffix; break; \
+        default: \
+            g_assert_not_reached(); \
+    }
+#define LD_MEMOP_HANDLER(variable, arg, suffix, a_bits, s_bits) \
+        if (a_bits >= s_bits) { \
+            LD_MEMOP_LOOKUP(variable, arg, aligned_ ## suffix ); \
+        } else { \
+            LD_MEMOP_LOOKUP(gadget, arg, unaligned_ ## suffix); \
+        }
+
+
+
+/**
+ * Macro that defines a look-up tree for named QEMU_ST gadgets.
+ */
+#define ST_MEMOP_LOOKUP(variable, arg, suffix) \
+    switch (get_memop(arg) & MO_SSIZE) { \
+        case MO_UB:   variable = gadget_qemu_st_ub_   ## suffix; break; \
+        case MO_UW: variable = gadget_qemu_st_leuw_ ## suffix; break; \
+        case MO_UL: variable = gadget_qemu_st_leul_ ## suffix; break; \
+        case MO_UQ:  variable = gadget_qemu_st_leq_  ## suffix; break; \
+        default: \
+            g_assert_not_reached(); \
+    }
+#define ST_MEMOP_HANDLER(variable, arg, suffix, a_bits, s_bits) \
+        if (a_bits >= s_bits) { \
+            ST_MEMOP_LOOKUP(variable, arg, aligned_ ## suffix ); \
+        } else { \
+            ST_MEMOP_LOOKUP(gadget, arg, unaligned_ ## suffix); \
+        }
+
+
+#define LOOKUP_SPECIAL_CASE_LDST_GADGET(arg, name, mode) \
+    switch(tlb_mask_table_ofs(s, get_mmuidx(arg))) { \
+        case -32:  \
+            gadget = (a_bits >= s_bits) ?  \
+                gadget_qemu_ ## name ## _aligned_ ## mode ## _off32_i64 : \
+                gadget_qemu_ ## name ## _unaligned_ ## mode ## _off32_i64; \
+            break; \
+        case -48:  \
+            gadget = (a_bits >= s_bits) ?  \
+                gadget_qemu_ ## name ## _aligned_ ## mode ## _off48_i64 : \
+                gadget_qemu_ ## name ## _unaligned_ ## mode ## _off48_i64; \
+            break; \
+        case -64: \
+            gadget = (a_bits >= s_bits) ? \
+                gadget_qemu_ ## name ## _aligned_ ## mode ## _off64_i64 : \
+                gadget_qemu_ ## name ## _unaligned_ ## mode ## _off64_i64; \
+            break; \
+        case -96: \
+            gadget = (a_bits >= s_bits) ? \
+                gadget_qemu_ ## name ## _aligned_ ## mode ## _off96_i64 : \
+                gadget_qemu_ ## name ## _unaligned_ ## mode ## _off96_i64; \
+            break; \
+        case -128: \
+            gadget = (a_bits >= s_bits) ? \
+                gadget_qemu_ ## name ## _aligned_ ## mode ## _off128_i64 : \
+                gadget_qemu_ ## name ## _unaligned_ ## mode ## _off128_i64; \
+            break;\
+        default: \
+            gadget = gadget_qemu_ ## name ## _slowpath_ ## mode ## _off0_i64; \
+            break; \
+        }
+
+
+static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
+                        intptr_t value, intptr_t addend)
+{
+    /* tcg_out_reloc always uses the same type, addend. */
+    tcg_debug_assert(type == sizeof(tcg_target_long));
+    tcg_debug_assert(addend == 0);
+    tcg_debug_assert(value != 0);
+    if (TCG_TARGET_REG_BITS == 32) {
+        tcg_patch32(code_ptr, value);
+    } else {
+        tcg_patch64(code_ptr, value);
+    }
+    return true;
+}
+
+#if defined(CONFIG_DEBUG_TCG_INTERPRETER)
+/* Show current bytecode. Used by tcg interpreter. */
+void tci_disas(uint8_t opc)
+{
+    const TCGOpDef *def = &tcg_op_defs[opc];
+    fprintf(stderr, "TCG %s %u, %u, %u\n",
+            def->name, def->nb_oargs, def->nb_iargs, def->nb_cargs);
+}
+#endif
+
+/* Write value (native size). */
+static void tcg_out_immediate(TCGContext *s, tcg_target_ulong v)
+{
+    if (TCG_TARGET_REG_BITS == 32) {
+        //tcg_out32(s, v);
+        tcg_out64(s, v);
+    } else {
+        tcg_out64(s, v);
+    }
+}
+
+void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
+                              uintptr_t jmp_rx, uintptr_t jmp_rw)
+{
+    /* Get a pointer to our immediate, which exists after a single pointer. */
+    uintptr_t immediate_addr = jmp_rw;
+    uintptr_t addr = tb->jmp_target_addr[n];
+
+    /* Patch it to be match our target address. */
+    qatomic_set((uint64_t *)immediate_addr, addr);
+}
+
+
+/**
+ * TCTI Thunk Helpers
+ */
+
+#ifdef CONFIG_SOFTMMU
+
+// TODO: relocate these prototypes?
+tcg_target_ulong helper_ldub_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr);
+tcg_target_ulong helper_lduw_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr);
+tcg_target_ulong helper_ldul_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr);
+
+tcg_target_ulong helper_ldub_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int8_t)helper_ldub_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_lduw_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int16_t)helper_lduw_mmu(env, addr, oi, retaddr);
+}
+
+tcg_target_ulong helper_ldul_mmu_signed(CPUArchState *env, uint64_t addr, MemOpIdx oi, uintptr_t retaddr)
+{
+    return (int32_t)helper_ldul_mmu(env, addr, oi, retaddr);
+}
+
+#else
+#error TCTI currently only supports use of the soft MMU.
+#endif
+
+
+/**
+ * TCTI Emmiter Helpers
+ */
+
+
+/* Write gadget pointer. */
+static void tcg_out_gadget(TCGContext *s, const void *gadget)
+{
+    tcg_out_immediate(s, (tcg_target_ulong)gadget);
+}
+
+/* Write gadget pointer, plus 64b immediate. */
+static void tcg_out_imm64_gadget(TCGContext *s, const void *gadget, tcg_target_ulong immediate)
+{
+    tcg_out_gadget(s, gadget);
+    tcg_out64(s, immediate);
+}
+
+
+/* Write gadget pointer (one register). */
+static void tcg_out_unary_gadget(TCGContext *s, const void *gadget_base[TCG_TARGET_GP_REGS], unsigned reg0)
+{
+    tcg_out_gadget(s, gadget_base[reg0]);
+}
+
+
+/* Write gadget pointer (two registers). */
+static void tcg_out_binary_gadget(TCGContext *s, const void *gadget_base[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS], unsigned reg0, unsigned reg1)
+{
+    tcg_out_gadget(s, gadget_base[reg0][reg1]);
+}
+
+
+/* Write gadget pointer (three registers). */
+static void tcg_out_ternary_gadget(TCGContext *s, const void *gadget_base[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS], unsigned reg0, unsigned reg1, unsigned reg2)
+{
+    tcg_out_gadget(s, gadget_base[reg0][reg1][reg2]);
+}
+
+
+/* Write gadget pointer (three registers, last is immediate value). */
+static void tcg_out_ternary_immediate_gadget(TCGContext *s, const void *gadget_base[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS][TCTI_GADGET_IMMEDIATE_ARRAY_LEN], unsigned reg0, unsigned reg1, unsigned reg2)
+{
+    tcg_out_gadget(s, gadget_base[reg0][reg1][reg2]);
+}
+
+/***************************
+ *  TCG Scalar Operations  *
+ ***************************/
+
+/**
+ * Version of our LDST generator that defers to more optimized gadgets selectively.
+ */
+static void tcg_out_ldst_gadget_inner(TCGContext *s,
+    const void *gadget_base[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS],
+    const void *gadget_pos_imm[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS][TCTI_GADGET_IMMEDIATE_ARRAY_LEN],
+    const void *gadget_shifted_imm[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS][TCTI_GADGET_IMMEDIATE_ARRAY_LEN],
+    const void *gadget_neg_imm[TCG_TARGET_GP_REGS][TCG_TARGET_GP_REGS][TCTI_GADGET_IMMEDIATE_ARRAY_LEN],
+    unsigned reg0, unsigned reg1, uint32_t offset)
+{
+    int64_t extended_offset = (int32_t)offset;
+    bool is_negative = (extended_offset < 0);
+
+    // Optimal case: we have a gadget that handles our specific offset, so we don't need to encode
+    // an immediate. This saves us a bunch of speed. :)
+
+    // We handle positive and negative gadgets separately, in order to allow for asymmetrical
+    // collections of pre-made gadgets.
+    if (!is_negative)
+    {
+        uint64_t shifted_offset = (extended_offset >> 3);
+        bool aligned_to_8B = ((extended_offset & 0b111) == 0);
+
+        bool have_optimized_gadget = (extended_offset < TCTI_GADGET_IMMEDIATE_ARRAY_LEN);
+        bool have_shifted_gadget   = (shifted_offset  < TCTI_GADGET_IMMEDIATE_ARRAY_LEN);
+
+        // More optimal case: we have a gadget that directly encodes the argument.
+        if (have_optimized_gadget) {
+            tcg_out_gadget(s, gadget_pos_imm[reg0][reg1][extended_offset]);
+            return;
+        }
+
+        // Special case: it's frequent to have low-numbered positive offsets that are aligned
+        // to 16B boundaries
+        else if(aligned_to_8B && have_shifted_gadget) {
+            tcg_out_gadget(s, gadget_shifted_imm[reg0][reg1][shifted_offset]);
+            return;
+        }
+    }
+    else {
+        uint64_t negated_offset = -(extended_offset);
+
+        // More optimal case: we have a gadget that directly encodes the argument.
+        if (negated_offset < TCTI_GADGET_IMMEDIATE_ARRAY_LEN) {
+            tcg_out_gadget(s, gadget_neg_imm[reg0][reg1][negated_offset]);
+            return;
+        }
+    }
+
+    // Less optimal case: we don't have a gadget specifically for this. Emit the general case immediate.
+    tcg_out_binary_gadget(s, gadget_base, reg0, reg1);
+    tcg_out64(s, extended_offset); //tcg_out32(s, offset);
+}
+
+/* Shorthand for the above, that prevents us from having to specify the name three times. */
+#define tcg_out_ldst_gadget(s, name, a, b, c) \
+    tcg_out_ldst_gadget_inner(s, name, \
+        name ## _imm,  \
+        name ## _sh8_imm,  \
+        name ## _neg_imm, \
+    a, b, c)
+
+
+
+/* Write label. */
+static void tcti_out_label(TCGContext *s, TCGLabel *label)
+{
+    if (label->has_value) {
+        tcg_out64(s, label->u.value);
+        tcg_debug_assert(label->u.value);
+    } else {
+        tcg_out_reloc(s, s->code_ptr, sizeof(tcg_target_ulong), label, 0);
+        s->code_ptr += sizeof(tcg_target_ulong);
+    }
+}
+
+
+/* Register to register move using ORR (shifted register with no shift). */
+static void tcg_out_movr(TCGContext *s, TCGType ext, TCGReg rd, TCGReg rm)
+{
+    switch(ext) {
+        case TCG_TYPE_I32:
+            tcg_out_binary_gadget(s, gadget_mov_i32, rd, rm);
+            break;
+
+        case TCG_TYPE_I64:
+            tcg_out_binary_gadget(s, gadget_mov_i64, rd, rm);
+            break;
+
+        default:
+            g_assert_not_reached();
+
+    }
+}
+
+
+static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
+{
+    TCGReg w_ret = (ret - TCG_REG_V16);
+    TCGReg w_arg = (arg - TCG_REG_V16);
+
+    if (ret == arg) {
+        return true;
+    }
+
+    switch (type) {
+    case TCG_TYPE_I32:
+    case TCG_TYPE_I64:
+
+        // If this is a GP to GP register mov, issue our standard MOV.
+        if (ret < 32 && arg < 32) {
+            tcg_out_movr(s, type, ret, arg);
+            break;
+        } 
+        // If this is a vector register to GP, issue a UMOV.
+        else if (ret < 32) {
+            void *gadget = (type == TCG_TYPE_I32) ? gadget_umov_s0 : gadget_umov_d0;
+            tcg_out_binary_gadget(s, gadget, ret, w_arg);
+            break;
+        } 
+        
+        // If this is a GP to vector move, insert the vealue using INS.
+        else if (arg < 32) {
+            void *gadget = (type == TCG_TYPE_I32) ? gadget_ins_s0 : gadget_ins_d0;
+            tcg_out_binary_gadget(s, gadget, w_ret, arg);
+            break;
+        }
+        /* FALLTHRU */
+
+    case TCG_TYPE_V64:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_ternary_gadget(s, gadget_or_d, w_ret, w_arg, w_arg);
+        break;
+
+    case TCG_TYPE_V128:
+        tcg_debug_assert(ret >= 32 && arg >= 32);
+        tcg_out_ternary_gadget(s, gadget_or_q, w_ret, w_arg, w_arg);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+
+
+static void tcg_out_movi_i32(TCGContext *s, TCGReg t0, tcg_target_long arg)
+{
+    bool is_negative = (arg < 0);
+
+    // We handle positive and negative gadgets separately, in order to allow for asymmetrical
+    // collections of pre-made gadgets.
+    if (!is_negative)
+    {
+        // More optimal case: we have a gadget that directly encodes the argument.
+        if (arg < ARRAY_SIZE(gadget_movi_imm_i32[t0])) {
+            tcg_out_gadget(s, gadget_movi_imm_i32[t0][arg]);
+            return;
+        }
+    }
+
+    // Emit the mov and its immediate.
+    tcg_out_unary_gadget(s, gadget_movi_i32, t0);
+    tcg_out64(s, arg); // TODO: make 32b?
+}
+
+
+static void tcg_out_movi_i64(TCGContext *s, TCGReg t0, tcg_target_long arg)
+{
+    uint8_t is_negative = arg < 0;
+
+    // We handle positive and negative gadgets separately, in order to allow for asymmetrical
+    // collections of pre-made gadgets.
+    if (!is_negative)
+    {
+        // More optimal case: we have a gadget that directly encodes the argument.
+        if (arg < ARRAY_SIZE(gadget_movi_imm_i64[t0])) {
+            tcg_out_gadget(s, gadget_movi_imm_i64[t0][arg]);
+            return;
+        }
+    }
+
+    // TODO: optimize the negative case, too?
+
+    // Less optimal case: emit the mov and its immediate.
+    tcg_out_unary_gadget(s, gadget_movi_i64, t0);
+    tcg_out64(s, arg);
+}
+
+
+/**
+ * Generate an immediate-to-register MOV.
+ */
+static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg t0, tcg_target_long arg)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_movi_i32(s, t0, arg);
+    } else {
+        tcg_out_movi_i64(s, t0, arg);
+    }
+}
+
+static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i32);
+        tcg_out_binary_gadget(s, gadget_ext8s_i32, rd, rs);
+        break;
+#if TCG_TARGET_REG_BITS == 64
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_HAS_ext8s_i64);
+        tcg_out_binary_gadget(s, gadget_ext8s_i64, rd, rs);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_ext8u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_binary_gadget(s, gadget_ext8u, rd, rs);
+}
+
+static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
+{
+    switch (type) {
+    case TCG_TYPE_I32:
+        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i32);
+        tcg_out_binary_gadget(s, gadget_ext16s_i32, rd, rs);
+        break;
+#if TCG_TARGET_REG_BITS == 64
+    case TCG_TYPE_I64:
+        tcg_debug_assert(TCG_TARGET_HAS_ext16s_i64);
+        tcg_out_binary_gadget(s, gadget_ext16s_i64, rd, rs);
+        break;
+#endif
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_ext16u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_binary_gadget(s, gadget_ext16u, rd, rs);
+}
+
+static void tcg_out_ext32s(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_debug_assert(TCG_TARGET_HAS_ext32s_i64);
+    tcg_out_binary_gadget(s, gadget_ext32s_i64, rd, rs);
+}
+
+static void tcg_out_ext32u(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_debug_assert(TCG_TARGET_HAS_ext32u_i64);
+    tcg_out_binary_gadget(s, gadget_ext32u_i64, rd, rs);
+}
+
+static void tcg_out_exts_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32s(s, rd, rs);
+}
+
+static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
+    tcg_out_binary_gadget(s, gadget_extrl, rd, rs);
+}
+
+static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
+{
+    return false;
+}
+
+static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
+                              tcg_target_long imm)
+{
+    /* This function is only used for passing structs by reference. */
+    g_assert_not_reached();
+}
+
+/**
+ * Generate a CALL.
+ */
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    tcg_out_gadget(s, gadget_call);
+    tcg_out64(s, (uintptr_t)func);
+}
+
+/**
+ * Generates LD instructions.
+ */
+static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg1,
+                       intptr_t arg2)
+{
+
+    if (type == TCG_TYPE_I32) {
+        tcg_out_ldst_gadget(s, gadget_ld32u, ret, arg1, arg2);
+    } else {
+        tcg_out_ldst_gadget(s, gadget_ld_i64, ret, arg1, arg2);
+    }
+}
+
+static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
+{
+    // Emit a simple gadget with a known return code.
+    tcg_out_imm64_gadget(s, gadget_exit_tb, arg);
+}
+
+static void tcg_out_goto_tb(TCGContext *s, int which)
+{
+    // If we're using a direct jump, we'll emit a "relocation" that can be usd
+    // to patch our gadget stream with the target address, later.
+
+    // Emit our gadget.
+    tcg_out_gadget(s, gadget_br);
+
+    // Place our current instruction into our "relocation table", so it can
+    // be patched once we know where the branch will target...
+    s->gen_tb->jmp_insn_offset[which] = tcg_current_code_size(s);
+
+    // ... and emit our relocation.
+    tcg_out64(s, which);
+
+    set_jmp_reset_offset(s, which);
+}
+
+/* We expect to use a 7-bit scaled negative offset from ENV.  */
+#define MIN_TLB_MASK_TABLE_OFS  -512
+
+/**
+ * Generate every other operation.
+ */
+static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
+                       const TCGArg args[TCG_MAX_OP_ARGS],
+                       const int const_args[TCG_MAX_OP_ARGS])
+{
+    switch (opc) {
+
+    // Simple branch.
+    case INDEX_op_br:
+        tcg_out_gadget(s, gadget_br);
+        tcti_out_label(s, arg_label(args[0]));
+        break;
+
+
+    // Set condition flag.
+    // a0 = Rd, a1 = Rn, a2 = Rm
+    case INDEX_op_setcond_i32:
+    {
+        void *gadget;
+
+        // We have to emit a different gadget per condition; we'll select which.
+        switch(args[3]) {
+            case TCG_COND_EQ:  gadget = gadget_setcond_i32_eq; break;
+            case TCG_COND_NE:  gadget = gadget_setcond_i32_ne; break;
+            case TCG_COND_LT:  gadget = gadget_setcond_i32_lt; break;
+            case TCG_COND_GE:  gadget = gadget_setcond_i32_ge; break;
+            case TCG_COND_LE:  gadget = gadget_setcond_i32_le; break;
+            case TCG_COND_GT:  gadget = gadget_setcond_i32_gt; break;
+            case TCG_COND_LTU: gadget = gadget_setcond_i32_lo; break;
+            case TCG_COND_GEU: gadget = gadget_setcond_i32_hs; break;
+            case TCG_COND_LEU: gadget = gadget_setcond_i32_ls; break;
+            case TCG_COND_GTU: gadget = gadget_setcond_i32_hi; break;
+            default:
+                g_assert_not_reached();
+        }
+
+        tcg_out_ternary_gadget(s, gadget, args[0], args[1], args[2]);
+        break;
+    }
+
+    case INDEX_op_setcond_i64:
+    {
+        void *gadget;
+
+        // We have to emit a different gadget per condition; we'll select which.
+        switch(args[3]) {
+            case TCG_COND_EQ:  gadget = gadget_setcond_i64_eq; break;
+            case TCG_COND_NE:  gadget = gadget_setcond_i64_ne; break;
+            case TCG_COND_LT:  gadget = gadget_setcond_i64_lt; break;
+            case TCG_COND_GE:  gadget = gadget_setcond_i64_ge; break;
+            case TCG_COND_LE:  gadget = gadget_setcond_i64_le; break;
+            case TCG_COND_GT:  gadget = gadget_setcond_i64_gt; break;
+            case TCG_COND_LTU: gadget = gadget_setcond_i64_lo; break;
+            case TCG_COND_GEU: gadget = gadget_setcond_i64_hs; break;
+            case TCG_COND_LEU: gadget = gadget_setcond_i64_ls; break;
+            case TCG_COND_GTU: gadget = gadget_setcond_i64_hi; break;
+            default:
+                g_assert_not_reached();
+        }
+
+        tcg_out_ternary_gadget(s, gadget, args[0], args[1], args[2]);
+        break;
+    }
+
+    /**
+     * Load instructions.
+     */
+
+    case INDEX_op_ld8u_i32:
+    case INDEX_op_ld8u_i64:
+        tcg_out_ldst_gadget(s, gadget_ld8u, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld8s_i32:
+        tcg_out_ldst_gadget(s, gadget_ld8s_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld8s_i64:
+        tcg_out_ldst_gadget(s, gadget_ld8s_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld16u_i32:
+    case INDEX_op_ld16u_i64:
+        tcg_out_ldst_gadget(s, gadget_ld16u, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld16s_i32:
+        tcg_out_ldst_gadget(s, gadget_ld16s_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld16s_i64:
+        tcg_out_ldst_gadget(s, gadget_ld16s_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld_i32:
+    case INDEX_op_ld32u_i64:
+        tcg_out_ldst_gadget(s, gadget_ld32u, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ld_i64:
+        tcg_out_ldst_gadget(s, gadget_ld_i64, args[0], args[1], args[2]);
+        break;
+   
+    case INDEX_op_ld32s_i64:
+        tcg_out_ldst_gadget(s, gadget_ld32s_i64, args[0], args[1], args[2]);
+        break;
+
+
+    /**
+     * Store instructions.
+     */
+    case INDEX_op_st8_i32:
+    case INDEX_op_st8_i64:
+        tcg_out_ldst_gadget(s, gadget_st8, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_st16_i32:
+    case INDEX_op_st16_i64:
+        tcg_out_ldst_gadget(s, gadget_st16, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_st_i32:
+    case INDEX_op_st32_i64:
+        tcg_out_ldst_gadget(s, gadget_st_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_st_i64:
+        tcg_out_ldst_gadget(s, gadget_st_i64, args[0], args[1], args[2]);
+        break;
+
+    /**
+     * Arithmetic instructions.
+     */
+
+    case INDEX_op_add_i32:
+        tcg_out_ternary_gadget(s, gadget_add_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_sub_i32:
+        tcg_out_ternary_gadget(s, gadget_sub_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_mul_i32:
+        tcg_out_ternary_gadget(s, gadget_mul_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_nand_i32:     /* Optional (TCG_TARGET_HAS_nand_i32). */
+        tcg_out_ternary_gadget(s, gadget_nand_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_nor_i32:     /* Optional (TCG_TARGET_HAS_nor_i32). */
+        tcg_out_ternary_gadget(s, gadget_nor_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_and_i32:
+        tcg_out_ternary_gadget(s, gadget_and_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_andc_i32:     /* Optional (TCG_TARGET_HAS_andc_i32). */
+        tcg_out_ternary_gadget(s, gadget_andc_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_orc_i32:      /* Optional (TCG_TARGET_HAS_orc_i64). */
+        tcg_out_ternary_gadget(s, gadget_orc_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_eqv_i32:      /* Optional (TCG_TARGET_HAS_orc_i64). */
+        tcg_out_ternary_gadget(s, gadget_eqv_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_or_i32:
+        tcg_out_ternary_gadget(s, gadget_or_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_xor_i32:
+        tcg_out_ternary_gadget(s, gadget_xor_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_shl_i32:
+        tcg_out_ternary_gadget(s, gadget_shl_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_shr_i32:
+        tcg_out_ternary_gadget(s, gadget_shr_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_sar_i32:
+        tcg_out_ternary_gadget(s, gadget_sar_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rotr_i32:     /* Optional (TCG_TARGET_HAS_rot_i32). */
+        tcg_out_ternary_gadget(s, gadget_rotr_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rotl_i32:     /* Optional (TCG_TARGET_HAS_rot_i32). */
+        tcg_out_ternary_gadget(s, gadget_rotl_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_add_i64:
+        tcg_out_ternary_gadget(s, gadget_add_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_sub_i64:
+        tcg_out_ternary_gadget(s, gadget_sub_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_mul_i64:
+        tcg_out_ternary_gadget(s, gadget_mul_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_and_i64:
+        tcg_out_ternary_gadget(s, gadget_and_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_andc_i64:     /* Optional (TCG_TARGET_HAS_andc_i64). */
+        tcg_out_ternary_gadget(s, gadget_andc_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_orc_i64:      /* Optional (TCG_TARGET_HAS_orc_i64). */
+        tcg_out_ternary_gadget(s, gadget_orc_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_eqv_i64:      /* Optional (TCG_TARGET_HAS_eqv_i64). */
+        tcg_out_ternary_gadget(s, gadget_eqv_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_nand_i64:     /* Optional (TCG_TARGET_HAS_nand_i64). */
+        tcg_out_ternary_gadget(s, gadget_nand_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_nor_i64:      /* Optional (TCG_TARGET_HAS_nor_i64). */
+        tcg_out_ternary_gadget(s, gadget_nor_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_or_i64:
+        tcg_out_ternary_gadget(s, gadget_or_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_xor_i64:
+        tcg_out_ternary_gadget(s, gadget_xor_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_shl_i64:
+        tcg_out_ternary_gadget(s, gadget_shl_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_shr_i64:
+        tcg_out_ternary_gadget(s, gadget_shr_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_sar_i64:
+        tcg_out_ternary_gadget(s, gadget_sar_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rotl_i64:     /* Optional (TCG_TARGET_HAS_rot_i64). */
+        tcg_out_ternary_gadget(s, gadget_rotl_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rotr_i64:     /* Optional (TCG_TARGET_HAS_rot_i64). */
+        tcg_out_ternary_gadget(s, gadget_rotr_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_div_i64:      /* Optional (TCG_TARGET_HAS_div_i64). */
+        tcg_out_ternary_gadget(s, gadget_div_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_divu_i64:     /* Optional (TCG_TARGET_HAS_div_i64). */
+        tcg_out_ternary_gadget(s, gadget_divu_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rem_i64:      /* Optional (TCG_TARGET_HAS_div_i64). */
+        tcg_out_ternary_gadget(s, gadget_rem_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_remu_i64:     /* Optional (TCG_TARGET_HAS_div_i64). */
+        tcg_out_ternary_gadget(s, gadget_remu_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_brcond_i64:
+    {
+        static uint8_t last_brcond_i64 = 0;
+        void *gadget;
+
+        // We have to emit a different gadget per condition; we'll select which.
+        switch(args[2]) {
+            case TCG_COND_EQ:  gadget = gadget_brcond_i64_eq; break;
+            case TCG_COND_NE:  gadget = gadget_brcond_i64_ne; break;
+            case TCG_COND_LT:  gadget = gadget_brcond_i64_lt; break;
+            case TCG_COND_GE:  gadget = gadget_brcond_i64_ge; break;
+            case TCG_COND_LE:  gadget = gadget_brcond_i64_le; break;
+            case TCG_COND_GT:  gadget = gadget_brcond_i64_gt; break;
+            case TCG_COND_LTU: gadget = gadget_brcond_i64_lo; break;
+            case TCG_COND_GEU: gadget = gadget_brcond_i64_hs; break;
+            case TCG_COND_LEU: gadget = gadget_brcond_i64_ls; break;
+            case TCG_COND_GTU: gadget = gadget_brcond_i64_hi; break;
+            default:
+                g_assert_not_reached();
+        }
+
+        // We'll select the which branch to used based on a cycling counter.
+        // This means we'll pick one of 16 identical brconds. Spreading this out
+        // helps the processor's branch prediction be less "squished", as not every
+        // branch is going throuh the same instruction.
+        tcg_out_ternary_gadget(s, gadget, last_brcond_i64, args[0], args[1]);
+        last_brcond_i64 = (last_brcond_i64 + 1) % TCG_TARGET_GP_REGS;
+
+        // Branch target immediate.
+        tcti_out_label(s, arg_label(args[3]));
+        break;
+    }
+
+
+    case INDEX_op_bswap16_i32:  /* Optional (TCG_TARGET_HAS_bswap16_i32). */
+    case INDEX_op_bswap16_i64:  /* Optional (TCG_TARGET_HAS_bswap16_i64). */
+        tcg_out_binary_gadget(s, gadget_bswap16, args[0], args[1]);
+        break;
+
+    case INDEX_op_bswap32_i32:  /* Optional (TCG_TARGET_HAS_bswap32_i32). */
+    case INDEX_op_bswap32_i64:  /* Optional (TCG_TARGET_HAS_bswap32_i64). */
+        tcg_out_binary_gadget(s, gadget_bswap32, args[0], args[1]);
+        break;
+
+    case INDEX_op_bswap64_i64:  /* Optional (TCG_TARGET_HAS_bswap64_i64). */
+        tcg_out_binary_gadget(s, gadget_bswap64, args[0], args[1]);
+        break;
+
+    case INDEX_op_not_i64:      /* Optional (TCG_TARGET_HAS_not_i64). */
+        tcg_out_binary_gadget(s, gadget_not_i64, args[0], args[1]);
+        break;
+
+    case INDEX_op_neg_i64:      /* Optional (TCG_TARGET_HAS_neg_i64). */
+        tcg_out_binary_gadget(s, gadget_neg_i64, args[0], args[1]);
+        break;
+
+    case INDEX_op_clz_i64:      /* Optional (TCG_TARGET_HAS_clz_i64). */
+        tcg_out_ternary_gadget(s, gadget_clz_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ctz_i64:      /* Optional (TCG_TARGET_HAS_ctz_i64). */
+        tcg_out_ternary_gadget(s, gadget_ctz_i64, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_extrh_i64_i32:
+        tcg_out_binary_gadget(s, gadget_extrh, args[0], args[1]);
+        break;
+
+    case INDEX_op_neg_i32:      /* Optional (TCG_TARGET_HAS_neg_i32). */
+        tcg_out_binary_gadget(s, gadget_neg_i32, args[0], args[1]);
+        break;
+
+    case INDEX_op_clz_i32:      /* Optional (TCG_TARGET_HAS_clz_i32). */
+        tcg_out_ternary_gadget(s, gadget_clz_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_ctz_i32:      /* Optional (TCG_TARGET_HAS_ctz_i32). */
+        tcg_out_ternary_gadget(s, gadget_ctz_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_not_i32:      /* Optional (TCG_TARGET_HAS_not_i32). */
+        tcg_out_binary_gadget(s, gadget_not_i32, args[0], args[1]);
+        break;
+
+    case INDEX_op_div_i32:      /* Optional (TCG_TARGET_HAS_div_i32). */
+        tcg_out_ternary_gadget(s, gadget_div_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_divu_i32:     /* Optional (TCG_TARGET_HAS_div_i32). */
+        tcg_out_ternary_gadget(s, gadget_divu_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_rem_i32:      /* Optional (TCG_TARGET_HAS_div_i32). */
+        tcg_out_ternary_gadget(s, gadget_rem_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_remu_i32:     /* Optional (TCG_TARGET_HAS_div_i32). */
+        tcg_out_ternary_gadget(s, gadget_remu_i32, args[0], args[1], args[2]);
+        break;
+
+    case INDEX_op_brcond_i32:
+    {
+        static uint8_t last_brcond_i32 = 0;
+        void *gadget;
+
+        // We have to emit a different gadget per condition; we'll select which.
+        switch(args[2]) {
+            case TCG_COND_EQ:  gadget = gadget_brcond_i32_eq; break;
+            case TCG_COND_NE:  gadget = gadget_brcond_i32_ne; break;
+            case TCG_COND_LT:  gadget = gadget_brcond_i32_lt; break;
+            case TCG_COND_GE:  gadget = gadget_brcond_i32_ge; break;
+            case TCG_COND_LE:  gadget = gadget_brcond_i32_le; break;
+            case TCG_COND_GT:  gadget = gadget_brcond_i32_gt; break;
+            case TCG_COND_LTU: gadget = gadget_brcond_i32_lo; break;
+            case TCG_COND_GEU: gadget = gadget_brcond_i32_hs; break;
+            case TCG_COND_LEU: gadget = gadget_brcond_i32_ls; break;
+            case TCG_COND_GTU: gadget = gadget_brcond_i32_hi; break;
+            default:
+                g_assert_not_reached();
+        }
+
+        // We'll select the which branch to used based on a cycling counter.
+        // This means we'll pick one of 16 identical brconds. Spreading this out
+        // helps the processor's branch prediction be less "squished", as not every
+        // branch is going throuh the same instruction.
+        tcg_out_ternary_gadget(s, gadget, last_brcond_i32, args[0], args[1]);
+        last_brcond_i32 = (last_brcond_i32 + 1) % TCG_TARGET_GP_REGS;
+
+        // Branch target immediate.
+        tcti_out_label(s, arg_label(args[3]));
+
+        break;
+    }
+
+    case INDEX_op_qemu_ld_i32:
+    {
+        MemOp opc = get_memop(args[2]);
+        unsigned a_bits = memop_alignment_bits(opc);
+        unsigned s_bits = opc & MO_SIZE;
+
+        void *gadget;
+
+        switch(tlb_mask_table_ofs(s, get_mmuidx(args[2]))) {
+            case -32:  LD_MEMOP_HANDLER(gadget, args[2],  off32_i32, a_bits, s_bits); break;
+            case -48:  LD_MEMOP_HANDLER(gadget, args[2],  off48_i32, a_bits, s_bits); break;
+            case -64:  LD_MEMOP_HANDLER(gadget, args[2],  off64_i32, a_bits, s_bits); break;
+            case -96:  LD_MEMOP_HANDLER(gadget, args[2],  off96_i32, a_bits, s_bits); break;
+            case -128: LD_MEMOP_HANDLER(gadget, args[2], off128_i32, a_bits, s_bits); break;
+            default:   LD_MEMOP_LOOKUP(gadget, args[2], slowpath_off0_i32); break;
+        }
+
+        // Args:
+        // - an immediate32 encodes our operation index
+        tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        tcg_out64(s, args[2]); // TODO: fix encoding to be 4b
+        break;
+    }
+
+    case INDEX_op_qemu_ld_i64:
+    {
+        MemOp opc = get_memop(args[2]);
+        unsigned a_bits = memop_alignment_bits(opc);
+        unsigned s_bits = opc & MO_SIZE;
+
+        void *gadget;
+
+        // Special optimization case: if we have an common case.
+        // Delegate to our special-case handler.
+        if (args[2] == 0x02) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], ld_ub, mode02)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        } else if (args[2] == 0x32) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], ld_leq, mode32)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        } else if(args[2] == 0x3a) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], ld_leq, mode3a)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        }
+        // Otherwise, handle the generic case.
+        else {
+            switch(tlb_mask_table_ofs(s, get_mmuidx(args[2]))) {
+                case -32:  LD_MEMOP_HANDLER(gadget, args[2],  off32_i64, a_bits, s_bits); break;
+                case -48:  LD_MEMOP_HANDLER(gadget, args[2],  off48_i64, a_bits, s_bits); break;
+                case -64:  LD_MEMOP_HANDLER(gadget, args[2],  off64_i64, a_bits, s_bits); break;
+                case -96:  LD_MEMOP_HANDLER(gadget, args[2],  off96_i64, a_bits, s_bits); break;
+                case -128: LD_MEMOP_HANDLER(gadget, args[2], off128_i64, a_bits, s_bits); break;
+                default:   LD_MEMOP_LOOKUP(gadget, args[2], slowpath_off0_i64); break;
+            }
+
+            // Args:
+            // - an immediate32 encodes our operation index
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+            tcg_out64(s, args[2]); // TODO: fix encoding to be 4b
+        }
+
+        break;
+    }
+
+    case INDEX_op_qemu_st_i32:
+    {
+        MemOp opc = get_memop(args[2]);
+        unsigned a_bits = memop_alignment_bits(opc);
+        unsigned s_bits = opc & MO_SIZE;
+
+        void *gadget;
+
+        switch(tlb_mask_table_ofs(s, get_mmuidx(args[2]))) {
+            case -32:  ST_MEMOP_HANDLER(gadget, args[2],  off32_i32, a_bits, s_bits); break;
+            case -48:  ST_MEMOP_HANDLER(gadget, args[2],  off48_i32, a_bits, s_bits); break;
+            case -64:  ST_MEMOP_HANDLER(gadget, args[2],  off64_i32, a_bits, s_bits); break;
+            case -96:  ST_MEMOP_HANDLER(gadget, args[2],  off96_i32, a_bits, s_bits); break;
+            case -128: ST_MEMOP_HANDLER(gadget, args[2], off128_i32, a_bits, s_bits); break;
+            default:   ST_MEMOP_LOOKUP(gadget, args[2], slowpath_off0_i32); break;
+        }
+
+        // Args:
+        // - our gadget encodes the target and address registers
+        // - an immediate32 encodes our operation index
+        tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        tcg_out64(s, args[2]); // FIXME: double encoded
+        break;
+    }
+
+    case INDEX_op_qemu_st_i64:
+    {
+        MemOp opc = get_memop(args[2]);
+        unsigned a_bits = memop_alignment_bits(opc);
+        unsigned s_bits = opc & MO_SIZE;
+
+        void *gadget;
+
+        // Special optimization case: if we have an common case.
+        // Delegate to our special-case handler.
+        if (args[2] == 0x02) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], st_ub, mode02)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        } else if (args[2] == 0x32) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], st_leq, mode32)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        } else if(args[2] == 0x3a) {
+            LOOKUP_SPECIAL_CASE_LDST_GADGET(args[2], st_leq, mode3a)
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+        }
+        // Otherwise, handle the generic case.
+        else {
+            switch(tlb_mask_table_ofs(s, get_mmuidx(args[2]))) {
+                case -32:  ST_MEMOP_HANDLER(gadget, args[2],  off32_i64, a_bits, s_bits); break;
+                case -48:  ST_MEMOP_HANDLER(gadget, args[2],  off48_i64, a_bits, s_bits); break;
+                case -64:  ST_MEMOP_HANDLER(gadget, args[2],  off64_i64, a_bits, s_bits); break;
+                case -96:  ST_MEMOP_HANDLER(gadget, args[2],  off96_i64, a_bits, s_bits); break;
+                case -128: ST_MEMOP_HANDLER(gadget, args[2], off128_i64, a_bits, s_bits); break;
+                default:   ST_MEMOP_LOOKUP(gadget, args[2], slowpath_off0_i64); break;
+            }
+
+            // Args:
+            // - our gadget encodes the target and address registers
+            // - an immediate32 encodes our operation index
+            tcg_out_binary_gadget(s, gadget, args[0], args[1]);
+            tcg_out64(s, args[2]); // FIXME: double encoded
+        }
+
+        break;
+    }
+
+    // Memory barriers.
+    case INDEX_op_mb:
+    {
+        static void* sync[] = {
+            [0 ... TCG_MO_ALL]            = gadget_mb_all,
+            [TCG_MO_ST_ST]                = gadget_mb_st,
+            [TCG_MO_LD_LD]                = gadget_mb_ld,
+            [TCG_MO_LD_ST]                = gadget_mb_ld,
+            [TCG_MO_LD_ST | TCG_MO_LD_LD] = gadget_mb_ld,
+        };
+        tcg_out_gadget(s, sync[args[0] & TCG_MO_ALL]);
+
+        break;
+    }
+
+    case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_mov_i64:
+    case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
+    case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
+    case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
+    case INDEX_op_ext8s_i32:    /* Always emitted via tcg_reg_alloc_op. */
+    case INDEX_op_ext8s_i64:
+    case INDEX_op_ext8u_i32:
+    case INDEX_op_ext8u_i64:
+    case INDEX_op_ext16s_i32:
+    case INDEX_op_ext16s_i64:
+    case INDEX_op_ext16u_i32:
+    case INDEX_op_ext16u_i64:
+    case INDEX_op_ext32s_i64:
+    case INDEX_op_ext32u_i64:
+    case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
+    case INDEX_op_extrl_i64_i32:
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/**
+ * Generate immediate stores.
+ */
+static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
+                       intptr_t arg2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_ldst_gadget(s, gadget_st_i32, arg, arg1, arg2);
+    } else {
+        tcg_out_ldst_gadget(s, gadget_st_i64, arg, arg1, arg2);
+    }
+}
+
+static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
+                               TCGReg base, intptr_t ofs)
+{
+    return false;
+}
+
+/* Test if a constant matches the constraint. */
+static bool tcg_target_const_match(int64_t val, int ct,
+                                   TCGType type, TCGCond cond, int vece)
+{
+    return ct & TCG_CT_CONST;
+}
+
+static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
+{
+    memset(p, 0, sizeof(*p) * count);
+}
+
+/***************************
+ *  TCG Vector Operations  *
+ ***************************/
+
+//
+// Helper for emitting DUPI (immediate DUP) instructions.
+//
+#define tcg_out_dupi_gadget(s, name, q, rd, op, cmode, arg) \
+    if (q) { \
+        tcg_out_gadget(s, gadget_ ## name ## _cmode_ ## cmode ## _op ## op ## _q1[rd][arg]); \
+    } else { \
+        tcg_out_gadget(s, gadget_ ## name ## _cmode_ ## cmode ## _op ## op ## _q0[rd][arg]); \
+    }
+
+
+//
+// Helpers for emitting D/Q variant instructions.
+//
+#define tcg_out_dq_gadget(s, name, arity, is_q, args...) \
+    if (is_q) { \
+        tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _q, args); \
+    } else { \
+        tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _d, args); \
+    }
+
+#define tcg_out_unary_dq_gadget(s, name, is_q, a) \
+    tcg_out_dq_gadget(s, name, unary, is_q, a) 
+#define tcg_out_binary_dq_gadget(s, name, is_q, a, b) \
+    tcg_out_dq_gadget(s, name, binary, is_q, a, b)
+#define tcg_out_ternary_dq_gadget(s, name, is_q, a, b, c) \
+    tcg_out_dq_gadget(s, name, ternary, is_q, a, b, c)
+
+
+//
+// Helper for emitting the gadget appropriate for a vector's size.
+//
+#define tcg_out_sized_vector_gadget(s, name, arity, vece, args...) \
+    switch(vece) { \
+        case MO_8: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _8b, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _16b, args); \
+            } \
+            break; \
+        case MO_16: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _4h, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _8h, args); \
+            } \
+            break; \
+        case MO_32: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _2s, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _4s, args); \
+            } \
+            break; \
+        case MO_64: \
+            if (type == TCG_TYPE_V128) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _2d, args); \
+            } \
+            else { \
+                g_assert_not_reached(); \
+            } \
+            break;  \
+        default: \
+            g_assert_not_reached(); \
+    } 
+#define tcg_out_sized_vector_gadget_no64(s, name, arity, vece, args...) \
+    switch(vece) { \
+        case MO_8: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _8b, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _16b, args); \
+            } \
+            break; \
+        case MO_16: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _4h, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _8h, args); \
+            } \
+            break; \
+        case MO_32: \
+            if (type == TCG_TYPE_V64) { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _2s, args); \
+            } else { \
+                tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _4s, args); \
+            } \
+            break; \
+        default: \
+            g_assert_not_reached(); \
+    } 
+
+
+#define tcg_out_unary_vector_gadget(s, name, vece, a) \
+    tcg_out_sized_vector_gadget(s, name, unary, vece, a)
+#define tcg_out_binary_vector_gadget(s, name, vece, a, b) \
+    tcg_out_sized_vector_gadget(s, name, binary, vece, a, b)
+#define tcg_out_ternary_vector_gadget(s, name, vece, a, b, c) \
+    tcg_out_sized_vector_gadget(s, name, ternary, vece, a, b, c)
+
+#define tcg_out_ternary_vector_gadget_no64(s, name, vece, a, b, c) \
+    tcg_out_sized_vector_gadget_no64(s, name, ternary, vece, a, b, c)
+
+
+#define tcg_out_sized_gadget_with_scalar(s, name, arity, is_scalar, vece, args...) \
+    if (is_scalar) { \
+        tcg_out_ ## arity ## _gadget(s, gadget_ ## name ## _scalar, args); \
+    } else { \
+        tcg_out_sized_vector_gadget(s, name, arity, vece, args); \
+    }
+
+#define tcg_out_ternary_vector_gadget_with_scalar(s, name, is_scalar, vece, a, b, c) \
+    tcg_out_sized_gadget_with_scalar(s, name, ternary, is_scalar, vece, a, b, c)
+
+#define tcg_out_ternary_immediate_vector_gadget_with_scalar(s, name, is_scalar, vece, a, b, c) \
+    tcg_out_sized_gadget_with_scalar(s, name, ternary_immediate, is_scalar, vece, a, b, c)
+
+/* Return true if v16 is a valid 16-bit shifted immediate.  */
+static bool is_shimm16(uint16_t v16, int *cmode, int *imm8)
+{
+    if (v16 == (v16 & 0xff)) {
+        *cmode = 0x8;
+        *imm8 = v16 & 0xff;
+        return true;
+    } else if (v16 == (v16 & 0xff00)) {
+        *cmode = 0xa;
+        *imm8 = v16 >> 8;
+        return true;
+    }
+    return false;
+}
+
+
+/** Core vector operation emission. */
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl, unsigned vece,
+    const TCGArg args[TCG_MAX_OP_ARGS], const int const_args[TCG_MAX_OP_ARGS])
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg r0, r1, r2, r3, w0, w1, w2, w3;
+
+    // Typing flags for vector operations.
+    bool is_v128 = (type == TCG_TYPE_V128);
+    bool is_scalar = !is_v128 && (vece == MO_64);
+
+    // Argument shortcuts.
+    r0 = args[0];
+    r1 = args[1];
+    r2 = args[2];
+    r3 = args[3];
+
+    // Offset argument shortcuts; offset to convert register numbers to gadget numberes.
+    w0 = args[0] - TCG_REG_V16;
+    w1 = args[1] - TCG_REG_V16;
+    w2 = args[2] - TCG_REG_V16;
+    w3 = args[3] - TCG_REG_V16;
+
+    // Argument shortcuts, as signed.
+    int64_t signed_offset_arg = (int32_t)args[2];
+
+    switch (opc) {
+
+    // Load memory -> vector: followed by a 64-bit offset immediate
+    case INDEX_op_ld_vec:
+        tcg_out_binary_dq_gadget(s, ldr, is_v128, w0, r1);
+        tcg_out64(s, signed_offset_arg);
+        break;
+    
+    // Store memory -> vector: followed by a 64-bit offset immediate
+    case INDEX_op_st_vec:
+        tcg_out_binary_dq_gadget(s, str, is_v128, w0, r1);
+        tcg_out64(s, signed_offset_arg);
+        break;
+
+    // Duplciate memory to all vector elements.
+    case INDEX_op_dupm_vec:
+        // DUPM handles normalization itself; pass arguments raw.
+        tcg_out_dupm_vec(s, type, vece, r0, r1, r2);
+        break;
+
+    case INDEX_op_add_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, add, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_sub_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, sub, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_mul_vec: // optional
+        tcg_out_ternary_vector_gadget_no64(s, mul, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_neg_vec: // optional
+        tcg_out_binary_vector_gadget(s, neg, vece, w0, w1);
+        break;
+
+    case INDEX_op_abs_vec: // optional
+        tcg_out_binary_vector_gadget(s, abs, vece, w0, w1);
+        break;
+
+    case INDEX_op_and_vec: // optional
+        tcg_out_ternary_dq_gadget(s, and, is_v128, w0, w1, w2);
+        break;
+
+    case INDEX_op_or_vec:
+        tcg_out_ternary_dq_gadget(s, or, is_v128, w0, w1, w2);
+        break;
+
+    case INDEX_op_andc_vec:
+        tcg_out_ternary_dq_gadget(s, andc, is_v128, w0, w1, w2);
+        break;
+
+    case INDEX_op_orc_vec: // optional
+        tcg_out_ternary_dq_gadget(s, orc, is_v128, w0, w1, w2);
+        break;
+
+    case INDEX_op_xor_vec:
+        tcg_out_ternary_dq_gadget(s, xor, is_v128, w0, w1, w2);
+        break;
+
+    case INDEX_op_ssadd_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, ssadd, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_sssub_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, sssub, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_usadd_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, usadd, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_ussub_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, ussub, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_smax_vec:
+        tcg_out_ternary_vector_gadget_no64(s, smax, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_smin_vec:
+        tcg_out_ternary_vector_gadget_no64(s, smin, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_umax_vec:
+        tcg_out_ternary_vector_gadget_no64(s, umax, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_umin_vec:
+        tcg_out_ternary_vector_gadget_no64(s, umin, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_not_vec: // optional
+        tcg_out_binary_dq_gadget(s, not, is_v128, w0, w1);
+        break;
+
+    case INDEX_op_shlv_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, shlv, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_aa64_sshl_vec:
+        tcg_out_ternary_vector_gadget_with_scalar(s, sshl, is_scalar, vece, w0, w1, w2);
+        break;
+
+    case INDEX_op_cmp_vec:
+        switch (args[3]) {
+            case TCG_COND_EQ:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmeq, is_scalar, vece, w0, w1, w2);
+                break;
+            case TCG_COND_NE:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmeq, is_scalar, vece, w0, w1, w2);
+                tcg_out_binary_dq_gadget(s, not, is_v128, w0, w0);
+                break;
+            case TCG_COND_GT:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmgt, is_scalar, vece, w0, w1, w2);
+                break;
+            case TCG_COND_LE:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmgt, is_scalar, vece, w0, w2, w1);
+                break;
+            case TCG_COND_GE:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmge, is_scalar, vece, w0, w1, w2);
+                break;
+            case TCG_COND_LT:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmge, is_scalar, vece, w0, w2, w1);
+                break;
+            case TCG_COND_GTU:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmhi, is_scalar, vece, w0, w1, w2);
+                break;
+            case TCG_COND_LEU:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmhi, is_scalar, vece, w0, w2, w1);
+                break;
+            case TCG_COND_GEU:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmhs, is_scalar, vece, w0, w1, w2);
+                break;
+            case TCG_COND_LTU:
+                tcg_out_ternary_vector_gadget_with_scalar(s, cmhs, is_scalar, vece, w0, w2, w1);
+                break;
+            default:
+                g_assert_not_reached();
+        }
+        break;
+
+    case INDEX_op_bitsel_vec: // optional
+    {
+        if (r0 == r3) {
+            tcg_out_ternary_dq_gadget(s, bit, is_v128, w0, w2, w1);
+        } else if (r0 == r2) {
+            tcg_out_ternary_dq_gadget(s, bif, is_v128, w0, w3, w1);
+        } else {
+            if (r0 != r1) {
+                tcg_out_mov(s, type, r0, r1);
+            }
+            tcg_out_ternary_dq_gadget(s, bsl, is_v128, w0, w2, w3);
+        }
+        break;
+    }
+
+    /* inhibit compiler warning because we use imm as a register */
+    case INDEX_op_shli_vec:
+        tcg_out_ternary_immediate_vector_gadget_with_scalar(s, shl, is_scalar, vece, w0, w1, r2);
+        break;
+    case INDEX_op_shri_vec:
+        tcg_out_ternary_immediate_vector_gadget_with_scalar(s, ushr, is_scalar, vece, w0, w1, r2 - 1);
+        break;
+    case INDEX_op_sari_vec:
+        tcg_out_ternary_immediate_vector_gadget_with_scalar(s, sshr, is_scalar, vece, w0, w1, r2 - 1);
+        break;
+    case INDEX_op_aa64_sli_vec:
+        tcg_out_ternary_immediate_vector_gadget_with_scalar(s, sli, is_scalar, vece, w0, w2, r3);
+        break;
+
+    case INDEX_op_mov_vec:  /* Always emitted via tcg_out_mov.  */
+    case INDEX_op_dup_vec:  /* Always emitted via tcg_out_dup_vec.  */
+    default:
+        g_assert_not_reached();
+    }
+}
+
+
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_neg_vec:
+    case INDEX_op_abs_vec:
+    case INDEX_op_not_vec:
+    case INDEX_op_cmp_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_bitsel_vec:
+        return 1;
+    case INDEX_op_rotli_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+    case INDEX_op_rotlv_vec:
+    case INDEX_op_rotrv_vec:
+        return -1;
+    case INDEX_op_mul_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
+        return vece < MO_64;
+
+    default:
+        return 0;
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    va_list va;
+    TCGv_vec v0, v1, v2, t1, t2, c1;
+    TCGArg a2;
+
+
+    va_start(va, a0);
+    v0 = temp_tcgv_vec(arg_temp(a0));
+    v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
+    va_end(va);
+
+    switch (opc) {
+    case INDEX_op_rotli_vec:
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_shri_vec(vece, t1, v1, -a2 & ((8 << vece) - 1));
+        vec_gen_4(INDEX_op_aa64_sli_vec, type, vece,
+                  tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(v1), a2);
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
+        /* Right shifts are negative left shifts for AArch64.  */
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        tcg_gen_neg_vec(vece, t1, v2);
+        opc = (opc == INDEX_op_shrv_vec
+               ? INDEX_op_shlv_vec : INDEX_op_aa64_sshl_vec);
+        vec_gen_3(opc, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_rotlv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
+        tcg_gen_sub_vec(vece, t1, v2, c1);
+        /* Right shifts are negative left shifts for AArch64.  */
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(v0),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(v2));
+        tcg_gen_or_vec(vece, v0, v0, t1);
+        tcg_temp_free_vec(t1);
+        break;
+
+    case INDEX_op_rotrv_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
+        t1 = tcg_temp_new_vec(type);
+        t2 = tcg_temp_new_vec(type);
+        c1 = tcg_constant_vec(type, vece, 8 << vece);
+        tcg_gen_neg_vec(vece, t1, v2);
+        tcg_gen_sub_vec(vece, t2, c1, v2);
+        /* Right shifts are negative left shifts for AArch64.  */
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t1),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+        vec_gen_3(INDEX_op_shlv_vec, type, vece, tcgv_vec_arg(t2),
+                  tcgv_vec_arg(v1), tcgv_vec_arg(t2));
+        tcg_gen_or_vec(vece, v0, t1, t2);
+        tcg_temp_free_vec(t1);
+        tcg_temp_free_vec(t2);
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+
+/* Generate DUPI (move immediate) vector ops. */
+static bool tcg_out_optimized_dupi_vec(TCGContext *s, TCGType type, unsigned vece, TCGReg rd, int64_t v64)
+{
+    bool q = (type == TCG_TYPE_V128);
+    int cmode, imm8, i;
+
+    // If we're copying an 8b immediate, we implicitly have a simple gadget for this,
+    // since there are only 256 possible values * 16 registers. Emit a MOVI gadget implicitly.
+    if (vece == MO_8) {
+        imm8 = (uint8_t)v64;
+        tcg_out_dupi_gadget(s, movi, q, rd, 0, e, imm8);
+        return true;
+    }
+
+    // Otherwise, if we have a value that's all 0x00 and 0xFF bytes,
+    // we can use the scalar variant of MOVI (op=1, cmode=e), which handles
+    // that case directly.
+    for (i = imm8 = 0; i < 8; i++) {
+        uint8_t byte = v64 >> (i * 8);
+        if (byte == 0xff) {
+            imm8 |= 1 << i;
+        } else if (byte != 0) {
+            goto fail_bytes;
+        }
+    }
+    tcg_out_dupi_gadget(s, movi, q, rd, 1, e, imm8);
+    return true;
+ fail_bytes:
+
+    // Handle 16B moves.
+    if (vece == MO_16) {
+        uint16_t v16 = v64;
+
+        // Check to see if we have a value representable in as a MOV imm8, possibly via a shift.
+        if (is_shimm16(v16, &cmode, &imm8)) {
+            // Output the corret instruction CMode for either a regular MOVI (8) or a LSL8 MOVI (a).
+            if (cmode == 0x8) {
+                tcg_out_dupi_gadget(s, movi, q, rd, 0, 8, imm8);
+            } else {
+                tcg_out_dupi_gadget(s, movi, q, rd, 0, a, imm8);
+            }
+            return true;
+        }
+
+        // Check to see if we have a value representable in as an inverted MOV imm8, possibly via a shift.
+        if (is_shimm16(~v16, &cmode, &imm8)) {
+            // Output the corret instruction CMode for either a regular MOVI (8) or a LSL8 MOVI (a).
+            if (cmode == 0x8) {
+                tcg_out_dupi_gadget(s, mvni, q, rd, 0, 8, imm8);
+            } else {
+                tcg_out_dupi_gadget(s, mvni, q, rd, 0, a, imm8);
+            }
+            return true;
+        }
+
+        // If we can't perform either of the optimizations, we'll need to do this in two steps.
+        // Normally, we'd emit a gadget for both steps, but in this case that'd result in needing -way-
+        // too many gadgets. We'll emit two, instead.
+        tcg_out_dupi_gadget(s, movi, q, rd, 0, 8, v16 & 0xff);
+        tcg_out_dupi_gadget(s, orr,  q, rd, 0, a, v16 >> 8);
+        return true;
+    }
+
+    // FIXME: implement 32B move optimizations
+
+     
+    // Try to create optimized 32B moves.
+    //else if (vece == MO_32) {
+    //    uint32_t v32 = v64;
+    //    uint32_t n32 = ~v32;
+
+    //    if (is_shimm32(v32, &cmode, &imm8) ||
+    //        is_soimm32(v32, &cmode, &imm8) ||
+    //        is_fimm32(v32, &cmode, &imm8)) {
+    //        tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+    //        return;
+    //    }
+    //    if (is_shimm32(n32, &cmode, &imm8) ||
+    //        is_soimm32(n32, &cmode, &imm8)) {
+    //        tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+    //        return;
+    //    }
+
+    //    //
+    //    // Restrict the set of constants to those we can load with
+    //    // two instructions.  Others we load from the pool.
+    //    //
+    //    i = is_shimm32_pair(v32, &cmode, &imm8);
+    //    if (i) {
+    //        tcg_out_insn(s, 3606, MOVI, q, rd, 0, cmode, imm8);
+    //        tcg_out_insn(s, 3606, ORR, q, rd, 0, i, extract32(v32, i * 4, 8));
+    //        return;
+    //    }
+    //    i = is_shimm32_pair(n32, &cmode, &imm8);
+    //    if (i) {
+    //        tcg_out_insn(s, 3606, MVNI, q, rd, 0, cmode, imm8);
+    //        tcg_out_insn(s, 3606, BIC, q, rd, 0, i, extract32(n32, i * 4, 8));
+    //        return;
+    //    }
+    //} 
+
+    return false;
+}
+
+
+/* Emits instructions that can load an immediate into a vector. */
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece, TCGReg rd, int64_t v64)
+{
+    // Convert Rd into a simple gadget number.
+    rd = rd - (TCG_REG_V16);
+
+    // First, try to create an optimized implementation, if possible.
+    if (tcg_out_optimized_dupi_vec(s, type, vece, rd, v64)) {
+        return;
+    }
+
+    // If we didn't, we'll need to load the full vector from memory.
+    // Emit it into our bytecode stream as an immediate; which we'll then
+    // load inside the gadget.
+    if (type == TCG_TYPE_V128) {
+        tcg_out_unary_gadget(s, gadget_ldi_q, rd);
+        tcg_out64(s, v64);
+        tcg_out64(s, v64);
+    } else {
+        tcg_out_unary_gadget(s, gadget_ldi_d, rd);
+        tcg_out64(s, v64);
+    }
+}
+
+
+/* Emits instructions that can load a register into a vector. */
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece, TCGReg rd, TCGReg rs)
+{
+    // Compute the gadget index for the relevant vector register.
+    TCGReg wd = rd - (TCG_REG_V16);
+
+    // Emit a DUP gadget to handles the operation.
+    tcg_out_binary_vector_gadget(s, dup, vece, wd, rs);
+    return true;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece, TCGReg r, TCGReg base, intptr_t offset)
+{
+    int64_t extended_offset = (int32_t)offset;
+
+    // Convert the register into a simple register number for our gadgets.
+    r = r - TCG_REG_V16;
+
+    // Emit a DUPM gadget...
+    tcg_out_binary_vector_gadget(s, dupm, vece, r, base);
+
+    // ... and emit its int64 immediate offset.
+    tcg_out64(s, extended_offset);
+
+    return true;
+}
+
+
+/********************************
+ *  TCG Runtime & Platform Def  *
+ *******************************/
+
+static void tcg_target_init(TCGContext *s)
+{
+    /* The current code uses uint8_t for tcg operations. */
+    tcg_debug_assert(tcg_op_defs_max <= UINT8_MAX);
+
+    // Registers available for each type of operation.
+    tcg_target_available_regs[TCG_TYPE_I32]  = TCG_MASK_GP_REGISTERS;
+    tcg_target_available_regs[TCG_TYPE_I64]  = TCG_MASK_GP_REGISTERS;
+    tcg_target_available_regs[TCG_TYPE_V64]  = TCG_MASK_VECTOR_REGISTERS;
+    tcg_target_available_regs[TCG_TYPE_V128] = TCG_MASK_VECTOR_REGISTERS;
+
+    TCGReg unclobbered_registers[] = {
+        // We don't use registers R16+ in our runtime, so we'll not bother protecting them.
+        TCG_REG_R16, TCG_REG_R17, TCG_REG_R18, TCG_REG_R19,
+        TCG_REG_R20, TCG_REG_R21, TCG_REG_R22, TCG_REG_R23,
+        TCG_REG_R24, TCG_REG_R25, TCG_REG_R26, TCG_REG_R27,
+        TCG_REG_R28, TCG_REG_R29, TCG_REG_R30, TCG_REG_R31,
+
+        // Per our calling convention.
+        TCG_REG_V8,  TCG_REG_V9,  TCG_REG_V10, TCG_REG_V11,
+        TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+   };
+
+    // Specify which registers are clobbered during call.
+    tcg_target_call_clobber_regs = -1ull;
+    for (unsigned i = 0; i < ARRAY_SIZE(unclobbered_registers); ++i) {
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, unclobbered_registers[i]);
+    }
+
+    // Specify which local registers we're reserving.
+    //
+    // Note that we only have to specify registers that are used in the runtime,
+    // and so not e.g. the register that contains AREG0, which can never be allocated.
+    s->reserved_regs = 0;
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_CALL_STACK);
+
+    /* We use negative offsets from "sp" so that we can distinguish
+       stores that might pretend to be call arguments.  */
+    tcg_set_frame(s, TCG_REG_CALL_STACK, -CPU_TEMP_BUF_NLONGS * sizeof(long), CPU_TEMP_BUF_NLONGS * sizeof(long));
+}
+
+/* Generate global QEMU prologue and epilogue code. */
+static inline void tcg_target_qemu_prologue(TCGContext *s)
+{
+    // No prologue; as we're interpreted.
+}
+
+static void tcg_out_tb_start(TCGContext *s)
+{
+    /* nothing to do */
+}
+
+bool tcg_target_has_memory_bswap(MemOp memop)
+{
+    return true;
+}
+
+/**
+ * TCTI 'interpreter' bootstrap.
+ */
+
+// Store the current return address during helper calls.
+__thread uintptr_t tcti_call_return_address;
+
+/* Dispatch the bytecode stream contained in our translation buffer. */
+uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env, const void *v_tb_ptr)
+{
+    // Create our per-CPU temporary storage.
+    long tcg_temps[CPU_TEMP_BUF_NLONGS];
+
+    uint64_t return_value = 0;
+    uintptr_t sp_value    = (uintptr_t)(tcg_temps + CPU_TEMP_BUF_NLONGS);
+    uintptr_t pc_mirror   = (uintptr_t)&tcti_call_return_address;
+
+    // Ensure our target configuration hasn't changed.
+    tcti_assert(TCG_AREG0 == TCG_REG_R14);
+    tcti_assert(TCG_REG_CALL_STACK == TCG_REG_R15);
+
+    asm(
+        // Our threaded-dispatch prologue needs to set up things for our machine to run.
+        // This means:
+        //   - Set up TCG_AREG0 (R14) to point to our architectural state.
+        //   - Set up TCG_REG_CALL_STACK (R15) to point to our temporary buffer.
+        //   - Point x28 (our bytecode "instruction pointer") to the relevant stream address.
+        "ldr x14, %[areg0]\n"
+        "ldr x15, %[sp_value]\n"
+        "ldr x25, %[pc_mirror]\n"
+        "ldr x28, %[start_tb_ptr]\n"
+
+        // To start our code, we'll -call- the gadget at the first bytecode pointer.
+        // Note that we call/branch-with-link, here; so our TB_EXIT gadget can RET in order
+        // to return to this point when things are complete.
+        "ldr x27, [x28], #8\n"
+        "blr x27\n"
+
+        // Finally, we'll copy out our final return value.
+        "str x0, %[return_value]\n"
+
+        : [return_value] "=m" (return_value)
+
+        : [areg0]        "m"  (env),
+          [sp_value]     "m"  (sp_value),
+          [start_tb_ptr] "m"  (v_tb_ptr),
+          [pc_mirror]    "m"  (pc_mirror)
+
+        // We touch _every_ one of the lower registers, as we use these to execute directly.
+        : "x0", "x1",  "x2",  "x3",  "x4",  "x5",  "x6",  "x7",
+          "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
+
+        // We also use x26/x27 for temporary values, and x28 as our bytecode poitner.
+        "x25", "x26", "x27", "x28", "cc", "memory"
+    );
+
+    return return_value;
+}
+
+
+/**
+ *  Disassembly output support.
+ */
+#include <dlfcn.h>
+
+
+/* Disassemble TCI bytecode. */
+int print_insn_tcti(bfd_vma addr, disassemble_info *info)
+{
+
+#ifdef TCTI_GADGET_RICH_DISASSEMBLY
+    Dl_info symbol_info = {};
+    char symbol_name[48] ;
+#endif
+
+    int status;
+    uint64_t block;
+
+    // Read the relevant pointer.
+    status = info->read_memory_func(addr, (void *)&block, sizeof(block), info);
+    if (status != 0) {
+        info->memory_error_func(status, addr, info);
+        return -1;
+    }
+
+#ifdef TCTI_GADGET_RICH_DISASSEMBLY
+    // Most of our disassembly stream will be gadgets. Try to get their names, for nice output.
+    dladdr((void *)block, &symbol_info);
+
+    if(symbol_info.dli_sname != 0) {
+        strncpy(symbol_name, symbol_info.dli_sname, sizeof(symbol_name));
+        symbol_name[sizeof(symbol_name) - 1] = 0;
+        info->fprintf_func(info->stream, "%s", symbol_name);
+    } else {
+        info->fprintf_func(info->stream, "%016lx", block);
+    }
+
+#else
+    info->fprintf_func(info->stream, "%016lx", block);
+#endif
+
+    return sizeof(block);
+}
+
+static bool tcg_out_qemu_ld_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
+
+static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
+{
+    g_assert_not_reached();
+}
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..92c6efeb34 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -91,6 +91,8 @@ option('debug_remap', type: 'boolean', value: false,
        description: 'syscall buffer debugging support')
 option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
+option('tcg_threaded_interpreter', type: 'boolean', value: false,
+       description: 'TCG with threaded-dispatch bytecode interpreter (experimental and slow, but less slow than TCI)')
 option('safe_stack', type: 'boolean', value: false,
        description: 'SafeStack Stack Smash Protection (requires clang/llvm and coroutine backend ucontext)')
 option('asan', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..8eb1954243 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -51,6 +51,9 @@ meson_options_help() {
   printf "%s\n" '                           Enable stricter set of Rust warnings'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter (slow)'
+  printf "%s\n" '  --enable-tcg-threaded-interpreter'
+  printf "%s\n" '                           TCG with threaded-dispatch bytecode interpreter'
+  printf "%s\n" '                           (experimental and slow, but less slow than TCI)'
   printf "%s\n" '  --enable-trace-backends=CHOICES'
   printf "%s\n" '                           Set available tracing backends [log] (choices:'
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
@@ -509,6 +512,8 @@ _meson_option_parse() {
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
+    --enable-tcg-threaded-interpreter) printf "%s" -Dtcg_threaded_interpreter=true ;;
+    --disable-tcg-threaded-interpreter) printf "%s" -Dtcg_threaded_interpreter=false ;;
     --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
diff --git a/tcg/aarch64-tcti/tcti-gadget-gen.py b/tcg/aarch64-tcti/tcti-gadget-gen.py
new file mode 100755
index 0000000000..ebed824500
--- /dev/null
+++ b/tcg/aarch64-tcti/tcti-gadget-gen.py
@@ -0,0 +1,1192 @@
+#!/usr/bin/env python3
+""" Gadget-code generator for QEMU TCTI on AArch64. 
+
+Generates a C-code include file containing 'gadgets' for use by TCTI.
+"""
+
+import os
+import sys
+import itertools
+
+# Epilogue code follows at the end of each gadget, and handles continuing execution.
+EPILOGUE = ( 
+    # Load our next gadget address from our bytecode stream, advancing it.
+    "ldr x27, [x28], #8",
+
+    # Jump to the next gadget.
+    "br x27"
+)
+
+# The number of general-purpose registers we're affording the TCG. This must match
+# the configuration in the TCTI target.
+TCG_REGISTER_COUNT   = 16
+TCG_REGISTER_NUMBERS = list(range(TCG_REGISTER_COUNT))
+
+# Helper that provides each of the AArch64 condition codes of interest.
+ARCH_CONDITION_CODES = ["eq", "ne", "lt", "ge", "le", "gt", "lo", "hs", "ls", "hi"]
+
+# The list of vector size codes supported on this platform.
+VECTOR_SIZES = ['16b', '8b', '4h', '8h', '2s', '4s', '2d']
+
+# We'll create a variety of gadgets that assume the MMU's TLB is stored at certain
+# offsets into its structure. These should match the offsets in tcg-target.c.in.
+QEMU_ALLOWED_MMU_OFFSETS = [ 32, 48, 64, 96, 128 ]
+
+# Statistics.
+gadgets      = 0
+instructions = 0
+
+# Files to write to.
+current_collection = "basic"
+output_files = {}
+
+# Create a top-level header.
+top_header = open("tcg/tcti_gadgets.h", "w")
+print("/* Automatically generated by tcti-gadget-gen.py. Do not edit. */\n", file=top_header)
+
+def _get_output_files():
+    """ Gathers the output C and H files for a given gadget-cluster name. """
+
+    # If we don't have an output file for this already, create it.
+    return output_files[current_collection]
+
+
+def START_COLLECTION(name):
+    """ Sets the name of the current collection. """
+
+    global current_collection
+
+    # If we already have a collection for this, skip it.
+    if name in output_files:
+        return
+
+    # Create the relevant output files
+    new_c_file = open(f"tcg/tcti_{name}_gadgets.c", "w")
+    new_h_file = open(f"tcg/tcti_{name}_gadgets.h", "w")
+    output_files[name] = (new_c_file, new_h_file)
+
+    # Add the file to our gadget collection.
+    print(f'#include "tcti_{name}_gadgets.h"', file=top_header)
+
+    # Add generated messages to the relevant collection.
+    print("/* Automatically generated by tcti-gadget-gen.py. Do not edit. */\n", file=new_c_file)
+    print("/* Automatically generated by tcti-gadget-gen.py. Do not edit. */\n", file=new_h_file)
+
+    # Start our C file with inclusion of the relevant header.
+    print(f'\n#include "tcti_{name}_gadgets.h"\n', file=new_c_file)
+
+    # Start our H file with a simple pragma-guard, for speed.
+    print('\n#pragma once\n', file=new_h_file)
+
+    # Finally, set the global active collection.
+    current_collection = name
+    
+
+def simple(name, *lines, export=True):
+    """ Generates a simple gadget that needs no per-register specialization. """
+
+    global gadgets, instructions
+
+    gadgets += 1
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    # Create our C/ASM framing.
+    if export:
+        print(f"__attribute__((naked)) void gadget_{name}(void);", file=h_file)
+        print(f"__attribute__((naked)) void gadget_{name}(void)", file=c_file)
+    else:
+        print(f"static __attribute__((naked)) void gadget_{name}(void)", file=c_file)
+
+    print("{", file=c_file)
+
+    # Add the core gadget
+    print("\tasm(", file=c_file)
+    for line in lines + EPILOGUE:
+        print(f"\t\t\"{line} \\n\"", file=c_file)
+        instructions += 1
+    print("\t);", file=c_file)
+
+    # End our framing.
+    print("}\n", file=c_file)
+
+
+
+def with_register_substitutions(name, substitutions, *lines, immediate_range=range(0), filter=lambda p: False):
+    """ Generates a collection of gadgtes with register substitutions. """
+
+    def _expand_op1_immediate(num):
+        """ Gets a uncompressed bitfield argument for a given immediate; for NEON instructions. 
+        
+        Duplciates each bit eight times; converting 0b0100 to 0x00FF0000.
+        """
+
+        # Get the number as a binary string...
+        binstring = bin(num)[2:]
+
+        # ... expand out the values to hex...
+        hex_string = binstring.replace('1', 'FF').replace('0', '00') 
+
+        # ... and return out the new constant.
+        return f"0x{hex_string}"
+
+
+    def substitutions_for_letter(letter, number, line):
+        """ Helper that transforms Wd => w1, implementing gadget substitutions. """
+
+        # Register substitutions...
+        line = line.replace(f"X{letter}", f"x{number}")
+        line = line.replace(f"W{letter}", f"w{number}")
+
+        # ... vector register substitutions...
+        line = line.replace(f"V{letter}", f"v{number + 16}")
+        line = line.replace(f"D{letter}", f"d{number + 16}")
+        line = line.replace(f"Q{letter}", f"q{number + 16}")
+
+        # ... regular immediate substitutions...
+        line = line.replace(f"I{letter}", f"{number}")
+
+        # ... and compressed immediate substitutions.
+        line = line.replace(f"S{letter}", f"{_expand_op1_immediate(number)}")
+        return line
+
+        
+    # Build a list of all the various stages we'll iterate over...
+    immediate_parameters = list(immediate_range)
+    parameters   = ([TCG_REGISTER_NUMBERS] * len(substitutions))
+
+    # ... adding immediates, if need be.
+    if immediate_parameters:
+        parameters.append(immediate_parameters)
+        substitutions = substitutions + ['i']
+
+    # Generate a list of register-combinations we'll support.
+    permutations = itertools.product(*parameters)
+
+    #  For each permutation...
+    for permutation in permutations:
+        # Filter any invalid combination
+        if filter(permutation): 
+            continue
+
+        new_lines = lines
+
+        # Replace each placeholder element with its proper value...
+        for index, element in enumerate(permutation):
+            letter = substitutions[index]
+            number = element
+
+            # Create new gadgets for the releavnt line...
+            new_lines = [substitutions_for_letter(letter, number, line) for line in new_lines]
+
+        # ... and emit the gadget.
+        permutation_id = "_arg".join(str(number) for number in permutation)
+        simple(f"{name}_arg{permutation_id}", *new_lines, export=False)
+
+
+def with_dnm(name, *lines):
+    """ Generates a collection of gadgets with substitutions for Xd, Xn, and Xm, and equivalents. """
+    with_register_substitutions(name, ("d", "n", "m"), *lines)
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    # Print out an extern.
+    print(f"extern const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}];", file=h_file)
+
+    # Print out an array that contains all of our gadgets, for lookup.
+    print(f"const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}] = ", end="", file=c_file)
+    print("{", file=c_file)
+
+    # D array
+    for d in TCG_REGISTER_NUMBERS:
+        print("\t{", file=c_file)
+
+        # N array
+        for n in TCG_REGISTER_NUMBERS:
+            print("\t\t{", end="", file=c_file)
+
+            # M array
+            for m in TCG_REGISTER_NUMBERS:
+                print(f"gadget_{name}_arg{d}_arg{n}_arg{m}", end=", ", file=c_file)
+
+            print("},", file=c_file)
+        print("\t},", file=c_file)
+    print("};", file=c_file)
+
+
+def with_dn_immediate(name, *lines, immediate_range, filter=lambda m: False):
+    """ Generates a collection of gadgets with substitutions for Xd, Xn, and Xm, and equivalents. """
+    with_register_substitutions(name, ["d", "n"], *lines, immediate_range=immediate_range, filter=lambda p: filter(p[-1]))
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    # Print out an extern.
+    print(f"extern const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}][{len(immediate_range)}];", file=h_file)
+
+    # Print out an array that contains all of our gadgets, for lookup.
+    print(f"const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}][{len(immediate_range)}] = ", end="", file=c_file)
+    print("{", file=c_file)
+
+    # D array
+    for d in TCG_REGISTER_NUMBERS:
+        print("\t{", file=c_file)
+
+        # N array
+        for n in TCG_REGISTER_NUMBERS:
+            print("\t\t{", end="", file=c_file)
+
+            # M array
+            for i in immediate_range:
+                if filter(i):
+                    print(f"(void *)0", end=", ", file=c_file)
+                else:
+                    print(f"gadget_{name}_arg{d}_arg{n}_arg{i}", end=", ", file=c_file)
+
+            print("},", file=c_file)
+        print("\t},", file=c_file)
+    print("};", file=c_file)
+
+
+def with_pair(name, substitutions, *lines):
+    """ Generates a collection of gadgets with two subtstitutions."""
+    with_register_substitutions(name, substitutions, *lines)
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    print(f"extern const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}];", file=h_file)
+
+    # Print out an array that contains all of our gadgets, for lookup.
+    print(f"const void* gadget_{name}[{TCG_REGISTER_COUNT}][{TCG_REGISTER_COUNT}] = ", end="", file=c_file)
+    print("{", file=c_file)
+
+    # N array
+    for a in TCG_REGISTER_NUMBERS:
+        print("\t\t{", end="", file=c_file)
+
+        # M array
+        for b in TCG_REGISTER_NUMBERS:
+            print(f"gadget_{name}_arg{a}_arg{b}", end=", ", file=c_file)
+
+        print("},", file=c_file)
+    print("};", file=c_file)
+
+
+def math_dnm(name, mnemonic):
+    """ Equivalent to `with_dnm`, but creates a _i32 and _i64 variant. For simple math. """
+    with_dnm(f'{name}_i32', f"{mnemonic} Wd, Wn, Wm")
+    with_dnm(f'{name}_i64', f"{mnemonic} Xd, Xn, Xm")
+
+def math_dn(name, mnemonic, source_is_wn=False):
+    """ Equivalent to `with_dn`, but creates a _i32 and _i64 variant. For simple math. """
+    with_dn(f'{name}_i32', f"{mnemonic} Wd, Wn")
+    with_dn(f'{name}_i64', f"{mnemonic} Xd, Wn" if source_is_wn else f"{mnemonic} Xd, Xn")
+
+
+def with_nm(name, *lines):
+    """ Generates a collection of gadgets with substitutions for Xn, and Xm, and equivalents. """
+    with_pair(name, ('n', 'm',), *lines)
+
+
+def with_dn(name, *lines):
+    """ Generates a collection of gadgets with substitutions for Xd, and Xn, and equivalents. """
+    with_pair(name, ('d', 'n',), *lines)
+
+
+def ldst_dn(name, *lines):
+    """ Generates a collection of gadgets with substitutions for Xd, and Xn, and equivalents. 
+    
+    This variant is optimized for loads and stores, and optimizes common offset cases.
+    """
+
+    #
+    # Simple case: create our gadgets.
+    #
+    with_dn(name, "ldr x27, [x28], #8", *lines)
+
+    #
+    # Optimization case: create variants of our gadgets with our offsets replaced with common immediates.
+    #
+    immediate_lines_pos = [line.replace("x27", "#Ii") for line in lines]
+    with_dn_immediate(f"{name}_imm", *immediate_lines_pos, immediate_range=range(64))
+
+    immediate_lines_aligned = [line.replace("x27", "#(Ii << 3)") for line in lines]
+    with_dn_immediate(f"{name}_sh8_imm", *immediate_lines_aligned, immediate_range=range(64))
+
+    immediate_lines_neg = [line.replace("x27", "#-Ii") for line in lines]
+    with_dn_immediate(f"{name}_neg_imm", *immediate_lines_neg, immediate_range=range(64))
+
+
+def with_single(name, substitution, *lines):
+    """ Generates a collection of gadgets with two subtstitutions."""
+    with_register_substitutions(name, (substitution,), *lines)
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    print(f"extern const void* gadget_{name}[{TCG_REGISTER_COUNT}];", file=h_file)
+
+    # Print out an array that contains all of our gadgets, for lookup.
+    print(f"const void* gadget_{name}[{TCG_REGISTER_COUNT}] = ", end="", file=c_file)
+    print("{", file=c_file)
+
+    for n in TCG_REGISTER_NUMBERS:
+        print(f"gadget_{name}_arg{n}", end=", ", file=c_file)
+
+    print("};", file=c_file)
+
+
+def with_d_immediate(name, *lines, immediate_range=range(0)):
+    """ Generates a collection of gadgets with two subtstitutions."""
+    with_register_substitutions(name, ['d'], *lines, immediate_range=immediate_range)
+
+    # Fetch the files we'll be using for output.
+    c_file, h_file = _get_output_files()
+
+    print(f"extern void* gadget_{name}[{TCG_REGISTER_COUNT}][{len(immediate_range)}];", file=h_file)
+
+    # Print out an array that contains all of our gadgets, for lookup.
+    print(f"void* gadget_{name}[{TCG_REGISTER_COUNT}][{len(immediate_range)}] = ", end="", file=c_file)
+    print("{", file=c_file)
+
+    # D array
+    for a in TCG_REGISTER_NUMBERS:
+        print("\t\t{", end="", file=c_file)
+
+        # I array
+        for b in immediate_range:
+            print(f"gadget_{name}_arg{a}_arg{b}", end=", ", file=c_file)
+
+        print("},", file=c_file)
+    print("};", file=c_file)
+
+
+
+def with_d(name, *lines):
+    """ Generates a collection of gadgets with substitutions for Xd. """
+    with_single(name, 'd', *lines)
+
+
+# Assembly code for saving our machine state before entering the C runtime.
+C_CALL_PROLOGUE = [
+    "stp x14, x15, [sp, #-16]!",
+    "stp x28, lr,  [sp, #-16]!",
+]
+
+# Assembly code for restoring our machine state after leaving the C runtime.
+C_CALL_EPILOGUE = [
+    "ldp x28, lr,  [sp], #16",
+    "ldp x14, x15, [sp], #16",
+]
+
+
+def create_tlb_fastpath(is_aligned, is_write, offset, miss_label="0"):
+    """ Creates a set of instructions that perform a soft-MMU TLB lookup.
+
+    This is used for `qemu_ld`/qemu_st` instructions; to emit a prologue that
+    hopefully helps us skip a slow call into the C runtime when a Guest Virtual 
+    -> Host Virtual mapping is in the softmmu's TLB.
+
+    This "fast-path" prelude behaves as follows:
+        - If a TLB entry is found for the address stored in Xn, then x27
+          is stored to an "addend" that can be added to the guest virtual addres
+          to get the host virtual address (the address in our local memory space).
+        - If a TLB entry isn't found, it branches to the "miss_label" (by default, 0:),
+          so address lookup can be handled by the fastpath.
+
+    Clobbers x24, and x26; provides output in x27.
+    """
+
+    fast_path = [
+        # Load env_tlb(env)->f[mmu_idx].{mask,table} into {x26,x27}.
+        f"ldp x26, x27, [x14, #-{offset}]",
+
+        # Extract the TLB index from the address into X26. 
+        "and x26, x26, Xn, lsr #7", # Xn = addr regsiter 
+
+        # Add the tlb_table pointer, creating the CPUTLBEntry address into X27. 
+        "add x27, x27, x26",
+
+        # Load the tlb comparator into X26, and the fast path addend into X27. 
+        "ldr x26, [x27, #8]" if is_write else "ldr x26, [x27]",
+        "ldr x27, [x27, #0x18]",
+
+    ]
+
+    if is_aligned:
+        fast_path.extend([
+            # Store the page mask part of the address into X24.
+            "and x24, Xn, #0xfffffffffffff000",
+
+            # Compare the masked address with the TLB value.
+            "cmp x26, x24",
+
+            # If we're not equal, this isn't a TLB hit. Jump to our miss handler.
+            f"b.ne {miss_label}f",
+        ])
+    else:
+        fast_path.extend([
+            # If we're not aligned, add in our alignment value to ensure we don't
+            # don't straddle the end of a page.
+            "add x24, Xn, #7",
+
+            # Store the page mask part of the address into X24.
+            "and x24, x24, #0xfffffffffffff000",
+
+            # Compare the masked address with the TLB value.
+            "cmp x26, x24",
+
+            # If we're not equal, this isn't a TLB hit. Jump to our miss handler.
+            f"b.ne {miss_label}f",
+        ])
+
+    return fast_path
+
+
+
+def ld_thunk(name, fastpath_32b, fastpath_64b, slowpath_helper, immediate=None, is_aligned=False, force_slowpath=False):
+    """ Creates a thunk into our C runtime for a QEMU ST operation. """
+
+    # Use only offset 0 (no real offset) if we're forcing slowpath; 
+    # otherwise, use all of our allowed MMU offsets.
+    offsets = [0] if force_slowpath else QEMU_ALLOWED_MMU_OFFSETS
+    for offset in offsets:
+        for is_32b in (True, False):
+            fastpath = fastpath_32b if is_32b else fastpath_64b
+
+            gadget_name = f"{name}_off{offset}_i32" if is_32b else f"{name}_off{offset}_i64"
+            postscript = () if immediate else ("add x28, x28, #8",)
+
+            # If we have a pure-assembly fast path, start our gadget with it.
+            if fastpath and not force_slowpath:
+                fastpath_ops = [
+                    # Create a fastpath that jumps to miss_lable on a TLB miss,
+                    # or sets x27 to the TLB addend on a TLB hit.
+                    *create_tlb_fastpath(is_aligned=is_aligned, is_write=False, offset=offset),
+
+                    # On a hit, we can just perform an appropriate load...
+                    *fastpath,
+
+                    # Run our patch-up post-script, if we have one.
+                    *postscript,
+
+                    # ... and then we're done!
+                    *EPILOGUE,
+                ]
+            # Otherwise, we'll save arguments for our slow path.
+            else:
+                fastpath_ops = []
+
+            #
+            # If we're not taking our fast path, we'll call into our C runtime to take the slow path.
+            # 
+            with_dn(gadget_name, 
+                    *fastpath_ops,
+
+                "0:",
+                    "mov x27, Xn",
+
+                    # Save our registers in preparation for entering a C call.
+                    *C_CALL_PROLOGUE,
+
+                    # Per our calling convention:
+                    # - Move our architectural environment into x0, from x14.
+                    # - Move our target address into x1. [Placed in x27 below.]
+                    # - Move our operation info into x2, from an immediate32.
+                    # - Move the next bytecode pointer into x3, from x28.
+                    "mov   x0, x14",
+                    "mov   x1, x27",
+                    f"mov   x2, #{immediate}" if (immediate is not None) else "ldr   x2, [x28], #8", 
+                    "mov   x3, x28",
+
+                    # Perform our actual core code.
+                    f"bl _{slowpath_helper}",
+
+                    # Temporarily store our result in a register that won't get trashed.
+                    "mov x27, x0",
+
+                    # Restore our registers after our C call.
+                    *C_CALL_EPILOGUE,
+
+                    # Finally, call our postscript...
+                    *postscript,
+
+                    # ... and place our results in the target register.
+                    "mov Wd, w27" if is_32b else "mov Xd, x27"
+            )
+
+
+def st_thunk(name, fastpath_32b, fastpath_64b, slowpath_helper, immediate=None, is_aligned=False, force_slowpath=False):
+    """ Creates a thunk into our C runtime for a QEMU ST operation. """
+
+    # Use only offset 0 (no real offset) if we're forcing slowpath; 
+    # otherwise, use all of our allowed MMU offsets.
+    offsets = [0] if force_slowpath else QEMU_ALLOWED_MMU_OFFSETS
+    for offset in offsets:
+
+        for is_32b in (True, False):
+            fastpath = fastpath_32b if is_32b else fastpath_64b
+
+            gadget_name = f"{name}_off{offset}_i32" if is_32b else f"{name}_off{offset}_i64"
+            postscript = () if immediate else ("add x28, x28, #8",)
+
+            # If we have a pure-assembly fast path, start our gadget with it.
+            if fastpath and not force_slowpath:
+                fastpath_ops = [
+
+                    # Create a fastpath that jumps to miss_lable on a TLB miss,
+                    # or sets x27 to the TLB addend on a TLB hit.
+                    *create_tlb_fastpath(is_aligned=is_aligned, is_write=True, offset=offset),
+
+                    # On a hit, we can just perform an appropriate load...
+                    *fastpath,
+
+                    # Run our patch-up post-script, if we have one.
+                    *postscript,
+
+                    # ... and then we're done!
+                    *EPILOGUE,
+                ]
+            else:
+                fastpath_ops = []
+
+
+            #
+            # If we're not taking our fast path, we'll call into our C runtime to take the slow path.
+            # 
+            with_dn(gadget_name, 
+                    *fastpath_ops,
+
+                "0:",
+                    # Move our arguments into registers that we're not actively using.
+                    # This ensures that they won't be trounced by our calling convention
+                    # if this is reading values from x0-x4.
+                    "mov w27, Wd" if is_32b else "mov x27, Xd",
+                    "mov x26, Xn",
+
+                    # Save our registers in preparation for entering a C call.
+                    *C_CALL_PROLOGUE,
+
+                    # Per our calling convention:
+                    # - Move our architectural environment into x0, from x14.
+                    # - Move our target address into x1. [Moved into x26 above].
+                    # - Move our target value into x2. [Moved into x27 above].
+                    # - Move our operation info into x3, from an immediate32.
+                    # - Move the next bytecode pointer into x4, from x28.
+                    "mov   x0, x14",
+                    "mov   x1, x26",
+                    "mov   x2, x27",
+                    f"mov  x3, #{immediate}" if (immediate is not None) else "ldr   x3, [x28], #8", 
+                    "mov   x4, x28",
+
+                    # Perform our actual core code.
+                    f"bl _{slowpath_helper}",
+
+                    # Restore our registers after our C call.
+                    *C_CALL_EPILOGUE,
+
+                    # Finally, call our postscript.
+                    *postscript
+            )
+
+
+
+def vector_dn(name, *lines):
+    """ Creates a set of gadgets for every size of a given vector op. Accepts 'S' as a size placeholder. """
+
+    def do_size_replacement(line, size):
+        line = line.replace(".S", f".{size}")
+        
+        # If this size requires a 32b register, replace Wd with Xd.
+        if size == "2d":
+            line = line.replace("Wn", "Xn")
+
+        return line
+
+
+    # Create a variant for each size, replacing any placeholders.
+    for size in VECTOR_SIZES:
+        sized_lines = (do_size_replacement(line, size) for line in lines)
+        with_dn(f"{name}_{size}", *sized_lines)
+
+
+def vector_dnm(name, *lines, scalar=None, omit_sizes=()):
+    """ Creates a set of gadgets for every size of a given vector op. Accepts 'S' as a size placeholder. """
+
+    def do_size_replacement(line, size):
+        return line.replace(".S", f".{size}")
+        
+    # Create a variant for each size, replacing any placeholders.
+    for size in VECTOR_SIZES:
+        if size in omit_sizes:
+            continue
+
+        sized_lines = (do_size_replacement(line, size) for line in lines)
+        with_dnm(f"{name}_{size}", *sized_lines)
+
+    if scalar:
+        if isinstance(scalar, str):
+            sized_lines = (scalar,)
+        with_dnm(f"{name}_scalar", *sized_lines)
+
+def vector_dn_immediate(name, *lines, scalar=None, immediate_range, omit_sizes=(), filter=lambda s, m: False):
+    """ Creates a set of gadgets for every size of a given vector op. Accepts 'S' as a size placeholder. """
+
+    def do_size_replacement(line, size):
+        return line.replace(".S", f".{size}")
+        
+    # Create a variant for each size, replacing any placeholders.
+    for size in VECTOR_SIZES:
+        if size in omit_sizes:
+            continue
+
+        sized_lines = (do_size_replacement(line, size) for line in lines)
+        with_dn_immediate(f"{name}_{size}", *sized_lines, immediate_range=immediate_range, filter=lambda m: filter(size, m))
+
+    if scalar:
+        if isinstance(scalar, str):
+            sized_lines = (scalar,)
+        with_dn_immediate(f"{name}_scalar", *sized_lines, immediate_range=immediate_range, filter=lambda m: filter(None, m))
+
+def vector_math_dnm(name, operation):
+    """ Generates a collection of gadgets for vector math instructions. """
+    vector_dnm(name, f"{operation} Vd.S, Vn.S, Vm.S", scalar=f"{operation} Dd, Dn, Dm")
+
+
+def vector_math_dnm_no64(name, operation):
+    """ Generates a collection of gadgets for vector math instructions. """
+    vector_dnm(name, f"{operation} Vd.S, Vn.S, Vm.S", omit_sizes=('2d',))
+
+
+def vector_logic_dn(name, operation):
+    """ Generates a pair of gadgets for vector bitwise logic instructions. """
+    with_dn(f"{name}_d", f"{operation} Vd.8b, Vn.8b")
+    with_dn(f"{name}_q", f"{operation} Vd.16b, Vn.16b")
+
+
+def vector_logic_dnm(name, operation):
+    """ Generates a pair of gadgets for vector bitwise logic instructions. """
+    with_dnm(f"{name}_d", f"{operation} Vd.8b, Vn.8b, Vm.8b")
+    with_dnm(f"{name}_q", f"{operation} Vd.16b, Vn.16b, Vm.16b")
+
+def vector_math_dn_immediate(name, operation, immediate_range, filter=lambda x: False):
+    """ Generates a collection of gadgets for vector math instructions. """
+    vector_dn_immediate(name, f"{operation} Vd.S, Vn.S, #Ii", scalar=f"{operation} Dd, Dn, #Ii", immediate_range=immediate_range, filter=filter)
+
+#
+# Gadget definitions.
+#
+
+START_COLLECTION("misc")
+
+# Call a C language helper function by address.
+simple("call",
+    # Get our C runtime function's location as a pointer-sized immediate...
+    "ldr x27, [x28], #8",
+
+    # Store our TB return address for our helper.
+    "str x28, [x25]",
+
+    # Prepare ourselves to call into our C runtime...
+    *C_CALL_PROLOGUE,
+
+    # ... perform the call itself ...
+    "blr x27",
+
+    # Save the result of our call for later.
+    "mov x27, x0",
+
+    # ... and restore our environment.
+    *C_CALL_EPILOGUE,
+
+    # Restore our return value.
+    "mov x0, x27"
+)
+
+# Branch to a given immediate address.
+simple("br",
+    # Use our immediate argument as our new bytecode-pointer location.
+    "ldr x28, [x28]"
+)
+
+
+# Exit from a translation buffer execution.
+simple("exit_tb",
+
+    # We have a single immediate argument, which contains our return code.
+    # Place it into x0, as one would a return code.
+    "ldr x0, [x28], #8",
+
+    # And finally, return back to the code that invoked our gadget stream.
+    "ret"
+)
+
+# Memory barriers.
+simple("mb_all", "dmb ish")
+simple("mb_st",  "dmb ishst")
+simple("mb_ld",  "dmb ishld")
+
+
+
+
+for condition in ARCH_CONDITION_CODES:
+
+    START_COLLECTION("setcond")
+
+    # Performs a comparison between two operands.
+    with_dnm(f"setcond_i32_{condition}",
+        "subs Wd, Wn, Wm",
+        f"cset Wd, {condition}"
+    )
+    with_dnm(f"setcond_i64_{condition}",
+        "subs Xd, Xn, Xm",
+        f"cset Xd, {condition}"
+    )
+
+    #
+    # NOTE: we use _dnm for the conditional branches, even though we don't
+    # actually do anything different based on the d argument. This gemerates
+    # effectively 16 identical `brcond` gadgets for each condition; which we
+    # use in the backend to spread out the actual branch sources we use.
+    #
+    # This is a slight mercy for the branch predictor, as not every conditional
+    # branch is funneled throught the same address.
+    #
+
+    START_COLLECTION("brcond")
+
+    # Branches iff a given comparison is true.
+    with_dnm(f'brcond_i32_{condition}',
+
+        # Grab our immediate argument.
+        "ldr x27, [x28], #8",
+
+        # Perform our comparison...
+        "subs wzr, Wn, Wm",
+
+        # ... and our conditional branch, which selectively sets w28 (our "gadget pointer")
+        # to the new location, if required.
+        f"csel x28, x27, x28, {condition}"
+    )
+
+    # Branches iff a given comparison is true.
+    with_dnm(f'brcond_i64_{condition}',
+
+        # Grab our immediate argument.
+        "ldr x27, [x28], #8",
+
+        # Perform our comparison and conditional branch.
+        "subs xzr, Xn, Xm",
+
+        # ... and our conditional branch, which selectively sets w28 (our "gadget pointer")
+        # to the new location, if required.
+        f"csel x28, x27, x28, {condition}"
+    )
+
+
+START_COLLECTION("mov")
+
+
+# MOV variants.
+with_dn("mov_i32",     "mov Wd, Wn")
+with_dn("mov_i64",     "mov Xd, Xn")
+with_d("movi_i32", "ldr Wd, [x28], #8")
+with_d("movi_i64", "ldr Xd, [x28], #8")
+
+# Create MOV variants that have common constants built in to the gadget.
+# This optimization helps costly reads from memories for simple operations.
+with_d_immediate("movi_imm_i32", "mov Wd, #Ii", immediate_range=range(64))
+with_d_immediate("movi_imm_i64", "mov Xd, #Ii", immediate_range=range(64))
+
+START_COLLECTION("load_unsigned")
+
+# LOAD variants.
+# TODO: should the signed variants have X variants for _i64?
+ldst_dn("ld8u",      "ldrb  Wd, [Xn, x27]")
+ldst_dn("ld16u",     "ldrh  Wd, [Xn, x27]")
+ldst_dn("ld32u",     "ldr   Wd, [Xn, x27]")
+ldst_dn("ld_i64",    "ldr   Xd, [Xn, x27]")
+
+START_COLLECTION("load_signed")
+
+ldst_dn("ld8s_i32",  "ldrsb Wd, [Xn, x27]")
+ldst_dn("ld8s_i64",  "ldrsb Xd, [Xn, x27]")
+ldst_dn("ld16s_i32", "ldrsh Wd, [Xn, x27]")
+ldst_dn("ld16s_i64", "ldrsh Xd, [Xn, x27]")
+ldst_dn("ld32s_i64", "ldrsw Xd, [Xn, x27]")
+
+START_COLLECTION("store")
+
+# STORE variants.
+ldst_dn("st8",         "strb  Wd, [Xn, x27]")
+ldst_dn("st16",        "strh  Wd, [Xn, x27]")
+ldst_dn("st_i32",      "str   Wd, [Xn, x27]")
+ldst_dn("st_i64",      "str   Xd, [Xn, x27]")
+
+# QEMU LD/ST are handled in our C runtime rather than with simple gadgets,
+# as they're nontrivial.
+
+START_COLLECTION("arithmetic")
+
+# Trivial arithmetic.
+math_dnm("add" , "add" )
+math_dnm("sub" , "sub" )
+math_dnm("mul" , "mul" )
+math_dnm("div" , "sdiv")
+math_dnm("divu", "udiv")
+
+# Division remainder
+with_dnm("rem_i32",  "sdiv w27, Wn, Wm", "msub Wd, w27, Wm, Wn")
+with_dnm("rem_i64",  "sdiv x27, Xn, Xm", "msub Xd, x27, Xm, Xn")
+with_dnm("remu_i32", "udiv w27, Wn, Wm", "msub Wd, w27, Wm, Wn")
+with_dnm("remu_i64", "udiv x27, Xn, Xm", "msub Xd, x27, Xm, Xn")
+
+START_COLLECTION("logical")
+
+# Trivial logical.
+math_dn( "not",  "mvn")
+math_dn( "neg",  "neg")
+math_dnm("and",  "and")
+math_dnm("andc", "bic")
+math_dnm("or",   "orr")
+math_dnm("orc",  "orn")
+math_dnm("xor",  "eor")
+math_dnm("eqv",  "eon")
+math_dnm("shl",  "lsl")
+math_dnm("shr",  "lsr")
+math_dnm("sar",  "asr")
+math_dnm("rotr", "ror")
+
+# AArch64 lacks a Rotate Left; so we instead rotate right by a negative.
+with_dnm("rotl_i32", "neg w27, Wm", "ror Wd, Wn, w27")
+with_dnm("rotl_i64", "neg w27, Wm", "ror Xd, Xn, x27")
+
+# We'll synthesize several instructions that don't exist; since it's still faster
+# to run these as gadgets.
+with_dnm("nand_i32", "and Wd, Wn, Wm", "mvn Wd, Wd")
+with_dnm("nand_i64", "and Xd, Xn, Xm", "mvn Xd, Xd")
+with_dnm("nor_i32",  "orr Wd, Wn, Wm", "mvn Wd, Wd")
+with_dnm("nor_i64",  "orr Xd, Xn, Xm", "mvn Xd, Xd")
+
+START_COLLECTION("bitwise")
+
+# Count leading zeroes, with a twist: QEMU requires us to provide
+# a default value for when the argument is 0.
+with_dnm("clz_i32",
+
+    # Perform the core CLZ into w26.
+    "clz w26, Wn",
+
+    # Check Wn to see if it was zero
+    "tst Wn, Wn",
+
+    # If it was zero, accept the argument provided in Wm.
+    # Otherwise, accept our result from w26.
+    "csel Wd, Wm, w26, eq"
+)
+with_dnm("clz_i64",
+
+    # Perform the core CLZ into w26.
+    "clz x26, Xn",
+
+    # Check Wn to see if it was zero
+    "tst Xn, Xn",
+
+    # If it was zero, accept the argument provided in Wm.
+    # Otherwise, accept our result from w26.
+    "csel Xd, Xm, x26, eq"
+)
+
+
+# Count trailing zeroes, with a twist: QEMU requires us to provide
+# a default value for when the argument is 0.
+with_dnm("ctz_i32",
+    # Reverse our bits before performing our actual clz.
+    "rbit w26, Wn",
+    "clz w26, w26",
+
+    # Check Wn to see if it was zero
+    "tst Wn, Wn",
+
+    # If it was zero, accept the argument provided in Wm.
+    # Otherwise, accept our result from w26.
+    "csel Wd, Wm, w26, eq"
+)
+with_dnm("ctz_i64",
+
+    # Perform the core CLZ into w26.
+    "rbit x26, Xn",
+    "clz x26, x26",
+
+    # Check Wn to see if it was zero
+    "tst Xn, Xn",
+
+    # If it was zero, accept the argument provided in Wm.
+    # Otherwise, accept our result from w26.
+    "csel Xd, Xm, x26, eq"
+)
+
+
+START_COLLECTION("extension")
+
+# Numeric extension.
+math_dn("ext8s",      "sxtb", source_is_wn=True)
+with_dn("ext8u",      "and Xd, Xn, #0xff")
+math_dn("ext16s",     "sxth", source_is_wn=True)
+with_dn("ext16u",     "and Wd, Wn, #0xffff")
+with_dn("ext32s_i64", "sxtw Xd, Wn")
+with_dn("ext32u_i64", "mov Wd, Wn")
+
+# Numeric extraction.
+with_dn("extrl",      "mov Wd, Wn")
+with_dn("extrh",      "lsr Xd, Xn, #32")
+
+START_COLLECTION("byteswap")
+
+# Byte swapping.
+with_dn("bswap16",    "rev w27, Wn", "lsr Wd, w27, #16")
+with_dn("bswap32",    "rev Wd, Wn")
+with_dn("bswap64",    "rev Xd, Xn")
+
+
+# Handlers for QEMU_LD, which handles guest <- host loads.
+for subtype in ('aligned', 'unaligned', 'slowpath'):
+    is_aligned  = (subtype == 'aligned')
+    is_slowpath = (subtype == 'slowpath')
+
+    START_COLLECTION(f"qemu_ld_{subtype}_unsigned_le")
+
+    ld_thunk(f"qemu_ld_ub_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_ldub_mmu",
+        fastpath_32b=["ldrb Wd, [Xn, x27]"], fastpath_64b=["ldrb Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    ld_thunk(f"qemu_ld_leuw_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_lduw_mmu",
+        fastpath_32b=["ldrh Wd, [Xn, x27]"], fastpath_64b=["ldrh Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    ld_thunk(f"qemu_ld_leul_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_ldul_mmu",
+        fastpath_32b=["ldr Wd, [Xn, x27]"], fastpath_64b=["ldr Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    ld_thunk(f"qemu_ld_leq_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_ldq_mmu",
+        fastpath_32b=["ldr Xd, [Xn, x27]"], fastpath_64b=["ldr Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+
+    START_COLLECTION(f"qemu_ld_{subtype}_signed_le")
+
+    ld_thunk(f"qemu_ld_sb_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_ldub_mmu_signed",
+        fastpath_32b=["ldrsb Wd, [Xn, x27]"], fastpath_64b=["ldrsb Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    ld_thunk(f"qemu_ld_lesw_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_lduw_mmu_signed",
+        fastpath_32b=["ldrsh Wd, [Xn, x27]"], fastpath_64b=["ldrsh Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    ld_thunk(f"qemu_ld_lesl_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_ldul_mmu_signed",
+        fastpath_32b=["ldrsw Xd, [Xn, x27]"], fastpath_64b=["ldrsw Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+
+    # Special variant for the most common modes, as a speedup optimization.
+    ld_thunk(f"qemu_ld_ub_{subtype}_mode02", is_aligned=is_aligned, slowpath_helper="helper_ldub_mmu",
+        fastpath_32b=["ldrb Wd, [Xn, x27]"], fastpath_64b=["ldrb Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x02
+    )
+    ld_thunk(f"qemu_ld_leq_{subtype}_mode32", is_aligned=is_aligned, slowpath_helper="helper_ldq_mmu",
+        fastpath_32b=["ldr Xd, [Xn, x27]"], fastpath_64b=["ldr Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x32
+    )
+    ld_thunk(f"qemu_ld_leq_{subtype}_mode3a", is_aligned=is_aligned, slowpath_helper="helper_ldq_mmu",
+        fastpath_32b=["ldr Xd, [Xn, x27]"], fastpath_64b=["ldr Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x3a
+    )
+
+
+# Handlers for QEMU_ST, which handles guest -> host stores.
+for subtype in ('aligned', 'unaligned', 'slowpath'):
+    is_aligned  = (subtype == 'aligned')
+    is_slowpath = (subtype == 'slowpath')
+
+    START_COLLECTION(f"qemu_st_{subtype}_le")
+
+    st_thunk(f"qemu_st_ub_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_stb_mmu",
+        fastpath_32b=["strb Wd, [Xn, x27]"], fastpath_64b=["strb Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    st_thunk(f"qemu_st_leuw_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_stw_mmu",
+        fastpath_32b=["strh Wd, [Xn, x27]"], fastpath_64b=["strh Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    st_thunk(f"qemu_st_leul_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_stl_mmu",
+        fastpath_32b=["str Wd, [Xn, x27]"], fastpath_64b=["str Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    st_thunk(f"qemu_st_leq_{subtype}", is_aligned=is_aligned, slowpath_helper="helper_stq_mmu",
+        fastpath_32b=["str Xd, [Xn, x27]"], fastpath_64b=["str Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath,
+    )
+    
+    # Special optimization for the most common modes.
+    st_thunk(f"qemu_st_ub_{subtype}_mode02", is_aligned=is_aligned, slowpath_helper="helper_stb_mmu",
+        fastpath_32b=["strb Wd, [Xn, x27]"], fastpath_64b=["strb Wd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x02
+    )
+    st_thunk(f"qemu_st_leq_{subtype}_mode32", is_aligned=is_aligned, slowpath_helper="helper_stq_mmu",
+        fastpath_32b=["str Xd, [Xn, x27]"], fastpath_64b=["str Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x32
+    )
+    st_thunk(f"qemu_st_leq_{subtype}_mode3a", is_aligned=is_aligned, slowpath_helper="helper_stq_mmu",
+        fastpath_32b=["str Xd, [Xn, x27]"], fastpath_64b=["str Xd, [Xn, x27]"],
+        force_slowpath=is_slowpath, immediate=0x3a
+    )
+
+
+#
+# SIMD/Vector ops
+#
+
+# SIMD MOVI instructions.
+START_COLLECTION(f"simd_base")
+
+# Unoptimized/unoptimizable load of a vector64; grabbing an immediate.
+with_d("ldi_d", "ldr Dd, [x28], #8")
+with_d("ldi_q", "ldr Qd, [x28], #16")
+
+# General purpose reg -> vec rec loads
+vector_dn("dup", "dup Vd.S, Wn")
+
+# move vector -> GP reg
+with_dn("umov_s0", "umov Wd, Vn.s[0]")
+with_dn("umov_d0", "umov Xd, Vn.d[0]")
+
+# mov GP reg -> vector
+with_dn("ins_s0", "ins Vd.s[0], Wn")
+with_dn("ins_d0", "ins Vd.d[0], Xn")
+
+
+# Memory -> vec reg loads.
+# The offset of the load is stored in a 64b immediate.
+
+# Duplicating load.
+# TODO: possibly squish the add into the ld1r, if that's valid?
+vector_dn("dupm", "ldr x27, [x28], #8", "add x27, x27, Xn", "ld1r {Vd.S}, [x27]")
+
+# Direct loads.
+with_dn("ldr_d",  "ldr x27, [x28], #8", "ldr Dd, [Xn, x27]")
+with_dn("ldr_q",  "ldr x27, [x28], #8", "ldr Qd, [Xn, x27]")
+
+# vec -> reg stores.
+# The offset of the stores is stored in a 64b immediate.
+with_dn("str_d",  "ldr x27, [x28], #8", "str Dd, [Xn, x27]")
+with_dn("str_q",  "ldr x27, [x28], #8", "str Qd, [Xn, x27]")
+
+
+START_COLLECTION(f"simd_arithmetic")
+
+vector_math_dnm("add",   "add")
+vector_math_dnm("usadd", "uqadd")
+vector_math_dnm("ssadd", "sqadd")
+vector_math_dnm("sub",   "sub")
+vector_math_dnm("ussub", "uqsub")
+vector_math_dnm("sssub", "sqsub")
+vector_math_dnm_no64("mul",  "mul")
+vector_math_dnm_no64("smax", "smax")
+vector_math_dnm_no64("smin", "smin")
+vector_math_dnm_no64("umax", "umax")
+vector_math_dnm_no64("umin", "umin")
+
+START_COLLECTION(f"simd_logical")
+
+vector_logic_dnm("and",  "and")
+vector_logic_dnm("andc", "bic")
+vector_logic_dnm("or",   "orr")
+vector_logic_dnm("orc",  "orn")
+vector_logic_dnm("xor",  "eor")
+vector_logic_dn( "not",  "not")
+vector_dn("neg", "neg Vd.S, Vn.S")
+vector_dn("abs", "abs Vd.S, Vn.S")
+vector_logic_dnm( "bit",  "bit")
+vector_logic_dnm( "bif",  "bif")
+vector_logic_dnm( "bsl",  "bsl")
+
+vector_math_dnm("shlv", "ushl")
+vector_math_dnm("sshl", "sshl")
+
+def filter_shl(size, imm):
+    match size:
+        case '16b': return imm >= 8
+        case '8b': return imm >= 8
+        case '4h': return imm >= 16
+        case '8h': return imm >= 16
+        case '2s': return imm >= 32
+        case '4s': return imm >= 32
+    return False
+
+def filter_shr(size, imm):
+    if imm == 0:
+        return True
+    match size:
+        case '16b': return imm > 8
+        case '8b': return imm > 8
+        case '4h': return imm > 16
+        case '8h': return imm > 16
+        case '2s': return imm > 32
+        case '4s': return imm > 32
+    return False
+
+vector_math_dn_immediate("shl", "shl", immediate_range=range(64), filter=filter_shl)
+vector_math_dn_immediate("ushr", "ushr", immediate_range=range(1,65), filter=filter_shr)
+vector_math_dn_immediate("sshr", "sshr", immediate_range=range(1,65), filter=filter_shr)
+vector_math_dn_immediate("sli", "sli", immediate_range=range(64), filter=filter_shl)
+
+vector_dnm("cmeq", "cmeq Vd.S, Vn.S, Vm.S", scalar="cmeq Dd, Dn, Dm")
+vector_dnm("cmgt", "cmgt Vd.S, Vn.S, Vm.S", scalar="cmgt Dd, Dn, Dm")
+vector_dnm("cmge", "cmge Vd.S, Vn.S, Vm.S", scalar="cmge Dd, Dn, Dm")
+vector_dnm("cmhi", "cmhi Vd.S, Vn.S, Vm.S", scalar="cmhi Dd, Dn, Dm")
+vector_dnm("cmhs", "cmhs Vd.S, Vn.S, Vm.S", scalar="cmhs Dd, Dn, Dm")
+
+START_COLLECTION(f"simd_immediate")
+
+# Simple imm8 movs...
+with_d_immediate("movi_cmode_e_op0_q0",  "movi Vd.8b, #Ii",          immediate_range=range(256))
+with_d_immediate("movi_cmode_e_op0_q1",  "movi Vd.16b, #Ii",         immediate_range=range(256))
+
+# ... all 00/FF movs...
+with_d_immediate("movi_cmode_e_op1_q0",  "movi Dd, #Si",             immediate_range=range(256))
+with_d_immediate("movi_cmode_e_op1_q1",  "movi Vd.2d, #Si",          immediate_range=range(256))
+
+# Halfword MOVs.
+with_d_immediate("movi_cmode_8_op0_q0",  "movi Vd.4h, #Ii",         immediate_range=range(256))
+with_d_immediate("movi_cmode_8_op0_q1",  "movi Vd.8h, #Ii",         immediate_range=range(256))
+with_d_immediate("mvni_cmode_8_op0_q0",  "mvni Vd.4h, #Ii",         immediate_range=range(256))
+with_d_immediate("mvni_cmode_8_op0_q1",  "mvni Vd.8h, #Ii",         immediate_range=range(256))
+with_d_immediate("movi_cmode_a_op0_q0",  "movi Vd.4h, #Ii, lsl #8", immediate_range=range(256))
+with_d_immediate("movi_cmode_a_op0_q1",  "movi Vd.8h, #Ii, lsl #8", immediate_range=range(256))
+with_d_immediate("mvni_cmode_a_op0_q0",  "mvni Vd.4h, #Ii, lsl #8", immediate_range=range(256))
+with_d_immediate("mvni_cmode_a_op0_q1",  "mvni Vd.8h, #Ii, lsl #8", immediate_range=range(256))
+
+# Halfword ORIs, for building complex MOVs.
+with_d_immediate("orr_cmode_a_op0_q0",   "orr Vd.4h, #Ii, lsl #8",  immediate_range=range(256))
+with_d_immediate("orr_cmode_a_op0_q1",   "orr Vd.8h, #Ii, lsl #8",  immediate_range=range(256))
+
+
+# Print a list of output files generated.
+output_c_filenames = (f"'tcti_{name}_gadgets.c'" for name in output_files.keys())
+output_h_filenames = (f"'tcti_{name}_gadgets.h'" for name in output_files.keys())
+
+print("Sources generated:",    file=sys.stderr)
+print(f"gadgets = [",          file=sys.stderr)
+print("      tcti_gadgets.h,", file=sys.stderr)
+
+for name in output_files.keys():
+    print(f"      'tcti_{name}_gadgets.c',", file=sys.stderr)
+    print(f"      'tcti_{name}_gadgets.h',", file=sys.stderr)
+
+print(f"]", file=sys.stderr)
+
+# Statistics.
+sys.stderr.write(f"\nGenerated {gadgets} gadgets with {instructions} instructions (~{(instructions * 4) // 1024 // 1024} MiB).\n\n")
diff --git a/tcg/meson.build b/tcg/meson.build
index 69ebb4908a..475e4db10c 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -27,11 +27,78 @@ if host_os == 'linux'
   tcg_ss.add(files('perf.c'))
 endif
 
+if get_option('tcg_threaded_interpreter')
+  # Tell our compiler how to generate our TCTI gadgets.
+  gadget_generator = '@0@/tcti-gadget-gen.py'.format(tcg_arch)
+  tcti_sources = [
+      'tcti_gadgets.h',
+      'tcti_misc_gadgets.c',
+      'tcti_misc_gadgets.h',
+      'tcti_setcond_gadgets.c',
+      'tcti_setcond_gadgets.h',
+      'tcti_brcond_gadgets.c',
+      'tcti_brcond_gadgets.h',
+      'tcti_mov_gadgets.c',
+      'tcti_mov_gadgets.h',
+      'tcti_load_signed_gadgets.c',
+      'tcti_load_signed_gadgets.h',
+      'tcti_load_unsigned_gadgets.c',
+      'tcti_load_unsigned_gadgets.h',
+      'tcti_store_gadgets.c',
+      'tcti_store_gadgets.h',
+      'tcti_arithmetic_gadgets.c',
+      'tcti_arithmetic_gadgets.h',
+      'tcti_logical_gadgets.c',
+      'tcti_logical_gadgets.h',
+      'tcti_extension_gadgets.c',
+      'tcti_extension_gadgets.h',
+      'tcti_bitwise_gadgets.c',
+      'tcti_bitwise_gadgets.h',
+      'tcti_byteswap_gadgets.c',
+      'tcti_byteswap_gadgets.h',
+      'tcti_qemu_ld_aligned_signed_le_gadgets.c',
+      'tcti_qemu_ld_aligned_signed_le_gadgets.h',
+      'tcti_qemu_ld_unaligned_signed_le_gadgets.c',
+      'tcti_qemu_ld_unaligned_signed_le_gadgets.h',
+      'tcti_qemu_ld_slowpath_signed_le_gadgets.c',
+      'tcti_qemu_ld_slowpath_signed_le_gadgets.h',
+      'tcti_qemu_ld_aligned_unsigned_le_gadgets.c',
+      'tcti_qemu_ld_aligned_unsigned_le_gadgets.h',
+      'tcti_qemu_ld_unaligned_unsigned_le_gadgets.c',
+      'tcti_qemu_ld_unaligned_unsigned_le_gadgets.h',
+      'tcti_qemu_ld_slowpath_unsigned_le_gadgets.c',
+      'tcti_qemu_ld_slowpath_unsigned_le_gadgets.h',
+      'tcti_qemu_st_aligned_le_gadgets.c',
+      'tcti_qemu_st_aligned_le_gadgets.h',
+      'tcti_qemu_st_unaligned_le_gadgets.c',
+      'tcti_qemu_st_unaligned_le_gadgets.h',
+      'tcti_qemu_st_slowpath_le_gadgets.c',
+      'tcti_qemu_st_slowpath_le_gadgets.h',
+      'tcti_simd_base_gadgets.c',
+      'tcti_simd_base_gadgets.h',
+      'tcti_simd_arithmetic_gadgets.c',
+      'tcti_simd_arithmetic_gadgets.h',
+      'tcti_simd_logical_gadgets.c',
+      'tcti_simd_logical_gadgets.h',
+      'tcti_simd_immediate_gadgets.c',
+      'tcti_simd_immediate_gadgets.h',
+  ]
+  tcti_gadgets = custom_target('tcti-gadgets.h',
+                            output: tcti_sources,
+                            input: gadget_generator,
+                            command: [find_program(gadget_generator)],
+                            build_by_default: false,
+                            build_always_stale: false)
+  tcti_gadgets = declare_dependency(sources: tcti_gadgets)
+else
+  tcti_gadgets = []
+endif
+
 tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
-                             dependencies: tcg_ss.dependencies(),
+                             dependencies: tcg_ss.dependencies() + tcti_gadgets,
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
@@ -41,7 +108,7 @@ user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
-                                dependencies: tcg_ss.dependencies(),
+                                dependencies: tcg_ss.dependencies() + tcti_gadgets,
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
-- 
2.41.0


