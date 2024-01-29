Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CCBC48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDP-0005m5-Do; Mon, 29 Jan 2024 14:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDH-0005jj-Oz; Mon, 29 Jan 2024 14:22:36 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDF-0002e9-39; Mon, 29 Jan 2024 14:22:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33ae74e5394so937942f8f.3; 
 Mon, 29 Jan 2024 11:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556151; x=1707160951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbX4+ybdo/OyShd/5+DAyR8pqK7OrIHy9zKIt9Znd6Q=;
 b=lYffLFdyu8TLRPV9FRyOZnKLUquLsqZ1GlEvyq9su/VScqv4++dL/xM3vSFEGxMizV
 yD46okRJ1urhNm36vpCT69WWIaFr49DzZF6ZY3ul0HDF0NgSAU5JbBHkDnuNs7e2h9IB
 DR/AfOgO/jQqoVPZZpHHGaOxiu9lXXriK0tL3sFcdAOYfRgqludASbqonDYTRINjbxTh
 ml7niimYAryJN6wvb2F3+2rTn/FNbra3sn2hkRoAoqlrfoWCyfWXJ3WlgaNWyZ0Kd8Ec
 W7f8EmMHG15zeo0c+Jju7SZI6I0XfZDB5BdRROsbgiPmTuLFAS4gdhPoCa/EqA1wZSnu
 UGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556151; x=1707160951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbX4+ybdo/OyShd/5+DAyR8pqK7OrIHy9zKIt9Znd6Q=;
 b=nypkQ7/iU+XlKh+EyhKOoP8Co/ongyr+FzlnW10YeNiJ/W7JNO7werln1ZoA4uLsMQ
 SEeFFnTPRuizYx9lWDfhfGDGua1P4KqTLt1f8veoaLUi7rd8Qb4FESaSHLZj9qf+k/P2
 66DBvKYBVuKZSTm1m2YgLbydnmRMNlIBKYMcmuf5pSzU/lkF3uGFKwKXn0lURE7eN5eZ
 Z4imGyYTjhhuS0RL2RZSLIb6QxFi9KOCxT2wbs+Q1abKOGEj1SXsW6i9DiIkaxloQqAR
 s250i9RBcASIllahIqo8qFppAxsqgjPLXg5NWAc6xlCej8SwvD7VeXYa2CQoUCSbyGGO
 WsAQ==
X-Gm-Message-State: AOJu0YwgSxg96AUwZsygpTS+2sjrKCSxAagQ7h4n45tHb7wYn7p+7x0E
 KQcfQlfRFap2zq/F9cQ3kM30eoWpApTxauCn4n9qp7kpgfZs+i3h
X-Google-Smtp-Source: AGHT+IHL0uFsV9N1cVkQGlkjdOhrhruaSZHvgtIdpMeED7YyPmUlkaDoeWyZ0g2tvdrzU/tYLK1Ibg==
X-Received: by 2002:a5d:6485:0:b0:33a:f5bd:2cf4 with SMTP id
 o5-20020a5d6485000000b0033af5bd2cf4mr1079241wri.58.1706556151195; 
 Mon, 29 Jan 2024 11:22:31 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:30 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v5 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Mon, 29 Jan 2024 19:22:04 +0000
Message-Id: <20240129192207.2946870-4-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
References: <20240129192207.2946870-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.h        |  4 +++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c9bed5c9fc..1c8979c1c8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -671,6 +671,10 @@ static inline uint32_t vext_get_vlmax(RISCVCPU *cpu, target_ulong vtype)
 void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+int riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a3d477d226..9640e4c2c5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -139,6 +139,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+    int pmm = 0;
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        pmm = riscv_cpu_cfg(env)->ext_smmpm ?
+                  get_field(env->mseccfg, MSECCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_S:
+        pmm = riscv_cpu_cfg(env)->ext_smnpm ?
+                  get_field(env->menvcfg, MENVCFG_PMM) : PMM_FIELD_DISABLED;
+        break;
+    case PRV_U:
+        pmm = riscv_cpu_cfg(env)->ext_ssnpm ?
+                  get_field(env->senvcfg, SENVCFG_PMM) : PMM_FIELD_DISABLED;
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
+    /* Get current PMM field */
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
2.34.1


