Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB3DC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR40-0000rd-OT; Thu, 18 Jul 2024 09:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3t-00009B-QI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3r-0004Wh-Ly
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so349058f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308842; x=1721913642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yDhjBwtmOOJHxvon8Ehvv2T5x4XcBgN5wG00aOhg5yA=;
 b=rHWNZVQLbfc5eiFnRLcctNFDPNEI1lyG97fREleOGDJ+aY/eVmWxsLLU1wj4O9lCNL
 Aep7ZXTESkY9pR2aeio0NF1cVBq0Fy4zdu+JOfrJFA6P5d5N1FPriPBNMe1jp0VqDZRI
 rEP2oIr6AK6DYNvti3P4VjxJXwuEy7EvdkvkymzZefMGKjjbnn7MWABwbqsX+0ZGN1S8
 Tb0j+2e1Myyy+dcd78FuRQgkoztDRh4vcRWd4reV9vkis0ZIMlHEeCcbPYtCFdlavEVs
 Gm1w9QPnPQT0ihNzPzqm9rCZhGj6Qa/H1BO+8CjdgKM+cLvjbyNLcBJc9+pSnyIetVOs
 +whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308842; x=1721913642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yDhjBwtmOOJHxvon8Ehvv2T5x4XcBgN5wG00aOhg5yA=;
 b=saakLv6PZ/MycRNE5tk4JYDBZHl4j05e5KjdDvTvdpV3xEuMgMtpYlBG1axGer5I/z
 khxzsizPa6ggaKUx0D/AqzlRIqtmn7llXrcqwkt/9kNnT9dtLzcJRBkfIeknQXTc7W24
 XfJuhyNNagN/V1fwBOrrSIcfdcnQpZvXxKpbjSboYtVzoeUye25o+6PFsqzTDlayye1s
 zxJASDLRaZZnARsL/By9RBRDHUwuWHSXvaIhhx6yspj0510M1laPr8+8Ed00XoUAw4EI
 JzZT1QalpClFhtrpveVL4VzUsDVmrPmPagsu6MHChhw+ZbvQvErMHLLD2a8T4x3I0kNs
 hnLw==
X-Gm-Message-State: AOJu0YwOsWtfemU0qpMyahuQ4oDPOVG1qOeF1JYZj8nGzuA3jyU4TeZx
 SMICtdngn45hXV4JLAVcSVllwGb8icFztIvEEBmomUljumMp4yxSntqhQnYU8Lh3iwUqvYZ8f06
 Y
X-Google-Smtp-Source: AGHT+IGoeRIepqV9R2aLNKQRoRzGlZ2DahRSPPgE7Vb1G6O9H+R64kxbRrVmqaGeCUU6hjmB5vcAbQ==
X-Received: by 2002:adf:f746:0:b0:364:aafb:6020 with SMTP id
 ffacd0b85a97d-36831654ad5mr3329907f8f.14.1721308841756; 
 Thu, 18 Jul 2024 06:20:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/26] tests/tcg/aarch64: Add test cases for SME FMOPA
 (widening)
Date: Thu, 18 Jul 2024 14:20:26 +0100
Message-Id: <20240718132028.697927-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Daniyal Khan <danikhan632@gmail.com>

Signed-off-by: Daniyal Khan <danikhan632@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240717060149.204788-4-richard.henderson@linaro.org
Message-Id: 172090222034.13953.16888708708822922098-1@git.sr.ht
[rth: Split test from a larger patch, tidy assembly]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/sme-fmopa-1.c   | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-2.c   | 56 +++++++++++++++++++++++++++
 tests/tcg/aarch64/sme-fmopa-3.c   | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++-
 4 files changed, 185 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-fmopa-1.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-2.c
 create mode 100644 tests/tcg/aarch64/sme-fmopa-3.c

diff --git a/tests/tcg/aarch64/sme-fmopa-1.c b/tests/tcg/aarch64/sme-fmopa-1.c
new file mode 100644
index 00000000000..652c4ea0902
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-1.c
@@ -0,0 +1,63 @@
+/*
+ * SME outer product, 1 x 1.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+
+static void foo(float *dst)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"
+        "ptrue p0.s, vl4\n\t"
+        "fmov z0.s, #1.0\n\t"
+        /*
+         * An outer product of a vector of 1.0 by itself should be a matrix of 1.0.
+         * Note that we are using tile 1 here (za1.s) rather than tile 0.
+         */
+        "zero {za}\n\t"
+        "fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n\t"
+        /*
+         * Read the first 4x4 sub-matrix of elements from tile 1:
+         * Note that za1h should be interchangeable here.
+         */
+        "mov w12, #0\n\t"
+        "mova z0.s, p0/m, za1v.s[w12, #0]\n\t"
+        "mova z1.s, p0/m, za1v.s[w12, #1]\n\t"
+        "mova z2.s, p0/m, za1v.s[w12, #2]\n\t"
+        "mova z3.s, p0/m, za1v.s[w12, #3]\n\t"
+        /*
+         * And store them to the input pointer (dst in the C code):
+         */
+        "st1w {z0.s}, p0, [%0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z1.s}, p0, [x0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z2.s}, p0, [x0]\n\t"
+        "add x0, x0, #16\n\t"
+        "st1w {z3.s}, p0, [x0]\n\t"
+        "smstop"
+        : : "r"(dst)
+        : "x12", "d0", "d1", "d2", "d3", "memory");
+}
+
+int main()
+{
+    float dst[16] = { };
+
+    foo(dst);
+
+    for (int i = 0; i < 16; i++) {
+        if (dst[i] != 1.0f) {
+            goto failure;
+        }
+    }
+    /* success */
+    return 0;
+
+ failure:
+    for (int i = 0; i < 16; i++) {
+        printf("%f%c", dst[i], i % 4 == 3 ? '\n' : ' ');
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/sme-fmopa-2.c b/tests/tcg/aarch64/sme-fmopa-2.c
new file mode 100644
index 00000000000..15f0972d835
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-2.c
@@ -0,0 +1,56 @@
+/*
+ * SME outer product, FZ vs FZ16
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+
+static void test_fmopa(uint32_t *result)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"               /* Z*, P* and ZArray cleared */
+        "ptrue p2.b, vl16\n\t"      /* Limit vector length to 16 */
+        "ptrue p5.b, vl16\n\t"
+        "movi d0, #0x00ff\n\t"      /* fp16 denormal */
+        "movi d16, #0x00ff\n\t"
+        "mov w15, #0x0001000000\n\t" /* FZ=1, FZ16=0 */
+        "msr fpcr, x15\n\t"
+        "fmopa za3.s, p2/m, p5/m, z16.h, z0.h\n\t"
+        "mov w15, #0\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "mov w15, #2\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "smstop"
+        : "+r"(result) :
+        : "x15", "x16", "p2", "p5", "d0", "d16", "memory");
+}
+
+int main(void)
+{
+    uint32_t result[4 * 4] = { };
+
+    test_fmopa(result);
+
+    if (result[0] != 0x2f7e0100) {
+        printf("Test failed: Incorrect output in first 4 bytes\n"
+               "Expected: %08x\n"
+               "Got:      %08x\n",
+               0x2f7e0100, result[0]);
+        return 1;
+    }
+
+    for (int i = 1; i < 16; ++i) {
+        if (result[i] != 0) {
+            printf("Test failed: Non-zero word at position %d\n", i);
+            return 1;
+        }
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/aarch64/sme-fmopa-3.c b/tests/tcg/aarch64/sme-fmopa-3.c
new file mode 100644
index 00000000000..3bfec34914c
--- /dev/null
+++ b/tests/tcg/aarch64/sme-fmopa-3.c
@@ -0,0 +1,63 @@
+/*
+ * SME outer product, [ 1 2 3 4 ] squared
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <math.h>
+
+static const float i_1234[4] = {
+    1.0f, 2.0f, 3.0f, 4.0f
+};
+
+static const float expected[4] = {
+    4.515625f, 5.750000f, 6.984375f, 8.218750f
+};
+
+static void test_fmopa(float *result)
+{
+    asm(".arch_extension sme\n\t"
+        "smstart\n\t"               /* ZArray cleared */
+        "ptrue p2.b, vl16\n\t"      /* Limit vector length to 16 */
+        "ld1w {z0.s}, p2/z, [%1]\n\t"
+        "mov w15, #0\n\t"
+        "mov za3h.s[w15, 0], p2/m, z0.s\n\t"
+        "mov za3h.s[w15, 1], p2/m, z0.s\n\t"
+        "mov w15, #2\n\t"
+        "mov za3h.s[w15, 0], p2/m, z0.s\n\t"
+        "mov za3h.s[w15, 1], p2/m, z0.s\n\t"
+        "msr fpcr, xzr\n\t"
+        "fmopa za3.s, p2/m, p2/m, z0.h, z0.h\n\t"
+        "mov w15, #0\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "mov w15, #2\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 0]}, p2, [%0]\n\t"
+        "add %0, %0, #16\n\t"
+        "st1w {za3h.s[w15, 1]}, p2, [%0]\n\t"
+        "smstop"
+        : "+r"(result) : "r"(i_1234)
+        : "x15", "x16", "p2", "d0", "memory");
+}
+
+int main(void)
+{
+    float result[4 * 4] = { };
+    int ret = 0;
+
+    test_fmopa(result);
+
+    for (int i = 0; i < 4; i++) {
+        float actual = result[i];
+        if (fabsf(actual - expected[i]) > 0.001f) {
+            printf("Test failed at element %d: Expected %f, got %f\n",
+                   i, expected[i], actual);
+            ret = 1;
+        }
+    }
+    return ret;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b53218e1156..8cc62eb4561 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -70,8 +70,9 @@ endif
 
 # SME Tests
 ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-AARCH64_TESTS += sme-outprod1 sme-smopa-1 sme-smopa-2
-sme-outprod1 sme-smopa-1 sme-smopa-2: CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
+SME_TESTS = sme-outprod1 sme-smopa-1 sme-smopa-2 sme-fmopa-1 sme-fmopa-2 sme-fmopa-3
+AARCH64_TESTS += $(SME_TESTS)
+$(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
 # System Registers Tests
-- 
2.34.1


