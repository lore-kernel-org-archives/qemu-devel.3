Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8ABC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbp-0003W4-TH; Fri, 11 Jul 2025 18:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYc-0007RX-BP
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:42 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYX-0008Qd-NF
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:28 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-40a55314d06so823982b6e.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274163; x=1752878963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AF32OpjR7IHi5ZdO5VPn5KefJdmAIBFy6cf7BlYfba8=;
 b=X0wYYXpOUUoNNWJOIazljetpkbDWNsBGuQayEca8Imtc8L9wS3uk89iwSi3xmMB7/j
 2s6ZUYdQBT0a8H3vmU5Th2bd6LUtK3ANsGBO29lE83yRIZ/ySLcIOZqOWN0NlMvi52uF
 VUkiJXXPHw4AlOAKSXdstF+GWPXbEcq6DXIbfSl/BOmbP9eYEAQwRwT/eNE93nfLU7kE
 J7KK3DWzJLABt83B1nuNKdj4Y8NwIr3+AAEWpOoPoNepBe0wiY8qjYSew9O9s4xcDZ+n
 LqzAKC1hSL48SwFSO3zXb3C1NfhPP7SViuy5a9+Lix07ILGRPk0alZGx64WmlE5WbMz/
 vScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274163; x=1752878963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AF32OpjR7IHi5ZdO5VPn5KefJdmAIBFy6cf7BlYfba8=;
 b=Z2gD7Kz1WbTSYCarTW98iytqK2vVpgBT3i39z+gzi8ApLz0bct18rFOrsDIDGPsud8
 sS6r2/hj6FVA4U5bhplsA25cbGusTsnULLjHIfdHgL+Z27Gzu811dD96YrYoBR+wSDH0
 N/fI/lDA9JYrOWtY7pOMM4rac2je97EMqO9gGz/u7brKJEQ13pilS5jlUfHrFeqTNFWf
 VJjOOjkBVLCdiIBwCvOR21QsatyqHP5xZ3tN63Nzu/eGNwbLj4S61mo9QvFZCGABpHMf
 330Y7Budvhn3K9SbEmVKwx/90Vuq7OqWPKL3orUWpjLIga55sp8DdvtXhsQDj4A0eeUM
 o5yg==
X-Gm-Message-State: AOJu0YwVw/kSmlppRrjRkrM4JWYUxPcDMnrVuQq9n0Nq5mBmq4bxXPQU
 JriaJT9deAvcdyMJNwlGpdSZGXKgn4iVUvFLvWKqyalQHdopm87JB0vvS6FhfKJzqRHyjiQXFTx
 w/DGFqno=
X-Gm-Gg: ASbGncvd2Gc6zEN8jbBSO7VK06+OlB8h+9QwuJooDLgKPxL/jcIiJeDDqmTtD1cr5hZ
 zOU3keKTnFv70bKsIEXB6iZ0KMrhkufJ6AsoK+oFn7C1HhgxU8DHK+/4Z1VkrI0G3SZwhYQgaHr
 gzxLgh10rIQHWnoqFcE274IjaEcp4XcILeXQkjuI0qHncOoc6odeOFhzSYSOxepYwHArnfNWvEu
 hGMSPGlVt0LXLItlP9CMhoXW2CtwrOIWBFl3eGGy8oPXgvpu5eIzRh0O/pMOnOEcp3iJMU/xxuF
 nTZ1GVtdbUB/GLRftD99kcscv576AXGq6DnV7DMPYMJX33EXFdsrCCTxOxSECfjvBV5z+C16mOR
 3k65zsLFLRg3lyJ+FEIJPJ9V2u67qVbjuK3ltA4yxTpN5cwOV0PT0yuwdT8RkTmEAs4K3RGJE7L
 3m5CutB/6x4aErs+zdhwY=
X-Google-Smtp-Source: AGHT+IEhGX78e48TrYxo2s509U+G5Z04kiOtV/5xvL0aLSjfkwogNT0nAqIjjbQQuAkBsvlM1t1xrg==
X-Received: by 2002:a05:6808:1818:b0:40c:f698:c132 with SMTP id
 5614622812f47-4150fe892famr3383207b6e.11.1752274163233; 
 Fri, 11 Jul 2025 15:49:23 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 4/9] target/arm: Introduce get_phys_addr_for_at
Date: Fri, 11 Jul 2025 16:49:10 -0600
Message-ID: <20250711224915.62369-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Rename get_phys_addr_with_space_nogpc for its only
caller, do_ats_write.  Drop the MemOp memop argument
as it doesn't make sense in the new context.  Replace
the access_type parameter with prot_check.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 18 +++++++-----------
 target/arm/ptw.c           | 21 ++++++++++++++-------
 target/arm/tcg/cpregs-at.c | 11 ++---------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index a02439df63..6c2555610e 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1604,25 +1604,21 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 /**
- * get_phys_addr_with_space_nogpc: get the physical address for a virtual
- *                                 address
+ * get_phys_addr_for_at:
  * @env: CPUARMState
  * @address: virtual address to get physical address for
- * @access_type: 0 for read, 1 for write, 2 for execute
- * @memop: memory operation feeding this access, or 0 for none
+ * @prot_check: PAGE_{READ,WRITE,EXEC}, or 0
  * @mmu_idx: MMU index indicating required translation regime
  * @space: security space for the access
  * @result: set on translation success.
  * @fi: set to fault info if the translation fails
  *
- * Similar to get_phys_addr, but use the given security space and don't perform
- * a Granule Protection Check on the resulting address.
+ * Similar to get_phys_addr, but for use by AccessType_AT, i.e.
+ * system instructions for address translation.
  */
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type, MemOp memop,
-                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
-                                    GetPhysAddrResult *result,
-                                    ARMMMUFaultInfo *fi)
+bool get_phys_addr_for_at(CPUARMState *env, vaddr address, unsigned prot_check,
+                          ARMMMUIdx mmu_idx, ARMSecuritySpace space,
+                          GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c7db93b95c..1866c494ef 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3545,18 +3545,25 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    MMUAccessType access_type, MemOp memop,
-                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
-                                    GetPhysAddrResult *result,
-                                    ARMMMUFaultInfo *fi)
+bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
+                          unsigned prot_check, ARMMMUIdx mmu_idx,
+                          ARMSecuritySpace space, GetPhysAddrResult *result,
+                          ARMMMUFaultInfo *fi)
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
+        .in_prot_check = prot_check,
     };
-    return get_phys_addr_nogpc(env, &ptw, address, access_type,
-                               memop, result, fi);
+    /*
+     * I_MXTJT: Granule protection checks are not performed on the final
+     * address of a successful translation.  This is a translation not a
+     * memory reference, so MMU_DATA_LOAD is arbitrary (the exact protection
+     * check is handled or bypassed by .in_prot_check) and "memop = MO_8"
+     * bypasses any alignment check.
+     */
+    return get_phys_addr_nogpc(env, &ptw, address,
+                               MMU_DATA_LOAD, MO_8, result, fi);
 }
 
 static ARMSecuritySpace
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 398a61d398..2ff0b3e76f 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -27,19 +27,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx,
                              ARMSecuritySpace ss)
 {
-    bool ret;
     uint64_t par64;
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-
-    /*
-     * I_MXTJT: Granule protection checks are not performed on the final
-     * address of a successful translation.  This is a translation not a
-     * memory reference, so "memop = none = 0".
-     */
-    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
-                                         mmu_idx, ss, &res, &fi);
+    bool ret = get_phys_addr_for_at(env, value, 1 << access_type,
+                                    mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
-- 
2.43.0


