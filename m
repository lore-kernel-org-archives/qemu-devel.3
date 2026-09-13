Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C8AC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB3-0002Xg-VJ; Sat, 12 Sep 2026 22:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAy-00023c-Om
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:40 -0400
Received: from mail-pz2-x1f.google.com ([2607:f8b0:4864:3b::1f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAw-0001tX-OH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:40 -0400
Received: by mail-pz2-x1f.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so513729a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267357; x=1789872157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IpI6yZvKCS2QIkwcCgvwqHxyIjXR9BZsLELZGpEwQHI=;
 b=Ccr8GbxVIp3ekVVGqms+5UwQgQ+hwiHFs4sjrUrHyMOlkSXVJ9gKCBxEsXKaDyGNLr
 ItA9U51jX/Bqj9eFOuLGXdzKILFRkDUxbfoYy0D2ofei2fcGUvS1BupsvstgRa75xiHj
 Ho5b8Ax48DCz40Tvllyh48DjW4qc4oGEy4cSNePw3PWdy5cSBqbvw2OWwNnzsXEhJiAJ
 JJJCEzwVA4bEFpen4EJ5g4eJ765GJCLkR15FOm+1LsiFGHDMqdpHJN2swb+dCbnPFXjy
 ul3doS87mZT6F+0yOgA/Gup8xb3ksLqVOX9pZdo48hGk7WnUCnwSpDHcH68UQyjYZGi5
 qfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267357; x=1789872157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IpI6yZvKCS2QIkwcCgvwqHxyIjXR9BZsLELZGpEwQHI=;
 b=tTJTB80hhXvp7MWSqg35vkxvLFYs4nAVFe2IdEgvDdVsB/HCqDnAfxQyCM8qpNuvde
 qNktW6ZypWVH9ZBNOwbRlz6UyHVQ7OPJLGf0nYseCV5XdHEWGQ9fMVwPVrXxmE9ozM6w
 Lp8azfnHtEyPxCAIQ2px5blLuGJE0oIgGXYb7iAZ7ly8A/6obTqL4jDd//GSw12LK4ww
 zLsuKONAaZnY9qElBu2WNaDhVN+TObNPZcuwLAtVvdznvKnH6nFMX3/nNxuP8U9cTjSy
 eGlpRh5Aadq/V2l+YXz0QL0ZjrXPfPFlzgm4iZ5YSilhOzK7bqoaSMw79qe4/mp7WndL
 QRXA==
X-Gm-Message-State: AFuF++mDSiMkXp+nQz00b1RxtUgoNDKbPQX1BDXrWb6qqfhCYaPkeT/A
 giWaEJ0Id7rPpuSWTdhijCwchTWLanHBs9Dp1Owfp7ghyTwCN9EZRa2kaF2/bzee6wQmlyqecLq
 W9Ft0leM=
X-Gm-Gg: AYBFou24IW3kQ6gCJ9vv39UVshd15OGhoPUsKEPHlSlVs2OAl9z1uj+v1xjGC1lp0to
 JUEyiKU+mOfg9FO+TGl+kOgJMZU9rgTjCo1BJoWgf3p/V5DMGGgazDPYJ+01MR//NyP3RHoG/Vg
 hSOkZaYpEB6tBaLopZYg1N3detbyquDE2fcR6+4xcXhCrhaDRnhPqtgZFLabhwupSb4p6OJ8EwZ
 ufMxijuE6ABFheiflL/98eGS0yU2c8qkMUlBdb0O2B5Glb7CHYqY4bOGm51vSAFdlNpbutMT9FQ
 1Rg1H+oHm+SRu/VmN+dXWhSESFXwscjRdm4Ga42dXk4zXfA85fwlKm1ArekrdEcmAeRPpcQEaRG
 HKARANxGRiJCMEZzP3+qx+jt+58ZGcEvDi2pTK0TNp5nFI6PajSm13HNVGv3e1TISCiZR25i9dp
 zjGhEg2mXflCgGx6UiaqE5nCFq1eDVgv85xW9jI7xykSNBZT1qv+CEGBx/mMck1DihsfzITW3Pj
 67y9R0=
X-Received: by 2002:a05:6a21:48d:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3db0e41e850mr10890034637.21.1789267357081; 
 Sat, 12 Sep 2026 19:42:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/86] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Sat, 12 Sep 2026 16:38:02 -1000
Message-ID: <20260913023837.741866-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1f.google.com
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
 tcg/tcg-op.c                 | 42 ++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 521aa406c49..48889a8a108 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d0d219918f..2de0aacd93c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e8ea8bb3cbe..dfecf8abca2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -526,6 +526,24 @@ static void gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(tmp, src);
+        gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, src);
+        gen_extrl_i64_i32(dst, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -928,21 +946,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1833,15 +1836,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


