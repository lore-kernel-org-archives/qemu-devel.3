Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC974CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQge-0005ih-QV; Tue, 16 Jun 2026 06:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgc-0005Zw-VA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQgb-00038F-6q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:06:26 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c8629bed4e7so3071257a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604384; x=1782209184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoVZEPR/9+nnh498alOrlfMaDgDYVh2sCOYh3fw4mdw=;
 b=hknb6PiiUtzQKUePRFtMTcorJvVT0gteoyKbK9ht3fKGe0LAzQrSGtGlPwIUOxv7BU
 XTw7YfbfNYAmhGHPRH/0JWyjKfjCBmq5axtu4zzqSQlbEUNoC7RS1JCoTlDdDaHaJO23
 WOoBgn9OwTd4LnDKVeZxlhLMaYKrcStM4B2XHfrwPQz7xD7gfkOeVb/NmFTAYa0cRfNH
 ftWobAIPgi0EPYZzCLOPJsZgxeoF65SETK0OQ0VqGlJYjKgurc+jL0S0ESg0OnrAWSEL
 yGv5JzBBE76EZCvHAPuP9t+VU9iztaSZTEy3SY0h6qBh5qIL+UWSHIbj0z9Ss7LpTYny
 WnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604384; x=1782209184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DoVZEPR/9+nnh498alOrlfMaDgDYVh2sCOYh3fw4mdw=;
 b=Co36V33ibBnMOHMvpfllD1M+vSpifaFQ1TaPPYCvrnwjmIu/pEtHtEi4idPXpT1VTV
 JPdkCg9kfLQ9NICFVS9MhKnnqbgArjzEs3UTtvOUKCZ42xbg7x+oqf4W9Nf31GkEY7oV
 +tK/ei+vx2upDgpr5vsqD2YBQVoZDuSemCbeVqO0FdYpy4EIJ9qpAj/sVSf6/Xgilooa
 ihgoZ+4badEIKZc1D1WcPvm1h+4DTnTxQpgziJLYim6zGWxXKwqgRWNSdk9u8Xujk7cN
 /Z+en0xsKk0icYcTRR3XywIN4og7wt6cvyjaX18pdFPWwlInfcffb41jfNczTXwsuwZL
 Pi1Q==
X-Gm-Message-State: AOJu0Yw8SF6eK9LUQ9EX25T1O+b8CsSSVE4hba9ngf7BuwsTfifGA9ds
 MBIlCFFWIMi8HgaCcfsE89uBkYNMGrUedoO/CXy0yyhLtRgW58/oPzeYXceaYFLk
X-Gm-Gg: Acq92OGbr3MfLyeZAWHyTW0kuKsFnaNfUwfLb7toOgznH89R59DX5loZlxbe/FcmfVZ
 nZ3Q78g4lL0quT3S6YefI4Lus95fkrgx/YO1vQKQICb7M7g3xoEYzB+6opc1SC4WWH0wOmfdgF8
 yF+asIeQKAMZeLEtJBKXXYYxms95An2m3tawqptFblnIDyrphoWUYCXoBgHBWWzMVjmg4AVP+2E
 tEYlMCnS5AEw8UfyddAIOtYZejqx7bdikH7wBASyu/BsSW+2xOECwss4rqcfxgEophaaM0dXdhQ
 Og8Q56bBqnaFhCmd1nQN3aO6pKI+9yS1shsQIhbyjK9hZ5Cxz1yPVQJ+mxau2tZfXlWp2p8DLPj
 no8FxqZXEqk7O0O/lTJsNWqF/ZigAiv8WYWN3ictmxBAp7gvec0C8hxnqt8oAFCSbawPF6ooo9J
 0o9tWB1cSg6HLQgl5ZOnys65OcAs54ru+aZJ+z42RaR2AulJ/WwiE=
X-Received: by 2002:a05:6a21:1690:b0:3b4:b216:2b32 with SMTP id
 adf61e73a8af0-3b7e4740859mr3673910637.15.1781604383734; 
 Tue, 16 Jun 2026 03:06:23 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:06:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/83] target/riscv: Fix size of pc, load_[val|res]
Date: Tue, 16 Jun 2026 20:04:17 +1000
Message-ID: <20260616100527.1939565-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
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

From: Anton Johansson <anjo@rev.ng>

Fix to 64 bits in size and as these are mapped to TCG globals, be
careful with host endianness when allocating globals.  Casts are
added to logging expressions to retain the correct size for
TARGET_RISCV32.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-4-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  6 +++---
 target/riscv/cpu.c        |  2 +-
 target/riscv/cpu_helper.c |  6 +++---
 target/riscv/machine.c    |  6 +++---
 target/riscv/translate.c  | 12 +++++++-----
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 981073021f..8f0e73b6b5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -226,9 +226,9 @@ struct CPUArchState {
     uint8_t vxsat;
     bool vill;
 
-    target_ulong pc;
-    target_ulong load_res;
-    target_ulong load_val;
+    uint64_t pc;
+    uint64_t load_res;
+    uint64_t load_val;
 
     /* Floating-Point state */
     uint64_t fpr[32]; /* assume both F and D extensions */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a57884dbc9..c0b6218421 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -585,7 +585,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
     }
 #endif
-    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
+    qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c3745cee19..f81354c90d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2373,9 +2373,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
 
     qemu_log_mask(CPU_LOG_INT,
                   "%s: hart:%"PRIu64", async:%d, cause:"TARGET_FMT_lx", "
-                  "epc:0x"TARGET_FMT_lx", tval:0x"TARGET_FMT_lx", desc=%s\n",
-                  __func__, env->mhartid, async, cause, env->pc, tval,
-                  riscv_cpu_get_trap_name(cause, async));
+                  "epc:0x%"PRIx64", tval:0x"TARGET_FMT_lx", desc=%s\n",
+                  __func__, env->mhartid, async, cause, env->pc,
+                  tval, riscv_cpu_get_trap_name(cause, async));
 
     mode = env->priv <= PRV_S && cause < 64 &&
         (((deleg >> cause) & 1) || s_injected || vs_injected) ? PRV_S : PRV_M;
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 45e13a0105..a0376c7564 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -453,9 +453,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
         VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
-        VMSTATE_UINTTL(env.pc, RISCVCPU),
-        VMSTATE_UINTTL(env.load_res, RISCVCPU),
-        VMSTATE_UINTTL(env.load_val, RISCVCPU),
+        VMSTATE_UINT64(env.pc, RISCVCPU),
+        VMSTATE_UINT64(env.load_res, RISCVCPU),
+        VMSTATE_UINT64(env.load_val, RISCVCPU),
         VMSTATE_UINTTL(env.frm, RISCVCPU),
         VMSTATE_UINTTL(env.badaddr, RISCVCPU),
         VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 4a557b4907..b444fde3ef 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1484,6 +1484,10 @@ void riscv_translate_init(void)
     /* 32 bits in size, no offset needed */
     size_t vl_offset = offsetof(CPURISCVState, vl);
     size_t vstart_offset = offsetof(CPURISCVState, vstart);
+    /* 64 bits in size mapped to TCGv, needs offset */
+    size_t pc_offset     = offsetof(CPURISCVState, pc) + field_offset;
+    size_t res_offset    = offsetof(CPURISCVState, load_res) + field_offset;
+    size_t val_offset    = offsetof(CPURISCVState, load_val) + field_offset;
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
@@ -1499,11 +1503,9 @@ void riscv_translate_init(void)
             offsetof(CPURISCVState, fpr[i]), riscv_fpr_regnames[i]);
     }
 
-    cpu_pc = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, pc), "pc");
+    cpu_pc = tcg_global_mem_new(tcg_env, pc_offset, "pc");
     cpu_vl = tcg_global_mem_new_i32(tcg_env, vl_offset, "vl");
     cpu_vstart = tcg_global_mem_new_i32(tcg_env, vstart_offset, "vstart");
-    load_res = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_res),
-                             "load_res");
-    load_val = tcg_global_mem_new(tcg_env, offsetof(CPURISCVState, load_val),
-                             "load_val");
+    load_res = tcg_global_mem_new(tcg_env, res_offset, "load_res");
+    load_val = tcg_global_mem_new(tcg_env, val_offset, "load_val");
 }
-- 
2.54.0


