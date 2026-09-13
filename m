Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB917C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7p-0008Uz-Ga; Sat, 12 Sep 2026 22:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7V-0008QC-14
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:05 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7O-00010P-Vv
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccd66bb5so732612a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267137; x=1789871937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5X7gY49NdidyziT4ycIpXRVmcSu5BPraTHlPdcpKfxw=;
 b=lP08nyKYMlNLp3c2h1Tu217Q904Eky4mFZvadwhNtEPc8QPHP867mFbDR0ECYNMImz
 suLBOa4Lw0/qxjIaO9l5u5HXiXGGQnCkptw+Zpw7gtgi5AKrtDSptjz9It+odn2ETbQY
 vONG1/u2Y3DANqlORNgd4S0WTXmv76UYjxY+IOF0hNh4ka0ws4LKMgR5yfze2MLsPaJ8
 94HrFDmagrZWtIUEzFW3SD8qVmjOkVAx+b94GCTGZoa4bRwNvS0yWOF5rr1NJM+viIXR
 pU5zJsBIrFqBTplakcazARFL0fTQgfq9e0Oe3Avwjs9Z9hGI00qhmZGZOhFDBUFR5koe
 yTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267137; x=1789871937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5X7gY49NdidyziT4ycIpXRVmcSu5BPraTHlPdcpKfxw=;
 b=b6gA0VoI54QrPhzA6TpTTpG4lsyYoUdkrld/fhcN/CXUhc16w1D17hi1Wi/5p7/sb+
 aDo1QtQ88IVWPNbeEXlY1WQjt8UZNxc+MOGNRq588j6hTjUaTsKIsY9xk19o3VTT90V7
 Yx25GoSDhMIgu0E51S02GR8WkGyDIazScm7xjosYMxmkqBlo2sPxlDY6JoinLn4e/9Zw
 VTpPQL3tEG3FXygzQXOzbj2MXxcTfNHsj8x3cjhBHRbd1Nf3EnTSHQ4v75uqAv3U5Z8Z
 WElnvD94vpj0R3YvYJtsu4d4EWF+M6jtJ445k4u4GK5CxQTpvQYB/GRUNzQs5ORQtULo
 DxRg==
X-Gm-Message-State: AFuF++mTMRUnNSh5FGvHg8ZGvljUyjHwk0cZ2iucW/chMxWslrbBK4Fn
 seILkWeVJlXmlZiWlXveKAx7j3vYEMBfVXBjWTA00pAbgrQDaHOa506i7DBznwhUVLi/kIO+wCb
 MZM10uLE=
X-Gm-Gg: AYBFou3/Yu6CsytLSugT474qryc8c8lShBmSM+eABnorE1IE5VTdTKtHBGoxJjGJq/b
 7wGsmvHexaxpYZLGchj1L5CJH4CGbY06KZXu5dY2oD9y8iO6isWg15PT5xc5F1hHEO9KpYuXTaL
 AuZJPDeo0NJj0pePWD/MXQ2BGec/E9capJApH8J5MZTaQvDi4eUHBgtS6pCfo5VQOzU/qfoNwhW
 5HoBWT5akzsn6IclwAFtzDbpaCsGjGbQJODm01YMv/2OW/lN2767FcVQf3yBUf28NwEMA+TmZfG
 b0fey2gPiyxnFF8Um9WUZPkKMTmnB3nNlFaq9umR5iBl/sKTJOswwug9eFvbU+wbnXrKTDJHrvT
 mvs2o8mGAA6aPUbi6ipBxpXkM2JhtvfRvFUF0QlZIccL3cvNbRdv3wUoH0PvRa8AbxNPb5ysLYg
 wYDhJ8bIaeTNL2K5dKe9/g3e3uSrTFY9Q53jQ9+u58kAZXmILG7mDz8E+d6+6Kk9AXqsWxRtKif
 T+m7onMq7aXb63ehw==
X-Received: by 2002:a17:90b:1c02:b0:38f:5801:dc0e with SMTP id
 98e67ed59e1d1-39dbc6a016emr9114463a91.15.1789267137327; 
 Sat, 12 Sep 2026 19:38:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/86] tcg: Generic expansion of tcg_gen_shl_*
Date: Sat, 12 Sep 2026 16:37:26 -1000
Message-ID: <20260913023837.741866-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
index 765a7ba013e..99c182aa5a4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47d3e6f6990..15cbb6c341a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1c9943cb082..1223ba31e3f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -443,6 +443,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -534,11 +539,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


