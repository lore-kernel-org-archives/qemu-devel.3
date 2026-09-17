Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4174C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kK-0003IF-Bo; Thu, 17 Sep 2026 00:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kD-0003F2-5w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:10 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0006ra-6c
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:08 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-8692a856865so357789b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619345; x=1790224145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HTqb6Ytqyni0MZUbHkECQVzYmI8HSCtGvwg7ShWDocA=;
 b=FZAQYZP4X7fq0anKJlaGK47GttE8KTQ3hMGvwZ9M3FLYMfkCoy5W/FQB2GtJk89ErC
 Nk31kC4VnQCEIGvZLOGvDdQvD8cJLEC7apjReP5TEhOg7dOVWLriQAY9i9VddrLbojTS
 LWTxwSzKk1v050b49QZQBiWLBAb2mhdLgd8KjZlWUMiAb3fyU4oqKWmfVNMAFNNn4RBZ
 dWpkvvOia/4gPipRUgjjPJGB4AE2QljWH74XaDkWOW3PdQyDeG+G7XxXQTsLcl0US1Dt
 oqxvPjoaV2J4WlVPpWahrbtTrYtq0gMtRFWg+z1RIoRffe/Vs4MK+ubPYtoZzYvy9J8c
 0iTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619345; x=1790224145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HTqb6Ytqyni0MZUbHkECQVzYmI8HSCtGvwg7ShWDocA=;
 b=ff3FrV/anEDAiFHetza9z+A20I1VlQcyi5gIYWuqVwcGjl+qBMB0A3Jf9kpN1sSnK8
 TwUHIQeYfPjAcAFIXgsPOjo6Ks0t3kPcD6Miw24cn6D6fKd0icMJrAOipk35DSVP+VxP
 ZpOK1LLIbldd0E9G9wBxl1TzgNuIboKF2QQxtNI7iZZ1hAdHgamZkRWcPO5FIaES/hLW
 ywSwtypCD3xDf7eYHADGdBF7/+LRBwPX1/lOtvhyD4sg9m/iYMQBA93qkCDJWBoKi4WM
 S/ZMTHQyHs6kBCv2tYy5Kd2pyxCPDaI6o4Fuer8mKRDVsJrt23HtqZaujF14beltSKdc
 BAcQ==
X-Gm-Message-State: AFuF++k8XUxGtCBDeUv47dtaCIqsYC4+GnQnGD8zX6RMFqGjhkY9Cf0N
 wwH8+KQBoXvkMamWfqzczLkkJtWx0ncEj5T9MQ0HlFGT60jL1ChXmYXqXXI/3k965MyGgDAkYav
 g9eZwZV8=
X-Gm-Gg: AYBFou2jkwwUOEThHDd5bZYsSEB43CzdjjR+9fz3lARS7wTV387KmxuT5Tet8z/7tTS
 +95UJ6EC0VvQYOy9FayXEgUWcdoy/J89R5F4iTWdSfQRYG0NeVN2QcfkUEXTqwaJiiRuo/DI3Kd
 VdxJmiaE/COIsLn5HC8b6yYCZZL15W9kNNgRlkds5dXIc5XMTTl5c1o4+AMPm8mFsmnL68O37ah
 m3eRanbfKu38ZuF3fUYb0uV65qJCHBHUWKi4EQj+JQWV2Me6QPJpuFMsnvFZLYYzGjrFGTItU4R
 xXsNNflwKggyOZXEQ9hMI3CUg/58nvZA0IsWYtFOYuTFO1GVwRM6d2hi0OhbbaMD/kiN3e7yadm
 BATGUwiaam0HVA3MSMw2f2znt+6cIrw+xA1iJun0MnxRI1DCldetiFP9XmpW/6RsQl4ogs5pMfA
 Ds7EoP+XETGHKdicyS1YycWrjxDW7kmDixGPnXPxGFq8pToirGvE+ahveEes88hbVhfXdz9XWXc
 tcKZLk=
X-Received: by 2002:a17:90b:2648:b0:39d:f70f:f034 with SMTP id
 98e67ed59e1d1-39e1e2f4d41mr18473959a91.10.1789619345293; 
 Wed, 16 Sep 2026 21:29:05 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 037/101] tcg: Generic expansion of tcg_gen_remu_*
Date: Wed, 16 Sep 2026 18:27:19 -1000
Message-ID: <20260917042823.542588-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 74 ++++++++++--------------------------
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 05b4bee34ce..f0572df01cf 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e67f11176d8..cffbb4d08a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9bc7446915b..4b94bba91f0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -236,20 +236,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                        tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -568,6 +554,26 @@ static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1,
+                         tcg_constant_internal(type, 0), src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -707,26 +713,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
@@ -1587,26 +1573,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


