Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2F0C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXr-0008Ft-3v; Wed, 24 Apr 2024 20:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXT-00088d-0e
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXP-00069g-Pg
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e834159f40so3377415ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003230; x=1714608030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sPOPP89zz2v/sO50UiLzGptqHlTjqXVxcZh0h8hT7xk=;
 b=JBykPiAJJnOAEdAqdZgEDVp0lK3YxwrCv4E35xwBcl118yZyoEzgidsOIxcaJsArbZ
 H3z4nIdew8OR4jv4B7U37lfzsNdlhCbmkhp5GOTNV8kVwBH71GOIc1tHEfwZAMSfDdkF
 Wik4Ex4sNA3UQUH9epp1L0o9A0Kv9NCRL/+49FvL9UG3K7JVeAGNd8+xybhsWD4qTNEr
 +AvDuLXLNf2YFvfnjfXl5jUwAeIqBLDeTt6Faze+1K8V8QAm4E8oEs2Au81x27kPX4OH
 V0pniLUvYyT/L24+0m2JFCkq/sT1mYtc2y/K6jXmBl0cwaoSk0u7Cyn0PiWUmIoPHCIc
 pF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003230; x=1714608030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPOPP89zz2v/sO50UiLzGptqHlTjqXVxcZh0h8hT7xk=;
 b=u4BnaWS50Yrh5JuCTew0FZCTt8oMMq2lgcnEs+DooM4ihuwRP6mbZ7LRakOD08WpRW
 rYNaOnnVb+MtUAt6c4xqlN3XI8+ESffrusCTosjceMXPgNz4Y/ZTMiKnWtP3fWgk+EfC
 pRxH6qnWw1vpIjoayzIiemp4pisYtUoJpMW77MlWbY9ys+WlOq0CyRUauVwTy9IMONvx
 r1zCzQDe0uwIr8bXBzOGgBdnOPayVAVI4DiVGytCrmSMefHtbJJLBCLj9KpJJmPCfqAV
 TwIUg1zkeSItlgYITHTfyocDjQDqNFy3Iygthn3FNG1jPJwOufiboFUX6zw8yEJVO34w
 jGGw==
X-Gm-Message-State: AOJu0YxJ1LQ6y+ZIemLatmpiGgEtk2WAyNXnqFeH99LJyz6xrjSJNCd/
 AW+eYqUgmtY4YGCK0cNnmXpIOaGbeV/mDqLKPJjuuNUuXSq8HE1urknQeIiiqPEy7cA9b9E6EDN
 v
X-Google-Smtp-Source: AGHT+IF5AONCJfw0D+kbAFnqdA0Z8G2+P9urDtnC/x2VoHIe2Z/Z3/w+rbUlL9bi9b1oIfFxEDgfmw==
X-Received: by 2002:a17:903:28f:b0:1e5:3c5:55a5 with SMTP id
 j15-20020a170903028f00b001e503c555a5mr5186794plr.8.1714003228481; 
 Wed, 24 Apr 2024 17:00:28 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/45] target/hppa: Use hppa_form_gva_psw in hppa_cpu_get_pc
Date: Wed, 24 Apr 2024 16:59:40 -0700
Message-Id: <20240425000023.1002026-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

This function is for log_pc(), which needs to produce a
similar result to cpu_get_tb_cpu_state().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 1d5f5086bf..7315567910 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -38,9 +38,10 @@ static void hppa_cpu_set_pc(CPUState *cs, vaddr value)
 
 static vaddr hppa_cpu_get_pc(CPUState *cs)
 {
-    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = cpu_env(cs);
 
-    return cpu->env.iaoq_f;
+    return hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
+                             env->iaoq_f & -4);
 }
 
 void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
@@ -61,8 +62,7 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
     flags |= (env->iaoq_f & 3) << TB_FLAG_PRIV_SHIFT;
 
-    *pc = hppa_form_gva_psw(env->psw, (env->psw & PSW_C ? env->iasq_f : 0),
-                            env->iaoq_f & -4);
+    *pc = hppa_cpu_get_pc(env_cpu(env));
     *cs_base = env->iasq_f;
 
     /* Insert a difference between IAOQ_B and IAOQ_F within the otherwise zero
-- 
2.34.1


