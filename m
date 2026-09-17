Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B38C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nk-0001v4-SD; Thu, 17 Sep 2026 00:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nC-0001Ax-6K
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:15 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nA-0007CJ-Aw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:13 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d37f93so278179a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619530; x=1790224330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0ocFvmkr4iifAApCfGk+XDNkHdJfMVXYlmziP4EcjQc=;
 b=YZ5thGQDtEI8l72mBltRgndRa8eClx/RjWYC57U8DgxdaNknNZF4v3pGYGttv3EhCG
 g16zGba0lTTpX/noTsZ6xQlunc5ohK7FNAA4GyMWnRahIsUcA8zvheEMWPbXo5Pjgosm
 RtO/fsG5+WBR5D0Z5NUP7phUrHoeQVUDtYEDSCN30aQbPURVWVqAa2fvgkNElXwQPQM/
 Oc0D/mZGGe7yooRiLd2N//kHOrMcUl11j1a/4F8b7a0E866p6QOnoX6cwYwUQ/2w4EVt
 c/aUiGPVUsKxUZjTsvMVbWoUy01cZqRGb4tkhxYmE8+wEWg1BnxrQ1D+Cehr5bltRTix
 kbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619530; x=1790224330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0ocFvmkr4iifAApCfGk+XDNkHdJfMVXYlmziP4EcjQc=;
 b=yK9x7P71rzLZ7IorgdF2UYmvm1btuIpB8zgVv/dmBamGhbwqBxjQi0DdIvzPmwtp/B
 R9tlIf1bfGNuZ75MV+yfPl3wSvjy2t+Mcnr7bZMQsUnCemqA+u8nVjBqpYhZ26AlBaSv
 NGMfZLER6YZXQ9NmSKoEHEkjx/Mm8haNtRR8lIMJtm9UxZfoYcqpRNvmIf2Bvy6ETmvG
 kJxYdaxvS+WF/XwMGIKA5VFqXXVpbDNrrhOTk8JGNuS1aJvebHCRABIa6m523HlzgRXQ
 wVEB55QUwXody7sNGVstp6VS61D/SqDgbnfcIvvPn9ek57p8HhGY6AvAWfDJNqaUBXLn
 SExQ==
X-Gm-Message-State: AFuF++l7W4rGn0wA/N8LwMqTXG2qwU46EVkHLzFi2amcoaz8hXoXBg8R
 wKa2Aj6hRzwWpDWSEWF/1kZkP/NzIK35+qMt0u0JR5a2+1SAbAp0oJ5ULnOkObOCvPUAC7S6jP6
 /HzTEFZs=
X-Gm-Gg: AYBFou1mdU3VbgY98UmpzmmLQHIUigfE6RWlvg5rkhb0Nd6t4plcZgbHyEmSRIdugYw
 8RqjVZdIBQ2cqjG8lxNfSrCyvuuc1599dtEeolOYmLwHz+0nLu54RPzvTW0hoxSufEfDulvfd2x
 mGmqMPf0rl8EBktpJTIlnWiMHDXiqoi8cbhR8dTO2txXBB45RlXZ/zDkR8c7E1n/SPjMFS0AvSp
 lll1U5Il0vTF24yolKRQVhsUuDMhk7N69CLPoir+RF3TtHIdKmPEuPq2a+8qvmYa89kyMejjmqo
 ijuZk6A2xt1J6cfMybqEh9wfi6hYYXbp2zKJSYIk3Le0X4PhhqLznPlYnOeDuqM1DNGPHHpoh2n
 3EWxDknxYzqen9DM1ZNZojH0DHC9UnzIVq7FV3m/xYl2Pt8uL5pR4upOwHeBBHQJ5LpCidHbFpK
 d1uh8nhLVybgZbm22r9HLRsjnO1AM8RZkwol2dBnIe7iZ07pJTLE91esF3uXdpkngiV02KsVuaQ
 EJ0hqo=
X-Received: by 2002:a05:6820:2213:b0:6b6:c0bc:365c with SMTP id
 006d021491bc7-6c7d1ad0e87mr5111859eaf.22.1789619530447; 
 Wed, 16 Sep 2026 21:32:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 041/101] tcg: Generic expansion of tcg_gen_nor_*
Date: Wed, 16 Sep 2026 18:27:23 -1000
Message-ID: <20260917042823.542588-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x0f.google.com
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 613e844aecb..1fb10ffd804 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 80d174a6cb1..62dc85ff6a6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 47381b7eaf4..9c911816eb0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -539,6 +539,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        gen_or(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -745,16 +755,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1772,16 +1772,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


