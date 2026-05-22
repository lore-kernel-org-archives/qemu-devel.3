Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27878CD5BB8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY19-0006Kl-5F; Fri, 22 May 2026 18:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY15-0005zK-7O
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:51 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY12-0002UV-Q7
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c80227c9572so3679048a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487607; x=1780092407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUMbr1Mo4sGAkfsyt384Ur4MJ/2KX4R7TjLYuvCu9AM=;
 b=uZ2roy8i0KhK8wS27X8He5vPREXeN++cZeKP+Z9/Ng0HI4VzLXoeEXkZfLmuGDbYMf
 5hGT9Ugj/5RDfaJg7WFqDLgMejq/PudUl3+AR8o+3l9DFyhBtE014O4hKaySXMVqVQr9
 XPabEE5WaUADRhxz7JMGkF9KKm1lbYaWVE3YC8sgpC6jH6B+uT/khz3y10iWyHvvxBCh
 TeUMWEzYbGpY2pDoMqfVhxaXOU+KMDp85pcu2WvTMblnH2mZZy5nCoSEqSycdTmshD5r
 Ot6A53cQgOV+emDe24tCUdR0LDHKgLEMVFl7hNxqDZ5QlRdLufaQkoKCRlrCYSaHl0lG
 EUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487607; x=1780092407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mUMbr1Mo4sGAkfsyt384Ur4MJ/2KX4R7TjLYuvCu9AM=;
 b=E2Rqg2lhVIoERaXbwB95tairZXvXf3pOS2ZsWDkDWrymAJtQz4BBm2xQW7CYZiAMJH
 5J5jIjwc/H11lUkABicIC4ddl8qgbUq+Sf10b/jczz4KvubuBI7EC21wrD/0Na6LUDBG
 qjQD/A/YSx9tMw/ciQBbk7rfCHZgYEsMp3EO6gys92WJS4BKUG+2s2Y1BXi9yvAUncKe
 eyTIRvXPfu2FfUG7/AJKaJZ2qbSDQrkAthOE1DIeKD0rutUXxgI0F7N+DsQjIi3PwGXL
 qkiLIHpg/dDaIW2kye+TpGuIZ9k92cF0bthGnFK66sRNbzDyyMSEPEKEakGZVd5dZ0Yf
 Ss/Q==
X-Gm-Message-State: AOJu0Yy4Sur8ozhqPEeIZJFnJWrY6vyTBr8PWhOD1zM18xzciAFdTzhL
 1vQqjZhEndOZPnUXrXtHG2k/dURjvvfpG0ixg7jV34dGxH7B2auEDx884YzHoUTLzOyjCtMwDGF
 bIRk0
X-Gm-Gg: Acq92OFPJsRXCms/qJzTrFdcAhdMUIymASsdqaYvCr7eyZLcFW9cWMZstAwTZ8e2aeX
 9ZGHLjbzOL1GY82p5B+/5VxnrkSVjclkaCF7nrDADfjtk3nBB7Eiyfz8Qr3dEv4a+keeiY0N0N5
 c/Q2l0pRwPenxuPEUo0dZ1T5mFj0rbHYUC7I6NCLlcz5h4nq1ZNnk4P1TdKET5s7F5dKDZ4GmjB
 k8dsTcUON9A6qMzKZ1Ft7ni7bCUSRNSQgYw09vCxXgLbU1wDnREac1FNwsE0ucfpUSG9LnEAuV3
 t7vLCZwEpkTljq/G05zLoBNUt1J8x2yJwPzZCcXod4km+JS01H+ne9RnLh1Lk9QdHeAxiksLD/b
 k1LKCbKI066VvErUfSWOAjD7LCpNJJAqtru4gC44EYX1kaJDXRDNwKfVAozOKSMSUKAkZ2fuQWj
 VRcGN+9pDOLQtwRddETWUSrzReTZ0dYIEMZYVHl8Q=
X-Received: by 2002:a17:902:f544:b0:2ba:6ed6:aa35 with SMTP id
 d9443c01a7336-2beb05e4133mr57181235ad.19.1779487607117; 
 Fri, 22 May 2026 15:06:47 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 40/64] target/arm: Implement LUTI2, LUTI4 for AdvSIMD
Date: Fri, 22 May 2026 15:02:42 -0700
Message-ID: <20260522220306.235200-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 target/arm/tcg/helper-defs.h   |  5 ++++
 target/arm/tcg/translate-a64.c | 38 +++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 52 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  6 ++++
 4 files changed, 101 insertions(+)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index a05f2258f2..05ccf795e8 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -1122,3 +1122,8 @@ DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(gvec_luti2_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_luti2_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_luti4_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_luti4_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2100da0a69..e6d405ea69 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5402,6 +5402,44 @@ static bool trans_TBL_TBX(DisasContext *s, arg_TBL_TBX *a)
     return true;
 }
 
+static bool do_lut_1(DisasContext *s, arg_rrx_e *a, gen_helper_gvec_3 *fn)
+{
+    if (fp_access_check(s)) {
+        gen_gvec_op3_ool(s, true, a->rd, a->rn, a->rm, a->idx, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(LUTI2_1b, aa64_lut, do_lut_1, a, gen_helper_gvec_luti2_b)
+TRANS_FEAT(LUTI2_1h, aa64_lut, do_lut_1, a, gen_helper_gvec_luti2_h)
+TRANS_FEAT(LUTI4_1b, aa64_lut, do_lut_1, a, gen_helper_gvec_luti4_b)
+
+static bool trans_LUTI4_2h(DisasContext *s, arg_rrx_e *a)
+{
+    if (!dc_isar_feature(aa64_lut, s)) {
+        return false;
+    }
+    if (fp_access_check(s)) {
+        /*
+         * (Ab)use preg_tmp to merge two disjoint 128-bit quantities
+         * into a sequential 256-bit table.
+         */
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, vfp.preg_tmp) < 32);
+        unsigned tmp_ofs = offsetof(CPUARMState, vfp.preg_tmp);
+        unsigned rn0_ofs = vec_full_reg_offset(s, a->rn);
+        unsigned rn1_ofs = vec_full_reg_offset(s, (a->rn + 1) % 32);
+
+        tcg_gen_gvec_mov(MO_64, tmp_ofs, rn0_ofs, 16, 16);
+        tcg_gen_gvec_mov(MO_64, tmp_ofs + 16, rn1_ofs, 16, 16);
+
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd), tmp_ofs,
+                           vec_full_reg_offset(s, a->rm),
+                           16, vec_full_reg_size(s),
+                           a->idx, gen_helper_gvec_luti4_h);
+    }
+    return true;
+}
+
 typedef int simd_permute_idx_fn(int i, int part, int elements);
 
 static bool do_simd_permute(DisasContext *s, arg_qrrr_e *a,
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91e98d28ae..cb633817d7 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3348,3 +3348,55 @@ DO_SME2_LUT(4,4,h, 2)
 DO_SME2_LUT(4,4,s, 4)
 
 #undef DO_SME2_LUT
+
+void HELPER(gvec_luti2_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    unsigned part = simd_data(desc);
+    unsigned vl = simd_oprsz(desc);
+    unsigned elements = vl / 1;
+    unsigned ibase = elements * part;
+    ARMVectorReg scratch;
+
+    do_lut_b(&scratch, vm, vn, elements, ibase, 0, 2, 8, 1);
+    memcpy(vd, &scratch, vl);
+    clear_tail(vd, vl, simd_maxsz(desc));
+}
+
+void HELPER(gvec_luti2_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    unsigned part = simd_data(desc);
+    unsigned vl = simd_oprsz(desc);
+    unsigned elements = vl / 2;
+    unsigned ibase = elements * part;
+    ARMVectorReg scratch;
+
+    do_lut_h(&scratch, vm, vn, elements, ibase, 0, 2, 16, 1);
+    memcpy(vd, &scratch, vl);
+    clear_tail(vd, vl, simd_maxsz(desc));
+}
+
+void HELPER(gvec_luti4_b)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    unsigned part = simd_data(desc);
+    unsigned vl = simd_oprsz(desc);
+    unsigned elements = vl / 1;
+    unsigned ibase = elements * part;
+    ARMVectorReg scratch;
+
+    do_lut_b(&scratch, vm, vn, elements, ibase, 0, 4, 8, 1);
+    memcpy(vd, &scratch, vl);
+    clear_tail(vd, vl, simd_maxsz(desc));
+}
+
+void HELPER(gvec_luti4_h)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    unsigned part = simd_data(desc);
+    unsigned vl = simd_oprsz(desc);
+    unsigned elements = vl / 2;
+    unsigned ibase = elements * part;
+    ARMVectorReg scratch;
+
+    do_lut_h(&scratch, vm, vn, elements, ibase, 0, 4, 16, 1);
+    memcpy(vd, &scratch, vl);
+    clear_tail(vd, vl, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index a9cf259b9b..6aea3ce89f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1344,6 +1344,12 @@ EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
 
 TBL_TBX         0 q:1 00 1110 000 rm:5 0 len:2 tbx:1 00 rn:5 rd:5
 
+LUTI2_1b        0100 1110 100 rm:5 0 idx:2  100 rn:5 rd:5   &rrx_e esz=0
+LUTI2_1h        0100 1110 110 rm:5 0 idx:3   00 rn:5 rd:5   &rrx_e esz=1
+
+LUTI4_1b        0100 1110 010 rm:5 0 idx:1 1000 rn:5 rd:5   &rrx_e esz=0
+LUTI4_2h        0100 1110 010 rm:5 0 idx:2  100 rn:5 rd:5   &rrx_e esz=1
+
 # Advanced SIMD Permute
 
 UZP1            0.00 1110 .. 0 ..... 0 001 10 ..... .....   @qrrr_e
-- 
2.43.0


