Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B004C282EC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW0-0004bN-7k; Wed, 12 Mar 2025 23:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0004YR-Hw
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:42 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVn-0007aJ-N2
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224171d6826so11331995ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837529; x=1742442329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1YMjkp2ohkieMSd8G7Gtaz9ulM7Flpbby2gUzDmBrk=;
 b=ZQnGyURQiu+Sjl/hmNY1qsdGeXpbc+Yz4KWBhekf2jRLtlfApiy/hGxABq3sFA4ksW
 Z1B7D0jOS/+lIkBfIgX0KVN8DlbCvADhtR2ZxOfJasqVXoT67OgDVYatLKIdaAJ9Ar3m
 rCORNWJtfOOxzb4DrCDI3Q5/iZU+vh4O6CsmrxIrYDxSPj8neQyAwyo8D/jbIt483hiM
 NNN9My+RzQHDXbEOzGZXR+NocrJHdfBKilCYOzmNhmu8XXkNyttPQcwqmC2B1klUWQx3
 ig9pm/N4aBV+GxoAMfOHb+iA6KZ97Vi1j13VOnV7gJoexaR0yTRelNkkMrCWkYP3RaZ+
 Eh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837529; x=1742442329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1YMjkp2ohkieMSd8G7Gtaz9ulM7Flpbby2gUzDmBrk=;
 b=TDw23QtlZmWNEmTpV+zAmPm2Q0vZUnQ67gsIr+OhN5Ha53AN9DUj+utEPmR8QMMhAV
 4C5gR2jntDu5pOh7GVot8dp6voFFdTb/FpTwWFtJhMxkIXUF/9PdCrLxMnGVnGInPNiX
 CjCJVdUO6w1UfIV0b5bTpwTzrCr2qddqOwtG+dES8GV/dlPe53SH/Sp20x9Wh8uKpLLY
 OhXgG4Z0/RW8A1H+epbDIM8i+zE0sjU0dYGSE5UcQfMtI+SBOv9VQHshLrz1GfGShLoc
 mQ80WvhG1oJGJ/TYyJN7G5nTb+XIJS1SX5q7iiG9Gb10fYEd+ObvJ9JCfuRyWTcUpNHK
 LsmA==
X-Gm-Message-State: AOJu0YxbdyBoSy4046Feg3YPoqP1oki7sEe5mN8Ib9clpwTkfmyHOP+9
 xs6Ur7lYkAqHhSXFMrXzIE7junOf8ptwSuBqCwz8FYiZ/OfUkusse9wWki46XIx0bO4GkGQE+Wx
 i
X-Gm-Gg: ASbGncvoYpu3QO65YMNQG68Zl2pZjyYkOhOb0ST8vQex3tVBJJuA4HBhaauIacaTms8
 clkB4gkuwLsrADB28VGoljx3RQBcMVfY74hU+Hf7RsvY7n40QtTeS8gzig4xO1DOSVNKV4TuZAq
 tsHmuPQfgea/N1tE2365JvjCuf+Cov5bbt51zgyDp8o9lq/QO2xR6V5NwI9LfH8VxFCmjKJ0xvd
 1a4WCiieqLqIiJkr1HnYp6InLf4iOqdzE+5zdP3FzZKRQ2hvSFhotawYed3Wm1ycu64uNRWDKp9
 0bfYbb9irT3vSkXF8ejl3krPv2dy7mu1qvAceDhbSNSHmaAUuLVJSi+yLuJOIzeCDu2kgchIQlc
 X
X-Google-Smtp-Source: AGHT+IGRJxH/B53M6lDZk0ohCvq5eegVltSs4rYePC28UYTyjnVoOTqMFeIRxQZjC3G1vFTSi5f9HQ==
X-Received: by 2002:a17:902:d48c:b0:220:bd61:a337 with SMTP id
 d9443c01a7336-2242889f1c7mr352984075ad.23.1741837529409; 
 Wed, 12 Mar 2025 20:45:29 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 04/37] include/exec: Split out cpu-ldst-common.h
Date: Wed, 12 Mar 2025 20:44:44 -0700
Message-ID: <20250313034524.3069690-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Split out the *_mmu api, which no longer uses
target specific argument types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-ldst-common.h | 122 +++++++++++++++++++++++++++++++++
 include/exec/cpu_ldst.h        | 108 +----------------------------
 2 files changed, 123 insertions(+), 107 deletions(-)
 create mode 100644 include/exec/cpu-ldst-common.h

diff --git a/include/exec/cpu-ldst-common.h b/include/exec/cpu-ldst-common.h
new file mode 100644
index 0000000000..c46a6ade5d
--- /dev/null
+++ b/include/exec/cpu-ldst-common.h
@@ -0,0 +1,122 @@
+/*
+ * Software MMU support
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef CPU_LDST_COMMON_H
+#define CPU_LDST_COMMON_H
+
+#ifndef CONFIG_TCG
+#error Can only include this header with TCG
+#endif
+
+#include "exec/memopidx.h"
+#include "exec/vaddr.h"
+#include "exec/mmu-access-type.h"
+#include "qemu/int128.h"
+
+uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
+Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
+
+void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
+                 MemOpIdx oi, uintptr_t ra);
+void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
+                  MemOpIdx oi, uintptr_t ra);
+
+uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
+                                 uint32_t cmpv, uint32_t newv,
+                                 MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
+                                    uint64_t cmpv, uint64_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint32_t cmpv, uint32_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
+                                    uint64_t cmpv, uint64_t newv,
+                                    MemOpIdx oi, uintptr_t retaddr);
+
+#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
+TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
+    (CPUArchState *env, vaddr addr, TYPE val,   \
+     MemOpIdx oi, uintptr_t retaddr);
+
+#ifdef CONFIG_ATOMIC64
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
+#else
+#define GEN_ATOMIC_HELPER_ALL(NAME)          \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
+    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
+#endif
+
+GEN_ATOMIC_HELPER_ALL(fetch_add)
+GEN_ATOMIC_HELPER_ALL(fetch_sub)
+GEN_ATOMIC_HELPER_ALL(fetch_and)
+GEN_ATOMIC_HELPER_ALL(fetch_or)
+GEN_ATOMIC_HELPER_ALL(fetch_xor)
+GEN_ATOMIC_HELPER_ALL(fetch_smin)
+GEN_ATOMIC_HELPER_ALL(fetch_umin)
+GEN_ATOMIC_HELPER_ALL(fetch_smax)
+GEN_ATOMIC_HELPER_ALL(fetch_umax)
+
+GEN_ATOMIC_HELPER_ALL(add_fetch)
+GEN_ATOMIC_HELPER_ALL(sub_fetch)
+GEN_ATOMIC_HELPER_ALL(and_fetch)
+GEN_ATOMIC_HELPER_ALL(or_fetch)
+GEN_ATOMIC_HELPER_ALL(xor_fetch)
+GEN_ATOMIC_HELPER_ALL(smin_fetch)
+GEN_ATOMIC_HELPER_ALL(umin_fetch)
+GEN_ATOMIC_HELPER_ALL(smax_fetch)
+GEN_ATOMIC_HELPER_ALL(umax_fetch)
+
+GEN_ATOMIC_HELPER_ALL(xchg)
+
+#undef GEN_ATOMIC_HELPER_ALL
+#undef GEN_ATOMIC_HELPER
+
+Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
+                                  Int128 cmpv, Int128 newv,
+                                  MemOpIdx oi, uintptr_t retaddr);
+Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
+                                  Int128 cmpv, Int128 newv,
+                                  MemOpIdx oi, uintptr_t retaddr);
+
+uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
+                         MemOpIdx oi, uintptr_t ra);
+uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
+                          MemOpIdx oi, uintptr_t ra);
+
+#endif /* CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index ddd8e0cf48..1fbdbe59ae 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -66,11 +66,8 @@
 #error Can only include this header with TCG
 #endif
 
-#include "exec/memopidx.h"
-#include "exec/vaddr.h"
+#include "exec/cpu-ldst-common.h"
 #include "exec/abi_ptr.h"
-#include "exec/mmu-access-type.h"
-#include "qemu/int128.h"
 
 #if defined(CONFIG_USER_ONLY)
 #include "user/guest-host.h"
@@ -157,100 +154,6 @@ void cpu_stl_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint32_t val,
 void cpu_stq_le_mmuidx_ra(CPUArchState *env, abi_ptr ptr, uint64_t val,
                           int mmu_idx, uintptr_t ra);
 
-uint8_t cpu_ldb_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_mmu(CPUArchState *env, vaddr ptr, MemOpIdx oi, uintptr_t ra);
-Int128 cpu_ld16_mmu(CPUArchState *env, vaddr addr, MemOpIdx oi, uintptr_t ra);
-
-void cpu_stb_mmu(CPUArchState *env, vaddr ptr, uint8_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stw_mmu(CPUArchState *env, vaddr ptr, uint16_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stl_mmu(CPUArchState *env, vaddr ptr, uint32_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_stq_mmu(CPUArchState *env, vaddr ptr, uint64_t val,
-                 MemOpIdx oi, uintptr_t ra);
-void cpu_st16_mmu(CPUArchState *env, vaddr addr, Int128 val,
-                  MemOpIdx oi, uintptr_t ra);
-
-uint32_t cpu_atomic_cmpxchgb_mmu(CPUArchState *env, vaddr addr,
-                                 uint32_t cmpv, uint32_t newv,
-                                 MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_le_mmu(CPUArchState *env, vaddr addr,
-                                    uint64_t cmpv, uint64_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgw_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint32_t cpu_atomic_cmpxchgl_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint32_t cmpv, uint32_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-uint64_t cpu_atomic_cmpxchgq_be_mmu(CPUArchState *env, vaddr addr,
-                                    uint64_t cmpv, uint64_t newv,
-                                    MemOpIdx oi, uintptr_t retaddr);
-
-#define GEN_ATOMIC_HELPER(NAME, TYPE, SUFFIX)   \
-TYPE cpu_atomic_ ## NAME ## SUFFIX ## _mmu      \
-    (CPUArchState *env, vaddr addr, TYPE val, \
-     MemOpIdx oi, uintptr_t retaddr);
-
-#ifdef CONFIG_ATOMIC64
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint64_t, q_be)
-#else
-#define GEN_ATOMIC_HELPER_ALL(NAME)          \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, b)     \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, w_be)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_le)  \
-    GEN_ATOMIC_HELPER(NAME, uint32_t, l_be)
-#endif
-
-GEN_ATOMIC_HELPER_ALL(fetch_add)
-GEN_ATOMIC_HELPER_ALL(fetch_sub)
-GEN_ATOMIC_HELPER_ALL(fetch_and)
-GEN_ATOMIC_HELPER_ALL(fetch_or)
-GEN_ATOMIC_HELPER_ALL(fetch_xor)
-GEN_ATOMIC_HELPER_ALL(fetch_smin)
-GEN_ATOMIC_HELPER_ALL(fetch_umin)
-GEN_ATOMIC_HELPER_ALL(fetch_smax)
-GEN_ATOMIC_HELPER_ALL(fetch_umax)
-
-GEN_ATOMIC_HELPER_ALL(add_fetch)
-GEN_ATOMIC_HELPER_ALL(sub_fetch)
-GEN_ATOMIC_HELPER_ALL(and_fetch)
-GEN_ATOMIC_HELPER_ALL(or_fetch)
-GEN_ATOMIC_HELPER_ALL(xor_fetch)
-GEN_ATOMIC_HELPER_ALL(smin_fetch)
-GEN_ATOMIC_HELPER_ALL(umin_fetch)
-GEN_ATOMIC_HELPER_ALL(smax_fetch)
-GEN_ATOMIC_HELPER_ALL(umax_fetch)
-
-GEN_ATOMIC_HELPER_ALL(xchg)
-
-#undef GEN_ATOMIC_HELPER_ALL
-#undef GEN_ATOMIC_HELPER
-
-Int128 cpu_atomic_cmpxchgo_le_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
-Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
-                                  Int128 cmpv, Int128 newv,
-                                  MemOpIdx oi, uintptr_t retaddr);
-
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -297,15 +200,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, vaddr addr,
 # define cpu_stq_mmuidx_ra    cpu_stq_le_mmuidx_ra
 #endif
 
-uint8_t cpu_ldb_code_mmu(CPUArchState *env, vaddr addr,
-                         MemOpIdx oi, uintptr_t ra);
-uint16_t cpu_ldw_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
-                          MemOpIdx oi, uintptr_t ra);
-
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_lduw_code(CPUArchState *env, abi_ptr addr);
 uint32_t cpu_ldl_code(CPUArchState *env, abi_ptr addr);
-- 
2.43.0


