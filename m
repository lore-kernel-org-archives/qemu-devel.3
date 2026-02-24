Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BFEF3C99B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuuZx-0007yp-4C; Tue, 24 Feb 2026 10:44:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZp-0007rn-40
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:58 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vuuZl-0006Im-1w
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 10:43:56 -0500
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b8fa449e618so912901566b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771947831; x=1772552631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7a4s9yfVfg/sM27gpDGwRk6HTs+3jP0sag1g142pnus=;
 b=m/Z7tGB+6KATJGyQseJ7LdPCT05GDWvN2LXD/4rLbS2nNPjouIhFLS3SiD+SNaRSOg
 bp23wxycE2l2lIePy4QiCuYairwinE/wzVxelbxq9TqdgpAVY9MHpWuI2pCZCRtrxF4Q
 Ht3U+h5D5hgWgsK65mQU3a1aVBRF30IagEOsBXSiMuynRompXjEcs2juQQhzfrmt+Ac+
 6+/wCgPzwoc313Pakdm8h4wc8lgnpq+ZVdfKEgHyq6UKlW+RSwWIk8g/YlgQP4+Xj6/G
 4cN1+U58+W7+zLVGI/JER/w8/hVjPLLDHKbfTGZmipEEJjPDazzCK9vDMh1hoOajhIDn
 Z73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947831; x=1772552631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7a4s9yfVfg/sM27gpDGwRk6HTs+3jP0sag1g142pnus=;
 b=R5xZzhIgM0eV7FqtSnJDJguHVMduQnnrJGa2JMKZUNal6NmAtVqSRm/sp2yrigbGXS
 7acj0ynp71EXFVn0y1w/c9LOuxt/WqfenlMmPHYhQz/5pNIO4uUyLN9B/0ZktqVPWYCq
 YA20W02R2kXJZII5af2Aen90h2tMrhI78lBOsJEGrqgc4L+2NZwDYjwroHOcQPbvxvYM
 3P1Ph0e/o24wusFeuFOS3QkNaGAUDIOoIb6vedDaGrzHZmzqNjKwahgXzVRdirIic9kU
 gvyRh1AwFLLr184sXlgkHr3A3N+oYjBKWj2Mjqf7MkWTD2nAwO+QWkjUVBLPncFtdRUK
 cTwQ==
X-Gm-Message-State: AOJu0YyB8Hb13FmZgwpa6KiviNw1r34SKG6IAB9vCC0SFOfP+zXn4Ci+
 KWbGPQYb+UoWaVY/So4DNjHx39+c1wGuMdXI/lk0zz36Q3tsp/VK3mq+oXAJHs+aoGc=
X-Gm-Gg: ATEYQzwSD6uuKLdOvMIuws1RYrByJZmFk81XlekOS7WfZbz/eT1IWuoWeIdlO+E86dZ
 XRrCuHYWWcWjKYnQwtz/6x6bYkUEtPdQ0cvy0+tE7nUPkhnKRTcbp3x2Wf3IjHy1mcHv8XudjKJ
 lXvVD8/nbn/r4PJbLofl3svvDoy7GNndhxU2XbizYBu4qSIm96u7MAPFGTcKNr0poznGSnGrMX+
 64ZFXB6/b282ymMhzB0SC95L1COtJMtiYXlTOm7D9s3w6v14CsQyQlkjL4CTcwjFaEW4inM4eJm
 BwNAzOj2m7/UmRCcM0iTiq7XwZQvi677xXgEaYapbWHFBu36WX4msss1NRt6rSsKsa2DIqPiPv3
 yttJKjAC4m4wwRzwfcA/Cus7uJrXDcFbsLAi0qURcCzQpmW0b3ls2rqS0gYzM5vW2y/B14lHSJI
 S+ZALHACilBLzzmXyIG1nFD+U=
X-Received: by 2002:a17:906:209c:b0:b87:1590:d528 with SMTP id
 a640c23a62f3a-b9081b6d72cmr475534566b.40.1771947830911; 
 Tue, 24 Feb 2026 07:43:50 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b931f81b914sm61831966b.7.2026.02.24.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:43:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 790255F8C1;
 Tue, 24 Feb 2026 15:43:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] target/arm: pass rd directly to wfit helper
Date: Tue, 24 Feb 2026 15:43:45 +0000
Message-ID: <20260224154347.344219-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224154347.344219-1-alex.bennee@linaro.org>
References: <20260224154347.344219-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x641.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If we generate an exception for WFIT we could also fill out the rv/rn
fields of the ISS. To facilitate this pass the register number
directly and read the timeout value in the helper itself.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/helper-defs.h   | 2 +-
 target/arm/tcg/op_helper.c     | 4 +++-
 target/arm/tcg/translate-a64.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 5a10a9fba3b..a9a062cf777 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -55,7 +55,7 @@ DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
-DEF_HELPER_2(wfit, void, env, i64)
+DEF_HELPER_FLAGS_2(wfit, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
 DEF_HELPER_2(pre_smc, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..28a1c7243ad 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -409,7 +409,7 @@ void HELPER(wfi)(CPUARMState *env, uint32_t insn_len)
 #endif
 }
 
-void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
+void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -428,6 +428,8 @@ void HELPER(wfit)(CPUARMState *env, uint64_t timeout)
     int target_el = check_wfx_trap(env, false, &excp);
     /* The WFIT should time out when CNTVCT_EL0 >= the specified value. */
     uint64_t cntval = gt_get_countervalue(env);
+    uint64_t timeout = env->xregs[rd];
+
     /*
      * We want the value that we would get if we read CNTVCT_EL0 from
      * the current exception level, so the direct_access offset, not
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..073454b9195 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2064,7 +2064,7 @@ static bool trans_WFIT(DisasContext *s, arg_WFIT *a)
     }
 
     gen_a64_update_pc(s, 4);
-    gen_helper_wfit(tcg_env, cpu_reg(s, a->rd));
+    gen_helper_wfit(tcg_env, tcg_constant_i32(a->rd));
     /* Go back to the main loop to check for interrupts */
     s->base.is_jmp = DISAS_EXIT;
     return true;
-- 
2.47.3


