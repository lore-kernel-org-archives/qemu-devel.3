Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A87D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIR-00055D-Ex; Thu, 14 Nov 2024 11:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI3-0004z7-MT
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:51 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI0-0002EC-OV
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:50 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e91403950dso648078a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600107; x=1732204907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aH/YSb9/f+Pg6UolkLA4sQEI53j6GiG7lP5Aqm9cSsA=;
 b=RT+Kl5faUclTlmPrp/awEHRtcu/yrF983B7fB5+W83ioqoDb0x3OvNFbBwlv1NoWXX
 9ShF4/255jkvHPeDVYkEuKj0e9qUpMmhm9FDSuFeN5OEzTRI+QdDT+Ak5CxFbXw1/EEU
 d/qQz2yIFWDm+xW2z7b/F9LLLBkSROXsFFGdkmImo//GibhkqV7wz34Y1qWqnC5+ccM1
 OYgW/NLI7HXXZek/++/5vBdW1WoH3V5CoDIxX1YR85jLcJaEiwNaGoiTZMswaI0uGvpi
 EQ9yuNOoSU2b1ZURL8k/CyNAY5PwKxX+5Pn+TgzTWEIrHqNZ33tfVnrjBjLnchFTAlpn
 m4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600107; x=1732204907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aH/YSb9/f+Pg6UolkLA4sQEI53j6GiG7lP5Aqm9cSsA=;
 b=cdOaYb/L1VRnmID6WixNuSPUPfSu++Fz+JIQhxbqmVaxDjnMNm3q9ORfVamUj3YJNG
 fUxU/bmGHycyAtAftYJgLIkXfipN8GqGmAf4qFAKXKXc5AK9abChiK6yAp6q6T7HUYh3
 FpQDUtdjmPPZyeejtIB4eO2/Agyvm9JStnmgSwDiRiyLAxn0z0qgSxeNmEUE24Q1xPUs
 hJmsoptEgFHnHrQzC/xVIUjk5yAq8Er8ZMf6WNnPHxDNC+4IWisiSdMny7jNVBtQMBxC
 jm/L++eCRKr6E89/9OV0J9KxG96afLSC9ZAU8ynOHAhf4z1UbSSAtaw+lG+rLMyUKqQM
 1nJA==
X-Gm-Message-State: AOJu0YwCHPhRr/PO78ub7QJhsbKi7yAsT+mk/6JkKeblOYTNpAf2rgCg
 5eXmbUUMT73Xrx4+7KH7n7RZstJ4dtEL1S0wo/lfUbEKqFG5NrpMeLCEFn1dqp+0Ghy45+3Hukl
 H
X-Google-Smtp-Source: AGHT+IGO50T2+G3nh2qLqmoY9c/fFez6dpmtOhk4e1eGoW34d3YRYyRV916fAdqex1sAC1p3l4DIKA==
X-Received: by 2002:a17:90b:4c06:b0:2e2:cd11:c9b with SMTP id
 98e67ed59e1d1-2e9b16eb849mr30900909a91.3.1731600106566; 
 Thu, 14 Nov 2024 08:01:46 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/54] accel/tcg: Remove tlb_n_used_entries_inc
Date: Thu, 14 Nov 2024 08:00:55 -0800
Message-ID: <20241114160131.48616-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Expand the function into its only caller, using the
existing CPUTLBDesc local pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 8caa8c0f1d..3e24529f4f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -354,11 +354,6 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
     tlb_mmu_flush_locked(desc, fast);
 }
 
-static inline void tlb_n_used_entries_inc(CPUState *cpu, uintptr_t mmu_idx)
-{
-    cpu->neg.tlb.d[mmu_idx].n_used_entries++;
-}
-
 void tlb_init(CPUState *cpu)
 {
     int64_t now = get_clock_realtime();
@@ -1211,7 +1206,7 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
 
     node->full = *full;
     copy_tlb_helper_locked(te, &node->copy);
-    tlb_n_used_entries_inc(cpu, mmu_idx);
+    desc->n_used_entries++;
     qemu_spin_unlock(&tlb->c.lock);
 }
 
-- 
2.43.0


