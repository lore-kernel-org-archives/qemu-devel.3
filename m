Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B39C36011
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 17:56:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyDvd-0007Jp-QU; Fri, 28 Mar 2025 13:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvc-0007JN-4i
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:36 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDva-0003Kb-CP
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:35 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3fcfc85f1f5so723171b6e.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 10:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743184533; x=1743789333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gcyk73YP4oKFYII3KIDsxDGo+q3lvpuGonD6HbKGNuc=;
 b=btAlVbzm531jQ4LiGvCSDkEiaFpDUNHiZ1+Is6ldwV/QVTFzFvLwRo6a+b8JAfzBfj
 oTMNpM9wIYYPWfIQxUS1eyzx0TfEg5wEOZSCYrstTz/MQXgEa8kBg2MGxunO9LnkQJUC
 kSr3LNgTZ7W3W/wJtnLWXgpFanIGUiJaKFmM2Dma+JIzfCUcSPnBFlYaXWpzVs3wusiV
 L0PqumYZ2XQU132rcRmCxLbrkDV7b7cTmGDrgMHGf4grcVI5R9oi3aq1aDMmUnKePdOk
 hMyKfj8/zteLb/gnpcosFjMo/QhL92Iv+EaMchIGYr5krDzne/y+fO4Eu2tJDW6fi/8z
 nj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743184533; x=1743789333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gcyk73YP4oKFYII3KIDsxDGo+q3lvpuGonD6HbKGNuc=;
 b=JScXec1iyt5ObVKr17CL8OFsU/5WqSiZW5QnBUN3hwXg/0niFWhFRPyrvQA6NTC//S
 LhzznimGHlRBwMwM3/Co4aRu0wgv4V9YAxvBbXI85UN1tA9PaHHzCI4Xx0JSLCS3+otg
 wtUH27OEBFcNWhWbrb6cksTSZvDM7Ie3+X2DsiYF7Ckdg4rELqACwFRMGYxAqkVHtQts
 M9GCOKJl9T8lF8wD8ltQRN+Bf88hVnea5JCreYqlxDKb9u2ojyuff3KcCx6dx1goQOIT
 OpjSvMJeffUFeG/3dwJWZLGlhyN1gzubvaL7xnnbrCKk9QI25JQtFLKu2TUMgtj0XiqO
 OH/w==
X-Gm-Message-State: AOJu0YwC0R6AqvLjd4FiaVOQi/ICkaC+iSRZvix7QqploBUs4BX+ZEst
 e+3864PM02nxw7lU2av5+OjJRoAakve5gLVgQxNBYa+5wOuCYjUO6X2aukA5ZCLcEqBasVywv/3
 Z
X-Gm-Gg: ASbGncuhbnHwyky+EpgqjLsU5iWRJNyRvtxyLUVstYOetw2m5wyPDf93oIeVGFd+0WL
 P1ULpzjqCbPCuuuMe6KSzVSCqU+NDzWeMDRmb1ypwdOW+TqSbT3ZZ/FP+8+D8tdOW3637SbUjeu
 aqopsEeZJa1vvIWzYtufBGRKgj6ohzk3jADEbxYAQ6NHtcZ4EukLo5RCAchK9+WY57xh7n8ymEU
 TQSc5BV4niEST04/72FGinJU6DjRaZO74oHRKsubBkBz5ECEEF+7dtoWTWGk1KWJiJ4U4ns3r6Y
 INlK6cW4qtXLxlWDIJcAcAU99YQP8i8KciNrjKFriKDz4JJOgxiMTN3C1+9dp5YqJCMPBj9lkkO
 TpJ2oNPoNT2o=
X-Google-Smtp-Source: AGHT+IHbtlYHrfuJo1HynYWlEwqVxcyquZY3jF1MeBugHxN+3u9k86f4n4EecqBT8SJgiPSuTBwOog==
X-Received: by 2002:a05:6808:398d:b0:3fe:aeaf:316d with SMTP id
 5614622812f47-3ff0f534c6dmr189121b6e.20.1743184532885; 
 Fri, 28 Mar 2025 10:55:32 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff0529511esm410338b6e.46.2025.03.28.10.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:55:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
Subject: [PATCH 3/3] target/mips: Simplify and fix update_pagemask
Date: Fri, 28 Mar 2025 12:55:26 -0500
Message-ID: <20250328175526.368121-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328175526.368121-1-richard.henderson@linaro.org>
References: <20250328175526.368121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

When update_pagemask was split from helper_mtc0_pagemask,
we failed to actually write to the new parameter but continue
to write to env->CP0_PageMask.  Thus the use within
page_table_walk_refill modifies cpu state and not the local
variable as expected.

Simplify by renaming to compute_pagemask and returning the
value directly.  No need for either env or pointer return.

Fixes: 074cfcb4dae ("target/mips: Implement hardware page table walker for MIPS32")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/tcg/tcg-internal.h      |  2 +-
 target/mips/tcg/system/cp0_helper.c | 10 +++++-----
 target/mips/tcg/system/tlb_helper.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/tcg-internal.h b/target/mips/tcg/tcg-internal.h
index 74fc1309a7..950e6afc3f 100644
--- a/target/mips/tcg/tcg-internal.h
+++ b/target/mips/tcg/tcg-internal.h
@@ -47,7 +47,7 @@ bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
 
 void mmu_init(CPUMIPSState *env, const mips_def_t *def);
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask);
+uint32_t compute_pagemask(uint32_t val);
 
 void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra);
 uint32_t cpu_mips_get_random(CPUMIPSState *env);
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 5db8166d45..78e422b0ca 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -864,24 +864,24 @@ void helper_mtc0_memorymapid(CPUMIPSState *env, target_ulong arg1)
     }
 }
 
-void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
+uint32_t compute_pagemask(uint32_t val)
 {
     /* Don't care MASKX as we don't support 1KB page */
-    uint32_t mask = extract32((uint32_t)arg1, CP0PM_MASK, 16);
+    uint32_t mask = extract32(val, CP0PM_MASK, 16);
     int maskbits = cto32(mask);
 
     /* Ensure no more set bit after first zero, and maskbits even. */
     if ((mask >> maskbits) == 0 && maskbits % 2 == 0) {
-        env->CP0_PageMask = mask << CP0PM_MASK;
+        return mask << CP0PM_MASK;
     } else {
         /* When invalid, set to default target page size. */
-        env->CP0_PageMask = 0;
+        return 0;
     }
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
 {
-    update_pagemask(env, arg1, &env->CP0_PageMask);
+    env->CP0_PageMask = compute_pagemask(arg1);
 }
 
 void helper_mtc0_pagegrain(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 123639fa18..df80301a41 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -876,7 +876,7 @@ refill:
         }
     }
     pw_pagemask = m >> TARGET_PAGE_BITS;
-    update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
+    pw_pagemask = compute_pagemask(pw_pagemask << CP0PM_MASK);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
         target_ulong tmp_entryhi = env->CP0_EntryHi;
-- 
2.43.0


