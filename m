Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D4ECA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTIR-0002u9-6r; Fri, 22 Aug 2025 11:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGt-0001qy-71
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:40 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGb-00050Q-5J
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:38 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24458272c00so23722095ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874872; x=1756479672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NhduwSVHFJtmbAuoSXf5vp/8JFTbyhJo4xB/s950yU=;
 b=XtUWo35QSklJIjHCCAfytZS0pkBmgudg1gpCM3sLXZGNOrkcahXrHCH6iDERcJitxN
 rhNHzxwJHqWd3rJRBI8Vab/Oaju3G5XhQwNbNb3ohjkqJkCY3XFLNWVYQrK36xIg/tYX
 FsJNHdZJKAYfHfF2OCcRG/BwJ2QT4AezLG3Rf2NzNvaJmXq/Xc9aQlQ53Vi6fxRRR6uj
 OuzAwiDf/KVJpV1hrd/fTscIwJyrm0VJka5fuYEsRv51fHXiGQFZnq/LtFDZPyt+WOm/
 W435d89rWaMp0Srn4/9Fb42zons8eXXjKOXSIGxLXEY50xG0keTlRnm8lNRtrKcCcMol
 ZBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874872; x=1756479672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NhduwSVHFJtmbAuoSXf5vp/8JFTbyhJo4xB/s950yU=;
 b=w43pB8kewRztwt8WCbJ082wsy+uSb3syLIDG9S9E78VMmMRRKeIIluejOEMNFnFicO
 +18zKflq8TSVve5tw5UAEZlTy/11e1VuMsZLZ+08mcMvwfxF19I6ncqrclpBqlbu27XR
 4wVgGm5hGmIQVzPDilmA7z+TR5Mae8K5biLm7IH6ajAFNIF9Nxme8MG4l5I9yi3GMnut
 GsMmrviO7prVeOUKvpksb0N3TkgaiUwLXp5baqVd9lrZLb5EtwzEVRRHhiBjKPY1pDUv
 oqTcUyTeUMzo7zMNjWc2t3mi+aAc5kDbnXpjVIuIkOuPfTK27g4M5e5P2V4CT7wKykbF
 yJFw==
X-Gm-Message-State: AOJu0YyNLdLZt9xqiZI72EY/lEVOJg+BAng/knhGbnIyEKUgrYp/shdA
 NXzq3XnS5UzIbHuk4d2F2848Q3OsjXUkT5vPDU4NHE5gHpat/fOQlA/VQRA8bJH2FcglbFUJuwB
 N4ImkmPnYjg==
X-Gm-Gg: ASbGncu9yuxFMTZkqgwXnOsGvg4xUiNsF3qTdp0QdUdhFoKbTS02tnwRvenUnmeYoQa
 bD6mAZw6t6Wsj0KO5MYEmppkOQAyAha/df2+NL80D+j52YwRoO7VhMm+AeibtueBpFClLUg8Qqu
 bSnTxAHEfpbTMPzSPUO2b1q1ErhLklRisz70qmuLeWqEup3TEuxWQzSsXzTq3D0Yc9UihnASihO
 /N1ACsnxruCssn3m7y3Ke1VOP+mwcQ5mXgSx1X1by7Tzo0siG/TTmq4EC2WaPqrHO9TPzFbmoLz
 SkmDU96Rwhfy64raQ2I7On8oK8wbFVMX67iy7cJx0mqALka7DzfAFRTVqiAtn+xGGInOGe3gQZT
 8myjYxmnmYbU7yGSGLEUeAmZeaenboOW+WNmhO4L/EoY=
X-Google-Smtp-Source: AGHT+IEJzCll6RqVE/5VCuu0Q08A66b23ZFkHXuRy5cswO7+hyICPJ+BAXHiwXuiwU+N+XGfMPopgA==
X-Received: by 2002:a17:903:230f:b0:242:8a7:6a6c with SMTP id
 d9443c01a7336-2462ee59160mr49861175ad.17.1755874871995; 
 Fri, 22 Aug 2025 08:01:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed5406e4sm85929495ad.165.2025.08.22.08.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 08:01:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 06/12] target/{arm,
 riscv}/common-semi-target: eradicate target_ulong
Date: Fri, 22 Aug 2025 08:00:52 -0700
Message-ID: <20250822150058.18692-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

We replace mechanically with uint64_t.
There is no semantic change, and allows us to extract a proper API from
this set of functions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/common-semi-target.h   | 6 +++---
 target/riscv/common-semi-target.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 7bb442f24ca..6775a270aaa 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -12,7 +12,7 @@
 
 #include "target/arm/cpu-qom.h"
 
-static inline target_ulong common_semi_arg(CPUState *cs, int argno)
+static inline uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -23,7 +23,7 @@ static inline target_ulong common_semi_arg(CPUState *cs, int argno)
     }
 }
 
-static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
+static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -44,7 +44,7 @@ static inline bool is_64bit_semihosting(CPUArchState *env)
     return is_a64(env);
 }
 
-static inline target_ulong common_semi_stack_bottom(CPUState *cs)
+static inline uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index 7e6ea8da02c..663dedfdad2 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -11,14 +11,14 @@
 #ifndef TARGET_RISCV_COMMON_SEMI_TARGET_H
 #define TARGET_RISCV_COMMON_SEMI_TARGET_H
 
-static inline target_ulong common_semi_arg(CPUState *cs, int argno)
+static inline uint64_t common_semi_arg(CPUState *cs, int argno)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     return env->gpr[xA0 + argno];
 }
 
-static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
+static inline void common_semi_set_ret(CPUState *cs, uint64_t ret)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
@@ -35,7 +35,7 @@ static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
     return is_64bit_semihosting(cpu_env(cs));
 }
 
-static inline target_ulong common_semi_stack_bottom(CPUState *cs)
+static inline uint64_t common_semi_stack_bottom(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-- 
2.47.2


