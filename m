Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEDC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73lV-0004Zn-K7; Thu, 17 Sep 2026 00:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k6-0003Ck-D3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006nk-Ge
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747ee1f9bso3704165ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619326; x=1790224126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCmOmovegGhUQGzqTd2jYdUvDaEHmn2ZTmtygxSB6Fo=;
 b=meE2sLGS1y74sIFKWDGZI++FB0j6TRVplMjeGnWxiYjGiJZCfbQQ2YCz8LpbdF+M/o
 zbMuboOPw/ULCNFIVtNwyP5bSSC3zLaFRGL54VQq70HG2g0rdmD/o4lxnCfI9RqlQ8hF
 xzva2FYNIHDNcCK20nUcBOoO8CbcRQ6LPqn2aNWWUBYTeh/lxMBrzsXCRfX2fzlBd4Ia
 s3uXwVVxKW0NQwfHSPuP5xzTwLtAKE5jAJtLw3UttDWQ6XGtV5ftwJb4FotX4C6cwkcD
 Wtymx279SBbClK/TqUG/eg1MFlN8jLBD482AfV2eZM+DeifZR+Q67LLly1vsMee1As68
 wNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619326; x=1790224126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uCmOmovegGhUQGzqTd2jYdUvDaEHmn2ZTmtygxSB6Fo=;
 b=LmfEBtvxJXMG80MNBGNgoI4sFdflFvIqO0uhEVItAB3PztDUA6iGbC9qaO2GFaJ3Om
 NonZrddk/L3lLGLyNTPUCdZv2accUUbFVqP3e+FB2rxSwGBA9ejlcWOUZFvikG+3xYzZ
 7ESJY/ESchtrTnOvK0ELZ+WHwvFDC9pJKhUPnznC9USAltuDPcTJ03TDkK7hKCThNPJ5
 OeOVvIX2+i4S0otzDRmASi8zzcBZNZFFtiiHv7fz6Lmp8MvbysrOYLqJgLCHhi6o1ya4
 spYcQui/sYHUzIdgcZJibQ+vvRw8khOH3Q16QwemZrNYZc9hEcEaKjvT9Xl+tJq55y0s
 Q7Hg==
X-Gm-Message-State: AFuF++kAla8sYBkKJAaGzj89bbqgNYXCsvRS6XEODyyN8LpOsGnMBWlC
 dz5zLmYtulVol65QJHrZhrrfOjRjnRwOj6vdzyZSFyS4kppK34CXOkMizo/BbKjPgVFQiAT4Qx4
 X90Uj
X-Gm-Gg: AYBFou1k2DgEdxkllzerw25JW58Jsyi4vmt/2IlmhaRbbC/+JffPl51MGj/0+59Qt7Q
 iyxelBaaXPK15VmiKxm8Tfn2ljsINPqtE5JZaBWD/3Hbr8Np7tbyQpt3wR1oQZfF4oIjiOtieLz
 pPHXfiwbG646XPgkTyElC8Wxm74OW7wygZPDBW9mIIMAMHZKWUiJ8hkJ8StIGJgpYyM1Zjmlui9
 4ZOqflogjXpmj/8vVT+2nb3sPzCOY2k4OXjP2c193zVC6rMnMz+O11Q36Th8h3aIDmeEX/ASkJk
 AztOG5Rpifc6jwikpdyE+aImWP8YoZFYjPr0vzZM03u2rYzcowZN85PFb5dqXJxBXj9SYbDGx6f
 XAO2YPkdNXsBrx4EclLncd6+sK1ImxXLkC+lXI0guLK2WPohS2ZAmp8WS26ATclavK0wSd7C0vS
 W7WaKuMFCmHmsrswsmp241Uxb14YCk+HY3bpMegJUuZMc2g1k5OruJTPftEb6cCjoGW/GR/sXEI
 TfMvzI=
X-Received: by 2002:a17:90b:390f:b0:39e:1c4e:5473 with SMTP id
 98e67ed59e1d1-39e1e47ab6dmr14407879a91.16.1789619325638; 
 Wed, 16 Sep 2026 21:28:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 018/101] tcg: Generic expansion of tcg_gen_and_*
Date: Wed, 16 Sep 2026 18:27:00 -1000
Message-ID: <20260917042823.542588-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 390df36f1c2..80ee29ee4d3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -317,7 +316,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9084171d6fc..a2ae864ac17 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,6 +2,7 @@
 
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bc902d04d53..ad7a70b575f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,11 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -454,11 +459,6 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


