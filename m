Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26718C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pb-0002I0-Mh; Mon, 17 Feb 2025 14:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ox-0001uu-54
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:26 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ou-0008Kj-F4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220dc3831e3so66720745ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820617; x=1740425417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjZ/gYyzhdiz61dtt91DImwS+lEhF+ORlkHG1x+DTPI=;
 b=N+Zy0c7C3tRuYrmJd30P68nppgH+mBCYUio3hdhwoNKYOUkPv7ER8KPlIj2zJAf81C
 63gHy6Su01QK/hO9mDsSED0BjXW3y45RExf9mwmCLwMNlHWxO/dCFogT9+hCiADzCrPo
 xHMAx2pEEP4jEkB8MP+gVKM4uNJTYhvJDgTKc/zXzq8KcIydpbGurPmVwlg/99hewUFI
 F01ZmtiV4WfMqNmNnYrPJflULrbzVgaodZKuWZef8ZEz/HCaAz0XdSqiT7VUdbHBJrzC
 BK2EeW5TAptZC+AVy+aiLX3C5LoFvmYFgeqU0mL8qq1oc6IITHwXQu4AdJK0rCWqwTby
 uFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820617; x=1740425417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjZ/gYyzhdiz61dtt91DImwS+lEhF+ORlkHG1x+DTPI=;
 b=uT63z33ztIAqARXboNLTV3FnCHWIIpm8CLHpsnHsMSMT0LgD0r2N2SDU/Oep8xab/I
 8dabjrqMyZ1AaELQyidvpYQMlg5cJ1/OYjTn7enzG7ysHYnaCUSv5uuerTq2UGw1lz7y
 IvxYUosxqQwhU1oK8kYOSv4+r36vp5NkSS8XzH7wEnKphVCgVAz92R3ZNRtx/QNqnl17
 Q/+yhlqrT0Aw/xt32qRbdWi5PsGaX25TD2twDRVvvnO1p1NB4qM1X5dXq8i8YfXrEwmZ
 xqb8aKRsKP4JggTv/oQCPtz5j32lT+63pehnEaTsi+WBimp/wjlIosNKSFBN+O+Puy5E
 qPoQ==
X-Gm-Message-State: AOJu0YzZKTzRDoycZJjab7kCeo4rDz/FHeYGlFvF16oS9yohp6pU2FUY
 3SLzpY0Kp86mOJAUPNBXMWTLKW6mSFFEYD7Dx4fKoHo500a8c9FaPpcJz4vQgXucwDf9j2BJBLx
 +
X-Gm-Gg: ASbGnctVhb+EVZWAl4ILSHWJ5JtGXosWE3qsyVZshGnjsrmmg3/UyQJGxLQvbGQEltQ
 QCFBH7/3UcGG8ZFcF413o5CHqe3iYDBJM8ewq42t6pqnfe81KUYYrGETHADLwK0ktHprQvcmTPS
 lIxm2CoA3X4zx0+FwMcDqTkMS5MP2Jy8/M8BLylymBu/4BnBSNZU3iOukmfsBd50Sg4MEaTM9xd
 e3gZPEsHRzIpxcHk+YvQpj+TYxmjF72PuuxVZERUxxa1x895ZTWTMlpW0PQp0I1A9PxgA11yv4h
 2JI3mEInioG4ACzqM0HYAxEhX6dWHndDT8R+12wP2ThswSA=
X-Google-Smtp-Source: AGHT+IHw4sz4Xsu1zmwx9bP1hPwBHZCS6jkoWukZDBDWU3VTQw62J6rYMG1ZXKb+0B9cdG7eabRklw==
X-Received: by 2002:a05:6a00:6597:b0:732:6276:b46c with SMTP id
 d2e1a72fcca58-7326276b487mr12924449b3a.0.1739820617487; 
 Mon, 17 Feb 2025 11:30:17 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 09/27] tcg: Replace addr{lo,
 hi}_reg with addr_reg in TCGLabelQemuLdst
Date: Mon, 17 Feb 2025 11:29:50 -0800
Message-ID: <20250217193009.2873875-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 93a3ccaf66..83f6eb6099 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1485,7 +1485,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
-        ldst->addrlo_reg = addr;
+        ldst->addr_reg = addr;
 
         /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
         QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
@@ -1552,7 +1552,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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


