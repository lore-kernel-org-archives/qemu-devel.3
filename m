Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319A0E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9x0-0008Ge-1G; Thu, 05 Dec 2024 06:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9wy-0008FY-CX; Thu, 05 Dec 2024 06:23:16 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9ww-0005Iq-N2; Thu, 05 Dec 2024 06:23:16 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53de6b7da14so871492e87.0; 
 Thu, 05 Dec 2024 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397792; x=1734002592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9lGZHXWqJDLPSDknYMJV5oSWnSKjVJ6tDAfkPQT3C8=;
 b=V+yyu2hAZOuWaoGaDei3ANoDocu7/2HXyFyYDymjwUw6NPfT0ev63NaaBHI2ZHe7/q
 iMYLmJMH2jd7fGc+30pgQyLPipqrtYFClu9xpsNfWl5eL3C9u4TS+hdRusoTKm8iECzT
 2nISRNUqc2XTwQO1x3XsJv7TdrIV337KaJSWrB2Ey0c19II2aPw8bIsbNg+TOx6TSsMD
 TyqOo29+SwtXzp8vE3XqwS5Jk6L3xqOavmsw5S/HwmMNM3g5cKI6JIdUX4Ikfr8KVDiO
 1OKCzpobypvb/ExL5awgXKRw5YWHyekl5Rm+woiEO35u3TQrJviCpQps85/fgFmR7ALQ
 /51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397792; x=1734002592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9lGZHXWqJDLPSDknYMJV5oSWnSKjVJ6tDAfkPQT3C8=;
 b=gJdnCZdBaZXd1gijIFp1XMJiSCXWeRAIOdQjdq0O89N3z/Vu+fXjZwloODly9iRGss
 pniwaQp4UrFnzmIvFdaDSrfFkvIKO4tiIipAVjnlSIwWIz/i6d92pCyQRPSMfrseXq23
 SmQYU8XedgucYnj9AP9oNJzimJ6fFHouCItdvFeaECioSBy+7sAXrSXJn5h8Fezh42Ts
 wrRsurSxUPd2BVhBcSBxRSWg5ShhVeV3BMx3i/fDtMDReT3buM7Pa6zLaNRnn+qA8Ted
 GhnWeAQY2ereCGZb+SjUCEc04HsBBSMeFrz8ucIwg5eyoyR4eIhcFRws8n8UmzQUZGb2
 I5UA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbNXZPF/bjVqkLRJ782MWHn1LObshSD4AZeyJAHpsxv2BIUtm9QRDWvhIR5ssurEYn/fLU/T3mbiF6@nongnu.org,
 AJvYcCWUTTAWTLpS9Ucfj2eNtYRf12L/IuVzQ14eptI+5E/5K+P5izTiJ6Llg9QcRdLG+tzOEnjP+sd+X7rXOg==@nongnu.org
X-Gm-Message-State: AOJu0Yy18/z8q9GPFdlW5TqyqqzsEGb8Lw2i6mHfoVzP4VFFOOBqeS/s
 WAEEYxnYpBBPvh2THS3SY+zciPH9lrW2HCruhc+oeZkGgusMQeje
X-Gm-Gg: ASbGnctBjmh3qocUHaIMaLrQhUY3LdgMZeFh5PBXCUA8NYWdw63CjZx0Ao0tVOuCMv+
 Rm5FWepc1qDbXMl+45yKpgxDolm/QccWkU5y+lvS7SuEEjfFrUvJ5sms0HBq1EYmf4KZg6dkzVP
 k78HbFzHvNrc5upvIl+Vn1xzQyIHHiB3m5sdtNbyFGmdhMNG8rgdcjQ0Y3ZmxC9FvynsiDqGD3t
 A6dplNdNLwhF9yXHLF8fr9x411l/Q2jN/PBMUcoVOTq6FEXTdT9eLc=
X-Google-Smtp-Source: AGHT+IHzXQkZmFTRlVb2oAsa7KrJ2rRXmKUBbU9CefOt5mKCsqzbvo7y1sZ7OhMkbKoxbPhFqFJpmQ==
X-Received: by 2002:a05:6512:398f:b0:52f:ca2b:1d33 with SMTP id
 2adb3069b0e04-53e1b88579cmr3023209e87.20.1733397792382; 
 Thu, 05 Dec 2024 03:23:12 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:11 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v12 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Thu,  5 Dec 2024 14:23:00 +0300
Message-Id: <20241205112304.593204-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205112304.593204-1-baturo.alexey@gmail.com>
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
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
index dba04851d5..2558f869f2 100644
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


