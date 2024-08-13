Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD97C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdryT-0003CN-Kq; Tue, 13 Aug 2024 09:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdryP-00038P-Fd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:54:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdryN-0007ri-JE
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:54:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so10375483a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723557241; x=1724162041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvKmjjUJqY8VJl2i3YDgoMrvEzziJTXRVQk9yERgOsk=;
 b=IbC7F4YpL+iNsDelrE3y4wb7JTyAmmqg48IS53P06Li3PQTs7U/p9pK/PWHwFRjPzv
 KQO3QLfeypgO2LT8vCQm2XNmVelaT8VNhbK+An4EO2reR1K2PrLhF3qayT7bDvRfesvs
 949xcHYU2b4o70dmMKczCBDBiAjyOm+DGuBGyXbYkmc640WgOfLoHK/zFse1jFlMdDgV
 S+mD1NrJlBcqJGpnb2wpO+fGAn7LXohiqso09yydgma+jgJFKINS8tGpSC7PBYxmILxE
 tTXqsMcBhecU3nhrdCyaG4TUyQeR6Q4TJFw4ke1rw+TqKF7/U+bXNWpIE4bGVviZHjhH
 LqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723557241; x=1724162041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvKmjjUJqY8VJl2i3YDgoMrvEzziJTXRVQk9yERgOsk=;
 b=dq9CJ7xVri1xjyej0Qvzz9AczQpGVxn+vf9AZNcIR/xNJuQ1FESEwGb9wQedmNOvXW
 t8iLHWP8t4jXtKMKLIEzxZqbMfFRW4avvllEGZNGVCHIe3kJgUMkji19ozuZCPZ64TI5
 ppjiEMn0w/R9l0H6JQP58qWjfy2XvDklpKsJtfgYPiEw/33/5qzrDSMWaVLEccYt/vku
 TGFgbuWh827clTR5+8WbY9MD1nWDE+sOIaVlDk/hN1tXmRPISvtLDbTiXLSqWb1tdwey
 c6+EYtoFNMP0lMklkAeTJb2vx40Gy+wPMZTBhnqo5Rsd49flgQIzTjav7/sjTtNTyXbR
 pupA==
X-Gm-Message-State: AOJu0Yxm1dJKtnr69VZfbwfIt89wYU6ppXOIGYOiTRbhTe/KwDgwQwDv
 XTkDx+zOrFyA4dpNwSzexsApbttbXhcJ9IoTtEQeThShzKxEwrlTUq+kdUAoCif8G9F5rL/lVV0
 DtkM=
X-Google-Smtp-Source: AGHT+IGKFercliZf60z7hslylbPL+DPhm5ssu0KvHfbHvqfTDuUc0tNWU6aaLCmBliOtZm1GWbLLCA==
X-Received: by 2002:a17:907:cca3:b0:a7a:afe8:1013 with SMTP id
 a640c23a62f3a-a80f0a85a48mr186250666b.1.1723557240536; 
 Tue, 13 Aug 2024 06:54:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f414eb82sm72466266b.175.2024.08.13.06.53.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 06:54:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v3 2/2] target/mips: Use correct MMU index in get_pte()
Date: Tue, 13 Aug 2024 15:53:13 +0200
Message-ID: <20240813135313.96519-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813135313.96519-1-philmd@linaro.org>
References: <20240813135313.96519-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
index 75a26131ca..5bff4cb72f 100644
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
 
@@ -641,7 +646,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
         /* wrong base address */
         return 0;
     }
-    if (!get_pte(env, *vaddr, directory_mop, &entry)) {
+    if (!get_pte(env, *vaddr, directory_mop, &entry, ptw_mmu_idx)) {
         return 0;
     }
 
@@ -667,7 +672,7 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
                                      ptw_mmu_idx) != TLBRET_MATCH) {
                 return 0;
             }
-            if (!get_pte(env, vaddr2, leaf_mop, &entry)) {
+            if (!get_pte(env, vaddr2, leaf_mop, &entry, ptw_mmu_idx)) {
                 return 0;
             }
             entry = get_tlb_entry_layout(env, entry, leaf_mop, pf_ptew);
@@ -822,7 +827,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
                              ptw_mmu_idx) != TLBRET_MATCH) {
         return false;
     }
-    if (!get_pte(env, vaddr, leaf_mop, &dir_entry)) {
+    if (!get_pte(env, vaddr, leaf_mop, &dir_entry, ptw_mmu_idx)) {
         return false;
     }
     dir_entry = get_tlb_entry_layout(env, dir_entry, leaf_mop, pf_ptew);
@@ -834,7 +839,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
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


