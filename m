Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A51CA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXN-0001Lf-HH; Thu, 14 Aug 2025 08:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXM-0001L3-Gx
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:32 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXH-0004C0-It
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:32 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-323267b98a4so864010a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176304; x=1755781104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZozRqgl1Uc77xaTQQdsLXzgeEe/cos7TSzVU6j/Q3E0=;
 b=Kiw3YMvkJYp6/PzjKQ0ot4YbSkRAKZ6Mf5fh9OOGQM0Ebiz4bqUPiD3SK29XZhRppe
 XWuIB9RtKXRruRnWFUqPZE5jIcHzss2krZFkrYrlycSuokr6pTXl/j1s7jGwStl64bln
 SbrRh5+ElCDYijShrzDtWYjapQLvq48spF4DOPSKs8YQ0GN/j3bJkbNJwoSIEBSU2hhr
 LjSCa4Qc/0mclni6akK48gOuoNrszs+0k0Vjxsh1orda3QBdWrWWHEUvpdxIxUzOdIeS
 k+AipZIKQHcpolOxKi/OuawKM8Hi3Q1WLV1o2bAmGRLpmesAlYJVHA5yNH0kDbEbIwkP
 Tesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176304; x=1755781104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZozRqgl1Uc77xaTQQdsLXzgeEe/cos7TSzVU6j/Q3E0=;
 b=OfzPZq9zFKCObbqMsWS7jfMcbiSr3nMJjqQnLcMxMGYFGbNHiKQbatDpt//VdjADY5
 +q1OvL2RKhvcgj4tERoXcOy7RnHBRztDj4aYVFP4h8iLI1znBk9dp9qBOWkCH0S/bK/r
 62r/jNWOYtxF1LVMPDFPnc5R2swNGvawq1jvZxSYEXbfTrtlmFJGg4obZO4y7w8HgfyJ
 dq9A23vcAuJbsAbTi86QU4yyKiPwq8cwMFyHF7cyAliMwbPasRwjsuq91kGRbVtuNlhV
 Tc+g5YYbeJ5jI4e9FSFe2n5FH7+u2apptl5OuMP/X7lR0PuxnqnXcdP6I2Dt9yp2r76r
 TP9g==
X-Gm-Message-State: AOJu0YyqK5DaLH0kGdjOZdVgN+Gfsar3YLTBKcciNv4axNMUR4jjeBU1
 D9aAjwEXk+cKR5iIVXcst564B5zl23C61DSjOJd/NhlLTW+yx1BdF8ZdJWyDOuFwElElA46r0wL
 ejkN43Ns=
X-Gm-Gg: ASbGnctV5ojhpw0fXSHRe6S8UlsuwwYKdtVWgqBa1i2dROPDh2vThtmK9r51Awz7Dyv
 kDIhS/+dxrywvlLKmK6IaICFQt5NVlUwSuTU2yohhDRBbICHvQT+B10HDY27JsSHRkO+1GDwDZa
 F5ooD7m5/BqPstHEFHbhNusiB7fmpA1DY6vj88dXwLCA69WQmK9L/20a+ex9uOsqBValt3KlXAn
 RILo0PJDJmC3NqF5Kff+s1epfPswKh9R02Sl1GKwJcbWX3vUkYyTEN4IXZDpdJZSjscFDuXgd51
 MoJX0glFWsIsX7JHMw0o/sLs8zmx9W2GmLT/+2Yoxp3p6f3gIcrienn42szh9RZ1xNgZTGMu9Wd
 DegE2FExPNXz5UbRcCk0aMelx02P6xgKrDEFSdynH/RuZZd8=
X-Google-Smtp-Source: AGHT+IFkliGFbRD4ynwrlexJaSlOn3qSueStZwUB9d27eiOMUHT68oz+UIBNKMm6fTd+Dp9x1+lBjg==
X-Received: by 2002:a17:90b:28cd:b0:31f:134:94ae with SMTP id
 98e67ed59e1d1-323279c853cmr5224610a91.11.1755176303832; 
 Thu, 14 Aug 2025 05:58:23 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/85] target/arm: Introduce get_phys_addr_for_at
Date: Thu, 14 Aug 2025 22:56:34 +1000
Message-ID: <20250814125752.164107-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 18 +++++++-----------
 target/arm/ptw.c           | 21 ++++++++++++++-------
 target/arm/tcg/cpregs-at.c | 11 ++---------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 326b5a73cf..0dd1b214c8 100644
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


