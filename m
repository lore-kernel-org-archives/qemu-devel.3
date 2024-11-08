Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221B9D5E13A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3o-0003mb-RP; Fri, 08 Nov 2024 01:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3n-0003lQ-ML; Fri, 08 Nov 2024 01:01:31 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3l-000830-Mj; Fri, 08 Nov 2024 01:01:31 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539e4b7409fso1897143e87.0; 
 Thu, 07 Nov 2024 22:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045688; x=1731650488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=iojRxKyVOQHZlwqBZ1dWJbW2SpzRwanOfr7K5MgHcj5BXLrY7BVez0ub9hFwwAczti
 z6JSpzqrw4qgfAc8FSF9SnJyaC9JgbonqdHeyCfQX6L1LIu/A7HD3JhpsoVFefo8eOa6
 Dvc2nnZ5iI6uHFJyIzss1WYpCxz5tIl+EckQ4cgk88a+3HdeyRzjBo1U6Mb/igu2/f68
 tq/0fzkLwlr/tuTXnnoqLjoppA4W5GW1D4py+0zvuEnQWppY/U8mnhHt2S6u5+6jTyj/
 b/NgpvPjKAN0qkeuZ6tY648SVKB8O8Jkl5A1wqEiqiwxH4lqDeSj2PScayEcbLVqg00N
 aPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045688; x=1731650488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=u1rA0CDpKtxHhrNWmc2cgnQK4lCDR/X6CXc1X6wWM+ZeWnqw9ivGkFp0McGuvJIbb+
 jnqnR/o9GssXuRO3KMMhgO/HE2aewONEL0n/NgsKj6+sW0ebi2kTuseJl6S7it0duR9N
 PLml1hwJXy/HVhV4C5Vw15hy/lp1TykaIBy1zpnIJmAaoO7JVM+vlV7L+8X2vqnKrmip
 7eKRqyBwJZ4uLbzvqP8U+kvCaorO4qVT8lrJBxSpgCfGJg2puTlnDeUcJnhsdva7dss6
 Kc2i5Hf4YD0xJnms2k3k56509ldtoPdqPC0CAjVVptMCMJ3phbQEEXJuF85Zh4wBLrS6
 GPjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+EMymPyW5h76dVk5CXJJ9wrfZNNxvhKDviHp5zUggWobEzI+xHHrx5voESJ0TgCEVwStahJMevh2UPA==@nongnu.org,
 AJvYcCUZqouK2fTO4t28tt6OORlcWFyzPyggrR2NBuTSRXvKQDZajvR5oAURGw0RD8sLgx7Yo1gQBFM3WPnd@nongnu.org
X-Gm-Message-State: AOJu0YwG0eUvwpOC/GGj0x8KvzIAiu+gekoSEUuJUBCfxBCbhDcoye+G
 ut8UfmUsiomvLObup2D6Tf8haUYe+a4674SfX9WcNritTyDAY5ME
X-Google-Smtp-Source: AGHT+IGGZQwVyCNPO3hZUeChFpyjQpy2HBCF0KLt6HgfEbfmb+AS75wHtjez46gGK77AWNdlAys+gw==
X-Received: by 2002:a05:6512:b14:b0:539:f922:bd3a with SMTP id
 2adb3069b0e04-53d85f23153mr586724e87.25.1731045687381; 
 Thu, 07 Nov 2024 22:01:27 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:26 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 3/7] target/riscv: Add helper functions to calculate current
 number of masked bits for pointer masking
Date: Fri,  8 Nov 2024 09:01:12 +0300
Message-Id: <20241108060116.37397-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108060116.37397-1-baturo.alexey@gmail.com>
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12e.google.com
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c | 74 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 417ff45544..74d7076f5a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 696a17461b..da2a10384a 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,6 +214,80 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+    RISCVPmPmm pmm = PMM_FIELD_DISABLED;
+#ifndef CONFIG_USER_ONLY
+    if (get_field(env->mstatus, MSTATUS_MPRV) &&
+        get_field(env->mstatus, MSTATUS_MXR)) {
+        return pmm;
+    }
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        if (riscv_cpu_cfg(env)->ext_smmpm) {
+            pmm = get_field(env->mseccfg, MSECCFG_PMM);
+        }
+        break;
+    case PRV_S:
+        if (riscv_cpu_cfg(env)->ext_smnpm) {
+            if (get_field(env->mstatus, MSTATUS_MPV)) {
+                pmm = get_field(env->henvcfg, HENVCFG_PMM);
+            } else {
+                pmm = get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                pmm = get_field(env->senvcfg, SENVCFG_PMM);
+            }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
+                pmm = get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+#endif
+    return pmm;
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+    bool virt_mem_en = false;
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env->satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env->satp, SATP64_MODE);
+    }
+    virt_mem_en = ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
+#endif
+    return virt_mem_en;
+}
+
+int riscv_pm_get_pmlen(RISCVPmPmm pmm)
+{
+    switch (pmm) {
+    case PMM_FIELD_DISABLED:
+        return 0;
+    case PMM_FIELD_PMLEN7:
+        return 7;
+    case PMM_FIELD_PMLEN16:
+        return 16;
+    default:
+        g_assert_not_reached();
+    }
+    return -1;
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
-- 
2.39.5


