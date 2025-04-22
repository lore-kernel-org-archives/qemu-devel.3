Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DFBC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIf-0002by-Dg; Tue, 22 Apr 2025 15:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIX-0002X6-FI
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006Co-8E
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so5299829a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350116; x=1745954916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eyx3jHfuOzS1kFXjXoFUhMf/lfjFavDcf4Lxs2+4npE=;
 b=byD2SDUgLR54PHfXv5rq3LUirY0FVaKs6UJmCDd2cJKs3pntShKCswUXBINbRzsvxU
 9fRC67KkKfYSh9AaeO9WYwUS4tI9v+MigDu3v7J2CjDakwOlBvQKYoGUghjQIyaYgkIj
 ajfGOlGWTNvg+MneMbBP/2D9FewFxXByjbrztKMHyqNcovRPT5hLMFQKpWuMl38YwQOA
 ev62cU/HBbPNsTpHzCr8LB98SASMq+LY7sdvmjkZlo05242SkE88YD0XtErj+iRuWegj
 VieRbw3R+wcY4exQWF6TixBC8R5+QEj7XPOjrz1yneBvVsKwiYG/uslKUUgiO/4vbfIU
 6Rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350116; x=1745954916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eyx3jHfuOzS1kFXjXoFUhMf/lfjFavDcf4Lxs2+4npE=;
 b=vpnIrzft3Ohu3Y+EoqoB7N6D34Q1rfg3BC4rG6B9LOMhZMZik7/TRjdxsGxPiHlZN1
 DWcnUqqVArcvLV6NOYd3NWrFaEVFoRwdhiv5yMP1TezIdjmLk4YNPOQw3CqBZxuJicrZ
 X5jpZdswCqZBUIxPtEEuqt3rQA6Nf1PC7dAsBqGtWmfOvIS/SYZ3Z0X4GqZFwa3TBxsp
 g/FnuBqkGFYJ9F72+tHV0ynEyv2xdKGEIJjLG92ilrcNLkj2+B+KPz5ighFrceEQO51a
 a3BwPV7G7pgz8+TbPN/sKNw49q32K8fKPi7MJpc8BJzuF6U8Z7jrCCi7gn7QIRaWXANK
 5OOw==
X-Gm-Message-State: AOJu0Ywoj4OCr0YzuFKKGIsBwf43AcyaTPylLRmlL1S2TUDBpt06D23r
 QF0yFZ7MlRPYa3Y0+nML7fDwz+11Q14umrBfo7mCRGxlsxyFU8Pas7pGGRJsHWeDUCUB+Qxyn0j
 k
X-Gm-Gg: ASbGnctOOkKvdb3UAjoRZW2DuN9Qjxj7/5cp+hSa+RIdtb4CoZ8lTSXmlVenw+RsRxK
 d4nMA06ziMHXZALWAn2ZvswZvJsUc5aAH4YUrPgQLbo9WM3T8MD96pOI4/tW8Uoa9KVg5Zf0pnG
 w8awr5AxLcb+5mA7Wa9AlbX+RwddoiF1PHE8BXXafUuI4mpIbMScMFj0KaAI1V+duB2MDU1iqOc
 pAvwfqeycxTO//rbBnReft0zo7cEciIAv2K63BphmokyCb6vnQlONLqGwMs0jcAGnaqdNCBeSSC
 IW93l6BoS1O4bNlaxt0Oh9lpnzxGbaBxduZ05mXUB0KurcmE6SPApbeFm8X7IN8vIY99UeknIrc
 =
X-Google-Smtp-Source: AGHT+IFdeApbYfgJ9rE+Q4uLUmOMTM0MnRVeGHgCg1MtEEiazxmFUOJnAqYAnAOCXNI9TaZZiQHSqw==
X-Received: by 2002:a17:90b:274a:b0:2ee:b875:6d30 with SMTP id
 98e67ed59e1d1-3087bb525cemr25959745a91.9.1745350115816; 
 Tue, 22 Apr 2025 12:28:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 023/147] include/exec: Split out cpu-ldst-common.h
Date: Tue, 22 Apr 2025 12:26:12 -0700
Message-ID: <20250422192819.302784-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


