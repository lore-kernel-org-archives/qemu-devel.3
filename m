Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ACDC44515
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkrtt-0001Y1-UL; Fri, 17 Jul 2026 19:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtp-0001UA-3Z
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:21 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrtk-0006yY-Mm
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:18 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-ca965de53baso2809394a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330595; x=1784935395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jexTKBibLdxg3RvO/0OqJ7xCxktdejWuZt8hYEIzmj8=;
 b=hHtKkJsFLGMH2yltT2tKWweY0mybbwvB/b540KmSuoS+Kwll8fZ2ssQGVupjlKbkJO
 IktznEeQ1J/xyXHiIhIUA6ZkXpgL/cmES8Qavfauj4aVKum6TelTScOA488jDAi/eEup
 fKFxWF7psv3gyG5L3cel2RGtuiMwm4+Rgbi+OWGd74o5pb+uk5MxGEAW5jFCzM3kb3Wl
 jRi4cKbhwoezjMire0Sf+/Ok1kazOrDYeX7URBI6dYWL0wzyxVJd0CKvG92n05HTOmpt
 jSowEAjnX4dHNbvOOE4ty3lNRll3irtS4ka1ugUnxS+Wj6Uyh7JDZs/uvO6Iw26JffjU
 BDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330595; x=1784935395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jexTKBibLdxg3RvO/0OqJ7xCxktdejWuZt8hYEIzmj8=;
 b=k6mWR0ASr11HHloRrEEjiIsBzzGRz/Jhootm0hwDxdS8c3cCQErdRwlLqLnfD2mD+W
 /JERCuoS7MF4xmQFObqkGW2WJMd7adbS7sJIz3ImvmSLpTkbwd1nZH3RgyIIGLst7LbE
 EdkZ1rw7/i2sRsp/cr/j3OsKz31AOdxADCrEikMyy6W63JRMwYZLw6n2/1ufJ/37ofmC
 9yvke1TnrGyIpO7ZjaSvKKB9atMw8oTW54gEzY9Tvh40bS9OPqDBc0xkNBZDYhEcVwhA
 qtjpI7wGwZu9jUj3lCGjxb+1h+1uVsYmPptmmMI8fTz2mvNgCOhNGMw9KWrbxe7xlAot
 RHNA==
X-Gm-Message-State: AOJu0YwKLJ8sgbeAeRwTVTSLsT7xoK+y2nGAFFDzxCOtYpCnLB3oxiDY
 LWv49iagsvJy/jbw3G8Ma43ZamBRAMB/+6EI7i6qEa+uc+L2u+kxlHHEh0gtko1hNcCfe+ScHB+
 OB3lf
X-Gm-Gg: AfdE7cmFG6XvXY00AwKTRzqU//kYo+PXaFf3W8Xk6BjsWZ4exrowMm12dSPidtVsnfM
 sSbzwk2Oal1GRkoqmZOBqemWYzv6mKtJNobc16FUU6AcoXEvYCVV0+FW65T944pQ/llFqWXJ1wZ
 Na1e298shbnzYaVkGzefg9LuScCKvCUgcIMu4MlOxMROODmNmEPnnvGvg+OvA4NHXDVqduKysYf
 y5L3KXqeBdpWxxdCJpH1oYTgA+DWOfnkE7d04HuGd61ZCXjKmo0yhZBLZ2mxkcVdxe2PhOm3GE5
 bILhNLVBH01991gqFDvQnM+TkDaP4eDD0CFAR+VOki4EVfh39jzEWZda4rdD2nYDpSqfcUI6Mkj
 EUu9JjJq9d5vBzbv8SRVWvC2QshKlI4hyVzxm6b47rs3DVNTEC/vCMvlLFCEabj5Y5t6cLuobLn
 tSiYy9oFE=
X-Received: by 2002:a17:90b:2151:b0:38e:59c2:cbc5 with SMTP id
 98e67ed59e1d1-38e59c2dc76mr1185855a91.18.1784330595170; 
 Fri, 17 Jul 2026 16:23:15 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/17] target/arm: Imply probe from allocation_tag_mem_probe
Date: Fri, 17 Jul 2026 16:22:53 -0700
Message-ID: <20260717232306.378988-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Rename current allocation_tag_mem_probe to
allocation_tag_mem_internal, then create a new
allocation_tag_mem_probe that lacks probe and ra arguments.
Force those to true and 0 when passing off to _internal.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/mte_helper.h | 18 +++---------------
 target/arm/gdbstub64.c      | 10 +++++-----
 target/arm/tcg/mte_helper.c | 29 ++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/target/arm/tcg/mte_helper.h b/target/arm/tcg/mte_helper.h
index 1f471fb69b..b23a5de193 100644
--- a/target/arm/tcg/mte_helper.h
+++ b/target/arm/tcg/mte_helper.h
@@ -19,8 +19,6 @@
  * @ptr_access: the access to use for the virtual address
  * @ptr_size: the number of bytes in the normal memory access
  * @tag_access: the access to use for the tag memory
- * @probe: true to merely probe, never taking an exception
- * @ra: the return address for exception handling
  *
  * Our tag memory is formatted as a sequence of little-endian nibbles.
  * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
@@ -31,22 +29,12 @@
  * a pointer to the corresponding tag byte.
  *
  * If there is no tag storage corresponding to @ptr, return NULL.
- *
- * If the page is inaccessible for @ptr_access, or has a watchpoint, there are
- * three options:
- * (1) probe = true, ra = 0 : pure probe -- we return NULL if the page is not
- *     accessible, and do not take watchpoint traps. The calling code must
- *     handle those cases in the right priority compared to MTE traps.
- * (2) probe = false, ra = 0 : probe, no fault expected -- the caller guarantees
- *     that the page is going to be accessible. We will take watchpoint traps.
- * (3) probe = false, ra != 0 : non-probe -- we will take both memory access
- *     traps and watchpoint traps.
- * (probe = true, ra != 0 is invalid and will assert.)
+ * If the page is inaccessible for @ptr_access, return NULL.
+ * Do not take watcnpoint traps.
  */
 uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   uint64_t ptr, MMUAccessType ptr_access,
-                                  int ptr_size, MMUAccessType tag_access,
-                                  bool probe, uintptr_t ra);
+                                  int ptr_size, MMUAccessType tag_access);
 
 /**
  * load_tag1 - Load 1 tag (nibble) from byte
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 0c3e5b30bd..08900f6843 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -725,8 +725,8 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
     /* Note that tags are packed here (2 tags packed in one byte). */
-    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
-                                    MMU_DATA_LOAD, true, 0);
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD,
+                                    1, MMU_DATA_LOAD);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
@@ -753,8 +753,8 @@ static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
 
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
-    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD, 1,
-                                    MMU_DATA_LOAD, true, 0);
+    tags = allocation_tag_mem_probe(env, mmu_index, addr, MMU_DATA_LOAD,
+                                    1, MMU_DATA_LOAD);
     reply = tags ? "01" : "00";
 
     gdb_put_packet(reply);
@@ -800,7 +800,7 @@ static void handle_Q_memtag(GArray *params, void *user_ctx)
     /* Find out the current translation regime for probe. */
     mmu_index = cpu_mmu_index(env_cpu(env), false);
     tags = allocation_tag_mem_probe(env, mmu_index, start_addr, MMU_DATA_STORE,
-                                    1, MMU_DATA_STORE, true, 0);
+                                    1, MMU_DATA_STORE);
     if (!tags) {
         /* Address is not in a tagged region. */
         gdb_put_packet("E04");
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index dc87dc283f..905e9d7eaf 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -80,10 +80,11 @@ static void mte_perm_check_fail(CPUARMState *env, uint64_t dirty_ptr,
 }
 #endif
 
-uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
-                                  uint64_t ptr, MMUAccessType ptr_access,
-                                  int ptr_size, MMUAccessType tag_access,
-                                  bool probe, uintptr_t ra)
+static uint8_t *
+allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
+                            uint64_t ptr, MMUAccessType ptr_access,
+                            int ptr_size, MMUAccessType tag_access,
+                            bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
     const size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
@@ -92,8 +93,6 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
     uint8_t *tags;
     uintptr_t index;
 
-    assert(!(probe && ra));
-
     if (!(flags & (ptr_access == MMU_DATA_STORE ? PAGE_WRITE_ORG : PAGE_READ))) {
         if (probe) {
             return NULL;
@@ -250,8 +249,16 @@ static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
                                    int ptr_size, MMUAccessType tag_access,
                                    uintptr_t ra)
 {
-    return allocation_tag_mem_probe(env, ptr_mmu_idx, ptr, ptr_access,
-                                    ptr_size, tag_access, false, ra);
+    return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
+                                       ptr_size, tag_access, false, ra);
+}
+
+uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
+                                  uint64_t ptr, MMUAccessType ptr_access,
+                                  int ptr_size, MMUAccessType tag_access)
+{
+    return allocation_tag_mem_internal(env, ptr_mmu_idx, ptr, ptr_access,
+                                       ptr_size, tag_access, true, 0);
 }
 
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
@@ -1221,7 +1228,7 @@ uint64_t mte_mops_probe(CPUARMState *env, uint64_t ptr, uint64_t size,
     /* True probe; this will never fault */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
                                    w ? MMU_DATA_STORE : MMU_DATA_LOAD,
-                                   size, MMU_DATA_LOAD, true, 0);
+                                   size, MMU_DATA_LOAD);
     if (!mem) {
         return size;
     }
@@ -1279,7 +1286,7 @@ uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
      */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
                                    w ? MMU_DATA_STORE : MMU_DATA_LOAD,
-                                   1, MMU_DATA_LOAD, true, 0);
+                                   1, MMU_DATA_LOAD);
     if (!mem) {
         return size;
     }
@@ -1331,7 +1338,7 @@ void mte_mops_set_tags(CPUARMState *env, uint64_t ptr, uint64_t size,
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     /* True probe: this will never fault */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr, MMU_DATA_STORE, size,
-                                   MMU_DATA_STORE, true, 0);
+                                   MMU_DATA_STORE);
     if (!mem) {
         return;
     }
-- 
2.43.0


