Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FACAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldM-0006GO-7C; Mon, 22 Sep 2025 14:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcF-0005Bl-MS
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc0-0004RZ-Ua
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:23 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77f207d0891so1613686b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567006; x=1759171806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=k6ZOlvw3H0ATNwAcOfu/bi3TvucMr61bFVYkX8gInH1Jpp2DPpL1ISROFzY+yQozSp
 jASUGZeVygfXNHe6Mcoqpu0lqcYR0Azj4Egcrttt3b5ItkNygZ4DHzcD88jHeCCHaCqR
 6VTWfV3J/BKvaN6AZOlm7BZ4dvDkMWUVZPZzIf+xOR0V6uCR/D0sqvngCj/o5965P8vi
 OwxudtCelAZgJhvoXiM2jFAoonMfV7H/mcK2EvWNHAJBmEt75srrJIsSGGMjJmttV/FL
 773KefrXCpRhqzPOV2K39voPgtuCrn33TBn1RwhSg+f4ZshuUjLHM2PHufE0lrNTEplh
 89+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567006; x=1759171806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=PWS+x+juPZGxDNgrbppJlucPgdw5bThO/52f1QQ9UG/CT9Srj2uWfNEsTjQCneJcwd
 n0PBe3RVdUorOoUTCQhLhxoDx5+o3wBwG5nsITVx1rAvPAz9XTSVEbTIhvlZkEj3+CVL
 npJwq2QbRQMixfkXcCT8KqIZkLLovsxncNZDJvA9Y5yILHwFC6taZhhLZkBfBNLVTR1t
 UH8dGQ0YsOSXIc4ju7U+Lv+9YXMcmStpFZt6d59wLpuBESBiwC+DYGuRUdc8m7vZLN+d
 0sXYSOHuxpTPenucd7QnrVdnz0eLO82a9SMU08fVq077x7tt1UY/6wUBsD1gQHd50r0j
 KPsA==
X-Gm-Message-State: AOJu0YwrLXrZwjnjR2124dOqeGB15X4Agjh98GMbqc4Fw/0IitBpJ24i
 sp7Tjmc4IaWSI0G4wBdAObeVfxXUfk6Ir+qIxQsI1MEUPvOWf9OLbDBgbGgL76EyKVIyRLWBtvV
 ukWgV
X-Gm-Gg: ASbGnctcQPfinJyKTVnmtaC1oCAOHazfgvEVtq+vPXF5UG75AlzgJeJcn4ze+7Bx1Z+
 q9+gkO/X25kPr8SLo/IbATrLVBJeBDmNSjyqFxGqfRga5QocurDzDG3OYSj1rEEsX016GyfWOZ4
 5/8crLS98nMTw7CnnF0d6x5L3Y590p5TmJK+zKbPU5WicS3qoNaCfnY2sa6X/M9PJbohzNg4xEI
 sefrkgrbQ/uk0Z8zzL2F7fKZhnVc6hylVe4AcnlvMZxQSuhkYTjzVrA6RxVS/KskUkUBo96z7Ro
 dunClUczWHInX4CBDeHDKeqlYE5dS8HhmNgFyZwK6O/17RDooD9imLgXNptadZGaWnt4QBGksYh
 0RxThiTxbLJgQNSjx2O79QsMNgyFx
X-Google-Smtp-Source: AGHT+IGQn/pmUoSuCSHB68LMbuj1TsTo6DC/hLuJCFO0CWSLw1G/JGLa3m7iot/J07QDqTKTEodUAw==
X-Received: by 2002:a05:6a20:748d:b0:24f:22af:ea26 with SMTP id
 adf61e73a8af0-2cfed265622mr139473637.45.1758567006371; 
 Mon, 22 Sep 2025 11:50:06 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 33/76] target/arm: Implement gcs bit for data abort
Date: Mon, 22 Sep 2025 11:48:41 -0700
Message-ID: <20250922184924.2754205-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/tlb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..f1983a5732 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -28,7 +28,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
-                                            int fsc)
+                                            int fsc, bool gcs)
 {
     uint64_t syn;
 
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)gcs << 40;
 
     return syn;
 }
@@ -252,9 +253,10 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
+        bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
                                    same_el, access_type == MMU_DATA_STORE,
-                                   fsc);
+                                   fsc, gcs);
         if (access_type == MMU_DATA_STORE
             && arm_feature(env, ARM_FEATURE_V6)) {
             fsr |= (1 << 11);
-- 
2.43.0


