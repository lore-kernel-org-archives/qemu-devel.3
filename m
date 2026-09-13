Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE41C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB7-0002x2-Nj; Sat, 12 Sep 2026 22:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB4-0002dW-Au
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aB2-0001vR-3f
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2db710396ffso27573275ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267362; x=1789872162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5uU6VGjMdu+r4NDMY3M6FhCSqpZRNUfsaZkS0EWBEq8=;
 b=PQZjMb1jkqLfMNmb5XsSyGd9x9liGsr6CENiMR8TbogvIDJG/cQx7CH1+R62pUJv4C
 kN23MrHaYQD6mEgtvRy7/ilqRmEHrDsv0s78X+lUAMm4UGUYNKbHc//dfDQ+SCwJxbdm
 2VNIKFDmBSlRbvTOGjyogRCCXgn53hixGd80U8c2SpNeS6NRaVpgTA9ZHQGwFMfdyw94
 AVXc/G978WtS6eaU0+vPbf1jg6ZgQZ/GCBIsU/kWk0fpl3PUJ7kQmsBZxuUOhOkhLC7m
 BDiE99yX+RQfeUGLsWllC0z9ipC1IgO4PEfDrb0fC2hO7J09aEoLpyPXjtd49iSlknWf
 079A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267362; x=1789872162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5uU6VGjMdu+r4NDMY3M6FhCSqpZRNUfsaZkS0EWBEq8=;
 b=fKMusc0euiVQtz/rfsKULaAHmltkXJM4zvIUBeaDXN5TquPRELhhfjpEZe5GV1oeYC
 Bkkcc3oZtdZ43UsVDjFRiVokETWf8tiX0l9iJz4O6vToPChP28VHhkRkDRsgH9c/8oeB
 P/ggabQZEPTL8uMpRoXsLW/JbjbtvaaTELOoHeTIwpuAYhUSVHcFO8xTjvWksiBvp5TY
 dj5B4DhqatnTO35RIISoygh4uPsTe5D9QAWEhvR1ZLm5FO9IUfdjcYgSmqvdY1IgVDap
 Q3P0iGMIEAEIM/jThKALBkvHGSg+AnZTF2lKUbsp7xnyE89eJXt0dMALJ4n/e5x3+Tv4
 EGpg==
X-Gm-Message-State: AFuF++nS+B/wOjNizlEvYCxkm/deX7Li7YOYQbkZAoZNOgdAFEb3lgcX
 bEo7/spfWTSJNwHHCiIir18JNBvG4xK0MAMqVL8KBin6LMqIOWdUoWuiuj1RteyidZrH79DXLfR
 jJENw
X-Gm-Gg: AYBFou2qwrPBWZxLSUnUHy0ACJ64YckFns+dnj6rewJMQtE91AFl9xpt8A+LKvPjZzG
 cg6t7rpFuz5mbJZlelaIQyY+IKMLAz9EKRqB3QTkVyIRYtkfdx8NH9n2gCZuR0GQecIoLRVmSPe
 e1tNFiDU0h2N9baUOSfTBcJgUDEIpKacVDVKXMEfzZZ9llH0qUY0AShV4ge1S/XZU/6emf8/fnO
 cFAumEINvlTnqmc00m+xl89jjjEB4Sz4plhO4LBgM2u1eDwX6DA4RamlhYGORDVLLmhGjWm3Qvp
 ZDBkAf9hbL7zTY9vlnhOZYzF8rFdMN8nvcLqmXU8ltzDE94xwx/oot6i1bVwHMW69VnPn53yLGE
 YustmJ+51TtEzVlp8xWo2AjiaYYPxw5/R4GqMTzsFBrGum/9S94TKIGU4S5aFdXTDd/20SvxzKH
 UZI8Yq+IR4GE4kKG6lNuNYMDzmoDc24u32xaIp8cXkYGSxA183mW9Gc/zqXv6WYtaMGJ6YrDNmR
 au+HpChs0GlETayvw==
X-Received: by 2002:a17:90b:288a:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39dd5478be2mr860652a91.5.1789267362389; 
 Sat, 12 Sep 2026 19:42:42 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 56/86] tcg: Generic expansion of tcg_gen_rotr_*
Date: Sat, 12 Sep 2026 16:38:07 -1000
Message-ID: <20260913023837.741866-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
index 91faccf568b..6c6a7f930c8 100644
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
index 1a9e05775f8..837c43e6587 100644
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


