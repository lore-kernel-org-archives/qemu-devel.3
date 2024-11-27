Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413FFD609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAiE-00068E-E8; Wed, 27 Nov 2024 00:35:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiC-00067k-5A; Wed, 27 Nov 2024 00:35:40 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiA-0000mP-G5; Wed, 27 Nov 2024 00:35:39 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53de771c5ebso2831295e87.2; 
 Tue, 26 Nov 2024 21:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685736; x=1733290536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=l6g8pgwpAsJO2EpNhsOeIDzvcO+0JYIhO836k5Vwr7UA03XMJuZdxul9WvvuS8YIbF
 aDsjVnXW0/wVVn3Qr6s33xKVBarRlHDzSCVmSmb52tK3866+PbI5zPTp1ct4O2NmHREc
 0R4aD3tURgEL14xEht5q+tXXMHYgMMVYaptduu/zMgY6Qlt9HXCK46x+dnO6qxMK96dj
 k5svEwooaKk+FFh/XZqoH7dKCY2cS/DKm9teKtLSSKLaeTKieZRK2FPDcI6abrphECjR
 rKv1TzKkKgc0yYLfrvypFC9C/Gl1C7OxHwkxwyS0uzKfqt2gfvpo78m1c0TQ4UWwGN0j
 dzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685736; x=1733290536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykBzviCP/aURtQhEtJqMDZCa/NEjG4aKeixd/MINorw=;
 b=QvCT2xMuvsSzA5GcZ0RNksC6uh+Jt/8co0WnFkRrbjRevKHDqFXVaC2uuaLL6oXvRC
 Hy9H2yHqGjzW4y3U23zitTEBTHvH7aTw8yAUeZFCN6LUr7KfrFw3FvSNZsfhQCew1dA4
 gLNpPWMMcDjKrxZa/4ktLKrjN4PMxS0b8+hO+BNdqlqpPCyrhkVov39I0j6IkgUEpiBN
 4BfbP2oxWk2FCmP2PpmTNQGmhtEaLeCpeuYtctjNY8DxIuenyvhhkn6QMtljCNJWwzGQ
 M8CZNvuTmGJbCGhXcDvWcCpxRTiJq7e9njxi45P4SlrGDgWRxk5BUBzyiATS7isUh8/x
 G8Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYhwxwNwbzl04Jxp3ZDcJUbQL4H0tqaJ2EAZYCLyzjMJL891wOZEzmEMLMM2dcUD+oA0xUKZrr96Qw@nongnu.org,
 AJvYcCXn0wG/k/5PrBBNYQse6Fj0hiweqFmR1oQ1CWnxX8wK98MoC4twGnQTP209lfWhlBngNKWvnNT1EIlAmQ==@nongnu.org
X-Gm-Message-State: AOJu0Yz0VdLs+Hlmf3Li57Us0bRvmLl9HnlhXDITPxnsY1pwLb+YszF0
 LXjHvV/BaSrA2fc98smm3ehEdxQTL3rMFtd9OcRlCQ5Sh+9D2gPh
X-Gm-Gg: ASbGncv22UxR7styiY6EQ4yuvho5WdhDyDjpTT+RNirZDR+TGemgTwHWdnRIUiKNf6r
 MWb3trkVTM2LK0bJrPc03HEtwN9l5+zkDF37KMp6m4GJvtQgfJJEicgzFhNGTWJliZV9L6cKshx
 IBwkRO89wnV1bhKegg9ageLRqukzYRO9WVntQ5PtbTSfr+9CNeerYe5pCCOmP1iNFvJIYfBiZ10
 sTAW5w0xTQKINScMYvsIdKTLtKQ9R5R9XvrenhaRw9SCW2ruB3wcuw=
X-Google-Smtp-Source: AGHT+IHZACi/9+ri871493qfx5fLLXc70Ak75T0XAOl/CC7oeqD8xLZk6yEjI+iEeJYYjdzmb4vbww==
X-Received: by 2002:a05:6512:33c8:b0:53d:ed47:626b with SMTP id
 2adb3069b0e04-53df01046d0mr683478e87.45.1732685736315; 
 Tue, 26 Nov 2024 21:35:36 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53de0c3ce8bsm1211799e87.116.2024.11.26.21.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 21:35:34 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v11 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Wed, 27 Nov 2024 08:35:19 +0300
Message-Id: <20241127053523.397378-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127053523.397378-1-baturo.alexey@gmail.com>
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12f.google.com
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


