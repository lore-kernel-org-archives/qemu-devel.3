Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221B7E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4P-0002u2-DV; Mon, 16 Dec 2024 07:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4I-0002rF-DN; Mon, 16 Dec 2024 07:19:25 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4E-00008R-U6; Mon, 16 Dec 2024 07:19:21 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3022598e213so39162891fa.0; 
 Mon, 16 Dec 2024 04:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351556; x=1734956356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlGe+f3UGYSb/kEDepIoDVwMot6RVWe/m1fwsn8f8OU=;
 b=YoNflpMWGSWmnhh+27JiAK78kyP8+iV/y4BWf0GBGU9Gk+mXBJcDcSBvYTNgkUDHsJ
 QQVLaxzUXAjq8sV//Ol41rlfhlwk5FA/Hy2T+mz4GeG6xEFegvN3iWlZP1HhEH47l2S5
 zRIW78U3HdCktC3wyPaq479338MDlyJ9YlbYoxJtr3CuR+TO5o1Z6gw0aBIzNTm1VuUO
 mVyharmXfMag6h2oA8NbJ5QVx/lW1vjgSSWJoHACr+GICLCmiRd6PaFNbZEaYJ4h/QwQ
 CwPU+UlFEVz4q8UQkNhCD0SsdaviU0Mu0Dg2O4cNZx+CIdBKSekvbREY0QfSIV24uH9y
 v2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351556; x=1734956356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QlGe+f3UGYSb/kEDepIoDVwMot6RVWe/m1fwsn8f8OU=;
 b=stJ+hMc//3jVmJth1bef/+fZA13WLq4yx9IvCYPoSQxM8btrbHRNpzMAJRbS2CHMiQ
 jLQUneNn4T9CJ0YoGvNAiC0K5nPYISic0y3/biKpJx83qNr2TX1vpdHUsi6g/iMVBWEF
 2yVpXgdmqDfOiXpyItrX5dlMg5LQs42zjv6y/Bz1iednKVsb/v8iz2VC4tc5dhYY4wz6
 8CNS471gvNPCDm24chYUCOAzZuZtcuy1uWQSB8QfB90U51e+EjSH9pkIhWKPgnMKwetB
 m+o/GxEmHZhNJqVXCj6Dumu6L/uZJ0AvY9CvvXa9pDRkgRy4vcOgkI4ee1Rn2gS7PffT
 n/LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfLCEjsW9/8yTRvkhvV5v67Im0kPp2q6EuCHQkM3ZgV1v6seDu3GKwXL4CwpHrpt+dn8vo04N61QCa@nongnu.org,
 AJvYcCV5atMSa/SUiXi8k7Q8drRmqb9i3clGeTxCWdFA6HMFGt26fOYYFgUzUrphd0VAlFSLPEfAO4EJqG7cdQ==@nongnu.org
X-Gm-Message-State: AOJu0YzFlbPlHVWBNA0kWGWcmnUukxTFs4sQfI3oMpqv/gSiSJq3js6z
 axL/j1mfUWll8dd/OlKsWq/nN83RFnM94q05xYs0xW3l0eiTSQcm
X-Gm-Gg: ASbGncu/eUQ2dnivXiFiD6L/ZBBn1ScJe5Wxv83rMFBUnpQ1zGfgUXX/qAJvkOwLbc3
 sSFEdBCTrezzBMETDfk3j1Dw97xKp/8S9dFsrn2em8e0kGUMbLIEVmVyRlht9IBcnuNl8LSgj4q
 CuvwhU+WgNzTAjENBLXetVphY0e8fyw66fMyt57No6G7eUlnZA7o04pkVadiefXdyO6Av6vZKWd
 lJfblBQ/k5Yi1HWGPrKc9JXoywlsDyFl7jogBh5tVCEuSIOsTGocLknVsnofg==
X-Google-Smtp-Source: AGHT+IH1JpCS5bwLc5yCt1nNUXwWf4kgSlzGq4boax/QNg40W6eY0qH6b1SHDQ0AdaQILqrAe7PJTg==
X-Received: by 2002:a05:6512:1105:b0:53d:ed4e:e5af with SMTP id
 2adb3069b0e04-5409056405dmr4017525e87.33.1734351556448; 
 Mon, 16 Dec 2024 04:19:16 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:15 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v13 3/7] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
Date: Mon, 16 Dec 2024 15:19:03 +0300
Message-Id: <20241216121907.660504-4-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216121907.660504-1-baturo.alexey@gmail.com>
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x232.google.com
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
 target/riscv/cpu_helper.c | 73 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+)

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
index dba04851d5..ed0d275e84 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -214,6 +214,79 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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


