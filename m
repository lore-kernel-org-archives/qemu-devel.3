Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F416CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNzU-0007vl-1r; Sat, 30 Aug 2025 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERN-0007Sc-AD
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERL-00050u-IA
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-248ff68356aso11843525ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532870; x=1757137670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58qPU9DMZkiZiNBL/rcJ7zUrHBcuvFVlT+jgfO7pgc8=;
 b=WrrBBnL5dZ8WFmaXYjYVBnyUMakSfxl27W8qbQy4T5ngBxoh+z1WrUWuCMVegd38TA
 hy3oBRqZFBtW83o00eMM8vLAyRSTK5dxRoMjRoNh+85xJ7vGTLstAJ8Sb323+mFiU7Yi
 X1KTVoEhsURKJTrofrb6M9HE4cjRv9qp3w33irNusGqmcKAcpaTYb2HEcFYF2UQc0XG+
 xBX2c4BiyA2AGVWXbKDCAjicfRGI25gMhcKQ2Hk0D5/2UCrQwcr+o5yr3CzX2QJ0gFeQ
 qvllUhsUTtKfcIBUoSOHp8jQc6uIJ7KGtFOVdHJn/2aNSnWLr3AciZ5M5rG3vfuOya2n
 SFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532870; x=1757137670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58qPU9DMZkiZiNBL/rcJ7zUrHBcuvFVlT+jgfO7pgc8=;
 b=XrMOxjPlq+CC+D2nIk43DEvS/oVMtUsWUzGVYgE5LxLJgEI/l0nOYlrFqoV+K55QVy
 6K5FICuXj4kbAB96bdMNLgplIQdT9svmhVVS9xpRP8z3B00CsaGksnpj8PLxcqArNKAB
 ufBrTBDAxPb7P9NzsKahFluuofiKleVip5ggWF2MX7WXS4KG4CE/N6wTfuopbktNUbTv
 i/lxsJl/IC/pVa9twIJS1zWYjvpD6gQ1/p/LhR2votfyMUx/5HK0sHcch+493QfBeJ0s
 eKSJHW2YwMxjZOVr1FyHfs1CH5+AwE4ciSzdXQytm0QsSxpARUAmBA7JfkqitxDpDi8H
 kjMg==
X-Gm-Message-State: AOJu0YwixYNbFSBxB+T9hEQ4qvNV2clEExdiYurdfI5e+jpF0/oLSW2E
 Dh819F0dg/IFrGvqWyClPq6DIQfyy9WuhCYG+PVEXsVp5Bkxf0a8WtSdEouIH+bmFS52fU2XOLY
 0lsoy1Sk=
X-Gm-Gg: ASbGncun6IzC/SwmVzXEGNWS+B4ufWdbsjJav6fH0vth4RpaFQZf4txgMPwXs4vL9UB
 jS0DtwmdQ3CIXC5b0RZNglAaMgtXBCgW0RMLNVBps9LkmWzf0YMBtIBbI02Cei3zlMFMvLuwpw0
 MJKdEwpOjjNkFQTVUKX39ls14kAlgmhDFDxuJ9LA9gxZm/BubM49sW28xdtR5WyGmT3+DFTp7ak
 EUzRCCZTvtMllLO2afiTlGaSVl+VGJYIA3YoayooWE39mLHGZegTskWxi1uqLz2psAANQdiQwT/
 k50zwuqfKxCB6gp2Xg4eOBKixUX0KM/LwQhQNCMi21FiRiLgmLDWJb4MP8CQ8ILy6qd92B/lfIX
 IHQxgbu7SFzvQs/fo1fk0n9bo5IDGcchg+hhZbayH4XgADzxfD3ZnGFHQWFe+uXoKQP26zcEnsA
 ==
X-Google-Smtp-Source: AGHT+IGRqZA1SkeOgylgeFXgPGkAeJDjPAKcKlJ71DTe5ZoKaVaX9Offa/XD00ulaCszmoD4VKg6UQ==
X-Received: by 2002:a17:903:94c:b0:234:8a4a:ad89 with SMTP id
 d9443c01a7336-2494486df45mr16534905ad.1.1756532869835; 
 Fri, 29 Aug 2025 22:47:49 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 69/84] target/arm: Load gcs record for RET
Date: Sat, 30 Aug 2025 15:41:13 +1000
Message-ID: <20250830054128.448363-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 20e18687d5..3ddf4bb018 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -444,6 +444,27 @@ static void gen_add_gcs_record(DisasContext *s, TCGv_i64 value)
     tcg_gen_mov_i64(gcspr, addr);
 }
 
+static void gen_load_check_gcs_record(DisasContext *s, TCGv_i64 target,
+                                      GCSInstructionType it, int rt)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 rec_va = tcg_temp_new_i64();
+
+    tcg_gen_qemu_ld_i64(rec_va, clean_data_tbi(s, gcspr), mmuidx, mop);
+
+    if (s->gcs_rvcen) {
+        TCGLabel *fail_label =
+            delay_exception(s, EXCP_UDEF, syn_gcs_data_check(it, rt));
+
+        tcg_gen_brcond_i64(TCG_COND_NE, rec_va, target, fail_label);
+    }
+
+    gen_a64_set_pc(s, rec_va);
+    tcg_gen_addi_i64(gcspr, gcspr, 8);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -1798,7 +1819,13 @@ static bool trans_BLR(DisasContext *s, arg_r *a)
 
 static bool trans_RET(DisasContext *s, arg_r *a)
 {
-    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    TCGv_i64 target = cpu_reg(s, a->rn);
+
+    if (s->gcs_en) {
+        gen_load_check_gcs_record(s, target, GCS_IT_RET_nPauth, a->rn);
+    } else {
+        gen_a64_set_pc(s, target);
+    }
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


