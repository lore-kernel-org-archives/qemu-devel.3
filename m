Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DB4CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ6-0000AG-8o; Mon, 18 May 2026 01:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vJ-PO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY1-0003Vr-Td
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:52 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-484df1dce93so332500b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082186; x=1779686986; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uoNJBVaQRDiz8HS80c7MV4AAAeKpSzxjgMbign2Rm7M=;
 b=VcshD3/5TF5GGXnFLkroh14DLI0m/DabmOW0lRqWqu9F1EZyysoafx8iJk/IzoxdLr
 uuYelQo6dwsIq8LGmZYmCQF1xmVWRZkY6C0E4o30StAdgCPpCRnckUkw9SKYh4WzG278
 K8LZxFEcPREg/jhLsadt2VKfjX9b2ESgBhvKUkSCQdf6Cg3u0aIKUZ5o51+Fwp+C22sP
 kgNE8+gdfXFnGtxYtQE4Qrkny+gQrO2oPFHpCii206+RCrMs1ExNrw+o/OiCCd7vgVA8
 ZBxnPfHxrdidwGCBAArrJ9MHLda9BnfjOrZ0EPfsA/CxACwwA/dmcSMgkzxo6EIGA7Rk
 3jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082186; x=1779686986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uoNJBVaQRDiz8HS80c7MV4AAAeKpSzxjgMbign2Rm7M=;
 b=p0BrQX0FPc5VJgbbekV7xyu6z5oAiEtL0qtGO/FejmQPzEZ+T12Rr/JCEddR6Oj5uK
 b8TmXnpPydH3UZP0WShyjgdi4VIZsb+Qo7nnqJkjsbiS9SCDachwI03MXiUWKsIy1yQz
 U08cH8VPuOTRAJs7IK2jHAxL2/JsiYz10QIOivNxY1e/Tft6sxjngx2AkVRov2HACQaE
 W4joW96uRPV0wtofZYlyLwyYeGR4vjX14A2rFhc8b4q300zfgFC6XoJ2n38a2HW0xXPh
 1UfglKvmeeHFaMCaMgNs6pfaRu9fQpqWPQJ4gJaYYbjH2BGG+18Q0+1FdnIiG+JqxsLQ
 Y/Hw==
X-Gm-Message-State: AOJu0YwdicU3PD6402Qss51khaOUROdtX764myFUo3nfoWqJN0z6Fz13
 zUYPLAKhQQlSSy543kOnAmq4LnAZdtFRtuG/nP4AolJBaRCWH153DWjd
X-Gm-Gg: Acq92OFb1e6Z11fvOpwRrclQZN7oR7QEx7p4OOQw0yxcRoxJOLiyx5XzOSVPoH35f6U
 V9WRvv3BWYFu3VyCooM3hFbFWZxS7abn8UahYctvoezKNZ800HTEtbftpcjs22vsazX9J994E9D
 Hl7dUZEd2UqHs+/VdxS30zRGfScC24vix1As2tCtInljiqgwKCMwdUb9Eqi3foE8Vw+wc19RJs+
 1V9OgGxZjLH3Kch/GzYY/wjRJ02uUv5aVKH/3Chkydl0xXV61lTJyJgWUQxfdOTkFNO11qMkzun
 +Eaax79fAZLcR8lUghg3AIGpfLAWuGTC1JSfPj4887jtQ9wBfuGi1lcG5q9hhrp9Zgbn/RcFfCp
 1Jrbm22pXkH6Rww80kEnUB7p5KXDJ8PMRaS7bD5OTkqTnnWYxX9+RcGT4Lq/qhXJFSW9A1Wqjik
 0KIcLTAcwhXw0vg8miXIWJQqIwCN4Rg5e+ZjwK1dyWWlY1MB2QRnGmKu2bdZIJOGTZQKJrhZLNX
 6AL7Up6EbGNGwEaxY0NrvJ6YeuL1Uk4yGSK6YiFCkeBt2Ea14R2Lu4yo8VDYmLL4EDmubY=
X-Received: by 2002:a05:6808:67c1:b0:46a:c987:ba00 with SMTP id
 5614622812f47-482e5760189mr9365885b6e.32.1779082185845; 
 Sun, 17 May 2026 22:29:45 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:19 -0600
Subject: [PATCH v8 22/35] tests/tcg/mips: add Octeon instruction smoke test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-22-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon integer, comparison, population count, and multiplier instruction
paths. Include hardware-backed regression coverage for VMM0 MPL1 zeroing
and MTP0 P1 zeroing.

Run the test with -cpu Octeon68XX and share the source between the
mips64 and mips64el target directories.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split the smoke test out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v5 -> v6:
  - Add VMM0/MPL1 and MTP0/P1 reset checks for the CN71XX-defined
    reset-state behavior.
---
 MAINTAINERS                                   |   2 +
 tests/tcg/mips/Makefile.target                |  11 ++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 204 ++++++++++++++++++++++++++
 tests/tcg/mips64/Makefile.target              |  20 +++
 tests/tcg/mips64el/Makefile.target            |   8 +
 5 files changed, 245 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eda1e84268..0b405b710d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -311,6 +311,8 @@ F: target/mips/
 F: disas/*mips.c
 F: docs/system/cpu-models-mips.rst.inc
 F: tests/tcg/mips/
+F: tests/tcg/mips64/
+F: tests/tcg/mips64el/
 
 OpenRISC TCG CPUs
 M: Stafford Horne <shorne@gmail.com>
diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
index 5d17c1706e..d9dc16f8ec 100644
--- a/tests/tcg/mips/Makefile.target
+++ b/tests/tcg/mips/Makefile.target
@@ -8,6 +8,17 @@ MIPS_SRC=$(SRC_PATH)/tests/tcg/mips
 # Set search path for all sources
 VPATH 		+= $(MIPS_SRC)
 
+ifneq ($(findstring 64,$(TARGET_NAME)),)
+VPATH += $(MIPS_SRC)/user/isa/octeon
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+octeon-insns: CFLAGS+=-mabi=64
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
+endif
+
 # hello-mips is 32 bit only
 ifeq ($(findstring 64,$(TARGET_NAME)),)
 MIPS_TESTS=hello-mips
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
new file mode 100644
index 0000000000..9153e37e9e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -0,0 +1,204 @@
+/*
+ * Test Octeon-specific user-mode instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <stdint.h>
+
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dpop(uint64_t rs)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        ".word 0x7100502d\n\t" /* dpop $10, $8 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0_zeroes_mpl1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[mpl1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000c\n\t" /* mtm1 $8, $9 */
+        "move $8, %[vmm0_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move $8, %[vmulu_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (1ULL), [mpl1] "r" (1ULL),
+          [vmm0_rs] "r" (2ULL), [vmulu_rs] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_mtp0_zeroes_p1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000a\n\t" /* mtp1 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (0ULL), [p1] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+int main(void)
+{
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+    assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+    assert(octeon_vmm0_zeroes_mpl1() == 0);
+    assert(octeon_mtp0_zeroes_p1() == 0);
+
+    return 0;
+}
diff --git a/tests/tcg/mips64/Makefile.target b/tests/tcg/mips64/Makefile.target
new file mode 100644
index 0000000000..042855844a
--- /dev/null
+++ b/tests/tcg/mips64/Makefile.target
@@ -0,0 +1,20 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 - included from tests/tcg/Makefile.target
+#
+
+MIPS64_SRC=$(SRC_PATH)/tests/tcg/mips64
+MIPS_OCTEON_SRC=$(SRC_PATH)/tests/tcg/mips/user/isa/octeon
+
+# Set search path for all sources
+VPATH 		+= $(MIPS64_SRC) $(MIPS_OCTEON_SRC)
+
+MIPS64_TESTS=octeon-insns
+
+TESTS += $(MIPS64_TESTS)
+
+$(MIPS64_TESTS): CFLAGS+=-mabi=64
+
+run-octeon-insns: QEMU_OPTS+=-cpu Octeon68XX
diff --git a/tests/tcg/mips64el/Makefile.target b/tests/tcg/mips64el/Makefile.target
new file mode 100644
index 0000000000..dbc5f8dc5f
--- /dev/null
+++ b/tests/tcg/mips64el/Makefile.target
@@ -0,0 +1,8 @@
+# -*- Mode: makefile -*-
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# MIPS64 little-endian - included from tests/tcg/Makefile.target
+#
+
+include $(SRC_PATH)/tests/tcg/mips64/Makefile.target

-- 
2.54.0


