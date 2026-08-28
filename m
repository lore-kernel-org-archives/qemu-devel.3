Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42B6C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x052G-0002pN-My; Fri, 28 Aug 2026 18:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x052F-0002oF-BX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x0528-0002JY-LO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:26:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso16885415ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787956007; x=1788560807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2MZbjMDE841td0JwucZyy0AxkAYMDGPNezkz1NHmtAY=;
 b=unaHY14J30ejDmKJINX6w5PZlnDCbo/04uFtFZqPjJzINfMiyyWKGUvP6yktuEiZ9W
 ox+j1nSz3/vQwDWcjLyN5zFQO5GXkH9yWz4iYkD48jtRvEnrlf5+RwlJYBrDemHJJyrs
 rtktJNVgmFjVjx1sJ2A8zBX7qI1x+meOnZ26ukQRQMJzDzIbwzYX7ORLkOePUlhRlgxR
 5Pq1iGqRNI1rTCto5xh7x41tIOj40pT1l0lhAqDs/KxX/CiFGJf3XTi4vBq47g8RRnV6
 UqpKfVeUrLvj9HXd+dtubNYilaDxwNlV7LhFK9jLdDe3EjyEwg+VQoY/LglsPX/PaBe1
 q/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787956007; x=1788560807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2MZbjMDE841td0JwucZyy0AxkAYMDGPNezkz1NHmtAY=;
 b=VJ3Cw6uZ7rFA+oYMIA2B0shPu0bc3CJ3b2Dfz27cl4wKCKY01nidz5CceX/2x47ORy
 WcXUVTNS3IzasO0hG8cx5wLZPQK4Vz3njNIhBuJKQTDQ8vZ5eK+93UD/F4/iYO3k3lgB
 Q/P0ocrFkdUQlsZaJhjg7SMjtDR24K7VDb+WmWPLpK73oT6hXUEAOrmEaMRB5d4eaUSd
 neQJGXv6vmshsdN+nfZNh0fq5b6cwj/+NQZ+MIPucZeJb1Vsi2kTgktjaeRNcQ/xLFGK
 u9TTsLlhIALrdzKyJsU0AZ/acx8vOgw7Trrc+WRTFq42cz/SnCfR050/YX+xbaDJIKlv
 SSuQ==
X-Gm-Message-State: AFuF++ml7uXXshIIBKB23oMhiLFERvMJEB/79EH0QV/4+rX36sVzyWYZ
 nnKnvZVSQa8O4PFJECp3FlbvSZGf4uwqg6bqmyfAmmSZMOK/jyl2seKLvZUrmFgJ82cgIZtQgQN
 oED1O2Kk=
X-Gm-Gg: AYBFou2CVcQ6jKSnHkfn7LPyIF/1r0NQdmDKMB8EbO8Nfo49S9tXORXONfXd98YsU6Q
 3EM/apqhzrNHvy31hhS9obDT5cgRGJL7EoCVF96aBnq+4Sps0AwyyO2m5u8H8tfVrAXl1zDcmSX
 aIYzEIF1PaE8Y0UvJlHvrjHuiK4WFjyFH0cyBhs2SVXFWorCaiSM5TdtQ0ltnBZEQGQ5dSqL0aF
 15N79Vw8VadNs07C2/wxjgf++wQLW6RMzYwx9aWiLM/pAODSjKRXnzTq/90eHjAk7V2LGOGyx4t
 flIVyVPeUF0b1SPSCB5eUBJYOMDudREXb7HpS+BczQa98Mr47q9go4M/NOMw+bw4UD7M39CmwSD
 kR0qDx7Z+7JyNnOLbeLe5Jbpm06L1xnkbMSxMRcaCS9Lbtyfy5F54FGvf1R5mfIYOOnzhOJC8x7
 Y7iM+KSYKJYL5ypLSdXfjOPPoroVxUhBC8l3O8gcEXD+aMjgR8aIjmH/cb/h2K3YT9yku6Z1JXH
 2vHVZ5bpsSTdaiOWRZn
X-Received: by 2002:a17:903:144f:b0:2d8:d4cd:dc8e with SMTP id
 d9443c01a7336-2d8d4cddf75mr43132365ad.17.1787956007247; 
 Fri, 28 Aug 2026 15:26:47 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759640270sm9178355ad.34.2026.08.28.15.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:26:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 08/13] target/arm: Clear PSTATE.UINJ when taking exceptions
Date: Fri, 28 Aug 2026 15:26:34 -0700
Message-ID: <20260828222639.1432046-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828222639.1432046-1-richard.henderson@linaro.org>
References: <20260828222639.1432046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Clear UINJ when taking an exception.
Clear UINJ when exception return is invalid.

In both cases, perform the clear without feature check,
since the bit is otherwise RES0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h            | 1 +
 target/arm/helper.c         | 9 +++++++++
 target/arm/tcg/helper-a64.c | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e258fa005e..b7ee215257f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1579,6 +1579,7 @@ void pmu_init(ARMCPU *cpu);
 #define PSTATE_Z (1 << 30)
 #define PSTATE_N (1ULL << 31)
 #define PSTATE_EXLOCK (1ULL << 34)
+#define PSTATE_UINJ (1ULL << 36)
 #define PSTATE_NZCV (PSTATE_N | PSTATE_Z | PSTATE_C | PSTATE_V)
 #define PSTATE_DAIF (PSTATE_D | PSTATE_A | PSTATE_I | PSTATE_F)
 #define CACHED_PSTATE_BITS (PSTATE_NZCV | PSTATE_DAIF | PSTATE_BTYPE)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4f30a94ecd3..ed6b4d985e1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9583,6 +9583,15 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
         env->condexec_bits = 0;
     }
+
+    /*
+     * R_XKSNJ: If FEAT_UINJ, PSTATE.UINJ is set to 0 *and* the resulting
+     * value stored in SPSR_ELx is 0.  The new PSTATE is automatically
+     * handled by construction of a new value from 0; clear it from the
+     * old state and as UINJ is RES0 otherwise, skip the feature check.
+     */
+    old_mode &= ~PSTATE_UINJ;
+
     env->banked_spsr[aarch64_banked_spsr_index(new_el)] = old_mode;
 
     qemu_log_mask(CPU_LOG_INT, "...with SPSR 0x%" PRIx64 "\n", old_mode);
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9d805231a08..f76d89990c3 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -764,10 +764,12 @@ illegal_return:
      * mandated behaviour:
      * restore NZCV and DAIF from SPSR_ELx
      * set PSTATE.IL
+     * reset PSTATE.UINJ
      * restore PC from ELR_ELx
      * no change to exception level, execution state or stack pointer
      */
     env->pstate |= PSTATE_IL;
+    env->pstate &= ~PSTATE_UINJ;
     env->pc = new_pc;
     spsr &= PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT;
     spsr |= pstate_read(env) & ~(PSTATE_NZCV | PSTATE_DAIF | PSTATE_ALLINT);
-- 
2.53.0


