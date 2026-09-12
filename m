Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDD3C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L51-0000IQ-MP; Sat, 12 Sep 2026 06:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4r-0008AT-Aw
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:21 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4n-00088H-8P
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:20 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2db22383fe8so4218935ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209313; x=1789814113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UPcFkvlxbeQe+K4g1tyvukG0hCxa+O0lWx2C20PLRUs=;
 b=iSt0d8towmh4oRzBaexn+dWEzNrR/1edS8HdyszmiGxz/powS2q6YwhZVI43ftYpAF
 cFGs4FWrOyTRS0OM48VB1pBlhopI6Vi/38YX6gthP1ZUHtab+9FxyMGKlF5YbW/sPMdw
 UL+H0JSlzVpbdMPGKFG8SqP7zpDn3Zf0nyFb849ABIZR/+4PGxAMCKPq6r0ADsbfuoPM
 FiZhI6023BNw9sXGzH+jMEeZ0HVzdbfy0odiNcBA+3mbvwgv3I9wgHm1jkJwg3yH8Bkp
 G1DTelXMIxu5HuqyEz2avyCFLTW9m3pU4u04xkCVm+eZWFRaS7xNR5ItDo2bmAX+cnjM
 edtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209313; x=1789814113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UPcFkvlxbeQe+K4g1tyvukG0hCxa+O0lWx2C20PLRUs=;
 b=XgNd4jtvDhYG9WfQGrXbyZu01yV/ppEuLFkOCJaZg5fYqGv/6FYFgRJV2x7gedv9/e
 Chm52Yf5ryI7Xs6/JWiwOvyS4ZuoEQWlrC3UVWR/rtvcuXJ8eaNB27ZKtU32HTgZZjz0
 LfellvhsOM/mqQPgYDIbREi+6clqlym9SVMTV12we1S5O7UU1FH3j0xNSATjQx3JTJEd
 I/N8lsN4cK40+0KrsIZJdbyZoFkBJAc7DU0fk6ABjCYHfa/sadNbcpLbD43llcXn16GT
 +C0Omt9pUkqVA4NnL4vqw+dK0JTThqPYNyN53Di0BxDfgJ2EqyEUV5gmC2fAGIGvfvmq
 2UTg==
X-Gm-Message-State: AFuF++kjUvu4MHfXDoJrnavMxdIe/e4yN9xQjdcmRuv6Oe38dMDh+zcn
 lJF5h+rNbBUb1HT8KgPvkAS31DsG/6DAMvaIw9hhZWqNZRWj5cD2YRBvXiL1cZPEZRwPEFXEZdC
 rNwgnAS0=
X-Gm-Gg: AYBFou2qvtZUE1ZActe4DqNP5MO3sxJbPOVXcsuR/Pa3P+iQ7Eehua1aCgsKzdohL8p
 mf3eGiekSoT7YfOV2enKMk+It0oue7zJ+1VfP+WiBolbZQ5pPcbgmmbqJgIsvLsAp0FkdYMF/3G
 MACDJO+G45CZmYTNYdckmej4Nkd4cRVP4y1YTgMbR7JQn/8iA5nJapVQa6P0jf7Kz3erQxYGkl9
 cvOKKLzbBOtQgWBI+SAih0sqF/usHjJJvCrjh2fB+3Hq46pICl9ym4rWLVPe2o6VdoHa7kAFzRC
 nuAa7HoW1lBx6em70z14JGuCQ4G3dAxQUg6sDFhgUvWjU4tPKkv42+DQPAoT0oOazS7a81Mheml
 AMwCcknsAHszqOCcn1fehGstB1M73o0HOschLaBKF09zXF21QHGwznM2b6Yzx4Mpb2dYgYsVqc7
 F+6FP4+ZMFb8b49owUHAX8up9uXJMd4WeJmev7B5+Aa6JfHJdVwk1WccwaOWyeXGDpIlqYEUqR7
 tmUdc8=
X-Received: by 2002:a17:903:1a67:b0:2d8:d4d3:da4d with SMTP id
 d9443c01a7336-2dd2a35dd20mr135742705ad.17.1789209312547; 
 Sat, 12 Sep 2026 03:35:12 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 45/82] tcg: Split out gen_extu_i32_i64
Date: Sat, 12 Sep 2026 00:30:49 -1000
Message-ID: <20260912103126.598030-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f3b1ee1fe43..d1eb006b2e6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -367,6 +367,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF_CRRRRR
 
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
 
 /*
  * Generic expansions for templated operations.
@@ -499,6 +500,11 @@ static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_extrl_i64_i32, TCG_TYPE_I32, dst, src);
 }
 
+static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_extu_i32_i64, TCG_TYPE_I64, dst, src);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -2311,8 +2317,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
 
 void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
 {
-    tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
-                tcgv_i64_arg(ret), tcgv_i32_arg(arg));
+    gen_extu_i32_i64(tcgv_i64_temp(ret), tcgv_i32_temp(arg));
 }
 
 void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
-- 
2.53.0


