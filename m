Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D719C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 17:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhuvv-0007qk-UA; Wed, 06 Mar 2024 12:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvp-0007jV-BO
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhuvj-0000hL-Fy
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 12:19:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dd0d46ecc3so380525ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 09:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709745583; x=1710350383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak1cEhiv4FX6M5PoItIiivnOuHJARZ/LokTRBdzbTFU=;
 b=H8p+Aqi7XmZM2AXMSNcyUn4lGMo+F6T23mJag3otHs5CFHDsaEU4BYFEPmVeMx5EIn
 uYJv/ag+K0R2U27QVpA6xUq66HeOaHeBvQTt5xA2Xg3/qTUwxderAgs70TYsNtlKpLDO
 uFyUcHEiKowK9SCRoAO/RBQ8RQQGcV6lJtcX4s84m4XDmQ7NisDWVwbDv7pmzhCj4B+p
 uNXfjG/H1yFM/XYR/75gXGktveiymdxY9RZJ4fXvMIxLQ7zmsVdVsN1H0V7cRHosD8F5
 3UI3pHwyR6X0RV2BkzfiBZdtnYLFM1LC1xPBhbXLrBaggBeG55X4W+GZWa3XigPtE3hO
 zhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709745583; x=1710350383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak1cEhiv4FX6M5PoItIiivnOuHJARZ/LokTRBdzbTFU=;
 b=he19+C5lbCtN1dLcwoiZX4Dc3/uTeaPPdBnmvftSkcsu59N0I3/oNUXDn7eV+rGELk
 q2EaCdUw4R+GiX8xtKE9rfZRdoquon29BupaONOTryIiNEdX6PPUAq7vIPRUl0FyiR1w
 Th8HsCWtUbGCGMvDVTTjckibUidE0XWewXRl5IY3o9vkB0M3n0aUV2Qn6NTGEC/ttzTe
 BakpBj0BxGjqDO1PDUJ/5f/VVWofyY1wlIw8FD5el0LjcEpy8bsqg6cIyBJH25YjUBqL
 e9uk8k5JA+Pz2FbX3ygtAy6Me8SInD2Y8zjA1y3zbvPygYl8U260acYks9j6+UXdMUw+
 pTlA==
X-Gm-Message-State: AOJu0YyFC1pEs37AJKRQi1DiezTlwinfWybtXb/XycXamIafm55P9GLk
 XFn0SbcmgTUmNGDIPo2Hg6uLLZ/UhBL7sFenV45lE60rIY10+j6+wgwa/+0BKEjrzVPgoU6HHTh
 b
X-Google-Smtp-Source: AGHT+IGY+uyKpv2yj7azD5dkxbt7s2qsi+GtL7rpQ24ZDYRMa3rBJvUo6veQgawlq4lGHXofFjaxTg==
X-Received: by 2002:a17:902:ea0b:b0:1dc:8790:6824 with SMTP id
 s11-20020a170902ea0b00b001dc87906824mr7319838plg.15.1709745583608; 
 Wed, 06 Mar 2024 09:19:43 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a170902c71100b001dbb6fef41fsm12869712plp.257.2024.03.06.09.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 09:19:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 2/9] trans_rvv.c.inc: remove 'is_store' bool from
 load/store fns
Date: Wed,  6 Mar 2024 14:19:25 -0300
Message-ID: <20240306171932.549549-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240306171932.549549-1-dbarboza@ventanamicro.com>
References: <20240306171932.549549-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bool is unused in some load/store functions that were changed. Remove it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 58 ++++++++++++-------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b838b8ea5b..e42728990e 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -796,7 +796,7 @@ typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
                               uint32_t data, gen_helper_ldst_stride *fn,
-                              DisasContext *s, bool is_store)
+                              DisasContext *s)
 {
     TCGv_ptr dest, mask;
     TCGv base, stride;
@@ -843,7 +843,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -877,7 +877,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
         return false;
     }
 
-    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -900,7 +900,7 @@ typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
 
 static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
                              uint32_t data, gen_helper_ldst_index *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     TCGv_ptr dest, mask, index;
     TCGv base;
@@ -967,7 +967,7 @@ static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, NF, a->nf);
     data = FIELD_DP32(data, VDATA, VTA, s->vta);
     data = FIELD_DP32(data, VDATA, VMA, s->vma);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, false);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool ld_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1019,7 +1019,7 @@ static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
     data = FIELD_DP32(data, VDATA, VM, a->vm);
     data = FIELD_DP32(data, VDATA, LMUL, emul);
     data = FIELD_DP32(data, VDATA, NF, a->nf);
-    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
 }
 
 static bool st_index_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
@@ -1098,7 +1098,7 @@ typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
                              uint32_t width, gen_helper_ldst_whole *fn,
-                             DisasContext *s, bool is_store)
+                             DisasContext *s)
 {
     uint32_t evl = s->cfg_ptr->vlenb * nf / width;
     TCGLabel *over = gen_new_label();
@@ -1129,42 +1129,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
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


