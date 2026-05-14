Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C4BCD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa28-00028b-29; Thu, 14 May 2026 13:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa11-0000ri-IJ
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-00044Z-KK
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:30 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43587e63a8eso3344677fac.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780298; x=1779385098; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nw3HDB6j0qIWtAlWCdkrvZ/X4TTt9CXxz+wl282PJTE=;
 b=AxV8qYsvvy4v4VM8O5nopXa8sdwxXjYldL/FsLQB7Wto4osnd7wkyDfKSyLKznQCQ2
 pCkZSab6KiNWow/1UFdqYXEUfFuVJaPZVr9h2qrShtimjMa9VgKdAI0urK57UgjmIzQY
 MEk4Ulzmvr3PGvngOaoRFIAQBkBbiUZOkF8AyF3SsO0diRzfx/RGPMgrLaez5U4LzzpI
 ynjEiJieT6tt3C+YEUQvsnhOLh8ljdlSHqjGEogUqzyabaTwEjEilgJQ4Gc2mJikwFtN
 GsoujMG4jtEHFNEuKmab9I22W/Z1YM4vhkW3yceMIRxZGojEV1pX9sGzb9mEcpxTumDE
 kotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780298; x=1779385098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Nw3HDB6j0qIWtAlWCdkrvZ/X4TTt9CXxz+wl282PJTE=;
 b=sgC5LRXuq/LqiboTvvnsn20DKIVCkio8+0IAL1BWlpOBihHkAjQ38puuZJzsQ7Yz5q
 F7jvQ8cF5SXRhBtI5tIM5+zfs2FFe49Jk/knjbCggO5/oK+jmqAscHNkVECIfxumPAbN
 1fa51Npu5B9QTmbyy3KpHFEGimem6UB6eGG8JEsIoQ8DCrAay2jFmWz7VuV/t2IIjMoA
 EYvW3of3RSDZMNs4gWAoDzjSKpmfDNGGZRKHSULaUsUk+aTAOj918+wKBScTyptA/iBw
 E30ctZJI7xjcAZ1U3+pitzT42Amu+PidjWM9iYmqhAIr68iqRnzQtIr4Qei2joyCudKU
 mhfw==
X-Gm-Message-State: AOJu0Yy383PyWQ6SZLKNFv4SbxxKPO0Fk9e7bJDrn/RI6DcL3soiGX0n
 fbuxoocohn+z+FH8Sto3DQKm23Da2OHEx17CWKU+1suQUXdLzfSa4+mz
X-Gm-Gg: Acq92OGDsO9fjdClvZHOQNPzQcbUUqFUg62ZgXO/WU1lEzvKlm/LNcr5nYrOWU1W2da
 iYavx+OZZ+5HUEcZrsaa4GDhMBWkCuHgFP5lCSXEAkb+UX/vT2EtY8yPldgDF2NZvhr4dCzQwwD
 /ClJcL+rDcLweoUD3Trm20lNmgZafRlfqam+wPUYnE7GKBayBBDou2bbnpAb7A6XzOyEfkhnfUX
 9Fv6DFl3Ytd7qJIb9yoSr5zBxX2HErIA7agepl1hkWQ22XFLyuXtmJWRef3fILTi24muu24qb/A
 mgR3EMvpxl4xylKj4WupFv7jSpXPqyst1rWwBP5OeOTOMb91g4Ec3sfn6cUPyAokWOXtzD2jWVJ
 wWNFl46+HQMYHGjxJQqPDo4DZ9R2+K3xTpnc23Swqk3/E3OBrYbSNWMz7ensDhv9ovdcDAQc2rN
 EIx5TM/R1FdZi65U07nhlxqwBSh67Thi46W2YmZ0wKY/DjGu2dBmlHyspk/U4mCu+dRXcr/1qvB
 PVA8vxqQrAuDpEyBTXo1uDylWixtqd7WUDAbIV10wKXVo/SlYN0PeHQ49t0x7s2R/x3Xwxfp8KF
 wGk=
X-Received: by 2002:a05:6820:188c:b0:694:a062:1a96 with SMTP id
 006d021491bc7-69c952e8ad6mr208715eaf.46.1778780297987; 
 Thu, 14 May 2026 10:38:17 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:14 -0600
Subject: [PATCH v7 25/35] tests/tcg/mips: add Octeon instruction smoke test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-25-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2c.google.com
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
index 80d28e618d..5e402f7918 100644
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


