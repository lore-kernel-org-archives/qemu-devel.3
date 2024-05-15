Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EC7C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:45:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7BBL-0000Ve-Db; Wed, 15 May 2024 05:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBJ-0000Hy-Cx
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:17 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7BBH-0002Ti-2V
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:44:17 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34da35cd01cso6137774f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766253; x=1716371053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcpRneuuBHCGfIHWgKcPe2ud0xuCeDPw4xb9NImYzmI=;
 b=oW3/YGXTTDfI8qiLuZTQuHnGVO4QNZoIs1Cg68pilSOO0WV1gISoBzIFFa6koE/rD5
 kakiHCMfCPNg1HlhdWljy9MI8UHWhUmyl3LiDQwcCSrohMDpvMGJ5VaBtfk2ShN4Ul91
 7l/5GKybYUn5iMgnUnQbkckgfatLaiP8JBUOZdyRv4UAZigiaC2IRFATl3W8oyi07JV1
 M+YmZpCkDMi822iqOytZk+yslAsIG5B9YZQ36p98wsduCM0IGDcpC1ahaBxyksmC4C1X
 hCOa+JzxnF0l8qX6+xVtUhNzxHoN3RI1QvV/N8V3ZkQK9522HgGRvU79lrYEKJrA6D4n
 NaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766253; x=1716371053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcpRneuuBHCGfIHWgKcPe2ud0xuCeDPw4xb9NImYzmI=;
 b=HbNCJ7DcIMp3hwgT47yRBbsnf/CcBSbTdTnPj43dAuZZ0WuodzlAdUDsVpmStOfkPa
 zKohzjY7Zi7ZckgwVq12GWqWlFEUSJwPIZH/a9SQzVjWkGABFvslLNbp35aJ42Imw8DS
 XAMZoKl9r9VcGnuy2cjEEFsmrnzS79Y1rEy2I0bF3RWzJ+4SCypcWzVnJ5BULhRRwS43
 4ubEX0k40uefwwsW3z2YN58ko9p62c7M5swYfWUtWvZfUd/h5n7Gurf90IYXZ76Uf5tj
 UPU1e9KGwyxiUMlW5kBl4UY06Hn2Po4DV7tAwc/6767TrYNqTDYNk/3EUu+607VeTUzr
 yfHw==
X-Gm-Message-State: AOJu0YzKwR6ypiqAyKIaTCP47UQGCdk5lHmqGuB5PUlMxLNy0MSBluTu
 p9eYWSYOXw7obCQPRTA6GRQyzLl8t1fb3KHyJ7ZAou5MKLUWoiZnwikY5cNaT9zab7LmgqtUl4V
 E9GQ=
X-Google-Smtp-Source: AGHT+IEyNvsvNVgEdqFCWMXFkJWikyrWatJ9OCe8XskZBpIbm2ILrMQeWuaMdHezq6bdsCAK2ap1pw==
X-Received: by 2002:adf:f3c2:0:b0:34c:72aa:6fe0 with SMTP id
 ffacd0b85a97d-3504a7372admr14223455f8f.18.1715766253556; 
 Wed, 15 May 2024 02:44:13 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc334sm15926239f8f.103.2024.05.15.02.44.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:44:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 40/43] target/hppa: Adjust priv for B,GATE at runtime
Date: Wed, 15 May 2024 11:40:40 +0200
Message-Id: <20240515094043.82850-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

Do not compile in the priv change based on the first translation;
look up the PTE at execution time.  This is required for CF_PCREL,
where a page may be mapped multiple times with different attributes.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  1 -
 target/hppa/helper.h     |  1 +
 target/hppa/mem_helper.c | 34 +++++++++++++++++++++++++++-------
 target/hppa/translate.c  | 36 +++++++++++++++++++-----------------
 4 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 78ab0adcd0..2bcb3b602b 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -380,7 +380,6 @@ void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
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
index 2929226874..b984f730aa 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -691,13 +691,6 @@ target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
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
@@ -793,3 +786,30 @@ void HELPER(diag_btlb)(CPUHPPAState *env)
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
index f40ac92e98..c2cee89a6a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3961,6 +3961,7 @@ static bool trans_bl(DisasContext *ctx, arg_bl *a)
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 {
     int64_t disp = a->disp;
+    bool indirect = false;
 
     /* Trap if PSW[B] is set. */
     if (ctx->psw_xb & PSW_B) {
@@ -3970,24 +3971,22 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
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
 
@@ -4000,6 +3999,9 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
+    if (indirect) {
+        return do_ibranch(ctx, 0, false, a->n);
+    }
     return do_dbranch(ctx, disp, 0, a->n);
 }
 
-- 
2.34.1


