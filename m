Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3E7C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JRF-0001bH-7j; Tue, 22 Apr 2025 15:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOq-00054J-Sh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOn-00071P-99
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227b828de00so60264945ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350516; x=1745955316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzXShXwzyB8CledzBeBuUJAwXnIfvn4Gim3OOlxSSgw=;
 b=jjnVXO7gtdinpI7OQ/wPvxE16v++Zy3Z6K7f+9yJ20OWUGaqwQdqpy9gniANYUYslL
 QbsXMu7h6Sb9vILyGPWqj0krJcmLA7ahR31O28Jjtjl4CaZOT7ykfxp4FXQQRW5lzda7
 5kibjqpCvV9CIcZ+DU5V+wcMWgyvUFYbt//cc/cyvpBRDAnM4pGZRwiG57sOhAqbNjmA
 CX3AFWKcF5gPH/OI4HkSsIgWIcMzb1pmcsvcgntfjB8Q13WLJzWjeSnKoo/1lNMMOA+x
 3iqmKYTc0e/CovS25QG2t3IyRZKGwruAvtMkXzUm4wynZMSkwKeLoUDDEh9JHiWhLC7b
 HJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350516; x=1745955316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzXShXwzyB8CledzBeBuUJAwXnIfvn4Gim3OOlxSSgw=;
 b=GwcBiX5RDWfQU0x2A/jYiitzqcRmq/jRVaO6vZ9hmEq22ejZ43hhwQVG8C7Bo3k1ss
 RtqNQlJoxY+eW9wqxJqeEM8UOYuvhsGJdfBbpD0EcxAclj4jTiscEdO+mBYi+vHkduyc
 1GxMOmM3jlDl9SqMURgDMVIXV1TT5nSyX2e4QMVWwmE9eq9MRXjK4DAf4MIIj/8+WSBx
 QeoBTlyATFEcYQZ837m/MyT6vJ/kRgkFrDkhsu/UF+z3jj23UI1iBHnknshnAaCs56w4
 4DxzHAwydGYFAZQw7eV38eBal9cGak6TmjR3w3Jm5V0WueWJ2emru2RRntoajAGxSrod
 768g==
X-Gm-Message-State: AOJu0Yy/3cANG6tpOetvmBJYzn8aI2bBBAX9C9xz09syOeTqp5yMDVSH
 5155UXQ3Winrvg5jd6/2XSWVhgmElrHRaULSpODkJG20qijGharYILYDizv+zGFlc/ieHnPdNeU
 +
X-Gm-Gg: ASbGncv4z61GdDjBfPo5tuAGabDqA5M1xXObGqLvAzvtki+vhHbbykG6+jF9FBKSY0d
 3PWKpQ+fixCFqmV4pAYwvBVQgjdY535+PCLvJOxFAUSnR1sjoY6i6uEHVOyEdt92c4BKRmV6Vh5
 ZxGj8k4b6+sf7Ksnbv9dCUujh+aEz2beAEwE+YfIXLdCsz7FnKocnev+EDIi1GS0/ezU3KSkvAz
 EVNB3hHTFhlZWT/9/2EY5bTtqhJXDw8S7m6r80YIdSdaYjnKAcT5kosl2sBrJExeHB7lFofyXf2
 leKGmHFpSnF5hiZEXSyBZL2FspCHgiMO0gb7heS8N55MvhrD8dPcqhSoMCWs7b0voFgO4N7O5dI
 =
X-Google-Smtp-Source: AGHT+IGGr2KkXDaLlZAGf1niMUDGG1nEVMHrz9nrogXXWdWFvypwPZdEdSGQMsoSmzXKJSY1GoeN8A==
X-Received: by 2002:a17:902:ce01:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-22c53581231mr280751445ad.12.1745350515914; 
 Tue, 22 Apr 2025 12:35:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 084/147] target/mips: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:13 -0700
Message-ID: <20250422192819.302784-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-14-philmd@linaro.org>
---
 target/mips/cpu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 47df563e12..cb0d6dde0e 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -182,11 +182,6 @@ static bool mips_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
-{
-    return mips_env_mmu_index(cpu_env(cs));
-}
-
 #include "cpu-defs.c.inc"
 
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
@@ -549,11 +544,18 @@ static const Property mips_cpu_properties[] = {
 
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
+
+static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
+{
+    return mips_env_mmu_index(cpu_env(cs));
+}
+
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .translate_code = mips_translate_code,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
+    .mmu_index = mips_cpu_mmu_index,
 
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
@@ -581,7 +583,6 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mips_cpu_class_by_name;
-    cc->mmu_index = mips_cpu_mmu_index;
     cc->dump_state = mips_cpu_dump_state;
     cc->set_pc = mips_cpu_set_pc;
     cc->get_pc = mips_cpu_get_pc;
-- 
2.43.0


