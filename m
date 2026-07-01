Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A604EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG8-0005wI-Vh; Tue, 30 Jun 2026 23:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFz-0005kZ-IP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:05:00 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFv-0002r5-AJ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2c9ed0c7fc7so1216795ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875094; x=1783479894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9lGyyAHN8LnCXhy7QmMc4S+kFAgGybyfRaIJ4iRcl0=;
 b=zdjq0bt2ZmV3HQrP3VgH6slMX9pLKqlDZ6i+eCxsAINylWvMsPU3+wmdphmQfXez3U
 MB0hFzz7ZCwCnXccUOXv6r93Pi8W8rxsAgYnHxh4e0XP7iu82bobZF2UsWuDuvzFa37G
 bu0JQ6auHu0tO356xsho5POCwccIkPVwXASxggLZMZsnh4Qi/0/QOISK1ykSKs5oxlyf
 T1S9scoUR/UtXYoZqCkhNi0SU87a0HNcz1B5GP5k0c/nvNWLZey4mpw5QvSYvBv+lkos
 2rPSc6homa/bkXvnBjPf82Z+kF/DMDKlwcyVjU15oNT7BMv5kDhzjKVaQ2WD0YKAhnMl
 3leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875094; x=1783479894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m9lGyyAHN8LnCXhy7QmMc4S+kFAgGybyfRaIJ4iRcl0=;
 b=JVPcZ+b9G+lf+O8UuY/jlFxZ3GQerCqSbfSaY/0Wkg4OfYVI3lnmnYZsSXep67lsNH
 72GATiPKkkcT1wQ4T8B3VFNDZCvlvbLgg/+UHyLAipwWmJ2ElKb1BH6R6S2/pEPswj/w
 fyByfsvjRiG3N45PJwU4/JT7YFlAzxZbWm3ZcPWz5QSAEBTatWGT79eHoXU+TEjdeVa+
 LEuqD6xuAk049q5MygPzimbkNmWyuKxNF4TrARezU271wgmTG7ABDIN/3ihPE/8PUUZx
 /qS/EP0HPKTj0Krkh+lf1xml7n4SbF4vj1MfLjTHLiC1xKfvZb32qfM/2Ro3H4rEzMSf
 p7hA==
X-Gm-Message-State: AOJu0YzdwqAWI0yN6uWftrtQU9f/RFrBZdAX8gJAWitVtbKdYH471GaQ
 +xWiNwevjK/O9Vv4w3iDSDAgzFl9+7SlH/R2YTBX3OhEWuuXyEupprf1STQE3P6f1XKW5gOAHD4
 Aebu3
X-Gm-Gg: AfdE7clIVWYnYTyjZOcdwgiwCRHDi01kABvvOydDF28ybTCmetfID3ytjJpC/NtTaRe
 kGBc6R7HxpWn/3bAFxeKJnF14pKCq/8txl0RUiStaWh4vLFcRfD6o3aWij9nxbTgPnzLIccEL1f
 PC2uFD7nIDgat7b0lA3E55R8l8xiyUjp5vVLPNhcoZHGnUITQSFuRpYekruvZ5MnXNOQ1N2iiY3
 AF7fFjJem7a9Wma87CqbLvc86+23qVp85Al70D//d4ziTxzG8fv70agrvMHxSFidUHmBJBkDTeH
 b2kAi4uPAMmdcaOXNgMLflQOpq2udMPrn3qNgm+hQ/SybeBFkl75hXYP7jvjXiTBOePRqQTgesg
 6abO36Z+vs0HMOo46gcDa94wSFdgEHeK9i4gXemGkRmQL6iXfKI08PIQjRIAhV0kErOOymFftie
 Am1doah66sLrOCwRNvlzk8VqzCHsffFyqJ5W3AB7OeBK+M90eClYKnrAW/ryBF
X-Received: by 2002:a17:902:f712:b0:2c9:aae1:a61a with SMTP id
 d9443c01a7336-2ca5a552530mr31604635ad.14.1782875093810; 
 Tue, 30 Jun 2026 20:04:53 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 11/17] target/arm: Use bp argument in
 arm_debug_check_breakpoint
Date: Tue, 30 Jun 2026 20:04:37 -0700
Message-ID: <20260701030443.1382447-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Use the matched breakpoint instead of looping over all.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 8bcce4a1b0..fc63d35d98 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -396,15 +396,8 @@ bool arm_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
      * TODO: We would need to look up the page for PC and verify that
      * it is present and executable.
      */
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (env->cpu_breakpoint[n] &&
-            env->cpu_breakpoint[n]->pc != pc &&
-            bp_wp_matches(cpu, env->cp15.dbgbcr[n], arm_current_el(env))) {
-            return true;
-        }
-    }
-    return false;
+    n = bp->flags >> BP_CPU_ID_SHIFT;
+    return bp_wp_matches(cpu, env->cp15.dbgbcr[n], arm_current_el(env));
 }
 
 bool arm_debug_check_watchpoint(CPUState *cs, const CPUWatchpoint *wp)
-- 
2.43.0


