Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E92CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 03:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS4Ya-0003t8-To; Tue, 26 May 2026 23:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wS4YX-0003sW-HM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:03:42 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wS4YT-0006x7-P5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:03:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-369576666d5so5420428a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 20:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779851015; x=1780455815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w8Mnvq4YXXdp6FicaglW0P+r4r0ymZQMV2gBaPgU5EE=;
 b=F4/9864VMtDrwEg4HHdGpZMHQfrrBurkiAhOtIUk9U55rz5zoMN3XoihPmWRbMUmgg
 MDyJ6EehNHvM2ZmQ0otbtRAKXHjsaxQNur3+Y9I+TitRM1W/bFyybmdYokqtJXRGwqN4
 jR4GPIBDwma1Nq/lrTfrOxciJu+o57ORlZe5OccKcgf4diaW/Fcy6LCwGAffGjB9+ME2
 Bt2VBzJFUFDK4CaNFffR7aJ/+s71jXRZwAvDisvH4EA5UUsRxmp7nqRD1lRCZdZwXDDJ
 EgH0uQhvGx4QY7Qvb8hXvEOs/8lWEjhwEAtvUEP0FUjGU/NjnzyRvBv96F1Yw0Dti4wS
 uYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779851015; x=1780455815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8Mnvq4YXXdp6FicaglW0P+r4r0ymZQMV2gBaPgU5EE=;
 b=N501ifX6A4QH9p2kOvvGm+I9topjSiYIXEctwXCQ29JgnM4Vscf0H9R2qIdiLtnSh8
 lT2IIuGKf+HpYkx/aCZKop5cW+Nvkx8VCXXfFfwe4O6yKj9aUdJF/4rCG0o+sZX94kzY
 DD8jRa2THrC2CtCOXO0En+B5wufhlYj29jy+59xKkDe/dYyd+wVn89SCjw1MkOamcFJR
 xOQ/NOvnrieN2RPwuZHCqBalfEmbmVzTm7eCcRQpamVMdmZfpiQmA8NmjFxrr7G4k2Nl
 dI3bEVGFWeGlmZzi3QeNjh8lAhbcwneCiUx4QPVKy9RT3/svPKK6W9ZHOkk0R4ICK0e3
 IbqA==
X-Gm-Message-State: AOJu0YzOUmapOk0M0mVtNxx3E6sMNxIqiQHNnLdG0rHe8+UXBncFABzM
 jfCgwDTiVadhyGk3Dt+leLQDWl2yDHfEdaugP9I1O1aNKc5wpYXZwTDNfxe2GDmq
X-Gm-Gg: Acq92OG8/zs63Y5XQKRw6ve35R1pbgCDKSpbP9jmLaXdbmGHZgpspDMBHYX1njESmyC
 4hbuaxmhJFgrIcRL50S6jzP+bch3kpI1ov1k47OATnO2Yy2meET14rANlHaJvvufZsgAx3IWQ1k
 b9XCYbjHvbH0qDJqsFHtW2wDsk1jV1ImT3dnAdBn+cwDBcNfw2G0iLKF3nm4NShGFpOQhA5Hjc7
 Pk6p44nzV/5pbi/6+RDVL1Zbm/UuisjffEBmxFH0dkZ6eIr+x3UCNfo3XJaOgOf3uUr/ZOuvMzh
 vyGm6rDEXSA4y4LklKvcqW6SsfXg82hmek9iPoCKsirbZHD+hpK47VS4HXhyiER+XdpdqVRQg+x
 FnFy3CnkRfeHO11gA/mof6t0uzDuyVmCA59tFv9L9cr6NMuLn2bQXdM4EkNgKNP7ol1JKytoD/S
 xxFbck32nfn9vxasL+Y+jou1XVKc+ZGzmt7bT720OxXTLikMPDkP7TvOa98fh0UGodT1boM+BwS
 mfbSRo=
X-Received: by 2002:a17:90b:38cd:b0:369:2e00:1ff0 with SMTP id
 98e67ed59e1d1-36a6749e96amr20166917a91.6.1779851015096; 
 Tue, 26 May 2026 20:03:35 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852056dadasm11137984a12.26.2026.05.26.20.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 20:03:34 -0700 (PDT)
From: stephensportia@gmail.com
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Subject: [PATCH v2] target/riscv: Add support for a custom CPU arch state
Date: Wed, 27 May 2026 13:03:27 +1000
Message-ID: <20260527030327.2289-1-stephensportia@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=stephensportia@gmail.com; helo=mail-pj1-x102f.google.com
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

Custom vendor CSR implementations may require custom state information.
This adds a custom_arch-state struct to the CPUArchState. It also adds a
RISCVCPUDef function pointer for handling allocation and initialization
of the custom_arch_state as well as a reset function pointer for setting
the custom_arch_state fields to known values on reset.

Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
---
 target/riscv/cpu.c | 15 +++++++++++++++
 target/riscv/cpu.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..ca557d27b5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -819,6 +819,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
+
+    if (mcc->def->custom_arch_state_reset) {
+        mcc->def->custom_arch_state_reset(env);
+    }
 #endif
 }
 
@@ -1167,6 +1171,9 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->custom_csrs) {
         riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
     }
+    if (mcc->def->custom_arch_state_init) {
+        mcc->def->custom_arch_state_init(&cpu->env);
+    }
 #endif
 
     accel_cpu_instance_init(CPU(obj));
@@ -2706,6 +2713,14 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
index 7d79c7a5a7..8132c65012 100644
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
@@ -509,6 +512,8 @@ struct CPUArchState {
     uint64_t rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    const void *custom_arch_state;
 };
 
 /*
@@ -561,6 +566,8 @@ typedef struct RISCVCPUDef {
     RISCVCPUConfig cfg;
     bool bare;
     const RISCVCSR *custom_csrs;
+    riscv_csr_custom_init_fn custom_arch_state_init;
+    riscv_csr_custom_reset_fn custom_arch_state_reset;
 } RISCVCPUDef;
 
 /**
-- 
2.43.0


