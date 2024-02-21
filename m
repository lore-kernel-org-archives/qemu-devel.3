Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776FBC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 02:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rccGO-00034k-4r; Tue, 20 Feb 2024 21:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGM-000347-0i
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:10 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rccGK-0001G9-5G
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 21:23:09 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6da9c834646so135065b3a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 18:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708482186; x=1709086986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pztqgJbiUkV/hJi7o1zBM7DA1XiTtD4zGsAJDwvJtmc=;
 b=Xys04fJ0ZyiFY5Tv9FXJnD9u1/1AVwC1Z0dwS0wxcPPs0rE50QACF8eO6LWlM/9NR4
 5UYJiTapDfSLotq/TRa+68STmxe/ZIUPiTO0F3U3ce49bjD2ohn+lXyzLcn00HdRVdtg
 H1QZUj5oKmUCdflAtXdVDVsjii3HCARWMGAvalloyVgz0/njtsQOfaAANap/jbOrrOn4
 X7FltSoxbBWp4yLo0vjZTDCuIQn6WGiDPmLlVgNJluplwIi0KzR+90TE8aptGRqi1Uvx
 tQYsMfB3LiNYzHgXsZU5iLN87LK3O84dXbL3FxEOVX9sIDz1RvMfB2HCPhQJe0ML1H2v
 6YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708482186; x=1709086986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pztqgJbiUkV/hJi7o1zBM7DA1XiTtD4zGsAJDwvJtmc=;
 b=A1GaDDMNz7VcpG8YxNSMouqwxw4q0pPRhuHvahvXcX2DOaJxBLyKMZCNPSzDFfDUzT
 fNwb8SpQwHGhr39AUXVdI9dA98zaNxHBhisji7kItEoMsmTq1vzv5lTE/PbSCGV0x8o+
 u0Hq6NZ1HKU40h1Drbsqw9GvCNaDj70mwDLIOpXCKwSbcV0YW52cQp0niF91C/XnfKt2
 B3tOFP01jpHhMOqxGPO6eFF6fp11FAB3LTzhLLT3Z7VPHSv0lt148ZECN2zC37YsWrQu
 g9GBl4LNE5uhMtkzIilfoP+Xn/YFjT4yF0dOEXF5XkgCereeofYePmYXTbPJRMW+WDhy
 6THg==
X-Gm-Message-State: AOJu0YxFaEly/1YusGjDhkyZHpDjv7WI1gg5oNh9PQHqJZXnyGMkjvT3
 5E/3R7fHAgCt8Dn0J68dqFTeG8cMMqIyL9U88hIPTDUEV7U1BvjvtryMNcA5qu20eD9qZ5066zW
 s
X-Google-Smtp-Source: AGHT+IE/yZT414SXU8u6g9041/M+mgXVZyigU3yfbDzERWf/wzq1BPEmRpvVZm/PrAF/POCSmwdM+A==
X-Received: by 2002:aa7:93ca:0:b0:6e4:7bc3:8a70 with SMTP id
 y10-20020aa793ca000000b006e47bc38a70mr3825389pff.17.1708482185943; 
 Tue, 20 Feb 2024 18:23:05 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a634945000000b005dc48e56191sm7183355pgk.11.2024.02.20.18.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 18:23:05 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 2/7] trans_rvv.c.inc: remove 'is_store' bool from
 load/store fns
Date: Tue, 20 Feb 2024 23:22:47 -0300
Message-ID: <20240221022252.252872-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221022252.252872-1-dbarboza@ventanamicro.com>
References: <20240221022252.252872-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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


