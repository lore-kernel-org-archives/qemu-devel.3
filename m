Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA954C98313
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxub-0000q4-22; Fri, 16 Jan 2026 23:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuZ-0000oN-8A
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:43 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuX-0001a8-FE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:27:43 -0500
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-c56188aef06so1118043a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624060; x=1769228860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAcboXIAREJxPB/lIeLJMYJ+7KUtxCxq2AfKGjB1mbk=;
 b=ZgcOz8I4BxbZbZVmsfYyaA27vLXR1kCUjxJFZVRI1FFD8Pw6RjbpjbAQ64Ts/Zu30g
 8k2vkmVuNZJXPynOrJjuX8Xh52GT9IQdWVGc8MxQkULbe8+ndp7jYUPbX1cz2y1atuUL
 0ocPDvi0/T1WOaQAAXHPBTI1x1FxYequJGhlhsVKRxiwOiONf2eYbjJrOyLKyTgotx2c
 XR833aiq4zFBGMfTQrIL78bC7g+VPKhjA60qb+Fhq2JNkKTT+tBBTKzyuOB3anU3luUH
 MUyLF8SOoAm5WAVYoEHoPCcstsB8E759dDG/n6v/tC6snE1oWLRRP5bcf/cZYLWDHiWL
 meyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624060; x=1769228860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JAcboXIAREJxPB/lIeLJMYJ+7KUtxCxq2AfKGjB1mbk=;
 b=lUfEKSr7QISgFwR/8JZoEoxotWYUJoioc2QoWxsY7NZB20fcGq6/L21RvrQznx9zug
 Kgf3Mx8ff/PkyuPzt4OWa6nwSQIxCyGPyWDWX4t8wjYVCVNLpuI6H9JyEr9HBq9mkr8v
 QHGQ52qSFacNw1/1IrtMD6Ezu1karJduSu2ZpuAcmNreAw+42bERXAQRhwe/pwT0RiKw
 djeeBS11fMD6M+yJ8cL02/B0vj7SB+3eR/ccFyXvqAtAp1DlYg7LubOE+WAtNWiU9VBC
 7EbBdCgGqqMZ2p2xsSAkk/pPUF6rkRdOnu0Yuz5qngf2Zy+zed1Mw8TaZOtD2keKoct1
 FJEg==
X-Gm-Message-State: AOJu0Yzbb24V6pDMtKlyEEnWXzWBV8lPDVj+QUyHv1jk31OLov3zkXGo
 QMA2WEU6XrhAQiz99QU/2ucUmT4DVi/2ZaodLfiiSlh6cxklcLFpu7h2
X-Gm-Gg: AY/fxX7Ji9j9+tZjz5R0sm6+8vussYx5qyhJLA8QbgYUtiqCqQltx2daH+zhTb4M3Cv
 6HtoKs3/tnz5gYYh+viWs/XZb8jKIuPAwgzBjDlZTrpPovBuuUYaxrpcvGcPTbMc2Uu7bT8anbM
 IH5/dBQBvxk7+RtYsyUtG+oWb9fk/8DC+/22MRhhYM9VvnS0MRFCNarg+Sq8mNIQcHbNiHT8qoN
 LgYB/k9iqWq7EpQ5AOc62NI7bIPLjEj1uYJDngwQPRAdjYzIIOPsAdltdCrC8NrBEQ2DutkNLz9
 QmZ8Z9Gs/JZZuyH50qPYjrmOqNajKNzb0hg2YE6Rz//HjxtRlLjq2Dh7QVmmqYbFxqMkGD49pcA
 ryBZeS2HZEaKhP5ZPMIeJVTh3oZYQDIewwgcR5j4+t9AE+YKrop4w2fvEO3GX464f2UqqVoIzrm
 i7igy+yd4EUb7RRc1Vab5zESPCLkrZm3AHrDEQ63D0Pbz2d/uKIvQ2HUEy2NH5RA==
X-Received: by 2002:a05:6a20:4322:b0:376:2a3e:e758 with SMTP id
 adf61e73a8af0-38dfe60629dmr5904323637.28.1768624060087; 
 Fri, 16 Jan 2026 20:27:40 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:39 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 1/8] riscv: split sdext and sdtrig config bits
Date: Sat, 17 Jan 2026 12:27:22 +0800
Message-ID: <78122e119ee8c961716e2bec72c9895148b04ef9.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x542.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add cfg.ext_sdext and cfg.ext_sdtrig and expose them as ISA
extensions. Keep the legacy 'debug' CPU property as a global kill
switch and force-disable both when it is off.

Trigger CSRs (tselect/tdata*/tinfo/mcontext) and trigger setup now
depend on ext_sdtrig instead of cfg.debug.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c                | 18 +++++++++++++++---
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/csr.c                | 16 ++++++++--------
 target/riscv/machine.c            |  4 ++--
 target/riscv/tcg/tcg-cpu.c        | 11 +----------
 5 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..bc0b385cc1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -189,7 +189,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdext, PRIV_VERSION_1_12_0, ext_sdext),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
     ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -783,7 +784,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     env->vill = true;
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 
@@ -922,6 +923,15 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
             return;
         }
     }
+
+    /*
+     * Keep the legacy 'debug' CPU property as a global kill switch.
+     * If it is off, force-disable Sdext/Sdtrig regardless of ISA strings.
+     */
+    if (!cpu->cfg.debug) {
+        cpu->cfg.ext_sdext = false;
+        cpu->cfg.ext_sdtrig = false;
+    }
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
@@ -946,7 +956,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1112,6 +1122,8 @@ static void riscv_cpu_init(Object *obj)
      */
     RISCV_CPU(obj)->cfg.ext_zicntr = !mcc->def->bare;
     RISCV_CPU(obj)->cfg.ext_zihpm = !mcc->def->bare;
+    RISCV_CPU(obj)->cfg.ext_sdext = true;
+    RISCV_CPU(obj)->cfg.ext_sdtrig = true;
 
     /* Default values for non-bool cpu properties */
     cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc79..9701319195 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -44,6 +44,8 @@ BOOL_FIELD(ext_zihpm)
 BOOL_FIELD(ext_zimop)
 BOOL_FIELD(ext_zcmop)
 BOOL_FIELD(ext_ztso)
+BOOL_FIELD(ext_sdext)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smstateen)
 BOOL_FIELD(ext_sstc)
 BOOL_FIELD(ext_smcdeleg)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 5c91658c3d..4f071b1db2 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -775,9 +775,9 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static RISCVException debug(CPURISCVState *env, int csrno)
+static RISCVException sdtrig(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
@@ -6308,12 +6308,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                          .min_priv_ver = PRIV_VERSION_1_12_0           },
 
     /* Debug CSRs */
-    [CSR_TSELECT]   =  { "tselect",  debug, read_tselect,  write_tselect  },
-    [CSR_TDATA1]    =  { "tdata1",   debug, read_tdata,    write_tdata    },
-    [CSR_TDATA2]    =  { "tdata2",   debug, read_tdata,    write_tdata    },
-    [CSR_TDATA3]    =  { "tdata3",   debug, read_tdata,    write_tdata    },
-    [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
-    [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
+    [CSR_TSELECT]   =  { "tselect",  sdtrig, read_tselect,  write_tselect  },
+    [CSR_TDATA1]    =  { "tdata1",   sdtrig, read_tdata,    write_tdata    },
+    [CSR_TDATA2]    =  { "tdata2",   sdtrig, read_tdata,    write_tdata    },
+    [CSR_TDATA3]    =  { "tdata3",   sdtrig, read_tdata,    write_tdata    },
+    [CSR_TINFO]     =  { "tinfo",    sdtrig, read_tinfo,    write_ignore   },
+    [CSR_MCONTEXT]  =  { "mcontext", sdtrig, read_mcontext, write_mcontext },
 
     [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
     [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 18d790af0d..d6a0b8e357 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -222,7 +222,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.ext_sdext || cpu->cfg.ext_sdtrig;
 }
 
 static int debug_post_load(void *opaque, int version_id)
@@ -230,7 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
     RISCVCPU *cpu = opaque;
     CPURISCVState *env = &cpu->env;
 
-    if (icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && icount_enabled()) {
         env->itrigger_enabled = riscv_itrigger_enabled(env);
     }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index d3968251fa..b5a26cf662 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -177,7 +177,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if (cpu->cfg.ext_sdtrig && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
@@ -469,15 +469,6 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
                 continue;
             }
 
-            /*
-             * cpu.debug = true is marked as 'sdtrig', priv spec 1.12.
-             * Skip this warning since existing CPUs with older priv
-             * spec and debug = true will be impacted.
-             */
-            if (!strcmp(edata->name, "sdtrig")) {
-                continue;
-            }
-
             isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
 
             /*
-- 
2.52.0


