Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C4D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcJR-0006D8-Ff; Thu, 14 Nov 2024 11:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-00052Q-LS
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIF-0002HP-JJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:07 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso716694a91.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600120; x=1732204920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nRyalkWLpxudzsmNEN2fR4VaSKzFhjYdvFTI7sg4gQs=;
 b=dT31tDmRlMxyUinjWEkJra+TYXFlZ3C6EieVlzwOZUEMG9WnM0xrWr2irVMbzv8lTH
 fmsFyStCAHPNrb63Ou7Qwi6Pk4P+i9ZXCD4t+udscjJJV8jTt9qZyqOPgypT1FdzYMTk
 KH8A7W+0ZPpy8F9srzIerC0Z4MSGLgmkeOCouPHBGXf7i0BUfrUUSVJC0Z6DZ+i/RuMn
 rWjxrWEuLLOaohh2UrHTvPWvhV7AP9t0s9NptpxNeQ0cQltVzbrYQ3RQVHLvUJYIzh8S
 vZ9kIR07tMC4mnuhomKXsPEuC9wXBEo3A7l4Buj+sRKxCtSTwKgiIYZlK2V3CCItGXqT
 uiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600120; x=1732204920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRyalkWLpxudzsmNEN2fR4VaSKzFhjYdvFTI7sg4gQs=;
 b=XKIzZV3Aw2UZtZSdS94D3f9F+Nbsblyw8iIdfRrHYBZSX1pgpMxbBto+YuzuemjYeU
 gmZxld0+CE5FauL1VDHsTt0DY0nqI1QBRMHi7CFUo4mCwVCWczZ/EWm5xs2k+nRDZ488
 lJ2cIB1v7mPW//DRZZZhf+mgo+1E7/UigclO7uV+1U01nPRgmtTX4aHyIkp9JVRfyZ2V
 HL54nUHs3+ZYKe1wg/hLqKTEK4hZN9FDPbIDp1jMKY2NOJHJxD6EVoG/yl9RxTi8vRcu
 1CygqL/zRr+x9YCtVe6ppsIAvI4NUlOEg/AXOOJ+UwNNzZ+QPDwW0RSjr7A742sgNA10
 SVrQ==
X-Gm-Message-State: AOJu0YwvfXspHGkM7ImfT/phzwot+XYdN1ZppHO6LIbqriHem90Szrq8
 ynILbulQAw/jLB0NDCiG++01x4IAVr13cjSB4C+1uUfb0HZlm7o5vVazUSzi/IpU/0cnHG9nN0k
 z
X-Google-Smtp-Source: AGHT+IHvW2J974QSn4ulUGCLcikT5osBaZ6b2NsYmusO2gXxa02oGvOJq+SpsgcBtxDPhswQCGnmKA==
X-Received: by 2002:a17:90b:3503:b0:2d3:d063:bdb6 with SMTP id
 98e67ed59e1d1-2e9f2c4eee5mr8381820a91.4.1731600115459; 
 Thu, 14 Nov 2024 08:01:55 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_internal
Date: Thu, 14 Nov 2024 08:01:03 -0800
Message-ID: <20241114160131.48616-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Return a copy of the structure, not a pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 84e7e633e3..41b2f76cc9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1364,7 +1364,7 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
 static int probe_access_internal(CPUState *cpu, vaddr addr,
                                  int fault_size, MMUAccessType access_type,
                                  int mmu_idx, bool nonfault,
-                                 void **phost, CPUTLBEntryFull **pfull,
+                                 void **phost, CPUTLBEntryFull *pfull,
                                  uintptr_t retaddr, bool check_mem_cbs)
 {
     uintptr_t index = tlb_index(cpu, mmu_idx, addr);
@@ -1379,7 +1379,7 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
                                 0, fault_size, nonfault, retaddr)) {
                 /* Non-faulting page table read failed.  */
                 *phost = NULL;
-                *pfull = NULL;
+                memset(pfull, 0, sizeof(*pfull));
                 return TLB_INVALID_MASK;
             }
 
@@ -1398,8 +1398,9 @@ static int probe_access_internal(CPUState *cpu, vaddr addr,
     }
     flags &= tlb_addr;
 
-    *pfull = full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
+    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
     flags |= full->slow_flags[access_type];
+    *pfull = *full;
 
     /*
      * Fold all "mmio-like" bits, and required plugin callbacks, to TLB_MMIO.
@@ -1423,19 +1424,17 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
                       bool nonfault, void **phost, CPUTLBEntryFull *pfull,
                       uintptr_t retaddr)
 {
-    CPUTLBEntryFull *full;
     int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
-                                      mmu_idx, nonfault, phost, &full, retaddr,
+                                      mmu_idx, nonfault, phost, pfull, retaddr,
                                       true);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
         int dirtysize = size == 0 ? 1 : size;
-        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
+        notdirty_write(env_cpu(env), addr, dirtysize, pfull, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
-    *pfull = *full;
     return flags;
 }
 
@@ -1444,25 +1443,22 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           void **phost, CPUTLBEntryFull *pfull)
 {
     void *discard_phost;
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull discard_full;
 
     /* privately handle users that don't need full results */
     phost = phost ? phost : &discard_phost;
+    pfull = pfull ? pfull : &discard_full;
 
     int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
-                                      mmu_idx, true, phost, &full, 0, false);
+                                      mmu_idx, true, phost, pfull, 0, false);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
         int dirtysize = size == 0 ? 1 : size;
-        notdirty_write(env_cpu(env), addr, dirtysize, full, 0);
+        notdirty_write(env_cpu(env), addr, dirtysize, pfull, 0);
         flags &= ~TLB_NOTDIRTY;
     }
 
-    if (pfull) {
-        *pfull = *full;
-    }
-
     return flags;
 }
 
@@ -1470,7 +1466,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
                        MMUAccessType access_type, int mmu_idx,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     int flags;
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
@@ -1482,7 +1478,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
         int dirtysize = size == 0 ? 1 : size;
-        notdirty_write(env_cpu(env), addr, dirtysize, full, retaddr);
+        notdirty_write(env_cpu(env), addr, dirtysize, &full, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1492,7 +1488,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 void *probe_access(CPUArchState *env, vaddr addr, int size,
                    MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
 {
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     void *host;
     int flags;
 
@@ -1513,12 +1509,12 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
             int wp_access = (access_type == MMU_DATA_STORE
                              ? BP_MEM_WRITE : BP_MEM_READ);
             cpu_check_watchpoint(env_cpu(env), addr, size,
-                                 full->attrs, wp_access, retaddr);
+                                 full.attrs, wp_access, retaddr);
         }
 
         /* Handle clean RAM pages.  */
         if (flags & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, size, full, retaddr);
+            notdirty_write(env_cpu(env), addr, size, &full, retaddr);
         }
     }
 
@@ -1528,7 +1524,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
                         MMUAccessType access_type, int mmu_idx)
 {
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     void *host;
     int flags;
 
@@ -1552,7 +1548,7 @@ void *tlb_vaddr_to_host(CPUArchState *env, abi_ptr addr,
 tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
                                         void **hostp)
 {
-    CPUTLBEntryFull *full;
+    CPUTLBEntryFull full;
     void *p;
 
     (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
@@ -1562,7 +1558,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
         return -1;
     }
 
-    if (full->lg_page_size < TARGET_PAGE_BITS) {
+    if (full.lg_page_size < TARGET_PAGE_BITS) {
         return -1;
     }
 
-- 
2.43.0


