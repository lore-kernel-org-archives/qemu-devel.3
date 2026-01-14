Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9463D31A0D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 04:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfsp9-0007O6-CN; Tue, 13 Jan 2026 23:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoi-00074V-Uc
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:13 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1vfsoh-0004Ae-4m
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 23:49:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso55605905ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 20:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768366149; x=1768970949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZuF6YEIztB5mevIrTN7lKK2Hx7jAvfRwQrJI7h3suow=;
 b=Ij9hNqL1Fp+j7DOpEjhaqCtEtebgGTaBHAjPWdsWFs910vo8NoMEo11Fub7rWkzA6T
 Pok89PFFkACHWaZI164Vyu/8R4CNz9TeXXXChUjKSh4Hz0WoLmfLelxtqLIUa9DwjQOy
 aXe6ysPfdFaL62tih6xW+OqGkc7qrobqdGokn7ZzkGRm2zzLEsWnYdbryOblaKfHEvN8
 tH7Rc6RGDx6wYv1y/TwNw5eeGZV6/tchVNXXtmXitKq4ikK2Ecj3djgeNXBJkUMdRJiu
 Pdqn3oeS14imdijrCkj6QudnkqBd4D6i44o0xeHOBJYOBgZdosfOXmIFH9WHk+GdcvP6
 W5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768366149; x=1768970949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZuF6YEIztB5mevIrTN7lKK2Hx7jAvfRwQrJI7h3suow=;
 b=gqbXSm7ZdhS06pwaAtD34ssT/IAmMmoXpA1JVAbcgv926CY5SJb39Jcz8Bgfr8hjqw
 uEHVJu5fQoU+FgUnd/KF3SOA0VylHkVnAGunM8OSjQRXfKHfwDv4Il5nTxSiGfNwRSHv
 tpH5TVYpzsrszTBsEXqxkXduvfxVBz/8YQKjQ60zmoSiftno89kofaMsHocJd5EyiBiI
 xWUqYroNMMhtTuZX1OMGaOqiKML0M/GY2/EFwEzfe9DMAxaaiW5Eporq5V55aqmAG0M5
 jAqoW8hIx7WdDoNoOR1FXNTCN9ZZB6eEQ95fVEOWCEqhCR4MW24B33ao6t+cY8X5K5wO
 ww5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7YjOULxAY5wRwxfEMkzLuXd4/KSLRJ24gPCsl1JBptRQUreo51RPFflLQxlQsSGbwEASMzBal2qIw@nongnu.org
X-Gm-Message-State: AOJu0Yzr8KMR5LUFx4AcI/UC6wYqFOY6UYaL6mRODxkm1cg8+oD90I7q
 Fkwrrp2VKH+EEMrFX1vA5oaVbnP7FsIAG4T+gV4o5dCi8XOXomgKRkzg
X-Gm-Gg: AY/fxX4n7QNFu4alRSSQB/EKCn5Io3L0T7VwOq8Bt5bAbzTAdUzLEmmCt7r+KwSiGO8
 DetGMjvy4UqmoFB8Te5DAAkJPIDKVTmLHCrBLE+F95n39wK4PRcMSbenFGk6yOMiuMgwzP0CoYG
 38LV+23gdr6iQVfvboK2g0obRyDwn9ZqcEdEga2c1/jwOQQjNL00sbdG849u9G7brSALrOVPmEn
 wgocbAbSJt52HmbT7mkMY/gVlMf56L8dUJEvu/th0xRgbFv5KuZAthkBZ+9mOwFyYydhONP1rqQ
 yBAJrVLw4z2vJtlllxUlUnvgVaImfe52BzDJbAbHViXfWDIP8QF/l2Zu+/LN56H1nb8txam7fZg
 YbHJeUoiI6Ejd6eRluDxISYNunuYo5i7gwxwPfVTOKh7zLtmjSQCXPXeVwn39nLZAF6WBjULNRv
 3sccF8NRpCJW3yjmhL382dQCuFCUYAGkKv//EHkhkhiZS0TDmkt6P2w+z+wGo=
X-Received: by 2002:a17:902:f690:b0:2a0:8df5:2f6f with SMTP id
 d9443c01a7336-2a59bb2a4e8mr8344305ad.15.1768366149111; 
 Tue, 13 Jan 2026 20:49:09 -0800 (PST)
Received: from lima-default (123.253.188.110.qld.leaptel.network.
 [123.253.188.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c49037sm216111905ad.36.2026.01.13.20.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 20:49:08 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
Subject: [RFC PATCH 21/25] target/riscv/debug: Implementation specific Sdtrig
 configuration
Date: Wed, 14 Jan 2026 14:46:54 +1000
Message-ID: <20260114044701.1173347-22-npiggin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114044701.1173347-1-npiggin@gmail.com>
References: <20260114044701.1173347-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement a Sdtrig CPU configuration class that provides
details about the Sdtrig configuration.

It is stored as a pointer in RISCVCPUClass to avoid issues with
nested compound literals inside static initialisers with GCC 11.

For now, the number of supported triggers is configurable. This
requires some logic

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/riscv/cpu.c     | 25 +++++++++++++++++++++++++
 target/riscv/cpu.h     |  4 ++++
 target/riscv/debug.c   |  5 ++++-
 target/riscv/debug.h   |  4 ++++
 target/riscv/machine.c | 11 ++++++++---
 5 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 057e221808..6f7a327fc7 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "debug.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
@@ -2816,6 +2817,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             mcc->def->vext_spec = def->vext_spec;
         }
         mcc->def->misa_ext |= def->misa_ext;
+#if !defined(CONFIG_USER_ONLY)
+        if (def->debug_cfg) {
+            mcc->def->debug_cfg = def->debug_cfg;
+        }
+#endif
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
 
@@ -2951,6 +2957,18 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
     DEFINE_RISCV_CPU(type_name, parent_type_name,             \
         .profile = &(profile_))
 
+#if !defined(CONFIG_USER_ONLY)
+/* Sdtrig implementation has 2 triggers that support match, match6, icount */
+static const RISCVSdtrigConfig default_sdtrig_config = {
+    .nr_triggers = 2,
+};
+
+bool riscv_sdtrig_default_implementation(const RISCVSdtrigConfig *config)
+{
+    return config == &default_sdtrig_config;
+}
+#endif
+
 static const TypeInfo riscv_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU,
@@ -2968,6 +2986,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.mmu = true,
         .cfg.pmp = true,
         .priv_spec = PRIV_VERSION_LATEST,
+#if !defined(CONFIG_USER_ONLY)
+        .debug_cfg = &default_sdtrig_config,
+#endif
     ),
 
     DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_VENDOR_CPU, TYPE_RISCV_CPU),
@@ -2995,6 +3016,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #else
         .cfg.max_satp_mode = VM_1_10_SV57,
 #endif
+
+#if !defined(CONFIG_USER_ONLY)
+        .debug_cfg = &default_sdtrig_config,
+#endif
     ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_MAX, TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 44ed1665e2..c4f1cb0a9d 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -571,6 +571,9 @@ typedef struct RISCVCSR RISCVCSR;
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
+#if !defined(CONFIG_USER_ONLY)
+    const RISCVSdtrigConfig *debug_cfg;
+#endif
     uint32_t misa_ext;
     int priv_spec;
     int32_t vext_spec;
@@ -666,6 +669,7 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
                                    void *rmw_fn_arg);
 
 RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
+bool riscv_sdtrig_default_implementation(const RISCVSdtrigConfig *config);
 #endif /* !CONFIG_USER_ONLY */
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 22f7958a79..93615b43fb 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -173,7 +173,10 @@ target_ulong tselect_csr_read(CPURISCVState *env)
 
 void tselect_csr_write(CPURISCVState *env, target_ulong val)
 {
-    if (val < RV_DEFAULT_TRIGGERS) {
+    CPUState *cs = env_cpu(env);
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
+
+    if (val < mcc->def->debug_cfg->nr_triggers) {
         env->sdtrig_state.trigger_cur = val;
     }
 }
diff --git a/target/riscv/debug.h b/target/riscv/debug.h
index 8a047c8073..3ba12f95cd 100644
--- a/target/riscv/debug.h
+++ b/target/riscv/debug.h
@@ -135,6 +135,10 @@ enum {
 #define MHSELECT_IGNORE       0
 #define MHSELECT_MCONTEXT     4
 
+typedef struct RISCVSdtrigConfig {
+    unsigned int nr_triggers;
+} RISCVSdtrigConfig;
+
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
 target_ulong tselect_csr_read(CPURISCVState *env);
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 23a5f60d2a..9f65bdca9b 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -221,10 +221,12 @@ static const VMStateDescription vmstate_kvmtimer = {
 static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPURISCVState *env = &cpu->env;
 
     return cpu->cfg.debug &&
-           env->sdtrig_state.mcontext == 0;
+           (riscv_sdtrig_default_implementation(mcc->def->debug_cfg) &&
+            env->sdtrig_state.mcontext == 0);
 }
 
 static int debug_pre_save(void *opaque)
@@ -277,15 +279,18 @@ static const VMStateDescription vmstate_debug = {
 
 /*
  * This is a newer version of the debug (sdtrig) state, required
- * to migrate hcontext/mcontext.
+ * to migrate hcontext/mcontext, or machines with non-default
+ * sdtrig implementation.
  */
 static bool sdtrig_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
     CPURISCVState *env = &cpu->env;
 
     return cpu->cfg.debug &&
-           env->sdtrig_state.mcontext != 0;
+           !(riscv_sdtrig_default_implementation(mcc->def->debug_cfg) &&
+             env->sdtrig_state.mcontext == 0);
 }
 
 static int sdtrig_post_load(void *opaque, int version_id)
-- 
2.51.0


