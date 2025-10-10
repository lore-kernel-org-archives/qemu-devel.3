Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1F1CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CqD-00072K-TX; Fri, 10 Oct 2025 09:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cq1-0006v2-Kq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:17 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpI-0003xG-P2
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1526630f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101578; x=1760706378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7+nBYL3F8qlOvra824tlrP4zq/NyYtJG8TYO8wDuVM8=;
 b=YWnPl/mW4LrJgSBdZygKnji0f3VMdgN/eDaJ1HWOdFL+pTIYJ9NvoTL/8qVK6bgrNs
 127li20xA/t/yl06bgWEGOUKLrGN/i+q2ceShLsP9qjtDnNdU+iHXwBzz4rB0tl3pi3z
 DbpPEEpEut2wGu27sHxSURgHGbwC5jP1b3qkpTAhw00eYwP0gqQrXkbZhfmKgXuJYXKy
 qGnOjGm9OUXrEFvF9Y8g2apnJFZQrPFLiJXtc0BupbaxWmx/+l9oo+OBahHKMW5TDG6J
 xcX55iWmsmNV0O8RF5JCDJraypCiP5JPSDmGwHrPQa63vtMGk18RKGMt8jVd0GATrMSz
 gWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101578; x=1760706378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7+nBYL3F8qlOvra824tlrP4zq/NyYtJG8TYO8wDuVM8=;
 b=AhFb5SrUl3drjPKa1RG4Jp3FTNdUfzvvK66Nz+t7dg8+Fkpot1RfFCo1S3762MKysO
 iMxITZdNdNmWXlxA4z5g5aHyGYNKl4WOqgGH5s1RuWc3sH9bxDIKggPNzLQbjh/T1RN7
 ywrh7faWzKCgFMdR75HrNg8tkqrqR0nYCWIIbQqbFtfJZp79dY5Zix+PkAv5G15du8XD
 G8X9/ubQHP/5RiFN+e51Qeh3v5C3wrCBFbxARJYapXwnEyFHnCNe8jRuwhou/U7mYhCY
 D+wtEuWBWj2puSHLiTwmI6CelZaIXQiuOajmylxqcskHdPoyTJvlrNMfgvwjYLc3oKM4
 4jSA==
X-Gm-Message-State: AOJu0YxtLBxJgeAmaWZOIMpW6Yzl0dIGcHJG//k77HgUSbjUCIJMWB25
 RE5LuTizlT7LIU7/ptNqvQrkMc+rSFSsM9c2Y/29EkvmsqV5EI8FeTd7nD198qVHDKazmOy3Sqv
 vsMWp
X-Gm-Gg: ASbGncuQMKkHy8p9Kje4ZzhZ27d6wsLZeTDb3Jkpb7+JB6z41YrGyCmqRRsPQ02e8OT
 7zTR4uNNcE25wh1i/uEtvV/8FFptifk0Slnop4p/IbspmNd5FzGdD1/YAeOaRQrNoCmlmLfn3km
 D13CBOjDkCXJVBWS0ekMjFqeKqmyz80qvsLCNbnmwgevbO93a8qu2pxzEb/86zqBYIIv8v9LSC0
 ZX9KmERZqfdnW2/y0b0rgk1S3yWj3HLDZijqRSN0+adCpL0iqqdtXfbPoUt8HR5R6TOgPaTxbZf
 6Sc7vFn0jjn9D2bgLwTsWnjm3om6yhC1ldG+91VDcUCD9bIa9Bc02gGVIM4rDlHyZU5g4blJrBc
 DrKpbiHO43fs7hzXo5j2py4z5tN77JkoUgDwRswJROpo9aw5FNgE=
X-Google-Smtp-Source: AGHT+IHMFOwhmXHr/OR2oBwK+pHFvwJ+D2U4oKlRQ+dGqNz18oPctB1sRFG0NpYfplokZ1gdBao6gQ==
X-Received: by 2002:a05:6000:420e:b0:401:c55d:2d20 with SMTP id
 ffacd0b85a97d-42582a04d0amr9472662f8f.26.1760101577839; 
 Fri, 10 Oct 2025 06:06:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/76] target/arm: Split {full,core}_a64_user_mem_index
Date: Fri, 10 Oct 2025 14:04:53 +0100
Message-ID: <20251010130527.3921602-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Separate get_a64_user_mem_index into two separate functions, one which
returns the full ARMMMUIdx and one which returns the core mmu_idx.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251008215613.300150-43-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 43c9bfef93f..1337e16a96b 100644
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


