Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB30D75BBF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0RJ-0004WK-Lz; Thu, 21 Nov 2024 01:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RD-0004Tr-KL; Thu, 21 Nov 2024 01:13:11 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RB-0006JW-PL; Thu, 21 Nov 2024 01:13:11 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53da5511f3cso464852e87.3; 
 Wed, 20 Nov 2024 22:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169587; x=1732774387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=mv8VcpxC3sobBvwXzFUbCKsYEqNtYXlVphkr6Zxq9La8L88CReAY1tvyCyjzuUgTc8
 c6h/yY9pUcn6Sb4KCfyZ7xE5vYh4EmxymwnW3y0cwWAo03CJx4cVZwEtji4Gjyy/hlYZ
 V2rorsgPnRUSFenXIgHxkcnk70VP2aT5W5mW0si3T/n/2LFCR9VRC1bGW3Tl2LRbLu0e
 RU3SOZ5TEmKLNjvkgedw931D4b9OxICStlOix6hCprYLfQ2m6ro6Niexw/eWzvjnZdK9
 9cS5vPHWmAEF6aI6l7WvUb3ryRljlxKXFJqFd/ip9ElQST80PpHBvpI8Y32/RR4Mhd2k
 o7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169587; x=1732774387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=CFHDcon65M0dRcCAOCxv5/OHojnAgyKbUATPW1tVS6ZWEAj0e9FUdLkBvmxtA8P5bs
 l4UIsFPKh6cg2vRz5kocxI/A0DwnXztwL8o0WBXFkXT4PqhXcT0pakD5uQczUmA/bOgS
 OJqyI+vBgEiXB1p4AhO+zwR6GiGxY8n+LdHcL4ME+g39j1rO5pk+cNG0DUDbwsb1ew1K
 T0R9PPIrDbVmhgfJlYQMgwY2XOpQW40NFqsyrxUMuwntkNKBlV6+C5N0+TUwRVs8KmAh
 ez5zU+dc3K3yg3tIwCMBvmbCU6+r3aEnmZLSKTNeI4wI6cnrbro/5C40ARlm3W7LlRCv
 xI4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmMVB2TU1bQ0yMD3Xja0coH7jpS4IDcFuJd3vCXdkq2DdKrhJ6pBHbkM/EK+5Ai8Ruh31s+6c0gH7QLw==@nongnu.org,
 AJvYcCX1QvvrLtrw7HRxnTPORbjJ/u1Nksvay3W4juPblcvtjbb+iuHLXqQrwl0y1mSItQXZvHLm9B4+7gEX@nongnu.org
X-Gm-Message-State: AOJu0YxNP4khBa+1lEJ+enPMYjwYP2ydGL91x2FhMn+7O9heZ+TW7Pvi
 mXCTyoZ3pKgvoimtYLcStyQec1JeArY26c3y2bEjRVYGhZm6N6dX
X-Google-Smtp-Source: AGHT+IHMmbNyHlVSjuUSR+t9o4CoQKnE37K1cJ+3uOfgvMHbuWD8cWCc5CFL0cKjnSk3DncCIS96eg==
X-Received: by 2002:a05:6512:2385:b0:539:9490:7257 with SMTP id
 2adb3069b0e04-53dc13478bamr2370680e87.30.1732169587421; 
 Wed, 20 Nov 2024 22:13:07 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:06 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Thu, 21 Nov 2024 09:12:55 +0300
Message-Id: <20241121061259.4043177-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x129.google.com
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


