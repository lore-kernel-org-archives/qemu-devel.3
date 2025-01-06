Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEE1E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHY-00075U-RZ; Mon, 06 Jan 2025 05:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHV-00073i-Gx; Mon, 06 Jan 2025 05:24:21 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHT-0008QG-P0; Mon, 06 Jan 2025 05:24:21 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5401ab97206so14746921e87.3; 
 Mon, 06 Jan 2025 02:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159058; x=1736763858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqgRKoDWayxy+ef4zXFPKBER9Was2OFOD3qMkO/gHU4=;
 b=J0VX15jz0RybzkbRLCzYe+zqS8Si4OXXKUSXIyQLox28SF7fVDxNUovIeaJd12iY3n
 +pDzYQ8JkVidWW1pslTrL8i6QPGSuEnyEfOGUFzo1uB+rEcb1cEFkmQEnCQz6jNuXiVu
 yynbLdR9c2H8x6/hLAGuWn13ZAZZ6osU8X9ZqSA3oJ9mCttU2JyKJMHs1Curak8M9lN5
 /n978GgI91k3s/vF54dP1qYshSwMm7ISGUFnCuWYI9h72xkd0ky51943JcX18iv3OjmM
 DGNj3GqKOb6fq+HKwcC0AB0L6FKFJR55WHyUpGASX2IDApBWM257hBaR4ES50LFN3eQE
 25RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159058; x=1736763858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqgRKoDWayxy+ef4zXFPKBER9Was2OFOD3qMkO/gHU4=;
 b=VqjV9O+c7kEQOKjHN/j1lMUneLF11CA59TQiqZqfZg/0b8WQNeqIz+6YEwJKi5xZzh
 6tHtYOPX7S7dhcu1nGCQUWlnduINB3nn9BD8JjMjvyAlUdr98KBxRI6jUwO5m/gP8hsd
 8vX+gcITwqH5ac8A3Ed4ByfPUCpIqeWye0w8MBxY024l0LGz+Ne9pgMXLSR7aBn/e8+i
 t4xcCBHehXVMW562HEaApjRQXDH2wcFZY+2z85bk5NI7bB+dHmo6dzcMAv0lhLJBhFWF
 clZ5niwuOhzSPX2ensOCrXaNlYlKG1HLeGP64HjDWlmZL1QgHfhuTQGf1ADlYHVsxaKZ
 5evA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwI2ofnsMIPg6xng429evgzHxaiufFVL0DUdH0NDufE8ul4u4MwgE7OM2oKFQHfmGV2Brbc9F0+gQK@nongnu.org,
 AJvYcCXxvRzdyGCmBV7KlHfA2ZxoPd/DOdrPgN3JxxZPAF6DZQyXpGTEpQqUy4fqug5ta1KUgQoijdFl7nVEqA==@nongnu.org
X-Gm-Message-State: AOJu0Yz90pZC6nJ1B6QZm6Q1opHK1+VmJvcNxFJPbvQ735xCKnEIrJF7
 fOs0xvWpEdo3t0v8v973xfP+Mey7zdOm1k7YZCuAagd3uyxDmJK1
X-Gm-Gg: ASbGncsGxhcAwIKlmpzznaKCIH3/SU6Y+xJj58CVfN8dnGBEBgidu0Tg7Ju+mplE4uz
 g6wiGOX0gSk7/idZH69Z7oXAbzLVmTdSyPavSLSLv4+dQshlTUaumW77nBQ72fi/yGMN0bOfFoY
 sMdSQKtUd5+kQ9DqhmxNiT8O1nFJR7qP/GRQYWjlaluMDBWZlj8SAcH4q92yzZZEkqTzwX0vhe/
 f4hYjRjM6OCP6j+WXunob1+9H7y9kPbEj7lQJZZZXepzBVVoNJxH95K42DL
X-Google-Smtp-Source: AGHT+IFQERwweDAsFivb4lPQkodKUf+daH3KOwmaOlAXgXcAPSLzTYod5/JomHhzKRSiTWi52THxGg==
X-Received: by 2002:a05:6512:32c8:b0:542:622f:124 with SMTP id
 2adb3069b0e04-542622f019cmr3956739e87.0.1736159057514; 
 Mon, 06 Jan 2025 02:24:17 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:16 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Mon,  6 Jan 2025 13:23:42 +0300
Message-Id: <20250106102346.1100149-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c | 78 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a3aca8a222..7c7feba54f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -771,8 +771,13 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 
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
index 8c1969294f..0e030d4ecb 100644
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


