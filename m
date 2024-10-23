Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B42ED2E00A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 03:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3S9a-0007Qs-Tw; Tue, 22 Oct 2024 23:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S98-00070j-MQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:56 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3S92-0008Mc-TJ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 23:34:54 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-717fd68fe33so3352584a34.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 20:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729654487; x=1730259287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DAeCA56AclqnO9IjlR+mT/BxP8eqo/+ZOrYIHvqWWg=;
 b=RWgrXg/4tJlzI3/s5lZXHWhcvU/UPs2c6eRvQEScRhHi6oz+J9nLV/WwH+sNMsn4H8
 VtzYpLhi+2+Jk+dyAmRQ+iM8TzCdjAID8AM+1qu4HFN/kr4CVFkn3l2pqYST0ad+Dfu7
 H/vkqijBVp2CKzYl2m7qaniFIIq/+FS2ut3w+HVw4UZnK7pFpqFkO32YxHMX1oyl9Baw
 SN2JyP7jolt00O9XnRwHJydMGgpw9GYUQbrBiuqoKpNnzrwxZGB/vRhey6bise0rC1XI
 S371wTr9e+tDX5BmalaidePisF07tqfikDY4Een3hfphhqWdYZPgS0tcqzr6sVmP4DMC
 5Qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729654487; x=1730259287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DAeCA56AclqnO9IjlR+mT/BxP8eqo/+ZOrYIHvqWWg=;
 b=VgdNdj65JCStNJH7x3ayFzUQuHBBwixk1R5pFLZTeQAdYj3hiVwIBXxS1CrTsHRoYg
 Idmw2LlOAuXF3mLM2yLzWonpP9CxXnOOvuLoF+IaGLJv7CRrItnRVrFShoE04pb4CBfq
 dQJngnr/VK0Ct7d7ujjSHNqXep/AafstvmKjai2joQwY5Xr1GUgkPgBGoNtAqRh2U9Er
 FGg4xOpKkWU8o1Tuhedbn3nSP9vXc7OGvwqMvbxzRpgy9DDaLEmGwk8/fybkvmPBxu8L
 H1vPwUu159OJKmp3nBAaUYcXvizu1G1ravudQlOehcQD88HxkC58kGro3FyDV9KGfUse
 4WKg==
X-Gm-Message-State: AOJu0YwJKIGApyazkuhcCQQ9DUxrC4YewthjCVdXRMmdcbtelMqjCE/m
 6jG7JDcQrWenW5h6oytGUEtJlASvka49K6GG1BGUx3DPVVp3Z92sXTTBHdqxmiY1k42/VGiYBQS
 h
X-Google-Smtp-Source: AGHT+IGOvXoJrTIJonRfWvfuMf4IiiJ4qBR4Tp9xvEEqXprPSp7aKVRU8aMgz4u9iHYpdBW7w/dwYw==
X-Received: by 2002:a05:6870:558f:b0:277:c28c:147e with SMTP id
 586e51a60fabf-28ccb8158fcmr1426814fac.21.1729654487311; 
 Tue, 22 Oct 2024 20:34:47 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec13d73b1sm5438338b3a.105.2024.10.22.20.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 20:34:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alexander Graf <graf@amazon.com>,
 qemu-stable@nongnu.org, Eduard Vlad <evlad@amazon.de>
Subject: [PULL 17/24] target/i386: Walk NPT in guest real mode
Date: Tue, 22 Oct 2024 20:34:25 -0700
Message-ID: <20241023033432.1353830-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023033432.1353830-1-richard.henderson@linaro.org>
References: <20241023033432.1353830-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

From: Alexander Graf <graf@amazon.com>

When translating virtual to physical address with a guest CPU that
supports nested paging (NPT), we need to perform every page table walk
access indirectly through the NPT, which we correctly do.

However, we treat real mode (no page table walk) special: In that case,
we currently just skip any walks and translate VA -> PA. With NPT
enabled, we also need to then perform NPT walk to do GVA -> GPA -> HPA
which we fail to do so far.

The net result of that is that TCG VMs with NPT enabled that execute
real mode code (like SeaBIOS) end up with GPA==HPA mappings which means
the guest accesses host code and data. This typically shows as failure
to boot guests.

This patch changes the page walk logic for NPT enabled guests so that we
always perform a GVA -> GPA translation and then skip any logic that
requires an actual PTE.

That way, all remaining logic to walk the NPT stays and we successfully
walk the NPT in real mode.

Cc: qemu-stable@nongnu.org
Fixes: fe441054bb3f0 ("target-i386: Add NPT support")
Signed-off-by: Alexander Graf <graf@amazon.com>
Reported-by: Eduard Vlad <evlad@amazon.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240921085712.28902-1-graf@amazon.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/sysemu/excp_helper.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8fb05b1f53..8cb0d80177 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -150,6 +150,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
     uint32_t pkr;
     int page_size;
     int error_code;
+    int prot;
 
  restart_all:
     rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
@@ -298,7 +299,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /* combine pde and pte nx, user and rw protections */
         ptep &= pte ^ PG_NX_MASK;
         page_size = 4096;
-    } else {
+    } else if (pg_mode) {
         /*
          * Page table level 2
          */
@@ -343,6 +344,15 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         ptep &= pte | PG_NX_MASK;
         page_size = 4096;
         rsvd_mask = 0;
+    } else {
+        /*
+         * No paging (real mode), let's tentatively resolve the address as 1:1
+         * here, but conditionally still perform an NPT walk on it later.
+         */
+        page_size = 0x40000000;
+        paddr = in->addr;
+        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        goto stage2;
     }
 
 do_check_protect:
@@ -358,7 +368,7 @@ do_check_protect_pse36:
         goto do_fault_protect;
     }
 
-    int prot = 0;
+    prot = 0;
     if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
         prot |= PAGE_READ;
         if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
@@ -420,6 +430,7 @@ do_check_protect_pse36:
 
     /* merge offset within page */
     paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
+ stage2:
 
     /*
      * Note that NPT is walked (for both paging structures and final guest
@@ -562,7 +573,7 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             addr = (uint32_t)addr;
         }
 
-        if (likely(env->cr[0] & CR0_PG_MASK)) {
+        if (likely(env->cr[0] & CR0_PG_MASK || use_stage2)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
             in.ptw_idx = use_stage2 ? MMU_NESTED_IDX : MMU_PHYS_IDX;
-- 
2.43.0


