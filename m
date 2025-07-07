Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CA0C83030
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYt0f-0004ZW-CD; Mon, 07 Jul 2025 17:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLW-0005R7-VE
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:54 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsLR-0004N9-TX
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:47 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4a9bff7fc6dso11459181cf.1
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919704; x=1752524504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UcOaztiRFujwM8Q+/rW8sEgsaMvxPs1FzhzS5/SBNWQ=;
 b=ETJXC4Z2pBciI/VJUXbBqPrTME1CvonVbYzLzVcMvtqvBae7ah2jstUDxkNCR1D87w
 XHcHtP5vERkDrOSileQ0CC6N4SbjvHdFY0Z9b7bMZBDPvs4Zxpq/X0otATLVVPwLOjYd
 yD6kgOQ0dkHBZAQ1Qy+wyXwCIdi31Ee30muDvyCPEPC3TNn1s/ZXTO7l7jqKUnTuNZkk
 wLeJmwJhasAz/zSBeIF4YDq6Yali4BRNTle8fAxiPPEsxV0VopD44oFbQiNLTKM+KQyO
 wGp0W1YhF/hjb7MMMq2ltDnikfbIny8Os9r+lGspH5dip1jU4GaaT0cApqHe7q9PpmBN
 dotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919704; x=1752524504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UcOaztiRFujwM8Q+/rW8sEgsaMvxPs1FzhzS5/SBNWQ=;
 b=egX88km9C4F3Hld2Fngs7CdvfCzWFds7aVPYgK3T5xwVKwkUWrTsOOWfUe2E0LpSy8
 fHB4qPD9fneCWms25OBVGgwXBQuZ6hEdnQDKHh089fmQ6Hl5fTpScAmvnU0KtDKm/vUd
 3oCDH9qc4ullghsp3eYxA3jrfWMemLd4eKWrZW87o9mZke+E5n4hrNLKz2DfQr0inPYd
 5p6gFEjIGGa6SlV6zBdOb1Jfn8oD4zCg31W+4Rse+jNpMPZGSjIJyX0jdA1mNpQfECA5
 x4G/TYOggnq0L5aXE0gMK+E8vvQrw9M/HlyQF4Y/NCMAlyI2PgmP1A0z64dt6OMpUgdH
 B8fg==
X-Gm-Message-State: AOJu0YxX4OOB4l0+H9gYmNv5puZyu3+vFIOlbeGm5lbvshrio2wUU7fT
 gJ7scPcQljsoYWWAmWZA2aQzSyKv31zoK1xWhfEoo4nO/TNsn7UmWRR6XzN4FKacr7W3epPuJQp
 bCQRK+WY=
X-Gm-Gg: ASbGncvo0VMtYh3uPlV5gZApxwAirnF0AJyAuhd13jUSeAX8sJT5pc1HheUiaXUdrGs
 glq6XJs/DGnGtZOpOxwdapv+ar0Z+Uhltbl7eKJeZRplCWESyzdd6UNGVK9mv8gELsw9tmt+c9K
 jTy22ytl2iWlelsTcswfFa9gU3NTsQm/mdQ8fJOeyvZr0yBHHdxJiKtg1gSoeNXTiMCitN7TnAH
 3ld8Ha1BURBLd5QyiKqoYripY1slbm5b7wk1jGwb9UVUgZPBP0q3hEYwVY/wUWQ8lFuxfWPy68d
 of5PXCClOtfpK9z2QuecgjoU51GLZ162FKLr2xppVwS/T/Z2H+X2HYgeoJITrU6k7WBPtpE5jl/
 e8TH/aXrmvSN7A2cQ
X-Google-Smtp-Source: AGHT+IF7dPdOFBCd6biW+fI3tOYHLV357pzNDh2FxmHgScJGPzy+bs1yyAlH4EaAboMqIzXeJsfhlw==
X-Received: by 2002:a05:622a:a908:b0:4a9:76fb:7eaa with SMTP id
 d75a77b69052e-4a9ce74bc99mr403641cf.0.1751919703602; 
 Mon, 07 Jul 2025 13:21:43 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/20] target/arm: Introduce get_phys_addr_for_at
Date: Mon,  7 Jul 2025 14:21:07 -0600
Message-ID: <20250707202111.293787-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x836.google.com
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

Rename get_phys_addr_with_space_nogpc for its only
caller, do_ats_write.  Drop the MemOp memop argument
as it doesn't make sense in the new context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h     | 17 +++++++----------
 target/arm/ptw.c           | 17 ++++++++++-------
 target/arm/tcg/cpregs-at.c |  9 ++-------
 3 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0844048ee8..6aea942d06 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1584,25 +1584,22 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     __attribute__((nonnull));
 
 /**
- * get_phys_addr_with_space_nogpc: get the physical address for a virtual
- *                                 address
+ * get_phys_addr_for_at:
  * @env: CPUARMState
  * @address: virtual address to get physical address for
  * @access_perm: PAGE_{READ,WRITE,EXEC}, or 0
- * @memop: memory operation feeding this access, or 0 for none
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
-                                    unsigned access_perm, MemOp memop,
-                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
-                                    GetPhysAddrResult *result,
-                                    ARMMMUFaultInfo *fi)
+bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
+                          unsigned access_perm, ARMMMUIdx mmu_idx,
+                          ARMSecuritySpace space, GetPhysAddrResult *result,
+                          ARMMMUFaultInfo *fi)
     __attribute__((nonnull));
 
 bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c1fe53965c..19a53ec707 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3538,18 +3538,21 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
     return false;
 }
 
-bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
-                                    unsigned access_perm, MemOp memop,
-                                    ARMMMUIdx mmu_idx, ARMSecuritySpace space,
-                                    GetPhysAddrResult *result,
-                                    ARMMMUFaultInfo *fi)
+bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
+                          unsigned access_perm, ARMMMUIdx mmu_idx,
+                          ARMSecuritySpace space, GetPhysAddrResult *result,
+                          ARMMMUFaultInfo *fi)
 {
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = space,
     };
-    return get_phys_addr_nogpc(env, &ptw, address, access_perm,
-                               memop, result, fi);
+    /*
+     * I_MXTJT: Granule protection checks are not performed on the final
+     * address of a successful translation.  This is a translation not a
+     * memory reference, so "memop = none = 0".
+     */
+    return get_phys_addr_nogpc(env, &ptw, address, access_perm, 0, result, fi);
 }
 
 static ARMSecuritySpace
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index c34fc6ec6f..e79866e651 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -33,13 +33,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
 
-    /*
-     * I_MXTJT: Granule protection checks are not performed on the final
-     * address of a successful translation.  This is a translation not a
-     * memory reference, so "memop = none = 0".
-     */
-    ret = get_phys_addr_with_space_nogpc(env, value, 1 << access_type, 0,
-                                         mmu_idx, ss, &res, &fi);
+    ret = get_phys_addr_for_at(env, value, 1 << access_type,
+                               mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
-- 
2.43.0


