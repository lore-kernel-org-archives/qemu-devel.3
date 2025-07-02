Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21711C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwnv-0001r5-DW; Wed, 02 Jul 2025 08:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwje-0004Td-2I
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:48 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0002BA-W5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:45 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2ea35edc691so1681640fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459915; x=1752064715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v/8hNQy8fFPp5bDwpch38EpRvO2SIx0CPU+DT6r9Io=;
 b=bXq0ZAa8oCZz3vbZtPDhbk8ektzu/8givoHpRpv/SFGMWK85CyhduOPF/4FLF7btwd
 hMvfgma65+30tx0yuDu4WpvNpkc5m1eJBhv+hEj9QR1NRj4y6pwRURtBIN9HYL3dMwo4
 B/3aZ+anJhWZP2l1DZ/1nEEXGEMNGzTHrRiXdXGY05c3/a8pac9z5Nk38no+MCI6kgUX
 zuxtUffqPMHi0uLcqb1DqhCcIEWLD6+jz2Oe7QR44wadS00WyhutyJXO17O9SWZamt4M
 3UFuO8/KKAG85H0oOj6Ibr5syZXziyhlyfsfEH+5tF4UKOkEXYTeUit7cpAxru2lm7p9
 5Vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459915; x=1752064715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6v/8hNQy8fFPp5bDwpch38EpRvO2SIx0CPU+DT6r9Io=;
 b=N5ERv7kK1Sx9iqF06omk4N78BfTaDfQc9Vd6PIENXyPH+2XrXi0XLTg4T7Gc86RcUA
 m1hKKyU73U5Z9eagJbQh5qc+bpFXTP5TLF7TkrA6R0hmxaIWxJ91kSprjgPoWS4G8WDO
 ozXlLfL4OgEQMmHHIH2LCai2hXJ3Uhthmlb3zMeRHCoiKjv9n3DW2pjQpppjwMyTqEUl
 ANw45j7y+lf2RY2feSiDygxafl6lTGcyyJUl0WLdlwyYdQ0tutW8Ec401mLdkwFORAau
 a5A6Nok8/8Bvr5gIlv9HH4+baT+eWqi070Yy3PpAlmsFoeYBiiNfgXixd1CgWqq60FLv
 xkoQ==
X-Gm-Message-State: AOJu0YwJ0RbSzNQ+sc4TLErE/7weLzLBoDpkjLC0ZFNeVz+w1t/6/3zR
 25KSp2fVqs0JyzB4sPWfuk5KLQtyg2GmvSQ3zR8W45+BzMM5RnDpbL/t7f41WdgDdqLCxYGeVX1
 1RbNm2Vs=
X-Gm-Gg: ASbGncsFsgAkjM1sKEDkJJpRfu7yPuLo0xpMaYpIQm2aJfuHrwfHOg7NiRCRrfzMk9V
 DKZLqhycbi85OzoNskysFQ3IvBj3d+FrFV5VVzqh2Iyl2J+tIGKyzy3yr4cWJMc6rTBHr+crN63
 rq31wzGmYfSbj19A6onefrqM1GxvhHtrtoNbb4Jy1tneNwTxNzVQPLSm27/jZyVIGz/FfT82lj9
 jnfQrwNm6ymgxF/IOhjhINkO8tnmmYhsh/+GfgZl10GGwUvw4rYjPlcaZup31yWIGg53HX28zVL
 1hwna2fO5SbWZSkcM5xha8K4vVjI9URmdVb56zI6wPKedHZ2BAW9cgaNNsbZGWDx9Q/NUg==
X-Google-Smtp-Source: AGHT+IGkl21D44Jth5E2OxdM4Kn0uoohFGfIglxI7ATXg08bjDeRoSHmFb4B1TNJ4wJ7rYMyD3hLFA==
X-Received: by 2002:a05:6871:2881:b0:2ef:9aa7:becb with SMTP id
 586e51a60fabf-2f5a8c97853mr2030240fac.18.1751459915006; 
 Wed, 02 Jul 2025 05:38:35 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 64/97] target/arm: Move scale by esz into helper_sve_while*
Date: Wed,  2 Jul 2025 06:33:37 -0600
Message-ID: <20250702123410.761208-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Change the API to pass element count rather than bit count.
This will be helpful later for predicate as counter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    |  2 ++
 target/arm/tcg/translate-sve.c | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ba5ab6b513..dbade6ece0 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4135,6 +4135,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     uint32_t oprbits = oprsz * 8;
     uint64_t esz_mask = pred_esz_masks[esz];
 
+    count <<= esz;
     do_zero(vd, oprsz);
     do_whilel(vd, esz_mask, count, oprbits);
 
@@ -4166,6 +4167,7 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     uint32_t oprbits = oprsz * 8;
     uint64_t esz_mask = pred_esz_masks[esz];
 
+    count <<= esz;
     do_zero(vd, oprsz);
     do_whileg(vd, esz_mask, count, oprbits);
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 210a029ab8..f74f2bb1b3 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3198,9 +3198,6 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, t0);
 
-    /* Scale elements to bits.  */
-    tcg_gen_shli_i32(t2, t2, a->esz);
-
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
 
@@ -3234,7 +3231,7 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     op0 = read_cpu_reg(s, a->rn, 1);
     op1 = read_cpu_reg(s, a->rm, 1);
 
-    tmax = tcg_constant_i64(vsz);
+    tmax = tcg_constant_i64(vsz >> a->esz);
     diff = tcg_temp_new_i64();
 
     if (a->rw) {
@@ -3244,15 +3241,15 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_sub_i64(diff, op0, op1);
         tcg_gen_sub_i64(t1, op1, op0);
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op1 == op0, diff == 0, and the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
     } else {
         /* WHILEWR */
         tcg_gen_sub_i64(diff, op1, op0);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op0 >= op1, diff <= 0, the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
     }
-- 
2.43.0


