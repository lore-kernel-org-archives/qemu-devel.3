Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31249C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksr-000202-G1; Sun, 27 Sep 2026 05:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrX-0002Iq-Cr
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:08:00 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrV-0008Hp-L9
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:59 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4d04d740cso719656a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500076; x=1791104876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NBid/Df+8xwSnPdPiDTf6owCVQi+vyqpZvS/U0w4JtM=;
 b=Tthh2iUVuTGvtvzX9YkFp5dAoLf4md04Ie3QmoF4l0gizzywbTMYhLD3wDX5dIzrzu
 Fx2oZdkEPSlW+DkUEaiiK0Bh4M9XVsohoXOUo8MfdirVhG7IMlZJ5NPYEKcGlnZCQVAP
 l5E2FL36WC5pAWNy2OC2hFMgzAsyg6ATPnVo9LJH7yWGa4ZczRwrkFkzoBsFnHFfQTZS
 EhjTqgJs7oTngv12FZ5arp6x80gI7ui8e65FyJNt0ehc4MGMWMDwHzeDH0qMbFkgIkM3
 3y0GF7YugP8FsdNCI/2BWTX/ryeVaTtLVTdunyh50CQgrYwZ3fdUU9nVCer1fQjJ7lcW
 noQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500076; x=1791104876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NBid/Df+8xwSnPdPiDTf6owCVQi+vyqpZvS/U0w4JtM=;
 b=eW2Iti2m2r3A7E4l2C5zdHpmv2mbjHU0oFGlmIsl+aKytlrgWmr2z27ugythjwE6ah
 zKFJKQXYdfLWMlIYHew9Ti6p1m8d5KeY3wlltnt9WTSHelenk84bbC21+hhEsHI7y4XV
 LjWxX/kZ7U9CaS1NUnkkxvhPzBChnNxIn3ZFsztwrTSVrbCmut/OaqSFkXsDwGWHofk7
 ICptYlI7r2Yq2n9UwlBojf0CuNjvzblM4B76na4YKGZ6WoBH5HvYaoq4yb7pdNI6E2Gl
 eLpT3J+Lm3h7OIA75oS473oSjVGoltkCRF9dXPg1fsdKVol3Val3a6K4ctoKzD7eAVof
 2kSg==
X-Gm-Message-State: AFq9FYJNwJUV/ARiBiB2eHL8ovtmbdzwJLFi54Kr8XdSc3eEnT4187ih
 62dXNPeT9yBzcYv6wGm7r60iF8hFgASAEIGxNeZd6PM40SCtGlxvpAbG95tVLnKnjPsqSsD0/wY
 7jRbg
X-Gm-Gg: AYBFou2eBpYwGf47l5yQslwP0JvPCVsepWAFUPMKyEl7o/9UAIncSwPkJYXD2gbiLaB
 Te4WqD7wj0S2VvpyzkFy9NTyQGWOLoSAaAMXU5kogS151kDNvwM3fOLW67flREZCQug2hHgEIeL
 0kwXQkDMtiX1wpH5J41fOIJx5PisuCM0UzMgtFxDUHIUOqKyhzlTDxifcQJJbJFkuJR6x+Vyl0H
 cGm7eGavU1oBe1HYXY6rAlhsgZqe+AYLgFfwmbxW8kQn6QyS/tloB8lq/zeuJxmf5BPZQjf8dmF
 yvhEYXC/h1nErAyNtkmWHC03EXuKzFMc25pZtKO3JU4HhV617NtrNxaKmKkZa5EFvvABI/qdvBe
 2cpdSqz4klqYx4GJ8WQE6brb4v2ZqLk4sOeoYBkdWvB4zHX2/U/K0sDK3lUvNIU2kjDtA0Nfe1W
 sl4q1stWoimoIAm3yJV1YEkRgLqI4y/TVWfDyXDkzpwwb9rKIfGXhG550BCdJON0NYcVsuycic1
 UzJpon6G4WSsCGsohRNpBs8xKXuhg==
X-Received: by 2002:a17:90b:2e0c:b0:3a0:be99:27f7 with SMTP id
 98e67ed59e1d1-3a0be9929c0mr5525820a91.7.1790500076009; 
 Sun, 27 Sep 2026 02:07:56 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 093/101] tcg: Generic expansion of tcg_gen_st_*
Date: Sun, 27 Sep 2026 02:00:03 -0700
Message-ID: <20260927090011.10724-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 +++++-----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a2786b8bd55..6c10f15167d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
@@ -166,7 +165,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 98a07a70f09..514967f91db 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -70,6 +70,7 @@ DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
+DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 647c7d1308b..20622be3daf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1254,6 +1254,11 @@ void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_st(TCGType type, TCGTemp *dst, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st, type, dst, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1415,12 +1420,6 @@ void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
-}
-
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1448,11 +1447,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


