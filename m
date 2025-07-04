Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D104C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhY9-0001I0-Fd; Fri, 04 Jul 2025 10:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPg-0003ko-Va
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:21 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPa-000269-V7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:16 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea35edc691so368626fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639349; x=1752244149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/B4lDUEqafN5g8eYZX+ybcJ0Y62/HOxTSdDxW3/oSE=;
 b=rVgjSpND1sNMQ1ZA+btdNe7Piq70LkZR6tzbAtUtOF369FY97ls5Xw50Rt5qoVRaDm
 jvfJcoXWLL+Fk9a94Y+hlSiH7zXf/JAKGGHz1NlxaY1oj6TLUEBm+2dsiEEOh1F4An+e
 /xb97Ou76VR2l6Vz+qMz4Og7XtXvVLEJFMDBofDXzLFIKjpvq6N7WtB27N93iwA/V1sP
 K2FfoJi4LIwff/vOYNaerO2ynoFLLHPKElK9VKc3OFsWssvgeViiHalx2thzf7xlcR7Z
 TbMtuF7+seqOT50lHTIYXk1Lddcb0cY64Y7Oyex413mja9pha2w5LidHAEsB1MgHyq3h
 54AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639349; x=1752244149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7/B4lDUEqafN5g8eYZX+ybcJ0Y62/HOxTSdDxW3/oSE=;
 b=lQEjy0gVRrF+UlCXD+GiLwEukaFZ5VMAID3shQ6GUceq3+zL4GP2ztxqgTjhw3w5cr
 FBQ9Gp+f3sW3CjetNonZ9uMKM/21b5dqtCTQpbRsOWp3KvEgYM3G0bFBkhQk6ISY9l/M
 3kj/6BPJRFLrs5QVpG5e4SnOrnIaks2eL+siHohJ0A3JPLXthpTiDQsStx7J7Dxl9MWT
 S9r7u+1zS0YI4lCfDBNRYjusNdNCmHc00tLwAqreMgcOGYUKAItVO5HmcAdMcs5fpKgN
 DTx8143lJ5rDb7Rxcnnxctk3zBhza7wtGV7+UjRN4vfuJy/rXMvwPQXmUDleDhmmI0Hg
 3KlA==
X-Gm-Message-State: AOJu0YzddbuOlczxFZow7InKLgwFe8a9ck3dqp/nEoG/4HlAuM+jV9K2
 9Z0Dwlmt19Y5nfWdFE12GZx86VcvzY/SNZCucooA6jcSCy1yvzSfJ/6hXLxf2MDrokhrjmVpWON
 k3Bu1ocI=
X-Gm-Gg: ASbGnctQZ31879F1bUco9c76JpWqobg5qBv10tuvrVbN+SRPpkHE200sp0QuY1i/rNJ
 EL/I+aveqG8gSLUtJkaQCX0rgB3FZd38FcMT9Ote9MUZAwMEiItmvw/pyiIyR0AIO7RKJmNZ6xl
 440cUXXbrj6Yi8YmgUITpVkKazw2JjdG95+jFbDybRfQEZuw1zGJg0AjbXU1CxG3570l+25u9MV
 uoy3HM+XJWqET7l2FwnCpK9JM5CPwGgP/n8+zTrIMYpIVhlI8tVMWULlK/9vJNkEl/luxiUkdW2
 ZlVg/MDvu8Iy5P+GiMZmRhnWwLzez//IZCo9zL3Inl2gJ7dJQSCyNR7B4jWRupUXi5KIDHflEmG
 YE2ThvaQgEAWL+2iTPGbbB4z7oL+Kd7fkBVcs8Ui9LQ/dpb5muDlzO41nSFM=
X-Google-Smtp-Source: AGHT+IGpivhomdLRnRbZkBuxyTLM18vQS9bG2aal1wICvshAUbnZYtRjsE3Vs8mGcUEtsrYUMt6OFg==
X-Received: by 2002:a05:6870:bac9:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2f796a56ea8mr1618317fac.1.1751639348765; 
 Fri, 04 Jul 2025 07:29:08 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:29:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 108/108] tests/tcg/aarch64: Add sme2-matmul test case
Date: Fri,  4 Jul 2025 08:21:11 -0600
Message-ID: <20250704142112.1018902-109-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Extract from
  https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/
Merge into two files and drop the EL3 setup code for FVP.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/sme2-matmul-0.c | 236 ++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  11 +-
 tests/tcg/aarch64/sme2-matmul-1.S | 321 ++++++++++++++++++++++++++++++
 3 files changed, 567 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/sme2-matmul-0.c
 create mode 100644 tests/tcg/aarch64/sme2-matmul-1.S

diff --git a/tests/tcg/aarch64/sme2-matmul-0.c b/tests/tcg/aarch64/sme2-matmul-0.c
new file mode 100644
index 0000000000..35737c5694
--- /dev/null
+++ b/tests/tcg/aarch64/sme2-matmul-0.c
@@ -0,0 +1,236 @@
+/*
+ * SPDX-FileCopyrightText: Copyright 2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * Copied from
+ * https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/
+ *
+ * and modified for testing with qemu-aarch64.
+ */
+
+#include <stdint.h>
+#include <string.h>
+#include <inttypes.h>
+#include <math.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#define DEBUG 0
+
+/*
+ * Vanilla matrix multiplication using the by-the-book definition.
+ */
+
+void preprocess_l(uint64_t nbr, uint64_t nbc, uint64_t SVL,
+                  const float *restrict a, float *restrict a_mod)
+{
+    // For all tiles of SVL x SVL data
+    for (uint64_t By = 0; By < nbr; By += SVL) {
+        for (uint64_t Bx = 0; Bx < nbc; Bx += SVL) {
+            // For this tile
+            const uint64_t dest = By * nbc + Bx * SVL;
+            for (uint64_t j = 0; j < SVL; j++) {
+                for (uint64_t i = 0; i < SVL && (Bx + i) < nbc; i++) {
+                    if (By + j < nbr) {
+                        a_mod[dest + i * SVL + j] = a[(By + j) * nbc + Bx + i];
+                    } else {
+                        // These elements are outside of matrix a, so zero them.
+                        a_mod[dest + i * SVL + j] = 0.0;
+                    }
+                }
+            }
+        }
+    }
+}
+
+void matmul(uint64_t M, uint64_t K, uint64_t N,
+            const float *restrict matLeft, const float *restrict matRight,
+            float *restrict matResult)
+{
+    for (uint64_t m = 0; m < M; m++) {
+        for (uint64_t n = 0; n < N; n++) {
+            float acc = 0.0;
+
+            for (uint64_t k = 0; k < K; k++) {
+                acc += matLeft[m * K + k] * matRight[k * N + n];
+            }
+
+            matResult[m * N + n] = acc;
+        }
+    }
+}
+
+/*
+ * SME2 Matrix multiplication handwritten in assembly code. This is split in 2
+ * functions that have to be invoked one after the other, with a top level
+ * binding.
+ */
+
+/* Matrix preprocessing, in assembly. */
+void preprocess_l_asm(uint64_t M, uint64_t K, const float *restrict a,
+                      float *restrict a_mod);
+
+/* Matrix multiplication (with the *transposed* RHS), in assembly. */
+void matmul_asm_impl(uint64_t M, uint64_t K, uint64_t N,
+                     const float *restrict matLeft_mod,
+                     const float *restrict matRight, float *restrict matResult);
+
+/* The top level matrix multiplication. */
+void matmul_asm(uint64_t M, uint64_t K, uint64_t N,
+                const float *restrict matLeft, const float *restrict matRight,
+                float *restrict matLeft_mod, float *restrict matResult)
+{
+    __asm volatile("" : : :
+                   "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+                   "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+                   "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+                   "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
+
+    preprocess_l_asm(M, K, matLeft, matLeft_mod);
+    matmul_asm_impl(M, K, N, matLeft_mod, matRight, matResult);
+
+    __asm volatile("" : : :
+                   "v0", "v1", "v2", "v3", "v4", "v5", "v6", "v7",
+                   "v8", "v9", "v10", "v11", "v12", "v13", "v14", "v15",
+                   "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
+                   "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31");
+}
+
+
+// Initialize an array of float.
+enum InitKind { RANDOM_INIT, LINEAR_INIT, DEAD_INIT };
+void initialize_matrix(float *mat, size_t num_elements, enum InitKind kind)
+{
+    for (size_t i = 0; i < num_elements; i++)
+        switch (kind) {
+        case RANDOM_INIT:
+            mat[i] = (((float)(rand() % 10000) / 100.0f) - 30.0);
+            break;
+        case LINEAR_INIT:
+            mat[i] = i+1;
+            break;
+        case DEAD_INIT:
+            mat[i] = nan("");
+            break;
+        }
+}
+
+/* Pretty print a matrix. */
+void print_matrix(size_t nbr, size_t nbc, const float *mat, const char *name)
+{
+    printf("%s(%lu,%lu) = [", name, nbr, nbc);
+    for (size_t y = 0; y < nbr; y++) {
+        printf("\n  ");
+        for (size_t x = 0; x < nbc; x++)
+            printf("%9.2f, ", mat[y * nbc + x]);
+    }
+    printf("\n];\n");
+}
+
+/* Compare 2 matrices for equality. */
+unsigned compare_matrices(size_t nbr, size_t nbc, const float *reference,
+                          const float *result, const char *str)
+{
+    unsigned error = 0;
+
+    for (size_t y = 0; y < nbr; y++) {
+        for (size_t x = 0; x < nbc; x++) {
+            if (fabsf(reference[y * nbc + x] - result[y * nbc + x]) >
+                fabsf(0.0002f * reference[y * nbc + x])) {
+                error = 1;
+                if (DEBUG) {
+                    printf("%lu (%lu,%lu): %f <> %f\n", y * nbc + x, x, y,
+                           reference[y * nbc + x], result[y * nbc + x]);
+                }
+            }
+        }
+    }
+    if (DEBUG) {
+        if (error) {
+            print_matrix(nbr, nbc, reference, "reference");
+            print_matrix(nbr, nbc, result, "result");
+        }
+        printf("%s: %s !\n", str, error ? "FAILED" : "PASS");
+    }
+
+    return error;
+}
+
+uint64_t ool_svcntsw(void);
+
+/*
+ * Assumptions:
+ * nbr in matLeft (M): any
+ * nbc in matLeft, nbr in matRight (K): any K > 2
+ * nbc in matRight (N): any
+ */
+
+int main(int argc, char **argv)
+{
+    /* Size parameters */
+    uint64_t M, N, K;
+    if (argc >= 4) {
+        M = strtoul(argv[1], NULL, 0);
+        K = strtoul(argv[2], NULL, 0);
+        N = strtoul(argv[3], NULL, 0);
+    } else {
+        /* Default: 125x35x70 */
+        M = 125;
+        K = 35;
+        N = 70;
+    }
+
+    if (DEBUG) {
+        printf("\nSME2 Matrix Multiply fp32 *asm* example "
+               "with args %lu %lu %lu\n", M, K, N);
+    }
+
+    const uint64_t SVL = ool_svcntsw();
+
+    /* Calculate M of transformed matLeft.  */
+    const uint64_t M_mod = SVL * (M / SVL + (M % SVL != 0 ? 1 : 0));
+
+    float *matRight = (float *)malloc(K * N * sizeof(float));
+
+    float *matLeft = (float *)malloc(M * K * sizeof(float));
+    float *matLeft_mod = (float *)malloc(M_mod * K * sizeof(float));
+    float *matLeft_mod_ref = (float *)malloc(M_mod * K * sizeof(float));
+
+    float *matResult = (float *)malloc(M * N * sizeof(float));
+    float *matResult_ref = (float *)malloc(M * N * sizeof(float));
+
+    //  initialize_matrix(matLeft, M * K, RANDOM_INIT);
+    //  initialize_matrix(matRight, K * N, RANDOM_INIT);
+    initialize_matrix(matLeft, M * K, LINEAR_INIT);
+    initialize_matrix(matRight, K * N, LINEAR_INIT);
+    initialize_matrix(matLeft_mod, M_mod * K, DEAD_INIT);
+    initialize_matrix(matResult, M * N, DEAD_INIT);
+
+    if (DEBUG) {
+        print_matrix(M, K, matLeft, "matLeft");
+        print_matrix(K, N, matRight, "matRight");
+    }
+
+    matmul_asm(M, K, N, matLeft, matRight, matLeft_mod, matResult);
+
+    /* Compute the reference values with the vanilla implementations. */
+    matmul(M, K, N, matLeft, matRight, matResult_ref);
+    preprocess_l(M, K, SVL, matLeft, matLeft_mod_ref);
+
+    unsigned error = compare_matrices(K, M_mod, matLeft_mod_ref, matLeft_mod,
+                                      "Matrix preprocessing");
+    if (!error)
+        error = compare_matrices(M, N, matResult_ref, matResult,
+                                 "Matrix multiplication");
+
+    free(matRight);
+
+    free(matLeft);
+    free(matLeft_mod);
+    free(matLeft_mod_ref);
+
+    free(matResult);
+    free(matResult_ref);
+
+    return error ? EXIT_FAILURE : EXIT_SUCCESS;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 16ddcf4f88..641c00cf02 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -28,7 +28,8 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme2 $$fnia, CROSS_AS_HAS_ARMV9_SME2)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -75,6 +76,14 @@ AARCH64_TESTS += $(SME_TESTS)
 $(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
 endif
 
+# SME2 Tests
+ifneq ($(CROSS_AS_HAS_ARMV9_SME2),)
+sme2-matmul: CFLAGS += $(CROSS_AS_HAS_ARMV9_SME2)
+sme2-matmul: sme2-matmul-0.c sme2-matmul-1.S
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $^ -o $@ $(LDFLAGS)
+AARCH64_TESTS += sme2-matmul
+endif
+
 # System Registers Tests
 AARCH64_TESTS += sysregs
 
diff --git a/tests/tcg/aarch64/sme2-matmul-1.S b/tests/tcg/aarch64/sme2-matmul-1.S
new file mode 100644
index 0000000000..5562e24c62
--- /dev/null
+++ b/tests/tcg/aarch64/sme2-matmul-1.S
@@ -0,0 +1,321 @@
+/*
+ * SPDX-FileCopyrightText: Copyright 2024 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * Copied from
+ * https://learn.arm.com/learning-paths/cross-platform/multiplying-matrices-with-sme2/
+ *
+ * and modified for testing with qemu-aarch64.
+ */
+
+    .text
+    .cfi_sections .debug_frame  // put stack frame info into .debug_frame instead of .eh_frame
+
+    .global ool_svcntsw
+    .type ool_svcntsw, "function"
+    .cfi_startproc
+ool_svcntsw:
+    rdsvl  x0, #1
+    lsr    x0, x0, #1
+    ret
+    .cfi_endproc
+    .size   ool_svcntsw, .-ool_svcntsw
+
+    .global preprocess_l_asm
+    .type preprocess_l_asm, "function"
+    .cfi_startproc
+
+preprocess_l_asm:
+    // preprocess_l_asm(uint64_t nbr, uint64_t nbc, const float * restrict a, float * a_mod);
+    // x0 : nbr
+    // x1 : nbc
+    // x2 : &a
+    // x3 : &a_mod
+    // x4 : SVLs (=cntw)
+    // x5 : Exit condition for inner loop
+    // x6 : a_ptr
+    // x7 : Outer loop counter
+    // x8 : a_base
+    // x9 : a_mod store base address
+    // x10: 32b Tile0 store end pointer
+    // x11: SVLs*nbc
+    // x12: Load/Store loop counter
+    // x13: 32b Tile1 store end pointer
+    // x14: 2*nbc
+    // x15: 3*nbc
+    // x16: 32b tile size
+
+// Assumptions:
+// nbr in matLeft (M): any
+// nbc in matLeft, nbr in matRight (K): any K > 2
+// nbc in matRight (N): any
+//
+// Left matrix re-arrangement:
+// Block of SVLs rows is transposed and contiguously stored.
+// Then the same transformation is applied to remaining blocks of SVLs rows.
+// The last block of rows is zero-padded to SVLs rows, if applicable.
+
+    smstart
+
+// constants
+    cntw    x4                      // SVLs
+    mul     x11, x4, x1             // SVLs*nbc
+    lsl     x14, x1, #1             // 2*nbc
+    add     x15, x14, x1            // 3*nbc
+
+    mul     x16, x4, x4             // SVLs*SVLs
+
+    mov     x7, #0
+    whilelt p0.s, x7, x0            // Tile predicate (M dimension)
+
+.Loop_outer:
+    mov     x8, x2                  // a load base address
+    mov     x9, x3                  // a_mod store base address
+    add     x5,  x2, x1, lsl #2     // Exit condition for inner loop
+
+    add     x10, x9 , x11, lsl #2   // 32b Tile0 store predicate condition
+    sub     x13, x10, x16, lsl #2   // 32b Tile1 store predicate condition
+    whilelt pn8.b, x8, x5, vlx2     // Tile predicate-as-counter (K dimension)
+
+.Loop_inner:
+    mov     x6, x8                  // a_ptr
+
+    mov     w12, #0                 // Load_loop counter
+
+.Load_loop:
+    psel    pn10, pn8, p0.s[w12, 0]
+    psel    pn11, pn8, p0.s[w12, 1]
+    psel    pn12, pn8, p0.s[w12, 2]
+    psel    pn13, pn8, p0.s[w12, 3]
+    ld1w    {z20.s, z28.s}, pn10/z, [x6]                // Load 2 row vectors from a_ptr
+    ld1w    {z21.s, z29.s}, pn11/z, [x6, x1,  lsl #2]   // Load " "   "       from a_ptr + nbc
+    ld1w    {z22.s, z30.s}, pn12/z, [x6, x14, lsl #2]   // Load " "   "       from a_ptr + nbc*2
+    ld1w    {z23.s, z31.s}, pn13/z, [x6, x15, lsl #2]   // Load " "   "       from a_ptr + nbc*3
+    mova    za0h.s[w12, 0:3], {z20.s-z23.s}
+    mova    za1h.s[w12, 0:3], {z28.s-z31.s}
+
+    add     x6, x6, x1, lsl #4      // a_ptr+=4*nbc FP32 elms [Bytes]
+    add     w12, w12, #4            // increment counter
+    cmp     w12, w4
+    b.mi    .Load_loop
+
+    mov     w12, #0                 // Store_loop counter
+
+.Store_loop:
+    whilelt pn10.b, x9, x10, vlx4
+    whilelt pn11.b, x9, x13, vlx4
+    mova    {z0.s-z3.s}, za0v.s[w12, 0:3]
+    mova    {z4.s-z7.s}, za1v.s[w12, 0:3]
+    st1w    {z0.s-z3.s}, pn10, [x9]               // Store 4 col vectors to a_mod
+    st1w    {z4.s-z7.s}, pn11, [x9, x16, lsl #2]  // Store 4 col vectors to a_mod + SVLs*SVLs
+    addvl   x9, x9, #4              // a_mod += 4*SVLb [Bytes]
+    add     w12, w12, #4            // increment counter
+    cmp     w12, w4
+    b.mi    .Store_loop
+
+    add     x9, x9, x16, lsl #2
+    addvl   x8, x8, #2              // a_base += 2*SVLb [Bytes]
+    whilelt pn8.b, x8, x5, vlx2
+    b.first .Loop_inner
+
+    add     x3, x3, x11, lsl #2     // &a_mod += SVLs*nbc FP32 elms [Bytes]
+    add     x2, x2, x11, lsl #2     // &a += SVLs*nbc FP32 elms [Bytes]
+    incw    x7
+
+    whilelt p0.s, x7, x0
+    b.first .Loop_outer
+
+    smstop
+
+    ret
+    .cfi_endproc
+    .size   preprocess_l_asm, .-preprocess_l_asm
+
+    .global matmul_asm_impl
+    .type matmul_asm_impl, "function"
+    .cfi_startproc
+
+matmul_asm_impl:
+    // matmul_asm_impl(M, K, N, matLeft, matRight, matResult_opt);
+    // x0 : M
+    // x1 : K, lda
+    // x2 : N, ldc, ldb
+    // x3 : &matLeft
+    // x4 : &matRight
+    // x5 : &matResult_opt
+    // x6 : SVLs-2
+    // x7 : a_ptr pointer
+    // x8 : a_ptr end address
+    // x9 : c_base pointer
+    // x10: c_ptr0 pointer
+    // x11: Exit condition for N loop
+    // x12: M loop counter
+    // x13: Store loop counter
+    // x14: Predicate select index
+    // x15: Exit condition for K loop
+    // x16: b_base pointer
+    // x17: b_ptr pointer
+    // x18: (SVLs+1)*ldc
+    // x19: ldb + SVLs
+    // x20: SVLs*lda + SVLs
+    // x21: c_ptr1 pointer
+    // x22: SVLs*lda
+    // x23: SVLs*ldc
+
+// Assumptions:
+// nbr in matLeft (M): any
+// nbc in matLeft, nbr in matRight (K): any K > 2
+// nbc in matRight (N): any
+//
+// Left matrix is pre-arranged.
+//
+// 32-bit accumulator mapping with 2x2 tiles processing
+
+    stp     x19, x20, [sp, #-48]!
+    stp     x21, x22, [sp, #16]
+    stp     x23, x24, [sp, #32]
+
+    smstart
+
+// constants
+    cntw    x6                      // SVLs
+    mul     x22, x6, x1             // SVLs*lda
+    mul     x23, x6, x2             // SVLs*ldc
+    add     x18, x23, x2            // SVLs*ldc + ldc
+    add     x11, x4, x2, lsl #2     // Exit condition for N loop
+    mov     x12, #0
+    cntb    x6                      // SVLb
+    mov     x14, #0
+    ptrue   pn10.b                  // Predicate as counter for SME2 VLx2 (a_ptr loads)
+    whilelt pn8.s, x12, x0, vlx2    // tiles predicate (M dimension)
+    sub     w6, w6, #8              // SVLb-8
+
+.Loop_M:
+    // Extracting tile 0/1 and tile 2/3 predicates (M dimension) from vlx2 predicate.
+    pext    { p2.s, p3.s }, pn8[0]
+    mov     x16, x4                 // b_base
+    mov     x9, x5                  // c_base
+
+    whilelt pn9.b, x16, x11, vlx2   // tiles predicate (N dimension)
+
+.Loop_N:
+    mov     x7, x3                  // a_ptr = a_base
+    mov     x17, x16                // b_ptr = b_base
+    mov     x10, x9                 // c_ptr0 = c_base
+
+    // Extracting tile 0/2 and tile 1/3 predicates (N dimension) from vlx2 predicate.
+    pext    { p0.b, p1.b }, pn9[0]
+
+    add     x8, x3, x22, lsl #2     // a_base + SVLs*lda FP32 elms [Bytes]
+    addvl   x15, x8, #-1            // Exit condition for K loop
+    ld1w    {z1.s},  p2/z,   [x7]   // Load 1st vector from a_ptr
+
+    zero    {za}
+    ld1w    {z2.s-z3.s},  pn9/z,   [x17]  // Load 2 vectors from b_ptr
+
+    fmopa   za0.s,  p2/m,   p0/m,   z1.s,   z2.s  // ZA0 += 1st a_ptr vector OP 1st b_ptr vector
+    ld1w    {z5.s},  p3/z,   [x7, x22, lsl #2]    // Load 2nd vector from a_ptr
+    addvl   x7, x7, #1                            // a_ptr += SVLb [Bytes]
+
+.Loop_K:
+    fmopa   za2.s,  p3/m,   p0/m,   z5.s,   z2.s       // ZA2 += 2nd a_ptr vector OP 1st b_ptr vector
+
+    fmopa   za1.s,  p2/m,   p1/m,   z1.s,   z3.s       // ZA1 += 1st a_ptr vector OP 2nd b_ptr vector
+    ld1w    {z0.s-z1.s},  pn10/z,   [x7]               // Load next 2 vectors from a_ptr
+
+    fmopa   za3.s,  p3/m,   p1/m,   z5.s,   z3.s       // ZA3 += 2nd a_ptr vector OP 2nd b_ptr vector
+    ld1w    {z6.s-z7.s},  pn9/z,   [x17, x2, lsl #2]   // Load next 2 vectors from b_ptr
+
+    fmopa   za0.s,  p2/m,   p0/m,   z0.s,   z6.s       // ZA0 += 1st a_ptr vector OP 1st b_ptr vector
+    psel    pn11, pn10, p3.s[w14, 0]                   // Select predicate-as-counter
+    ld1w    {z4.s-z5.s},  pn11/z,   [x7, x22, lsl #2]  // Load next 2 vectors from a_ptr
+
+    fmopa   za2.s,  p3/m,   p0/m,   z4.s,   z6.s       // ZA2 += 2nd a_ptr vector OP 1st b_ptr vector
+    add     x17, x17, x2, lsl #3                       // b_ptr += 2*ldb FP32 elms [Bytes]
+
+    fmopa   za1.s,  p2/m,   p1/m,   z0.s,   z7.s       // ZA1 += 1st a_ptr vector OP 2nd b_ptr vector
+
+    fmopa   za3.s,  p3/m,   p1/m,   z4.s,   z7.s       // ZA3 += 2nd a_ptr vector OP 2nd b_ptr vector
+    ld1w    {z2.s-z3.s},  pn9/z,   [x17]               // Load next 2 vectors from b_ptr
+
+    fmopa   za0.s,  p2/m,   p0/m,   z1.s,   z2.s       // ZA0 += 1st a_ptr vector OP 1st b_ptr vector
+    addvl   x7, x7, #2                                 // a_ptr += 2*SVLb [Bytes]
+
+    cmp     x7, x15
+    b.mi    .Loop_K
+
+    fmopa   za2.s,  p3/m,   p0/m,   z5.s,   z2.s       // ZA2 += 2nd a_ptr vector OP 1st b_ptr vector
+
+    fmopa   za1.s,  p2/m,   p1/m,   z1.s,   z3.s       // ZA1 += 1st a_ptr vector OP 2nd b_ptr vector
+
+    fmopa   za3.s,  p3/m,   p1/m,   z5.s,   z3.s       // ZA3 += 2nd a_ptr vector OP 2nd b_ptr vector
+    add     x17, x17, x2, lsl #2                       // b_ptr += 2*ldb FP32 elms [Bytes]
+
+    cmp     x7, x8
+    b.pl    .Ktail_end
+
+.Ktail_start:
+    ld1w    {z1.s},  p2/z,   [x7]
+    ld1w    {z2.s-z3.s},  pn9/z,   [x17]
+
+    fmopa   za0.s,  p2/m,   p0/m,   z1.s,   z2.s
+    ld1w    {z5.s},  p3/z,   [x7, x22, lsl #2]
+
+    fmopa   za2.s,  p3/m,   p0/m,   z5.s,   z2.s
+
+    fmopa   za1.s,  p2/m,   p1/m,   z1.s,   z3.s
+
+    fmopa   za3.s,  p3/m,   p1/m,   z5.s,   z3.s
+
+.Ktail_end:
+    mov     w13, #0
+    psel    pn11, pn9, p2.b[w13, 0]
+    psel    pn12, pn9, p3.b[w13, 0]
+    // Move from ZA tiles to vectors: z0 = za0h[1], z1 = za1h[1], z2 = za2h[1], z3 = za3h[1]
+    mova    { z0.b-z3.b }, za0h.b[w13, 0:3]
+    st1w    { z0.s-z1.s }, pn11, [x10]                  // Store to c_ptr0
+    st1w    { z2.s-z3.s }, pn12, [x10, x23, lsl #2]     // Store to c_ptr0 + SVLs*ldc
+.Loop_store_ZA:
+    psel    pn11, pn9, p2.b[w13, 4]
+    psel    pn12, pn9, p3.b[w13, 4]
+    mova    { z0.b-z3.b }, za0h.b[w13, 4:7]
+    st1w    { z0.s-z1.s }, pn11, [x10, x2,  lsl #2]      // Store to c_ptr0 + ldc
+    st1w    { z2.s-z3.s }, pn12, [x10, x18,  lsl #2]     // Store to c_ptr0 + (SVLs+1)*ldc
+
+    add     x10, x10, x2, lsl #3    // c_ptr0 += 2*ldc FP32 elms [Bytes]
+    add     w13, w13, #8
+
+    psel    pn11, pn9, p2.b[w13, 0]
+    psel    pn12, pn9, p3.b[w13, 0]
+    mova    { z0.b-z3.b }, za0h.b[w13, 0:3]
+    st1w    { z0.s-z1.s }, pn11, [x10]                  // Store to c_ptr0
+    st1w    { z2.s-z3.s }, pn12, [x10, x23, lsl #2]     // Store to c_ptr0 + SVLs*ldc
+    cmp     w13, w6
+    b.mi    .Loop_store_ZA
+
+    psel    pn11, pn9, p2.b[w13, 4]
+    psel    pn12, pn9, p3.b[w13, 4]
+    mova    { z0.b-z3.b }, za0h.b[w13, 4:7]
+    st1w    { z0.s-z1.s }, pn11, [x10, x2,  lsl #2]      // Store to c_ptr0 + ldc
+    st1w    { z2.s-z3.s }, pn12, [x10, x18,  lsl #2]     // Store to c_ptr0 + (SVLs+1)*ldc
+
+    addvl   x9, x9, #2
+    addvl   x16, x16, #2            // b_base += 2*SVLb [Bytes]
+    whilelt pn9.b, x16, x11, vlx2   // tile predicate (N dimension)
+    b.first .Loop_N
+
+    add     x3, x3, x22, lsl #3     // a_base += 2*SVLs*lda FP32 elms [Bytes]
+    add     x5, x5, x23, lsl #3     // c_base += 2*SVLs*ldc FP32 elms [Bytes]
+    incw    x12, all, mul #2        // M loop counter += 2* SVLs
+    whilelt pn8.s, x12, x0, vlx2    // tiles predicate (M dimension)
+    b.first    .Loop_M
+
+    smstop
+
+    ldp     x23, x24, [sp, #32]
+    ldp     x21, x22, [sp, #16]
+    ldp     x19, x20, [sp], #48
+
+    ret
+    .cfi_endproc
+    .size   matmul_asm_impl, .-matmul_asm_impl
-- 
2.43.0


