Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B0C43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 00:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weMS6-0001hb-JU; Mon, 29 Jun 2026 20:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1weJri-00053n-8b
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:50:07 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randy.schifflin@gmail.com>)
 id 1weJre-0000Ii-2N
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:50:05 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-139f3eaaa49so1456767c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782769800; x=1783374600; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gr22IlubKHJ2OEFeZd/t989XmyhwFF2RBqpMnZFqhoY=;
 b=afz10GP1Xe4d6kRh4VjwsjKRn8NNPtpPSS5BWgso+rvsGTsaDH6Feu7WJcfRZvpaSr
 D4JXsQjA4JaXwYSquUs516eRpVQ4Etu+ysMaaXuMiTJb+ZAvFEB09jUhDhOuwVSdDNhQ
 b4AfD8c1KRF+jKnUmbv9NX2vfAxOKdRf9PHYCci8tD7LcyidTacw9mpsuODtkd9wr9Y6
 MP2ZPsIqBwzM4yREbNZ87E+okr/kPPA8N9jXScSL0Ox3o/0rDNnOc0JQuklkuRv5dwLU
 GoNZ5Jr0g7wHKoxVTZNblRPyH+GGXxtaEgNAKPi5AahDLpCJ34ZBERdkdEehuOP07dL5
 Zn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782769800; x=1783374600;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gr22IlubKHJ2OEFeZd/t989XmyhwFF2RBqpMnZFqhoY=;
 b=bdPAlKJCBe9EUyLYXzQscvmjsNy2lMR2XvfoAXNnpdbDXzIfU2X2I6o25fwN8AO9px
 F1Ps21ijQU1C9J+HxPlBbpFxg1siJ+AWKmhPDm7pCwNj1iVsn3/u/NU5jkTpJa19quho
 DJZPu4//spBgtG2gxIVBQRvZofPoEyhfA9ayg3p9nvdxnGsU2unCrPoyWCTUbeXXPmVB
 kdPF/Np31ysP9wLe7PrHvxoSGbsK6UVr2zllYo+AfJXBDbaRAZKF8naetwjN6BXbHt5W
 U03vvll8TXbM7RsvYgVoC9JWFSY67Cdvpis+H0nprQQ1kFyWNXqobj6zMku815pd6L01
 XvFQ==
X-Gm-Message-State: AOJu0YwhBIwfJitNXsEv8thTWvKTpOwuDjAB4CjJ4s5JZgDfcqnjQZLi
 NpJH9dU5sAj9AtISKwhW7viYFQN58H9yN3FxKQRZL/2cctI7yIrgC4BIecOe4BvDKoM=
X-Gm-Gg: AfdE7cnaXxgnHuRai0CnDZUbbo06+2uOI2vcZxvoByicbPptppRUmkjAzX/wqw+Omz7
 LfpKSaMxSrZgENfFaumQdaeQ4M1hGkisUdjx2MHqYUy1QYgIScECMVXaGv8BR67mra6Fiunutge
 MV/3S44atWKwmzQptgwBAPPp5vU2fLZ38cD3B+3gcfyiwOfQ3qS5M/qXpHV2dKq4OnYG2Z6UWkZ
 Uos9VN27VvbELDVzQcTJdwoMFmDMYLwYDLSLUr9eD/GKGKLUPzDml/I+DCT0W4+Lm00yDR9Gi08
 Revg3IS/3d7AUH4Qup5mlYYgV6uZh+jXpF3STLrlVS1BXHnWQbw+ZXmuj2rDQnes7i7esJJ22yi
 bHFXrKqgt9YtxIPteCVoJ1dpy3qAz2TippAVQgCDRMRUGBFzWXKgIcSc+XHYK6ldu7Lm51Pq7BT
 W6VKTRH8gjCL/eHZfL45Tqc6Lh
X-Received: by 2002:a05:7022:e18:b0:139:ba7d:84a2 with SMTP id
 a92af1059eb24-13b2a16e278mr635474c88.21.1782769799662; 
 Mon, 29 Jun 2026 14:49:59 -0700 (PDT)
Received: from devone.local ([2600:8801:100:1910:7665:6164:2268:839e])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm1755523c88.0.2026.06.29.14.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:49:59 -0700 (PDT)
From: Randy Schifflin <randy.schifflin@gmail.com>
Date: Mon, 29 Jun 2026 14:49:12 -0700
Subject: [PATCH 1/2] target/sh4: add tests for sh4 fipr and ftrv instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-1-4356b305f971@gmail.com>
References: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-0-4356b305f971@gmail.com>
In-Reply-To: <20260629-fixup-sh4-tcg-fpu-instructions-b4-v1-0-4356b305f971@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-trivial@nongnu.org, 
 Randy Schifflin <randy.schifflin@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1782769797; l=5989;
 i=randy.schifflin@gmail.com; s=id_rsa; h=from:subject:message-id;
 bh=NbSl5+Eqy3Fn4qFPP/jg1KONm/toXsKbwNh7FUGXBuY=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBALXHj1ozDvr3TmWcPoueK1kIy
 Q3yQ7HL5bbiu8J+P0QBzcchmw5nwN0avQmreXhYuMhz40g0dhCJPnJqNHg1FBflQPz2cgY7Utm3
 9lQrK/CQqWsjRwXMinMR7LrmtMFp9+up7MzdXoxmTLgPsKJ/dQmx0rUHx++mUSl8zl7lHO50YVD
 hsw1RHrkrXlxnUjRi+jtjgErRHvoRwSZpKc44yR62wV8chkTMnHtrn8hgL0Hh+jhHteNn4JTQB/
 wme8MghhliXR5oh9xirpeLlS9S4TBY3Vdk6ccgvncSS4uF/y2ZAAV5sNiLZ97OFkBhIQ0bXhVx9
 w1LPMkho650Iu9da5/0koNheHS2KAVC2FdPTyaxvqeFAsAB8fCprfh4lpShdcVpyChdd2KXFS53
 s9MAUQmZjG0pQvS/dqGCCDWqo7cY3J3VTMXwVtdzYkgZt5eMajL7z8VljXQ08ZgAStdizC/rHNg
 wy+fIL+6kgxvL/NhJwoiAWhC4D+xQY7SXjJGTvwAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgDQF75nY5RTn+E12r9uTTRJhFonxgAnx8Zrb4D2uBUU8hGDkd
 9ZOGaCpJ5rKP301TWINbUJqcAij4HL8+jEjddRl3l1Ol+sjMikjYHf4y2NRJOXvGTVBRQZ3vf8t
 yoVsObCv2XPpIycBQDxKcHNhyeaKp2P8uWJQGPnS+HD2qnOlp3DtUskKgiHOhC/JThKRPirzuWg
 U30pYn/jLfvMPnGl6yRFIJjIMfyRrXyFp89xPOOMNC63HqGjUYxtrb3DuXxnOoWLqHrHsmDXyWY
 yDcsBRK06iQfW9AiRZQLBFuOYzyzGcDFY8iJrybZ2HJX/AmOzMmTjPKT+l25RbM+qARBW4g3+Zq
 yswLBgqtB1dKh4kNWM6sqwE3lpFXAQgs9JyNq3JI+F9sMlIytvNLHSuQwpNQvCCOVHyiGpR93mJ
 hsB3tQSkpoL4t3hCyGLV+xGS1CgxFDLCixxHgHfK5W/wSyP+V1O2ekgpqsi7/lOzUWXaIwcFLxt
 nb5+0GlZxEWW+wQ==
X-Developer-Key: i=randy.schifflin@gmail.com; a=openssh;
 fpr=SHA256:7gww1tlDoVPb7symWGdTNhRWcHyTORA23OcjS8eyd8Y
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=randy.schifflin@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 29 Jun 2026 20:35:48 -0400
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

Add tests for the TCG generation of the sh4-specific `fipr`
and `ftrv` instructions.

Signed-off-by: Randy Schifflin <randy.schifflin@gmail.com>
---
 tests/tcg/sh4/Makefile.target |  7 +++
 tests/tcg/sh4/test-fpu-fipr.c | 64 ++++++++++++++++++++++++++++
 tests/tcg/sh4/test-fpu-ftrv.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index b7a8737be0..0975fac72d 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -16,3 +16,10 @@ TESTS += test-addv
 
 test-subv: CFLAGS += -O -g
 TESTS += test-subv
+
+test-fpu-fipr: CFLAGS += -O -g
+TESTS += test-fpu-fipr
+
+test-fpu-ftrv: CFLAGS += -O -g
+TESTS += test-fpu-ftrv
+
diff --git a/tests/tcg/sh4/test-fpu-fipr.c b/tests/tcg/sh4/test-fpu-fipr.c
new file mode 100644
index 0000000000..bf8258fc36
--- /dev/null
+++ b/tests/tcg/sh4/test-fpu-fipr.c
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdlib.h>
+static const unsigned long FPSCR_PR_BIT = 1UL << 19;
+
+static void single_precision_mode(void) {
+    unsigned long fpscr;
+    // Read FPSCR register
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    // Set precision mode to single-precision
+    fpscr &= ~FPSCR_PR_BIT;
+    // Write FPSCR register
+    asm volatile("lds %0, fpscr" : : "r" (fpscr)); 
+}
+
+static float fipr(const float v1[4], const float v2[4]) {
+    float fout = 0.0;
+    // Perform inner product of fv4 and fv8
+    // Result is stored in the last float register of the last vector argument
+    asm volatile(
+        "fmov %1,fr4\n"
+        "fmov %2,fr5\n"
+        "fmov %3,fr6\n"
+        "fmov %4,fr7\n"
+        "fmov %5,fr8\n"
+        "fmov %6,fr9\n"
+        "fmov %7,fr10\n"
+        "fmov %8,fr11\n"
+        "fipr	fv4,fv8\n" // (fr4,fr5,fr6,fr7) dot (fr8,fr9,fr10,fr11)
+        "fmov fr11,%0\n"   // Result in fr11
+        : "=f" (fout) 
+        : "f" (v1[0]), "f" (v1[1]), "f" (v1[2]), "f" (v1[3]), "f" (v2[0]), "f" (v2[1]), "f" (v2[2]), "f" (v2[3]));
+    return fout;
+}
+
+int main(void)
+{
+    // The SH4 manual specifies `fipr` is only available when FPSCR register precision-mode (PR) bit is 0
+    single_precision_mode();
+
+    float v1[4] = {1.0, 0.0, 0.0, 0.0};
+    float mag_sq = 0.0;
+    float dot = 0.0;
+
+    mag_sq = fipr(v1, v1);
+    if (mag_sq != 1.0) {
+        abort();
+    }
+
+    v1[0] = 2.0;
+    mag_sq = fipr(v1, v1);
+    if (mag_sq != 4.0) {
+        abort();
+    }
+
+    float v2[4] = {1.0, 0.0, 0.0, 0.0};
+    dot = fipr(v1, v2);
+    if (dot != 2.0) {
+        abort();
+    }
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/test-fpu-ftrv.c b/tests/tcg/sh4/test-fpu-ftrv.c
new file mode 100644
index 0000000000..1018da1b7c
--- /dev/null
+++ b/tests/tcg/sh4/test-fpu-ftrv.c
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <limits.h>
+#include <stdlib.h>
+static const unsigned long FPSCR_PR_BIT = 1UL << 19;
+
+static void single_precision_mode(void) {
+    unsigned long fpscr;
+    // Read FPSCR register
+    asm volatile("sts fpscr, %0" : "=r" (fpscr));
+    // Set precision mode to single-precision
+    fpscr &= ~FPSCR_PR_BIT;
+    // Write FPSCR register
+    asm volatile("lds %0, fpscr" : : "r" (fpscr)); 
+}
+
+// Set XMTRX registers to a doubling scale matrix
+static void xmtrx_scale_2(void) {
+    asm volatile(
+        "fldi0 fr0\n" // Pair dr0 (fr0, fr1) = zero,zero
+        "fldi0 fr1\n"
+        "fldi1 fr2\n"
+        "fadd fr2,fr2\n" // Pair dr2 (fr2,fr3) = two,zero
+        "fldi0 fr3\n"
+        "fldi0 fr4\n"
+        "fmov fr2,fr5\n" // Pair dr4 (fr4, fr5) = zero,two
+
+        // Enable pair-write
+        "fschg\n" 
+        // matrix[0][0] = 2.0
+        // matrix[0][1] = 0.0
+        "fmov dr2,xd0\n" 
+        // matrix[0][2] = 0.0
+        // matrix[0][3] = 0.0
+        "fmov dr0,xd2\n"
+        // matrix[1][0] = 0.0
+        // matrix[1][1] = 2.0
+        "fmov dr4,xd4\n"
+        // matrix[1][2] = 0.0
+        // matrix[1][3] = 0.0
+        "fmov dr0,xd6\n"
+        // matrix[2][0] = 0.0
+        // matrix[2][1] = 0.0
+        "fmov dr0,xd8\n"
+        // matrix[2][2] = 2.0
+        // matrix[2][3] = 0.0
+        "fmov dr2,xd10\n"
+        // matrix[3][0] = 0.0
+        // matrix[3][1] = 0.0
+        "fmov dr0,xd12\n"
+        // matrix[3][2] = 0.0
+        // matrix[3][3] = 2.0
+        "fmov dr4,xd14\n"
+        // Disable pair-write
+        "fschg"
+        :
+        :
+        : "fr0", "fr1", "fr2", "fr3", "fr4", "fr5");
+}
+
+// The SH4 manual specifies `ftrv` is only available when FPSCR register precision-mode (PR) bit is 0, aka single-precision
+// Transform vector vin by xmtrx; store result in vector vout
+static void ftrv(const float vin[4], float vout[4]) {
+    asm volatile("fmov %4,fr0\n" 
+                 "fmov %5,fr1\n" 
+                 "fmov %6,fr2\n" 
+                 "fmov %7,fr3\n" 
+                 "ftrv xmtrx,fv0\n"
+                 "fmov fr0,%0\n" 
+                 "fmov fr1,%1\n" 
+                 "fmov fr2,%2\n" 
+                 "fmov fr3,%3" 
+                 : "=f" (vout[0]), "=f" (vout[1]), "=f" (vout[2]), "=f" (vout[3])
+                 : "f" (vin[0]), "f" (vin[1]), "f" (vin[2]), "f" (vin[3])
+                 : "fr0", "fr1", "fr2", "fr3");
+}
+
+int main(void)
+{
+    single_precision_mode();
+    xmtrx_scale_2();
+    float vin[4] = {1.0, 2.0, 3.0, 4.0};
+    float vout[4] = { 0.0, 0.0, 0.0, 0.0};
+
+    ftrv(vin, vout);
+    if (vout[0] != 2.0) {
+        abort();
+    }
+    if (vout[1] != 4.0) {
+        abort();
+    }
+    if (vout[2] != 6.0) {
+        abort();
+    }
+    if (vout[3] != 8.0) {
+        abort();
+    }
+
+    return 0;
+}

-- 
2.43.0


