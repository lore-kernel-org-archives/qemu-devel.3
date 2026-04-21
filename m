Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33413F327B9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF5kP-00011h-LW; Tue, 21 Apr 2026 03:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kO-00011E-3Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:16 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wF5kM-0004IS-FV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 03:42:15 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso24315715ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776757333; x=1777362133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u32VCWbUqw/KoJwFnMW3CTsxfVufA4KHN5YakpZ2TKU=;
 b=jH2OJkeCit7VCyXYIvTn/uoY7J8L1p4+VzpUQildGY0JzoDyxO9pF6gki7Q656dNwa
 lYw0cI7dmOUgYCmkHXKrVANdnmc52tIHx6wQPjC52qpQ63bibxw20V5hqdPQTnYUUE8b
 i2/bIw2NEhJDqzmsyfk38b11+rfOZKdJIkBwaKTtj3tn8pbIxE1QIN1b9U68llC1BKN1
 96pAcraPi3cUMZEjsi6yZaQpYxFNKvVF2dMiANcpvrhYHXnUaGHNKeTpjJLr8n8HSvYI
 uHAoLJI1sbtkx1JCajtoeWpPS4yfu0xnMpk4BtlMxC/gaeYfj5PZit//ynLd13OPYCgs
 j2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776757333; x=1777362133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u32VCWbUqw/KoJwFnMW3CTsxfVufA4KHN5YakpZ2TKU=;
 b=Xgrmyr1vOKqmBsUb3y5h6jDo8Nib71fYZU+Vi72c1+uyqBMRBCe3gInx0SDDFzJck9
 1XZPPD+4YghZQFgxkY8blwC5jHAGvCARBhK6AQuZuxDdgyVlEZhYNZdUPdEQsbK8rNGJ
 hBE8JU/hzinCN7/DtR6zs1EaaAFQaJLfvC9TIfffh9wIq+rxomDMwxhHNzfToXaRbux3
 jomt45sxjJBhR/NJJ6JT5Z9e9YUCqsQ1BOGr2G6bR6jJAz+id+yoGHd6kRQmH2kHJz1d
 mZdbun5CwszjAhcmVap4m4Gs2pIj727vap1IK2BXKTX0RrQos5d+SXj/+1USqoTKfXcC
 0XKg==
X-Gm-Message-State: AOJu0YzAGbNPYIaWVTZrdIulIYS467e4WQ7paT/ZnF2TX5xbOmrc8waj
 iTf1KwNSuuCzdaOR+/2+I796AD898wi9ixm+8DdmoBwmqMyEV5dmOoMm/baHapwFr2sfI2oDJoE
 GjN2L08XNQsIXroBV2d4OYIWgMjBB2Ts+EUGCSpeG8NHZPOpKcWl2xwkTJ1HzDqDlU3+ijRqj1a
 M0DpGTS04i8naFK7rRSZZIV2XOpXRxBXDQBcLZNwp/OIKJMhhI
X-Gm-Gg: AeBDievIT4WlYCgLsjKOE9ySuDGotos55qWjzD/LWZwPzY3L7+tUG7cIt2+ZRtzTgnU
 at/DaRrOLRKThkzVKFFpPBMetHakSOeHs0LAQXoCCfTepOJF4u49pomWXC2K/8Rvs5G1Deqb7Pj
 vmYTyaRbn90x14+BhsoWHmvV77rLmc5F//STMexVK6Ptnyx5ZzbmeRI2Y0z8SdWL/Z/eAkdzWRO
 Szzv3beGDgWJFUrPqIN3M5CusupLhddpbTou+CZUFcijtyY/SCu9+znaq1nqpmVrD92aswD5Enx
 I4Lx0S85NUz21eFQUxn1wweksfBzMo5jd0ZcNwUCddUQoKIc3BWevaNW0px/CVIQf8xacOGxpIf
 zydopJWixzB6s44I02u2krj3qJhnS9yvILwkBdYof8vqnGCEaVxG29eTGf+UtbGt8nzk20G5Yc3
 2Ix1zpW/uoeYQK+1s4wDTJtV2ZMGhFK6eltTe9dyq7vANgmIPA/pFB6GeAxQas
X-Received: by 2002:a17:903:b8f:b0:2b0:7225:d2c0 with SMTP id
 d9443c01a7336-2b5f9fb9d4cmr169244785ad.30.1776757332434; 
 Tue, 21 Apr 2026 00:42:12 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff918sm133191675ad.13.2026.04.21.00.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 00:42:11 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Jim Shu <jim.shu@sifive.com>, Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v2 1/2] target/riscv: Add the implied rule for G extension
Date: Tue, 21 Apr 2026 15:42:03 +0800
Message-ID: <20260421074204.2908422-2-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421074204.2908422-1-frank.chang@sifive.com>
References: <20260421074204.2908422-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x631.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jim Shu <jim.shu@sifive.com>

Add the missing implied rule from G to imafd_zicsr_zifencei.
riscv_cpu_validate_g() is also removed as imafd_zicsr_zifencei
can be enabled by the implied rule.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++-
 target/riscv/tcg/tcg-cpu.c | 44 --------------------------------------
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 72c6f4f0f14..7978b4fad43 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2247,6 +2247,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
+    .is_misa = true,
+    .ext = RVG,
+    .implied_misa_exts = RVI | RVM | RVA | RVF | RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+        CPU_CFG_OFFSET(ext_zifencei),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2634,7 +2646,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f78088956..840ef82350d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -532,46 +532,6 @@ static void riscv_cpu_update_named_features(RISCVCPU *cpu)
     cpu->cfg.ext_ziccrse = cpu->cfg.has_priv_1_11;
 }
 
-static void riscv_cpu_validate_g(RISCVCPU *cpu)
-{
-    const char *warn_msg = "RVG mandates disabled extension %s";
-    uint32_t g_misa_bits[] = {RVI, RVM, RVA, RVF, RVD};
-    bool send_warn = cpu_misa_ext_is_user_set(RVG);
-
-    for (int i = 0; i < ARRAY_SIZE(g_misa_bits); i++) {
-        uint32_t bit = g_misa_bits[i];
-
-        if (riscv_has_ext(&cpu->env, bit)) {
-            continue;
-        }
-
-        if (!cpu_misa_ext_is_user_set(bit)) {
-            riscv_cpu_write_misa_bit(cpu, bit, true);
-            continue;
-        }
-
-        if (send_warn) {
-            warn_report(warn_msg, riscv_get_misa_ext_name(bit));
-        }
-    }
-
-    if (!cpu->cfg.ext_zicsr) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
-            cpu->cfg.ext_zicsr = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zicsr");
-        }
-    }
-
-    if (!cpu->cfg.ext_zifencei) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
-            cpu->cfg.ext_zifencei = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zifencei");
-        }
-    }
-}
-
 static void riscv_cpu_validate_b(RISCVCPU *cpu)
 {
     const char *warn_msg = "RVB mandates disabled extension %s";
@@ -611,10 +571,6 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
 
-    if (riscv_has_ext(env, RVG)) {
-        riscv_cpu_validate_g(cpu);
-    }
-
     if (riscv_has_ext(env, RVB)) {
         riscv_cpu_validate_b(cpu);
     }
-- 
2.43.0


