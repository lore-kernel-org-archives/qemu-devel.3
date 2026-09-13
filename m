Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC09FC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a87-00019i-Km; Sat, 12 Sep 2026 22:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7l-0008Uf-M1
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:23 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7f-00014Q-Ta
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:20 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc4bdf8acd6so727152a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267153; x=1789871953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FT5i7omdgeqTtEKejEMXy1b/3oPoi7YPkLLjuk15T3o=;
 b=UioZJQ9R7h/dms/x0W8pf1AriLhPfIQIgKJQg3uVJ1JJN9KA7YwnYDZwCga05WQGfu
 TsGJkgvQCgiRNjt4/2dFOjy8U9UPw2enobysQMPoStjyqo9gkOl5huAJxpLBZ+twm3Sg
 IbWWbuucn6V9QXcMbhxIRS7COCNLoznsfMKf9XmvKfZ06yUWhpvVd4In5WyHlocvqQlp
 c/awWx+Nsamuwj6ueD9vHKWVKZBWcqfQBbO4aGxOSuiTUKjPrQdZPmWEgqFwqeq8QBzU
 +fzUvb6wDjcFgCTVm3yIByRWwwP2w7OWnEgg3tQBJU6f0ALo5o5jCEABnWR9YLM2rtLw
 WeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267153; x=1789871953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FT5i7omdgeqTtEKejEMXy1b/3oPoi7YPkLLjuk15T3o=;
 b=QrJ31bRsR5P5qTVotURefIwptV5EJyATzCUa3xoNqGzbxxm2tWORmznoQ8oZ5wcmQI
 IU5Z92pcG0AoysO9vpl7QtbRF4HaX/+AJRX2YTFZ3ee+uLyLrqF4eIpBVHs8mr9K0Vfk
 pj858VM9G0VpDIzi/MfMgAdK3+Hb5BJYqBZ9sbKOxG13kkowj7nZvG92XjQVYl7XtbsU
 +OF5ZLZGeFKmzkaE8PGL5Z4WjkSPrQ9M4QYjNnSfctM/AD4D86zqFQNHzaGhLKBNXp8Q
 mfeQxBq8P3GVSF2UpZ6viChwzyC081+IYSoONErv/t0yCPVoZaT9qg4ACmY/HJo9ZWrf
 FHXQ==
X-Gm-Message-State: AFuF++mztrh7oScrScTStdEkaPvTJPcW3J9q4w9yBrZx7W93uBkH+QKf
 HkcEHd9gDg/TmGfIcJEDF71mBGl7CNde6nk/0w6TC17ccoVIf+DEA3vZubZNGfoO3UlbMHjWG0p
 CYjO5
X-Gm-Gg: AYBFou2V6eYp+UAnFX6FhTbzVkKW3qoPmXA3oR4m9+8k0+IWOTsLco6rO0oC+c6iRD+
 ORuXOgU/CIcUKpnj+XqcAO2NwxluYRvKQpveIJnuHnQfEdl2vO+yaB6dd6CDek7MjUSHXdCcGIu
 PjeFxY+qfVrdnF/2zq+QqM38xmPOI4Gn9tcIK/yYSYjVsxu2ySW/HCbJHzNxsWTeBvHACtY3yhu
 Aqel1cIy90usT4kJ8Qql3utFge0LXBQzzoNDs2hUn2+l6rD4h3puHoUHPGO3S0/AaDxackbPqQj
 75158c0GHRMO79gZtoXAd3o6KnnZrrZgsip0gBzpQN8DYYYTCjDdymzeZtbYxbrsMBNDtESliOG
 Gg8vYlM4K/uak7LGoppWPR1kIjcFE91/lp9UxsumXVWR+/i5Jtfu4QYY40sUbvWLPnu8K7nV/jj
 0O6eyN6dHkdduu7kk/y18du152N/R8nsqHMxmd+NALVxOQsiWDalYwWFP/4Lc3vW5j+Lr64V2M1
 tsrjwMXn96bR0S8tA==
X-Received: by 2002:a17:90b:390f:b0:38e:bbf1:de3f with SMTP id
 98e67ed59e1d1-39d9c0b7047mr19238031a91.12.1789267153165; 
 Sat, 12 Sep 2026 19:39:13 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/86] tcg: Generic expansion of tcg_gen_rem_*
Date: Sat, 12 Sep 2026 16:37:40 -1000
Message-ID: <20260913023837.741866-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x29.google.com
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
 tcg/tcg-op.c                 | 62 +++++++++++++-----------------------
 3 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7ab4cbac632..c1f9b3fd37c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 473d472823c..67261d12741 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b71c76de375..9f5ccecdde0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -534,6 +534,28 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            int width = tcg_type_size(type) * 8;
+            gen_sari(type, tmp, src1, width - 1);
+            gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -673,26 +695,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1587,26 +1589,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


