Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65176CA1010
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 07:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuRGR-0006mf-3P; Fri, 05 Sep 2025 03:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGN-0006m0-Os; Fri, 05 Sep 2025 03:53:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uuRGK-0000F5-6g; Fri, 05 Sep 2025 03:53:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24457f581aeso18774865ad.0; 
 Fri, 05 Sep 2025 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757058813; x=1757663613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Z6SuNhFPrPhzfMBT/bngXY1a+8lOkAShgssGKYktwc=;
 b=k3Tjpuzyo4kDGYZ+RljETzQSf2dCMJHxVtM2733U8k5WkDYRbyYrxr/7hFTZ4LKPCf
 /NHnLCrs7DQY79ZELsm7+80T1+9K1uMXLd5zg1MZnibj/TE7peJqVoA0sKVnBDH7xypl
 JvF19jL1gv5pbOIc9bctUcA3cld8FUe6irkWCGpS8aeHRC3cRVGoKFjpXX/boxwXFmLk
 eYlB43IL7y2EmT20paRI4kk1GmyeSwwSPez95gGPmQXWtlpfM/uiMNhZWlWA4WcvlUDv
 h6TE99IV5BMa7KWtE+MIrDgV7e2CxZN+uihQlyxB91Szs3QpuVVw9qjKKb1DZlQjKXh4
 vtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757058813; x=1757663613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Z6SuNhFPrPhzfMBT/bngXY1a+8lOkAShgssGKYktwc=;
 b=oCjwpBoERc3XtBUOoaZ04qp3qQvDEzGz+zjTQLYtQfw9salLQNk4Z4VQ1pDF1DrgKC
 Oo8dlqKD+e5uZBvbN0Ult883s+CzkD3SeZcfJdmgolh8IH5lxtvD3PuGZt8F9k/T+BIy
 5mP4RdOiBO/f1/36GMXJRSYPK9abxJfZ6F5HIT14o9AbUcrBn2WUK/RWPvBKd7fan3mA
 YhA0N8Ti6yrP0/arzfiWKxxFR+zRPh29hSX77IzW49oJXoe/qI6j3ZyTgvn0b3KP+T1X
 Xls2sfH4rW8KLqjyt8RT7d2ZYUydKpkQ+hY0+hFhtlaBGziELaesX3sV5IlN4q5H2vmN
 +jjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCwSTsYIUfw/7OBxnjuq3VklAG2ET3LfIM29dCFkMpSNSw8kVOPzTv1Hp7BdoRAbtssGGadZ6yim+i@nongnu.org
X-Gm-Message-State: AOJu0YxuLDhUK0SqWx517yoiw/gB5ntR3cbRM1f/6OiLkzp7ar9nUiAn
 U8K87vzBdUjJ/nljmMf+HZKfAQbusp8+EU1Xm8upNpNqNVtT3S6WuEN7/Sf/3EpM
X-Gm-Gg: ASbGncv9qJ2eu8xNszu5AtyUcwyNBBozwVO2lRLX1j9dziBdgH+jumWycxRoM0qX0e9
 8gOryfRGheq7rOrCzU0MEXFJ3ht356/y9+rGR/e4LKkrRVKsEtg+539Osq/6GcsrxeBQBpspzeh
 /VSUdUyPb1Hmk4kEClBXMfnp6dX12vxRSwLjLvyfAOtQiEZW9RrjTBvNC+T1KXMgCPS2LN82jJ9
 aM0MkadmIGFp+iiFasqzjz8udJsVZ6P3k4ICPL9HAk2vwHlOBF1CR7LaqEV79VLGG5kSE+qUKTd
 IliAsP8EKG6gASV6hoYl+ET9Qn1z+fO2fstJ4RTUSQN3GxdxDVa9w5VJEHRdv4uMYCLiGksK2K8
 Om2gRj4RB+9bc1kV9JPtza6LZoqiclcPoQVzoQw==
X-Google-Smtp-Source: AGHT+IGIRqtrH6SRilkpaokCQKNMfNdm5X64FF6tQy5NCEo2eY8uevM3fhVRYlT1a/49j9Ue6CPghQ==
X-Received: by 2002:a17:903:4405:b0:24e:47ea:951e with SMTP id
 d9443c01a7336-24e47ea95dfmr6286985ad.19.1757058813485; 
 Fri, 05 Sep 2025 00:53:33 -0700 (PDT)
Received: from lima-default ([1.146.99.18]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a26ae02sm20967560b3a.21.2025.09.05.00.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 00:53:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH v2 2/3] target/risvc: Fix vector whole ldst vstart check
Date: Fri,  5 Sep 2025 17:49:57 +1000
Message-ID: <20250905074959.426911-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905074959.426911-1-npiggin@gmail.com>
References: <20250905074959.426911-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

The whole vector ldst instructions do not include a vstart check, so an
overflowed vstart can result in an underflowed memory address offset and
crash:

    accel/tcg/cputlb.c:1465:probe_access_flags:
      assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)

Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.

This was found with a verification test generator based on RiESCUE.

Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/vector_helper.c             |  2 +
 tests/tcg/riscv64/Makefile.target        | 10 ++++
 tests/tcg/riscv64/test-vstart-overflow.c | 75 ++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-vstart-overflow.c

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index fc85a34a84..e0e8735000 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -825,6 +825,8 @@ vext_ldst_whole(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
     uint32_t esz = 1 << log2_esz;
     int mmu_index = riscv_env_mmu_index(env, false);
 
+    VSTART_CHECK_EARLY_EXIT(env, evl);
+
     /* Calculate the page range of first page */
     addr = base + (env->vstart << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
index 4da5b9a3b3..daa0c6688f 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -1,6 +1,9 @@
 # -*- Mode: makefile -*-
 # RISC-V specific tweaks
 
+HAVE_RISCV_VECTOR_INTRINSICS := $(shell echo '#ifndef __riscv_v_intrinsic\n#error\n#endif' |  \
+                                  $(CC) -march=rv64gcv -E -x c - >/dev/null 2>&1 && echo y)
+
 VPATH += $(SRC_PATH)/tests/tcg/riscv64
 TESTS += test-div
 TESTS += noexec
@@ -18,3 +21,10 @@ TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
 run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
+
+ifeq ($(HAVE_RISCV_VECTOR_INTRINSICS),y)
+# Test for vstart >= vl
+TESTS += test-vstart-overflow
+test-vstart-overflow: CFLAGS += -march=rv64gcv
+run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
+endif
diff --git a/tests/tcg/riscv64/test-vstart-overflow.c b/tests/tcg/riscv64/test-vstart-overflow.c
new file mode 100644
index 0000000000..72999f2c8a
--- /dev/null
+++ b/tests/tcg/riscv64/test-vstart-overflow.c
@@ -0,0 +1,75 @@
+/*
+ * Test for VSTART set to overflow VL
+ *
+ * TCG vector instructions should call VSTART_CHECK_EARLY_EXIT() to check
+ * this case, otherwise memory addresses can underflow and misbehave or
+ * crash QEMU.
+ *
+ * TODO: Add stores and other instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdint.h>
+#include <riscv_vector.h>
+
+#define VSTART_OVERFLOW_TEST(insn)                \
+({                                                \
+    uint8_t vmem[64] = { 0 };                     \
+    uint64_t vstart;                              \
+    asm volatile("                           \r\n \
+    # Set VL=52 and VSTART=56                \r\n \
+    li          t0, 52                       \r\n \
+    vsetvli     x0, t0, e8, m4, ta, ma       \r\n \
+    li          t0, 56                       \r\n \
+    csrrw       x0, vstart, t0               \r\n \
+    li          t1, 64                       \r\n \
+    " insn "                                 \r\n \
+    csrr        %0, vstart                   \r\n \
+    " : "=r"(vstart), "+A"(vmem) :: "t0", "t1", "v24", "memory"); \
+    vstart;                                       \
+})
+
+int run_vstart_overflow_tests()
+{
+    /*
+     * An implementation is permitted to raise an illegal instruction
+     * exception when executing a vector instruction if vstart is set to a
+     * value that could not be produced by the execution of that instruction
+     * with the same vtype. If TCG is changed to do this, then this test
+     * could be updated to handle the SIGILL.
+     */
+    if (VSTART_OVERFLOW_TEST("vl1re16.v    v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vs1r.v       v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vle16.v      v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vse16.v      v24, %1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vluxei8.v    v24, %1, v20")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vlse16.v     v24, %1, t1")) {
+        return 1;
+    }
+
+    if (VSTART_OVERFLOW_TEST("vlseg2e8.v  v24, %1")) {
+        return 1;
+    }
+
+    return 0;
+}
+
+int main()
+{
+    return run_vstart_overflow_tests();
+}
-- 
2.51.0


