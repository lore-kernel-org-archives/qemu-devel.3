Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F1CC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82V-0002Tf-0V; Sat, 21 Jun 2025 19:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82J-00024r-AW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:15 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00050X-28
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:15 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso2537987b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550051; x=1751154851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wt9IyzYIYvITnB8KBX6qG/qZfT7Tsvz/Ul6mWzwG758=;
 b=LmEl+rqQqdGOp9lVGDMVf8tXrU7phdY3LnhlyU+2hpTusoxyRpw4AN7VtmcBQkg5H4
 /ZCWs4wqZK/0KqQzCAxbBOtR+f3EzijoV3EuiaeHigDeJoWBAPkVXTrds8VaiJ4Ykr7c
 Tg6+GNxszdoZlIXGNv5WCMXBySHJDnhLIUB23lwSi/L0k9TKSEqYvMKjPUss8Nn8YMe1
 YUJm4ZRuJYJQKbJ5xt1/3MZRVFodyBVIvyT0ad9ZsEcXv5Oozq1WWjnutEAnC0h0ePWl
 6Yegm7TfGy5vOGCQpwt52kaAZHESXWBWtEaG+YwTBdWdbNdukL7r01hpr4xTIlxlmin4
 Xh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550051; x=1751154851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wt9IyzYIYvITnB8KBX6qG/qZfT7Tsvz/Ul6mWzwG758=;
 b=lJMWhOOYaFC5eBPLA3bYG3GA0ZS19HShezCw2kSHSBDzEqKP57TO2Rf4GL9HjGW+B4
 /7ZpyQvSHgqIGPmxwc6IasRyIUIXd8KWRH/DY3xxgm1sfixw4oG7TwqhHMqrfj57fzcw
 AlwW4D3EoJGwvFZ17AfA9zzr0FdnAGAN8imU0tSEN6OI02HLVpVGjcskaRJE1KipX7H/
 AJKNVf9SvmB2hCooucXXLY9AbOLEx4fkqpmDDbHpFVQzIO04H1tbXJjMWGzXSXxOPLCJ
 RX8h5sTV+p5T9GHRThwiIqf10FZSHj1UCEf4sHova2vP+yjE73dDLXhtDx2NpsXi1fdT
 8UnA==
X-Gm-Message-State: AOJu0YzUk28CPNXYoYfFq5my36uXiEUfAZirUPqjzYPW4jzQzPip2mc6
 jZsmSfd9ILD2PtNWVeJFMfbrAfoEaTd03daxjDflPZW50KUcp54sb13hmyGvIG7PHnVLOQHBeyE
 Cb7KzD90=
X-Gm-Gg: ASbGncunQxyZtsNh5kyg+Vvkn9kSNhTkSVDwrCdg5f+IWCijwFnqlsrIdC9+qKNSier
 I20TXltaz1HkBVAgYi6f6STjCw+5HElwRpHXFUqkEiiZWX5F2ei+D/Ow3ArJAz6uxoKJTN6yCHe
 eF99q30Vvyw8mNm74k9v/+e4EMkqGLNxsVPZRkmTjFvtU9JLgCAgFUHzO6q24JM7sHUMNt+5Qaz
 WhAFCuabQg5+K3I5lEu+4zr/RfX0K815ziBfVG68AakCe/aswsc9qdUfRbumymved2/jgyMMj6+
 hW5SsYsEOXamQ/ywoW0zKHxnu39WbajvN+7Xp75n+2ApZBcc3XWKRC8bLbtUeWuixZZ1o0OB3JK
 fUL2fPhZsy+cC0bq5YQ4B
X-Google-Smtp-Source: AGHT+IHnikvhQ8dxMKpQMh6us5iHQTbZrEq+y5lAUNjhQQ4gARzG//m3XSSXSMGzKrr0rOpMuHL92w==
X-Received: by 2002:a05:6300:6e17:b0:220:4750:133a with SMTP id
 adf61e73a8af0-22047501489mr1527742637.25.1750550051184; 
 Sat, 21 Jun 2025 16:54:11 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 050/101] target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
Date: Sat, 21 Jun 2025 16:49:46 -0700
Message-ID: <20250621235037.74091-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper.h        |  2 ++
 target/arm/tcg/translate-sme.c | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    |  2 ++
 target/arm/tcg/sme.decode      | 25 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index 623c68fe97..f1e6c7cf3f 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -721,10 +721,12 @@ DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfadd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfsub, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 6a77efdaeb..f89850cfa8 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1005,6 +1005,50 @@ TRANS_FEAT(BFMLA_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(BFMLS_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
 
+static bool do_faddsub(DisasContext *s, arg_az_n *a, ARMFPStatusFlavour fpst,
+                       gen_helper_gvec_3_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int n = a->n;
+        int zm = a->zm;
+        int vstride = svl / n;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, n);
+        TCGv_ptr ptr = fpstatus_ptr(fpst);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < n; ++r) {
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm + r);
+            int o_za = r * vstride * sizeof(ARMVectorReg);
+            int desc = simd_desc(svl, svl, 0);
+
+            tcg_gen_addi_ptr(t, t_za, o_za);
+            fn(t, t, t_zm, ptr, tcg_constant_i32(desc));
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FADD_nn_h, aa64_sme2_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fadd_h)
+TRANS_FEAT(FSUB_nn_h, aa64_sme2_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fsub_h)
+
+TRANS_FEAT(FADD_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_s)
+TRANS_FEAT(FSUB_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_s)
+
+TRANS_FEAT(FADD_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_d)
+TRANS_FEAT(FSUB_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_d)
+
+TRANS_FEAT(BFADD_nn, aa64_sme2_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfadd)
+TRANS_FEAT(BFSUB_nn, aa64_sme2_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfsub)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e5a4f56ef7..e41386861e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1469,10 +1469,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
 DO_3OP(gvec_fadd_d, float64_add, float64)
+DO_3OP(gvec_bfadd, bfloat16_add, bfloat16)
 
 DO_3OP(gvec_fsub_h, float16_sub, float16)
 DO_3OP(gvec_fsub_s, float32_sub, float32)
 DO_3OP(gvec_fsub_d, float64_sub, float64)
+DO_3OP(gvec_bfsub, bfloat16_sub, bfloat16)
 
 DO_3OP(gvec_fmul_h, float16_mul, float16)
 DO_3OP(gvec_fmul_s, float32_mul, float32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0d592bb467..91df2068cf 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -515,6 +515,31 @@ FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 
+&az_n           n off rv zm
+@az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=2 rv=%mova_rv zm=%zn_ax2
+@az_4x4_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=4 rv=%mova_rv zm=%zn_ax4
+
+FADD_nn_h       11000001 101 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_s       11000001 101 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_d       11000001 111 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_h       11000001 101 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_s       11000001 101 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_d       11000001 111 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+
+FSUB_nn_h       11000001 101 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_s       11000001 101 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_d       11000001 111 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_h       11000001 101 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_s       11000001 101 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_d       11000001 111 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+
+BFADD_nn        11000001 111 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+BFADD_nn        11000001 111 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+BFSUB_nn        11000001 111 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+BFSUB_nn        11000001 111 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
-- 
2.43.0


