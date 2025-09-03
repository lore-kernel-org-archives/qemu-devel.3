Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ED0CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 03:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdlE-00009m-9R; Tue, 02 Sep 2025 23:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdks-0008MJ-6U; Tue, 02 Sep 2025 23:01:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1utdkq-0006xQ-FE; Tue, 02 Sep 2025 23:01:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-77251d7cca6so2524308b3a.3; 
 Tue, 02 Sep 2025 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756868506; x=1757473306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVsPU6o2dAkDdBPoKyfvLVYbO3tTi0w59PoBz8wKzeM=;
 b=JeID5fNW2BQyl9N2P4otjyWApRTZGvmcd2Zcmj63Cxf6DxaboHKQT1MixRTRAxtE+x
 Y1n76DQKIoSzVTL+EYaAoADjPPgQpcTnNYmESQkOAZp0lUlyyJrKnMXH9fp2aOiK+TpK
 snoEHy6nn7artCcitsn9Ette2+5c7DumCVE7LdHtKQ6xfMBidzcRwr4dSdaHWK4kzNiy
 Z5npaWWnRXoIBgxLpku3TBY6yLY8x+9HeL3uajRuqFGjY2lNVo8l8ZZPgvxEg+sQLAjs
 msQrrSMxbtzmGR5DvWnSPtjTGveayv2bDBIPPihzvdE2i0OLWk1Dye9g7MNvI8PIKAaI
 RPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756868506; x=1757473306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVsPU6o2dAkDdBPoKyfvLVYbO3tTi0w59PoBz8wKzeM=;
 b=P5vOjhmtE2koe1H74HT0YLBGTNsGX/on41loTkXR6fg/D6TD3bzHeuiIRMXwiaX+ZS
 j+6ko4cdxkhfo8Ak59uOL7Ma/j/P8BDCpldCEaJ66CuaRdTs23+boEj+4yWCmfW87qtx
 GXukf4oLdVRJzMHmtWvrQuwkREREv8KiBeaWMTUmvybTclQrFSQDTpMHzdvEUyIzJSZz
 rJuxuCUZiuQ7Pi9CCIMY1mXG52jJj5BCYkYcUbEdFFRKWaDvik5MOlhed8mQUAmN8MJU
 E8qCVU87bqMsJF0+zflECrfX9v3H9G9OOX6pgVd6GrhzVDRVLxegtbAxyg8SCdSBIqh+
 DMFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWcrWQUnqwesCIQWxfB/v67ryZo3E4Ogt9OyAk15LUfzWd4ERI9dWeW0VQ5e0VGOWlnh77oympSBAh@nongnu.org
X-Gm-Message-State: AOJu0YxlcbgkRMfn4F4vg4BO5iH1+jg/GBBGSBoDXSyFABCoPZhavijT
 X3M+cUHesuGDA6EY0kVumb3N1rrsCK1pJDla4+9PCcqWzHWcc/wDyidGHVtJew==
X-Gm-Gg: ASbGnctPs5An8h/e2kZKKBiS8rEOM9KhEpKlZHYfxeU4hlEfSPzAakk7WKaMKTTbF8i
 7pJpo9NI5nZneiN5sJbv7THC6LklJb2+67OczFiOdchNC+Xcy+ikHjN8e05iiikbXemDFZa8MNn
 gIu1inh4jDjkLZ14fYYG6bkjbgROqxTRSk4DPuX1JsiBbcdXgvRnn0UyGXP9tIxZhaYb6oFvQUQ
 FK4EJ6457BVwPH3TjWj2b4XJ3ifjP0Jos12uPf2MdHtIXpAPOBAhfLTT32WtyyxIf+pmm/sGLTs
 tj/s42pwobqwU5wIew15aNy75XwQs6bu04ERVikG3WxGTNMBxv9WbMbWl/iDpR0gCp68UN5GWx2
 Ot+ZWxNM/lRYeaLY3BmQzyL7TdFgSWpiZ21I7aI1vIgQP7wvTQnhIxy6e0l2FPA3Qc/993FwtaX
 k1imOP/XC7
X-Google-Smtp-Source: AGHT+IFmBrlJO5F1Xh9oDfkVtBD83qPDokXEPem7I+MNLnMK1BJ2xszmw4D3mBdEHMaAYaln6BTk4Q==
X-Received: by 2002:a05:6a20:3d8d:b0:246:9192:2779 with SMTP id
 adf61e73a8af0-24691922d8emr2089734637.7.1756868505619; 
 Tue, 02 Sep 2025 20:01:45 -0700 (PDT)
Received: from lima-default (123.253.189.97.qld.leaptel.network.
 [123.253.189.97]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7725e419913sm6971760b3a.55.2025.09.02.20.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 20:01:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, Nicholas Joaquin <njoaquin@tenstorrent.com>,
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Subject: [PATCH 2/3] target/risvc: Fix vector whole ldst vstart check
Date: Wed,  3 Sep 2025 13:01:12 +1000
Message-ID: <20250903030114.274535-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903030114.274535-1-npiggin@gmail.com>
References: <20250903030114.274535-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

The whole vector ldst instructions do not include a vstart check,
so an overflowed vstart can result in an underflowed memory address
offset and crash:

    accel/tcg/cputlb.c:1465:probe_access_flags:
      assertion failed: (-(addr | TARGET_PAGE_MASK) >= size)

Add the VSTART_CHECK_EARLY_EXIT() check for these helpers.

This was found with a verification test generator based on RiESCUE.

Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/vector_helper.c             |  2 +
 tests/tcg/riscv64/Makefile.target        |  5 ++
 tests/tcg/riscv64/test-vstart-overflow.c | 75 ++++++++++++++++++++++++
 3 files changed, 82 insertions(+)
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
index 4da5b9a3b3..19a49b6467 100644
--- a/tests/tcg/riscv64/Makefile.target
+++ b/tests/tcg/riscv64/Makefile.target
@@ -18,3 +18,8 @@ TESTS += test-fcvtmod
 test-fcvtmod: CFLAGS += -march=rv64imafdc
 test-fcvtmod: LDFLAGS += -static
 run-test-fcvtmod: QEMU_OPTS += -cpu rv64,d=true,zfa=true
+
+# Test for vstart >= vl
+TESTS += test-vstart-overflow
+test-vstart-overflow: CFLAGS += -march=rv64gcv
+run-test-vstart-overflow: QEMU_OPTS += -cpu rv64,v=on
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


