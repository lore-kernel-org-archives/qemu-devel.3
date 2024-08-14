Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62C0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se9xc-0004zV-R8; Wed, 14 Aug 2024 05:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9xb-0004oA-Df
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:06:27 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1se9xZ-0000of-Io
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:06:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a7a83a968ddso642481366b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723626380; x=1724231180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKHnEDZFkWOqzMoUUCQs4Gmx/1ICFTXsIFwtO9oeg58=;
 b=FHck7vWffXFyNSg5W1peTmr8pBEEfnTYpIqN9sndq41T8eCvZnLBR3TqCRIymdlP1S
 9SuQxQNoi/XcBUwyuTUjJCJcKwhsNCXUPyfkcUiOcimPY23B5Ijh6CFfyNtztzPlnymT
 5XieCruYBCgF5lmz4DCecqZ8x6a/mYzc06nn+n1YqDA/S8It9XQKXeC0BF6nGQ5SBGo9
 O7jKLQkFr7bs7YhYayViMzzRzgqWAYn6KSKqVnl7vxzgMZPoMOpmUyg1hIJ4pIMlddMf
 aDmNAW2R7wUjTQp9f2Y6B9omqtpdI8iYB0mh18MWwk+IWXBWExtM8VGqsl1Pxt1HAnnk
 aloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723626380; x=1724231180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKHnEDZFkWOqzMoUUCQs4Gmx/1ICFTXsIFwtO9oeg58=;
 b=wFuykThEg3QskKYl58lgmfHBDe5nqqZApQ78pIB0fxHNgJ5d5BrePUENhmHtGhRnwr
 uL5Wo2o0F772wKDSleRhW59HywV2sq8vjaKYuxJ26r7TVlK/BXVJCMvcw/F7IPhRLjD1
 aCP25OKoksv4Sfjtvf4ZJPRcUsUVVWzDCZiL9ZF+b6r3/csom0k05r7gg0l2gy+BfgDv
 6qf8fuxjNIKZorlgerSmuZZ0QssmQ1CtBsIJCsP1YtAaEIrW4FXteZZsHCuTwrekK/u6
 0eyRiyKVL/ql+tosj78OS/oNZGbHJkiEZ8MdBwlH1J9VBRkY8ofYywiTUip/75zOV0Cm
 kaTA==
X-Gm-Message-State: AOJu0YzZ7Iublm6RcyBg2x9R53xYNQkeLyYAcmCFdYwSF1GiW8HMp+JP
 uaErmkDBNiR04wrt0aasF3nUIezHrTyJwIZ3sGZYUytzG6FBI3S83ijMS6nxRPf9/lDQZc4qUUF
 HkIM=
X-Google-Smtp-Source: AGHT+IGxB+22R0Ln8KkhLOLQsrx487K4X1eS/M2nIVp2u9luJn4SJPjSdV4aFwtEhAj4D9CCKyiNAQ==
X-Received: by 2002:a17:907:1b0d:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-a83663fa418mr137716866b.0.1723626379702; 
 Wed, 14 Aug 2024 02:06:19 -0700 (PDT)
Received: from localhost.localdomain (124.170.88.92.rev.sfr.net.
 [92.88.170.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f414f06bsm145948166b.159.2024.08.14.02.06.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 02:06:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v4 2/3] target/mips: Use correct MMU index in get_pte()
Date: Wed, 14 Aug 2024 11:04:51 +0200
Message-ID: <20240814090452.2591-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814090452.2591-1-philmd@linaro.org>
References: <20240814090452.2591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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


