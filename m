Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33451C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 04:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxGV1-0006TK-OM; Fri, 21 Aug 2026 00:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUc-00069Z-Ne
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:36 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxGUZ-0003Gb-Dh
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 00:04:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so434424a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 21:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787285069; x=1787889869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hB/TBe/tgCga7z7P0ES69Q94cYLYvjn4re5w156s5Ek=;
 b=ek1B8wZkF3/Y+Kg5jhSy/WN+bC9LpzaTveQ5ffiz0wYnyPixl1lzHt+e0yr+YGIVcQ
 NrWCv8133UgCpT3B9HYWD2lxPrPbLdO/vFIrPDuBnGZ+/3bU5KSiN4k1I2/LTB1a1OKU
 pHU8O5/sUx+962bcpMUG2x5UJEBd4fAssmnrVG4rq3Jj2/l1UGj604XCFWEUNlAFzRg5
 WvNfYC0RkgMjTZoYTi2Cm8Hw+XM3qW85HLmBHqGmvtwsGgWHfwancviNaIEAeXQ+xSMl
 jCgPFLEa6G7w9yaOK5HSkcRbYDdHSunpMQo2D7dTs7+/E/sDtyKUAOUEnQN4pQNPXfZn
 5qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787285069; x=1787889869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hB/TBe/tgCga7z7P0ES69Q94cYLYvjn4re5w156s5Ek=;
 b=UScjtX3SlxzcU72qQEBGufeQXfJ579im20mwVgfszSrquV8M49Oi8/5Vd4RyUcR4YO
 44rKPjD2TxcEe6/MPcCoI2wkgC64YwsYW1zHtVN+OFCVIrlkDPcr/dyDZNjunaskQKr6
 C9ChGzhtG8Dyc/f6lnFNx6PIpYfs7uIcDcbgY9aZHUJVqIjHceS9onVi7ZgBUQfoRPZp
 HSY1u+/jSf4hzzYn/+egz6eFa3XohCgm50rJ2d2BQ+Iv8Kb0axdT9VcE8KJ2tgx3MWv9
 CqPqS1prCGLcY4BS7LW/SY9SE+KJ/jEFKn7G92cRob8DNq1jdHrG6QyMkQZQqvS3SS5N
 ARRg==
X-Gm-Message-State: AFuF++lD3sF/KABbJLuTBcC6tF+VKtbYk/7mYijMaxEQ+ScD42c78n1i
 TEp8IW1VtUXOUHkiVq8gfJBsYCZD3t9yWlA/7QCjaUEShRi7d1YquVLyxlXUNYxkWxKr/8fCLN2
 GEPC6
X-Gm-Gg: AR+sD12x3z6UxnmjuKaPHVQvptaK+2teAK04yfKOCtmUIB0SAl7nuJproVmVMEGTQ1h
 ejP+SAe/rDPBd7d+B1ckyjeIDyQyFQKBhTjAjAbPX+ZD8xQKUStirq55pksgkg62eOgx3XYKJxv
 ZZQbAjfuIq3GHsvxC/VLF/jMpOGwV/MXKYPHDBkqk3jm2Y2tTVoZcs7Fl/ffp4BNbOfzOx9O7fc
 fFUGKL1p5NNzX04CPc9dV/srPsfoGN+OnyflQa1SSmbzuDBKubf6D67hRcPb2QHqIuaog3RvGQq
 xeZARQAy1Kkuq/J/k2/dPZ8gq698pJlPqEdKBud7vRM0v1z3pMUHZWEF0oX1un54LRXjmqCP7RA
 StRKNlMZ3HzQtehp3udax6NrS7aIHUGhOK+p+MrB+Ng75WCvazCCpz60hE0jXHFJ71Jk0lqlp7N
 nNPISp6WVzB4NEixTYWBAO/Ud1CRdrG9wO2L/nOxtcL9K9dko+MxcLvLtBn8DpJJpAX6o=
X-Received: by 2002:a17:90a:e7c3:b0:38f:efed:5448 with SMTP id
 98e67ed59e1d1-395c371d53amr5567107a91.8.1787285068548; 
 Thu, 20 Aug 2026 21:04:28 -0700 (PDT)
Received: from stoup.. ([108.174.179.84]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4c194d2sm1298383a91.15.2026.08.20.21.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 21:04:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
	Joel Stanley <joel@jms.id.au>
Subject: [PATCH v2 22/23] tests/tcg/riscv64: Vector load test
Date: Thu, 20 Aug 2026 21:04:03 -0700
Message-ID: <20260821040404.268123-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821040404.268123-1-richard.henderson@linaro.org>
References: <20260821040404.268123-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

A userspace program to perform vector loads and stores that cross page
boundaries, and check the result.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260820130223.2762-2-joel@jms.id.au>
---
 tests/tcg/riscv64/Makefile.target |  13 +++
 tests/tcg/riscv64/test-rvv-ldst.S | 131 ++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rvv-ldst.S

diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..68a5ec5255 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -13,6 +13,19 @@ run-test-noc: QEMU_OPTS += -cpu rv64,c=false
 TESTS += test-aes
 run-test-aes: QEMU_OPTS += -cpu rv64,zk=on
 
+# Vector load test
+TESTS += test-rvv-ldst
+test-rvv-ldst: CFLAGS += -march=rv64gcv
+test-rvv-ldst: LDFLAGS = -nostdlib -static
+run-test-rvv-ldst: QEMU_OPTS += -cpu max
+
+# Re-run the vector tests at each supported VLEN
+TEST_RVV_VLENS = 128 256 512 1024
+EXTRA_RUNS += $(patsubst %,run-test-rvv-ldst-vlen%,$(TEST_RVV_VLENS))
+run-test-rvv-ldst-vlen%: test-rvv-ldst
+	$(call run-test, $@, env QEMU=$(QEMU) $(QEMU) $(QEMU_OPTS) -cpu max$(COMMA)vlen=$* $<, \
+		test-rvv-ldst with vlen=$*)
+
 # Test for fcvtmod
 TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
diff --git a/tests/tcg/riscv64/test-rvv-ldst.S b/tests/tcg/riscv64/test-rvv-ldst.S
new file mode 100644
index 0000000000..939b3f038b
--- /dev/null
+++ b/tests/tcg/riscv64/test-rvv-ldst.S
@@ -0,0 +1,131 @@
+/*
+ * RISC-V vector load/store page crossing test
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+    .section .rodata
+    // Page aligned so the within-page cases never cross a boundary
+    .set MAX_PAGE_SIZE, 65536
+    .balign MAX_PAGE_SIZE
+src_data:
+    .byte 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17
+    .byte 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F
+    .set NUM_BYTES, . - src_data
+
+    .balign MAX_PAGE_SIZE
+pageA_start:
+    // Fill the page, stopping 8 bytes short of the boundary
+    .fill MAX_PAGE_SIZE - 8, 1, 0xfa
+src_cross_data:
+    .byte 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27
+pageB_start:
+    .byte 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F
+    .set NUM_CROSS_BYTES, . - src_cross_data
+
+    .section .bss
+    .balign MAX_PAGE_SIZE
+dst_data:
+    .space 16
+
+    .balign MAX_PAGE_SIZE
+    .space (MAX_PAGE_SIZE - 8)
+dst_cross_data:
+    .space 16
+
+.option norelax
+.option norvc
+
+    .text
+    .globl _start
+_start:
+    // Case 1: Load/store within a page. t3 is the exit code on failure
+    li      t3, 1
+    la      a0, src_data
+    li      a1, NUM_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+
+    // Check the load will cover 16 bytes
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+    // Case 2: Load straddles a page boundary
+    li      t3, 2
+    la      a0, src_cross_data
+    li      a1, NUM_CROSS_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+    // Case 3: Store straddles a page boundary
+    li      t3, 3
+    la      a0, src_data
+    li      a1, NUM_BYTES
+
+    // SEW=8, LMUL=1
+    vsetvli t0, a1, e8, m1, ta, ma
+    bne     t0, a1, fail
+
+    // perform load
+    vle8.v  v1, (a0)
+
+    // Store vector content in memory
+    la      a2, dst_cross_data
+    vse8.v  v1, (a2)
+
+    // Compare first half
+    ld      t1, 0(a0)
+    ld      t2, 0(a2)
+    bne     t1, t2, fail
+
+    // Compare second half
+    ld      t1, 8(a0)
+    ld      t2, 8(a2)
+    bne     t1, t2, fail
+
+pass:
+    li      a0, 0
+    j       exit
+
+fail:
+    mv      a0, t3
+
+exit:
+    li      a7, 93        // sys_exit
+    ecall
-- 
2.43.0


