Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4511BC4453A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 18:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmbsv-0004Pt-0Y; Wed, 22 Jul 2026 14:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsj-0004Mm-2B
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmbsg-0006N0-LU
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 14:41:24 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so2811812a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784745681; x=1785350481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hoczlY2y26Dl/5Nu2k5E9x3RU2NVrWsSXJQ8sVstzR8=;
 b=OOEizBbljfg3OmxjGGoYwsEydHasOsJp+ehrRvqTqTn9+ddde7SnRNH0swLW30mSux
 edkw0IteEg+m2FoYz96wuniLEiYJ34MIyZLhM6TVDtE4HAUFfiTQRME1vIyh8KyhvONw
 SqAlLKblZ6J0v05z5nE+DhVti+SQnZRCmaTGARhVvjXd73dxLrQWmw9M73yeIP82FYXv
 GkqpdVflikIiOp9rXSxBv4pqN6ckjlRDDr3I9LzgohpwsOL6lecWQ+RiQ01rdm6MDInD
 wi/Z/4gQWw1n5W0ucPk0LNubQ8oTSmrjeq6xJFF+nn/pUW4uzggkpxZchQrZBPurTH/m
 qtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745681; x=1785350481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hoczlY2y26Dl/5Nu2k5E9x3RU2NVrWsSXJQ8sVstzR8=;
 b=nxi5z+IUCbhBClJDyE9foz2hXMlY1zGxvNRYT66673DHGL19b96/RN/wmpSY4qFb0a
 4pxHyWNYXnVVvwhGYmikGakLJ5UaROhNqGu1QHtCSY9eAQ9jUe6krUpnNRSrm6nHx4vg
 1xg9QmEYZOlt0iT77O7nGjaKTm++DWpT9f2dJJ3JUZ5GHgVV5UKZybxyrYJHg9yeOcZ1
 nRQ/iQn7i5et795wopEUUlFIBeuIDSKlczwNRGNPHQvyB3CpE0DOlhlGupsrVjAgYj9j
 1p8uw2r2png30y7xY5R3y++er3Js0KikEIIkepYofwEFYa7TrBHliv113q0dtMBnJV06
 tPKQ==
X-Gm-Message-State: AOJu0YxAsAdm4VjPuJ+kd5x26xfXSq4hbVy/u2IkYEGeQUgikQU/57pI
 cf+CRH6CltRzLpW5zCUZRMvo5w0DJ4Nk6a3zKhQbbp5ncCjy60Hxr6RptRf7kLMIqyyKePr84C4
 rtiJS
X-Gm-Gg: AR+sD10n+zmL09vZ+IQOq9Irkmc8KZ2SZdZjhw0YLCFuV1cJw5/KYb8uht27OGIN3gd
 FDJMDYAMs1ZO5m/g6anIvUOgEy2pJNylnAi5VRWUA7aOWJVCvahML/kJsZQkyikb5lsfEqI47lQ
 WBavkUIyvDOOB3Fi+2QhLr/OpexEbJi9QCTC3KB99/fTVEVyAr+9geEj6lYThAFqbh7aZWblwK3
 ZNfPl6Bf1biUbfblYJ3lKkGmbaeaIU+J7s9JUW2RMkI8aTVpY14q78jdCx0ru+vGORdt+rVrJy4
 NaS9M4HG/+WvJpvi5YgQhBsyo6nJoZ/t+ZLDWXMzC5rWaUe+iQYMBzLkfNb3r3/XrqH/+grBw3j
 ABg4HlKX7CtLR+BVJ+5eC9ANNc5CX8p5yQLYRkMqh5BdN14NjCqbzXDByKDVGvjb8CLK64AJ947
 QFBnPiqx5NpbL4qhm3qIALLhtOh861i9W/xq9TOhhy8CBxGW9VWp4PBgNHrF40ZA==
X-Received: by 2002:a17:90b:5405:b0:38e:9045:bac0 with SMTP id
 98e67ed59e1d1-38e9045bb77mr9335260a91.5.1784745680451; 
 Wed, 22 Jul 2026 11:41:20 -0700 (PDT)
Received: from stoup.. (162-198-231-97.lightspeed.wlfrct.sbcglobal.net.
 [162.198.231.97]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13015052sm8559298c88.5.2026.07.22.11.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 1/3] accel/tcg: Add infrastructure for atomic 64-byte
 load/store
Date: Wed, 22 Jul 2026 11:41:15 -0700
Message-ID: <20260722184117.11937-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722184117.11937-1-richard.henderson@linaro.org>
References: <20260722184117.11937-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst-common.h           |  6 ++++
 include/qemu/atomic512.h                      | 12 +++++++
 include/qemu/value64.h                        | 14 ++++++++
 accel/tcg/cputlb.c                            | 30 +++++++++++++++++
 accel/tcg/user-exec.c                         | 33 +++++++++++++++++++
 accel/tcg/ldst_common.c.inc                   | 31 +++++++++++++++++
 .../include/generic/host/atomic512-ldst.h.inc | 16 +++++++++
 7 files changed, 142 insertions(+)
 create mode 100644 include/qemu/atomic512.h
 create mode 100644 include/qemu/value64.h
 create mode 100644 host/include/generic/host/atomic512-ldst.h.inc

diff --git a/include/accel/tcg/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
index f12be8cfb7..d8fae3384e 100644
--- a/include/accel/tcg/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -15,6 +15,7 @@
 #include "exec/vaddr.h"
 #include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
+#include "qemu/value64.h"
 
 uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
 uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
@@ -117,4 +118,9 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
+Value64 cpu_atomic_ld64_mmu(CPUArchState *env, vaddr ptr,
+                            MemOpIdx oi, uintptr_t ra);
+void cpu_atomic_st64_mmu(CPUArchState *env, vaddr ptr, const Value64 *val,
+                         MemOpIdx oi, uintptr_t ra);
+
 #endif /* ACCEL_TCG_CPU_LDST_COMMON_H */
diff --git a/include/qemu/atomic512.h b/include/qemu/atomic512.h
new file mode 100644
index 0000000000..8553a0feba
--- /dev/null
+++ b/include/qemu/atomic512.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 512-bit atomic operations.
+ */
+
+#ifndef QEMU_ATOMIC512_H
+#define QEMU_ATOMIC512_H
+
+#include "qemu/value64.h"
+#include "host/atomic512-ldst.h.inc"
+
+#endif /* QEMU_ATOMIC512_H */
diff --git a/include/qemu/value64.h b/include/qemu/value64.h
new file mode 100644
index 0000000000..7de287a13d
--- /dev/null
+++ b/include/qemu/value64.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_VALUE64_H
+#define QEMU_VALUE64_H
+
+/*
+ * An stream of 64 bytes; no endianness implied.
+ * The members are perforce host byte ordering.
+ */
+typedef union {
+    uint64_t l[8];
+} Value64;
+
+#endif /* QEMU_VALUE64_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7f7c208ba1..1f192f1837 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -42,6 +42,7 @@
 #include "exec/tlb-flags.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
+#include "qemu/atomic512.h"
 #include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
@@ -2429,6 +2430,20 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     return ret;
 }
 
+static Value64 do_atomic_ld64_mmu(CPUState *cpu, vaddr addr,
+                                  MemOpIdx oi, uintptr_t ra)
+{
+    MMULookupLocals l;
+
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
+    mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
+
+    if (likely(HAVE_ATOMIC512_LD && !(l.page[0].flags & TLB_MMIO))) {
+        return atomic64_read(l.page[0].haddr);
+    }
+    cpu_loop_exit_atomic(cpu, ra);
+}
+
 /*
  * Store Helpers
  */
@@ -2825,6 +2840,21 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     }
 }
 
+static void do_atomic_st64_mmu(CPUState *cpu, vaddr addr, const Value64 *val,
+                               MemOpIdx oi, uintptr_t ra)
+{
+    MMULookupLocals l;
+
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
+    mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
+
+    if (likely(HAVE_ATOMIC512_ST && !(l.page[0].flags & TLB_MMIO))) {
+        atomic64_set(l.page[0].haddr, val);
+    } else {
+        cpu_loop_exit_atomic(cpu, ra);
+    }
+}
+
 #include "ldst_common.c.inc"
 
 /*
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index a35aca7889..d6d2eec2e1 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -35,6 +35,7 @@
 #include "exec/page-protection.h"
 #include "exec/helper-proto-common.h"
 #include "qemu/atomic128.h"
+#include "qemu/atomic512.h"
 #include "qemu/bswap.h"
 #include "qemu/int128.h"
 #include "trace.h"
@@ -1116,6 +1117,22 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     return ret;
 }
 
+static Value64 do_atomic_ld64_mmu(CPUState *cpu, vaddr addr,
+                                  MemOpIdx oi, uintptr_t ra)
+{
+    void *haddr;
+
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
+    haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, MMU_DATA_LOAD);
+
+    if (HAVE_ATOMIC512_LD) {
+        Value64 ret = atomic64_read(haddr);
+        clear_helper_retaddr();
+        return ret;
+    }
+    cpu_loop_exit_atomic(cpu, ra);
+}
+
 static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
                        MemOpIdx oi, uintptr_t ra)
 {
@@ -1191,6 +1208,22 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     clear_helper_retaddr();
 }
 
+static void do_atomic_st64_mmu(CPUState *cpu, vaddr addr, const Value64 *val,
+                               MemOpIdx oi, uintptr_t ra)
+{
+    void *haddr;
+
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
+    haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, MMU_DATA_LOAD);
+
+    if (HAVE_ATOMIC512_ST) {
+        atomic64_set(haddr, val);
+        clear_helper_retaddr();
+    } else {
+        cpu_loop_exit_atomic(cpu, ra);
+    }
+}
+
 uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
                          MemOpIdx oi, uintptr_t ra)
 {
diff --git a/accel/tcg/ldst_common.c.inc b/accel/tcg/ldst_common.c.inc
index 57f3e06192..3ce560a1f2 100644
--- a/accel/tcg/ldst_common.c.inc
+++ b/accel/tcg/ldst_common.c.inc
@@ -189,6 +189,23 @@ Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr,
     return ret;
 }
 
+Value64 cpu_atomic_ld64_mmu(CPUArchState *env, vaddr addr,
+                            MemOpIdx oi, uintptr_t ra)
+{
+    MemOp mop = get_memop(oi);
+
+    tcg_debug_assert((mop & MO_SIZE) == MO_512);
+    tcg_debug_assert(memop_alignment_bits(mop) == MO_512);
+    tcg_debug_assert((mop & MO_BSWAP) == 0);
+
+    {
+        Value64 ret = do_atomic_ld64_mmu(env_cpu(env), addr, oi, ra);
+        /* TODO: 48 other bytes unreported to plugins. */
+        plugin_load_cb(env, addr, ret.l[0], ret.l[1], oi);
+        return ret;
+    }
+}
+
 /*
  * Store helpers for cpu_ldst.h
  */
@@ -243,3 +260,17 @@ void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
     do_st16_mmu(env_cpu(env), addr, val, oi, retaddr);
     plugin_store_cb(env, addr, int128_getlo(val), int128_gethi(val), oi);
 }
+
+void cpu_atomic_st64_mmu(CPUArchState *env, vaddr addr, const Value64 *val,
+                         MemOpIdx oi, uintptr_t retaddr)
+{
+    MemOp mop = get_memop(oi);
+
+    tcg_debug_assert((mop & MO_SIZE) == MO_512);
+    tcg_debug_assert(memop_alignment_bits(mop) == MO_512);
+    tcg_debug_assert((mop & MO_BSWAP) == 0);
+
+    do_atomic_st64_mmu(env_cpu(env), addr, val, oi, retaddr);
+    /* TODO: 48 other bytes unreported to plugins. */
+    plugin_store_cb(env, addr, val->l[0], val->l[1], oi);
+}
diff --git a/host/include/generic/host/atomic512-ldst.h.inc b/host/include/generic/host/atomic512-ldst.h.inc
new file mode 100644
index 0000000000..8b79fcd13d
--- /dev/null
+++ b/host/include/generic/host/atomic512-ldst.h.inc
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Load/store for 512-bit atomic operations, generic version.
+ */
+
+#ifndef HOST_ATOMIC512_LDST_H
+#define HOST_ATOMIC512_LDST_H
+
+#define HAVE_ATOMIC512_LD 0
+#define HAVE_ATOMIC512_ST 0
+
+/* Fallback definitions that must be optimized away, or error.  */
+Value64 QEMU_ERROR("unsupported atomic") atomic64_read(const void *s);
+void QEMU_ERROR("unsupported atomic") atomic64_set(void *d, const Value64 *v);
+
+#endif /* HOST_ATOMIC512_LDST_H */
-- 
2.43.0


