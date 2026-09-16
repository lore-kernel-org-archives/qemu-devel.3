Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F92C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNq-0007sO-3F; Wed, 16 Sep 2026 09:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0006mC-Bu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:40 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNK-0001ST-Gh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:38 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 46e09a7af769-80199394f52so624489a34.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564113; x=1790168913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9TS9NYSz5lLDhijItqF+xKJhMNx3JxEktLWlDwVCe6A=;
 b=hnHxQECXCLW/Vm2Tt+hOoO09Esk+m+On9HMY/9oRppLbRmnHtFH4LxRf4W26nMZZ5r
 VHS5ckH7lKPFonvn9W/3oCMUlooTu/vPDCCXdyYXjKWMO+QccNecBQzHfUCQJPyIXZtF
 +ESa2XFS3kB/5Dt5diamkksqBlrnUq9R1PlI8IgKz5m2OY7ceOij47UUin1YRhYmh1QO
 UmfSC8T0vlB87XWmpHNg0TJuG3C505sqw9yuvwZyfQfVy/tCl9offfd95NDdkeui9G4j
 VLLYUwiL36MdcadX8GsfZnUp9kfpYvAwGsr+jgQ6i0IEpSHRy1yZuRiDMEKIEF7yzLps
 U/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564113; x=1790168913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9TS9NYSz5lLDhijItqF+xKJhMNx3JxEktLWlDwVCe6A=;
 b=UTP/qvoGvF51OhnbJu9Femrd1VwmR61FWzZ58La8Shp27IzDL6oxvH7uxKknk/fsSR
 0COZVnJHiIZ3fbFPwiQaY4UeO1xLBJOi2TwnFESuSOjRwbNbmbmkiP4J71l8foymoDT6
 Jo27W/kEdhJLpNJhShcfTJpsIWl85d2Ri0nkcQGrfqjczQyZ4Fd2X9+oc4lqrsq4V/tZ
 41sSM8ez7UngxOKMt9byPD1rgIacSEsWfJPJ9CQAk1q1nr0ZZPgeojbK4ZNIMU0wOY01
 Id8WiQWeXS/rUU9ot2+fhItKIFYzs1jwUox7KAjJa7VhCz1qp4X/sluBFmvfIAfum2Hw
 uvEA==
X-Gm-Message-State: AFuF++lFDjeVvr9280mqhS7m+ueU/q3Ikeitr+KqD/sLflX3MXVyauqd
 CKgbt2ZFl4kaSJuSRTfMD3WbvMhYeFEhOcfj+DduAAd8JTNU25u10hjA558ia6lar8yJu9rqYb0
 s+ZbtJFc=
X-Gm-Gg: AYBFou2/WGEhXj2NIVXP4GAhNptaoaKsjBu5pE8I7t9FPt1FfrmNn7ORe4vGvh582cc
 Heyd5teVM/2+Li178OmN3u+xMnEc3OCfifYhaMAmyYUIXXtNihF1s2+dQLmLh+jQ9OTTJAXK4Yo
 6H6WO73U3gJFJnFXJPu7SeMOIvU96lm7dMMsZ2tADYr7ebyARDIfCzzFD9D0or0IO/OvrqJVueJ
 OcW2Xra9BZiIsvVVYhQctJwKqdn+UQA+gp2x6G7LCfERUhUy+2vToks+FwTW0bq9xiwlfqBdPoy
 WrJPaeapneIT+501TV+YIVqEUtfiVRwUnssX1z/4eAIcDr6amdOmIO88Ww6K1e6t9CQZ1bj1TwU
 jXhgJC/xMRrRHciOVa0PagfE13l9Th1iZq7L95FQ/ukTWUWQKZsfwHcWKWsqJABURsPl8fQprQn
 pfvoxOD9Y4UPQIXfPhAZjE9uyrY16I9qQrBeRr2j+dNCu15WWhlsUCTIuHarJ5Wc6/2LoX85dTI
 HFK378=
X-Received: by 2002:a05:6820:3107:b0:6b7:83c5:fe01 with SMTP id
 006d021491bc7-6c7d54fe2e5mr2582932eaf.66.1789564112628; 
 Wed, 16 Sep 2026 06:08:32 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 59/92] tcg: Generic expansion of tcg_gen_rotr_*
Date: Wed, 16 Sep 2026 03:03:34 -1000
Message-ID: <20260916130409.3382710-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0c.google.com
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
 tcg/tcg-op.c                 | 63 ++++++++++++------------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index bd1c76d9556..a1c32214723 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3b2b0b76454..35542e003ef 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2893f5728a5..66beb4a07cb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -872,6 +872,27 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_shr(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shl(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -985,27 +1006,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shl_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1795,27 +1795,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shl_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


