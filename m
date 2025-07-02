Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DF3C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgB-00081a-Q5; Wed, 02 Jul 2025 08:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfm-0007Zg-GO
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:47 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfZ-0000z1-S3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:46 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2efbbf5a754so3004908fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459669; x=1752064469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AUY72MQ1kLespnWy6+gTZuXwFdz1x/T5obJXeRu/P0=;
 b=TJ8uJMPMZiQNdDcZPxgT116DLjCMhzahPNeTmL20vhgosbyRsPTH6oGR3B+UdYOIT8
 6agF+qjLaawy7fzbkofyTeODThnNWBF9fNVog5Eng5LmbYPU9dMAsJv/dEzm2l1dbFwu
 73DQatzOkXPsE/1BgaJS+knMfXmKRLA8AKx+/ynCwQxrf5suwhEAwtT5zUHnxIE29+55
 zqZHm2poLKwiaFrtl0leKgf/AcLxx+/Wcdm30H5ZPDVd7feIAR8+tumRbHK5nSGbFy6e
 FURI1Z5Pvwp2qmr0vf2PcnoewDsgz4InsDMKtS87Us3rdNI0b+opEgadqNxw+mF5/1Di
 Ug9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459669; x=1752064469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AUY72MQ1kLespnWy6+gTZuXwFdz1x/T5obJXeRu/P0=;
 b=pPg8CyLyyJBfJvN/VnjmW1VAL1AbMHdB2L5XBwzWRx7e88ICHJbK73fj8xrzmgkuDc
 s4Ee04+SaM+Cq5cIhMfpPu+RAa/dV9eABLg9yLI+ZM8J+xIO9+xTF8jYjtKsUqThs05C
 ME/SKDJgQPEu+HL0bLyxn1n8K2et0NEDnRhLz9mCRZ0RYpfP1A4zK5iSy5v5awOzUmO2
 GugBfr/TicGro4Wj7jCD0ZEIcKgEqQGY4E+ywbHrE1IY/NmArcFI0DiiZApgyODnpErE
 VMHwKZiPuyvigYKGJy5wjIPXNSPVp1KI6gWdHT86mnDpEjCMB5u0sZk7Re8nichEItAk
 gTRQ==
X-Gm-Message-State: AOJu0YyJyBiKT+wP26d2st1O4CkICjCn6VWP5/e/ElnI6vM1LdzKbhe+
 NjQICPuYyDrySvqBXqtZzDp8H9+iEbpEeomUUjFfJlebN39CwYQNLPLZBfrBO/ff4fAhSbDgtso
 oQt0FSaA=
X-Gm-Gg: ASbGncuvmHmwG4Bbtz+7ihiIktfR8onA8kRYeduNo0/JPH91WCkiXNn53Q1Hyxs95aL
 Bq4CTCFFgcLCJZtqKJwyIeXjIKksSyR3nChL/1FiKsbTe07u0ApgsqyS9Z+X8j/gzH8nCkjwuvu
 mZvgSdq+y6EV3mNcWm0zzXlZa4N+PjyKGMMyvFlQvi13SN5H0fB+jF6lFhr7lejxNixT6dDd5HK
 djRotfBSxI5GvJhnygJypWw0ywX1/4XN1y0iSs9mBzGX6zq8ePBrW3aEhm9DIv01LgV1i7ag4SC
 n9wQOwbRB7CjJn25EZw8ef5A09Ijax5yg8tHbv/nsyUW2qMTzJDrqei6Ew8olkYsDyArtLQ79Il
 RRUKq
X-Google-Smtp-Source: AGHT+IEA2fZedilkD7J7t1IM33r6OlvfNi6a2MHy2DBoY86wALmLGEA6QRGSc1jAKNA0St34zLPnxw==
X-Received: by 2002:a05:6870:9593:b0:2ea:7e18:5838 with SMTP id
 586e51a60fabf-2f5c63fc10dmr1809877fac.13.1751459669385; 
 Wed, 02 Jul 2025 05:34:29 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 13/97] target/arm: Split out get_zarray
Date: Wed,  2 Jul 2025 06:32:46 -0600
Message-ID: <20250702123410.761208-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prepare for MOVA array to/from vector with multiple registers
by adding a div_len parameter, herein always 1, and a vec_mod
parameter, herein always 0.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 47 +++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 2c8cb24b7c..ea0e5a7cb5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -43,7 +43,8 @@ static bool sme2_zt0_enabled_check(DisasContext *s)
 
 /* Resolve tile.size[rs+imm] to a host pointer. */
 static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
-                                int tile, int imm, bool vertical)
+                                int tile, int imm, int div_len,
+                                int vec_mod, bool vertical)
 {
     int pos, len, offset;
     TCGv_i32 tmp;
@@ -52,10 +53,23 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Compute the final index, which is Rs+imm. */
     tmp = tcg_temp_new_i32();
     tcg_gen_trunc_tl_i32(tmp, cpu_reg(s, rs));
+    /*
+     * Round the vector index down to a multiple of vec_mod if necessary.
+     * We do this before adding the offset, to handle cases like
+     * MOVA (tile to vector, 2 registers) where we want to call this
+     * several times in a loop with an increasing offset. We rely on
+     * the instruction encodings always forcing the initial offset in
+     * [rs + offset] to be a multiple of vec_mod. The pseudocode usually
+     * does the round-down after adding the offset rather than before,
+     * but MOVA is an exception.
+     */
+    if (vec_mod > 1) {
+        tcg_gen_andc_i32(tmp, tmp, tcg_constant_i32(vec_mod - 1));
+    }
     tcg_gen_addi_i32(tmp, tmp, imm);
 
     /* Prepare a power-of-two modulo via extraction of @len bits. */
-    len = ctz32(streaming_vec_reg_size(s)) - esz;
+    len = ctz32(streaming_vec_reg_size(s) / div_len) - esz;
 
     if (!len) {
         /*
@@ -111,6 +125,14 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/* Resolve ZArray[rs+imm] to a host pointer. */
+static TCGv_ptr get_zarray(DisasContext *s, int rs, int imm,
+                           int div_len, int vec_mod)
+{
+    /* ZA[n] equates to ZA0H.B[n]. */
+    return get_tile_rowcol(s, MO_8, rs, 0, imm, div_len, vec_mod, false);
+}
+
 /*
  * Resolve tile.size[0] to a host pointer.
  * Used by e.g. outer product insns where we require the entire tile.
@@ -177,7 +199,7 @@ static bool do_mova_tile(DisasContext *s, arg_mova_p *a, bool to_vec)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_zr = vec_full_reg_ptr(s, a->zr);
     t_pg = pred_full_reg_ptr(s, a->pg);
 
@@ -259,7 +281,7 @@ static bool trans_LDST1(DisasContext *s, arg_LDST1 *a)
         return true;
     }
 
-    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, a->v);
+    t_za = get_tile_rowcol(s, a->esz, a->rs, a->za, a->off, 1, 0, a->v);
     t_pg = pred_full_reg_ptr(s, a->pg);
     addr = tcg_temp_new_i64();
 
@@ -281,19 +303,14 @@ typedef void GenLdStR(DisasContext *, TCGv_ptr, int, int, int, int, MemOp);
 
 static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 {
-    int svl = streaming_vec_reg_size(s);
-    int imm = a->imm;
-    TCGv_ptr base;
+    if (sme_za_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int imm = a->imm;
+        TCGv_ptr base = get_zarray(s, a->rv, imm, 1, 0);
 
-    if (!sme_za_enabled_check(s)) {
-        return true;
+        fn(s, base, 0, svl, a->rn, imm * svl,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     }
-
-    /* ZA[n] equates to ZA0H.B[n]. */
-    base = get_tile_rowcol(s, MO_8, a->rv, 0, imm, false);
-
-    fn(s, base, 0, svl, a->rn, imm * svl,
-       s->align_mem ? MO_ALIGN_16 : MO_UNALN);
     return true;
 }
 
-- 
2.43.0


