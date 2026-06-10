Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3816CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYI-00027Z-D0; Wed, 10 Jun 2026 12:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYF-000219-FD
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:11 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYD-0005u9-1A
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:11 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so5233849f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107988; x=1781712788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lf8wPmZJU46wuhYvQOeyoSsFpA/7mbyswfhdhoFFMh0=;
 b=JSZPsmh90GJv4Ep/DuIRGTWFgRdQTSCVdDYeM10UXz2ekxgBh5m/Cr0ZOPSjdFTQey
 MQdmv8JtWK1dvtsH4FPCmVcMdKgv/bkpwAMUi8Pz9e7uLpjRDrSNe+HpTg76kPIqfPxE
 RA3fJc0yZ3QqtePn8zKGDO0jijflLDT2shj7H94vUQSyXrB3uU+MqYGnARAe0CO88uIU
 hp9NM1g18NAW1SIONUkp1cR0Iz4WD7FVmtjOGi005ku1jxnxNV2Jbq8t8Q8GRjWzXYZG
 o6mfEGpPDL+oqTa/3PKR3OKpqCzK4UsxFghGVdG2tIujFkKmtV+Oeaceyww/58B8oxDb
 dBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107988; x=1781712788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lf8wPmZJU46wuhYvQOeyoSsFpA/7mbyswfhdhoFFMh0=;
 b=dMIz2mVDTwPypO2gQLmq2ICDaxAe9bLdMcvxMGdDHnYXbFjERTlYUbXLJZtD5hrfEe
 XyxH8FQGJqRQG6jxPbApdEw1W1fV6UuFTueN9zB4nywvWPfbox2rkYPRKsD0rpBS1tPi
 R3hefhK75qEufESEp/Jq6QcCzcj70wKiQWr5H6jqq1xwEI1tJO+Y8E9bCC7tIu2T3AkJ
 8MF2/3+e3hiqCUhB+bVriUBN0FYGCbG5VFERrN6Kz7eOTjPy+NM3ZnBwueX2J2lgmKKW
 O4Pi5R+EhQZQX5Uv4o0K6Nsd4JoxUJqAkpw1vg9h1vVTqmZ7vWoIQEflANuS1mNvKptT
 X7bw==
X-Gm-Message-State: AOJu0Yx+AXJRRiqD0IaY3zzdnP/N5n0Va/qrstjH+aH5YBkFphcgzBn1
 +cU9hphWj8THCpmzEVBGLQuvr6eqQfi/a4spu93FIZkF1Vo7hml5dOJwtUkggjg+7415Q1qV+lF
 nXVoS
X-Gm-Gg: Acq92OH0SzwnsAx0DtngR1III5sNsWyis15vrTuQ0X5mJh+OYy9y5wyS/3DWFbUNlI3
 Rmkm4zVp01WkMIu/kClNfGqC+/59jRR2DFkYyyDd2bT1xiM8oedVwbWuCUOTNjC5Brk0Hk+Ub1T
 j5WiAcIOGiqye5+n4K2yRXutPvwI2N4zAZkJv1DJgzMOmfxRTN7NbaTYyNmjaTXLder5c4HjdTS
 K7SRT0kzf82HMkh0QQfnB7jXMMati+M39f8AiqOv/C+HVrxCyH/3Ntly6pzfraTbvTBY64AC7Sd
 s89UfI1ADffgB9x09r1XyTxaTdU6EuD1Ic4Ch+bCQqds0IdTDrzHfwP+gocaVjItbY8YOgaO/l7
 7bGa273xdFjl6NAs8N8hQ8r+mWqdqoDBiVeFmuElCgoShsyZcz5feG826JNXBJWeZLtJ5/7OUGL
 EmQsmHG4vuz12/iw14WjXEUZi2TFPfBbDaNYYRcxBp13l/zRVJ/JlVvBtj9GTeY4MujspOk7C63
 wDqmnd/Tt5l6kFAPX2N6AEmJqV5nHC+1L0BRPbgHQA=
X-Received: by 2002:a5d:5549:0:b0:45e:ea68:5237 with SMTP id
 ffacd0b85a97d-460302e7187mr29927552f8f.11.1781107987689; 
 Wed, 10 Jun 2026 09:13:07 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/71] target/arm: Implement LUTI2, LUTI4 for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:38 +0100
Message-ID: <20260610161202.2235298-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  6 ++++
 target/arm/tcg/helper-defs.h   |  5 ++++
 target/arm/tcg/translate-a64.c | 38 +++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    | 52 ++++++++++++++++++++++++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 610047846f..2d06f14e1d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1355,6 +1355,12 @@ EXT_q           0110 1110 00 0 rm:5 0  imm:4 0 rn:5 rd:5
 
 TBL_TBX         0 q:1 00 1110 000 rm:5 0 len:2 tbx:1 00 rn:5 rd:5
 
+LUTI2_1b        0100 1110 100 rm:5 0 idx:2  100 rn:5 rd:5   &rrx_e esz=0
+LUTI2_1h        0100 1110 110 rm:5 0 idx:3   00 rn:5 rd:5   &rrx_e esz=1
+
+LUTI4_1b        0100 1110 010 rm:5 0 idx:1 1000 rn:5 rd:5   &rrx_e esz=0
+LUTI4_2h        0100 1110 010 rm:5 0 idx:2  100 rn:5 rd:5   &rrx_e esz=1
+
 # Advanced SIMD Permute
 
 UZP1            0.00 1110 .. 0 ..... 0 001 10 ..... .....   @qrrr_e
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
index 5606f610c8..ffd505601c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5502,6 +5502,44 @@ static bool trans_TBL_TBX(DisasContext *s, arg_TBL_TBX *a)
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
index bd8ae5d6a4..f4ff56e034 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3344,3 +3344,55 @@ DO_SME2_LUT(4,4,h, 2)
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
-- 
2.43.0


