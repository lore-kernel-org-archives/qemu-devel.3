Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9E6C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpA-0007Uq-VO; Sun, 27 Sep 2026 05:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknv-0004gY-Fn
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:15 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknt-0007eU-Kt
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:15 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 d2e1a72fcca58-88286981a36so129726b3a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499852; x=1791104652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n1DzY9pKbQy5un5XM7Bq0Ui2HlgjI9YNsNR6ZIJ7ZdA=;
 b=LrpK6KnXM7r/vZesQ9LJ7Ge5jiyY0uhuA7TEr3Zod5M9Ig0OrZM3FQ961G/lylco5A
 T8pggZmfOfy9/s8yzSi7UD0TeRsptqk2E6KPjlIvpt4KHivgXJyQuwfgl72ZR1GwBcxm
 jxTwOlLaeqz7Byhf35phuuufC5rHxxZyIkPxm7LKkFJ2Nb8+4G2oBA/8ktktp2vWK6K6
 Sn+3lvJGEgWraHzYK2HCgU/zf7m6lzDZv/BS/7pc4GN+vSNR/MIqX89t2V/k5pZugBP9
 AFCR2VHT6mxPDKM5CGJ+Hz0qP5wr2kFeJvWP0TCFrUsGHAYuDPApbeq/AHjZe/Uwvcq0
 Tx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499852; x=1791104652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n1DzY9pKbQy5un5XM7Bq0Ui2HlgjI9YNsNR6ZIJ7ZdA=;
 b=u//vZVJ9i31Nryh72ZKl9pqn8ZBkYvvTx1/lXQ9ff1Sbk2ZpbhB1pBRkzNUGeRUTjP
 CEEAuUKANYC/jvcsooIklwgIUD+ZzkuBHX5E1tQ7cT3JmO+aBr0saDgxNw9v7mGAn5aG
 e33QLZt4pf/eeRKFYaUiyQyRy6TtAJDw62EpT5ShZOUxxhvwrgPMoaDPT/n4gcubybQD
 DiXvSD4yM9qxonGsxFwU1oNctUF/ajGOYmrleDR97sozzYD7v+LP0THPDNEQbCYmPJhb
 EDo+fjwye/sVTq40LhoJCa3MzdKkU0bzqhxdTb73TQbD23itNp8vohiP6CRJCv1rQpau
 tuOQ==
X-Gm-Message-State: AFq9FYKpxJV9tr0APz5/CYT/fS/4061Ilgig0Mfiu2w1oFptyeuqs6kz
 Nwo4TJDu9wQlwuIL84iSOVrJuYBxtBPvbCNxjfBX30WKurpuN+kw/EOnSIHUV/Uy9lcIfsg5LT3
 j00VC
X-Gm-Gg: AYBFou0kxEIuEvjYqNgG4ngmmnt8GloTZ3hVsr1n/Q/APfriy5dOnOLJBmTn7ZzrBjB
 GTGj/9jDGkCvWSng0pltKR7DL5kMIbrvupbqUMU9nodRDNNDWKG0WqIFZEI/xmxWgUomRKwbaGY
 fpuBTfv405KHI44xhlM4EnwkAEY5Fi7ZvSum1w+5tYCdweBqxt/KYc9TPelWYFS0ZnwKNAl+TIn
 IMtEHiaqW7eUf79VXyk/2+RA5IEYoEIUaqOfGLReOM6mCF07xV6yy0ftfB4fDk1mrLBQESTGW3Q
 uvaEB6o9D0XYzu3XWzDPWgjH/TEVCeO7bVbcJyMEDViUp0F4HrVzID+92GN8Enj2vXkCXY2UbOb
 UbzDgeuTBl5+qG0Jwbh4UVqqFhtuKXRZF9zMJPyUsclufbFIDoFJrMXBoFiuAjPSYDQBP/n0xt/
 eADWynhJjXa9Coh7W1z7KDxagCDUpRR5S/dnlwlcOCVeYc/Vwdg05aOad3P4Lz6Ux5ty3i+QsF0
 8XEcyesyg+GSP4CvcrtXb18jaIIvw==
X-Received: by 2002:a17:90b:1807:b0:3a0:c8be:3227 with SMTP id
 98e67ed59e1d1-3a0c8be4232mr5046157a91.13.1790499852216; 
 Sun, 27 Sep 2026 02:04:12 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 057/101] tcg: Generic expansion of tcg_gen_clrsb_*
Date: Sun, 27 Sep 2026 01:59:27 -0700
Message-ID: <20260927090011.10724-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2a.google.com
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
 tcg/tcg-op.c                 | 45 ++++++++++++++----------------------
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ede4743b1ae..d19feb49cbc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -185,7 +184,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7ee00c9d53e..ef0ac5aece3 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF2(clrsb, TCGV, TCGV)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3498be09e70..5ee49e2553d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -422,6 +422,23 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_clrsb(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_size(type) * 8;
+
+        tcg_gen_sari(type, tmp, src, width - 1);
+        tcg_gen_xor(type, tmp, tmp, src);
+        tcg_gen_clzi(type, tmp, tmp, width);
+        tcg_gen_addi(type, dst, tmp, -1);
+    } else if (type == TCG_TYPE_I32) {
+        gen_helper_clrsb_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    } else {
+        gen_helper_clrsb_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    }
+}
+
 void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_clz, type, 0)) {
@@ -830,20 +847,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t, arg, 31);
-        tcg_gen_xor_i32(t, t, arg);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_subi_i32(ret, t, 1);
-        tcg_temp_free_i32(t);
-    } else {
-        gen_helper_clrsb_i32(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1675,20 +1678,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t, arg, 63);
-        tcg_gen_xor_i64(t, t, arg);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_subi_i64(ret, t, 1);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_clrsb_i64(ret, arg);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


