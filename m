Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7975DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usODi-0004bG-VG; Sat, 30 Aug 2025 12:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQf-0007GG-VF
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:10 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQe-0004sd-1s
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:09 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4df220483fso505678a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532827; x=1757137627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xtnxT94KMGz92qj0rHCZHgfy98zANUVCadhNE7Sddw=;
 b=uDUpwLFsDUMZzWuf009db4ygGeqIiipP4SnLbmwN2vzgfqShLhHphn6ZS6PO4NmdJo
 R+uJaoWlkHnNiG8bE1f1X7ITQCvTH1KkOGqslgiBaC0ZpDIn+aFLttABZt7TchdkvpY+
 7nzYB5kMUXHA5WjCY/ApeuAO1H6b4Eq67eKxrbTY4n0yE7ebi+tCQWlXW1sReeBblw9o
 B8UurcBfSO09d1fL5BNeR1NMeHx590qLcuUFTnzaViVjNK67gUB+Pir57EqRLf+JhDkY
 fIP4/WvOP5Sd9VXaaDmcWSQp0q8NC1xkAQAU4pLI/XLIXTEyGUag0ZoiPtIIQD2Bxf5E
 BDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532827; x=1757137627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xtnxT94KMGz92qj0rHCZHgfy98zANUVCadhNE7Sddw=;
 b=euAI9IIskjmRQlo3crArgEu9p+1qFpVgg+SB2c8esH1kyMp9l8FW8ilC3FSYsOPi1e
 1f+FDvOWwFiksnsKwgQcRQgrbAV/LMcwBUoZPIXzZZU248BnPnd0+jPviPxLCB0V+DhB
 qV9ozMFfb3SYD/ZDkp5tagux+ggBvD+83SG9tAiRMizdZ5oSLLOgYWnscfhuVHaqI+Lk
 mJXngqInbibBrwlhO2+z0ncmfFZetEa8qDApI9wGUmWyEC4lRB5fvl1jFh0x8z6GrFd9
 +gmui030Kc9wo0a1tJnBzFlMoeN7U7FOYG54xaUGNu2jFfcMDBlvL45yl1rXLXvfSuza
 By3w==
X-Gm-Message-State: AOJu0YzCu6Qu16wCX5Qq2yzNZkQg4Jtc02ejMFlnNtbtffWuM9/avMuc
 ng+cIbuvN5bpPMR05uJRu/1cYUavEmdRh+BpxLyA/vQkevh8US6nHExoVfytGvtDmdVRazTTd5Z
 XjWvovWw=
X-Gm-Gg: ASbGncvMz571Vpneq0BZWtqdnl57zb0FuAflgxIySQaqncWSE4heZHFObQHjudzCmZ1
 aPQLRAdnA/iY1uitPM44VKV/vg1i0sdI9qertczEv6UhAoRicTcFb4a49F+89GNM9eHt/OhZgxI
 zbWOzV5X5LQeh+ghBRncZZLq7t/pQD7iHYrcwxbl7a8NJIbvhVQwJvHtHYCohYAsxeb5SeSoF7T
 tY91iRCGgzRNuGOFVFkU9Km6tgbupKs6o+aXpGvPqXI/ROUF+0osxojutq5UyVlw1PrWaSqQGby
 +ytr0/ZQDmbUX38EMR7Wf1VdTfDCwXSmd+D2SgKb7puXntwxha+vxBazs/2MS+Pvctik5rnln5+
 MjVPeoiz6zhzyw5tLRgdttCWh3Sm5EBdbG9rc5jSmXKmw/GOzLY58p5RvNPW2iLA=
X-Google-Smtp-Source: AGHT+IFrH+pIfDK8BbO+bGnPeFXgi3/fLiEg1GosYQoBaDCl62++b/5gZ80lqqeEDn0VMnblooMynQ==
X-Received: by 2002:a17:902:eb83:b0:248:70b9:c70b with SMTP id
 d9443c01a7336-24944b1fbb2mr13565705ad.55.1756532826597; 
 Fri, 29 Aug 2025 22:47:06 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 53/84] target/arm: Split {arm,core}_user_mem_index
Date: Sat, 30 Aug 2025 15:40:57 +1000
Message-ID: <20250830054128.448363-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
index 8c73f54e9a..ca1633540f 100644
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
@@ -4476,7 +4482,7 @@ static bool do_SET(DisasContext *s, arg_set *a, bool is_epilogue,
         return false;
     }
 
-    memidx = get_a64_user_mem_index(s, a->unpriv);
+    memidx = core_user_mem_index(s, a->unpriv);
 
     /*
      * We pass option_a == true, matching our implementation;
@@ -4530,8 +4536,8 @@ static bool do_CPY(DisasContext *s, arg_cpy *a, bool is_epilogue, CpyFn fn)
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


