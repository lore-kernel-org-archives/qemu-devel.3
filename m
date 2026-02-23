Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D30EC110C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:09:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZKi-0002Rj-K6; Mon, 23 Feb 2026 12:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKe-0002LT-Ob
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:52 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZKc-0000FJ-69
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:02:52 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48374014a77so47451825e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866169; x=1772470969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lwouxz/o/dkwKMhTRSd+FjgJjYJhHe7TZXKPF0VtHa8=;
 b=dbiCcWdAGoU9hzeb1mbdj3vcRD4/gOIo0TCPJ7z3+ySyQpLpXVu3ByptpI/Ly6UbEs
 3FtvksYHeg9Yow+xnMDCQN+VVq94GF0spjteyyc3mPnyqQ6bAOC9KbcQctBzBT6gW5wE
 3VsVefRHY7kdrW1QNzNFWdiTMAsWx4zgLWyjS0jf/H+ODabp3mCTl2KPETXW4Lyy95yj
 ad/fLLptLxDuEAt3iT2VeufAh0tDZyKhlW/HXHmvRp+xNc8aG3ycZPaKaGePmQpaVCDF
 WxgbPNnihrPdb4B2I32ZzS/VsqEvNxYnF9km2bY4OreWVjy79Iy4gsK4Q2JpTeeLiN8z
 vYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866169; x=1772470969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lwouxz/o/dkwKMhTRSd+FjgJjYJhHe7TZXKPF0VtHa8=;
 b=f+xBBW4xk4IgFUtgdhzqsHQfLfnl+VfyyH95Ca2DxVSSF4NgZVMgNfW1G0gIcJnO7Y
 f8iJuvBWUKh90Glz7skAZNziwiH0vT0DWKaRZq7N8on6Xs5jhIIkZbLqxF73eXVowsdl
 NO6U1vtEqz2FGA2FU9/8W973NKKuOCAnd+LXXlZ8SdTjKXDUVkLWtYLQf8Nu5bvQ5XHQ
 Z/Acc+p4eluzlxM6t+4CM9DgeiKpLjVu04TkmHeL+AI18CBk3qQXbSF53PsvULZ35P/5
 wSjA3pHGJJrKZWw+yjFuHKPssF87X3HIxmMKWSR+iMyPma6Bf/C/X0ZoPyqwDdW4Dyh9
 hrYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5Fik6udwJoYiyKa0natsi1baBqDX7JidNYlA3Fp7vMCxuo/afmv6WykHKpGp22hKiR0l3ZDUtHw2T@nongnu.org
X-Gm-Message-State: AOJu0YzKYMXpcVXQyj3i9hEtKuKxoOcyusEnQLtrA4mhkOKY4dsh/eh6
 yIjgUmSKMWag9WXubF9R+Cz9JZIKtquuCdwUD1349V0JMNSCfZuFrzlohAHD89LjUF31pyZRT/c
 Cz1GU
X-Gm-Gg: AZuq6aIYQG1B6nTywnCIy7n4iTb6RsKcTXpP+nuxGrshsQ0g46xbpDfekhjhScAYprP
 S+SlMHLkDkW79FQPZ9fBXwYYGgItN7F0PE+4xotmTvi38FltAixl2WUT0tU2+i18MYMt3kfJ3bO
 JUJvSiTz+IU5ENDdDMnDJdQIsIyBinQytDVKO33OlNlcIYVN63NbboJ+PTJuNAzYw1BHhkZQ9kF
 Yj79QySWE5AWgoAZAUH5YdUDVNtvfamEvmn4XIkW4U87DkRamOWyv82iZ7IImsjs9ZQ/iNxPqqz
 sbuSoWQ2TSfqYFimzcCv4QJC+uLA/1hNE86nCAGsIUqGqyjRqsyn1DoS13OUKgc3VR5C9PVs2R7
 c1huUQGeXyzTwcJxYK46q76QBQkiuSEcFie1Bj+YKjY4xS56c0r1m03B0xVzNd+j7w+Ss1ghgpL
 Pv6wkbcKOKbT5Ok/vojMsL7/9qM4d4BzeFP1C/ngNTziy4rFnCHwyRpm1GwWVfF7uB4JzHKhcUL
 UlaaQyAFYh9z9iS67YA+FX62ld1AUjKWVGskaftrw==
X-Received: by 2002:a05:600c:1e1d:b0:480:6999:27ec with SMTP id
 5b1f17b1804b1-483a95bebcdmr171897625e9.13.1771866168578; 
 Mon, 23 Feb 2026 09:02:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:02:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 30/65] hw/intc/arm_gicv5: Implement IRS_PE_{CR0,SELR,STATUSR}
Date: Mon, 23 Feb 2026 17:01:37 +0000
Message-ID: <20260223170212.441276-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The IRS_PE_CR0, IRS_PE_SELR, IRS_PE_STATUSR registers allow software
to set and query per-CPU config.  Software writes the AFFID of a CPU
to IRS_PE_SELR, and can then read and write the 1ofN config for that
CPU to IRS_PE_CR0, and read the CPU's online status from
IRS_PE_STATUSR.

For QEMU, we do not implement 1-of-N interrupt routing, so IRS_PE_CR0
can be RAZ/WI.  Our CPUs are always online and selecting a new one
via SELR is instantaneous, so IRS_PE_STATUSR will return either
ONLINE | V | IDLE if a valid AFFID was written to SELR, or just IDLE
if an invalid AFFID was written.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 39 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  1 +
 include/hw/intc/arm_gicv5_common.h |  1 +
 3 files changed, 41 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index d0ba8fe669..0f32bdf357 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -930,6 +930,21 @@ static void spi_sample(GICv5SPIState *spi)
     }
 }
 
+static bool irs_pe_selr_valid(GICv5Common *cs, GICv5Domain domain)
+{
+    /*
+     * Return true if IRS_PE_SELR has a valid AFFID in it. We don't
+     * expect the guest to do this except perhaps once at startup,
+     * so do a simple linear scan through the cpu_iaffids array.
+     */
+    for (int i = 0; i < cs->num_cpu_iaffids; i++) {
+        if (cs->irs_pe_selr[domain] == cs->cpu_iaffids[i]) {
+            return true;
+        }
+    }
+    return false;
+}
+
 static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
                          uint64_t *data, MemTxAttrs attrs)
 {
@@ -1051,6 +1066,24 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         /* Sync is a no-op for QEMU: we are always IDLE */
         *data = R_IRS_SYNC_STATUSR_IDLE_MASK;
         return true;
+    case A_IRS_PE_SELR:
+        *data = cs->irs_pe_selr[domain];
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        *data = 0;
+        return true;
+    case A_IRS_PE_STATUSR:
+        /*
+         * Our CPUs are always online, so we're really just reporting
+         * whether the guest wrote a valid AFFID to IRS_PE_SELR
+         */
+        v = R_IRS_PE_STATUSR_IDLE_MASK;
+        if (irs_pe_selr_valid(cs, domain)) {
+            v |= R_IRS_PE_STATUSR_V_MASK | R_IRS_PE_STATUSR_ONLINE_MASK;
+        }
+        *data = v;
+        return true;
     }
 
     return false;
@@ -1139,6 +1172,12 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_SYNCR:
         /* Sync is a no-op for QEMU: ignore write */
         return true;
+    case A_IRS_PE_SELR:
+        cs->irs_pe_selr[domain] = data;
+        return true;
+    case A_IRS_PE_CR0:
+        /* We don't implement 1ofN, so this is RAZ/WI for us */
+        return true;
     }
     return false;
 }
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index b358691105..bcbe88cde7 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -68,6 +68,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
     memset(cs->irs_ist_cfgr, 0, sizeof(cs->irs_ist_cfgr));
     memset(cs->irs_cr0, 0, sizeof(cs->irs_cr0));
     memset(cs->irs_cr1, 0, sizeof(cs->irs_cr1));
+    memset(cs->irs_pe_selr, 0, sizeof(cs->irs_pe_selr));
 
     if (cs->spi) {
         GICv5Domain mp_domain;
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 00b1dc2b45..5254e68fbb 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -87,6 +87,7 @@ struct GICv5Common {
     uint32_t irs_spi_selr[NUM_GICV5_DOMAINS];
     uint32_t irs_cr0[NUM_GICV5_DOMAINS];
     uint32_t irs_cr1[NUM_GICV5_DOMAINS];
+    uint32_t irs_pe_selr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.
-- 
2.43.0


