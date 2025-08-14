Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C034BCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeF-0003ok-1A; Thu, 14 Aug 2025 09:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcl-00027V-1C
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcg-000596-Qf
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:04:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76e2e613e90so656985b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176640; x=1755781440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPINWJ4nV+k9v7TwnsVQ/3E97hW4E8lZ7vTBhJUQGXg=;
 b=FZp3Xh+Swexc23JNWzCCipi8U6MJcY8OguBqMgwPjX/iwMzrWUkC0D/Ea+Zc7WgvoX
 DhhD1z8EFh97qZeTkEq8FOiiUAgVV544fM/Jc1Z6WgzxFb+7VMfxn/RM3rcIy2oJHjsm
 MuzB9pVm1D7CuKLDa6eGzIkFcBt/6gjARbDUkE0POqhOYqCDAfh7hseVl1TW6F44yv5U
 C+SvSr/gKsrnDY6mR2eqW76jdgj4JvL2oTfu7lFCrCIH7VG/zXLrfnEKvucO1cq3YaQI
 fqyQdOSU9RfeU80gMkx+e5e4fAej5hgIqJXHawz3Ntg9lP66/bXE/F3P6yScQzbGXTl/
 Nv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176640; x=1755781440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPINWJ4nV+k9v7TwnsVQ/3E97hW4E8lZ7vTBhJUQGXg=;
 b=ebCa2sdyj91RL3I4zD6Dla/wrRlxe/xlcGJhIgeBzfPDKS9GeLHskoWIqYYPYTJbm5
 q7V2scqau8Cj7HZhkLPyDj8Mz5B9KIcNuhxsGo1EhBx7elq6e592ivrxv51wyWYqBVjz
 mAsdGVNPVoaiwysfFwkdTLy0nkFULMKhiJStCn7tE17PrlXhUxvkWwCa1LBAYCP9oZEN
 384/ZT4rjzShWxIES6388Jm+JyPj3KWI8qfYnMUGIgxd69HwdSlci1Nl8zReZ0WB2CvL
 gNFVQOw/8lub9Xc8mwYtn51u87hUs/4gVmWaINM2YpmL5JJxLg7mle5dbYiB/3uglBdR
 XrvQ==
X-Gm-Message-State: AOJu0Yzh5htdganaPCsVRHvJu8+izkjdR5XaiuOZrtHZCCtyDORygHqb
 HUXoFOeHBluk4EPJOb6OO3AXgjS/Ol0UK00PjRHz6jFjrUY4uqdR3EqSNdZHiqvb5I+j1jLF0N8
 Gqkcne8E=
X-Gm-Gg: ASbGncsahOx4B9Yfp1hkZeLqinDbKdGKP1WTD6Cx9KI+0WKuISlw6we9AN9nJGjwrV7
 pU8fAQCirUfAu+vaofZLLkJhjh4udL2h2RbiDttSwOtzT8HOrGADviDypBPLHZaiGFf0PaAs7de
 UDLPNhWNkX7IssWuNzKnCycEmTpwkoZaZLFofKyQkLRlBrREYSGQ/Ynzt1JiVz6CjqLy27rd6ER
 ujlHUaRBTq6HA4m0Q3mDhQ5kgpFvjDnqF3lFiHu82xthS000dMDzhKBDI+639m0UG9ZIZSvuRbZ
 w1zM9ulEXlRsI9OSk7+iE9u2XBUAdVO2Ps4akgFE1d3+/qemAk4HN9uj0fI+8Ha1uZygVtMBb/n
 pzJnHONp45TTv9YzhzqT/y+RBNbZPgRl3hOQLJGrtQCQvISM=
X-Google-Smtp-Source: AGHT+IFJHh2BjyRpgAU4wUJUXEFilaka3qvCmU03AZkSOg50l2jHfefqGjhioZ1hSPwbLS5+1hh99Q==
X-Received: by 2002:a05:6a20:914f:b0:23d:de52:a5f0 with SMTP id
 adf61e73a8af0-240bd261906mr5335555637.42.1755176640339; 
 Thu, 14 Aug 2025 06:04:00 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 53/85] target/arm: Split {arm,core}_user_mem_index
Date: Thu, 14 Aug 2025 22:57:20 +1000
Message-ID: <20250814125752.164107-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Separate current to unpriv and arm to core mmu conversions
into two separate functions.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 34d22cac8a..eaeafdf138 100644
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
+static ARMMMUIdx arm_user_mem_index(DisasContext *s, bool unpriv)
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
+static int core_user_mem_index(DisasContext *s, bool unpriv)
+{
+    return arm_to_core_mmu_idx(arm_user_mem_index(s, unpriv));
 }
 
 static void set_btype_raw(int val)
@@ -3539,7 +3545,7 @@ static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
     if (!a->p) {
         tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_user_mem_index(s, a->unpriv);
     *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
                                         a->w || a->rn != 31,
                                         mop, a->unpriv, memidx);
@@ -3560,7 +3566,7 @@ static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
@@ -3578,7 +3584,7 @@ static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = get_a64_user_mem_index(s, a->unpriv);
+    int memidx = core_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
@@ -4427,7 +4433,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         return false;
     }
 
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_user_mem_index(s, a->unpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
@@ -4481,8 +4487,8 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
         return false;
     }
 
-    rmemidx = get_a64_user_mem_index(s, runpriv);
-    wmemidx = get_a64_user_mem_index(s, wunpriv);
+    rmemidx = core_user_mem_index(s, runpriv);
+    wmemidx = core_user_mem_index(s, wunpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
-- 
2.43.0


