Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E75C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nq-0002PU-5i; Thu, 17 Sep 2026 00:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nV-0001es-Vz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:40 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nT-0007Hg-0r
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:32 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469f20513so278205b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619549; x=1790224349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zm24+dLCs606J8p1fpHH1+kH1dAQHMuG8bBV4e56uuU=;
 b=KAtJdS2eOv514m4VMBl1zu4rux4JhoUhgeWAI7+gDezCvTVgIOjx4eeUvR5Jk1qQod
 bKJFpBUmfsjj0WpkFJ8mJXrueEdeFHy7H8AQG5qXuvXqlAg/enk/XaMwHK3wqcW81pmy
 UhNybrSGOH9nayjfimqlOcMeV65pWoS7g4kxwCiUoJhL+FWNF++UeEFP1/bKnLlRI8X5
 WtXHYkQOCw8gZQYpLB+wNX5w+qShs0YwZduqE9/ca80AHEnjUr3/BCWVpt/SY8WupZ8d
 ddQIm3d+UOEcIeEGDFdUTFDl0gvaELJrFO4kyQcN3ZccEZGBeJp0g8m54gKr4i/fcU20
 9oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619549; x=1790224349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Zm24+dLCs606J8p1fpHH1+kH1dAQHMuG8bBV4e56uuU=;
 b=UyyyQNqjJDbzWXGd8GnyDQvbPCDmY50SUTajLGMFXg4OqXCn9yJFhl5aZX1VJUrxVT
 cwoYAbmBl7rhJmDo6+Ze9VetnEkjktK8KcF70rNhYjIOQm3ycCCo4S2VB3enQxFVhzlW
 bRy+q4SkFIgJk4lSigtkJjG8+i3ADNrjri03R1ClFmrUUszx1WLWVA0ZWdZ2bjoDqoOZ
 e3Kyq6ngVHD3ofvh7HuXyeqmla5V9+7j3J/NB4dl6yqiXv/Lj6wXbusX84a+VAXH9VdG
 NkYNcIilIE605XdVzmuk0nLQigWX+V8pdnU0YVZVePJ/JEP/niokCSCGsGvrqvfkU7TF
 tTTA==
X-Gm-Message-State: AFuF++nly9Pfzjc0JFNvjytoNB7QV/ZiqEr/ZFE1eVCsP51+rag58q0i
 Rbjxs0PqgmpO9oMyqMgxK0B3ZafyPZD8Hyd99K613Afbt+gEetJBM8CVHfoSfqyE1IsAd6OqqT9
 7EMQFO/U=
X-Gm-Gg: AYBFou2XGBx4iDXYVzkpbfl3bkCcmx94apInrqbCzYHR45ItDC/qFOKz9f1cAp7yoli
 8i22Gg+Irnyzgreq1VgwIUpz3gNq2I367tCzjnatbe+rOjC6AeRFRyV+hFSy1BMxgYYM+ZV7pmv
 7NDJJqR48TBhN3sSikKP/3Ol0Mqs45Ro20qYlVzITOHAXSPB2GUDJOu/GhqndG4zYzb3KEaUavl
 P1y5ir6biIVMUDv7rug0UD/Ma/gPrk4uR3INHrWbAylzVVPp70iDXoIAHfRuJx+AFGvTwRg8a/d
 XxmZ1cKw/iaazSWg9hV7RguKjPA48hSR7FOGiBdOyYNto4KVCwQoEeG4ajxUR/Swhq6GvJkr6zR
 cnLi1L5mvKTvpM/UqDWiQTfNW+7W2oa9co2shN3wPo9Z9Hcpkt1f+p0q+aw7ksF0LRGPPZCSiMh
 Ea8Do+e9rCafjyM1MFl7+gbmF84uOu3y1dLdDx5uCNalelK78CR6fKztNr0fqDYqvlQuc2JFCgG
 35n4NOsay3Hk3VQvQ==
X-Received: by 2002:a05:6a20:914c:b0:3d3:ae1f:d7f6 with SMTP id
 adf61e73a8af0-3dd5f74d755mr12740782637.22.1789619549530; 
 Wed, 16 Sep 2026 21:32:29 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 061/101] tcg: Generic expansion of tcg_gen_rotl_*
Date: Wed, 16 Sep 2026 18:27:43 -1000
Message-ID: <20260917042823.542588-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

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
index eb3c55ba69b..6a34798ad79 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -838,6 +838,26 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        gen_shl(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shr(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -939,27 +959,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1770,27 +1769,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


