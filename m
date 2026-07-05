Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98F9C44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEdu-0008Oh-A7; Sun, 05 Jul 2026 00:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcV-0005Hn-RP
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcA-0004UC-Rk
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ca64c3ce5fso19728565ad.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226277; x=1783831077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnP83ngqbzOCaEyHZuWHVT2DEUxtaEIT/kVQUZ1VwBM=;
 b=dClL0i5RWjVq+7cOca0wARGvOA9Kk5oFOvfmeOYw5cM1R6WGROgthgQUZbFwDnNc6L
 oP8SxrSlQINySR+/d87LXJ+jJR5j7QdnpqbH7W62tP27pC0urNVoJKhzWcgpgfuiIpPH
 /vPMtSybsdASdCNBa5EINsYbalMwR+o++lhYeIIWSFC0zSQy5gLImTxDQfD6YpPkVCmU
 8lY34bctbZIInmpMl3Y87FtvBAv5kFEfvZO1Z1lUUoohPTkn1sysPaYyIRGXWd5KZFq7
 vjVY+lQLDAi7nPMs7GFl6xKKV1EplhFCyTrjIDXJRR1fTxXb8by6IwznQ+h2qLmm2NuT
 cYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226277; x=1783831077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GnP83ngqbzOCaEyHZuWHVT2DEUxtaEIT/kVQUZ1VwBM=;
 b=ce+FzzpXhP7bV+KAsJ3Mf4qB/6+QocmD/4we7L4IC7xvMjQpLIVac8aB83/5xCA5MK
 5E+AxJRuOkjfxg3J93UlxSkkgZEu3SPA79NtQckVnyiN3EzSr/gx/SSie0deniOyEHlh
 wD4RGnJvhdhPG6cznkHSyFiYGjAI4Ze0ZwKeG+NwSPty/GGXgyoFJUV0XGq8p8HiyGoF
 ZkP4f4kvtb2Q6I5d33W5VLjyHRZF2+VKCW8k6J3TCWkVWSOfark3yooAZ2KX5WioInlh
 bxt6eBSLcuSI0epG4S7CxvLN3eTEGqgOek1PiqjpvmqsZg7ttYi02Wbbxa1hT4wmI9W7
 tktA==
X-Gm-Message-State: AOJu0YyeVZvIEoCK4j8ypGQ9c9qdl6ZWACoeqWEptAAv8bGDswFj8G4D
 /aVot/E1S4GD+OfPuOHC+7FTof86c5JWVwP1IvGOCf37BdxKYK32k3kfbGPSg2xIrbtrD07Rhg8
 yIWzy
X-Gm-Gg: AfdE7clzz7zPBNehkpkdDRedd4Fd55SIQ2Kk9mXXviieQIRYYsg9kMAfCqpdWUXaU4L
 ubi6FYLy0JomcrSxD3F+CiUas/PI+CGhpimgt+o+1ot+HB3oXWq2NpN39/m0rXzD88Dvk+ZD18k
 CuzT4J1trESfiKT47IpwyOUQYQB8WWBz9ZM9cQTeYsosKcgaBtKbydoMcsVYiwOhRJS2YbqNuvT
 deIeUVcTo8KDJ0blAq/BroP/SPZJNFmgmEl1IOrDoa24KdO7ZS57b6kSc0ro3aFg2oifZZQyhS9
 1DB5Af7Lugxz8sQNjxnFx2FSB+l56ZSKJdq9TjJt2u5wBVPoGIVTpY5KmP/NThHARGWRidFsSiN
 /XPwMoadO16IHcrDOBYoVtdXrgF2ii3MyKKLOxe2jJxKjXdFtgvFSTyOAiUmPj9+urExW+NGbcd
 X9NwNKEFsc088v6VCNWUJisw6LzuDGMnjKmSPDyWbpvGDHSDc=
X-Received: by 2002:a17:903:b8f:b0:2c9:97a8:8c1b with SMTP id
 d9443c01a7336-2cbb9f086e7mr52110315ad.46.1783226277370; 
 Sat, 04 Jul 2026 21:37:57 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 36/46] target/ppc: Simplify ppc_cpu_debug_check_breakpoint
Date: Sat,  4 Jul 2026 21:37:15 -0700
Message-ID: <20260705043725.1373137-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

We don't need to check PPC_ISA207S, because that's already
done starting with register_book3s_207_dbg_sprs().
Replace target_ulong with uint64_t, as we're under TARGET_PPC64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/tcg-excp_helper.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 56ca66e7b5..99ffe4a820 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -330,23 +330,19 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
+    uint64_t priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
 
-    if (env->insns_flags2 & PPC2_ISA207S) {
-        target_ulong priv;
-
-        priv = env->spr[SPR_CIABR] & PPC_BITMASK(62, 63);
-        switch (priv) {
-        case 0x1: /* problem */
-            return env->msr & ((target_ulong)1 << MSR_PR);
-        case 0x2: /* supervisor */
-            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
-                    !(env->msr & ((target_ulong)1 << MSR_HV)));
-        case 0x3: /* hypervisor */
-            return (!(env->msr & ((target_ulong)1 << MSR_PR)) &&
-                     (env->msr & ((target_ulong)1 << MSR_HV)));
-        default:
-            g_assert_not_reached();
-        }
+    switch (priv) {
+    case 0x1: /* problem */
+        return env->msr & (1ull << MSR_PR);
+    case 0x2: /* supervisor */
+        return (!(env->msr & (1ull << MSR_PR)) &&
+                !(env->msr & (1ull << MSR_HV)));
+    case 0x3: /* hypervisor */
+        return (!(env->msr & (1ull << MSR_PR)) &&
+                 (env->msr & (1ull << MSR_HV)));
+    default:
+        g_assert_not_reached();
     }
 #endif
 
-- 
2.43.0


