Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E7ACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvm-0006nj-O9; Sat, 30 Aug 2025 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELY-0005pw-Ew
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:54 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELW-00043s-P1
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:41:52 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-327e5b65e2cso1188402a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532509; x=1757137309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3X6dK/y2a1gIrJDtkDZkfEpwUr8G+BbPPw6R4etjaMU=;
 b=fAv0r+vPKk17wMFg6zA9utWEFsriC8wEQcVIbU2ggOzOmL/2rf2hi26kzv0JLKXC0U
 SogcSDTUjPmAXQ8fDEYtXIEcmYujJCe/UhdedkerXw8HVWXymLkiDpU8tMizMBiiAs7G
 kSL7E/2jzvwpfYgxsrS6o86grbSp34Bt/PPmJN9APON2lvSFFJK3t+I+EeukI++JAYkt
 5Kd8+ps2mz7iSAv9uxmRQsbibnpggbpsjiMQEEJMkWNaJWXqD3h7BbuzBDPQl0VBsG+D
 4pti1VpSQhLPnlixM5rvKz5sb0Dzz8cxkzNBF9L7ASoPVZta173yZi4+5QXh8FtANhKk
 y8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532509; x=1757137309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3X6dK/y2a1gIrJDtkDZkfEpwUr8G+BbPPw6R4etjaMU=;
 b=hqdfgzguUW0ptCyG2iZvj738XZquTEUYEZHyH5NTuaAyXjSppNCIexE8MEewTFVC73
 I98pUF3YH+qvHccaP0ut3J3EGvXHDJioNlJXq8mXG5D+zfB/5Ksx2Tb4g51J4LFWmiFm
 Lq1CLym18Zz75NmvyjdCyREKHzP8Fq7kh4UY0JJf9HWeQp+x1d1Nz2s5PSkCUnj77Lqq
 NQBH31aqvYVkAUo3aGI4+NRt3vB9kBatXZeK1FdlI0E7QEDPgsU2h1P+0v/OEvAjdYPB
 e/TmJLriAA0NqRAZbIzF0oZBCoumoNIgF0Ia34QjLhsHvK8P63CVZFDH0Ippy2YVqw9G
 mb0A==
X-Gm-Message-State: AOJu0YzIiEuiDE6RADKDESLhOjuHzJ0TO1nQjF2nrGEkzz9ZzqDjLns+
 O2ESHItWfosJLDKMy/vYqNcNCciFodiNktQud+JOL+JVE5QazIy9gxkbmoFejsse4vy8/I/1YMn
 ODGZMMpM=
X-Gm-Gg: ASbGncsikzrDXnxX/BhURyNa+XC7trE8uv9XUPQSJ9Wo7CwbAx4YDWjyAN075gaZ2dr
 axgljWJj89Mcv2ITa02wJsnxmtf14CABp7tFpg2ZxotxXuH+0mTe/4tfGxtE6lDU2yfj8IOVljZ
 xtoN0JvsIjRrcfJKqA8lG/EkywbtWPIVd7ZLLo29Q0z1OjNfmc9jeQloWUUcpQy3Lv5TD+V9GW/
 1meAv2T+62ZER5o4TDgqYpvH1iKZOa5oOy7FBYmAZE2YjWjnDsRnPwduKXJonEo9egIOMSTOr++
 /0qgvop7nZzEMn760VrcKy3Ro8JOqgxx/MGvbZkF50+kqF4dGC1911EOY/Zlr1QbMfbDLyd/mV6
 zm8uEE8Yy+xlRYoX5E3QpxcmHNe/FIZ66zIMj3eqemo+vqSpihgDE6RdhueMJm00HhlK+V+M=
X-Google-Smtp-Source: AGHT+IEu2mSVwzDT5LjMKQJdS2hDVzvACdeZL6GIpneXFiBpdrSOrYUvVbgVWRtPQDGRX4OFtTQDMA==
X-Received: by 2002:a17:90b:1d03:b0:320:fda8:fabe with SMTP id
 98e67ed59e1d1-328156ba3b0mr1365474a91.22.1756532509081; 
 Fri, 29 Aug 2025 22:41:49 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:41:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 05/84] target/arm: Add in_prot_check to S1Translate
Date: Sat, 30 Aug 2025 15:40:09 +1000
Message-ID: <20250830054128.448363-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
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

Separate the access_type from the protection check.
Save the trouble of modifying all helper functions
by passing the new data in the control structure.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9652f40ff8..d37c0ce0f1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -64,6 +64,12 @@ typedef struct S1Translate {
      * Stage 2 is indicated by in_mmu_idx set to ARMMMUIdx_Stage2{,_S}.
      */
     bool in_s1_is_el0;
+    /*
+     * The set of PAGE_* bits to be use in the permission check.
+     * This is normally directly related to the access_type, but
+     * may be suppressed for debug or AT insns.
+     */
+    uint8_t in_prot_check;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -581,6 +587,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
             .in_space = s2_space,
             .in_debug = true,
+            .in_prot_check = PAGE_READ,
         };
         GetPhysAddrResult s2 = { };
 
@@ -1089,7 +1096,7 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
     }
     result->f.prot = ap_to_rw_prot(env, ptw->in_mmu_idx, ap, domain_prot);
     result->f.prot |= result->f.prot ? PAGE_EXEC : 0;
-    if (!(result->f.prot & (1 << access_type))) {
+    if (ptw->in_prot_check & ~result->f.prot) {
         /* Access permission fault.  */
         fi->type = ARMFault_Permission;
         goto do_fault;
@@ -1243,7 +1250,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
 
         result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw,
                                     xn, pxn, result->f.attrs.space, out_space);
-        if (!(result->f.prot & (1 << access_type))) {
+        if (ptw->in_prot_check & ~result->f.prot) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
             goto do_fault;
@@ -2123,7 +2130,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (!(result->f.prot & (1 << access_type))) {
+    if (ptw->in_prot_check & ~result->f.prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -2537,7 +2544,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    return !(result->f.prot & (1 << access_type));
+    return (ptw->in_prot_check & ~result->f.prot) != 0;
 }
 
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -2953,7 +2960,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+    ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
@@ -3625,6 +3632,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
+        .in_prot_check = 1 << access_type,
     };
 
     return get_phys_addr_gpc(env, &ptw, address, access_type,
@@ -3638,6 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_prot_check = PAGE_READ,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


