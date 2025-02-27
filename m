Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84EAC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnert-000683-Sf; Thu, 27 Feb 2025 09:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerm-0005Qb-3j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:58 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerj-0004ut-BU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:57 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so9605645e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740666469; x=1741271269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wGTNFxYDOBY5OQaGDmBAuOxvbJwhsg8/Ld9YxzxYgfA=;
 b=N13qwBjXmsDZtvx1sLihLtLTN39Kmc2gvV5e4OwAN2+vGPXMQ/kxb/khIbVR58JI6H
 VzUWealKNoY1FELiFLX9jrZQtMaPORVlrjIBYAlCGcW8b48xcqYG3a+w80egHM9O7IR4
 mAKMA46X0BiN/8QvLiK/mmrem9i2QDA/hjkR2lphRH2bIEdFSmj4ChMpMVwMbAEFKWlD
 Gvlsos2LoE8FhYFLL0n3585W5w4xwCqVcOzCTqDsnJPKOMddF3pryP9JcZf36ZWk3hJz
 R8nPHm8AvegicmFJiaJXc0xro+1kX1hRyUnnV/Rd5MYXDsFRReHhcLmFD2UlOSc1x02P
 Ce3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666469; x=1741271269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGTNFxYDOBY5OQaGDmBAuOxvbJwhsg8/Ld9YxzxYgfA=;
 b=vNsBu6KvPwzZrOulW824hpeYL+q71ZU6bVIj0qZaHEvLBobZ41z4bmTE45ijHKQ/jQ
 x3I0M3sz+keNjIDc0rLOK8Km/Ar/AKeDJhh04VFYQLqSs5D2LEL4NcJuzZdGs+FdNlvD
 N3s8v1ifd5OIJsEXuJ0zu/gaoz2uEafcltEQL69h42u8V+e9U++RwUMWuTnf/7GCGO8L
 aBQ/bGjaaMQ+yQStbdsDbihAtmYdp9aZ7H//YzIJeRJ1fnLrGYPX3EW5C4iJXg3DtQZF
 brczaZJcF8x7U6a0SYUCN/Hx/rfwOilnfQfK6LbzfMbzjHPTuPNk0QABZg/cDBzzzUgv
 u1IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaUg1f98IVTDQQ0ruzEBYFEwj7C62WpPTEFrTYc03gnJOzO3noR2fn/cMleTX1zZddlNytiyc3E0ih@nongnu.org
X-Gm-Message-State: AOJu0Yw3gpevRmWQEnIictIgz3cMh9cIvDLwPCPg8lmge97hUHqngEhV
 1mCNlzqKyFRrIM8ZTct9D2zN106zhghmYqA1EvRmqI3tJkhKxH2bqdw5KcGHF/M=
X-Gm-Gg: ASbGncslVTDSUDpX8qCsR6HXvrlwY4A0mwORAfaw3Xr4HEIIWOoAJLxzDWxxm6PzcmI
 /sFP6dQZJ8O5hu6GFT3BVu8NgixptjWUNghLFzbu9fstl+JvwZC84m881oQ94nRYcagvQnjINVu
 N9cwYWkmK84pLmhrIRMW3YGNEDz+zQL+Qlwz16fYwJbLIw9K6Kj9ALcWHnbb5IHcDZ/T3wG//WX
 fNFJfTk2gUaI0Cz+um/HF4tfg18sw+9WSslkYiNYsbG+bd4txsd1N/oqBph1WRVhuj91qoJTkx1
 GHQM3hm0APwOB9bRKqf+whOno1SpjRTz
X-Google-Smtp-Source: AGHT+IHj/8Kj0lsgvn4qtkG4AhEgZUM1J0MY/frv4KSXyXhuYaMtMOVXbqDG7eHeOkEVhcHfN7ybGg==
X-Received: by 2002:a05:600c:5123:b0:439:8ef6:5782 with SMTP id
 5b1f17b1804b1-43ab8fd7acemr72056025e9.10.1740666469262; 
 Thu, 27 Feb 2025 06:27:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532b8dsm55968335e9.14.2025.02.27.06.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:27:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] target/arm: Correct LDRD atomicity and fault behaviour
Date: Thu, 27 Feb 2025 14:27:44 +0000
Message-ID: <20250227142746.1698904-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142746.1698904-1-peter.maydell@linaro.org>
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Our LDRD implementation is wrong in two respects:

 * if the address is 4-aligned and the load crosses a page boundary
   and the second load faults and the first load was to the
   base register (as in cases like "ldrd r2, r3, [r2]", then we
   must not update the base register before taking the fault
 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses

Rewrite the handling of the loads in LDRD to use a single
tcg_gen_qemu_ld_i64() and split the result into the destination
registers. This allows us to get the atomicity requirements
right, and also implicitly means that we won't update the
base register too early for the page-crossing case.

Note that because we no longer increment 'addr' by 4 in the course of
performing the LDRD we must change the adjustment value we pass to
op_addr_ri_post() and op_addr_rr_post(): it no longer needs to
subtract 4 to get the correct value to use if doing base register
writeback.

STRD has the same problem with not getting the atomicity right;
we will deal with that in the following commit.

Cc: qemu-stable@nongnu.org
Reported-by: Stu Grossman <stu.grossman@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 64 ++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index d8225b77c8c..e10a1240c17 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -5003,10 +5003,43 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
     return true;
 }
 
+static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
+{
+    /*
+     * LDRD is required to be an atomic 64-bit access if the
+     * address is 8-aligned, two atomic 32-bit accesses if
+     * it's only 4-aligned, and to give an alignemnt fault
+     * if it's not 4-aligned.
+     * Rt is always the word from the lower address, and Rt2 the
+     * data from the higher address, regardless of endianness.
+     * So (like gen_load_exclusive) we avoid gen_aa32_ld_i64()
+     * so we don't get its SCTLR_B check, and instead do a 64-bit access
+     * using MO_BE if appropriate and then split the two halves.
+     *
+     * This also gives us the correct behaviour of not updating
+     * rt if the load of rt2 faults; this is required for cases
+     * like "ldrd r2, r3, [r2]" where rt is also the base register.
+     */
+    int mem_idx = get_mem_index(s);
+    MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
+    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_i64 t64 = tcg_temp_new_i64();
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    TCGv_i32 tmp2 = tcg_temp_new_i32();
+
+    tcg_gen_qemu_ld_i64(t64, taddr, mem_idx, opc);
+    if (s->be_data == MO_BE) {
+        tcg_gen_extr_i64_i32(tmp2, tmp, t64);
+    } else {
+        tcg_gen_extr_i64_i32(tmp, tmp2, t64);
+    }
+    store_reg(s, rt, tmp);
+    store_reg(s, rt2, tmp2);
+}
+
 static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     if (!ENABLE_ARCH_5TE) {
         return false;
@@ -5017,18 +5050,10 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     }
     addr = op_addr_rr_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt + 1, tmp);
+    do_ldrd_load(s, addr, a->rt, a->rt + 1);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_rr_post(s, a, addr, -4);
+    op_addr_rr_post(s, a, addr, 0);
     return true;
 }
 
@@ -5152,23 +5177,14 @@ static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
 
 static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 {
-    int mem_idx = get_mem_index(s);
-    TCGv_i32 addr, tmp;
+    TCGv_i32 addr;
 
     addr = op_addr_ri_pre(s, a);
 
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, a->rt, tmp);
-
-    tcg_gen_addi_i32(addr, addr, 4);
-
-    tmp = tcg_temp_new_i32();
-    gen_aa32_ld_i32(s, tmp, addr, mem_idx, MO_UL | MO_ALIGN);
-    store_reg(s, rt2, tmp);
+    do_ldrd_load(s, addr, a->rt, rt2);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_ri_post(s, a, addr, -4);
+    op_addr_ri_post(s, a, addr, 0);
     return true;
 }
 
-- 
2.43.0


