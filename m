Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7CAC5DF88
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGV3-0006U4-Ae; Fri, 21 Aug 2026 00:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUc-00069a-Pi
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:36 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUZ-0003Gp-Et
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:34 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so402486a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285069; x=1787889869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oUcA47zI0T3mx+6NPIXLmuwEUg4/HjoJ4MZuVuTU53U=;
 b=BGgzDcHdCBfsSXDsAQRxcXUaTcdl4Szu7CCO9LyZlTw1QnOIZc4lsIUq0IMazl0m0X
 K/z/ERf5iCIfxVd2I1OiGXET/9MlX3rh0SRDxW3CqXO2xKFtrTGWRoU63+dpn5m2oCEg
 T0wBag+9qqQFDMgGLtcF0IWKyFN7TqGxV3QBU1BzlKGZQsBRBe01NRid2xthh1Q6+F4N
 Co9a+YS55aSW1cnxOZREOwORXm8JIs16Y0PqT6vWl1rx9gJtne7dai+HGk8M0ts4DH6n
 B5Lj8OfM9qJVJBIljinPU3Li3gb4dk2iVCk9Nasna9AOLFqqZ+ES5l0iVXDRCsLY0rGS
 q17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285069; x=1787889869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oUcA47zI0T3mx+6NPIXLmuwEUg4/HjoJ4MZuVuTU53U=;
 b=lgKxAUZR+MnBsWufRt7bo7Dej3gdxpM3thqH9ysEUGDrJmZMOwh6s6i9EejxNEBmcY
 fDQNNu4Pye2hO4RVnVqaEUT/sGCaR46tvhI3CPBNouuPy6e7k7lenDlv8S2YgKLedYxA
 ZQ6EPZvXwRADkSNFac9JUaE7RQqS0ApMjJ0NLy1kcggs4phFjDl4FpCfyjk5dPP64BE+
 qgpZhH6hXtVg63oThma1wXZl46L2RGGgZVjxudwJJqBYES0+sH04yorWdNwAVpWsNwon
 eyk8Saa+0Fnn+fn1RBzANyEl5xJBDSw/cXfxU8aV2lcrOT7i7cUab8iK32Dig2kPNmkw
 YNFQ==
X-Gm-Message-State: AFuF++nvEIZwEtcf4qJn9KridqJvDVjjsv26K0O1KX956b2jYgxB5dQv
 ZlVIHy84uapMJp9eSrYRQRiq86owv1mDuPc0Qgxqcq64WrgfsDIkJKcMyt+4Z4osn/nDkT1dchH
 EvrjJ
X-Gm-Gg: AR+sD12rGdFbUawPnVsZ7vBhleBWXEsYGPNoQCcE1R6Lm6Frd4f57ChTwzVDBT5a9Ve
 M1UpEGQX4zJj0CcKoj/H+WdO25H4211DHx8MlpYcWYWqdmlscYAFxJzcX0V5Z3SRWpmoXlf6eeg
 lyCfrBSBNcLZPKXcpFOSG+0B0pg3qrIZegMNQiHJFcmInJukLGkB5LD01c1ZkmvTGRYByZj6dDC
 e91LiqNGNrQpp/yt31JbIKmnvs3qATdBx9OZ0E+WXaSZlck5KnutufT4aHm+TQUO01EmHiD009G
 Zt4UJQ4qBRzGuIDXAqKbhWr8RImcb4jl2tJhm3Wvc8v+vx+PD9u7X2yFptMm7cAEpFNqvK92kPk
 gIDjpqAyFtSOkmQUzZog/4cXaBvMnAkqJeGzripiTuRXwpoIwVX+nyUEX8kxU9I28n2RYnQ3rqh
 xwucy1mfPrreOJYJHbMsrXzO16nUcjujBtTZDAst7EiLqGF5OOO4x6nky/Avk+ZfWX5/oE91/XE
 UM3Ow==
X-Received: by 2002:a17:90b:2d91:b0:38e:2e86:ed02 with SMTP id
 98e67ed59e1d1-395c39cd288mr6454633a91.14.1787285069386; 
 Thu, 20 Aug 2026 21:04:29 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 23/23] tests/tcg/riscv64: Add intrinsics version of
 test-rvv-ldst
Date: Thu, 20 Aug 2026 21:04:04 -0700
Message-ID: <20260821040404.268123-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

A C userspace program to perform vector loads and stores that cross page
boundaries, and check the result.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260820130223.2762-3-joel@jms.id.au>
---
 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c | 66 ++++++++++++++++++++
 tests/tcg/riscv64/Makefile.target            | 12 +++-
 2 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst-intrinsics.c

diff --git a/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
new file mode 100644
index 0000000000..3dbc862470
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst-intrinsics.c
@@ -0,0 +1,66 @@
+/*
+ * RISC-V vector load/store test, including accesses that cross a page
+ * boundary. Intrinsics version of test-rvv-ldst.S.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <riscv_vector.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+
+#define MAX_PAGE_SIZE 65536
+#define NUM_BYTES 16
+
+struct cross_page {
+    uint8_t pad[MAX_PAGE_SIZE - NUM_BYTES / 2];
+    uint8_t data[NUM_BYTES];
+};
+
+/* Page aligned so the within-page cases never cross a boundary */
+static const uint8_t src_data[NUM_BYTES]
+    __attribute__((aligned(MAX_PAGE_SIZE))) = {
+    0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
+    0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
+};
+
+static const struct cross_page src_cross
+    __attribute__((aligned(MAX_PAGE_SIZE))) = {
+    .data = {
+        0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
+        0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
+    },
+};
+
+static uint8_t dst_data[NUM_BYTES] __attribute__((aligned(MAX_PAGE_SIZE)));
+static struct cross_page dst_cross __attribute__((aligned(MAX_PAGE_SIZE)));
+
+static void vec_copy(uint8_t *dst, const uint8_t *src, int code)
+{
+    size_t vl = __riscv_vsetvl_e8m1(NUM_BYTES);
+    if (vl != NUM_BYTES) {
+        exit(code);
+    }
+
+    vuint8m1_t v = __riscv_vle8_v_u8m1(src, vl);
+    __riscv_vse8_v_u8m1(dst, v, vl);
+
+    if (memcmp(dst, src, NUM_BYTES)) {
+        exit(code);
+    }
+}
+
+int main(void)
+{
+    /* Case 1: load/store within a page */
+    vec_copy(dst_data, src_data, 1);
+
+    /* Case 2: the load straddles a page boundary */
+    vec_copy(dst_data, src_cross.data, 2);
+
+    /* Case 3: the store straddles a page boundary */
+    vec_copy(dst_cross.data, src_data, 3);
+
+    return 0;
+}
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 68a5ec5255..3c6cd4937c 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -14,10 +14,11 @@ TESTS += test-aes
 run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
 
 # Vector load test
-TESTS += test-rvv-ldst
-test-rvv-ldst: CFLAGS += -march=rv64gcv
+TESTS += test-rvv-ldst test-rvv-ldst-intrinsics
+test-rvv-ldst-intrinsics test-rvv-ldst: CFLAGS += -march=rv64gcv
 test-rvv-ldst: LDFLAGS = -nostdlib -static
-run-test-rvv-ldst: QEMU_OPTS += -cpu max
+test-rvv-ldst-intrinsics: LDFLAGS = -static
+run-test-rvv-ldst-intrinsics run-test-rvv-ldst: QEMU_OPTS += -cpu max
 
 # Re-run the vector tests at each supported VLEN
 TEST_RVV_VLENS = 128 256 512 1024
@@ -26,6 +27,11 @@ run-test-rvv-ldst-vlen%: test-rvv-ldst
 	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
 		test-rvv-ldst with vlen=$*)
 
+EXTRA_RUNS += $(patsubst %,run-test-rvv-ldst-intrinsics-vlen%,$(TEST_RVV_VLENS))
+run-test-rvv-ldst-intrinsics-vlen%: test-rvv-ldst-intrinsics
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
+		test-rvv-ldst-intrinsics with vlen=$*)
+
 # Test for fcvtmod
 TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
-- 
2.43.0


