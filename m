Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636A5C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 21:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYsyC-0007EP-BP; Mon, 07 Jul 2025 17:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL7-0005Gf-M2
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:29 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uYsL4-0004Ga-Ih
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 16:21:25 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4a58ba6c945so50480551cf.2
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751919680; x=1752524480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkrYVJIhusUBoORiuozvI3ByiW8Rp/qSiQ54lRxVHfA=;
 b=IAzJAOLPs4/9R8k+e4BqNLW4575fbW42tMiIvhmx2UEdn/ReeduOI+E1QJAS68laEe
 qf1iQ0IA7N7NlazvSPMwSCZoqQjp4MWhuScGru526m538vI/r+x1y2yYOcx57NYvwCN+
 t0ulF591aerA4atcK4KqI9zkiJSVijnKw+PGCO1dcPQcfgkgtW2WnSgptfw0vi0Re/Tp
 0sKTsaeTuaaz4K1kj5pQVHnp7o+pLF49E1y3knIpgabCrKLHjq6J7nXy2IrS7g86RNdv
 APYYQ2+hJDQTCc8ivDRXBUk6r/N144N0t1/Zmqqod3ZXb3XhVHVHvr9jicceRUmzjnK9
 WkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751919680; x=1752524480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkrYVJIhusUBoORiuozvI3ByiW8Rp/qSiQ54lRxVHfA=;
 b=jPnxyO5aGZcpZ6KJuWdXk7PW4d9seFCEqcJ16hzqDWCmoccWm1INn5XTilahKk/4Mp
 /jal/vChO3v3mbwjJqrR9poGZidj3WivENnVtaTpUWBcIBt8Vjb8mpclvLGjOMEkLCN6
 b8+hP6HjmGd1ZRC9jwaYpqPB9VohOI+utP+w0kZux1W8qsJMm7AES7T6k3UQIwkkjJXN
 89tWZRR2tcfh9s0NTJwy2KLmuXXF68CQcHVOlJDAomE9mHfSqwsObEOed42Wkb9hSXKt
 JLJWBWV4ZcPuU+YNOsnYU17tKXGjsVvdLLPfNww3xlMWZocZDYBS2PVuiv8VJnaL8VbT
 Km/Q==
X-Gm-Message-State: AOJu0YxYdUkQ7oW9QZmh/ISS7uDJeRGrg06xVWby16H8l4m8HB6JFkq3
 OaYNackmHDFZ4ntwd06c+ouxJPO3k1aanqP4zEdp3H5H6nHrGR+rVDU3VG+049ReNP0VBc1Bqu3
 p1qay0N4=
X-Gm-Gg: ASbGncvyhZjGNkBdSR6LY1GPprHWoE4rB09QWBnjW60MtgetaBafL7nWpSv2XvONym3
 1qU20P07Z8zlChesQBMh3oHImBfr9tC/shVKAP5nNmt2WHNL+3zSwQK+0tcYM3v9jM/aplO6M+h
 rIG9FOb2m88mbhsDlS+bEYvJPm7nQddG5Ap52A7JMxSxGrlXvKQ9JmdkSR6h+psz6i7VNM2w6xr
 z4wOH7Jbski6zSqbuYFyxyw/8rUVtE8Rbq7C6LA+03WXL51YTKkVkJQo0P/B4C7CEQ90VWcnwu2
 fENClsb7y9W73vvJFlsq7yp07PRMWHWDfbXbF+69Wo1+OGLIk4R75Iy7ecARtj/vztay8/g04Bi
 /5tLSbUDVI3qQRqQK
X-Google-Smtp-Source: AGHT+IF0lew89TWHIdMr7nGTxlDU5q5tIU2Ocw6p11uz3XLTtxiPTN3mdlehWI3a4YWynYwyVcw6Tg==
X-Received: by 2002:a05:622a:138c:b0:4a6:f3f7:4c28 with SMTP id
 d75a77b69052e-4a9964e3befmr218711521cf.17.1751919679932; 
 Mon, 07 Jul 2025 13:21:19 -0700 (PDT)
Received: from stoup.. ([172.58.142.143]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a78dd4sm69050351cf.51.2025.07.07.13.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 13:21:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 03/20] target/arm: Convert get_phys_addr_lpae to access_perm
Date: Mon,  7 Jul 2025 14:20:54 -0600
Message-ID: <20250707202111.293787-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707202111.293787-1-richard.henderson@linaro.org>
References: <20250707202111.293787-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 39ecc093a5..7503d1de6f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1643,14 +1643,14 @@ static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
  * @env: CPUARMState
  * @ptw: Current and next stage parameters for the walk.
  * @address: virtual address to get physical address for
- * @access_type: MMU_DATA_LOAD, MMU_DATA_STORE or MMU_INST_FETCH
+ * @access_perm: PAGE_{READ, WRITE, EXEC}, or 0
  * @memop: memory operation feeding this access, or 0 for none
  * @result: set on translation success,
  * @fi: set to fault info if the translation fails
  */
 static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                uint64_t address,
-                               MMUAccessType access_type, MemOp memop,
+                               unsigned access_perm, MemOp memop,
                                GetPhysAddrResult *result, ARMMMUFaultInfo *fi)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -1678,7 +1678,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         int ps;
 
         param = aa64_va_parameters(env, address, mmu_idx,
-                                   access_type != MMU_INST_FETCH,
+                                   !(access_perm & PAGE_EXEC),
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
@@ -1945,7 +1945,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
          */
         if (param.hd
             && extract64(descriptor, 51, 1)  /* DBM */
-            && access_type == MMU_DATA_STORE) {
+            && (access_perm & PAGE_WRITE)) {
             if (regime_is_stage2(mmu_idx)) {
                 new_descriptor |= 1ull << 7;    /* set S2AP[1] */
             } else {
@@ -2123,7 +2123,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (!(result->f.prot & (1 << access_type))) {
+    if (access_perm & ~result->f.prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -3509,7 +3509,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return get_phys_addr_lpae(env, ptw, address, access_type,
+        return get_phys_addr_lpae(env, ptw, address, 1 << access_type,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-- 
2.43.0


