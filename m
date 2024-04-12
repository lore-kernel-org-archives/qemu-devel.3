Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842EAC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 02:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv6Rj-0004kV-OZ; Thu, 11 Apr 2024 22:15:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv6Rg-0004ji-Lj
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 22:15:17 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv6Rd-0005Qm-KD
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 22:15:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e411e339b8so3832595ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 19:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712888111; x=1713492911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CWIVZJINHW7JcPiz2/SVDLtJDtIbrdpEhoE0ho2QK1Y=;
 b=CyZmR6jW8ZVUK5zckccnUbJMUu+XHsKeOmGcqptK4V7ioc3jgGH453ZXXs93y8Z1Kf
 QBNuqY09TTeCv7AHpPTcs8MQdjXINb8NTM8z7b0grnURzWynlz4KiGAlAqPl2KaFlUe2
 8F/wZNxTVrHG2ItsJbx7s6k2Tu+C8o4OVGVpTdk5hK9YjdjwdIV9H1EWP8fvPxXqMgby
 S5kfMegzKRhgGFM6BbnUIyb1WWYoAxAbzadSYgRUhdSmeNvwQ/0ZEdd+Zfc3IM+ZGHEA
 Db87fpqwCR+mus1RSa9ngXwIsPWi79suxo9DfEsTCaL++MQsGD2V0eAJa7poXPS2P7lp
 D8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712888111; x=1713492911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CWIVZJINHW7JcPiz2/SVDLtJDtIbrdpEhoE0ho2QK1Y=;
 b=ctu8zD5UneHJlHMr44KSTg6uNHwi9fixGK7SrgqWTUmn8WBJvF3fTvZKxmpnCzy0UD
 oF7hdRyX9ocPxRQzmCRvlehJ4yk08AhBclW3K4w2RqFVEgRLqmGT5eZUw0uYzNP7Ru/1
 Uc2Yg9M+UhK424rAivFkiHtzwzC1ibT2BlQy4SF8Rnjse4enxNokNjebjPQfc3hmUFdH
 yYPSvomybCOOQC6dNhPbKo49CPdGjiMdpg6NRj2m86gY7E80C18InjNoZr06Zs0gsCy3
 5cMMquvv0B08ZPHiu3NQo1lHhOSPyIKhaV3Kznxg8kmR2lW1VEKjJPRfPXIo/RbpzdpM
 UqNQ==
X-Gm-Message-State: AOJu0YyiTibrNf9LdaePbqwEeM6yiKdZo/+cZgC5A37KmZ6sXiCPDh+B
 aW1B4YlIQiSMIOmGqcPUd34hiXGneHobv6GcfD0343rIgu2s6HfXxTCPCnTj3Zbk865UxwTgvQ9
 C
X-Google-Smtp-Source: AGHT+IE2KTgHjzQ5LD5ZZYpLw6GKrMf50e4w/OAUeOhCHoZ4/hwFIOeqbQpb8HPt5M+Jelxl3QlaOw==
X-Received: by 2002:a17:903:22c5:b0:1e2:aa62:2fbf with SMTP id
 y5-20020a17090322c500b001e2aa622fbfmr1452972plg.45.1712888111237; 
 Thu, 11 Apr 2024 19:15:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a170902a50e00b001ddc83fda95sm1852845plq.186.2024.04.11.19.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:15:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bazz@bazz1.com,
	mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH] target/sparc: Use GET_ASI_CODE for ASI_KERNELTXT and
 ASI_USERTXT
Date: Thu, 11 Apr 2024 19:15:09 -0700
Message-Id: <20240412021509.145502-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reads are done with execute access.  It is not clear whether writes
are legal at all -- for now, leave helper_st_asi unchanged, so that
we continue to raise an mmu fault.

This generalizes the exiting code for ASI_KERNELTXT to be usable for
ASI_USERTXT as well, by passing down the MemOpIdx to use.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2281
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2059
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1609
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1166
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h      |  3 ++
 target/sparc/ldst_helper.c | 65 ++++++++++++++++++++++++++------------
 target/sparc/translate.c   | 49 ++++++++++++++++++++++++++--
 3 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index e55fad5b8c..b8087d0d2b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -32,6 +32,9 @@ DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+DEF_HELPER_FLAGS_3(ld_code, TCG_CALL_NO_WG, i64, env, tl, i32)
+#endif
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
 DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e581bb42ac..2846a86cc4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -585,7 +585,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 #if defined(DEBUG_MXCC) || defined(DEBUG_ASI)
     uint32_t last_addr = addr;
 #endif
-    MemOpIdx oi;
 
     do_check_align(env, addr, size - 1, GETPC());
     switch (asi) {
@@ -684,24 +683,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_M_DIAGS:   /* Turbosparc DTLB Diagnostic */
     case ASI_M_IODIAG:  /* Turbosparc IOTLB Diagnostic */
         break;
-    case ASI_KERNELTXT: /* Supervisor code access */
-        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));
-        switch (size) {
-        case 1:
-            ret = cpu_ldb_code_mmu(env, addr, oi, GETPC());
-            break;
-        case 2:
-            ret = cpu_ldw_code_mmu(env, addr, oi, GETPC());
-            break;
-        default:
-        case 4:
-            ret = cpu_ldl_code_mmu(env, addr, oi, GETPC());
-            break;
-        case 8:
-            ret = cpu_ldq_code_mmu(env, addr, oi, GETPC());
-            break;
-        }
-        break;
     case ASI_M_TXTC_TAG:   /* SparcStation 5 I-cache tag */
     case ASI_M_TXTC_DATA:  /* SparcStation 5 I-cache data */
     case ASI_M_DATAC_TAG:  /* SparcStation 5 D-cache tag */
@@ -779,7 +760,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case 0x4c: /* SuperSPARC MMU Breakpoint Action */
         ret = env->mmubpaction;
         break;
-    case ASI_USERTXT: /* User code access, XXX */
     default:
         sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
         ret = 0;
@@ -787,6 +767,8 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
 
     case ASI_USERDATA: /* User data access */
     case ASI_KERNELDATA: /* Supervisor data access */
+    case ASI_USERTXT: /* User code access */
+    case ASI_KERNELTXT: /* Supervisor code access */
     case ASI_P: /* Implicit primary context data access (v9 only?) */
     case ASI_M_BYPASS:    /* MMU passthrough */
     case ASI_LEON_BYPASS: /* LEON MMU passthrough */
@@ -1161,6 +1143,49 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
 #endif
 }
 
+uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
+{
+    MemOp mop = get_memop(oi);
+    uintptr_t ra = GETPC();
+    uint64_t ret;
+
+    switch (mop & MO_SIZE) {
+    case MO_8:
+        ret = cpu_ldb_code_mmu(env, addr, oi, ra);
+        if (mop & MO_SIGN) {
+            ret = (int8_t)ret;
+        }
+        break;
+    case MO_16:
+        ret = cpu_ldw_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap16(ret);
+        }
+        if (mop & MO_SIGN) {
+            ret = (int16_t)ret;
+        }
+        break;
+    case MO_32:
+        ret = cpu_ldl_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap32(ret);
+        }
+        if (mop & MO_SIGN) {
+            ret = (int32_t)ret;
+        }
+        break;
+    case MO_64:
+        ret = cpu_ldq_code_mmu(env, addr, oi, ra);
+        if ((mop & MO_BSWAP) != MO_TE) {
+            ret = bswap64(ret);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret;
+}
+
 #endif /* CONFIG_USER_ONLY */
 #else /* TARGET_SPARC64 */
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 319934d9bd..c9b9b047df 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1117,6 +1117,7 @@ typedef enum {
     GET_ASI_EXCP,
     GET_ASI_DIRECT,
     GET_ASI_DTWINX,
+    GET_ASI_CODE,
     GET_ASI_BLOCK,
     GET_ASI_SHORT,
     GET_ASI_BCOPY,
@@ -1159,14 +1160,22 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
                || (asi == ASI_USERDATA
                    && (dc->def->features & CPU_FEATURE_CASA))) {
         switch (asi) {
-        case ASI_USERDATA:   /* User data access */
+        case ASI_USERDATA:    /* User data access */
             mem_idx = MMU_USER_IDX;
             type = GET_ASI_DIRECT;
             break;
-        case ASI_KERNELDATA: /* Supervisor data access */
+        case ASI_KERNELDATA:  /* Supervisor data access */
             mem_idx = MMU_KERNEL_IDX;
             type = GET_ASI_DIRECT;
             break;
+        case ASI_USERTXT:     /* User text access */
+            mem_idx = MMU_USER_IDX;
+            type = GET_ASI_CODE;
+            break;
+        case ASI_KERNELTXT:   /* Supervisor text access */
+            mem_idx = MMU_KERNEL_IDX;
+            type = GET_ASI_CODE;
+            break;
         case ASI_M_BYPASS:    /* MMU passthrough */
         case ASI_LEON_BYPASS: /* LEON MMU passthrough */
             mem_idx = MMU_PHYS_IDX;
@@ -1379,6 +1388,22 @@ static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     case GET_ASI_DIRECT:
         tcg_gen_qemu_ld_tl(dst, addr, da->mem_idx, da->memop | MO_ALIGN);
         break;
+
+    case GET_ASI_CODE:
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+        {
+            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
+            TCGv_i32 r_oi = tcg_constant_i32(oi);
+            TCGv_i64 t64 = tcg_temp_new_i64();
+
+            gen_helper_ld_code(t64, tcg_env, addr, r_oi);
+            tcg_gen_trunc_i64_tl(dst, t64);
+        }
+        break;
+#else
+        g_assert_not_reached();
+#endif
+
     default:
         {
             TCGv_i32 r_asi = tcg_constant_i32(da->asi);
@@ -1791,6 +1816,26 @@ static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         }
         break;
 
+    case GET_ASI_CODE:
+#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
+        {
+            TCGv_i64 tmp = tcg_temp_new_i64();
+            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
+
+            gen_helper_ld_code(tmp, tcg_env, addr, tcg_constant_i32(oi));
+
+            /* See above.  */
+            if ((da->memop & MO_BSWAP) == MO_TE) {
+                tcg_gen_extr_i64_tl(lo, hi, tmp);
+            } else {
+                tcg_gen_extr_i64_tl(hi, lo, tmp);
+            }
+        }
+        break;
+#else
+        g_assert_not_reached();
+#endif
+
     default:
         /* ??? In theory we've handled all of the ASIs that are valid
            for ldda, and this should raise DAE_invalid_asi.  However,
-- 
2.34.1


