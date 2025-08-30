Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649CACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNtp-0008Ni-JJ; Sat, 30 Aug 2025 11:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELd-0005qx-Iy
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:58 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELb-00045N-TU
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:57 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7722c8d2846so1049582b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532514; x=1757137314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZIUi24UCtA+WCzxRmM2e3Q9u+Kr20hlCK3lal507EEI=;
 b=wx5WYltEomoEScrDLFeAXZD5WabZqwXvocGd/Tm/MpNdgj4Q9xlduw+nNnyEXYb2Wc
 WSaJejnkme/BKTB/d5sUQ7RjtluYtjxnnZShOxbC1u5HDRScphddcD3/tcZ/2D7xnzcY
 fK6bBVAnU6QhIGO7TP/wzPiq79L8q5F00J0rFrIVU0/9+s3dEIXLH1WFCtTL7c5ArI64
 +KM79S3XuERg8za32lzSTcraBCE4JrdqkKlwybW/gb/tzw5VksdHaTfZUhamY4FwLJy7
 xe/h1eAwwEXA/raxpklWuT61rygoSzG/umuT01yTBFn8kDd1OGrr6SYVHvhty+Mx2vTo
 a28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532514; x=1757137314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZIUi24UCtA+WCzxRmM2e3Q9u+Kr20hlCK3lal507EEI=;
 b=i75Geh9TnL/E+C5APxYFHzdsJPVB7J55DPRsXSG1DSsMq4Cl/c4lDuqlmWHUBhaxJw
 cV+8x6F+76ko5bQmbF8n8W2Fgt4virT3CAl5JzmYxQiOkjS0iD7616Wedfs/TuLGXs0u
 VmQx+RUJtvm4mH3lsRFiuAWncHFfY/jsklWA1g+uhMD79dxn4YwIyhJ4DS0Ts4vcuLlM
 KEJrBeH2VIsUMFIvhRnugxJli0jpAPL4/GmTLgVpZu8D91iEkVAhmgvLsch9IkVadSX3
 oR/LE98E+AdD6IhB+/gqE4H2BBpoNVYB6x1bgice2WbdJB1V/ky2hQM24R+Z4utn6l1H
 E6Xg==
X-Gm-Message-State: AOJu0YwkottForF4pkyUVY/vYzwgR3+M/zgByZZIr8AwhzI42iBgAzz5
 FdhjtDb8tvCp8xmMU7wcC0PRzCFWwgsTUSQFQlb/Ys2qMO02A5aupffcC2ZB6FjGce+Yq6Mgrjb
 Mx+kPBHI=
X-Gm-Gg: ASbGncvEmvOXV8ahBKBI0p5BqULKTz4nqnXYXeVM3iFfKYb/gZTmLP0oGfz3vzO188G
 ylI0RQ9K4W9P/v2YvsXyvtaAldEjlrPxFfabKPxyrobV0mGO1Kt5NzKhuun66rClbgxhrdV8U2c
 6vYha7fV/MuSPS4AGEd6Qmvt/OKoDnqc6Z2dNkg5v63wJet+qzvWaIva9J5V7+JNu0uO2fct7Vl
 JHrZA6WysaIoIM1/ukUcmUCUIdGTE6raCtQ8tD+kaBrarQhPZGShWkn702p5ii5uGRf7ZTCCm38
 IKk1oyOg8xKiOhQ+gjrWeiLpAbZaFpSWDS9W0IKv/mrLgFsugtCW3OLLR4xBUrQp5w0EuVYSx7L
 sS6H2o2Ajhu4WQFXmOOp9g9gOwyKik8jhapku9FxSOmEEJdVwYCmkHD9Qi+jVL87+JtO+0Ag=
X-Google-Smtp-Source: AGHT+IGmX6P3MRUNZaf529VQMzmLxg+zkTp+rqzPRreBm7ms8M7liNkMdVMIuyWnSiGf5kdPDMGLlg==
X-Received: by 2002:a05:6a20:3ca8:b0:243:78a:829e with SMTP id
 adf61e73a8af0-243d6f7e7fbmr1474092637.55.1756532514028; 
 Fri, 29 Aug 2025 22:41:54 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 07/84] target/arm: Introduce get_phys_addr_for_at
Date: Sat, 30 Aug 2025 15:40:11 +1000
Message-ID: <20250830054128.448363-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 899242e572..8782594b77 100644
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
index 5d85610de2..8925c9a610 100644
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


