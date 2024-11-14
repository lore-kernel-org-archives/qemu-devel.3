Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E12D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcIT-000562-Ix; Thu, 14 Nov 2024 11:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIL-00052V-MH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:11 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcIE-0002Gq-Gp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:02:06 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7240d93fffdso616485b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600114; x=1732204914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Yssv0jEMu3znLJwX6X9mSGXOOpGLG/4PsoO3zzU/j8=;
 b=XgsI8Y7WRvgNkYvNbvQCseP/ZqUaN/ZNKMN+yGY+OsZ/MzUt+7bDRWnntY5ueT3fSl
 czls36G4ttsu70Tj5JjKxcqJrEvYlN5GMcYuo0nsRzM9Y01ng5K5byZRHN5cxYgWg3rq
 rONvu/YuteAC+Owmxbfq8MPrX/mpvLWFX1el/39quU+fRrW+p3EjM2C+5W42RwbdvUmk
 8JcgwAi5OJ5pKZiVBuhMr3ZYnx7CrhyaIrCcIgU4W6MqzXHONDf29uJpqFqggJJNse5y
 gHo5y6DMlkdYNXT1s9ZZ2Fn4XvuyEDk1pujFKufhycvUuntZNiJZO1jR+h41fu6I3/91
 GoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600114; x=1732204914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Yssv0jEMu3znLJwX6X9mSGXOOpGLG/4PsoO3zzU/j8=;
 b=co25rNHQr1XaxeRXWBYd45Um+dOR64O/KXwyo49KbNYzfKoh42/gkzLm57su9ZXcPL
 H2njF7lSTfPJf3muY1cENcXtHoR2816TaCLINlejVEqm5HlavEibgU0fGxRVjoAed85v
 8+z4oB4rbODzhMvVty8FjUho2VpVTqhG7sdyUdzDIU8FB8oJXTJ+QPFWNVB2FRAyZjeE
 pn3HWwDB/teg7ITlRjLxqV3uPNxnwluhRmLx1i/OhWaCfWlpiPx8C3WoErIWupc6+2A2
 2vBdNAmuuMS6NKONMjTc/biOHCv4tVntejktEf3z+xMOkBmRd3AxCzawN7P78Qi7XPlK
 kppA==
X-Gm-Message-State: AOJu0YzpjUI/KqBc4okCBBNXIu0JABvOyUH1+5ZCVk97+ie7YAEWfEKi
 qNAW+SngYKGQy2uicIiMRvbgYmIVlX48qDSSOoPKvfRnYbhw0cmSxeH+c9rYhvJyDHzA1xouwE8
 b
X-Google-Smtp-Source: AGHT+IFLdAAVJWloFL406nCZNpvgcVG5gYnNaGTp0OhtyT1eS3AqjXuJsSo+9xeXXm45DxgMRFh9vQ==
X-Received: by 2002:a17:90b:51c4:b0:2e2:ffb0:89f6 with SMTP id
 98e67ed59e1d1-2e9f2c78416mr9734707a91.15.1731600113640; 
 Thu, 14 Nov 2024 08:01:53 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/54] accel/tcg: Return CPUTLBEntryFull not pointer in
 probe_access_full_mmu
Date: Thu, 14 Nov 2024 08:01:01 -0800
Message-ID: <20241114160131.48616-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Return a copy of the structure, not a pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h              |  2 +-
 accel/tcg/cputlb.c                   | 13 ++++++++-----
 target/arm/ptw.c                     | 10 +++++-----
 target/i386/tcg/sysemu/excp_helper.c |  8 ++++----
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 2e4c4cc4b4..df7d0b5ad0 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -393,7 +393,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
  */
 int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
-                          void **phost, CPUTLBEntryFull **pfull);
+                          void **phost, CPUTLBEntryFull *pfull);
 
 #endif /* !CONFIG_USER_ONLY */
 #endif /* CONFIG_TCG */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 585f4171cc..81135524eb 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1439,25 +1439,28 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
 
 int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
                           MMUAccessType access_type, int mmu_idx,
-                          void **phost, CPUTLBEntryFull **pfull)
+                          void **phost, CPUTLBEntryFull *pfull)
 {
     void *discard_phost;
-    CPUTLBEntryFull *discard_tlb;
+    CPUTLBEntryFull *full;
 
     /* privately handle users that don't need full results */
     phost = phost ? phost : &discard_phost;
-    pfull = pfull ? pfull : &discard_tlb;
 
     int flags = probe_access_internal(env_cpu(env), addr, size, access_type,
-                                      mmu_idx, true, phost, pfull, 0, false);
+                                      mmu_idx, true, phost, &full, 0, false);
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
         int dirtysize = size == 0 ? 1 : size;
-        notdirty_write(env_cpu(env), addr, dirtysize, *pfull, 0);
+        notdirty_write(env_cpu(env), addr, dirtysize, full, 0);
         flags &= ~TLB_NOTDIRTY;
     }
 
+    if (pfull) {
+        *pfull = *full;
+    }
+
     return flags;
 }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9849949508..3ae5f524de 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -592,7 +592,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         ptw->out_space = s2.f.attrs.space;
     } else {
 #ifdef CONFIG_TCG
-        CPUTLBEntryFull *full;
+        CPUTLBEntryFull full;
         int flags;
 
         env->tlb_fi = fi;
@@ -604,10 +604,10 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         if (unlikely(flags & TLB_INVALID_MASK)) {
             goto fail;
         }
-        ptw->out_phys = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
-        ptw->out_rw = full->prot & PAGE_WRITE;
-        pte_attrs = full->extra.arm.pte_attrs;
-        ptw->out_space = full->attrs.space;
+        ptw->out_phys = full.phys_addr | (addr & ~TARGET_PAGE_MASK);
+        ptw->out_rw = full.prot & PAGE_WRITE;
+        pte_attrs = full.extra.arm.pte_attrs;
+        ptw->out_space = full.attrs.space;
 #else
         g_assert_not_reached();
 #endif
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 02d3486421..168ff8e5f3 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -436,7 +436,7 @@ do_check_protect_pse36:
      * addresses) using the address with the A20 bit set.
      */
     if (in->ptw_idx == MMU_NESTED_IDX) {
-        CPUTLBEntryFull *full;
+        CPUTLBEntryFull full;
         int flags, nested_page_size;
 
         flags = probe_access_full_mmu(env, paddr, 0, access_type,
@@ -451,7 +451,7 @@ do_check_protect_pse36:
         }
 
         /* Merge stage1 & stage2 protection bits. */
-        prot &= full->prot;
+        prot &= full.prot;
 
         /* Re-verify resulting protection. */
         if ((prot & (1 << access_type)) == 0) {
@@ -459,8 +459,8 @@ do_check_protect_pse36:
         }
 
         /* Merge stage1 & stage2 addresses to final physical address. */
-        nested_page_size = 1 << full->lg_page_size;
-        paddr = (full->phys_addr & ~(nested_page_size - 1))
+        nested_page_size = 1 << full.lg_page_size;
+        paddr = (full.phys_addr & ~(nested_page_size - 1))
               | (paddr & (nested_page_size - 1));
 
         /*
-- 
2.43.0


