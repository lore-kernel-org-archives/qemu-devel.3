Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701DBD41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 16:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTjgg-00035q-19; Thu, 11 Dec 2025 11:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgf-00035h-0b
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1vTjgd-0003v4-GN
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 11:38:40 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so2796965ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 08:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1765471118; x=1766075918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DRRc31U2dAwfcZXx7v8kYgdUw1nw6KYRX9k66akdTU=;
 b=mgDRc1++O/McAuKrP/w3DzEJB1WEG46KWrudq//rtMSWPwJm+6JuARlfPYDFopCqG9
 x85mLFvXkT+vZwn4LUakqrQzjXQHsoidcmRvOI0nvqG3O2Wx9GE+ip0AbF4EKcvYhJQB
 KrD2HBZIRLHkcji7vktbvYiJ86UxAkJBihyvOkev3kAztoBrUCddO5BYWYj511OjmJj6
 GgBL1qVX+TuWbYCwgKm7wLlO6eHVhygHC9LHQWa3nZ8bdwHcYNvbvaPGtOrsW25wNye7
 yO8FfKEQiG+59PBVmtpbthFZF7IE9B3JCAiedZuxaBYxfcfrCdE2hYHxnuhe1c01ei0E
 MW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765471118; x=1766075918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3DRRc31U2dAwfcZXx7v8kYgdUw1nw6KYRX9k66akdTU=;
 b=dLfyGcv4skcLWyTc07C7Y17QhoAFphVtaeVtRcV7bvTpFmNDRJqeD+1bk/c1u8+e38
 dCgkOAuwpxj0L9G7n1QXXRoTYR7sLFC6ChlIfOZTcqePZQmKc59/u5/7n56KQZuphn+0
 F+D8Ei22nUJkLkOlHSFBpuiLy01YJxmTFNjnViHZi846vpQeshC9qO1xMhif+WRRkMc0
 lkRohxFWeKd8FfaPrQ7tugsxmxrhWf0Hcqw24+XKVy7F8k2Q1KSIXw8osT4JdtGil3h/
 QwJzlcNzFaIm9uB6rCPQz7p71NaPMbn3c7UDJvKincINxaejw6YVI36LGeFZgV+LB+Cf
 51qw==
X-Gm-Message-State: AOJu0YzkkrppnBOpEX3JMuQ5h+gByudZweiHsfn7WMd9jh515Ha2eNWK
 eeguStt6T7Xi69/YFzf7vVf1LwjLZATfqhvzkgfERtf3ziiJER4Wl4K6und9wNAfIJUdRjXlrA5
 DwgehHSIURclvBb79oOdVJSlZ4mDo4Gbe0B3LmQHMh7I7SDwrYc+lpugKmw1RHLqlpIxy/KPlBh
 SkSDpO2zzZQmGWdKHfqT1gTeE4yejr/rnQ3eEpK34HwDg=
X-Gm-Gg: AY/fxX49//hS92ib9xjYu7LKbDU/5TbKy4kc/09RWGZCVeQhXN6IgdwrjF5sCnQwQmD
 k2uTqViqfIE0ONG1hjeGnC+NR9fGeFTXAnkRWmygjPPqUBQ7mdu1kmggNMFjVGf90tDBs9XCfgx
 eu4LQqfwq9dgNOBeMa+cEBKKEyePrIuSy0uciMibuiNfD/KDZMZ1ljVnV7OYFoD51VZfr80wq4h
 7UX4jpFzT2PlTniZtv7ogj4b2fWkTNRLcyoyytl8OTBHAEK7H5QpCizurkkQNYZNwsY4zc5k71h
 F9KltVkmu5LUAW4/ca/tgIFQqAGCQwnq3wV/7Lmu8xK+YGwI0oXwLNfT3gId4vpiZIps8Xu1l0D
 DWS0LrZUzl1LUkwXxmPzlCuItgYC/kDTW9SYZ6Ptv3cP3fRIKL5/VIxXW22YBL4KK7RCNg4eioO
 shgQeoUeEIgiP7XixK3q3J1Y7ufPpdEiZFKl5DBw==
X-Google-Smtp-Source: AGHT+IFAkqOvMpE/L5/EtWhkjhwaeEOsUGexj6iq7CAkZtAc53oxFWH7CUOMfSl3G6ULCILTYAwnEQ==
X-Received: by 2002:a17:903:3d0f:b0:296:549c:a2b with SMTP id
 d9443c01a7336-29ec229aec7mr63252875ad.3.1765471117586; 
 Thu, 11 Dec 2025 08:38:37 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea016c63sm28962965ad.48.2025.12.11.08.38.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:38:37 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v3 3/6] target/riscv: Fix pointer masking PMM field selection
 logic
Date: Fri, 12 Dec 2025 00:38:22 +0800
Message-ID: <20251211163826.3998266-4-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211163826.3998266-1-frank.chang@sifive.com>
References: <20251211163826.3998266-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Frank Chang <frank.chang@sifive.com>

mstatus.MPV only records the previous virtualization state, and does not
affect pointer masking according to the Zjpm specification.

This patch rewrites riscv_pm_get_pmm() to follow the architectural
definition of Smmpm, Smnpm, and Ssnpm.

The resulting PMM selection logic for each mode is summarized below:

  * mstatus.MXR = 1: pointer masking disabled

  * Smmpm + Smnpm + Ssnpm:
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U-mode:  senvcfg.PMM
      VS-mode: henvcfg.PMM
      VU-mode: senvcfg.PMM

  * Smmpm + Smnpm (RVS implemented):
      M-mode:  mseccfg.PMM
      S-mode:  menvcfg.PMM
      U/VS/VU: disabled (Ssnpm not present)

  * Smmpm + Smnpm (RVS not implemented):
      M-mode:  mseccfg.PMM
      U-mode:  menvcfg.PMM
      S/VS/VU: disabled (no S-mode)

  * Smmpm only:
      M-mode:  mseccfg.PMM
      Other existing modes: pointer masking disabled

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu_helper.c | 51 +++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index da6e2d8fe3a..4347153d794 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -131,13 +131,47 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
+/*
+ * Returns the effective PMM field.
+ *
+ * @env: CPURISCVState
+ *
+ * The PMM field selection logic for each effective privilege mode
+ * is as follows:
+ *
+ * - mstatus.MXR = 1: disabled
+ *
+ * - Smmpm + Smnpm + Ssnpm:
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U-mode:  senvcfg.PMM
+ *     VS-mode: henvcfg.PMM
+ *     VU-mode: senvcfg.PMM
+ *
+ * - Smmpm + Smnpm (RVS implemented):
+ *     M-mode:  mseccfg.PMM
+ *     S-mode:  menvcfg.PMM
+ *     U/VS/VU: disabled (Ssnpm not present)
+ *
+ * - Smmpm + Smnpm (RVS not implemented):
+ *     M-mode:  mseccfg.PMM
+ *     U-mode:  menvcfg.PMM
+ *     S/VS/VU: disabled (no S-mode)
+ *
+ * - Smmpm only:
+ *     M-mode:  mseccfg.PMM
+ *     Other existing modes: disabled
+ */
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
-    int priv_mode = cpu_address_mode(env);
+    int priv_mode;
+    bool virt;
+
+    riscv_cpu_eff_priv(env, &priv_mode, &virt);
 
-    if (get_field(env->mstatus, MSTATUS_MPRV) &&
-        get_field(env->mstatus, MSTATUS_MXR)) {
+    if ((priv_mode != PRV_M && get_field(env->mstatus, MSTATUS_MXR)) ||
+        (virt && get_field(env->vsstatus, MSTATUS_MXR))) {
         return PMM_FIELD_DISABLED;
     }
 
@@ -149,12 +183,14 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
         }
         break;
     case PRV_S:
-        if (riscv_cpu_cfg(env)->ext_smnpm) {
-            if (get_field(env->mstatus, MSTATUS_MPV)) {
-                return get_field(env->henvcfg, HENVCFG_PMM);
-            } else {
+        if (!virt) {
+            if (riscv_cpu_cfg(env)->ext_smnpm) {
                 return get_field(env->menvcfg, MENVCFG_PMM);
             }
+        } else {
+            if (riscv_cpu_cfg(env)->ext_ssnpm) {
+                return get_field(env->henvcfg, HENVCFG_PMM);
+            }
         }
         break;
     case PRV_U:
@@ -171,6 +207,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
     default:
         g_assert_not_reached();
     }
+
     return PMM_FIELD_DISABLED;
 #else
     return PMM_FIELD_DISABLED;
-- 
2.43.0


