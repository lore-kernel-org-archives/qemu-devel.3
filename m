Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA346C44516
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 23:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkru1-0001cx-PK; Fri, 17 Jul 2026 19:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkru0-0001bS-3A
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wkrty-00072H-18
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 19:23:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-381b831d535so5699752a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 16:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784330608; x=1784935408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4HeBVv7zNWopmwOur9m+FBODN8PMLRBceVz2vLyib0k=;
 b=rAcE1KjUTktf0GpAyE1cGpDS4VHF/PS5mGuNAzv5ByexgYtmikJFKqPXbNJzR4RvjT
 ThPpSE8FcvWJf1o7FXZL0S7VvtFZFTrMkrr+DNDbuOOqxoRcqb1B4jWiTMOOCgxVfpDm
 Iz7Gn4RJWfG3ujyCR/3sgdXt+BosJ7gj9p0LGSUDtwsAifpIXbYshgnv8MN+7rJ8QYM5
 18aEFe16vb+BsOBwAwDWjaLambPVfiAt3t/3y11AMamO+3+4zsPfTCJOkpoIEfWDA4/H
 7AZL82INtJZL+EZ+TkDVqbwRX1BOrd/5ZU+hOaY4fU/8Zfgj9+Sa4nuDRghP+Yk7f7zO
 8I5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784330608; x=1784935408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4HeBVv7zNWopmwOur9m+FBODN8PMLRBceVz2vLyib0k=;
 b=AoMS1FYuML/8N4Si+toO9xEFaU4S2s+5CixhVLUPTB6p8c8uHG90Qj/49LdidIssp+
 R+qzecFGirUknmZu5C9W2qu0fEbdpp6Gtq2tyxmFs7YGr3PLco0mMbZoIUroMqJngmlk
 nNmYDEOlEL/oYffO0naj2Z9RgUf9mUJiCytKVuX35vNR8+pURGEyWVxKQ4xWg9q7Hx6m
 J8Q3nbQQDSKLe/fu0bNTx8RWTd2yFz3v+W6BHKbrK4Ivoumd5ZHlBOIaqhbkfI+YEuod
 TrvI4bu2DVIcz7bJrS9lvAsR9msM1018Ub3S1O0Jiz2OKeG8JZhoWbuYRLsRGhf4Eu6l
 jUig==
X-Gm-Message-State: AOJu0Yx9UWWlblk4NrhRlMOrPkC++3LrJAqXyRpbCho1EV5Vf9lg3QgG
 pLjtu1f+iz4n30utyIRLWbW0FjIi37d8FOxB7+9mwOLOnKIbXkken4BXqJV/chI41HzqoIn2G/X
 /KrhE
X-Gm-Gg: AfdE7cm8aeKq4/Ur1YF5sfVdVFBDkn8DOK1dGpvH8Oa3hDHoGi98c6XyCnZ5BCjuRN0
 NJBDbwUOXx29KO5OuEBdno5F9QKdrYfPvg9vwthx/mztwxNXbmYAh1CFBbO/27TqM2+kIfnk+mz
 tuqy7n9/RyMLnW9Y66l8YvE+uUV2o4dlJPf9JncIvBHOoySmcHcRjygg7oae9WjQg8eUCtdIczL
 J7ZTonkca9Ta5KAnG0Su7iRP+nT726O/GYf/pF01MzKnNYwADWb5FV5AGTmRV5Utzyfuz2NKhGz
 3WHGk3xNAYAHazSN0EXqBIgVkpdgr8TabhYIa4hafXF33365obDsA1MH+tcSRZ6juun9iLWiMFX
 AOzaDGPHxXiMBVoe5oAloHTDyCEaGY7af+0N1PLNRIR6/0az7EN4aaRuUHehqaHG9gAS0ylmQiP
 GD9xT0S50=
X-Received: by 2002:a17:90b:3f85:b0:38d:dbc7:5178 with SMTP id
 98e67ed59e1d1-38e4b54610fmr5035493a91.22.1784330607940; 
 Fri, 17 Jul 2026 16:23:27 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2a18a47sm8186261c88.8.2026.07.17.16.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 16:23:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/17] target/arm: Pass MTEDESC to helper_dc_zva
Date: Fri, 17 Jul 2026 16:23:03 -0700
Message-ID: <20260717232306.378988-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717232306.378988-1-richard.henderson@linaro.org>
References: <20260717232306.378988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Passing the mmu_idx and dcz blocksize in the descriptor is helpful,
as is unifying the helper interface with other DC insns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h |  2 +-
 target/arm/tcg/mte_helper.c      |  6 +++---
 target/arm/tcg/translate-a64.c   | 21 ++++++++++++---------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 0e56e00f45..ac8f460ffb 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -80,7 +80,7 @@ DEF_HELPER_3(vfp_ah_maxh, f16, f16, f16, fpst)
 DEF_HELPER_3(vfp_ah_maxs, f32, f32, f32, fpst)
 DEF_HELPER_3(vfp_ah_maxd, f64, f64, f64, fpst)
 
-DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_3(dc_zva, TCG_CALL_NO_WG, void, env, i64, i32)
 
 DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 6e1f701c4c..4fa6066cbc 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1117,11 +1117,11 @@ static void do_dczva_0(CPUARMState *env, vaddr addr, size_t len, void *mem,
     clear_helper_retaddr();
 }
 
-void HELPER(dc_zva)(CPUARMState *env, uint64_t addr)
+void HELPER(dc_zva)(CPUARMState *env, uint64_t addr, uint32_t desc)
 {
     uintptr_t ra = GETPC();
-    size_t len = (size_t)4 << get_dczid_bs(env_archcpu(env));
-    int mmu_idx = arm_env_mmu_index(env);
+    size_t len = FIELD_EX32(desc, MTEDESC, SIZEM1) + 1;
+    int mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
     MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     int flags;
     void *mem;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 24a0cd8345..c3ff46989a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3137,14 +3137,16 @@ static void handle_sys(DisasContext *s, bool isread,
     }
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        if (s->mte_active[0]) {
-            tcg_rt = tcg_temp_new_i64();
-            gen_helper_mte_check_zva(tcg_rt, tcg_env, gen_mtedesc_zva(s),
-                                     cpu_reg(s, rt));
-        } else {
-            tcg_rt = cpu_reg(s, rt);
+        {
+            TCGv_i32 desc = gen_mtedesc_zva(s);
+            if (s->mte_active[0]) {
+                tcg_rt = tcg_temp_new_i64();
+                gen_helper_mte_check_zva(tcg_rt, tcg_env, desc, cpu_reg(s, rt));
+            } else {
+                tcg_rt = cpu_reg(s, rt);
+            }
+            gen_helper_dc_zva(tcg_env, tcg_rt, desc);
         }
-        gen_helper_dc_zva(tcg_env, tcg_rt);
         return;
     case ARM_CP_DC_GVA:
         {
@@ -3170,11 +3172,12 @@ static void handle_sys(DisasContext *s, bool isread,
     case ARM_CP_DC_GZVA:
         {
             TCGv_i64 clean_addr, tag;
+            TCGv_i32 desc = gen_mtedesc_zva(s);
 
             /* For DC_GZVA, we can rely on DC_ZVA for the proper fault. */
             tcg_rt = cpu_reg(s, rt);
             clean_addr = clean_data_tbi(s, tcg_rt);
-            gen_helper_dc_zva(tcg_env, clean_addr);
+            gen_helper_dc_zva(tcg_env, clean_addr, desc);
 
             if (s->ata[0]) {
                 /* Extract the tag from the register to match STZGM.  */
@@ -4788,7 +4791,7 @@ static bool trans_STZGM(DisasContext *s, arg_ldst_tag *a)
      * except the alignment happens before the access.
      */
     tcg_gen_andi_i64(addr, addr, -s->dcz_blocksize);
-    gen_helper_dc_zva(tcg_env, addr);
+    gen_helper_dc_zva(tcg_env, addr, gen_mtedesc_zva(s));
     return true;
 }
 
-- 
2.43.0


