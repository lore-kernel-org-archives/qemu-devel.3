Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73382C48BEC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 22:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rakPR-0005m8-Rq; Thu, 15 Feb 2024 17:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPP-0005kr-Gg
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:47 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rakPL-0006DQ-3B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 17:40:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d918008b99so11622415ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 14:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708036841; x=1708641641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0c/7JvgnDh+15xoKUqd6xGLTzj/38aC5iwcl74lVSY=;
 b=WpMjCDOrcLIda4bGJv0PgQKeiaBiI3szqrleOIusYMCc1RXgOSrsOWmjYd+it2wPdX
 HeHmJ+Vtu1c7UpvZux04Ux373/KQkl+WjSCfyxvwSjFmSQmxAJ0C3jzZv/l9MjVLDmYF
 IUU7dcltxvAOGmur72oBzYf2ZFDfTqnarGU2P+Y2wvjswdCA4K1KcazhJU9hsue3x48y
 Vx64NkRSiUJjYRkIwuTGVqfx3gybCs20tCSlC11CbHzlwRpSAfuzGoaRMDEWoS8rdows
 bM6ZuwLVV4FihxInYFI35X2Zi6OupRauu9GYGPy/ZqBx9bAf9m3P81yslH5UtMtmgL40
 6aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708036841; x=1708641641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0c/7JvgnDh+15xoKUqd6xGLTzj/38aC5iwcl74lVSY=;
 b=IWN7fuMmdy+4mpExKu/XvLmlcQD5Crb5gmHkHSELpb7HiWo2INavKVQAnBY16/3SuU
 KIrC3q5Xj9wEtmegMorXmKbOHhUqZd5baa8VSd6OFdR2Z1nvbMDYqwSfxmv96j2ZkgzP
 4DNhONHze5/1AheKi4ghxu2+gL6rXH/R2aOcez2Jjn8j9cEcHN7+1TlIRCo0jiTQhHHQ
 cpxMKUYSp2cCgi510YMkrPBU0cKl0LN+5qyAEmdhwxRo6aNThYhbdNuIE0d7wM+tNEtX
 HxBgz3Bzjt9bDHXYx+2L/kL1sCohoNeA6aZVM+pk0C2OS0DUg/reuFpTudP2S4G5D8Ov
 w39Q==
X-Gm-Message-State: AOJu0Yxq+k9BVgwlGZRRXz/twV7UYP8owLxGeG7MzCzqDOK9F7GUqzRW
 gKkmiuQaDIQrEz/PCoOzzDUqHrfXXewjJ5uUibWWbE92aafF565ajUtvR7YDmkF5ZND3EdAzNAR
 e
X-Google-Smtp-Source: AGHT+IEgdOK7sxcd7a82zb18BWAXaQ3yBgh1EMV4FKhvng+9MMBPFPqrfO4rgo+gYnHl+ks3z5zWFg==
X-Received: by 2002:a17:902:650e:b0:1d9:7046:fbcd with SMTP id
 b14-20020a170902650e00b001d97046fbcdmr2734717plk.3.1708036841161; 
 Thu, 15 Feb 2024 14:40:41 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j2-20020a170902758200b001db40866e25sm1733679pll.308.2024.02.15.14.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 14:40:40 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Andrew Jones <ajones@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 5/6] target/riscv: Gate hardware A/D PTE bit updating
Date: Thu, 15 Feb 2024 19:39:54 -0300
Message-ID: <20240215223955.969568-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215223955.969568-1-dbarboza@ventanamicro.com>
References: <20240215223955.969568-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Andrew Jones <ajones@ventanamicro.com>

Gate hardware A/D PTE bit updating on {m,h}envcfg.ADUE and only
enable menvcfg.ADUE on reset if svade has not been selected. Now
that we also consider svade, we have four possible configurations:

 1) !svade && !svadu
    use hardware updating and there's no way to disable it
    (the default, which maintains past behavior. Maintaining
     the default, even with !svadu is a change that fixes [1])

 2) !svade && svadu
    use hardware updating, but also provide {m,h}envcfg.ADUE,
    allowing software to switch to exception mode
    (being able to switch is a change which fixes [1])

 3) svade && !svadu
    use exception mode and there's no way to switch to hardware
    updating
    (this behavior change fixes [2])

 4) svade && svadu
    use exception mode, but also provide {m,h}envcfg.ADUE,
    allowing software to switch to hardware updating
    (this behavior change fixes [2])

Fixes: 0af3f115e68e ("target/riscv: Add *envcfg.HADE related check in address translation") [1]
Fixes: 48531f5adb2a ("target/riscv: implement svade") [2]
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  3 ++-
 target/riscv/cpu_helper.c  | 19 +++++++++++++++----
 target/riscv/tcg/tcg-cpu.c | 15 +++++----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e5eef3a4de..7598daa162 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -960,7 +960,8 @@ static void riscv_cpu_reset_hold(Object *obj)
     env->two_stage_lookup = false;
 
     env->menvcfg = (cpu->cfg.ext_svpbmt ? MENVCFG_PBMTE : 0) |
-                   (cpu->cfg.ext_svadu ? MENVCFG_ADUE : 0);
+                   (!cpu->cfg.ext_svade && cpu->cfg.ext_svadu ?
+                    MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
     /* Initialized default priorities of local interrupts. */
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d462d95ee1..c994a72634 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -907,7 +907,9 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     }
 
     bool pbmte = env->menvcfg & MENVCFG_PBMTE;
-    bool adue = env->menvcfg & MENVCFG_ADUE;
+    bool svade = riscv_cpu_cfg(env)->ext_svade;
+    bool svadu = riscv_cpu_cfg(env)->ext_svadu;
+    bool adue = svadu ? env->menvcfg & MENVCFG_ADUE : !svade;
 
     if (first_stage && two_stage && env->virt_enabled) {
         pbmte = pbmte && (env->henvcfg & HENVCFG_PBMTE);
@@ -1082,9 +1084,18 @@ restart:
         return TRANSLATE_FAIL;
     }
 
-    /* If necessary, set accessed and dirty bits. */
-    target_ulong updated_pte = pte | PTE_A |
-                (access_type == MMU_DATA_STORE ? PTE_D : 0);
+    target_ulong updated_pte = pte;
+
+    /*
+     * If ADUE is enabled, set accessed and dirty bits.
+     * Otherwise raise an exception if necessary.
+     */
+    if (adue) {
+        updated_pte |= PTE_A | (access_type == MMU_DATA_STORE ? PTE_D : 0);
+    } else if (!(pte & PTE_A) ||
+               (access_type == MMU_DATA_STORE && !(pte & PTE_D))) {
+        return TRANSLATE_FAIL;
+    }
 
     /* Page table updates need to be atomic with MTTCG enabled */
     if (updated_pte != pte && !is_debug) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ea763abb31..ccfb7b2dd3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -196,17 +196,14 @@ static bool cpu_cfg_offset_is_named_feat(uint32_t ext_offset)
 
 static void riscv_cpu_enable_named_feat(RISCVCPU *cpu, uint32_t feat_offset)
 {
-    switch (feat_offset) {
-    case CPU_CFG_OFFSET(ext_zic64b):
+     /*
+      * All other named features are already enabled
+      * in riscv_tcg_cpu_instance_init().
+      */
+    if (feat_offset == CPU_CFG_OFFSET(ext_zic64b)) {
         cpu->cfg.cbom_blocksize = 64;
         cpu->cfg.cbop_blocksize = 64;
         cpu->cfg.cboz_blocksize = 64;
-        break;
-    case CPU_CFG_OFFSET(ext_svade):
-        cpu->cfg.ext_svadu = false;
-        break;
-    default:
-        g_assert_not_reached();
     }
 }
 
@@ -321,8 +318,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_zic64b = cpu->cfg.cbom_blocksize == 64 &&
                           cpu->cfg.cbop_blocksize == 64 &&
                           cpu->cfg.cboz_blocksize == 64;
-
-    cpu->cfg.ext_svade = !cpu->cfg.ext_svadu;
 }
 
 static void riscv_cpu_validate_g(RISCVCPU *cpu)
-- 
2.43.0


