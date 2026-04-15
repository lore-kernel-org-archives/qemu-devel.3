Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69496F428E3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD6jb-0005nS-JE; Wed, 15 Apr 2026 16:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jZ-0005n5-Nn
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD6jX-00029U-TE
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 16:21:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso68232695e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776284469; x=1776889269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tRASIuS0HGZ1KXlQIrarfjjRdCGTU4SsT3rkHsGSRk=;
 b=XMewRmWONnYAyynYj+99nvUUxzMiASVJx7Jo4/yDMJc/URdZbY/V9xqzQ9vNJQoqsx
 4mWfxR6h40+IPrXk9azoDC65goTRnqt/M3vNnFB5jCzqfohtrYg1lcrmo/GT9f/YZO3o
 A5f2QIctyDY6zwlQZds7qkHpDo4hCxdMw2cfQYrl+shjgczENsAuh4OTKIB1LctkD3LS
 CTYcm9t0ASie7TIbe6Td8KaJfD63ZAYfHmy5+dRvowc1/sN2CoHiP6IDn4S7sR5IdBpX
 G820wFz25w49w8lqd+6yf84exFP8UwkDPgyEywOP69414wnfnnUHy44QiGkPWatCzHhs
 HKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776284469; x=1776889269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9tRASIuS0HGZ1KXlQIrarfjjRdCGTU4SsT3rkHsGSRk=;
 b=VgnUv9SgG86WL+cT53BUli+ZC4mRdUAHt9lVE4MCF69BY0kZRw4obWLmqt6ctIEejr
 iRh+pYjnl0mSHCDYVZGbTmvExvGFYd19GWSPUsMjR+/sZE988Wf/thgPyhqit9ETByCm
 6f5aZ8zN2zD4w4tR6Tf2v7oPI9dZgFvT6i2fxmWXqsH9RHvTRcn/N4OkgrIoFKA9+8I1
 OlC+dVpxoO5GLGFBiNYvLMBRPPHUjgJW9yB8j0W3twBXHJiWWv3qK6xGWLTV9jJBXr4L
 yL5Cr5/lko8MnpdIPwKEFnh2GIBePPKVZjg70iqzXU7Xnw28TspWDEhwSRlrZw1f3Prt
 Dd2w==
X-Gm-Message-State: AOJu0Yz/18DnY1wRX2ixyIwkx15SW35y9q3LgL9MiThVIdoTmNHqjm7a
 wfvSlWqc/m8KfQJk7fdd1nPTfWLjBJysh8Wiw7xJw98a8ogemK6owc3B2CrUVp25Kl/L26vqeFk
 i8VQI6Q8=
X-Gm-Gg: AeBDietlCaFJ49DJfXM7RGwp9UYo5dSt62oeSLuW3JuaZobwm9W5qSPGaJ/EqiBf9eM
 7FR7kTELeNaWe8mUeLYSNOFxdudxauu6TJinf3LL51o+/vhh5ybJeb3MGPCw8PMp3wQgfuk56+u
 vZ5nUOVi7nb3XkoztclOjIhKh5+3GvE+bDZUc73M8/S1Zje7cc9VPXjsOdXMmU+h/vUebZTFNbq
 ZO4Fmq7TqU5TzKBLpPMK5R/cMViazUu5Nembd6Y4Z5FmwwkX5nayHSYTROiacvsbvHGl+UOqxtU
 AfRJvl0vB2PcLxnHS21uTCX/iS3Vstk5BOSQQyzjce1pF2EXxjwND2yXwcqzXy4qEWH8cR+o/xg
 AIkBfhQ/dCqk86O4hLyd7LI1y0JbzFrcUQVPyCoquJGxxRVOEVfj+Vav6ewuD1wYnRKVPOb/dmV
 PjFUm/TwS7UV5VeVnbEsnMaSKiCFthE3EZc/4fLKGj5+CX7gxCI0aFLTYluncp1P3sFb6MByGP
X-Received: by 2002:a05:600c:1f83:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488d687bf61mr317200555e9.25.1776284469049; 
 Wed, 15 Apr 2026 13:21:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0eb43f6sm27720695e9.25.2026.04.15.13.21.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 13:21:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [RFC PATCH v5 5/6] target/mips: Convert MSA LD/ST.D (Doubleword
 Vector)
Date: Wed, 15 Apr 2026 22:20:25 +0200
Message-ID: <20260415202027.83008-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415202027.83008-1-philmd@linaro.org>
References: <20260415202027.83008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace runtime helpers by translation.

Replace the legacy cpu_ld/st*_data_ra() calls by tcg_gen_qemu_ld/st()
which allow to respect atomicity.

Remove the ensure_writable_pages() hack and MSALDST_PROTO macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/msa_helper.h.inc |  6 ----
 target/mips/tcg/msa_helper.c     | 53 --------------------------------
 target/mips/tcg/msa_translate.c  | 18 +----------
 3 files changed, 1 insertion(+), 76 deletions(-)

diff --git a/target/mips/tcg/msa_helper.h.inc b/target/mips/tcg/msa_helper.h.inc
index f0d31ceef29..e994353056f 100644
--- a/target/mips/tcg/msa_helper.h.inc
+++ b/target/mips/tcg/msa_helper.h.inc
@@ -432,9 +432,3 @@ DEF_HELPER_4(msa_ftint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ftint_u_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_s_df, void, env, i32, i32, i32)
 DEF_HELPER_4(msa_ffint_u_df, void, env, i32, i32, i32)
-
-#define MSALDST_PROTO(type)                         \
-DEF_HELPER_3(msa_ld_ ## type, void, env, i32, tl)   \
-DEF_HELPER_3(msa_st_ ## type, void, env, i32, tl)
-MSALDST_PROTO(d)
-#undef MSALDST_PROTO
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index c93c0cddebc..67ec19ea95c 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -21,11 +21,8 @@
 #include "cpu.h"
 #include "internal.h"
 #include "tcg/tcg.h"
-#include "accel/tcg/cpu-ldst.h"
-#include "accel/tcg/probe.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
-#include "exec/target_page.h"
 #include "fpu/softfloat.h"
 #include "fpu_helper.h"
 
@@ -8205,53 +8202,3 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 
     msa_move_v(pwd, pwx);
 }
-
-/* Data format min and max values */
-#define DF_BITS(df) (1 << ((df) + 3))
-
-/* Element-by-element access macros */
-#define DF_ELEMENTS(df) (MSA_WRLEN / DF_BITS(df))
-
-void helper_msa_ld_d(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    uintptr_t ra = GETPC();
-    uint64_t d0, d1;
-
-    d0 = cpu_ldq_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_data_ra(env, addr + 8, ra);
-    pwd->d[0] = d0;
-    pwd->d[1] = d1;
-}
-
-#define MSA_PAGESPAN(x) \
-        ((((x) & ~TARGET_PAGE_MASK) + MSA_WRLEN / 8 - 1) >= TARGET_PAGE_SIZE)
-
-static inline void ensure_writable_pages(CPUMIPSState *env,
-                                         target_ulong addr,
-                                         int mmu_idx,
-                                         uintptr_t retaddr)
-{
-    /* FIXME: Probe the actual accesses (pass and use a size) */
-    if (unlikely(MSA_PAGESPAN(addr))) {
-        /* first page */
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-        /* second page */
-        addr = (addr & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-        probe_write(env, addr, 0, mmu_idx, retaddr);
-    }
-}
-
-void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
-                     target_ulong addr)
-{
-    wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = mips_env_mmu_index(env);
-    uintptr_t ra = GETPC();
-
-    ensure_writable_pages(env, addr, mmu_idx, GETPC());
-
-    cpu_stq_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_data_ra(env, addr + 8, pwd->d[1], ra);
-}
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 8486508f5ba..b1d764bd179 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -785,8 +785,8 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
         MO_ATOM_NONE,
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
         MO_ATOM_SUBALIGN, /* Slightly stronger than required */
+        MO_ATOM_IFALIGN_PAIR
     };
-    TCGv_i32 wd;
     TCGv_i128 t16;
     TCGv_va addr;
     MemOp mop;
@@ -801,22 +801,6 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a, bool is_load)
     addr = tcgv_va_temp_new();
     gen_base_offset_addr(ctx, addr, a->ws, a->sa << a->df);
 
-    wd = tcg_constant_i32(a->wd);
-
-    if (is_load) {
-        switch (a->df) {
-        case 3:
-            gen_helper_msa_ld_d(tcg_env, wd, addr);
-            return true;
-        }
-    } else {
-        switch (a->df) {
-        case 3:
-            gen_helper_msa_st_d(tcg_env, wd, addr);
-            return true;
-        }
-    }
-
     t16 = tcg_temp_new_i128();
 
     mop = MO_128 | MO_LE;
-- 
2.53.0


