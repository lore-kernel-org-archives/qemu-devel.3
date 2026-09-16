Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CC0C982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNd-0007F8-Do; Wed, 16 Sep 2026 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0006mF-CC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:41 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNK-0001S9-Fv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:37 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae7166edso731718eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564112; x=1790168912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yp5Ek2O3IweFGooXyDjYcPw4chPNm4YtEfla76rCIeI=;
 b=ws+ZddXshfsq1QXAmav8gdJqNzsJgtkheI9ClwmZq2xmSR1Y0OM9LxMANhaNXBl54Z
 4yQuL4FM0jy+0SXKKVJDXP//M5ZSj2TCon6V9aEfjtDFR4xYwd1jt0f+HMrLbYI2pY3M
 ZU/AgIiCGYpm4m4SME3lIvqxHChhClo3Bqxuls78SNPkiL88tIuPhkStmsGtb2DnYUpR
 JKoU0qcwf2WMm7SvA/4C3hASCNYq3jwhWUAi8PI8Pchc6nqSsiqGX41mUj+qWZLeJcga
 /S9wyy1XiBaOhPtY+OY+qrs/3/eo/aNmrxtWDfcBOoSGdK1K0K9dYv5o5B7Y44y7R9ud
 peOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564112; x=1790168912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yp5Ek2O3IweFGooXyDjYcPw4chPNm4YtEfla76rCIeI=;
 b=DwW9+shHZjR4QZBYg8NnX/vBJSbCEG9WwA8b033f/vHyzwBfdMTuxXZXJebWdmhW0p
 aj2lHQTjHbf8knlgVYtL3ZuG1alEN0d9RuGVGWk5eYZnJBcvg2urbzc47F+H6uTscE03
 7ox3d9tHb9rbcP6DhiWd05JBQoou/HkZkc/GnT/T2GWuktaAdNW3WGgP3rG2OPZ4BrnD
 f5ZGkinWJPdnIV+SPtqGCy/EgkwYJ9PZs9IW2otAx+JIoAmOI5hsISIM730rU0B2uots
 sgm4r7eA2AZQcAu4lVofQJL+i/zQkfOEQPEaGxO4sckndtASAt0YqcRaLxiSDY9tKMNk
 dO1Q==
X-Gm-Message-State: AFuF++mTj71IjYRvZxRfj9LHjZm+1nyTpvSC0vbfLPszZ4M7H30oA8ng
 RM2cgdGuoRIPKCb+/QS8KQ6bZL78jPUX6o5OI77L8ROpDBMuxU1Wr9EjVKyVVZA8riiddaoh3OL
 v2297tVY=
X-Gm-Gg: AYBFou0qGm6gNArFhQpnJaKaizuThRqU886/HkMYa/FfkshWBYbtJiAXz8uDz/ukQZ8
 zDL1SZJbQpe2LC3y1y/h4o9aZtvP+U8ynJq6U36LWd+zk7rK4uawnRL11WsT9fxFs8QUT9dnhxp
 GMSt7YhLLTlRD27AOEHhmmSAy/VwrNk5ctowsUQtJ+/3DtVdqPZ6LPrBuMo73RPynQyRlcLIS4Z
 M3PGo7AUbRuw+A3Ih1nwJYSziq6Mv4hEiWJjYWj4ZHc1uOnRBJzeAb+FMW7MAeJdPlvOnDxXF9R
 yL7d3F3kPAxzb28ZQ3z5JXgugHVkhwdLZ3eNelBMg4ZsZ1VgMDJCZFaT4fpqYLZwL1CpE5eNZF0
 00xyngwZv/uDjTnoWhSJ0aCv5qxowvc94cmlcUZYbyympWIaG6Bt2/3KVxCoTKMG2ozzn2qAOET
 Z8EsORPxinB1mzcfzvbDe6yLRKSo0O6QlXvQjzXA98iLE51VXjVNdRSmKSNqH9yCFCqziCsoN/i
 9yZryg=
X-Received: by 2002:a05:6820:4c05:b0:6b3:5475:4861 with SMTP id
 006d021491bc7-6c7d17c4d3emr2581259eaf.18.1789564111651; 
 Wed, 16 Sep 2026 06:08:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 58/92] tcg: Generic expansion of tcg_gen_rotl_*
Date: Wed, 16 Sep 2026 03:03:33 -1000
Message-ID: <20260916130409.3382710-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0f.google.com
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
 tcg/tcg-op.c                 | 63 ++++++++++++------------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 79bb00b4a5d..bd1c76d9556 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1bdf9876067..3b2b0b76454 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -33,6 +33,7 @@ DEF3(ori, TCGV, TCGV, TINT)
 DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
+DEF3(rotl, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 424ee358803..2893f5728a5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -851,6 +851,27 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_shl(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shr(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -952,27 +973,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shr_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1783,27 +1783,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shr_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


