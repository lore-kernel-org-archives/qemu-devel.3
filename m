Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E088ECD5BDE
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRorL-00062P-4f; Tue, 26 May 2026 06:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wRor8-00061V-SD
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:17:51 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wRor4-0001zl-C3
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:17:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ba856db1c0so76255965ad.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779790660; x=1780395460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i6UQMmjJXOvMiIkOKCXgigHHPVp50+pBNbNSrVzCBeg=;
 b=oeLSPmE4nS5/I29R2IHKW2BJMq0nG0bqXc998bcZujzo/6C3gORKWiyjebcuozWTKw
 28NimS9hKQ4ubDrX9D8tIwnz/q8A0KV7vqGiVZoo9lviGqyOw5SrBlE6lxixh9O1q+QC
 cN/fY6gENlW9yacb4Sg6U5sxmETd/oMyOX0yaAksj8V2QKOlXgHbK6Q5BYkgwobk7jwV
 zAAA5/KoBedSBphQhV7V9BmV8wtOqIWaEz7ea0COwMg+46rVeRzM5JB+n5BnNtKadkop
 jjQDs4E0ZXuTtoYZ7r9yyKRLHxgCIUHxqIzdFSDT+TPGcMFdoiVfVOLH0mXeVxn04BkM
 5JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790660; x=1780395460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6UQMmjJXOvMiIkOKCXgigHHPVp50+pBNbNSrVzCBeg=;
 b=EOwN1VsKQT5vhkiYI2q6Fl4+JjwJTifB7INC+zmG3G2cfqLCKlfkEaaHuYtDpbSfzG
 p34r983qRScSRIxGGo1kE3SiE7rT6hEdsqRAvoYxC9BtHmuAQ+GNV1GRYhIqc3pzAiXH
 3RMaLGxoMEhCbzoImqyroflM7n6SzYT+8Sz6djyJUid5aZ/BBV9IzH1p+/4yoFHnotcG
 4hzVHIDD1JUMq1A+oK+VxVntDU8zMPgJHEx0lSM4giorHyjFz6QnL2gABNcW/lSDy7Ou
 5nLqSBlUj7n5xqzHPMr5xT8gay6vTTG2oOUW0xgVfHzvu7ohNzWNZkWW32Rft8kmtO4a
 AgnQ==
X-Gm-Message-State: AOJu0YxQHgYxxr0y3XZgbgKiczdD3x8urbnEb67OyOtTkKCXO1m8kUkb
 WrbMbKayV2mhgunUS6fgetZEDRDiAjmzNO+HIwh7joknAGsRj+wClDGKuMQLKS/M
X-Gm-Gg: Acq92OEVpLkUD9Xigush+ivIbR5PdCyZYEgkAk4R1N6/7eVQPEU47lIu89SF1z51S16
 gDiJPhILmjFYAY03RGH7/BnQGVnrl5El2F4D5ThMl6L7jSku+c5YZv3OjVI+CCW9V+zIPizKJCs
 1RDOC80SESADfsbNjqdMuSwASbF5/lSJVtAIOyN9dfymNzqBD67uquDdfchdY6tFvnTBC7ec0ok
 p4Kij+PGC/GByGL82ZE6ikzg5se4Zk6LsPsVynOJJaBmN2kRY1yan/2UjODAXy1YqrJ8jojzf9r
 7mUoi6UDhj4qjcOTghJkAIeI5L5ghkJGNTegcSJPPCtgBAu34zz2OnRyqWGGfzGjgl+8QaQdUWe
 cxr8Y4pi5aSEf5g/+uOqvjUZ75wFINE83vbxYi1pTa59INWF1SJXC7SC9xr33yGgwlhzKjCMLlE
 ZdIDMXCqPOB50IKj0PT+hA35RKMXRSN+lOdJkcd43vxfMMtrNna3vStNsB5b+XEE40uZN+hCowe
 JXlRNQ=
X-Received: by 2002:a17:903:1b46:b0:2b2:81aa:f6c3 with SMTP id
 d9443c01a7336-2beb07378e7mr207604535ad.29.1779790660339; 
 Tue, 26 May 2026 03:17:40 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b386esm126286435ad.44.2026.05.26.03.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:17:39 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH] target/riscv: Add support for a custom CPU arch state
Date: Tue, 26 May 2026 20:17:32 +1000
Message-ID: <20260526101732.54144-1-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=stephensportia@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Portia Stephens <portias@oss.tenstorrent.com>

CPU custom CSR implementations may require custom state information.
This adds support for a void struct to be added to CPUArchState to track
this state information.
Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 target/riscv/cpu.c | 18 ++++++++++++++++++
 target/riscv/cpu.h |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..2e3acee76f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
+
+    if (env->custom_arch_state_reset) {
+        env->custom_arch_state_reset(env);
+    }
 #endif
 }
 
@@ -1167,6 +1171,12 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    if (mcc->def->custom_arch_state_init) {
+        mcc->def->custom_arch_state_init(&cpu->env);
+    }
+    if (mcc->def->custom_arch_state_reset) {
+        cpu->env.custom_arch_state_reset = mcc->def->custom_arch_state_reset;
+    }
 #endif
 
     accel_cpu_instance_init(CPU(obj));
@@ -2706,6 +2716,14 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
             assert(!mcc->def->custom_csrs);
             mcc->def->custom_csrs = def->custom_csrs;
         }
+        if (def->custom_arch_state_init) {
+            assert(!mcc->def->custom_arch_state_init);
+            mcc->def->custom_arch_state_init = def->custom_arch_state_init;
+        }
+        if (def->custom_arch_state_reset) {
+            assert(!mcc->def->custom_arch_state_reset);
+            mcc->def->custom_arch_state_reset = def->custom_arch_state_reset;
+        }
     }
 
     if (!object_class_is_abstract(c)) {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7..77b513c29a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -213,6 +213,9 @@ typedef struct PMUFixedCtrState {
         uint64_t counter_virt_prev[2];
 } PMUFixedCtrState;
 
+typedef void (*riscv_csr_custom_init_fn)(CPURISCVState *env);
+typedef void (*riscv_csr_custom_reset_fn)(CPURISCVState *env);
+
 struct CPUArchState {
     target_ulong gpr[32];
     target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
@@ -509,6 +512,9 @@ struct CPUArchState {
     uint64_t rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    const void *custom_arch_state;
+    riscv_csr_custom_init_fn custom_arch_state_reset;
 };
 
 /*
@@ -561,6 +567,8 @@ typedef struct RISCVCPUDef {
     RISCVCPUConfig cfg;
     bool bare;
     const RISCVCSR *custom_csrs;
+    riscv_csr_custom_init_fn custom_arch_state_init;
+    riscv_csr_custom_reset_fn custom_arch_state_reset;
 } RISCVCPUDef;
 
 /**
-- 
2.43.0


