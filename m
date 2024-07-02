Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2FEC30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 23:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOnDT-00027r-0q; Tue, 02 Jul 2024 19:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDM-00024A-0t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOnDH-0007Ve-R4
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 19:47:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f480624d10so35859575ad.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719964024; x=1720568824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/97R44ZbYpqM6mlWBYqM01l2PIY00KEtifrsfqW+GKQ=;
 b=CGTPgF5wS+7fi+FJHFUwrDMqA+qz1O3aqs7f77LZ5Kl3h6YgS1NKZsQ1iObrxKftHU
 5QnfflqFc/tNA2A4XmcPzy566ZOFTxt13Vy16cCk2vrnLF/E/KgWXJnFTBBWQYLj9Hdm
 /6A5Jy/66f3dm7PNpVRSSA0pvN9WLtCvYZ8/agHWjMyQ2Ti2FdTcovuqzQHNin3+Ke+6
 lptUno2PhZsvNQAsyM9pTmEKG34sxA32xjEaepwDRau2fhM8GeTehuWwGaMk7XtEJZ24
 lndDCGACC54O/4BZjmY8jbM0LwlDNxmEwlpLM3WrkgdT6wY5WljYPxrB8wFhNsRBVpWq
 IAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719964024; x=1720568824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/97R44ZbYpqM6mlWBYqM01l2PIY00KEtifrsfqW+GKQ=;
 b=O8SkQj9Rf7QHmIjbtrQ8J1zZj1tcTp2eNRYP+LmgIhL/WCEeUzKOOC6NNoF2TRS35e
 YsbrqVz9Cz1M7AqZJZ1Pfm3FfXQOTacsu1jh88ZiQ6EtWAqTISJVGpmeLZZmxGjrh5d2
 00CJJ8KDsdbGDNMT2BBO94JAJlxK/ZFKCqy1iMeH5PYev+QJhSOrVWDIupz7g7ZAYmON
 E4ourzHMp6emlNNCo0g+nft0U8/CNms5Kr6k/HI+8PKE0cidrr+R4Lb5CEY+0VlTX4PG
 FVuV1n5YOABhts6XaW5MzQDsg6kZH5Pg2RktZxgOhi97NecyF1wJUsOH+17W3roI8Biq
 0sbw==
X-Gm-Message-State: AOJu0YyynocKw3vgLV6lKpgJw7Z0ZQaXvjzExgAliWFWJAp6WNipLNjn
 fZUqJZ0LpBRSc++nqBgSy+eIJj24lME7fgtxKRpDj9tdYACNHiC0hln05YzKkUygMiyhHFXjDp/
 P
X-Google-Smtp-Source: AGHT+IFufuMiMgxRMLvXoqmD+17IZMeHkMg9yS55bPQUkNafaHmFejBmPqum/KlUphQ1Et2G6XAJoA==
X-Received: by 2002:a17:903:191:b0:1f9:aa05:878f with SMTP id
 d9443c01a7336-1fadbb4c3e7mr98720645ad.0.1719964023964; 
 Tue, 02 Jul 2024 16:47:03 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1535e62sm90147045ad.154.2024.07.02.16.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 16:47:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH 3/4] target/ppc: Split out helper_dbczl for 970
Date: Tue,  2 Jul 2024 16:46:58 -0700
Message-Id: <20240702234659.2106870-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702234659.2106870-1-richard.henderson@linaro.org>
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

We can determine at translation time whether the insn is or
is not dbczl.  We must retain a runtime check against the
HID5 register, but we can move that to a separate function
that never affects other ppc models.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h     |  7 +++++--
 target/ppc/mem_helper.c | 34 +++++++++++++++++++++-------------
 target/ppc/translate.c  | 24 ++++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 76b8f25c77..afc56855ff 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -46,8 +46,11 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
 DEF_HELPER_4(lsw, void, env, tl, i32, i32)
 DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
 DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
-DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
-DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
+DEF_HELPER_FLAGS_2(dcbz, TCG_CALL_NO_WG, void, env, tl)
+DEF_HELPER_FLAGS_2(dcbzep, TCG_CALL_NO_WG, void, env, tl)
+#ifdef TARGET_PPC64
+DEF_HELPER_FLAGS_2(dcbzl, TCG_CALL_NO_WG, void, env, tl)
+#endif
 DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_FLAGS_2(icbiep, TCG_CALL_NO_WG, void, env, tl)
 DEF_HELPER_5(lscbx, tl, env, tl, i32, i32, i32)
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index 5067919ff8..d4957efd6e 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -296,26 +296,34 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     }
 }
 
-void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbz(CPUPPCState *env, target_ulong addr)
 {
-    int dcbz_size = env->dcache_line_size;
-
-#if defined(TARGET_PPC64)
-    /* Check for dcbz vs dcbzl on 970 */
-    if (env->excp_model == POWERPC_EXCP_970 &&
-        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
-        dcbz_size = 32;
-    }
-#endif
-
-    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+    dcbz_common(env, addr, env->dcache_line_size,
+                ppc_env_mmu_index(env, false), GETPC());
 }
 
-void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
+void helper_dcbzep(CPUPPCState *env, target_ulong addr)
 {
     dcbz_common(env, addr, env->dcache_line_size, PPC_TLB_EPID_STORE, GETPC());
 }
 
+#ifdef TARGET_PPC64
+void helper_dcbzl(CPUPPCState *env, target_ulong addr)
+{
+    int dcbz_size = env->dcache_line_size;
+
+    /*
+     * The translator checked for POWERPC_EXCP_970.
+     * All that's left is to check HID5.
+     */
+    if (((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
+        dcbz_size = 32;
+    }
+
+    dcbz_common(env, addr, dcbz_size, ppc_env_mmu_index(env, false), GETPC());
+}
+#endif
+
 void helper_icbi(CPUPPCState *env, target_ulong addr)
 {
     addr &= ~(env->dcache_line_size - 1);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 0bc16d7251..2664c94522 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -200,6 +200,7 @@ struct DisasContext {
     uint32_t flags;
     uint64_t insns_flags;
     uint64_t insns_flags2;
+    powerpc_excp_t excp_model;
 };
 
 #define DISAS_EXIT         DISAS_TARGET_0  /* exit to main loop, pc updated */
@@ -4445,27 +4446,29 @@ static void gen_dcblc(DisasContext *ctx)
 /* dcbz */
 static void gen_dcbz(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
+
+#ifdef TARGET_PPC64
+    if (ctx->excp_model == POWERPC_EXCP_970 && !(ctx->opcode & 0x00200000)) {
+        gen_helper_dcbzl(tcg_env, tcgv_addr);
+        return;
+    }
+#endif
+
+    gen_helper_dcbz(tcg_env, tcgv_addr);
 }
 
 /* dcbzep */
 static void gen_dcbzep(DisasContext *ctx)
 {
-    TCGv tcgv_addr;
-    TCGv_i32 tcgv_op;
+    TCGv tcgv_addr = tcg_temp_new();
 
     gen_set_access_type(ctx, ACCESS_CACHE);
-    tcgv_addr = tcg_temp_new();
-    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
     gen_addr_reg_index(ctx, tcgv_addr);
-    gen_helper_dcbzep(tcg_env, tcgv_addr, tcgv_op);
+    gen_helper_dcbzep(tcg_env, tcgv_addr);
 }
 
 /* dst / dstt */
@@ -6480,6 +6483,7 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->hv = (hflags >> HFLAGS_HV) & 1;
     ctx->insns_flags = env->insns_flags;
     ctx->insns_flags2 = env->insns_flags2;
+    ctx->excp_model = env->excp_model;
     ctx->access_type = -1;
     ctx->need_access_type = !mmu_is_64bit(env->mmu_model);
     ctx->le_mode = (hflags >> HFLAGS_LE) & 1;
-- 
2.34.1


