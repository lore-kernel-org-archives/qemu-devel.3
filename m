Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD5C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJq-0001Cv-NR; Wed, 16 Sep 2026 09:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJY-00011y-Mr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:42 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJW-0000J0-Cw
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:39 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so2253623a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563877; x=1790168677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uCmOmovegGhUQGzqTd2jYdUvDaEHmn2ZTmtygxSB6Fo=;
 b=aos3Vjw7monu4j28bEvcK/40aiI2dK7owsx5FjkqWwUahraHZufebxLtg3CX5LkuA2
 EaAANvy3IZYpS53axFSPT37hlWZBJWxT3kB4ArtYwrbg/cY3NYzf7wPPRCbcxTxcaLcg
 oZMhRH8FfRi994vWVqPGOmKvhYxQ+1QIF1ZJW40FJtNCML3gmZFOo2W087jOSvBXWvFn
 fBfCoJPIYMKiur/XYikGohZL64RN+oGUC2UwZQ1GQEWrfwPNduxupmMVPnMWdshyx8ey
 xnl5t1szfkwa7OSoSXgSRpI/ho/qfr8JAL09EVHKD3KjWVy5aIwGCzRWFG43ypr9/rIm
 IsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563877; x=1790168677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uCmOmovegGhUQGzqTd2jYdUvDaEHmn2ZTmtygxSB6Fo=;
 b=dwbTJwa337g9NzVE0QmD1JPgw7NahE0vatqnPz8HqIih77gpQpsXwNlUpB0f4sQ+PU
 1v2if5Vcp3qs/Vtv9EbSJ6nTeg7Yznnn5x5HFP3cBKSzMC7fIMPaob85bIf6yNMGb6ax
 op3Hl0RxxnAB3S25Tn/o5S7vF7CdqMX/IMJO/KtLK4OrZxnp+oz1oT6tUwmOjWcrwhS0
 AOESPst31YEq29ihaMdGGQbOaQAsOMc4k5H7A9BpAxq5HpV/gsALCoMtu+0KSZTim5Cz
 HFQnc2FsSjkJQjOIo2aqaqXkzFtw+T9/1594R/ctuF78l3WT+VjM3JJanE4KmhtRQkXf
 XqzA==
X-Gm-Message-State: AFuF++lvMxnPvLJnTViMdq4cw3KUPKYVRk+N+UDwK77VV6WcyIzZdpIS
 ryCflxqUwiBVVHMVIV5j0NgQJKsF4QpI9VvSWFGbacHZ5slgWK7N/JBYd6zZ8VFzTfxLADt1pvv
 hj/7wtuo=
X-Gm-Gg: AYBFou2NRs4vKUua8DVN+vd7HFknGULKA7WKwkTyH95nty4M0eA5T/Fpli2ygt11L65
 DOF4Bh+7V8ka/PVK+WdkYM9imDNGmcPVxIl+WdTg9tgTLj7wId5qSBolNBb8Gy11ryFPYlph1EY
 KyN7UxpUCHM1xTIR1l+Cp5SQWi4Ha3ckopavaIVu55qP5cHPTqPtWS8O6O7uGE7lMCKxuPL0GMH
 SsRssKyqh0ogg/C6HcVTIpG+hYYIeZ1jPIUfVIJjBhzuapdcAYOLsVGrM5xCAD9iaeUUZ/47J8+
 0HIYJeTZLo5evPmLXiApq4u/A3xi/ZUlzD+3/csO4Yfmf1Is75XTkl1fFSPTkx67FuiuPzB6a9n
 YTVZYwu0yh3iG9lh5P4Ie26jZuAIwf9kCuNAzL42Vgz6n0LlOglmkF6M/FfkTJ3O8CXi5kyLvAz
 TyQ/SG8ba3gfsDdWd4k/YZuz9Qk3gH1isN6vuCbWYJn/6jy2D9JAjQ/JQAxjADNg+pkcwYUSu9q
 RXN5e+WZHDRstPFLA==
X-Received: by 2002:a17:90a:51e2:b0:39e:16e3:44f7 with SMTP id
 98e67ed59e1d1-39e16e3563dmr3874745a91.6.1789563876423; 
 Wed, 16 Sep 2026 06:04:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/92] tcg: Generic expansion of tcg_gen_and_*
Date: Wed, 16 Sep 2026 03:02:50 -1000
Message-ID: <20260916130409.3382710-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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


