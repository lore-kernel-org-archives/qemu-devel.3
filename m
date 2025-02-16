Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2439EC021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6R-0007hN-Gr; Sat, 15 Feb 2025 19:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0007c1-L5
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:26 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS64-0006GB-Bg
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:24 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2fc3027c7aeso3249528a91.0
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664078; x=1740268878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JcTFhEmt/GmA4i7xwN3/fTGwcsSGIfQEr5FASNX2Lc=;
 b=bvAFWREcDORuTC0pGLo0SIH+XEzG/3O05VpS7wxjBj2F4NyuOItbbFIMkpdjqKP/B+
 cLoILUtD1r48dxbkf5CIETF651S+bePssKaM4VPjetQ0hQOp2WZLoIaib60BRPrKxh9q
 cE4/G5o4SEhqf5nxBbbxym8ONgVDBNchMtVFWSybmBLQgbrq2PB7GptPhcbD7rV9odqI
 hfMcTcCL2i2Oi9obpUHxMa2+aGnLgl3ITjhHr4YRqINf5QIGfcSP9DM3iJHTPqFFvYhA
 j3cCrJ1YGCksN7zifQfYWO32cQ5wtu17R3qvFpO9kNkw3hBqVWy5d6w7VYw77WfeIAN2
 vKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664078; x=1740268878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JcTFhEmt/GmA4i7xwN3/fTGwcsSGIfQEr5FASNX2Lc=;
 b=Iq2BR366rgUTVl9OLHuiUm0ApBJxLda7MJLK3YYDxhmpZI8wFSMtHxPRW4W7jFkkj0
 LvZnGzscT4+QFwroAvs64xViLf+Y15j4tJFKHCt3TGk/6lHTQP48EBH+TLFbcarDG3fe
 MoalNzdGx32lw/kbz9Mc5y4loSSeI9HKP8SYBZQ35b+vMX575xY1J9duXnDxK1ACjR/e
 pXFA5OqcRit0nQG9v5qBGdSMxKlPVbAfJd1dtfMhnsQZP7R3ajnVmjiUfhKhQQV/Uf4Y
 E47ZGJD7NFYch5lvcURIDye6ELnKjhpNPXGorfoQO7iDpSUeMNsO/0RnMXM+sDBqNZgO
 3j2A==
X-Gm-Message-State: AOJu0YxxWd5QIK6p9n+kq435jI80rvIDbClZLejtHO8vNK3GU3GxPlvd
 47vqXJM2PAUJ3baPj++SwOrr6pYzkFsv6zEBDdBYTDtgh/IguXgoA8EzqrHa1sT+Gzo7azwQn9z
 j
X-Gm-Gg: ASbGncsOjnGAzeDPr25U21Uo2UkCub6l9Ylryu+1TZumQTg73IQ6ERm1ohqo7Ug4OqQ
 lz1l7LtaJQjU6lOYUv33t8zd6eFvvVF2iK6+7qgwZ14rUybm7UzJ02PgS9aViyCAfFTEuIfThnD
 61MOUPMezTcZf9BupNxwq6FtM9BU8+SSoS+PmE0kZYdly9Wzk45j8JxBuakLNWvf9E9yt3W2yJK
 CA7c458+jNQzGx2mh5xrBbiD5bmFrz+BDqdd3P0Sd2a9HEpnY/f3E7qfriY6LIeQk8mkP9xumS+
 Id4Nh3lap0EuDl45TlqoC83LiHDlKJ/RT66osLNUSA14+/g=
X-Google-Smtp-Source: AGHT+IHoMdZQeYLjP+tChVB646qwiuDqx1pVFcimgKRwNbI9w+joyNSpHqxIUN7XqSgqrAOPtUWSzg==
X-Received: by 2002:a17:90b:3c82:b0:2fa:13f7:960 with SMTP id
 98e67ed59e1d1-2fc40f0e9dbmr7219765a91.13.1739664078098; 
 Sat, 15 Feb 2025 16:01:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/24] tcg: Replace addr{lo,
 hi}_reg with addr_reg in TCGLabelQemuLdst
Date: Sat, 15 Feb 2025 16:00:53 -0800
Message-ID: <20250216000109.2606518-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

There is now always only one guest address register.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 18 +++++++++---------
 tcg/aarch64/tcg-target.c.inc     |  4 ++--
 tcg/arm/tcg-target.c.inc         |  4 ++--
 tcg/i386/tcg-target.c.inc        |  4 ++--
 tcg/loongarch64/tcg-target.c.inc |  4 ++--
 tcg/mips/tcg-target.c.inc        |  4 ++--
 tcg/ppc/tcg-target.c.inc         |  4 ++--
 tcg/riscv/tcg-target.c.inc       |  4 ++--
 tcg/s390x/tcg-target.c.inc       |  4 ++--
 tcg/sparc64/tcg-target.c.inc     |  4 ++--
 10 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index fef93b25ff..55cb9b3ac7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -100,8 +100,7 @@ struct TCGLabelQemuLdst {
     bool is_ld;             /* qemu_ld: true, qemu_st: false */
     MemOpIdx oi;
     TCGType type;           /* result type of a load */
-    TCGReg addrlo_reg;      /* reg index for low word of guest virtual addr */
-    TCGReg addrhi_reg;      /* reg index for high word of guest virtual addr */
+    TCGReg addr_reg;        /* reg index for guest virtual addr */
     TCGReg datalo_reg;      /* reg index for low word to be loaded or stored */
     TCGReg datahi_reg;      /* reg index for high word to be loaded or stored */
     const tcg_insn_unit *raddr;   /* addr of the next IR of qemu_ld/st IR */
@@ -6061,7 +6060,7 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
          */
         tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
                                TCG_TYPE_I32, TCG_TYPE_I32,
-                               ldst->addrlo_reg, -1);
+                               ldst->addr_reg, -1);
         tcg_out_helper_load_slots(s, 1, mov, parm);
 
         tcg_out_helper_load_imm(s, loc[!HOST_BIG_ENDIAN].arg_slot,
@@ -6069,7 +6068,7 @@ static void tcg_out_ld_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         next_arg += 2;
     } else {
         nmov = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
-                                      ldst->addrlo_reg, ldst->addrhi_reg);
+                                      ldst->addr_reg, -1);
         tcg_out_helper_load_slots(s, nmov, mov, parm);
         next_arg += nmov;
     }
@@ -6226,21 +6225,22 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
 
     /* Handle addr argument. */
     loc = &info->in[next_arg];
-    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
+    tcg_debug_assert(s->addr_type <= TCG_TYPE_REG);
+    if (TCG_TARGET_REG_BITS == 32) {
         /*
-         * 32-bit host with 32-bit guest: zero-extend the guest address
+         * 32-bit host (and thus 32-bit guest): zero-extend the guest address
          * to 64-bits for the helper by storing the low part.  Later,
          * after we have processed the register inputs, we will load a
          * zero for the high part.
          */
         tcg_out_helper_add_mov(mov, loc + HOST_BIG_ENDIAN,
                                TCG_TYPE_I32, TCG_TYPE_I32,
-                               ldst->addrlo_reg, -1);
+                               ldst->addr_reg, -1);
         next_arg += 2;
         nmov += 1;
     } else {
         n = tcg_out_helper_add_mov(mov, loc, TCG_TYPE_I64, s->addr_type,
-                                   ldst->addrlo_reg, ldst->addrhi_reg);
+                                   ldst->addr_reg, -1);
         next_arg += n;
         nmov += n;
     }
@@ -6288,7 +6288,7 @@ static void tcg_out_st_helper_args(TCGContext *s, const TCGLabelQemuLdst *ldst,
         g_assert_not_reached();
     }
 
-    if (TCG_TARGET_REG_BITS == 32 && s->addr_type == TCG_TYPE_I32) {
+    if (TCG_TARGET_REG_BITS == 32) {
         /* Zero extend the address by loading a zero for the high part. */
         loc = &info->in[1 + !HOST_BIG_ENDIAN];
         tcg_out_helper_load_imm(s, loc->arg_slot, TCG_TYPE_I32, 0, parm);
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 45dc2c649b..6f383c1592 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1775,7 +1775,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr_reg;
+        ldst->addr_reg = addr_reg;
 
         mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                      ? TCG_TYPE_I64 : TCG_TYPE_I32);
@@ -1837,7 +1837,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr_reg;
+            ldst->addr_reg = addr_reg;
 
             /* tst addr, #mask */
             tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, a_mask);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 252d9aa7e5..865aab0ccd 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1491,7 +1491,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
@@ -1558,7 +1558,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* We are expecting alignment to max out at 7 */
         tcg_debug_assert(a_mask <= 0xff);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b33fe7fe23..cfea4c496d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2201,7 +2201,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         if (TCG_TARGET_REG_BITS == 64) {
             ttype = s->addr_type;
@@ -2257,7 +2257,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* jne slow_path */
         jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addr, a_mask, true, false);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4f32bf3e97..dd67e8f6bc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1010,7 +1010,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr_reg;
+        ldst->addr_reg = addr_reg;
 
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
@@ -1055,7 +1055,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr_reg;
+            ldst->addr_reg = addr_reg;
 
             /*
              * Without micro-architecture details, we don't know which of
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 153ce1f3c3..d744b853cd 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1244,7 +1244,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_AREG0, mask_off);
@@ -1309,7 +1309,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr;
+            ldst->addr_reg = addr;
 
             /* We are expecting a_bits to max out at 7, much lower than ANDI. */
             tcg_debug_assert(a_bits < 16);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 74b93f4b57..2d16807ec7 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2473,7 +2473,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* Load tlb_mask[mmu_idx] and tlb_table[mmu_idx].  */
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, mask_off);
@@ -2577,7 +2577,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst = new_ldst_label(s);
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr;
+            ldst->addr_reg = addr;
 
             /* We are expecting a_bits to max out at 7, much lower than ANDI. */
             tcg_debug_assert(a_bits < 16);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 55a3398712..689fbea0df 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1727,7 +1727,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr_reg;
+        ldst->addr_reg = addr_reg;
 
         init_setting_vtype(s);
 
@@ -1790,7 +1790,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
             ldst = new_ldst_label(s);
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr_reg;
+            ldst->addr_reg = addr_reg;
 
             init_setting_vtype(s);
 
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 6786e7b316..b2e1cd60ff 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1920,7 +1920,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr_reg;
+        ldst->addr_reg = addr_reg;
 
         tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
                      s->page_bits - CPU_TLB_ENTRY_BITS);
@@ -1974,7 +1974,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst = new_ldst_label(s);
             ldst->is_ld = is_ld;
             ldst->oi = oi;
-            ldst->addrlo_reg = addr_reg;
+            ldst->addr_reg = addr_reg;
 
             tcg_debug_assert(a_mask <= 0xffff);
             tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ea0a3b8692..527af5665d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1127,7 +1127,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
     ldst->oi = oi;
-    ldst->addrlo_reg = addr_reg;
+    ldst->addr_reg = addr_reg;
     ldst->label_ptr[0] = s->code_ptr;
 
     /* bne,pn %[xi]cc, label0 */
@@ -1147,7 +1147,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr_reg;
+        ldst->addr_reg = addr_reg;
         ldst->label_ptr[0] = s->code_ptr;
 
         /* bne,pn %icc, label0 */
-- 
2.43.0


