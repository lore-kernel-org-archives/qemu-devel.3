Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C616C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBF7-0002Ox-Dt; Mon, 19 Aug 2024 18:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE2-0000T2-FS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBE0-0000gV-LF
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:51:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37182eee02dso2551230f8f.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107902; x=1724712702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd77jbfvrLILzXcHedj2gSAGQaYl7M6K1uhrf65ne10=;
 b=URbGPzgX/DJiRLTIYSW46iqzl+KtpGiXlJXGkLKmmErHWJBWm8jqUrDT1p0uSVa2VD
 NnhC+BPFuV14sAJF/BYbvhewCYwc8EY3oh7oluVPIvQ+M9Ka00ssmiN++Z2V4mhLk/R+
 7iei8FR6jDSTHkSCvHuXDQy28yPIkIaXd8iuGQXXx2JdrOJkJbb9rlaf8b8h9DKRHqbn
 q04+Dig69KtNJNoct8ye3XVKnHCjFdWWF/NH6V640A/wOtIP093xeK0qX+rWeWaOKffa
 bTqiaB7bQtSLsI5IQvttnYFrEAn8RFPiDFZbSe3Vt9nCuWz1lvYBdwcraPDgnyEOQJFo
 ZXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107902; x=1724712702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nd77jbfvrLILzXcHedj2gSAGQaYl7M6K1uhrf65ne10=;
 b=kW3iCoSkbo2/2eB7hcnMk8fOrDVhQAjgSR7lRyym9XjkpHlzTnbg8dsCZ5Ne0g71jc
 nrcwJq+sLgutvGQJhvYS7maFU+QFqMZmhApf8IEeIVRT9lH7kktEtPyUdlS/Fy3FPdJ4
 sDtE9g5pMyZN+79WMBlrK2z1zhmVc153Ywjv1HB2KmMUgJCoFMCDCikkeVH7MxKoC7PL
 rW95g8Nbxmy8w6z3gRQGnTkyn3tJ0eMNjYRcPtyp01yO/pvPVsImtR8QmgYaB7l30YBk
 sGtxiwAlvfoo7NhMafmi23YoUxBO/p6ugEIC/4OdsLlVM//4dARlFl0LHGpynxzN7AiL
 BWJg==
X-Gm-Message-State: AOJu0YySaKmawEzka+ls467WLzOA6qsox+1oJOqwdcZZTBjt86n1kd4n
 DUjNYyc/sUdaVKq+Rf52PsakJUu6GPUHOcvN9X8vi4kX3xeoN/TQb0xLEZjWP7pwyXhWjMz+nup
 AQYg=
X-Google-Smtp-Source: AGHT+IGor8W9PkmhMbF5zZLQUdhb/zhmNCVLIQn5x0Sk5Z7uxD1NHUgZ3RU5K+SjSU5Or0U+qLRImQ==
X-Received: by 2002:a5d:5e04:0:b0:366:dfc4:3790 with SMTP id
 ffacd0b85a97d-371c4a63393mr463587f8f.0.1724107902137; 
 Mon, 19 Aug 2024 15:51:42 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a38csm11705599f8f.6.2024.08.19.15.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:51:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/20] target/mips: Use correct MMU index in get_pte()
Date: Tue, 20 Aug 2024 00:51:01 +0200
Message-ID: <20240819225116.17928-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240814090452.2591-3-philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 60147ba0af..0e94e00a5f 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -593,16 +593,21 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
  */
 
 static bool get_pte(CPUMIPSState *env, uint64_t vaddr, MemOp op,
-        uint64_t *pte)
+                    uint64_t *pte, unsigned ptw_mmu_idx)
 {
+    MemOpIdx oi;
+
     if ((vaddr & (memop_size(op) - 1)) != 0) {
         return false;
     }
+
+    oi = make_memop_idx(op | MO_TE, ptw_mmu_idx);
     if (op == MO_64) {
-        *pte = cpu_ldq_code(env, vaddr);
+        *pte = cpu_ldq_code_mmu(env, vaddr, oi, 0);
     } else {
-        *pte = cpu_ldl_code(env, vaddr);
+        *pte = cpu_ldl_code_mmu(env, vaddr, oi, 0);
     }
+
     return true;
 }
 
@@ -642,7 +647,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         /* wrong base address */
         return 0;
     }
-    if (!get_pte(env, *vaddr, directory_mop, &entry)) {
+    if (!get_pte(env, *vaddr, directory_mop, &entry, ptw_mmu_idx)) {
         return 0;
     }
 
@@ -668,7 +673,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
                                      ptw_mmu_idx) != TLBRET_MATCH) {
                 return 0;
             }
-            if (!get_pte(env, vaddr2, leaf_mop, &entry)) {
+            if (!get_pte(env, vaddr2, leaf_mop, &entry, ptw_mmu_idx)) {
                 return 0;
             }
             entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);
@@ -823,7 +828,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leaf_mop, &dir_entry)) {
+    if (!get_pte(env, vaddr, leaf_mop, &dir_entry, ptw_mmu_idx)) {
         return false;
     }
     dir_entry = get_tlb_entry_layout(env, dir_entry, leaf_mop, pf_ptew);
@@ -835,7 +840,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leaf_mop, &dir_entry)) {
+    if (!get_pte(env, vaddr, leaf_mop, &dir_entry, ptw_mmu_idx)) {
         return false;
     }
     dir_entry = get_tlb_entry_layout(env, dir_entry, leaf_mop, pf_ptew);
-- 
2.45.2


