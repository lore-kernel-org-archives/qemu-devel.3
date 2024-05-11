Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D128C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhH-0005UH-1m; Sat, 11 May 2024 06:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhF-0005Th-VN; Sat, 11 May 2024 06:11:17 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jh7-00029u-LJ; Sat, 11 May 2024 06:11:17 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a59ab4f60a6so610761666b.0; 
 Sat, 11 May 2024 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422268; x=1716027068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0m567lbtMWX/Xqv2X9vHS/gn97bjDpzEPZiou0M2OMo=;
 b=SwUrSPHI7dn1kPj2pTjwdepYecQ45MLsgvZ4TWgI957SYWiVIgiuO3LkTeLwQZJ6HR
 f/5tvlC9ezVKMWiTZMwwT12exlk/DI3zm2N7/R+8B5Ii8zvMIuer+78/x7P8pJAtg1Bo
 zYggYZCNq2BorwEDgHggMI6aAJ1ETtRJ3xstgGNeSmWkN/Q34lL6uvpgHtUWW/xvhYek
 qsne19AoPG2/VRTVjY8lkR/QCJiDW0hEvbmFBp0ibeSTV+5FAMyaRIBjMyQIdvpITOaY
 m1Ng/dWVFkVuzhqB7YTMCatJQhYwmKCHdRNXfEQ9sZN7DyMdoj/2BJYPTLmpOn1h3k9L
 D/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422268; x=1716027068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0m567lbtMWX/Xqv2X9vHS/gn97bjDpzEPZiou0M2OMo=;
 b=EYGoC6uOilNcCfqAydwzRiqBblQXxzG0MgNOXD6Sq9Gie9EcDL6ab2Z1NMRcvHCkhr
 Dd2D2s7ZYrDqB5r5Q7g8lo/xRRcFxqF3P9lKkZFrI/2FjT00Pj298nKJ0D8syf/qvObB
 cLFOrgGk3Bg5+K2UgYJWQ/U0/CRxOdgYzvRgU5PmAbflb/xJl0dakGKqTivVJQpus5hS
 Z41F5t2b1RYt1WD86mcJrsEjp9TI//qYNhUNvmRwINlM+ena4fAnTVtv7Cz9kTlCx/XR
 r/1cySv4HhJQufcpPrT6zhcdZddUBnnYtEkEfZLe5++84afMsIKACaaduLMduajgOwZB
 MQrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ6+eRJupRc+iU0AhLR8/2OFZECD29Bv46FZ+RIwHV2yzJ0ifyEAfjushYGFrWk43Fr/CtDmTnVQmahJcF1JhVfwxjzSZU8lVVaGoPqVh/22BQhTis3iFxO9at5g==
X-Gm-Message-State: AOJu0Yzu1NGNHZLvPLgtCzfHlIDNQOohQ83NrtviSSrIztlJU9u5nuEf
 MHLHOHQpWgsw1QqWfoiQgxnH9jXfZeiecAhxU2nD4rFJN45JvA7z0zNPYoZC
X-Google-Smtp-Source: AGHT+IFdT9cDLFVcHRNlQvygTKU4p+sq3M83Z3ao/UmmHiGvnpCgM7fX0OLI7QzQIeaxd4GOm2wFeg==
X-Received: by 2002:a17:906:af0c:b0:a5a:2737:a3e8 with SMTP id
 a640c23a62f3a-a5a2d65989emr483784466b.59.1715422267704; 
 Sat, 11 May 2024 03:11:07 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:07 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Sat, 11 May 2024 13:10:50 +0300
Message-Id: <20240511101053.1875596-4-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  5 ++++
 target/riscv/cpu_helper.c | 58 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 52b6ba73c8..9cac723b19 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -698,8 +698,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
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
index bf58350669..e4a127ca84 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -142,6 +142,64 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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


