Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26993CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqL-0007GT-Iv; Fri, 10 Oct 2025 09:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cq9-0006wN-74
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpJ-0003y7-3Z
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:20 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e52279279so14554345e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101582; x=1760706382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KWWWfmCvad/yyOAjIOoDjFHyfPWd7FPeZ8XpXrjRocI=;
 b=FVC2E9Jgq9tEZ/tsDODRwf6WgLjRELy4Y8CQy2jEIJ3ybcH5tjNcHEdh/lx6vQ/edt
 s8V0CK4X3gX9IjhV3GLoDtJ1h4nGddNvk/eJD/Ne04SVrmeygQKZA6lmXYAWca9vGt8J
 lkc/xQGD+kM1e/e+RW6SsFNC+qDuefZcLlCUkMc/9xeDETVNkpJLC+PoJVk0h7PUhI8B
 MTuXLAGdcXiq7BttPpg4oC4Xpvz8Qn8ioQ0J7I68ZcKt94x65r+xK28FZXFu/U5cPLOj
 ff9kNQdFQaHT0JrGvpqt8hxBNGvsvsdFvp0p4gO6XRZqBgcNEjk5WYSHOuYTbf8X+HXM
 oXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101582; x=1760706382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWWWfmCvad/yyOAjIOoDjFHyfPWd7FPeZ8XpXrjRocI=;
 b=uo2cgQYVbyjKr/H2KBHEkdcrRTeo+ZvZ864nY8As+5nyEAxVR/yzNhlMiVg9ukmRNm
 ZmNnSPgsSqVieHvFszoLKrRZlSMFobNfi/lYzM5YLWQ+fl2Z04v7NxYtPLElEu+K5vxw
 3O8S2e/CJ2V6KGFJcbH6qpCEnY1H4l2d3l1GYR+yZviybcb41BCCrBjQfexMEZHKCiZc
 UOp4JTS1vjOez5BYMCDG2xVo4pmVP7GBDTOJoifnhv4bRv5eJIAu3O1XEFiaM/0JLQPH
 KBRZ+YITAS3usbM/i+3hDnhJkd3mvGZ2MgkemTd3rbne5Sm2blSHGfeC3gFu80024b7a
 nCVA==
X-Gm-Message-State: AOJu0YwD4QQT0Ye9qL4sl70GoRUzEdvGAWg3m3BzTzOi1twaG7TG6kuQ
 ZZn3HpOlCB6LznyPCTF1LFgTwQZDCyvwMMeyRPA+sgCsEmRcOlhL/zAM7G8IVZIA4hP7OixQmRQ
 xI6Dr
X-Gm-Gg: ASbGncu0VoHP9nQKeTr67EACApDqOm6Dxuni1rBDAvjXa5kDWYh7KYMji4haGTLbUEX
 OnSwDpXpnsh1BYtrl6rg2KMWLMHswclcT4iT/PGtRn3RjKNYi89q+ddsRHMDpDDOW8+HyEPHblV
 t94G3Qk6ZgzXs/ZqThrFcJQyY76KHbPJryvKhJN/mUer2T3JeLE3NJe7eXrTJ5rMC2Zb2yKqy+g
 og8Z5UHGaC2pCqfq2MeZEl21xHAhm8wAUpGt4rsONJNGbao0/vq5VHxLlOOD7xQzKs4ZWWkosed
 STWqxANWhT5veI8r+mCm4oP9nKuGA7WxyEHevnCAZS8F+6PdlYstvJ4eXc2W4Q6MtBILs+emVLY
 HfKtp18ryEonh9c94emXcstUuWbmlVzPLX+ZIIwSaGhER7vSeXYo=
X-Google-Smtp-Source: AGHT+IHMkky0I7bOpC2nX0Rs/y8QXjFks8RU3h5pBwpF0o54rD1Wp8+yq3rHlSP1LBHOl+tLMHJi4Q==
X-Received: by 2002:a05:600c:8b38:b0:45c:4470:271c with SMTP id
 5b1f17b1804b1-46fa9af3682mr84905625e9.18.1760101582321; 
 Fri, 10 Oct 2025 06:06:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/76] target/arm: Implement GCSSTR, GCSSTTR
Date: Fri, 10 Oct 2025 14:04:57 +0100
Message-ID: <20251010130527.3921602-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Note that CreateAccDescGCS() does not enable tagchecked,
and Data Aborts from GCS instructions do not set iss.isv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-47-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 +++
 target/arm/tcg/translate-a64.c | 42 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8283a9c83d9..2ae73f443a6 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c037119cdf9..b72aa968cd2 100644
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
-- 
2.43.0


