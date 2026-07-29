Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C2EC54FD4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBJi-0001Ca-Ul; Wed, 29 Jul 2026 16:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBJf-0001B0-UB
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:55:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1wpBJc-0003DQ-5H
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:55:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2caed617615so17538365ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785358546; x=1785963346; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MqCGVPZaL8YlpK75awrlyK4ZvCplq5GmdHaR78M3eVw=;
 b=SBSKIqgN2/0vw4tlHHXbr+3xCbNai+rliDULSAd2aFNl6XT0c2EE8E43baTZaoD97H
 SdS+l1EMju/zqCq72A3MBYzJ5We7ib6RxmzRYoZ87nZT1EBJsXDM6BrHOHfdP7+5XUVb
 OvZYr+l7bR66VHH1MOASRDxY28Pva4+9exrhMWk2sjdkrmjj7MQVh2FBMrBINAUWwKIz
 asxjW7OCrV+RBvg8St7bKhx0gTuc+Dfj3YMUp7sXuIYW8Dxb793JhmhXwIzMXI/Qh3SP
 1ZzzbkjnwgsFU5wKK+zW+NrkQOtV9FoJWAUXGc/r4E5hw3TA+zn6E1WLIZ5xLAGMJZ2p
 mhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785358546; x=1785963346;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MqCGVPZaL8YlpK75awrlyK4ZvCplq5GmdHaR78M3eVw=;
 b=FKpKplM1I2adqDUczeLgW2RODeu9lJ9A6IVtG1YZgnxS5dGOYc0XgwVcCunSor0tj/
 Law79jeBE6tYgwPCFSY2F+DFSC8nZi8b+wTFdy6UTQQOQMtqsaFfz/HCUWy2XFRqY0ae
 KBvGHaYBOaXeZfDe5Gr7yCaxlvqfLNDZTKTuId0EzdNsH2/E30H9LyRbuzDzSDnRLBTY
 GJCIwqWrrYlFhR/YMtgsjVa7Pol2bc/c64mbtzRLnFfWY7PXUIKa7il1Hae9pJPYE+5P
 nUsMlYD1qoYQhKFyeyM3H0MTv9jtliMjDKbR1LGr3ywl355erFPa+Lkycy+qfO+h0VVg
 GS9A==
X-Gm-Message-State: AOJu0YwB1c1XFC/NbhnZTGVElDsbG6+23Gs3rwHKj9O4qUn4ncbCyQiZ
 WA076HxNDlBoLl8lIZeG2sipQx6MXpIrcxV1Ny+F5WAW8JF/gWNwL5Xh
X-Gm-Gg: AR+sD13CrD4+7k633nkGjg5E8ctpptBGoHQkKNYFxkT+ysjRSFHSmZsY9UKndfrqzuq
 cMnmzzobQitHWBTUtBDqK9091HF1w+ZbpuUv4QkEdc75+6nb7/GhHnzrhFXrfeOdOTYLkT3UqI+
 +FlCPNYsziA4U4b19AFQMFNsXMjQmDFi3rFnQmi3CyHBq1O/HvPcCLOuNqLKskYhPpIq81fwZiT
 xDnE9E0blDw7Ys6HKS2J/7GipzuwPd7RDCfr9d1Gpix9CIdcMeRkZdjCJK4sLDxfhEiU12CRwrW
 jrDnhZZoXEMhxDYaFoL2AT+PJfQAWy/c7buR3kYzMhVG6qtFfpuhmbExvb+xfovxCeko/GsGW+4
 kdxbLNirX0kCG6l7jHFhTCIVM3cpZH+mvpx/X5FK8cD89j0Jx/yYG+WW3DisILZFTUwcW+GHivw
 SYpKS5qWCf1wu71+604raLZCAcnQdIx+4U61womF68sS4U2thdQ5GoYTBwHb1MyqwOsHx+kdR1
X-Received: by 2002:a05:6a21:6916:b0:3c3:ca18:b4a4 with SMTP id
 adf61e73a8af0-3c8ba5baaf4mr9203220637.43.1785358545748; 
 Wed, 29 Jul 2026 13:55:45 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:66a:cb3f:f6a7:d5f0])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7271f010sm14868879c88.9.2026.07.29.13.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 13:55:45 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Date: Wed, 29 Jul 2026 13:55:07 -0700
Subject: [PATCH 1/2] target/sh4: add tcg tests for fmov instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-sh4-fix-fmov-instructions-b4-v1-1-65cc9679025a@gmail.com>
References: <20260729-sh4-fix-fmov-instructions-b4-v1-0-65cc9679025a@gmail.com>
In-Reply-To: <20260729-sh4-fix-fmov-instructions-b4-v1-0-65cc9679025a@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1785358542; l=14000;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=BSwpivmp4jY+2Pjwh4iaeavOawEQ5IaV/K9rAJljvF0=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgJytY41ZYpWIGAD/MBT0QESTNx3PCJJ7TTzD56VVN25IqUfyo
 +Avx+OpqXc23i8/5MTOVd+mRkAy8RaI7xMKGRTi0exJUqTZBY737Hy9VlpLcQDN/ddjSNki0UzG
 BRj5pG8MJXuJtgSGJ6jaWcsWqlnaRbFtX6/0aFAge2Jl4mPwps+C4Ji1hPtDn6KGuXMJQACzkzV
 oyS+W9YY+uJthXK/YvDMawpWHp8wxkOFi7jreAfnRND7klyja3KEJv1IuujsyPUtfKEcvtlZ1EY
 Hy1m1MzdkWA5/k7PiiNl1fmfEdKHvAcgYnG8ok1/Ot96ZJ8y3uoTR2RZEJpwFLZDUmggIBnAGAp
 f8AHE2OvUQ+qT+WiwxsCo6w0fKBkJu8mwEDAIApuusMBhMK0Xu+xbnqOidA0laW/NVRgIe6RVZa
 yVT0iJhzxHZbxXBIx/RozvQMH7dnhRIAWT/Gr5d7EqbO5quUdC/I5uiyB4ma6+txdsH6M8krdix
 SgZnwiwo6V8jzgA==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=randy.schifflin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add tests for the TCG generation of the sh4-specific `fmov`
  instructions. Covers register/register and register/memory
  in each direction, for single and double precision fp registers,
  and with direct and indirect memory addressing.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
---
 tests/tcg/sh4/Makefile.target |   3 +
 tests/tcg/sh4/test-fpu-fmov.c | 518 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 521 insertions(+)

diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index b7a8737be0..82f4898f90 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -16,3 +16,6 @@ TESTS += test-addv
 
 test-subv: CFLAGS += -O -g
 TESTS += test-subv
+
+test-fpu-fmov: CFLAGS += -O -g
+TESTS += test-fpu-fmov
diff --git a/tests/tcg/sh4/test-fpu-fmov.c b/tests/tcg/sh4/test-fpu-fmov.c
new file mode 100644
index 0000000000..90e51923ed
--- /dev/null
+++ b/tests/tcg/sh4/test-fpu-fmov.c
@@ -0,0 +1,518 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#define ARR_SIZE 16
+static const float in_arr[ARR_SIZE] = {
+    1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0,
+    9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0
+};
+
+static float out_arr[ARR_SIZE] = {
+    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
+    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
+};
+
+static const unsigned long FPSCR_PR_BIT = 1UL << 19;
+static void single_precision_mode(void)
+{
+    unsigned long fpscr;
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    fpscr &= ~FPSCR_PR_BIT;
+    asm volatile("lds %0, fpscr" : : "r" (fpscr));
+}
+
+static void double_precision_mode(void)
+{
+    unsigned long fpscr;
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    fpscr |= FPSCR_PR_BIT;
+    asm volatile("lds %0, fpscr" : : "r" (fpscr));
+}
+
+static void fill_arr(float *arr, float n)
+{
+    for (int i = 0; i < ARR_SIZE; i++) {
+        arr[i] = n;
+    }
+}
+
+/* uses fmov frm,frn instruction */
+static int test_fmov_freg_freg(void)
+{
+    int pass = true;
+
+    register float out asm ("fr0") = 0.0;
+    asm volatile(
+        "fldi1 fr1\n"
+        "fmov fr1,%0\n"
+        : "=f" (out)
+    );
+
+    if (out != 1.0) {
+        fprintf(
+            stderr,
+            "fmov freg,freg failed. Expected %f, got %f\n", 1.0, out
+        );
+        pass = false;
+    }
+
+    return pass;
+}
+
+/* uses fmov frm,@rn instruction */
+static int test_fmov_freg_addr(float *out)
+{
+    int pass = true;
+    fill_arr(out, 0);
+
+    register float *out_addr = out;
+    asm volatile(
+        "fldi1   fr0\n"
+        "fmov.s  fr0,@%0\n"
+        : : "r" (out_addr) : "memory"
+    );
+
+    if (out[0] != 1.0) {
+        fprintf(
+            stderr,
+            "fmov freg,addr failed. Expected %f, got %f\n", 1.0, out[0]
+        );
+        pass = false;
+    }
+
+    fill_arr(out, 0);
+    return pass;
+}
+
+/* uses fmov @rm,frn instruction */
+static int test_fmov_addr_freg(const float *in)
+{
+    int pass = true;
+    const register float *in_addr = in;
+    register float out = 0.0;
+    asm volatile(
+        "fmov.s    @%1,%0\n"
+        : "=f" (out) : "r" (in_addr)
+    );
+
+    if (out != 1.0) {
+        fprintf(
+            stderr,
+            "fmov addr,freg failed. Expected %f, got %f\n", 1.0, out
+        );
+        pass = false;
+    }
+
+    return pass;
+}
+
+/* uses fmov frm,@(r0,rn) instruction */
+static int test_fmov_freg_indirect_addr(float *out)
+{
+    int pass = true;
+    fill_arr(out, 0.0);
+
+    register float *out_addr = out;
+    asm volatile(
+        "mov      #4,r0\n"
+        "fldi1    fr0\n"
+        "fmov.s   fr0, @(r0, %0)\n"
+        : : "r" (out_addr) : "memory"
+    );
+
+    if (out[1] != 1.0) {
+        fprintf(
+            stderr,
+            "fmov freg,indirect_addr failed. Expected %f, got %f\n", 1.0, out[1]
+        );
+        pass = false;
+    }
+
+    fill_arr(out, 0.0);
+    return pass;
+}
+
+/* uses fmov @(r0,rm),frn instruction */
+static int test_fmov_indirect_addr_freg(const float *in)
+{
+    int pass = true;
+
+    const register float *in_addr asm ("r1") = in;
+    register float out asm ("fr0") = 0.0;
+    asm volatile(
+        "mov      #4,r0\n"
+        "fmov.s   @(r0, %1), %0\n"
+        : "=f" (out) : "r" (in_addr) : "memory"
+    );
+
+    if (out != in[1]) {
+        fprintf(
+            stderr,
+            "fmov indirect_addr,freg failed. Expected %f, got %f\n", in[1], out
+        );
+        pass = false;
+    }
+
+    return pass;
+}
+
+/* uses fmov drm,drn instruction */
+static int test_fmov_dreg_dreg(void)
+{
+    int pass = true;
+    double_precision_mode();
+
+    register double out asm ("dr0") = 0.0;
+    asm volatile(
+        "mov   #42,r0\n"
+        "lds   r0,fpul\n"
+        "float fpul,dr2\n"
+        "fmov  dr2,%0\n"
+        : "=f" (out)
+    );
+
+    if (out != 42.0) {
+        fprintf(
+            stderr,
+            "fmov dreg,dreg failed. Expected %f, got %f\n", 42.0, out
+        );
+        pass = false;
+    }
+
+    single_precision_mode();
+    return pass;
+}
+
+/* uses fmov drm,@rn instruction */
+static int test_fmov_dreg_addr(float *out)
+{
+    int pass = true;
+    fill_arr(out, -1.0);
+
+    register float *out_addr = out;
+    asm volatile(
+        "fldi0 fr0\n"
+        "fldi1 fr1\n"
+        "fschg\n" /* Set fast pairs on */
+        "fmov   dr0, @%0\n"
+        "fschg\n" /* Set fast pairs off */
+        : : "r" (out_addr) : "memory"
+    );
+
+    if (out[0] != 0.0) {
+        fprintf(
+            stderr,
+            "fmov dreg,addr failed. " \
+                "Expected element 0 to be %f, got %f\n", 0.0, out[0]
+        );
+        pass = false;
+    }
+    if (out[1] != 1.0) {
+        fprintf(
+            stderr,
+            "fmov dreg,addr failed. " \
+                "Expected element 1 to be %f, got %f\n", 1.0, out[1]
+        );
+        pass = false;
+    }
+
+    fill_arr(out, 0.0);
+    return pass;
+}
+
+/* uses fmov @rm,drn instruction */
+static int test_fmov_addr_dreg(const float *in)
+{
+    int pass = true;
+
+    const register float *in_addr asm ("r1") = in;
+    register float write_out_0 asm ("fr0") = 0.0;
+    register float write_out_1 asm ("fr1") = 0.0;
+
+    asm volatile(
+        "fschg\n" /* Set fast pairs on */
+        "fmov    @%2,dr0\n"
+        "fschg\n" /* Set fast pairs off */
+        : "=f" (write_out_0), "=f" (write_out_1) : "r" (in_addr) : "memory"
+    );
+
+    if (write_out_0 != in[0]) {
+        fprintf(
+            stderr,
+            "fmov addr,dreg failed. " \
+                "Expected element 0 to be %f, got %f\n", in[0], write_out_0
+        );
+        pass = false;
+    }
+    if (write_out_1 != in[1]) {
+        fprintf(
+            stderr,
+            "fmov addr,dreg failed. " \
+                "Expected element 1 to be %f, got %f\n", in[1], write_out_1
+        );
+        pass = false;
+    }
+
+    return pass;
+}
+
+/* uses fmov drm,@(r0,rn) instruction */
+static int test_fmov_dreg_indirect_addr(float *out)
+{
+    int pass = true;
+    fill_arr(out, -1.0);
+
+    register float *out_addr = out;
+    asm volatile(
+        "mov      #8,r0\n"
+        "fldi0    fr0\n"
+        "fldi1    fr1\n"
+        "fschg\n" /* Set fast pairs on */
+        "fmov   dr0, @(r0, %0)\n"
+        "fschg\n" /* Set fast pairs off */
+        : : "r" (out_addr) : "memory"
+    );
+
+    if (out[2] != 0.0) {
+        fprintf(
+            stderr,
+            "fmov dreg,indirect_addr failed. " \
+                "Expected element 0 to be %f, got %f\n", 0.0, out[2]
+        );
+        pass = false;
+    }
+
+    if (out[3] != 1.0) {
+        fprintf(
+            stderr,
+            "fmov dreg,indirect_addr failed. " \
+                "Expected element 1 to be %f, got %f\n", 1.0, out[3]
+        );
+        pass = false;
+    }
+
+    fill_arr(out, 0.0);
+    return pass;
+}
+
+/* uses fmov @(r0,rm),drn instruction */
+static int test_fmov_indirect_addr_dreg(const float *in)
+{
+    int pass = true;
+
+    const register float *in_addr asm ("r1") = in;
+    register float write_out_0 asm ("fr0") = 0.0;
+    register float write_out_1 asm ("fr1") = 0.0;
+    asm volatile(
+        "mov      #8,r0\n"
+        "fschg\n" /* Set fast pairs on */
+        "fmov     @(r0, %2), dr0\n"
+        "fschg\n" /* Set fast pairs off */
+        : "=f" (write_out_0), "=f" (write_out_1) : "r" (in_addr) : "memory"
+    );
+
+    if (write_out_0 != in[2]) {
+        fprintf(
+            stderr,
+            "fmov indirect_addr,dreg failed. " \
+                "Expected element 0 to be %f, got %f\n", in[2], write_out_0
+        );
+        pass = false;
+    }
+
+    if (write_out_1 != in[3]) {
+        fprintf(
+            stderr,
+            "fmov indirect_addr,dreg failed. " \
+                "Expected element 1 to be %f, got %f\n", in[3], write_out_1
+        );
+        pass = false;
+    }
+
+    return pass;
+}
+
+/*
+ * reads in data from `in` using fast pairs
+ * writes data to `out` using slow singles
+ * uses fmov @rm+,drn instruction
+ * uses fmov frm,@-rn instruction
+ */
+static int test_fmov_fast_in_slow_out(const float *in, float *out)
+{
+    int pass = true;
+    fill_arr(out, 0.0);
+
+    const register float *in_addr = in;
+    register float *out_addr = out;
+    asm volatile(
+        "fschg\n" /* Set fast pairs on */
+        "fmov @%0+,dr0\n"
+        "fmov @%0+,dr2\n"
+        "fmov @%0+,dr4\n"
+        "fmov @%0+,dr6\n"
+        "fmov @%0+,dr8\n"
+        "fmov @%0+,dr10\n"
+        "fmov @%0+,dr12\n"
+        "fmov @%0+,dr14\n"
+        "fschg\n" /* Set fast pairs off */
+
+        "add #64,%1\n" /* Start at the back and work to the front */
+        "fmov fr15,@-%1\n"
+        "fmov fr14,@-%1\n"
+        "fmov fr13,@-%1\n"
+        "fmov fr12,@-%1\n"
+        "fmov fr11,@-%1\n"
+        "fmov fr10,@-%1\n"
+        "fmov fr9,@-%1\n"
+        "fmov fr8,@-%1\n"
+        "fmov fr7,@-%1\n"
+        "fmov fr6,@-%1\n"
+        "fmov fr5,@-%1\n"
+        "fmov fr4,@-%1\n"
+        "fmov fr3,@-%1\n"
+        "fmov fr2,@-%1\n"
+        "fmov fr1,@-%1\n"
+        "fmov fr0,@-%1\n"
+        : "+r" (in_addr), "+r" (out_addr) :: "memory"
+      );
+
+    for (int i = 0; i < ARR_SIZE; i++) {
+        if (in[i] != out[i]) {
+            fprintf(
+                stderr,
+                "fmov fast->slow failed. " \
+                    "Expected element %i to be %f, got %f\n", i, in[i], out[i]
+            );
+            pass = false;
+        }
+    }
+
+    fill_arr(out, 0.0);
+    return pass;
+}
+
+/* reads in data from `in` using slow singles */
+/* writes data to `out` using fast pairs */
+/* uses fmov @rm+,frn instruction */
+/* uses fmov drm,@-rn instruction */
+static int test_fmov_slow_in_fast_out(const float in[16], float out[16])
+{
+    int pass = true;
+    fill_arr(out, 0.0);
+
+    const register float *in_addr = in;
+    register float *out_addr = out;
+    asm volatile(
+        "fmov @%0+,fr0\n"
+        "fmov @%0+,fr1\n"
+        "fmov @%0+,fr2\n"
+        "fmov @%0+,fr3\n"
+        "fmov @%0+,fr4\n"
+        "fmov @%0+,fr5\n"
+        "fmov @%0+,fr6\n"
+        "fmov @%0+,fr7\n"
+        "fmov @%0+,fr8\n"
+        "fmov @%0+,fr9\n"
+        "fmov @%0+,fr10\n"
+        "fmov @%0+,fr11\n"
+        "fmov @%0+,fr12\n"
+        "fmov @%0+,fr13\n"
+        "fmov @%0+,fr14\n"
+        "fmov @%0+,fr15\n"
+
+        "fschg\n" /* Set fast pairs on */
+        "add #64,%1\n" /* Start at the back and work to the front */
+        "fmov dr14,@-%1\n"
+        "fmov dr12,@-%1\n"
+        "fmov dr10,@-%1\n"
+        "fmov dr8,@-%1\n"
+        "fmov dr6,@-%1\n"
+        "fmov dr4,@-%1\n"
+        "fmov dr2,@-%1\n"
+        "fmov dr0,@-%1\n"
+        "fschg\n" /* Set fast pairs off */
+        : "+r" (in_addr), "+r" (out_addr) :: "memory"
+      );
+
+    for (int i = 0; i < ARR_SIZE; i++) {
+        if (in[i] != out[i]) {
+            fprintf(
+                stderr,
+                "fmov slow->fast failed. " \
+                    "Expected element %i to be %f, got %f\n", i, in[i], out[i]
+            );
+            pass = false;
+        }
+    }
+
+    fill_arr(out, 0.0);
+    return pass;
+}
+
+int main(void)
+{
+    single_precision_mode();
+    int pass = true;
+
+    if (!test_fmov_freg_freg()) {
+        pass = false;
+    };
+
+    if (!test_fmov_freg_addr(out_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_addr_freg(in_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_freg_indirect_addr(out_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_indirect_addr_freg(in_arr)) {
+        pass = false;
+    };
+
+    if (!test_fmov_dreg_dreg()) {
+        pass = false;
+    }
+
+    if (!test_fmov_dreg_addr(out_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_addr_dreg(in_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_dreg_indirect_addr(out_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_indirect_addr_dreg(in_arr)) {
+        pass = false;
+    };
+
+    if (!test_fmov_fast_in_slow_out(in_arr, out_arr)) {
+        pass = false;
+    }
+
+    if (!test_fmov_slow_in_fast_out(in_arr, out_arr)) {
+        pass = false;
+    }
+
+    if (!pass) {
+        fprintf(
+            stderr,
+            "Fmov tests failed\n"
+        );
+        abort();
+    }
+
+    return 0;
+}

-- 
2.43.0


