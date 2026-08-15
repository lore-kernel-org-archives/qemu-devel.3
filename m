Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427EBC5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKn-0007QA-MI; Sat, 15 Aug 2026 15:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKi-0007Jo-HO
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKg-0008LS-Cs
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:19 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2caed617615so28246995ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823177; x=1787427977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iUY4RptRktypsob4goKzTfAtgRhOitw3SAZ3982l394=;
 b=aVQVKXkq55wjPiBT4H3LGqy6oTCQ3gjL9NFCJ1iKXZ6IgW8WTxGGcnDCrfMESz2Y2y
 ELsomweFs7i53mLwlWDAV0Gr5J8/pG+wOzUXikw4swZwX3PS42TA/ZYE0bK3B5axm22v
 tXpa/8r/O+6FPv7lpZrlQaA7Rf9NO1/YshDekbVXoVhogsGm0kdsEMB2hwBN6SRg8t0i
 JATOZzydu84bzpt1Tl8dPrN/wLurEFCqcf61TT7cjo2EVPmVSSVJMv3NKadXkulZvzRH
 2SoSUvb78igz0WjA94c3WfC8+kG/Nm5YY1+MKzxq0NUu76euAZ3i1Xe5DuHpheMpx6z2
 VTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823177; x=1787427977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iUY4RptRktypsob4goKzTfAtgRhOitw3SAZ3982l394=;
 b=ec+eyLPUrpU0wlndNG3Qr0ErA+4tkdNzwiHukSLxt6MZW6MTorqqWu3jrYDRnVevW+
 Fzmw5IAj9uSO/vOz/XhMORXjo+8+XVtWlS1xgnGQJn3qGL9fN1Z5ogUqFfkZ4VCfUbwL
 RX3923Q0ErEnMK1U+OQE/dOkGQb90xBmPsos+LaOo0y7cxo9OJR94sjiYGJ+ZP0l+lyT
 bYnyX0jvG+jJIxih0ActvQyO+wvKBqDnLCSXDTmoZAfkLmGyzXnmhSKMCzTB8Vo+P7G9
 RjE0aHjQZCY87gD2sfh7se3xPyh6A9eg33GHURk4MDADVYCNxjjZGWwh9wG+mXpN0tdc
 sfoQ==
X-Gm-Message-State: AOJu0YwPRdZst+jfvgTiqcddnOiys3njn3PggBd2pksEhWkHNDb0hObk
 lK4u4qwBP3N/DmLnlI4z4992OHl5QwYLgdFm3VuVleTR/9tgnZjppvALePnNZ2nKQCLlLnGF5O9
 xU1xL
X-Gm-Gg: AR+sD104UNk1eucCuOp2iH/TT/+fOQ2+ThYJ4m6CbsASlVjkq+ACULhLXID0FvD2qX8
 PMd9V2iCtqbswFDXHe0abGt6eAPEWTnSPtVPINyYGy6KtmXH0sm4ut4bXUKyJ7YcqpfbEEILvYn
 jK2K5alkphHc/xn+MQmp5n+oWdHVhKxqma2bFH1BOhg+Gi/+JoPhraW16JeoFUrbr0oSkIPmfxw
 mzkUNsIm/ye2it2sHjdKJFI6UqxII5sr7qBSn5O9KCG8H9UkNhjpnIAFuIdwUkZUtB4irHnNZi6
 n5RY5xOuFIySNHeh6SeuxeB/ZiLHKLFIy/vr+om+Xid1DSe+SiTNbLg7v5lIm6phNrnutpdRZx8
 TdVTySj8N3OIO5YPhxIz7Ymm0yz4OKwrWKjsRCsfhsP/GXToJhno2FY4TLr93Dfg/jlDgqFThaE
 Qjx3Zb1yAoRN8Elxq4/zCfoeKB6wAsPEZRkmy3pADKL7bc7r9vwJXjnZXJuPnc+9daPkyYSNwLo
 Z+fcTLhT+7AbEv8lKWu
X-Received: by 2002:a17:903:3d05:b0:2c9:aae1:a611 with SMTP id
 d9443c01a7336-2d3b0fc1d57mr184020795ad.23.1786823176770; 
 Sat, 15 Aug 2026 12:46:16 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 16/23] target/riscv: Add MEM_IDX, BSWAP, ALIGN to VDATA
Date: Sat, 15 Aug 2026 12:45:41 -0700
Message-ID: <20260815194549.1377505-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Populate it in all vector ldst operations.
Not yet used within the helpers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/internals.h                    |  3 +++
 target/riscv/tcg/insn_trans/trans_rvv.c.inc | 25 ++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 9e4da39ea0..b7ffb6098c 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -94,6 +94,9 @@ FIELD(VDATA, VTA, 4, 1)
 FIELD(VDATA, VTA_ALL_1S, 5, 1)
 FIELD(VDATA, VMA, 6, 1)
 FIELD(VDATA, NF, 7, 4)
+FIELD(VDATA, MEM_IDX, 11, 3)
+FIELD(VDATA, BSWAP, 14, 1)
+FIELD(VDATA, ALIGN, 15, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h_bf16(uint64_t frs1);
diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
index a22e2cae6c..3916236762 100644
--- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
@@ -693,6 +693,14 @@ static uint8_t vext_get_emul(DisasContext *s, uint8_t eew)
 typedef void gen_helper_ldst_us(TCGv_ptr, TCGv_ptr, TCGv,
                                 TCGv_env, TCGv_i32);
 
+static uint32_t vdata_add_memopidx(DisasContext *s, uint32_t data)
+{
+    data = FIELD_DP32(data, VDATA, MEM_IDX, s->mem_idx);
+    data = FIELD_DP32(data, VDATA, BSWAP, s->mo_endianness != 0);
+    data = FIELD_DP32(data, VDATA, ALIGN, !s->cfg_ptr->ext_zicclsm);
+    return data;
+}
+
 static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
                           gen_helper_ldst_us *fn, DisasContext *s,
                           bool is_store)
@@ -712,6 +720,7 @@ static bool ldst_us_trans(uint32_t vd, uint32_t rs1, uint32_t data,
      * The first part is vlen in bytes (vlenb), encoded in maxsz of simd_desc.
      * The second part is lmul, encoded in data of simd_desc.
      */
+    data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
@@ -890,6 +899,8 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
     stride = get_gpr(s, rs2, EXT_NONE);
+
+    data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
@@ -991,6 +1002,8 @@ static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
     mask = tcg_temp_new_ptr();
     index = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
+
+    data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
@@ -1127,6 +1140,8 @@ static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
     dest = tcg_temp_new_ptr();
     mask = tcg_temp_new_ptr();
     base = get_gpr(s, rs1, EXT_NONE);
+
+    data = vdata_add_memopidx(s, data);
     desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
                                       s->cfg_ptr->vlenb, data));
 
@@ -1231,15 +1246,15 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
             }
         }
     } else {
-        TCGv_ptr dest;
-        TCGv base;
+        TCGv_ptr dest = tcg_temp_new_ptr();
+        TCGv base = get_gpr(s, rs1, EXT_NONE);
         TCGv_i32 desc;
         uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
         data = FIELD_DP32(data, VDATA, VM, 1);
-        dest = tcg_temp_new_ptr();
+        data = vdata_add_memopidx(s, data);
+
         desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
-                        s->cfg_ptr->vlenb, data));
-        base = get_gpr(s, rs1, EXT_NONE);
+                                          s->cfg_ptr->vlenb, data));
         tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
         fn(dest, base, tcg_env, desc);
     }
-- 
2.43.0


