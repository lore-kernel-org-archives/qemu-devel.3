Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A4BC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLd-000542-Ah; Sun, 27 Jul 2025 04:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLa-0004qC-A3
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:06 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLY-00041F-5w
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24003ed822cso1914845ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603383; x=1754208183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBl8wbDOpfkOgn+Qj5iZnDh6LWcdNiRislLxlLvgUus=;
 b=Qq87pOknrhZrJ9Wk07bAqagbbwEBi9ZBt/G2JVThL6wOrnqvCUWdf4WtGu0zjUa0qY
 c7d7i0C0cGe3XeVTS8J3rUbC3Q5Z8Hgp4MdIXEfthmIHOyM/Zu/Pcds5j+I/9zuJU7Og
 hR2K8RTtVV94SGho6UJeyr5X4bfM8fo1khM9FKWPcua+xOuAo0Xy8sA7EQ+Yy6Op+8Pi
 +BTmsk2AdJ23LQqGBOYrwugICwdAZba8Es0mkfbVIO6C+fiOc4C0uCIO/b2U7T0aBM2X
 /veav2i3uZcYR8frXHRtNGx6TWwvhJY4RVPX9qM8N4vuQ5ZBR0QEpNIdcmomvzggG8wZ
 xkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603383; x=1754208183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBl8wbDOpfkOgn+Qj5iZnDh6LWcdNiRislLxlLvgUus=;
 b=FkOUz6qby9hWGqoZjDIyHho/9Tx5avkgltXZnbWF7xXJZ9KJrgN3zcvMGhZ9teOEqo
 ehM6kJUYEvadT0hDbHur+awHACYnq2vb+W1GyYvmkv08XY67mKqu62/iaWWthNHPf9fG
 8F9d350yTBRxQsk7QCdFE3UTNurWS3L96XFY3DMMtVhs/Sl2Rdjz/jAB943fcupse6KD
 swRYyxcF+ZD3eVcanWgC7BLBnyJKJi/jLQIeSXWZV8bCQf0p+L8qCr6S4nsDk5qo+Uv7
 +9EaXF8F14yGzlKGpuZBpy3bP2fT5uBJUM0Sk3bPfLjNSWOH2mBGVHAo/fqsRnmGK0gu
 Jo8Q==
X-Gm-Message-State: AOJu0YyAa1vABOvQ+Mzo74z9U6LfYlYyAc2POaLNPH3jpzWYNtFk/IaB
 PDZv0V41ICpmSa5xBviepyXghTdeY4/Hj3bOlukamWosJXQOxitigo55l7AwXt+ctd1l6lDf7Sw
 /9H2G
X-Gm-Gg: ASbGncubewoRZQhj6lgxMP+fAPr5Yec9giaA2QsFLiNVY0pbLT8OgZw08VE4EsxREMe
 p/svTWIL2FJfodU3WfW7zSp+bHqLtnwVoGAvcaFGZnbbWGqSg2IJ6MPBmXP7nvrGKsnSKraW0Xe
 hpnE+EB0TRiOxzo99sbJ+ZsUGnmB8ysaW2y/8GwsbWFwUVDN6M3oZzbSGtrVFqPSZtpOufV4tBF
 Sf1GV9xNL1I9OUakcRn+kjrft9b5Pz1qz2ZMyUJqDEbmce22zXggXN4GeKIXpV8uq60iqUUXuFB
 NDCaC/F+Ni6uLkRPIdrI5bxxYjBY4llXlfO5P/iMJsRj4azgM37CTU8b+b+yoBELkciyqcsQQsw
 iSZSQcB50burtWqsHQWf7tI1S96815NWmxbDWNEGuGCjlYnh5Dg882RsCkYyqP3e1NNbkXYcLiW
 nEe7dgAUfTYA==
X-Google-Smtp-Source: AGHT+IEgJ6ZyBs2S1E41d1MudyquAGu/lrvMtcFIScCW1Hdi9hk3xoB5Tnt6lm7KgyG4jYDxEvg9/A==
X-Received: by 2002:a17:902:c7ca:b0:23f:f96f:9dbe with SMTP id
 d9443c01a7336-23ff96f9fecmr27379525ad.24.1753603382640; 
 Sun, 27 Jul 2025 01:03:02 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/82] target/arm: Introduce get_phys_addr_for_at
Date: Sat, 26 Jul 2025 22:01:36 -1000
Message-ID: <20250727080254.83840-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
as it doesn't make sense in the new context.  Replace
the access_type parameter with prot_check.

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


