Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3A5C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkEv-00025s-99; Sun, 04 Feb 2024 16:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEs-00024K-KG
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkEq-0003WN-T2
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:22 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d94323d547so29784445ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082879; x=1707687679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUVZCd5J0t9hl0sHMhDVNqIs8ATVsECXvY1CwvamRqY=;
 b=Jo/CuqwTtE9S1/udy1TBfhqSLavhhGzNiUYSCcOeskTUDbqBopOct+z26jo5sNQ/l0
 eJdgY5nmrUmrnlO80DpZrhFmOBSjLiEN5tjuLJN5vzIRgaLR7AIku37a3F1vD4F/ngr9
 T+aCF9DNafID1MUuEeiElKwc+meWVH+R339SMCx6XgUJw49U8AFVCb6mwhb67W6WGGEl
 aCoi2uCZ58ACJvzxASni5nfD1wiG4lUZcrrqWe+LfYozElVq7+QjxnI0SriG0CStvTDy
 J/UQ3r3DU/3YD5CXkvAPHVwepAqVDm6TUkp/8D+VTasct0AYMMn7UEPp4BPggtZV4RtA
 W0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082879; x=1707687679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUVZCd5J0t9hl0sHMhDVNqIs8ATVsECXvY1CwvamRqY=;
 b=WPIccwbxiwVrHU9ja956wIeuIMHydM+1eWzGIyUPc1WNy9H8QeU6hNDLH6nfGH5Zsc
 992cUKoOtHgxj8u08PywZH6ciXY7pl0/ltuu8UAkCiJjZYPL9CDR8e5VkBtum8+oFpn+
 KJ/GbksZYVoOJv7L9ke5jLwYCrwg28CdBbxAhkL9C12ADPpZ6AXn2R30YFbjSbyRR4Rr
 5jr/7JgVN3lb+oQxvV4MuP9Iv3aekb8RUklwZFPq95rSt0vO1IDJdAKXndEnelZxD5FP
 OMk1mRP6RcXU7v01mgX+CBtCk11688AsVWAqtgVAvlQ6PWonFIoeTMAUBDTL2atRtFx8
 d82Q==
X-Gm-Message-State: AOJu0YzQn9I6P1AP0XdxiUvf2WZkPM1wp9UJc8TuZbqMwYmsPIviVkvf
 C5a7SrRMiJMmrOnTev3asCUtsiDlbE6GoOUeUiWWPdJq1y9sySsnDiVkUDX9R0ij6wjGQ7JR2Ae
 iswU=
X-Google-Smtp-Source: AGHT+IEtTF+RBXZ0xv0ufXywQLBc3P4XfL22MXyNzfeKftmG5KPl/9gUssFfzii8miaSRQLDiUnrnw==
X-Received: by 2002:a17:902:e804:b0:1d9:bd8d:d81e with SMTP id
 u4-20020a170902e80400b001d9bd8dd81emr353954plg.47.1707082879566; 
 Sun, 04 Feb 2024 13:41:19 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/39] target/alpha: Use TCG_COND_TSTNE for gen_fold_mzero
Date: Mon,  5 Feb 2024 07:40:24 +1000
Message-Id: <20240204214052.5639-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 49 +++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 220eda2137..882cf6cea0 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -490,56 +490,53 @@ static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
 
 /* Fold -0.0 for comparison with COND.  */
 
-static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
+static TCGv_i64 gen_fold_mzero(TCGCond *pcond, uint64_t *pimm, TCGv_i64 src)
 {
-    uint64_t mzero = 1ull << 63;
+    TCGv_i64 tmp;
 
-    switch (cond) {
+    *pimm = 0;
+    switch (*pcond) {
     case TCG_COND_LE:
     case TCG_COND_GT:
         /* For <= or >, the -0.0 value directly compares the way we want.  */
-        tcg_gen_mov_i64(dest, src);
-        break;
+        return src;
 
     case TCG_COND_EQ:
     case TCG_COND_NE:
-        /* For == or !=, we can simply mask off the sign bit and compare.  */
-        tcg_gen_andi_i64(dest, src, mzero - 1);
-        break;
+        /* For == or !=, we can compare without the sign bit. */
+        *pcond = *pcond == TCG_COND_EQ ? TCG_COND_TSTEQ : TCG_COND_TSTNE;
+        *pimm = INT64_MAX;
+        return src;
 
     case TCG_COND_GE:
     case TCG_COND_LT:
         /* For >= or <, map -0.0 to +0.0. */
-        tcg_gen_movcond_i64(TCG_COND_NE, dest, src, tcg_constant_i64(mzero),
-                            src, tcg_constant_i64(0));
-        break;
+        tmp = tcg_temp_new_i64();
+        tcg_gen_movcond_i64(TCG_COND_EQ, tmp,
+                            src, tcg_constant_i64(INT64_MIN),
+                            tcg_constant_i64(0), src);
+        return tmp;
 
     default:
-        abort();
+        g_assert_not_reached();
     }
 }
 
 static DisasJumpType gen_fbcond(DisasContext *ctx, TCGCond cond, int ra,
                                 int32_t disp)
 {
-    TCGv cmp_tmp = tcg_temp_new();
-    DisasJumpType ret;
-
-    gen_fold_mzero(cond, cmp_tmp, load_fpr(ctx, ra));
-    ret = gen_bcond_internal(ctx, cond, cmp_tmp, 0, disp);
-    return ret;
+    uint64_t imm;
+    TCGv_i64 tmp = gen_fold_mzero(&cond, &imm, load_fpr(ctx, ra));
+    return gen_bcond_internal(ctx, cond, tmp, imm, disp);
 }
 
 static void gen_fcmov(DisasContext *ctx, TCGCond cond, int ra, int rb, int rc)
 {
-    TCGv_i64 va, vb, z;
-
-    z = load_zero(ctx);
-    vb = load_fpr(ctx, rb);
-    va = tcg_temp_new();
-    gen_fold_mzero(cond, va, load_fpr(ctx, ra));
-
-    tcg_gen_movcond_i64(cond, dest_fpr(ctx, rc), va, z, vb, load_fpr(ctx, rc));
+    uint64_t imm;
+    TCGv_i64 tmp = gen_fold_mzero(&cond, &imm, load_fpr(ctx, ra));
+    tcg_gen_movcond_i64(cond, dest_fpr(ctx, rc),
+                        tmp, tcg_constant_i64(imm),
+                        load_fpr(ctx, rb), load_fpr(ctx, rc));
 }
 
 #define QUAL_RM_N       0x080   /* Round mode nearest even */
-- 
2.34.1


