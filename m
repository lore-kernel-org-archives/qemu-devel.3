Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4547BCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lgE-0005jz-EX; Mon, 22 Sep 2025 14:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfS-0003um-2T
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lf8-0004wu-Ga
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-25669596921so50314945ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567197; x=1759171997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWIuoMSiqJF4N4o+nZ0K+Ku+FE0azEDKcujW4yFEPEA=;
 b=u6CLfyD1pPdkC9zQ3VzVGrl3xfihIdDcnR1Yg21fnQ2z81zdjmO+CMA6HS614B8SFG
 M7NJeeoHzyJOuQU282zBQnXXD8tWoRBExOzGVPHecYz9usI8krJeGzUGvxuS4EuGuzco
 bWmym+odK0ccrxkjEPgkGF0dyaFCxtQy6tpq1ofCQ89oSK6vAy3wLhnUr/r+6Xy51Muv
 7mxc1Qdy/maAbpNGlvH1RSOgmE2fPm1VSw8e6+P2CydnaawckdHsP2GZnAyxHMkQKs7A
 +MrAK2MjVfI5fEHxdJA+VberUc1h466U2VVZgLN4fSS50iL2pi4l3gCRRV4QV7h8gnzC
 BlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567197; x=1759171997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWIuoMSiqJF4N4o+nZ0K+Ku+FE0azEDKcujW4yFEPEA=;
 b=OEVk+AXEAfDFM28nnAZDS8Rr5Gq4QIVUMnSZIlsBSDG+DTIeH/paM1Ob7/loeUs6VC
 ojdSNWolIzH6i2cArYe/q0UOkldORmqneBsjGZ2G90TYmCf6qi+6g9V4kZ0icucVQ3wV
 /3p3SvNVcxDFGC4ndF646LIR7eDhrXn/VWIMrz/yvbkWFZh2Kwe+i9M2/xVJAxXr5P6/
 WFUdwdDpso86+lshO5kk3L5z0CAqtZZ58uqUYXEejoZAbMMIMvFxj5En9s4qf34OTIAi
 PM0j5i6dTrtwtpGxrZ+8Z9+IgMgTZtwqHjQpUxDRD9xknkiC30uw9+z0JuzFU65hEk4t
 8oJQ==
X-Gm-Message-State: AOJu0YxetCSKvgvr6lgoGyWS4Ghekv+1hZsRUOjJ3SPwrNVpua4joTrC
 5dJ9WPvrH7RKzKY6Pvs12LUHIzEIqv6FuTjnln7XtAJEx1z8DgAeg2ute6+7b66rFwpZzG8beKq
 oNJqx
X-Gm-Gg: ASbGncum8iHSOLSISup01KPZ3pgH4vtVqm6aGDcT0tb4Whnro8tPFmv705UJRSPnUA5
 QMXDnCD70EAnWLO7B4bnDQYYzkrp5BtWngAaAcZdMBjb1U/cQC42kDlOyZBvByvup4sIg119vmf
 f/jClQAbJ89MvbCACVL7jbWdvcJ43YNKsbNQCrPMLIgCj2DEwAVQeS6V87oupvYRT8dwJE+ojEC
 ZAA+7P9c7zV//5ZrE0BvXa91cPxD1g7ZWfD8VrWyflJmxvYvxnr7TQqSD8iKDJSuQU7+pUPtiE/
 zZd93/AbQej0/ZoX+yLM6IB9hO1ZYtIf48oex40tjpxeQ8s2U+FbPf/wXOgjWLs1+s+u8+C/aUk
 dpZ5PF/87dTa45orfz1O8xIJgZMAw
X-Google-Smtp-Source: AGHT+IHQ8yqIpuAQK5OfMvs330q4027hPqWVvFRYu9qRAIabFv8sgYFsak3FJwKKkqmaWnpbwYalFA==
X-Received: by 2002:a17:903:1b0b:b0:267:a942:788c with SMTP id
 d9443c01a7336-269ba3fa0afmr206941515ad.1.1758567197368; 
 Mon, 22 Sep 2025 11:53:17 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 45/76] target/arm: Split {full,core}_a64_user_mem_index
Date: Mon, 22 Sep 2025 11:48:53 -0700
Message-ID: <20250922184924.2754205-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Separate get_a64_user_mem_index into two separate functions, one which
returns the full ARMMMUIdx and one which returns the core mmu_idx.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ce5d597c93..f0331830b5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -93,7 +93,7 @@ void a64_translate_init(void)
 }
 
 /*
- * Return the core mmu_idx to use for A64 load/store insns which
+ * Return the full arm mmu_idx to use for A64 load/store insns which
  * have a "unprivileged load/store" variant. Those insns access
  * EL0 if executed from an EL which has control over EL0 (usually
  * EL1) but behave like normal loads and stores if executed from
@@ -103,7 +103,7 @@ void a64_translate_init(void)
  *           normal encoding (in which case we will return the same
  *           thing as get_mem_index().
  */
-static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
+static ARMMMUIdx full_a64_user_mem_index(DisasContext *s, bool unpriv)
 {
     /*
      * If AccType_UNPRIV is not used, the insn uses AccType_NORMAL,
@@ -130,7 +130,13 @@ static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
             g_assert_not_reached();
         }
     }
-    return arm_to_core_mmu_idx(useridx);
+    return useridx;
+}
+
+/* Return the core mmu_idx per above. */
+static int core_a64_user_mem_index(DisasContext *s, bool unpriv)
+{
+    return arm_to_core_mmu_idx(full_a64_user_mem_index(s, unpriv));
 }
 
 static void set_btype_raw(int val)
@@ -3577,7 +3583,7 @@ static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
     if (!a->p) {
         tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_a64_user_mem_index(s, a->unpriv);
     *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
                                         a->w || a->rn != 31,
                                         mop, a->unpriv, memidx);
@@ -3598,7 +3604,7 @@ static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
@@ -3616,7 +3622,7 @@ static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
@@ -4514,7 +4520,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         return false;
     }
 
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_a64_user_mem_index(s, a->unpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
@@ -4568,8 +4574,8 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
         return false;
     }
 
-    rmemidx = get_a64_user_mem_index(s, runpriv);
-    wmemidx = get_a64_user_mem_index(s, wunpriv);
+    rmemidx = core_a64_user_mem_index(s, runpriv);
+    wmemidx = core_a64_user_mem_index(s, wunpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
-- 
2.43.0


