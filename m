Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47B2CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jMC-0008V4-CT; Fri, 03 Oct 2025 13:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKg-0005lF-Do
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJx-0007ir-Q3
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f1f29a551so3463679b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511503; x=1760116303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fNvE/0VLywPk9VR9GyOGl84ab7Le9+vvxZH9uub5Ig=;
 b=tUu8x60M6f/fc6n8JIWT263FhpRTb5vSKSAycA6PcNqIhEWHwB3iVul1SletdNNK/J
 0NeHSLsHyEmTfDS06MvE8xnYesPU8tLKi+KFtrwMHVxyKueUnsjF6uN9Hmiqxt3Pa4c+
 tfDjZzJe4/3KhZekUJCPI7JFFhMs484wVK+Ef0kZVfTHQVgyhtTx/9kE5wLVlmV48LDP
 INTEKb1dOawp01f404EYiJa2fXlSij3wSklWyJtJ9W9qQmGHD4dek+iKIxGhCw37WSmF
 fqDdDMnfOhcIMF75dmFlHQ6/3MEx7n/2wbM2OuNlboixDFRDGM0pikOOKXb2PkCOu1AK
 OU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511503; x=1760116303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fNvE/0VLywPk9VR9GyOGl84ab7Le9+vvxZH9uub5Ig=;
 b=Zi2EYwoEBfh1PxRW2QoXj9Te7nNbyV05Zm4tYU0r7QYNEmqcGx4HghDhWlANya2yAO
 Ki6j4UlNvWRqe6W9U5a1eq5wCsOMY8qAio8iE5jmpF3d7jjeXaeIVDv6JOhWId3PlPi+
 Bo+muFIIkQ1JE3wOi1r3KCa6XxOm5AFBFyC2ykGD4ZbcGyam1rLDtPEFhEQ/S+ddBWim
 Edt1xj3rCW8EVAAZUpm+eMD9R4m9p/JBNtsgWepnLayAwmoqJFeN9+3Wc6faBaviKL4G
 X5Pr1V4fmDrCVMfOL4/HH6hdbZTjh+cyueYD2WBcFwWpVeqVF1SqcEktqPrYp30CFkvN
 fBNA==
X-Gm-Message-State: AOJu0YzGDYYJ9NCYm2NZ6Z9m/NIh9bWF+81mV59wFsbCQsOKyYYkwJce
 xWHDs+igdsHjCZ+bg3IJkP9/Xr+eyRI+DqlqRNhbd1gtclHFVMI7lYvFwsSWFVcsDdvTEbytPvQ
 VVPfpF+s=
X-Gm-Gg: ASbGncutBbrGQRsoQOrsyKK9iz8w379yXi2Ao/eJ1JIMbuDizsduqivD9Gx/uXNZZv/
 rMlou/CsDNmYBW50lmj6/JtzthRc2mcJQ/nuptRmj9q02bywIIexuAr2+DUseEsxoUGnxTyRRBo
 pI85+p0dZmlrBK+EwiBnuCFz/oRzOtM9SVhoEgi62o7ohWBG4zVFA4P07lk0SpBcGtToXFseYoT
 UACY2jTaGxeZn4wGD6BrZUwGwfA3aNTyqlavGR0kGKMb0fVjzfeN6l8QiLAsr0Rx8CE5GggE1eh
 R7YSEp51WNRXiT7txHbv1Z63GZz7pgLNa+XMDFLgUDMnsBDkr8QYq3x/pVImaxspI3Pw2MewCLc
 o60L1OXsWHnndS6+zF6XKhUsX6QmdfcIj8GvkABPTqJokXQ8czhDyFxBW
X-Google-Smtp-Source: AGHT+IGT8W9UBTbGhleDX3KaYjUq0sd3EVS3Z68GC7QNUarGuRmZpbV4jxvY9RbRKUkEXExzoZReeQ==
X-Received: by 2002:a05:6a21:505:b0:32b:6eaa:f4d4 with SMTP id
 adf61e73a8af0-32b6eaaf5d9mr3416995637.37.1759511503282; 
 Fri, 03 Oct 2025 10:11:43 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 46/73] target/arm: Implement GCSSTR, GCSSTTR
Date: Fri,  3 Oct 2025 10:07:33 -0700
Message-ID: <20251003170800.997167-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c037119cdf..b72aa968cd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_a64_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(full_a64_user_mem_index(s, unpriv));
 }
 
+/* For a given translation regime, return the core mmu_idx for gcs access. */
+static int core_gcs_mem_index(ARMMMUIdx armidx)
+{
+    return arm_to_core_mmu_idx(regime_to_gcs(armidx));
+}
+
 static void set_btype_raw(int val)
 {
     tcg_gen_st_i32(tcg_constant_i32(val), tcg_env,
@@ -3989,6 +3995,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
     return true;
 }
 
+static bool trans_GCSSTR(DisasContext *s, arg_GCSSTR *a)
+{
+    ARMMMUIdx armidx;
+
+    if (!dc_isar_feature(aa64_gcs, s)) {
+        return false;
+    }
+
+    /*
+     * The pseudocode for GCSSTTR is
+     *
+     *   effective_el = AArch64.IsUnprivAccessPriv() ? PSTATE.EL : EL0;
+     *   if (effective_el == PSTATE.EL) CheckGCSSTREnabled();
+     *
+     * We have cached the result of IsUnprivAccessPriv in DisasContext,
+     * but since we need the result of full_a64_user_mem_index anyway,
+     * use the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = full_a64_user_mem_index(s, a->unpriv);
+    if (armidx == s->mmu_idx && s->gcsstr_el != 0) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_gcs_gcsstr(a->rn, a->rt),
+                              s->gcsstr_el);
+        return true;
+    }
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_qemu_st_i64(cpu_reg(s, a->rt),
+                        clean_data_tbi(s, cpu_reg_sp(s, a->rn)),
+                        core_gcs_mem_index(armidx),
+                        finalize_memop(s, MO_64 | MO_ALIGN));
+    return true;
+}
+
 static bool trans_LD_mult(DisasContext *s, arg_ldst_mult *a)
 {
     TCGv_i64 clean_addr, tcg_rn, tcg_ebytes;
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8283a9c83d..2ae73f443a 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -571,6 +571,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
 LDAPR_i         00 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=0
 LDAPR_i         01 011001 11 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=1 sz=1
 
+# GCSSTR, GCSSTTR
+GCSSTR          11011001 000 11111 000 unpriv:1 11 rn:5 rt:5
+
 # Load/store multiple structures
 # The 4-bit opcode in [15:12] encodes repeat count and structure elements
 &ldst_mult      rm rn rt sz q p rpt selem
-- 
2.43.0


