Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDFCC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:26:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYYd-0002TR-GW; Tue, 20 Feb 2024 17:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYN-0002Pg-VG
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:32 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcYYL-0003Xk-1z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:25:30 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dba94f9201so39099575ad.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 14:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708467924; x=1709072724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pztqgJbiUkV/hJi7o1zBM7DA1XiTtD4zGsAJDwvJtmc=;
 b=jBgn+t+KHi8WpoI3WANHqA0S4QeDF4KYoizFkwuX60Q7Fr8IPSI9vKhJPtINaB1+ag
 FSTrePhpHnPMa0jIajvqZag8kaCeVsGfHL7OizaoyANqgsBkVwBSIxbo+jJBk3HMp0hr
 pvATOm5vJoiMhyDgvInGqiOXoxwTgCmF7GhOLdH4qvECqDaKEv18zE1bkjOC5iQpTJhb
 Fi5JzBqDBpfvqozPbGNwqY1z8ZLcBuI1FOEgaU5ZwUQh4YIa2+rA+s14osZd8mMizuLf
 0ew8H4Y+h6QJA3huGso9QzRhguYEVHjiOHmaOUdi2DdgwKqYgyCI5WneqLQEZVbXszfN
 L8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708467924; x=1709072724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pztqgJbiUkV/hJi7o1zBM7DA1XiTtD4zGsAJDwvJtmc=;
 b=Zzis3kyMqOKfVx3zpvjPAOvKUSaRPodIuVbYFAULvvM4L8z/3a5tetzPTIS3w8+V2C
 ea7sGW0AREg/XDeVUK26UsRAXGg4ej8DW/O/ZO50hcgjg4r8/E5hwWjoCEeYPeIaqlm/
 jbKk8eTup0YrLpKiWaOes7QYtmmlnh8qaQ4IYsrOHyEjkmE7E8y6h8Sm+SPI0p9qE1nj
 oe0sDIcej/waNxIgBWzbD+hby5FzG+URc4lqi5C9SyFao6bOE8btdxg0Ue2sF/JHVeAb
 TAP/wo39Vi88jcoj7favzCzQbRCRU13cMcsLEWrao2G5tUYVkpxrAOUxpZaorRHKyRGt
 PM6A==
X-Gm-Message-State: AOJu0Yz4shbv+mdMh9svCqlMcezI4I7We4OlzFJe7DyZzNQ5velbvqOk
 7H3PEr2rI3ev5cFxKKw3aJ/XN+PbQl5xH3UO77iyMwpP/8XTSP3Ve2ZKE2meKkkloq21v3XpUqT
 a
X-Google-Smtp-Source: AGHT+IEdAEXSkSk5NdS1ahFj0aqFn9i6RhUFL5ZgCa+05JuWQcS+Yeecy1lg34GeHGNuTLqituGxug==
X-Received: by 2002:a17:902:fc85:b0:1db:cbdd:53f5 with SMTP id
 mf5-20020a170902fc8500b001dbcbdd53f5mr12649456plb.21.1708467924395; 
 Tue, 20 Feb 2024 14:25:24 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 iw20-20020a170903045400b001dbb86b88e5sm6761044plb.124.2024.02.20.14.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 14:25:23 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 2/6] trans_rvv.c.inc: remove 'is_store' bool from
 load/store fns
Date: Tue, 20 Feb 2024 19:25:06 -0300
Message-ID: <20240220222510.209448-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220222510.209448-1-dbarboza@ventanamicro.com>
References: <20240220222510.209448-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

After the 'mark_vs_dirty' changes from the previous patch the 'is_store'
bool is unused in all load/store functions that were changed. Remove it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 69 ++++++++++++-------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 7a98f1caa6..15ccebf3fc 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -609,8 +609,7 @@ typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
                                 TCGv_env, TCGv_i32);
 
 static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
-                          gen_helper_ldst_us *fn, DisasContext *s,
-                          bool is_store)
+                          gen_helper_ldst_us *fn, DisasContext *s)
 {
     TCGv_ptr dest, mask;
     TCGv base;
@@ -673,7 +672,7 @@ static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
 }
 
 static bool ld_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
@@ -710,7 +709,7 @@ static bool st_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
 }
 
 static bool st_us_check(DisasContext *s, arg_r2nfvm* a, uint8_t eew)
@@ -739,7 +738,7 @@ static bool ld_us_mask_op(DisasContext *s, arg_vlm_v *a, uint8_t eew)
     /* Mask destination register are always tail-agnostic */
     data = FIELD_DP32(data, VDATA, VTA, s->cfg_vta_all_1s);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s, false);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
 }
 
 static bool ld_us_mask_check(DisasContext *s, arg_vlm_v *a, uint8_t eew)
@@ -756,7 +755,7 @@ static bool st_us_mask_op(DisasContext *s, arg_vsm_v *a, uint8_t eew)
     /* EMUL = 1, NFIELDS = 1 */
     data = FIELD_DP32(data, VDATA, LMUL, 0);
     data = FIELD_DP32(data, VDATA, NF, 1);
-    return ldst_us_trans(a->rd, a->rs1, data, fn, s, true);
+    return ldst_us_trans(a->rd, a->rs1, data, fn, s);
 }
 
 static bool st_us_mask_check(DisasContext *s, arg_vsm_v *a, uint8_t eew)
@@ -776,7 +775,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
                               uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s, bool is_store)
+                              DisasContext *s)
 {
     TCGv_ptr dest, mask;
     TCGv base, stride;
@@ -823,7 +822,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -857,7 +856,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
         return false;
     }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -880,7 +879,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     TCGv_ptr dest, mask, index;
     TCGv base;
@@ -947,7 +946,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -999,7 +998,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1078,7 +1077,7 @@ typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     uint32_t evl = s->cfg_ptr->vlenb * nf / width;
     TCGLabel *over = gen_new_label();
@@ -1109,42 +1108,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH, IS_STORE)               \
+#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF, WIDTH)               \
 static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
 {                                                                         \
     if (require_rvv(s) &&                                                 \
         QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
         return ldst_whole_trans(a->rd, a->rs1, ARG_NF, WIDTH,             \
-                                gen_helper_##NAME, s, IS_STORE);          \
+                                gen_helper_##NAME, s);                    \
     }                                                                     \
     return false;                                                         \
 }
 
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1, false)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2, false)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4, false)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8, false)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1, false)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2, false)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4, false)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8, false)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1, false)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2, false)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4, false)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8, false)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1, false)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2, false)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4, false)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8, false)
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  1, 1)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, 1, 2)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, 1, 4)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, 1, 8)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  2, 1)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, 2, 2)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, 2, 4)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, 2, 8)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  4, 1)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, 4, 2)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, 4, 4)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, 4, 8)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  8, 1)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, 8, 2)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, 8, 4)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, 8, 8)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1, true)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1, true)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1, true)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1, true)
+GEN_LDST_WHOLE_TRANS(vs1r_v, 1, 1)
+GEN_LDST_WHOLE_TRANS(vs2r_v, 2, 1)
+GEN_LDST_WHOLE_TRANS(vs4r_v, 4, 1)
+GEN_LDST_WHOLE_TRANS(vs8r_v, 8, 1)
 
 /*
  *** Vector Integer Arithmetic Instructions
-- 
2.43.2


