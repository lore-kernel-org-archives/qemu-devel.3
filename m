Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723EC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmcE-0006gH-TI; Wed, 24 Apr 2024 20:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmax-0005Fg-1d
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmas-0007tj-Q4
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:08 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e9ffd3f96eso3558315ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003444; x=1714608244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sIcgMZsbCQjMNHUGM6x7heye+I2mJEY00KtRZt5wXT0=;
 b=rWEA9QXYcqvVGX1fNHzdZ45nJq2EeQy3lWGkkYxW9hE0QXe+SzjtsJDTDWuId9he1U
 h7EznO338YFi7vh/CPzPdYs5pPrHopjMq/pbi+TL8p4Ctkv3pu25nzBzkLFQMFPE7E7Y
 Rie19PX5yteDgFgiJvZZzLeUWLvrLrTGrxZH5hDKEjGLbG1pBgcki/EvHxt5WdLO/QKK
 7ELWQoywcn9gF1jMIgSlVPyOY4wcTRtfLABYjKg84SyZ8AxQvqVaf8OVMSuzwLm1S9d6
 Xk6K2a/ODJZ++OxeHYoFgaR62ITZiSdSdw/RpKi/6bt6Jlqxf9Db8DsGoh85zcS5sWfv
 Pedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003444; x=1714608244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sIcgMZsbCQjMNHUGM6x7heye+I2mJEY00KtRZt5wXT0=;
 b=KtGbF4zxrjC11ueWdcLrgG/FeITqzmDNCM5NyaUc6sQ6KGKfOZP3tRa8jvaxhm+ftu
 j8QGORSeRllkqTUqskbNGPh8PWdQmU1OtqG3s3b2PpYh+Nlu0SWP1I8cSfbmBH5kyqVY
 VsVNmrV6KJRpNrLPN15S09BpoikDMNat6FCeZ6i4a0s2blzvTCbzy67S1eePjf1ehXLI
 K+dDM2Ooff1wT5QMV+xB589K4ruqGUoHp+tvFumayqsfFkWtm/uMsIw7SGnjo14uqPWd
 tTakbxdN5x90n2sAkrF5SicvlpBNyBY6JxNUMH2N9Ct8hG5sGTKR15qFpSTQ4d1NxS3Z
 vyjA==
X-Gm-Message-State: AOJu0Yw/KnrUqdwxQCTiJW7Vw9ojexz3TaX3cXHotJ59hrdj1wCVRNTs
 WT988OyRyAnw+32bPnytU6zzUEcFDPgWVlC7bUY5BMAdBZqZEUWIJ6Uz6bnK4BskqNo18ewtKUv
 m
X-Google-Smtp-Source: AGHT+IFScLH1Sz58svI+t05Fvj4HB6dsaAgzDTPIsPDXLU6RGqbvo4qcpbHHRRNQgAUYUN+E7f6FXQ==
X-Received: by 2002:a17:902:f547:b0:1e5:62:7ac0 with SMTP id
 h7-20020a170902f54700b001e500627ac0mr5773548plf.14.1714003444228; 
 Wed, 24 Apr 2024 17:04:04 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm12483717plb.296.2024.04.24.17.04.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:04:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/45] target/hppa: Adjust priv for B,GATE at runtime
Date: Wed, 24 Apr 2024 17:00:18 -0700
Message-Id: <20240425000023.1002026-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Do not compile in the priv change based on the first
translation; look up the PTE at execution time.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 -
 target/hppa/helper.h     |  1 +
 target/hppa/mem_helper.c | 34 +++++++++++++++++++++++++++-------
 target/hppa/translate.c  | 36 +++++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 5f3e99cdc4..8523f22452 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -386,7 +386,6 @@ void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 extern const MemoryRegionOps hppa_io_eir_ops;
 extern const VMStateDescription vmstate_hppa_cpu;
 void hppa_cpu_alarm_timer(void *);
-int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr);
 #endif
 G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra);
 
diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index c12b48a04a..de411923d9 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -86,6 +86,7 @@ DEF_HELPER_1(halt, noreturn, env)
 DEF_HELPER_1(reset, noreturn, env)
 DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
+DEF_HELPER_FLAGS_2(b_gate_priv, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 3ef9e80064..6756d36dae 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -690,13 +690,6 @@ target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
     return phys;
 }
 
-/* Return the ar_type of the TLB at VADDR, or -1.  */
-int hppa_artype_for_page(CPUHPPAState *env, target_ulong vaddr)
-{
-    HPPATLBEntry *ent = hppa_find_tlb(env, vaddr);
-    return ent ? ent->ar_type : -1;
-}
-
 /*
  * diag_btlb() emulates the PDC PDC_BLOCK_TLB firmware call to
  * allow operating systems to modify the Block TLB (BTLB) entries.
@@ -792,3 +785,30 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
         break;
     }
 }
+
+uint64_t HELPER(b_gate_priv)(CPUHPPAState *env, uint64_t iaoq_f)
+{
+    uint64_t gva = hppa_form_gva(env, env->iasq_f, iaoq_f);
+    HPPATLBEntry *ent = hppa_find_tlb(env, gva);
+
+    if (ent == NULL) {
+        raise_exception_with_ior(env, EXCP_ITLB_MISS, GETPC(), gva, false);
+    }
+
+    /*
+     * There should be no need to check page permissions, as that will
+     * already have been done by tb_lookup via get_page_addr_code.
+     * All we need at this point is to check the ar_type.
+     *
+     * No change for non-gateway pages or for priv decrease.
+     */
+    if (ent->ar_type & 4) {
+        int old_priv = iaoq_f & 3;
+        int new_priv = ent->ar_type & 3;
+
+        if (new_priv < old_priv) {
+            iaoq_f = (iaoq_f & -4) | new_priv;
+        }
+    }
+    return iaoq_f;
+}
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a4200742bd..3ae196490a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3959,6 +3959,7 @@ static bool trans_bl(DisasContext *ctx, arg_bl *a)
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
     int64_t disp = a->disp;
+    bool indirect = false;
 
     /* Trap if PSW[B] is set. */
     if (ctx->psw_xb & PSW_B) {
@@ -3968,24 +3969,22 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
     nullify_over(ctx);
 
 #ifndef CONFIG_USER_ONLY
-    if (ctx->tb_flags & PSW_C) {
-        int type = hppa_artype_for_page(cpu_env(ctx->cs), ctx->base.pc_next);
-        /* If we could not find a TLB entry, then we need to generate an
-           ITLB miss exception so the kernel will provide it.
-           The resulting TLB fill operation will invalidate this TB and
-           we will re-translate, at which point we *will* be able to find
-           the TLB entry and determine if this is in fact a gateway page.  */
-        if (type < 0) {
-            gen_excp(ctx, EXCP_ITLB_MISS);
-            return true;
-        }
-        /* No change for non-gateway pages or for priv decrease.  */
-        if (type >= 4 && type - 4 < ctx->privilege) {
-            disp -= ctx->privilege;
-            disp += type - 4;
-        }
+    if (ctx->privilege == 0) {
+        /* Privilege cannot decrease. */
+    } else if (!(ctx->tb_flags & PSW_C)) {
+        /* With paging disabled, priv becomes 0. */
+        disp -= ctx->privilege;
     } else {
-        disp -= ctx->privilege;  /* priv = 0 */
+        /* Adjust the dest offset for the privilege change from the PTE. */
+        TCGv_i64 off = tcg_temp_new_i64();
+
+        gen_helper_b_gate_priv(off, tcg_env,
+                               tcg_constant_i64(ctx->iaoq_first
+                                                + ctx->iaq_f.disp));
+
+        ctx->iaq_j.base = off;
+        ctx->iaq_j.disp = disp + 8;
+        indirect = true;
     }
 #endif
 
@@ -3998,6 +3997,9 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
+    if (indirect) {
+        return do_ibranch(ctx, 0, false, a->n);
+    }
     return do_dbranch(ctx, disp, 0, a->n);
 }
 
-- 
2.34.1


