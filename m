Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFDBC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSi-0005lX-NX; Tue, 01 Jul 2025 13:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSb-0005h9-UC
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSZ-0003eu-WD
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so3890463f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389674; x=1751994474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oWq+MsMuHkvLIcOj3T9lPNr1c6oazCfcCQPJVuth2lo=;
 b=waegaM7lIf7kQwnhsxpVghq8AQYTLCDCK5dmS8TYujUr1iDp0t7VtAWUK6euUOafMk
 ZI3qSRuc74mByfwkGRHhTFQ1ie6rMPkbyIbEDQ7Fq2kfzGkpS7djw1jksMqZVKKaauk+
 volHygp2G6NU/8zrI+D8gVEPWawyj7vnb5D80GEit6Ly3hhvS8O+J0x3BgC8Cp466cyI
 mwEk+Fd3cC8H0PxMDIU7wrjQtYU+/3pBQf/nXn6FrZYkE5K6onA49PeJEER6frcIA2UN
 +eL0Z204pjUtd44/b2+VbDEiPLjtnWBJe/k6vaAZIdawpfFCbo5KqHk4FyYWMR51ztDg
 Z7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389674; x=1751994474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWq+MsMuHkvLIcOj3T9lPNr1c6oazCfcCQPJVuth2lo=;
 b=m9T4s28NxUwOYPmoRQg/kOJrtE01mNzEL4j4/G+resHwG6rxWDqLfxzidq3naTqUS8
 BYlXDaz5RPynMus3YuaEST1isZrKP3T7gWjaGoF0m5otqheqql2Nbk/3tppmVHOeZeae
 HwcbO/cKiig6XjhzFELFMqUDHkUdjWGjhXDk4mbD6plRrpvhrjlkMj3DGz2Rxw1+JdAE
 MGJY36qyyYpoHdYuceTJ64vYJ9Ts7t840W/Owq8QXGt6PpCgZeWR7Yz4MYB5JeNwLSJe
 RAlXq6usZvqtD3ryoaIjng+F+wdBAQTDyJPGDzh/NcSLHauoHDu8tGlQzpJLuQJhgecK
 k03Q==
X-Gm-Message-State: AOJu0YzxSYklGhbKMq9VPevngvQX87iDCSd4yvHFaYJ+kFkYqAw/RtSZ
 2g0zViM7v6DkJ61GIep4pdapDVQzJ/6aI+F0tGr/YYllIS7EejP3n8tYFREqnNOaOw9OUNEqtrQ
 KeQTA
X-Gm-Gg: ASbGnctSoy8zvafozKATvDsYTfiQGd1B7aeByb9hpeMUY5ePx/V8o/533xD+0Rn8HJd
 UL/0NrP+6ylXFBiCeBE4E4yOk9gv93ciAbuKdfS9wqCF+goXa1TJUPuyrR8q3O3j3nu+GOq0l5w
 35P2P0LI7sEHmGZAoqPGi5iQZtwruNRn5nm328V7tXnUPfLWNa+dTqZ2f5WrOuVYWqcy6OnJy9H
 e4SAql8KqKp0Al/aMmJGRy84XKtEK0EuW1285kxZbTqVDpjslgpwRyNXJgdJmSx/qskXv58brRo
 5nSvJ/CxfYG0kj9vZCaJ57nXQYAoewMlcweC4R2DNFG1hNhhIkiLlwigSIUwGEZ93W21
X-Google-Smtp-Source: AGHT+IEjCua3g+eRN9RRwvt7X7Zka/gtKuJq55wiER3xWTmLwkc0k3ohJOeW2OxLadzbBGJvvUVSBg==
X-Received: by 2002:a05:6000:643:b0:3a6:d95e:f37c with SMTP id
 ffacd0b85a97d-3afa162e3eamr2732776f8f.2.1751389674151; 
 Tue, 01 Jul 2025 10:07:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/43] target/arm/hvf: Pass @target_el argument to
 hvf_raise_exception()
Date: Tue,  1 Jul 2025 18:07:08 +0100
Message-ID: <20250701170720.4072660-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

In preparation of raising exceptions at EL2, add the 'target_el'
argument to hvf_raise_exception().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-12-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ebde4c6f183..7b6d291e79c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1088,13 +1088,13 @@ void hvf_kick_vcpu_thread(CPUState *cpu)
 }
 
 static void hvf_raise_exception(CPUState *cpu, uint32_t excp,
-                                uint32_t syndrome)
+                                uint32_t syndrome, int target_el)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
 
     cpu->exception_index = excp;
-    env->exception.target_el = 1;
+    env->exception.target_el = target_el;
     env->exception.syndrome = syndrome;
 
     arm_cpu_do_interrupt(cpu);
@@ -1454,7 +1454,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
                                     SYSREG_CRN(reg),
                                     SYSREG_CRM(reg),
                                     SYSREG_OP2(reg));
-    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
     return 1;
 }
 
@@ -1764,7 +1764,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
                                      SYSREG_CRN(reg),
                                      SYSREG_CRM(reg),
                                      SYSREG_OP2(reg));
-    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+    hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
     return 1;
 }
 
@@ -1967,7 +1967,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         if (!hvf_find_sw_breakpoint(cpu, env->pc)) {
             /* Re-inject into the guest */
             ret = 0;
-            hvf_raise_exception(cpu, EXCP_BKPT, syn_aa64_bkpt(0));
+            hvf_raise_exception(cpu, EXCP_BKPT, syn_aa64_bkpt(0), 1);
         }
         break;
     }
@@ -2078,7 +2078,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
         }
         break;
     case EC_AA64_SMC:
@@ -2093,7 +2093,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             }
         } else {
             trace_hvf_unknown_smc(env->xregs[0]);
-            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
+            hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
         }
         break;
     default:
-- 
2.43.0


