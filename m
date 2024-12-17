Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C016E7718C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOS-00068K-P6; Tue, 17 Dec 2024 03:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOP-000676-J4; Tue, 17 Dec 2024 03:57:25 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOL-00006R-M1; Tue, 17 Dec 2024 03:57:24 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-30037784fceso49632491fa.2; 
 Tue, 17 Dec 2024 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425839; x=1735030639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cH5USctIgwRZsBAfwmFIykbcOZshiCQYP5m8E4ld9HU=;
 b=Rzt5xcOOMiZ9ElNl1e3qf5SxiXm1K0aIwxl+8Gr2TB9A6LGddf32BICQQC+nYGdYdl
 LL5cV556iywqQZUpRv1XN9lZszjKmadRVsAZMTHfprMIXx8jjQxpN9OqoiXg2MCXXoju
 7Xh+A4dYXulU14Pht5jEtNKxyynJYST3668XbwzyStaQb1NxTsRhMKm42ckAgeylShU2
 XC5DK9vMgqbKgB4vAzDgIJ/qk3M6aNEKE/DYaCACCiKjtugLhXPsFds6jL2jX5QxNZFM
 7rzKOVt0ZP0xLSBX/aKBxQuZmDzBYjh/SXmn3EXg5+x6218thfMR68+SgCoJ7Pnit6wJ
 RkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425839; x=1735030639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cH5USctIgwRZsBAfwmFIykbcOZshiCQYP5m8E4ld9HU=;
 b=WATqqs+UCPzJTEFNZWLKp4Kn+n7vDCorxwGvW8jqjV1+rnVV4+djMnoX/klk9zDtRC
 cbEEl9eeM/2KUIO91IPy7FrG0n9GLuHkRw63lFdHE6cklrn+6rvjrJZZOTSEZ7tXkFHc
 UbRYh4TSu3YHmbBubq8AMzR1zHYhJX7Bv3FaaKaZ3OP3lnST678WFbPkdxI4yTxuL3k3
 fvpZX5wNs8RB4qWcZKOX9AfmELzp9hy27JdyIB5df9rFWEQVcAgsprRzDzeULIw6Rsoa
 owup5osWgzP06XxjryMFVe5YY9DeoJvEq7s4wuyUGT2KDopimzQkJz15zkt8g68TkXR/
 dTMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9zczXzGpfh/6eL7bQijrloND5L+2Wgfk5gDLGEgL0tzGNzkfofm020ubxFCfU2a47ll34aO9nrj9BwQ==@nongnu.org,
 AJvYcCXTQUGuvdF6HtyfDhnvHK2zMoAmdd5gDxQ+FfueqNrFYugD7T7RpD/blgxHD7XT91RH0irOL7BTrTzt@nongnu.org
X-Gm-Message-State: AOJu0YzaWks7YKbxIPP/U+49ZP0fscQWULm0GLs4Di4T5D9XyoEhDQ7m
 AEswYpEQSxAsCMnw+HkYRFIfjNR4Z8rEt9lt/wM9AH+IQUGoT3NpG3v+aHQQ
X-Gm-Gg: ASbGncvHWrTpD6GGWuWZUHlEAFjLZSMGw0E/RTP6VkCWR2uflggq+zb+feZizcintKz
 Jrbv9lNu4OeU6pQN54MG2Q4rZaQ9p3wbqd8CM4dAcL9d4XwTkHRObH7ajjIAqmzi05ofMWyp5dY
 cFj6gNsn6JlDzwbntxAAX4v4HgA6xIlGWgShK/5gznK4DyPNiPtlESLlkUFDYycLs/RhVAo4JPS
 LD5e0mm4nFqp4G/eUd/W8/g0t52zQ3HNJQ7Y/f/H6Qo0/UBDwiuEpS2mbz+
X-Google-Smtp-Source: AGHT+IGcLGvxdk5Y0wbxq7ciCu8gAwr9SjGAAO/+SWndZ2dLLFBt991xCwXtwX2a3+UkKJ4xvoc+VQ==
X-Received: by 2002:ac2:5ece:0:b0:53f:8c46:42a6 with SMTP id
 2adb3069b0e04-54090568547mr3825852e87.27.1734425839128; 
 Tue, 17 Dec 2024 00:57:19 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:18 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v14 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Tue, 17 Dec 2024 11:57:05 +0300
Message-Id: <20241217085709.679823-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x22c.google.com
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 417ff45544..e7f346ff6b 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -768,8 +768,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
 bool riscv_cpu_is_32bit(RISCVCPU *cpu);
 
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
+uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
+
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
                           target_ulong *ret_value);
+
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
                            target_ulong *ret_value,
                            target_ulong new_value, target_ulong write_mask);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dba04851d5..7d149dfb33 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,6 +214,84 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     *pflags = flags;
 }
 
+RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int priv_mode = cpu_address_mode(env);
+
+    if (get_field(env->mstatus, MSTATUS_MPRV) &&
+        get_field(env->mstatus, MSTATUS_MXR)) {
+        return PMM_FIELD_DISABLED;
+    }
+
+    /* Get current PMM field */
+    switch (priv_mode) {
+    case PRV_M:
+        if (riscv_cpu_cfg(env)->ext_smmpm) {
+            return get_field(env->mseccfg, MSECCFG_PMM);
+        }
+        break;
+    case PRV_S:
+        if (riscv_cpu_cfg(env)->ext_smnpm) {
+            if (get_field(env->mstatus, MSTATUS_MPV)) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            } else {
+                return get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    case PRV_U:
+        if (riscv_has_ext(env, RVS)) {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->senvcfg, SENVCFG_PMM);
+            }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
+                return get_field(env->menvcfg, MENVCFG_PMM);
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return PMM_FIELD_DISABLED;
+#else
+    return PMM_FIELD_DISABLED;
+#endif
+}
+
+bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    int satp_mode = 0;
+    int priv_mode = cpu_address_mode(env);
+
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        satp_mode = get_field(env->satp, SATP32_MODE);
+    } else {
+        satp_mode = get_field(env->satp, SATP64_MODE);
+    }
+
+    return ((satp_mode != VM_1_10_MBARE) && (priv_mode != PRV_M));
+#else
+    return false;
+#endif
+}
+
+uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm)
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
+}
+
 #ifndef CONFIG_USER_ONLY
 
 /*
-- 
2.39.5


