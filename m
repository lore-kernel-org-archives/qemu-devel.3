Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C33ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAF-0002Xy-02; Mon, 09 Sep 2024 12:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAD-0002T7-SO
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:53 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAC-0007iH-8H
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:22:53 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2068a7c9286so41256835ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898970; x=1726503770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htF5qh+BwrQAazett+74anTVYDcrx88zDGCrAO2eD7Q=;
 b=VQ0t9OUgc/t7WEnf0JG5m7Tg30niJaPWJXBmcG7I7Fs0aDT0X+kV9dbCRs9+3IQyEV
 t8vGi6ZDFkRtH7lONbN7Z++k+pR8xIpOBBm37g3xG6yAK4oYt1Z9Iir57yW487t2uK6F
 agDFDKwybCM5nIBezWsKVufpu4QdIcmWErAfN7kvFlifaWDb3WVwuiXu749tF3PWzIaZ
 BJzTbBlFkuUC/ql2HbsnoGwEi0VhSVAaq0aCWZgU2JpM9jwvA+k6KFFC4N/fhmjYeF+u
 xSeOV1ciuZV7LL+nDyzwsyMyOjsFYA0tq6MewtrzraCBN9WnBL6qB8vE2Ir9+cfVXwp5
 KlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898970; x=1726503770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htF5qh+BwrQAazett+74anTVYDcrx88zDGCrAO2eD7Q=;
 b=iA/RyGLic/L82re+5brpDV3KS23iFTDAgXByRsrq6Y7DdvLoJaXpftv+4WTt15hAHp
 zpkHajJwKmuOWaaSW513S1U0y2uVjD1Reu7w27xEQa6LWMbtCliY9LGUOk7QP2IFwo3k
 oHAUuK36Nj5XGg7PIziZomS/9AGh0YyiUqW8oTM4mUlthvtJh7VLO28sDnyBb1EEghy7
 ocEeoRYfpIiDRpjm2+fk5iFmIn+2nhEe6hQCBVxn6Ds9sK3lqpW47HRVe8EHBzOBvzi9
 tDav5oL1k8bmuUVyPmFCCURP1X1TOxGzlZu7EE1Ub6aWyvbAAlR0rz4VOVswMiiVKmDJ
 eHCw==
X-Gm-Message-State: AOJu0Yxh7lGvwsrno6DG6q98vHTu7dH8/NnGdCA0b4xk+rZMFgrMmngP
 RElLIskyfDzbN3iH1dDpFE8T9fwo2aKwi36UaSSFbCs91D0HqLlxe50nmHqHUgbsDMoGX9/vdwr
 N
X-Google-Smtp-Source: AGHT+IHnDCshfaZ90PytRSBInZrrFGaoUSKbCZVQIkOcXEmRYHwkm8edHBVbnzVLV4lpA8GoAvw59g==
X-Received: by 2002:a17:902:cec1:b0:205:8407:6321 with SMTP id
 d9443c01a7336-206f04a01fcmr132698365ad.9.1725898970527; 
 Mon, 09 Sep 2024 09:22:50 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:22:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/29] target/arm: Simplify do_reduction_op
Date: Mon,  9 Sep 2024 09:22:19 -0700
Message-ID: <20240909162240.647173-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use simple shift and add instead of ctpop, ctz, shift and mask.
Unlike SVE, there is no predicate to disable elements.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 40 +++++++++++-----------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 04160b2513..74efb35164 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9027,34 +9027,23 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
  * important for correct NaN propagation that we do these
  * operations in exactly the order specified by the pseudocode.
  *
- * This is a recursive function, TCG temps should be freed by the
- * calling function once it is done with the values.
+ * This is a recursive function.
  */
 static TCGv_i32 do_reduction_op(DisasContext *s, int fpopcode, int rn,
-                                int esize, int size, int vmap, TCGv_ptr fpst)
+                                MemOp esz, int ebase, int ecount, TCGv_ptr fpst)
 {
-    if (esize == size) {
-        int element;
-        MemOp msize = esize == 16 ? MO_16 : MO_32;
-        TCGv_i32 tcg_elem;
-
-        /* We should have one register left here */
-        assert(ctpop8(vmap) == 1);
-        element = ctz32(vmap);
-        assert(element < 8);
-
-        tcg_elem = tcg_temp_new_i32();
-        read_vec_element_i32(s, tcg_elem, rn, element, msize);
+    if (ecount == 1) {
+        TCGv_i32 tcg_elem = tcg_temp_new_i32();
+        read_vec_element_i32(s, tcg_elem, rn, ebase, esz);
         return tcg_elem;
     } else {
-        int bits = size / 2;
-        int shift = ctpop8(vmap) / 2;
-        int vmap_lo = (vmap >> shift) & vmap;
-        int vmap_hi = (vmap & ~vmap_lo);
+        int half = ecount >> 1;
         TCGv_i32 tcg_hi, tcg_lo, tcg_res;
 
-        tcg_hi = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_hi, fpst);
-        tcg_lo = do_reduction_op(s, fpopcode, rn, esize, bits, vmap_lo, fpst);
+        tcg_hi = do_reduction_op(s, fpopcode, rn, esz,
+                                 ebase + half, half, fpst);
+        tcg_lo = do_reduction_op(s, fpopcode, rn, esz,
+                                 ebase, half, fpst);
         tcg_res = tcg_temp_new_i32();
 
         switch (fpopcode) {
@@ -9105,7 +9094,6 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
     bool is_u = extract32(insn, 29, 1);
     bool is_fp = false;
     bool is_min = false;
-    int esize;
     int elements;
     int i;
     TCGv_i64 tcg_res, tcg_elt;
@@ -9152,8 +9140,7 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
         return;
     }
 
-    esize = 8 << size;
-    elements = (is_q ? 128 : 64) / esize;
+    elements = (is_q ? 16 : 8) >> size;
 
     tcg_res = tcg_temp_new_i64();
     tcg_elt = tcg_temp_new_i64();
@@ -9208,9 +9195,8 @@ static void disas_simd_across_lanes(DisasContext *s, uint32_t insn)
          */
         TCGv_ptr fpst = fpstatus_ptr(size == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
         int fpopcode = opcode | is_min << 4 | is_u << 5;
-        int vmap = (1 << elements) - 1;
-        TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, esize,
-                                             (is_q ? 128 : 64), vmap, fpst);
+        TCGv_i32 tcg_res32 = do_reduction_op(s, fpopcode, rn, size,
+                                             0, elements, fpst);
         tcg_gen_extu_i32_i64(tcg_res, tcg_res32);
     }
 
-- 
2.43.0


