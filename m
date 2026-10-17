Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED63CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5r-0006mI-I9; Sat, 17 Oct 2026 16:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4c-00047q-Vf; Sat, 17 Oct 2026 16:32:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB4Z-0004ZP-Pt; Sat, 17 Oct 2026 16:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268883; bh=BZ7RBmb5WhcAgkBggiI5IidmdW4xw8utdBJQ/DY1vsw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nPHdMxT1pLJ7J6YXAn1q67NXDayEho6/+gYzYgSt0mcAVK7TO62cW5vsFxGH4gK8Y
 svgmjoW5clr/hKnhc2Hhmw/hiv8EJls4sQJ9BbrF1tbt/rB9NVZ38vgqSUT6ZjHJio
 3jklw5DcCPHqhfY0SY6wqy2S5rCoruJWkPVmVcYVZOmyQIg4E3XSuch8B4lgUJOqPm
 NjEqzSFJVZE+vSvdFiQiA6/N31DmtMBIiGfzoTCesrhC3F4navZqh8xhLjrMeQGZuI
 REQr4Z9YdxkBdTu98c+ylM8v8LdshcYBdMCMl7VOzOuPPh71ytAtlkOkOnTYgLC463
 8FWHVeCzhpOsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C18D21DE775;
 Sat, 17 Oct 2026 23:28:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E846443449;
 Sat, 17 Oct 2026 23:28:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 55/73] target/i386/tcg: zero FXSAVE FOP and reserved
 slot bytes
Date: Sat, 17 Oct 2026 23:26:13 +0300
Message-ID: <20261017202638.728621-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Artemii Mashanov <ralerrdirsardx@gmail.com>

TCG's do_xsave_fpu() omitted writing the FOP field and the reserved
bytes (10..15) of each x87 register slot. Those parts of
the destination buffer retained their previous contents.

The reserved bytes of all eight slots are zeroed. TCG does not
yet track the actual FOP value, this patch stores a fixed zero instead.

Add a regression test in tests/tcg/x86_64/fxsave.c. It fills the
FXSAVE area with 0xcc, executes FNINIT and FXSAVE64, then verifies that
FOP and all reserved slot bytes are zero.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3522

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260826171655.117679-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0dd9fb43ea221260969be449b596e7252abbca80)
(Mjt: fixup for make=>meson test conversion)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 62f1c110e2..470061e2c4 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2617,6 +2617,7 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     access_stw(ac, ptr + XO(legacy.fcw), env->fpuc);
     access_stw(ac, ptr + XO(legacy.fsw), fpus);
     access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);
+    access_stw(ac, ptr + XO(legacy.fpop), 0);
 
     /* In 32-bit mode this is eip, sel, dp, sel.
        In 64-bit mode this is rip, rdp.
@@ -2629,6 +2630,8 @@ static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
         do_fstt(ac, addr, tmp);
+        access_stw(ac, addr + 10, 0);
+        access_stl(ac, addr + 12, 0);
         addr += 16;
     }
 }
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index c48767fef8..0f8f48b1a5 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -20,6 +20,7 @@ X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
 X86_64_TESTS += fma
+X86_64_TESTS += fxsave
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
diff --git a/tests/tcg/x86_64/fxsave.c b/tests/tcg/x86_64/fxsave.c
new file mode 100644
index 0000000000..d08a4e8a0e
--- /dev/null
+++ b/tests/tcg/x86_64/fxsave.c
@@ -0,0 +1,66 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * See https://gitlab.com/qemu-project/qemu/-/issues/3522
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#define FXSAVE_FOP_OFFSET      6
+#define FXSAVE_X87_OFFSET      32
+#define FXSAVE_SLOT_SIZE       16
+#define FXSAVE_RESERVED_START  10
+#define FXSAVE_NUM_SLOTS       8
+
+struct fxsave_area {
+    uint8_t raw[512];
+} __attribute__((aligned(16)));
+
+_Static_assert(sizeof(struct fxsave_area) == 512,
+                "FXSAVE area must be exactly 512 bytes");
+
+static uint16_t u16_le(const uint8_t *p)
+{
+    uint16_t v;
+    memcpy(&v, p, sizeof(v));
+    return v;
+}
+
+int main(void)
+{
+    struct fxsave_area area;
+    uint16_t fop;
+
+    memset(&area, 0xcc, sizeof(area));
+
+    __asm__ volatile(
+        "fninit\n\t"
+        "fxsave64 %0"
+        : "+m" (area)
+        :
+        : "memory"
+    );
+
+    fop = u16_le(&area.raw[FXSAVE_FOP_OFFSET]);
+    if (fop != 0) {
+        fprintf(stderr, "FOP: expected 0, got 0x%04x\n", (unsigned)fop);
+        return 1;
+    }
+
+    for (int slot = 0; slot < FXSAVE_NUM_SLOTS; slot++) {
+        int base = FXSAVE_X87_OFFSET + slot * FXSAVE_SLOT_SIZE;
+        for (int b = FXSAVE_RESERVED_START; b < FXSAVE_SLOT_SIZE; b++) {
+            uint8_t val = area.raw[base + b];
+            if (val != 0) {
+                fprintf(stderr,
+                        "Slot %d byte %d (offset %d): expected 0x00, "
+                        "got 0x%02x\n",
+                        slot, b, base + b, (unsigned)val);
+                return 1;
+            }
+        }
+    }
+
+    return 0;
+}
-- 
2.47.3


