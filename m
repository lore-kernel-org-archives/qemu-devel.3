Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365E6CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jLb-0007VQ-NO; Fri, 03 Oct 2025 13:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jKO-00057d-4v
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jJs-0007gZ-PS
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:12:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso1617777b3a.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511499; x=1760116299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZunbW8zrXRCzDcEAaVX1Pev0CRMsCYpGOAhWGA2DZnI=;
 b=Psp5f8Hjls1moJeN0e9CEpe19DhCHprlKDsVB3UPRYjWy3t+VbEhRk+W37rTZ2Y/S5
 FAk+9qOs78HBjbMSLa6FtfGxX0QBJA1cADuhrDCjxamICSqDPbfCcqqjsJuJIzt9YkBh
 2oTUhpzv55QkjyKEiX5CAZzoyLwTaDYM4Y2lzHAlP1A6E33CrUixtUYXHocyHIKW4geH
 QNeA/6Zr2HNMqbKmkkbFcU6RP6n4LBCyH2eKNp8JEADRy6nZqKreXMUqSsCGFDh3AWGA
 mntvm/fxeMdkW6Z+rgIftAci5LYT3srLI/y+ujIiZ5dXVH+fRDJYQT/max9vNYunx+VU
 KDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511499; x=1760116299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZunbW8zrXRCzDcEAaVX1Pev0CRMsCYpGOAhWGA2DZnI=;
 b=tsy+1fa8RXdiPMLu0V4H2VpzClBLEo6ttGvTia/q+lGRIkrqJJXq/ih35j5cbHK3kI
 prta8Po2KTjd9ewycUFOEEkVPlfIu/OiD5WqAXEn6xSJiBOKBP1H55WcJLmUyM4m5rQd
 0TzJR6Qa6gv+gsXKEDo/4GqVcvtYbAohWm3GbbmK0O331jsb3ZawdkA77lOswljXbenZ
 zJu+CCzZ6iJCCzzqKIRtD3LTnptgLEZzIjlqM69b3bkVQE9j6FtIvsAIqomPbmL/N3NG
 gLhioOM3Cx/oWFbE6gXhFadMwjKPRsxdDIJZmVniUtZfH/y+CkoOKATyd72il4dwGcwM
 DkdQ==
X-Gm-Message-State: AOJu0YzCMzEfbtLXwbvMMh6ZWlgRkvc7Bfk/eZ7Lc/+Nkb3HalDtLktD
 A8PcGwZfvMO9QaM1PPUCgYA2q+JaqkURA9bFaLNNByVJvjVd9WruK28UhUx4c9kRtG6zexRx8or
 QHnILtfM=
X-Gm-Gg: ASbGncvGv6HY6ZpvMZF3ticpSNHxT0uI9rlp2XKnN22mTgLeW7y00guMcMyQFi1l02t
 rXta64PFI+UJQnRdjZ+PMjTPBCg5e5kMeD4PsB4z11aNtasNL3gNtYXOKz85HgXp0LX0HPDAZU+
 KAAhE187Nvm4lRrqV28T/Gp8XyHNuAB7V4e+FtzGeLVZGbhB9TbGOzgYnIj4tsNAG2sLkHpMsmL
 WTJ/rr+A2dvcXiVi3zlN5rnuoZeImFPd4QoVcs08epQO1CVE94/KpUoIuuSkrQwfMPYZ/1jxiXS
 Nd0h6frdY90CcAbrK98C1rnv3CfFpyv/KQjbt4Ou4/KPCWCAYYKzKM4kVJcvh29Xq6KBEy+x6Jq
 w/sgI6RMeZLat4EG1DqqILeGG1jYcKEXOpxpu7jifvQRh5zOyw9eJx8MH
X-Google-Smtp-Source: AGHT+IGGz61qRD/yrZ0dz7KCVtSu6tDmSI+274aOVYci/eNB20Plk+DpdHJiSg4XKURLJYqLDqY1lA==
X-Received: by 2002:a05:6a00:23cb:b0:784:3dd9:1f15 with SMTP id
 d2e1a72fcca58-78c98dc68f0mr4273401b3a.20.1759511498984; 
 Fri, 03 Oct 2025 10:11:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b02053a51sm5418769b3a.46.2025.10.03.10.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:11:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 42/73] target/arm: Split {full,core}_a64_user_mem_index
Date: Fri,  3 Oct 2025 10:07:29 -0700
Message-ID: <20251003170800.997167-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index 43c9bfef93..1337e16a96 100644
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


