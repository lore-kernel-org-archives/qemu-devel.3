Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3163BC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhS0-00073X-KS; Fri, 04 Jul 2025 10:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhMA-0004kK-Uf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:45 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM6-0008Bm-II
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:37 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea080f900cso303443fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639133; x=1752243933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uvmVGiggaJVnD3biVZOgKJf/5fGxdVKjkB2gcwvGJfg=;
 b=WVwyLve0llLgLZOICYT1tUrZDl0meSxR4w+XdcesBqDxEpOUcJ5XpcWVSYIgs3BKYn
 54FLnBvNgUKWQD5uAEwvqXN5OZWNLgo9gM8VZslPnJFDIpc/21Dd6bUGIsBTsjOTS5ho
 n/ycnUMgUR2GLXMFnaBIVJ+0wkpQSKerkUoJHjImG4X0e9Q7QvV2sT8ZrlNlRl9xTgdA
 114PT6QeaU3zkwJqgTbLSMpGLfjn/AL+EmCV8Ly9jdDysciDEhBn3M9fCuBIZHPMs6m5
 kzGxeFro0GeKuGYT4Hw4ERjQ8JCn85Y6wmREJ7XrXZTzpHszWajkTuYGkEbalOp4qfqv
 fSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639133; x=1752243933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvmVGiggaJVnD3biVZOgKJf/5fGxdVKjkB2gcwvGJfg=;
 b=KJG3g1Dugkc651IiRFed//BXv/Sfd+pA6Oj0C3PPruLUV7P0CI7vDIwEQfTDzzRNMQ
 Ai11Z3wEIMH1XMufwKOcjOcXovt/uvX0P2N7sSB9E2CtjOZQeSIfMrP//8zI2YP3oPGJ
 soKdpg8yklbyMUPIEOXHwq4V78JN+FSfxQrviZx5YsDtOSXXZ+IT6/z0Asw0ETFNqwVW
 mctX7fTNIVBGJPbXouZdeSAAC7pBpI2B4p1d2wVfTQuWkdlxaL1//Fk9feAVHuScBgPZ
 UonBqxsHvRMDtCr4uuY6I8WIwAoEAo89saX7ki8xhUG0e/BVVF1xBPk9Dezh/teMDDlE
 xoiQ==
X-Gm-Message-State: AOJu0YxKfhNeMI2Uj5z6YNwZYhIa4moG9g19JbMWnm8qr3wHuHMVj54R
 dAaaSfg9G3bw6NRHYwAGhrXt1qHgIMDm5rxYeKopyNAmp2T5FcphNSOSMeOu9B5LDgCqUDVk3+w
 PgqEXkSc=
X-Gm-Gg: ASbGncuA78eY0/EtlUbYYIC1nivAkZWxHzNdefQetFMNjQ7QZu7q5wE9t8oaux0X5fo
 RCL+D+RY8TnkM+WVoPi0TPm3KW8RkV+W49ZTke7FlLgK/Ijiijrz7HZoDws4001eB+UWTy0nOjW
 oGfFjd98LCjaCaXDMR5RefovSNBr7sO3T4Rvse4gTZTkuwDItxa+K2fSJ549VntMFjq57icNkHa
 Avu61fAAIGuxSpo+y1T1boAOXn7lyzt7z7arTxb8JBxlb7GvJdbbsXGUEnt+MGN+HH859jPA8lS
 o+5LPLr8jjIkTY7x2z9fSzFLvON1Bi0qeDxr6FmK2NnruL010AjncwuAVjIsQ9WD7tP13oSwzg0
 mnbR0VLmQ0Lmrg+G73qbfnn2vaQqYs1nnVWcQJFYFMVEgLRChD2ujmxKgMlQ=
X-Google-Smtp-Source: AGHT+IHziEzKqF8l8Xn6X9yuF2pNtBUw/zYC0hPxtSMyeoLZ59jkB0izpUWzug8JVjX4da/ja5Cjag==
X-Received: by 2002:a05:6870:eca2:b0:2c2:5c26:2d8e with SMTP id
 586e51a60fabf-2f791e49cc4mr2343740fac.16.1751639132705; 
 Fri, 04 Jul 2025 07:25:32 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 075/108] target/arm: Move scale by esz into
 helper_sve_while*
Date: Fri,  4 Jul 2025 08:20:38 -0600
Message-ID: <20250704142112.1018902-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Change the API to pass element count rather than bit count.
This will be helpful later for predicate as counter.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    |  2 ++
 target/arm/tcg/translate-sve.c | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 5e11e86e5e..b8f3fbb816 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4133,6 +4133,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
 
+    count <<= esz;
     memset(d, 0, sizeof(*d));
     do_whilel(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, false);
@@ -4165,6 +4166,7 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
 
+    count <<= esz;
     memset(d, 0, sizeof(*d));
     do_whileg(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, true);
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


