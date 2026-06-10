Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F708CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXv-0008LJ-ID; Wed, 10 Jun 2026 12:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXR-0007fB-HK
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXP-0005U9-Fk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490b915ded5so61340185e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107938; x=1781712738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K+F6PgnA5j+iTjiRAUodyt/0uyyZ76nvV2j5nGbqtDc=;
 b=fu4XM0ma3NBLU6dLwrR6UqdgP47TSkineaUO3WRY8LuR2ZIUfBOiCbGQFB7LZVF9sZ
 rohgzLokMLNwrWJWrvxHCoz7CMG/RGJ1FheK+s0DDVSleoO8h0j1xNuZ6FQ8sb7GjBSX
 Hp1CmnscG6fZJ1RbbbHvoQq42vi2LKmneQ38vWFWOJBuvquFblpwWafcbXO39NVURQ/O
 ZNpp9DH9iZChlGZD9m9BgrbUvN6MKi8kVY2EEKbQ1yRQZ/auJKpUmU/UkK+bIud94TTQ
 Mkb2zkr4tOyrE9mZ/fv3x8g/bqRSvPNC+ddfhVTtE9o5W7ctZMoK6PuGMBVdkVvSD8Vm
 fl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107938; x=1781712738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K+F6PgnA5j+iTjiRAUodyt/0uyyZ76nvV2j5nGbqtDc=;
 b=EFWOxFnPFh4fJ/BEqAQr4fIAjxoiXNwW/1x7SGv8VV8616rh09hmrOCjTvl09CGp3F
 9XqR/Kyrd7NSdeqtokk+9vU5JLLYJe7Ztkf3vRRwqHAAj2l/t8DLK4/5JMQfsPZ2dcxE
 TrV8DduVsbc0rcYsjTMyh7UlXp+/Ze+Eyo9uCmzCkYFVycDR0/L/Kl2sWqbmrKHrKSD7
 BdnISRYk1oLhArQieEZokd7zHtMREBxa23zi7Omw9jvGpQSZMY8OnkNtvpKFF6TaJrCv
 mlG6wCErR+lDAgULbUEsaS4KnH0hf4YSBGmYMRfq6PRqa++TjD2/FgtEws0OXjxapVqq
 rGOg==
X-Gm-Message-State: AOJu0YwygHfnmEaPCYT76OaJY6yBt/HNLnkvzFf37UwyePcIFX90Ap6y
 VTJiUW1DuXV92Mj1Dt7fjtcIneTPATkL+wip8XGbM1CHLHKEHMzIIs+BH0DiqnLELM+P0A9hmjx
 s11gK
X-Gm-Gg: Acq92OHxZ+3fBasIhN6dbQlvAa+rtQw0E79VvgcDnHlQTll3aQ25X8NPUYrMniffNJc
 ZV5UEmEnNEuGbNzY2CvaS/JhkjLRUlvMoJv5omMXH63jvt+/BR/OdfOrW/fnsXlL/x9GkN4qBEL
 7+1Iufv5HZiUDSl7sOfpTRg00pvTSK6/0DgesYb5FHtaSPcmtfofjdbXfi9yYqzewacEgAeII7T
 0BSLaS40ewTqEJ+EliL3Ey7bMZV1wAQcKBGfiyBO0nEGUk+g1zAOzx11Uw2wFz6CWFMztLiorbx
 NdMumFw12L0YYwjXhjs5GX+yc+acLvvzx+I5t60bNIdRbZWFagoooBQKyo4PpmGrtA2QTjCarIv
 TUX86VHO0Ov7VZK4mVbwxd3Cl7DkainMrZ1nEGGi85ryBRx0V1edGx+arDkYIZzZy0yqN0PZG12
 oiqnhYsOdbNBCF3hqI0OCDLDTphKmPIFlXtj6RQXYiKfjW2u/62AuRYlR6W3nru6mLZ8fI1yVNB
 csE+WntVafSiWIzMpx6TUfXxUet10ppy/i1HHuyOJqyRJLZRJ843g==
X-Received: by 2002:a05:600c:5010:b0:490:bb20:de64 with SMTP id
 5b1f17b1804b1-490c25b337amr407885505e9.5.1781107938070; 
 Wed, 10 Jun 2026 09:12:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/71] target/arm: load on canonical tag loads ext bits
Date: Wed, 10 Jun 2026 17:11:01 +0100
Message-ID: <20260610161202.2235298-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

Loading tags from canonically tagged regions should use the canonical
tags (extension bits), not allocation tags. See AArch64_MemTagRead().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-9-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64-defs.h |  4 ++--
 target/arm/tcg/mte_helper.c      | 14 ++++++++++++--
 target/arm/tcg/translate-a64.c   |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index cae543a7a1..c268b8c3cc 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -102,14 +102,14 @@ DEF_HELPER_FLAGS_3(mte_check, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(mte_check_zva, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
-DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_4(ldg, TCG_CALL_NO_WG, i64, env, i64, i64, i32)
 DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
-DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_3(ldgm, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index d35e3ef04d..c382f0149f 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -304,7 +304,7 @@ int load_tag1(uint64_t ptr, uint8_t *mem)
     return extract32(*mem, ofs, 4);
 }
 
-uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uint8_t *mem;
@@ -317,6 +317,9 @@ uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
     /* Load if page supports tags. */
     if (mem) {
         rtag = load_tag1(ptr, mem);
+    } else if (mtx) {
+        uint64_t bit55 = extract64(ptr, 55, 1);
+        rtag = 0xF * bit55;
     }
 
     return address_with_allocation_tag(xt, rtag);
@@ -458,7 +461,7 @@ void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
     }
 }
 
-uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
+uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr, uint32_t mtx)
 {
     int mmu_idx = arm_env_mmu_index(env);
     uintptr_t ra = GETPC();
@@ -476,6 +479,13 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
 
     /* The tag is squashed to zero if the page does not support tags.  */
     if (!tag_mem) {
+        /* Load canonical value if mtx is set (untagged memory region) */
+        if (mtx) {
+            bool bit55 = extract64(ptr, 55, 1);
+            ret = extract64(-bit55, 0, 1 << gm_bs);
+            shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
+            return ret << shift;
+        }
         return 0;
     }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b5c9c9c166..c472917f05 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4801,7 +4801,7 @@ static bool trans_LDGM(DisasContext *s, arg_ldst_tag *a)
     tcg_rt = cpu_reg(s, a->rt);
 
     if (s->ata[0]) {
-        gen_helper_ldgm(tcg_rt, tcg_env, addr);
+        gen_helper_ldgm(tcg_rt, tcg_env, addr, tcg_constant_i32(s->mtx));
     } else {
         MMUAccessType acc = MMU_DATA_LOAD;
         int size = 4 << s->gm_blocksize;
@@ -4836,7 +4836,7 @@ static bool trans_LDG(DisasContext *s, arg_ldst_tag *a)
     tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
     tcg_rt = cpu_reg(s, a->rt);
     if (s->ata[0]) {
-        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt);
+        gen_helper_ldg(tcg_rt, tcg_env, addr, tcg_rt, tcg_constant_i32(s->mtx));
     } else {
         /*
          * Tag access disabled: we must check for aborts on the load
-- 
2.43.0


