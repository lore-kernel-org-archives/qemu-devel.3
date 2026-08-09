Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B40C5AD2C
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQD-0000KT-R3; Sat, 08 Aug 2026 21:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQC-0000JV-Qp
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:52 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQB-0002KM-0o
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:52 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38f620399a0so652421a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239230; x=1786844030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xMgsCAzpsxr99VprhfKZkcv1OibNXXEBZ1Rt/1CfLY0=;
 b=Pj89OhqxmREy0XuKX0uWHoGhbr/IJ5SX8VWBKnE7aXcxymn+21Zofhgn+H11S4rvoI
 HQWUE7O9D87pT40ILoVUrQinI/6ZoAzl9JmtBW1AoSoOavinuCDH71rgNYQiFXBcCg8W
 Q7tmuiWuPyhqNbcbrSdPxmOYl7Z+5cYD7/0WRHgdkUyZhblWoTJQj+EeECXo3fb1sfpj
 7qTxN+d9nRcpZBlIS8feC6sMOYpKWsm0lr0f6Fp5E8frH5Yu1nj5Aq8q+s7zE7c626o0
 JHjKjYTeM7C+lFU0l38qIXczzqwSuFdHZg+7oQ1Ao+ophA5UvSc9WtB3ErM+bFLgxifH
 5ISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239230; x=1786844030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xMgsCAzpsxr99VprhfKZkcv1OibNXXEBZ1Rt/1CfLY0=;
 b=YeXrk1MP3k620/tjvEWZK7AGVFEYxt41BvlbM52lhmKa+PxGQQby6Ae9GsR6Skt9s9
 PlSqZVUHPGnNFv459LNv7qrNuuA3fF4WNmdwKUR3WtvGsTrG3//fNfVVrPb3TZ0Q10m1
 vwxoeJykeXQxutelmHQzaz8AQ98Qm9YGueOJPKGou1jBl7s6IeVyvoqqUW5Q9fDEQ5+H
 JcyKSwfBktzaKHKpqABbnClT+ZxhNuAZBobL6Ezq1nN/7SuV0cvHbZ2HI6cJbDqbDcQa
 ai+CfkTrV5zzHiGlyZze/wmj6K5HX98fOmjMQEYQvtm89f0NiuWpHhfEZGbMf7tzLjTa
 0nHw==
X-Gm-Message-State: AOJu0YyylLP8AysBZuhnlRpMxavBLP0NiKGflvHoqlqk32Vb25dPHg8V
 vS3KGya/aeeGcI1l1YE8VTnWYpWJBoLPqhot8jqsqaADkMAP/ALONcU1W3lCAuaQiHewYiGe0Ks
 pTMKR
X-Gm-Gg: AR+sD11EbdoAZA9iqu9/7gBpY0rczIKD3Za6xyAxczVk9ObQ08JdH/ojpN0s7hhW4xn
 xY+AtQtF+0ukwX7D9JReZZi7lnxLDRFce9t6TpDV5oJsUbCPiwkYB0m5jB//5Uw6hm0auif8Ol8
 E7STDEY6c6la6Ge0a89JbKDnn+QbQXYIy83H0qThc3GgPfdm9niEHTxC1Cl4J7XRa/AIvBJP1W2
 vNn0rlSLJY3CVDvXbknA2/xGhc5OpiNz9w5I/7BO1zi2WFFawver16tCC473enoLqEuWqvfOeWf
 fvxpi0ReymNraA6WqQTsylrPS8QHANj9Z3JmGItWErwwzOHaSnM7GEfs7RD5m5wjkTj+7nu69FI
 fr3Ns4MlxIPG3pnGGsfZQwcXwpyqyM68uSoH80wURZiwDFjrjkQzgIhLzEQp9LVi5DscfZh5pKw
 pXonlhmrif9+SpMUJhFTWHLKPOuHHpeq//Pk75tmZ2b7wH+b2ixih7+mlD/Y4E+R1nvZ9bw8y7P
 WDkf5mRVpOOpQG72B8Q98onM/hb44g=
X-Received: by 2002:a17:90b:580b:b0:38e:9e9d:9209 with SMTP id
 98e67ed59e1d1-3903c5c51cdmr34482563a91.17.1786239229585; 
 Sat, 08 Aug 2026 18:33:49 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 4/9] target/sh4: Enable disassembly via capstone
Date: Sat,  8 Aug 2026 18:33:38 -0700
Message-ID: <20260809013343.664966-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h |  7 +++++++
 target/sh4/cpu.c         | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index 5c78824da2..788f90771a 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -71,4 +71,11 @@
 #define CS_MODE_RISCV_VENTANA    0
 #endif
 
+#if CS_API_MAJOR < 5
+#define CS_ARCH_SH              -1
+#define CS_MODE_SHFPU            0
+#define CS_MODE_SH4              0
+#define CS_MODE_SH4A             0
+#endif
+
 #endif /* QEMU_CAPSTONE_H */
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 763424695c..7593062993 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -28,6 +28,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
+#include "disas/capstone.h"
 
 static void superh_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -167,10 +168,23 @@ static void superh_cpu_reset_hold(Object *obj, ResetType type)
 static void superh_cpu_disas_set_info(const CPUState *cpu,
                                       disassemble_info *info)
 {
+    const CPUSH4State *env = cpu_env((CPUState *)cpu);
+
     info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
                                      : BFD_ENDIAN_LITTLE;
     info->mach = bfd_mach_sh4;
     info->print_insn = print_insn_sh;
+
+    info->cap_arch = CS_ARCH_SH;
+    info->cap_insn_unit = 2;
+    info->cap_insn_split = 2;
+    /*
+     * Possible capstone bug: the isa levels are not additive:
+     * least significant bit wins, so SH4 overrides SH4A.
+     * Work around by settiing one or the other but not both.
+     */
+    info->cap_mode = CS_MODE_SHFPU
+        | (env->features & SH_FEATURE_SH4A ? CS_MODE_SH4A : CS_MODE_SH4);
 }
 
 static ObjectClass *superh_cpu_class_by_name(const char *cpu_model)
-- 
2.43.0


