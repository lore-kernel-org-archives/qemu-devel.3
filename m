Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA79FFF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtv-0000ni-WB; Wed, 29 Apr 2026 00:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtn-0000ai-03
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:48 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwtj-00013J-2j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:51:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b7adb38d65so58114575ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438302; x=1778043102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t12dkHELQlr7kmEBDjQiQOrmEP65Un9QTjXYostGZcQ=;
 b=r0lupXtsK94Q0fM9XsfSoKidk60KqJoWYUxPnK5UPQjgDjE+NcR8tp2iHPZB9WYbbW
 WuUcobr+w/2bDKO9DNa4yGGN9F1B/mfTEdoeGqy1f5OzxrLGjlXif29YFxlMctbxT8mQ
 +sv5PkWNM0cq45pveGuuTILrbbNq1hBaQ0/EEmuLGG4UM1bU+/brVo/ldPK6MxokxQlo
 j0t+EBA+eyuIA7cHD9DZrRilc5qS4+Su7G86CLATSwt9D0YGx2xKKPx6ZE08/ROVxfZh
 tvfp7YYVkKk9ChlsbuOZl/INsPE6a81bI90f3CPDeuUIQuYB0pGuAHMgRiDS+I8zX45g
 PWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438302; x=1778043102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t12dkHELQlr7kmEBDjQiQOrmEP65Un9QTjXYostGZcQ=;
 b=NkP/V3ELxy5lQXqAYZYhDba7//PMCyKqex6mk4FpIEI6UUHfUoSbIs9pMKFmbedWjz
 VnaSwEwKIIrsUQWdxDz9G2YnPzTeHc7Sb1gWfYDKaYQP8xxIeR/vV4Waotp/qwCIkhRS
 ifPE2VbpI/DrHon8XmyFVg46m/I7nGTTE/tu7LV8qgNoSRRrsAWlGRxXN0PXgrHVFisc
 NrQoBhbd8yNdbJ76rCmnu2UCp/jdweqs4ytY2ox9jKEE02wkeWaIVGayT+0/EhcbZ1XP
 XuJQd1RYEWDy1booPk8jCVNVOUGK7nx+Quf9bTu7fRHwzq6AiKVbqSSAhMj6+GMwbxpu
 UELw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CQ0OxoJ/lEYlhzx0uwqgBwhNPsSPtRlVsHPZcVFOoDFrKIWnGLpkwvEwSC797yAJdNCun3+Qd8GcI@nongnu.org
X-Gm-Message-State: AOJu0YxuhFzgU0G8ovnbyVt1yp9c1J5G8LSOGIAuze10MJogS9tUmIxF
 WTXa7j+K8Tw/QGuv/YHoq/grZQY/DAElW1wI2hEyFGdkO+yBoRpWfOUQ
X-Gm-Gg: AeBDiet+cUnwUcdYDMsDo3qToX6K4CchqsrGarbS+wDiTYAVD4ykUTUhgvH+6+nlgol
 ZyaNMyXPupCC3sNSNUJyqy+q3muTosUPfpNivlH3stGIFmCRZTdMT3sSpTv2qi16L9O2LdIk2df
 At4mfh10YjqjPcj1qIwVdKhYc5pkDQWHKbi6AypHrGmoesA+9J/vMxnW4ZiDiTal4v5BO8eotUs
 miSR9U4k5KjcBGrzVmO+aOStZeMqzPblDnqr58mro8TR4liZdSJBT8vhXMxoUg6nmxOQKqOgmnx
 lE4hnlNxtErMLkRvbSM3Dwm4nrUE6QlPd975qie9lEhVMn1cd6OXoK8mNgGFEP0HNk/uPTBRQIn
 hsP841PmzPG/VZH5MBJgAzm8niDAAXm7k9nhRq7NNQh2sbMeMiG9ymuvnu5uMOlOpPcU/fd4qqB
 Smr/lrJ9Q5Gw/L9JMS8DH9H5/vLZmbUB+ywiW3oSkiscTX6PZXmUje
X-Received: by 2002:a17:903:1cd:b0:2b4:6529:7b9f with SMTP id
 d9443c01a7336-2b97c46d112mr58193335ad.26.1777438301763; 
 Tue, 28 Apr 2026 21:51:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:51:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable@nongnu.org
Subject: [PULL 42/51] target/riscv: Generate access fault if sc comparison
 fails
Date: Wed, 29 Apr 2026 14:47:43 +1000
Message-ID: <20260429044752.4176397-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

The RISC-V spec states:

"For the purposes of memory protection, a failed SC.W may be treated
like a store."

So if the comparison in sc.w fails we should still check for alignment
and do a probe access to check permissions.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3323
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3136
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260415233740.3027321-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  3 +++
 target/riscv/op_helper.c                | 14 ++++++++++++++
 target/riscv/insn_trans/trans_rva.c.inc |  6 ++++++
 3 files changed, 23 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 54d2331966..36cdacfb0e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1351,3 +1351,6 @@ DEF_HELPER_4(vsm4r_vs, void, ptr, ptr, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(ssamoswap_disabled, void, env)
 #endif
+
+/* Zalrsc SC write probe */
+DEF_HELPER_FLAGS_3(sc_probe_write, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index dde40a5549..81873014cb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -267,6 +267,20 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
     /* We don't emulate the cache-hierarchy, so we're done. */
 }
 
+void helper_sc_probe_write(CPURISCVState *env, target_ulong addr,
+                           target_ulong size)
+{
+    uintptr_t ra = GETPC();
+    int mmu_idx = riscv_env_mmu_index(env, false);
+
+    if (addr & (size - 1)) {
+        env->badaddr = addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ADDR_MIS, ra);
+    }
+
+    probe_write(env, addr, size, mmu_idx, ra);
+}
+
 #ifndef CONFIG_USER_ONLY
 
 target_ulong helper_sret(CPURISCVState *env)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index a7a3278d24..62c0fe673d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -90,6 +90,12 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
      */
     TCGBar bar_strl = (ctx->ztso || a->rl) ? TCG_BAR_STRL : 0;
     tcg_gen_mb(TCG_MO_ALL + a->aq * TCG_BAR_LDAQ + bar_strl);
+    /*
+     * "For the purposes of memory protection, a failed SC.W may be treated
+     * like a store." so let's check the write access permissions
+     */
+    gen_helper_sc_probe_write(tcg_env, src1,
+                              tcg_constant_tl(memop_size(mop)));
     gen_set_gpr(ctx, a->rd, tcg_constant_tl(1));
 
     gen_set_label(l2);
-- 
2.53.0


