Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B684C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKa-0002UX-Jv; Wed, 16 Sep 2026 09:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK0-0001dD-4R
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:08 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJx-0000Vu-TQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:07 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d45ae011dso7630697b3.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563905; x=1790168705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0qud3ViN0qLpjocCia/wtCVduN1uZ5G1LgBxCeKJTWU=;
 b=YKRfFe/RpBM4WOGyIKORzZuRbjt0RFZdSKtpSB6bsMYgRX3nsEWPAiPkLBaQv81pGp
 pNJyaNGRDpI2Si4YBApVkNCEVAwewFT/ch/TmlIBxOawX4I2YxVlMmKxMNQxUQaBtSNP
 qOGDHIIzjF/Yv/L0FuSoZ1kEuumxB0FMqKFqciBve0GiXGdHYlZXAGICAm6yd/kuv03O
 goZ7KAOFeifbCfzWAxjvpYM8M0Bd37hHG3axts/xoIoqCQ3sxu8E0FT3Pv/J8oXYngU3
 t0yfVtUDtRNY43JpMjjlMm5XBV9UzudtmXnJiKV/3npKCj2Vzns+sJgWNbsBlyJU6jkN
 k1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563905; x=1790168705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0qud3ViN0qLpjocCia/wtCVduN1uZ5G1LgBxCeKJTWU=;
 b=n8Z0lqlPj0F1BXa+pQmBpDskqR0Fe0ct5fBW1t3uRg6mVrIr+Ltc8nzFV0NMNZbdt9
 9E8vGlL+nimX98M1CzX/ao9Ygt2aqlOIJ+X1s+4BnL8oxs1ESAdUROLaC3O5ldlY5Wmx
 9l1WqALuInzL6SoQT15HjXBVn017TcPiLGShRm/G8PWZGj++q63+350G+tv/HsfEeFdN
 io9KUoQ2PnJiqShW74lCrZk6FPLbT98GlbcdV8FTNilwVQ43rqq3S4+C88vzDgEh4EWC
 wCecpB+GS5NCDyj5SQTtPUogmq70/ExFsDveo7tFpLegjtS26dAiGvKSC/jqJbOEG2oj
 6bTA==
X-Gm-Message-State: AFuF++lbayPRS5++6oBgKxrYKZ5tX8DNdmKEXjdmiEakA4yu82adg44m
 +9OprbslznpVsVn2uusgvn81MqPUsSTs161xFmKA7mhWtskemJ4SUsELOMH7C/c9hbKuAx95QLm
 eHq4YaBE=
X-Gm-Gg: AYBFou3fQ5b8l7ROX6x6bbSO66B5ksy6hpPxXA6+Gc+9vcB2Bj46ccWPgyOrkrhZDd7
 WOh+m+T1EElFxZUC7Tz1953m+qEVRb25oQhWRop7qEnvWzo5B/XOcwc965QjSndCq4zvsGCag6I
 A378jJ+PyD5sNr3b63fcxs3RIil7qepvk0XCHJl8iuI5LyAh4Ebc4kHSME2YkfOVfC0K+l/Uxni
 5sUzT0amg5yGh2OfA2iJ/hjKL0amh15tGZ+lwvvEDTECQLjbWegCJbRG8hc4lj02YB/tipcQhVH
 trqfLtvbSqEdb81Fs75fu4IWqjakcG7OtVeNXZ7nRWlugKJkAMYZQiew7f7bXpFQpzHTbFa6Dpo
 t4Ru4tyk/VLaM5qzO0vb0dMA/RedD8jbtvr7XD3MKXzr7X1nNtEnITrZmVAkZgLAOlzi+aKSt6U
 XCjHps/vCkkyBH885nwwbxQLeJF2s71gt/0yVVCdvg3jRC9ul6K4aWzwlq8KF1WcQ3A8wmSH/Vz
 Y//yeAg
X-Received: by 2002:a05:690c:a7d1:b0:873:5bb2:6c2c with SMTP id
 00721157ae682-892292a7c99mr5314457b3.51.1789563904706; 
 Wed, 16 Sep 2026 06:05:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/92] tcg: Generic expansion of tcg_gen_divu_*
Date: Wed, 16 Sep 2026 03:03:08 -1000
Message-ID: <20260916130409.3382710-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx2-x10.google.com
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
 tcg/tcg-op.c                 | 43 +++++++++++++-----------------------
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6223d46b199..05b4bee34ce 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 67261d12741..e67f11176d8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7b6eb9a3fbd..cf6904623f0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -475,6 +475,21 @@ static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+
+        gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1, zero, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -695,20 +710,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1589,20 +1590,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


