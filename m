Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922BC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwQS-0005o0-1D; Sun, 27 Jul 2025 04:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPN-0001gP-Ta
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:02 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPL-0004kM-Ku
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso31848865ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603618; x=1754208418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JapRuQj/rYjZd7QW4g+JSnFIid1K0Vna/nY4R0gHLQ=;
 b=oSEpP2m9QeyR3C/LWCGjZjnAHy7pSFcrlaJ+yAIBNDLa8/Fy6RozqNtrq1KVVsmC+y
 90tTjoO7l+9g/TsqofyuxgjSM0i9j/OMJB28ayc0EWvtR71sCHmwrS+nP6GilSVC6+xH
 AKGxeU12I0/LbrSDK51Zbr2lZwBd8ndzQ29BFCwhuLfttdLIdg0SjiOAAMicoozhGcIY
 CVhe4c2FS07+uyG653knXCnsCVlLK70cp+PK+vR7vhSe8Zhn8e7aOcUMdqVvcFHcN8zY
 09MGTluF5kA1dlvp1cyRXCOz1Z7VVASP+r/luUzXcjQPh6NSvKoh52kyDKs4HCgdXJ5s
 mHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603618; x=1754208418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JapRuQj/rYjZd7QW4g+JSnFIid1K0Vna/nY4R0gHLQ=;
 b=aqLAneNYWmMWMewD+1XNGCW2RUWuNJ3KVO0uAKvO/TEhMPgJe6WcF717/6rkUyOuIp
 OyCSoFEqoXz3QVfVcxBMs7nWhkedWEvyjMZusn7R4vCPmlt5mA9IyHzavXOkAwnDW0Nb
 eWuF/OfKT3diVLUKUB/lIFQjaUSjrg208TrJU7tca/+p6tfiOCSLtIpIXuFWJvmnwIWO
 dmdboZWftjKfx5PEBYhePS8VUensIwixSiRev/6k+z93xYcjk8hyP3CwBatj2gvOu6W3
 k0UA/cMl/2+hJzBVJrzCZNF6/uIULMwOyLSFgqYl6iYwQAjp46TyU0bMmlUabvRT3Muw
 1A0w==
X-Gm-Message-State: AOJu0Yyk/M7qLJhKECi4jBhrl6+pG4E98Xar6W6eLSl3LZ5adIB5ailX
 vpFDL4XxTk0b/ZWH3pPJbm4BbFddrTBfBTSoxytQRgni7thexamQoZnHcwkmKTD8lxcWCmpqEVm
 9b+tB
X-Gm-Gg: ASbGncvR8hDUxF0zYZnOTCMwSzAwl4B70jho1scrIg87umW9zhftDPbHEDPfFobRZLw
 dt/RtPLZ9nlSdw2ovvzHFrCx+1MTxEyhBfwfWC5kQiMGwY/W7QLOBnrR6/02CjqSuH41IE/Cra7
 Pl4KHz+RNJWCGIjZLVzVsVv+1zhEXjztrVz05Wh7KQ3xJbcjMwYnNWohXG7OHijaShmtSylZzZI
 2xUDP7jHwOe9LCqvXFRlxVh8epFY4wzXxiYn8miDd6f/M/uF+7D2NUzXeKuRDofM6lrXJNhjWgK
 kJW15gsINf9gNWboEKgCuDHComfmwN4ir/g1f+ZJfdxHgLTKPc4PXTLnE2/rwVe7ErKeNWpU9Mr
 6BP2ptSwjI+Ug/rfOy66/QWUcdsuK1ODiRpGF/x3AE6Aq+o+77LwxrkCf84GD/3/W+v9I2Gw5T6
 fp8qdl9RQjdA==
X-Google-Smtp-Source: AGHT+IG0uzV56S+Q3O8b+sX45ycBAFUkQ8fuad9Y6UGFaJ2Q+JT3p1XWOZCznNjuH7Cj9oTmYkn8AA==
X-Received: by 2002:a17:903:22cf:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-23ff707feaemr37050175ad.17.1753603618312; 
 Sun, 27 Jul 2025 01:06:58 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 50/82] target/arm: Split {arm,core}_user_mem_index
Date: Sat, 26 Jul 2025 22:02:22 -1000
Message-ID: <20250727080254.83840-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


