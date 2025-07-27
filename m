Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C3FC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRB-0008Gh-Ri; Sun, 27 Jul 2025 04:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPS-00027D-6u
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:06 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPQ-0004ls-ER
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:05 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-24003ed822cso1924355ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603623; x=1754208423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjXGBVIh+Z1kVRR+6/ZuQ93tHMy2PrqXnE27+av6Y7g=;
 b=fUezS4p+l+LcUkiedC6FWkUofNSblAjN65ozVNNeo4X/eFTA5PEpe35RKA20CVHwgR
 zbntgiogIk7wnnln1bJlmKe6tRmwDCA9yf2KsnGEEtX6XqvUyxesqiJTzYth0DRcJFHb
 p85RJOPeRx8V5cOw0IGGj109FSB3u/d2QOofmD/ImP0RCsgeVZM8MWnAaHHeat2Ufj48
 CYAcvUEqVpBX+RXcQSu55JO4dlu4xINHq+MnADrgQU14Z+0ueSEJrv0gUTnVZ1vzo2+e
 2sr9aZ12yqH3jb8mKhILT1boT6AW74OqTDKHtEdCkUXgtP16jSIE4ngSeSj5rdyVfQl+
 rRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603623; x=1754208423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjXGBVIh+Z1kVRR+6/ZuQ93tHMy2PrqXnE27+av6Y7g=;
 b=dNBUUlAL0HPQrNjDKyN+sB7/zQJcsmviO2sahM/eMZnOUlPHM43sTmeIZRjg9EVYnF
 5mw9R9q2pSHKSupVcfFYNtCiqJVK5JqlJRkiiQN2w+nOkdZV2JUOmw9LtZRxcCmleEzv
 4Fpenl/HCvwThhRvF+BmqaBAxuc28fu+ll+DJjLMrc4NRovwBzgQjK4R7TeeSnA6DdfF
 I44FuAjH0VbqadFqmkD8y9QTh/arvUiwn3oeWgEgNut7ZpZWz/e7PhCajXgi/JoDqXFz
 7QGO+dNN32BsHZR30CinGTsaMieGhkpT332G8MAYpsNiffFhVa+DVOa3zVNiF/rZ+Wk9
 Faew==
X-Gm-Message-State: AOJu0Yzh2dFb7rl3qwIrtJRQMHTs9Xz/i4P5xcGpenoxVD40WSv+UqD9
 xTbMVCiaPzei+fukIIBzRTa6sIx8EPi7g4inohh6ERxq9wiqh3p1LIrcgnTm8N27Ab+lI7CbFaS
 xFXJn
X-Gm-Gg: ASbGncvWkm4KShzFtdANtIgZ83HKgvtgmuVkeZr6LyeeWKe9hKAIjkUddsrTUOnZiVf
 k/uwdUx6HG8S7s4OJ7+VNJBYxVD5rfBrHPNKAUWxs0G27lFdIUy03an7ZLHhvcs+MMbg6hX3lER
 4QfSWxYGLKdUy+e8MaEjOk9B2O3e0MFUx80kbNNF+OdYDVHewW0/WaxaPksmabVBvX7D9bkgnHB
 Q/I8C2axTAdHQZqiFemz23Re9cbDKqYVt5zwl265nMWl+dOXonlQwiLjlmyQvV+ogDE9FBC3GQl
 VoTXjgCgbTrDQqaS6YFipi8WmTMdfDhXmXGv/bGi0HtXnyZvhNcjIaD71e0nac1c/Gae4aPuijr
 ykOYdptJJrAC/rvxkYDIM4QQG6zajllLMtGVXkWnJXa+0qltg7Mi+jOyaTG4XPr3+/L/AgL9ntn
 ltaLF2BB8srw==
X-Google-Smtp-Source: AGHT+IHPJgPJ+uKXNU+iImif1vtJlXfInIpCWA3nGVpJZlBWQYFBP82U19KOGEuYdfZv3d87CxeCNg==
X-Received: by 2002:a17:903:2094:b0:23f:d0d0:69b7 with SMTP id
 d9443c01a7336-23fd0d06b84mr39260535ad.36.1753603623048; 
 Sun, 27 Jul 2025 01:07:03 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 54/82] target/arm: Implement GCSSTR, GCSSTTR
Date: Sat, 26 Jul 2025 22:02:26 -1000
Message-ID: <20250727080254.83840-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode      |  3 +++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d803c10ac7..e0548f7180 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -139,6 +139,12 @@ static int core_user_mem_index(DisasContext *s, bool unpriv)
     return arm_to_core_mmu_idx(arm_user_mem_index(s, unpriv));
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
@@ -3902,6 +3908,42 @@ static bool trans_STLR_i(DisasContext *s, arg_ldapr_stlr_i *a)
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
+     * but since we need the result of arm_user_mem_index anyway, use
+     * the mmu_idx test as a proxy for the effective_el test.
+     */
+    armidx = arm_user_mem_index(s, a->unpriv);
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
index 4315ed8dab..d034d96b37 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -554,6 +554,9 @@ LDAPR_i         10 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext
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


