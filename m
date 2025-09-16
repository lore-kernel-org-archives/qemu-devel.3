Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4A0CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4R-0002zF-ET; Tue, 16 Sep 2025 14:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4P-0002s1-Vk
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4N-0001Zl-LH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso35430825e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045982; x=1758650782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7ECBn6N5IfpT2DcG4vN1Bk0unyr8MRHKpcjEdajq/Zw=;
 b=dYdlcVI9yru39qydu7iWPsw4NI+A8MBD28I2olG8blAMHYW3taGtQlf2hPLVautY7g
 2N7a9zsj6qPBelQ+Dh4nVXHaq7DxVR2YZzDm5w4aV4X578XMY1qZAzeqB+yOazjYcxpf
 m+UcQtBv9PkFbFqJeGNz4X/ffkr+W5rmyZemOnlJR3osNpfdwoJW8FT2uzjPoSAO4m1w
 QHZUziDOs0YpqmIhQCl0bUYvfKRz4fphYj8Gn56h53016v8/ED9EjPOWOPBe/DZmg6dB
 FRe8PXucddukbfzNmnYMgXs0FqrGkg4aXkSiQMjvVnab9qMiBe93HxV+pHcrEHwD1tgG
 6rTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045982; x=1758650782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ECBn6N5IfpT2DcG4vN1Bk0unyr8MRHKpcjEdajq/Zw=;
 b=nLF7B+TlQHtfcdd44+ofZB8QRzackWR8vwwHWy5+WcgBaapElUAmHQ2VlM0XihVeQA
 v1DWy+8qdzLNooCkQmCP+l8sUC5W97Z55NWOS0FtMv/oL5ituzwg8+vEZSWxkw93kxyT
 Bx5P5JGCmMrX+j9wobsTZTvJ9ZgCMuxO0As+WA+8UB6fWTXx6WssOnQdkGoLHrAizeHD
 GBwChgF657id97+TLDZfDhMQBIwLT0+FJ6Vr5d06fMJFAwxrkGy3ZN2WryZ/YmY/BDJ/
 6kZnUjMuKnmLgQrcm/taogHctHwPm/y+eEZDj6wLzuOH2i4AulCcBuhkLgePUeXIIwi+
 tXiw==
X-Gm-Message-State: AOJu0YxwY36M2plpbMkmUFCGtWSi5cU7S4VxXVpaWz56sv90pIjXJvgZ
 DJk7RgywzuMUOWgKyT39MOtB5lIc3MCwx0bic9pZckKN/6HgOGpMtWXCNUfZaz5FYmLKtkmHnae
 p6eZd
X-Gm-Gg: ASbGncuuKGQettfFuSjyYRbn8kCXvFgK14zvURclYRX2gho5BI0l45Msq2lqxtxFCOl
 ey6FQojuzGh91R/a7CxGOFh2cujG/odqb2ntf2g8OMx+ph+kVjNcnfdSeFqzqdatuRz8ap3pRkI
 Mh/ljh+O1+Ta/WXN1rPg7jaMAvSqAxGR2ePBfGOMkQhdwPJma3QxnDIOb0bM+brQkqWbnDdoaNV
 4amEy5KSDmlCVyIuANUGelER4/bVCEIy4lYRDZ9xK0iThCN+uEHYh9KLdqyo9xHpFhLe7zVhl7C
 yIGzUlnx5+5KzBLnYEyXFOyY78a8Z1ek6kjbO/IoiRnO+gVi5L09xLK5JcZlb6ivcHFfgjDcM6U
 oloAusqtyN0FL652Qz95iysc1lJ7w
X-Google-Smtp-Source: AGHT+IG+85LWHUXpr9pMldixRuJcz+vNz60WkgedJv8nXDvgPHEb1DOoIlyVNnzNPl38BUOKI5TA7g==
X-Received: by 2002:a7b:cc88:0:b0:45d:f7ca:4f07 with SMTP id
 5b1f17b1804b1-45f2121490bmr136114715e9.18.1758045981895; 
 Tue, 16 Sep 2025 11:06:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] target/arm: Introduce get_phys_addr_for_at
Date: Tue, 16 Sep 2025 19:05:42 +0100
Message-ID: <20250916180611.1481266-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Rename get_phys_addr_with_space_nogpc for its only
caller, do_ats_write.  Drop the MemOp memop argument
as it doesn't make sense in the new context.  Replace
the access_type parameter with prot_check.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     | 18 +++++++-----------
 target/arm/ptw.c           | 21 ++++++++++++++-------
 target/arm/tcg/cpregs-at.c | 11 ++---------
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 899242e572f..8782594b774 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1602,25 +1602,21 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
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
index 5d85610de29..8925c9a6100 100644
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
index 398a61d3989..2ff0b3e76f7 100644
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


