Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD041C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwg-0002Ol-O0; Mon, 10 Feb 2025 05:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwe-0002NU-1T
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwb-0000MN-TT
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGTMV/JVOhgwSD7zfFhjmY9o50J6ILSLJjCbihcs1Oc=;
 b=CLU+pHR5G8/IA2aIndM1i2IjbdSlB8xAaMmU8z83Qhq3aYxXNzLhzikVi5WsaWaFiODp/G
 udDjrPoB38gB9FOJLXfZn/jSzH7UvYWo3utyOcYDkteK1KkbOz3PMQYhNMCrAZSVWjm8KI
 rBGnNlD3mHTAnF++buLggggNMxeOwJA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-IKXnFx1ONMSw8OeeRsWHng-1; Mon, 10 Feb 2025 05:23:11 -0500
X-MC-Unique: IKXnFx1ONMSw8OeeRsWHng-1
X-Mimecast-MFC-AGG-ID: IKXnFx1ONMSw8OeeRsWHng
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab79858cd31so234989666b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182989; x=1739787789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGTMV/JVOhgwSD7zfFhjmY9o50J6ILSLJjCbihcs1Oc=;
 b=tMeC/GUsM24zLFYt4uwGlAGYdMCI/a9YE2f3WPRlfW7+9SKEnyOuauYhvxJqDjMCA3
 92Z7Xq+ssSIcjViYmy7WWwWwouCa56XdqGR77M1yfpcH93Nq8xE3XZ5W859REo8wqjMN
 S7WfO9wbo+/jukrUw4YDMfzfspeHU15b0Yl2leDaiWi/Ka85ReEkdJLGOsaIGLXCbjr0
 FojVwL8+9xNUC5FsqYldMwPuGOsK9+JAYxXScKjGXDVkeOltA4RKv9MsxxD66sosxevt
 RpE0X6L63UcrG0WaO/i7ks16MSDZvKj5ZH8QqYu1xlyDWXZjUdVoKzqiw1ZsgLElX2yv
 4Q2A==
X-Gm-Message-State: AOJu0Yz+vP3d3644zrZOFScmA2thf1F8X8FnNgr2CXXfEjXPuPYYYelC
 +lpYhDDHe+HTVI2YYajzeSKxkCrismZfsyzy9vR/RbSX50mv/u04KvzcBDGDe7t1PYMTNk/U/yR
 ltepD0kqx38c9AS3DCjPy/nmD2ZrsQ1IL1I3+D0CWSzsHXR7DaloeiBH7OuJX7RRRazvi8ucwIT
 QucsQWyA6LGZ9vDJSErCJ+4ymbmijpsD9Ivqt00Ko=
X-Gm-Gg: ASbGnctsLLgf6+NdYd4YEFP9j1V8xroL8GiDN3zyks7JPyFYKsxQgXJrm5woAbPh2ZW
 0SSPi1jcb/glsZnb45dqFLrlB0jfwjZpwbWpNp+DTirqn7sgOlWyNbF2jjvSFJFoyB4V6n1vHuu
 B6k+6X2JroP5Fl+QFqvoW+dDe063f1IjPvhOFgkoIFhCjprRoCRho0/cfRrVJqlYhAnXH3eoxlV
 Sa5FvPDHYXcQ0NKd/B7fbdsAknaT/qVjDj51xx1SfaAzbkNfnHmxKOKXdn0y0/F4Da/isJQOPTA
 xjtpwg==
X-Received: by 2002:a17:907:1b27:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-ab789ac0169mr1438222166b.14.1739182989010; 
 Mon, 10 Feb 2025 02:23:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8EDm970Ti+/x53SCyJTQQFHqYprLsbtmqNW2lJA/pPggmIi42D9VTRl9rx6GKYllKCZbmDg==
X-Received: by 2002:a17:907:1b27:b0:aa6:8cbc:8d15 with SMTP id
 a640c23a62f3a-ab789ac0169mr1438219166b.14.1739182988387; 
 Mon, 10 Feb 2025 02:23:08 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab79bf7ca1esm538707366b.30.2025.02.10.02.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/9] tests/tcg/x86_64/fma: Test some x86 fused-multiply-add
 cases
Date: Mon, 10 Feb 2025 11:22:51 +0100
Message-ID: <20250210102255.2555097-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Add a test case which tests some corner case behaviour of
fused-multiply-add on x86:
 * 0 * Inf + SNaN should raise Invalid
 * 0 * Inf + QNaN shouldh not raise Invalid
 * tininess should be detected after rounding

There is also one currently-disabled test case:
 * flush-to-zero should be done after rounding

This is disabled because QEMU's emulation currently does this
incorrectly (and so would fail the test).  The test case is kept in
but disabled, as the justification for why the test running harness
has support for testing both with and without FTZ set.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20250116112536.4117889-3-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/x86_64/fma.c           | 109 +++++++++++++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target |   1 +
 2 files changed, 110 insertions(+)
 create mode 100644 tests/tcg/x86_64/fma.c

diff --git a/tests/tcg/x86_64/fma.c b/tests/tcg/x86_64/fma.c
new file mode 100644
index 00000000000..09c622ebc00
--- /dev/null
+++ b/tests/tcg/x86_64/fma.c
@@ -0,0 +1,109 @@
+/*
+ * Test some fused multiply add corner cases.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <inttypes.h>
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+/*
+ * Perform one "n * m + a" operation using the vfmadd insn and return
+ * the result; on return *mxcsr_p is set to the bottom 6 bits of MXCSR
+ * (the Flag bits). If ftz is true then we set MXCSR.FTZ while doing
+ * the operation.
+ * We print the operation and its results to stdout.
+ */
+static uint64_t do_fmadd(uint64_t n, uint64_t m, uint64_t a,
+                         bool ftz, uint32_t *mxcsr_p)
+{
+    uint64_t r;
+    uint32_t mxcsr = 0;
+    uint32_t ftz_bit = ftz ? (1 << 15) : 0;
+    uint32_t saved_mxcsr = 0;
+
+    asm volatile("stmxcsr %[saved_mxcsr]\n"
+                 "stmxcsr %[mxcsr]\n"
+                 "andl $0xffff7fc0, %[mxcsr]\n"
+                 "orl %[ftz_bit], %[mxcsr]\n"
+                 "ldmxcsr %[mxcsr]\n"
+                 "movq %[a], %%xmm0\n"
+                 "movq %[m], %%xmm1\n"
+                 "movq %[n], %%xmm2\n"
+                 /* xmm0 = xmm0 + xmm2 * xmm1 */
+                 "vfmadd231sd %%xmm1, %%xmm2, %%xmm0\n"
+                 "movq %%xmm0, %[r]\n"
+                 "stmxcsr %[mxcsr]\n"
+                 "ldmxcsr %[saved_mxcsr]\n"
+                 : [r] "=r" (r), [mxcsr] "=m" (mxcsr),
+                   [saved_mxcsr] "=m" (saved_mxcsr)
+                 : [n] "r" (n), [m] "r" (m), [a] "r" (a),
+                   [ftz_bit] "r" (ftz_bit)
+                 : "xmm0", "xmm1", "xmm2");
+    *mxcsr_p = mxcsr & 0x3f;
+    printf("vfmadd132sd 0x%" PRIx64 " 0x%" PRIx64 " 0x%" PRIx64
+           " = 0x%" PRIx64 " MXCSR flags 0x%" PRIx32 "\n",
+           n, m, a, r, *mxcsr_p);
+    return r;
+}
+
+typedef struct testdata {
+    /* Input n, m, a */
+    uint64_t n;
+    uint64_t m;
+    uint64_t a;
+    bool ftz;
+    /* Expected result */
+    uint64_t expected_r;
+    /* Expected low 6 bits of MXCSR (the Flag bits) */
+    uint32_t expected_mxcsr;
+} testdata;
+
+static testdata tests[] = {
+    { 0, 0x7ff0000000000000, 0x7ff000000000aaaa, false, /* 0 * Inf + SNaN */
+      0x7ff800000000aaaa, 1 }, /* Should be QNaN and does raise Invalid */
+    { 0, 0x7ff0000000000000, 0x7ff800000000aaaa, false, /* 0 * Inf + QNaN */
+      0x7ff800000000aaaa, 0 }, /* Should be QNaN and does *not* raise Invalid */
+    /*
+     * These inputs give a result which is tiny before rounding but which
+     * becomes non-tiny after rounding. x86 is a "detect tininess after
+     * rounding" architecture, so it should give a non-denormal result and
+     * not set the Underflow flag (only the Precision flag for an inexact
+     * result).
+     */
+    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, false,
+      0x8010000000000000, 0x20 },
+    /*
+     * Flushing of denormal outputs to zero should also happen after
+     * rounding, so setting FTZ should not affect the result or the flags.
+     * QEMU currently does not emulate this correctly because we do the
+     * flush-to-zero check before rounding, so we incorrectly produce a
+     * zero result and set Underflow as well as Precision.
+     */
+#ifdef ENABLE_FAILING_TESTS
+    { 0x3fdfffffffffffff, 0x001fffffffffffff, 0x801fffffffffffff, true,
+      0x8010000000000000, 0x20 }, /* Enabling FTZ shouldn't change flags */
+#endif
+};
+
+int main(void)
+{
+    bool passed = true;
+    for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+        uint32_t mxcsr;
+        uint64_t r = do_fmadd(tests[i].n, tests[i].m, tests[i].a,
+                              tests[i].ftz, &mxcsr);
+        if (r != tests[i].expected_r) {
+            printf("expected result 0x%" PRIx64 "\n", tests[i].expected_r);
+            passed = false;
+        }
+        if (mxcsr != tests[i].expected_mxcsr) {
+            printf("expected MXCSR flags 0x%x\n", tests[i].expected_mxcsr);
+            passed = false;
+        }
+    }
+    return passed ? 0 : 1;
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index d6dff559c7d..be20fc64e88 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -18,6 +18,7 @@ X86_64_TESTS += adox
 X86_64_TESTS += test-1648
 X86_64_TESTS += test-2175
 X86_64_TESTS += cross-modifying-code
+X86_64_TESTS += fma
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
-- 
2.48.1


