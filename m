Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB004CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwh-0005zO-AQ; Thu, 19 Sep 2024 09:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwJ-0004di-Cz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:19 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwF-00010d-At
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so6575455e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751473; x=1727356273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zURWD2EwiMkoq8peBlm9KWuzJycV0Jiua+pYVgeZppE=;
 b=ePTk3eZInNbFpYTFyIYM+HH3awTSybwTs9rUl7woQHd03xAfn+ygAxVXP0h2gGyEZY
 JBqCJqUFrH6mJb7NNg74FKLounoDefW7Olqp7wVRLzeyb/Ggn6wJ2PmNiehRGQtnX2+Q
 GOSsPNjuORWM7FNNgRS0TjNXlwObjh4ESMFpI7PGfwfKlvEBEY1zFTZKi8ukqHvK/RH1
 kLgsUhxOzT8WhvQ/5wJ0l2ZdfZN3eNwma0qdQ1UBmYKwweC+r1EOxXoiBF8I/XjSLv0V
 670mK4UO69FIn6lXZ7jCdMPmC6WG/5fEiuZI3Xg7jUhKhsaTtxYM96SVFhZh7ghZBznV
 OC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751473; x=1727356273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zURWD2EwiMkoq8peBlm9KWuzJycV0Jiua+pYVgeZppE=;
 b=Xa6SN3IBHFrFqa4HM+rjRg9TuftMQQOe/f2Cak0tiLTfASWdWORAnyPlCPi0/h0zSE
 7lclMw8JbgBRQSDfzvggu+4+JwwXWkGi6UzkFbiKzXJcwUizkSmX2huZXNzEHhEfL3nv
 KkM6WwCdh1aMKxU5urNbvkORF6cOaDHKSQOqASSwEFG6eFbDvzIC4L2/bKAuhj6R5E/k
 x65Q9pJoitXrorIkfWu2YmL7FIcOVcwvQm4/XuaGBs6dqH4UTPvStqjDv6z197XSAkFv
 qUIjR3AqidLcO4xM2L2fK2+dqaGa74NTjbxf3+icFcQjPpYo3jcqqQE4szg2gbgkjV9S
 PVvA==
X-Gm-Message-State: AOJu0YygVp03LJQssHCNWtw3xD4z3mQYo43hmHpeJzwVBVKNOSoWq58h
 O4xV72EBeRH2cPAgaY9+/pNdlsx+PxRZZh+U7rCv0GzJi22mXhhKdQ77g/J2qy94cw8tSFXEslP
 E
X-Google-Smtp-Source: AGHT+IExChSOfmp/VwIiq6YyztkepKEHuLZAsw0IJDiD205t4+ecIeXE09Fg0Fgkyrnb402lSXJF3A==
X-Received: by 2002:a05:600c:1c9a:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-42d964d8579mr155304525e9.22.1726751472981; 
 Thu, 19 Sep 2024 06:11:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/38] target/arm: Simplify do_reduction_op
Date: Thu, 19 Sep 2024 14:10:37 +0100
Message-Id: <20240919131106.3362543-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use simple shift and add instead of ctpop, ctz, shift and mask.
Unlike SVE, there is no predicate to disable elements.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 40 +++++++++++-----------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 04160b25136..74efb351648 100644
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
2.34.1


