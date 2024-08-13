Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE02BC52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdodF-0008G7-4N; Tue, 13 Aug 2024 06:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdodB-0007mq-DL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:58 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdod8-0005qL-CB
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:56 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5a156557029so6027215a12.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723544392; x=1724149192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQjGZK3beew7IwbGeEw9H3Yr18ElnIBqbghrqrG+68k=;
 b=NOBymis3qSyv5eBA4i1pixFJfjxpm/fV6/eCzuJccvOFECsmPZUQ6Jt9Fl2QVANMap
 lat76to18POYabB4lGlm8RjVCS6rIEeSSZDIlr3QcO6TZJkdE7iFK2oK+96mkO7O30jP
 kUbwriwEN2iIH6HkRlUHci6T4vFhGZW5gpTVszhcEVOkQ06XtPWiVa3sGvuCnmsuYv9D
 ACP2TL1ZLtP9vl/xwfGtb4Maw89u1DtJvYAkvQu2E/Hw+HxiyH/Raa0olMsqtvbNk7f5
 uHquqCLc7pIiMNuxkfB4YYN0ryOeORGGNe0eUDlHwsWCT66vA37p0L8tdrWWMcLqfI/7
 XKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544392; x=1724149192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FQjGZK3beew7IwbGeEw9H3Yr18ElnIBqbghrqrG+68k=;
 b=aHhes0SavJlWUBRJn4VmfRq81j6rX15vQ4zJ57tQZB5Wab/vWSedVywwTucTNgEhfA
 aYxAFp7UMGogo9Psk9ObAljIp8RzKRmxLqcFyHoPTMOR/eZlOW/x2TEq1QAVbxQujRp5
 ZG5SWMYkYOQwx/Ncn8GeaKUJ8AMowFVq5/RDqAWx25ZNuKV1pAeS6gODQCH8F159z9IV
 oFyRxJ4nzZwz19FUG6O1VMEozY0aY3C+RBKNhHk5/UZFNeJjsP6Woj3zwXr56HbFZ5+V
 QmCd6YRk5MLic+mPgPU5XNlxd2CcGVVPrYnnxxrpZyhQltH+GPLmhxLnmDoggad0Z0Uz
 WhjQ==
X-Gm-Message-State: AOJu0YxM0D7CBEd4JRZvCFX+FRk7E8VzPax6H+EgIVsZMs8ZkBbrQiOB
 zmDw9Yjlka011aHQxEba1lDegYRqQit46DEOiDKZNlR3d7O/zNqKGsax+2mjon5/cPKpzBvE9mO
 ZEaw=
X-Google-Smtp-Source: AGHT+IHJWHUD2GY612FzWR781LwV5aDhobIPV8/dkIBHA25bpJ5lxAMKnmITDXDMyo+Jp62bXZaG+A==
X-Received: by 2002:a05:6402:270b:b0:5a2:8802:8e10 with SMTP id
 4fb4d7f45d1cf-5bd44c0feb3mr2279145a12.8.1723544392161; 
 Tue, 13 Aug 2024 03:19:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd191a20fcsm3046548a12.36.2024.08.13.03.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 03:19:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
Subject: [PATCH-for-9.1 v2 2/2] target/mips: Use correct MMU index in get_pte()
Date: Tue, 13 Aug 2024 12:18:56 +0200
Message-ID: <20240813101856.49469-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813101856.49469-1-philmd@linaro.org>
References: <20240813101856.49469-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When refactoring page_table_walk_refill() in commit 4e999bf419
we missed the indirect call to cpu_mmu_index() in get_pte():

  page_table_walk_refill()
  -> get_pte()
     -> cpu_ld[lq]_code()
        -> cpu_mmu_index()

Since we don't mask anymore the modes in hflags, cpu_mmu_index()
can return UM or SM, while we only expect KM or ERL.

Fix by propagating ptw_mmu_idx to get_pte(), and use the
cpu_ld/st_code_mmu() API with the correct MemOpIdx.

Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index a8caf3ade8..4e64c226a5 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -593,16 +593,21 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
  */
 
 static bool get_pte(CPUMIPSState *env, uint64_t vaddr, unsigned entry_bytes,
-        uint64_t *pte)
+                    uint64_t *pte, unsigned ptw_mmu_idx)
 {
+    MemOpIdx oi;
+
     if ((vaddr & (entry_bytes - 1)) != 0) {
         return false;
     }
+
+    oi = make_memop_idx(size_memop(entry_bytes) | MO_TE, ptw_mmu_idx);
     if (entry_bytes == 8) {
-        *pte = cpu_ldq_code(env, vaddr);
+        *pte = cpu_ldq_code_mmu(env, vaddr, oi, 0);
     } else {
-        *pte = cpu_ldl_code(env, vaddr);
+        *pte = cpu_ldl_code_mmu(env, vaddr, oi, 0);
     }
+
     return true;
 }
 
@@ -643,7 +648,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         /* wrong base address */
         return 0;
     }
-    if (!get_pte(env, *vaddr, direntry_size, &entry)) {
+    if (!get_pte(env, *vaddr, direntry_size, &entry, ptw_mmu_idx)) {
         return 0;
     }
 
@@ -669,7 +674,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
                                      ptw_mmu_idx) != TLBRET_MATCH) {
                 return 0;
             }
-            if (!get_pte(env, vaddr2, leafentry_size, &entry)) {
+            if (!get_pte(env, vaddr2, leafentry_size, &entry, ptw_mmu_idx)) {
                 return 0;
             }
             entry = get_tlb_entry_layout(env, entry, leafentry_size, pf_ptew);
@@ -827,7 +832,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+    if (!get_pte(env, vaddr, leafentry_size, &dir_entry, ptw_mmu_idx)) {
         return false;
     }
     dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, pf_ptew);
@@ -839,7 +844,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leafentry_size, &dir_entry)) {
+    if (!get_pte(env, vaddr, leafentry_size, &dir_entry, ptw_mmu_idx)) {
         return false;
     }
     dir_entry = get_tlb_entry_layout(env, dir_entry, leafentry_size, pf_ptew);
-- 
2.45.2


