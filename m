Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSJ-0007dS-12; Thu, 18 Apr 2024 15:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPD-0008EO-Hj
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:55 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXPA-0007Wo-14
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:26:46 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56e48d0a632so1824106a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468402; x=1714073202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb1njxsoj9fqYLqI6LbCARFpOVdltqpYC3ClFHXZbjY=;
 b=SJS0cwg9zXXPVFCnpbkYs2cKU0yYG9UVSqhn2+Hh4aGmIjTsOnQF6DSlN7+AXnHgy2
 GCPIYLsZrJRj8Kaw6VoU9pmm+fWNZ2k5FpA5x7Gk/0zTbbUQXTo6TFNZ1Dsfn0zu/chK
 PB7mHawBoCPYgHgI70cj3wzqd3miOGv07CSU5y7X3QeiX9eGPj9Cunk2PNj+YVfm7eq8
 wuGKIh+uFZJMsh5I9QqpX7ncpWV3VpOvLwG+6qGJthe81qgcKcg3cqBh72lf5gY/aS4y
 NT+XGZkxsLXVhX6ZswB2EpkIAjZKTulposrNzshoi9OlpZWS2g7mgucAkznygdvasDII
 I7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468402; x=1714073202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cb1njxsoj9fqYLqI6LbCARFpOVdltqpYC3ClFHXZbjY=;
 b=CxDT3zKRNQpvfqOSCMQnzZPWWtI6flNVcGdYP82Bl0MOYB4hiJ8D78E/mbEZOLb0Sf
 Rmodk8f00wos27dtCa7EPTZcPrUogUJ3ymXCJWpepkfYXDMcya0eAxCWBDRvAABrY1x7
 wEdRXG4G9928ckVXaHZz8wkAt3v0nNBp3VC1z94iIJdJxCNL9b5dvht98y3odZwa5oML
 GrszzfP7N8fyWXH5IfZbA68m0s3CamyMTKxCaQNXL0FEgOqP5cX5hQgyvbVkgODuBXnv
 xUBUP2F6zHZfIwZJMNv3OzGO2TExBhFxckFz2wTJTuQmhoFe+kgr1UuLAm1kD8YWtuf6
 tF9Q==
X-Gm-Message-State: AOJu0Yzg+ftcvKRB1QhH6z62DhdRUCVWR9OTv3URZTSMyHmJLvy6Iw/4
 pAvPHn6HOPooxUwdknT6savCbKeBxLzpM6xRvu4U7+btocGtHonwn7hNLOyiFsyVS7KNgAkWo6k
 X
X-Google-Smtp-Source: AGHT+IE+0wbmWgIFnPU7i6VoBuSEKx6idnpuhGmJGfEUKBYV1liUnXM/8gEwZP44oUl1tDGVCvsLvw==
X-Received: by 2002:a50:d7db:0:b0:56e:d9e:f4d3 with SMTP id
 m27-20020a50d7db000000b0056e0d9ef4d3mr95268edj.18.1713468402179; 
 Thu, 18 Apr 2024 12:26:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a50f683000000b0056e59d747b0sm1276471edn.40.2024.04.18.12.26.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:26:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 12/24] exec: Move CPUTLBEntry helpers to cputlb.c
Date: Thu, 18 Apr 2024 21:25:11 +0200
Message-ID: <20240418192525.97451-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

The following CPUTLBEntry helpers are only used in accel/tcg/cputlb.c:
  - tlb_index()
  - tlb_entry()
  - tlb_read_idx()
  - tlb_addr_write()

Move them to this file, allowing to remove the huge "cpu.h" header
inclusion from "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 55 -----------------------------------------
 accel/tcg/cputlb.c      | 51 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 7032949dba..2c5a0a5c81 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -70,7 +70,6 @@
 #include "exec/abi_ptr.h"
 #include "exec/mmu-access-type.h"
 #include "qemu/int128.h"
-#include "cpu.h"
 
 #if defined(CONFIG_USER_ONLY)
 
@@ -294,60 +293,6 @@ Int128 cpu_atomic_cmpxchgo_be_mmu(CPUArchState *env, abi_ptr addr,
                                   Int128 cmpv, Int128 newv,
                                   MemOpIdx oi, uintptr_t retaddr);
 
-#if !defined(CONFIG_USER_ONLY)
-
-#include "tcg/oversized-guest.h"
-
-static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
-                                    MMUAccessType access_type)
-{
-    /* Do not rearrange the CPUTLBEntry structure members. */
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
-                      MMU_DATA_LOAD * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
-                      MMU_DATA_STORE * sizeof(uint64_t));
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
-                      MMU_INST_FETCH * sizeof(uint64_t));
-
-#if TARGET_LONG_BITS == 32
-    /* Use qatomic_read, in case of addr_write; only care about low bits. */
-    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
-    ptr += HOST_BIG_ENDIAN;
-    return qatomic_read(ptr);
-#else
-    const uint64_t *ptr = &entry->addr_idx[access_type];
-# if TCG_OVERSIZED_GUEST
-    return *ptr;
-# else
-    /* ofs might correspond to .addr_write, so use qatomic_read */
-    return qatomic_read(ptr);
-# endif
-#endif
-}
-
-static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
-{
-    return tlb_read_idx(entry, MMU_DATA_STORE);
-}
-
-/* Find the TLB index corresponding to the mmu_idx + address pair.  */
-static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
-                                  vaddr addr)
-{
-    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
-
-    return (addr >> TARGET_PAGE_BITS) & size_mask;
-}
-
-/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
-static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
-                                     vaddr addr)
-{
-    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
-}
-
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e16d02a62c..953c437ba9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -27,6 +27,9 @@
 #include "exec/tb-flush.h"
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "exec/mmu-access-type.h"
+#include "exec/tlb-common.h"
+#include "exec/vaddr.h"
 #include "tcg/tcg.h"
 #include "qemu/error-report.h"
 #include "exec/log.h"
@@ -95,6 +98,54 @@ static inline size_t sizeof_tlb(CPUTLBDescFast *fast)
     return fast->mask + (1 << CPU_TLB_ENTRY_BITS);
 }
 
+static inline uint64_t tlb_read_idx(const CPUTLBEntry *entry,
+                                    MMUAccessType access_type)
+{
+    /* Do not rearrange the CPUTLBEntry structure members. */
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_read) !=
+                      MMU_DATA_LOAD * sizeof(uint64_t));
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_write) !=
+                      MMU_DATA_STORE * sizeof(uint64_t));
+    QEMU_BUILD_BUG_ON(offsetof(CPUTLBEntry, addr_code) !=
+                      MMU_INST_FETCH * sizeof(uint64_t));
+
+#if TARGET_LONG_BITS == 32
+    /* Use qatomic_read, in case of addr_write; only care about low bits. */
+    const uint32_t *ptr = (uint32_t *)&entry->addr_idx[access_type];
+    ptr += HOST_BIG_ENDIAN;
+    return qatomic_read(ptr);
+#else
+    const uint64_t *ptr = &entry->addr_idx[access_type];
+# if TCG_OVERSIZED_GUEST
+    return *ptr;
+# else
+    /* ofs might correspond to .addr_write, so use qatomic_read */
+    return qatomic_read(ptr);
+# endif
+#endif
+}
+
+static inline uint64_t tlb_addr_write(const CPUTLBEntry *entry)
+{
+    return tlb_read_idx(entry, MMU_DATA_STORE);
+}
+
+/* Find the TLB index corresponding to the mmu_idx + address pair.  */
+static inline uintptr_t tlb_index(CPUState *cpu, uintptr_t mmu_idx,
+                                  vaddr addr)
+{
+    uintptr_t size_mask = cpu->neg.tlb.f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS;
+
+    return (addr >> TARGET_PAGE_BITS) & size_mask;
+}
+
+/* Find the TLB entry corresponding to the mmu_idx + address pair.  */
+static inline CPUTLBEntry *tlb_entry(CPUState *cpu, uintptr_t mmu_idx,
+                                     vaddr addr)
+{
+    return &cpu->neg.tlb.f[mmu_idx].table[tlb_index(cpu, mmu_idx, addr)];
+}
+
 static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
                              size_t max_entries)
 {
-- 
2.41.0


