Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEB2FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8B0-0005Pn-P9; Fri, 24 Apr 2026 00:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8Az-0005P5-Fw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8Ax-00028l-OR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso4706340b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777004998; x=1777609798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U84UA1BQ7VqfrcfRfFgnZ2xkpsO6jNjW5chEwl65Yx0=;
 b=NhClxl0sd6/OnrJAp6MEW0CBqPHNv7JGS/PgI74olr3HBt4dqDwoUdo9N1cK/A9ANd
 crNoaUF1Fh5eb5Fvnvxd5Lx6jMJI1iVUQKPzg32rN6ncdDJZXEoeDSbL8vWlL4aMJ+19
 9twlR7RPJo7UwiUZVgKnBtyVBRChxJnwAJ79u/T6BeddrZZ9iyCMb6Tay9xtjsWVB4AB
 fgd9INuX/8B+PSxLlIggfJbj31+WXAg2TpTwsL+PRBFT0lD+NHyZnkA4llBiFsD4n+HK
 ILhcCGYPZogv0GpaWxCYouDzt3BkfORS18Ho290UjU/ZgsUjFXkG3jH2vv2wkOLYsQ12
 oplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777004998; x=1777609798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U84UA1BQ7VqfrcfRfFgnZ2xkpsO6jNjW5chEwl65Yx0=;
 b=TdN9p9tjMy6HetFaIflPSOSjwSV3HuCqqTrQbVUzJdSycwVxZTShqaNvn6B8VGZ6AY
 P38EqtAbgQNVPIMnSh2G19XiiVw0jnsR1WLjNDWFC9oXDLDoMMBlzFq52IhmWaddaLmb
 l1ik3/V4l6WAnWg/YS7kGbfmKc2YcxUcJFVuxtmp1FUX3POdXykDpoi/rB2hudTgiNah
 LH8XpAUUUMSTfo1Y7qpeCKOEhJNdWLeqXUVYwrQshUmYAOs96EFqfMtk3FWPJe3HIUkK
 1yU4JyAMH7H4kTFMx50IwJGeoy3DQg3LZtOewkY4AK6bVD3Ipp5i5CPcWdGJToYzCSXs
 is5g==
X-Gm-Message-State: AOJu0YzdbEbkMEXwrHl7Js0lFe/ZlQ3qpxm2ukkxN5WGYbX30YGrSxxt
 EWFcw044WFg+WjNvNoPGARAL1/Uz1bvAm5Q9dYA7Hy7WAqsFwdxP1KxAREc7xh9TG5AKWHmlDJi
 OUV+8AEKar7GP08nN+8v1SubZtuj5+T+WLBqwWqXzmTuEi7VCgbPHeJ/fuVtyS5SS4lcOJex5ED
 EL0AJvEiwLto4vkmSX28s/lcz2VNEHKD6b86NgezQlBKvKDEWu
X-Gm-Gg: AeBDiet7HVzNk0GUjxy7bqMY1DxLPMbXOuoSOfyv7s/t/ARNxhSlXZfxnKMTF8Ye17M
 S813OkyqMkqYyCUIsZBilfPjM8nZSvWwP/rkuk0m1H8hGvI68rD92Z+EdxP/ZEveYIQaESUqWqU
 +Km9cowoXgx3ewb63S1p58WOzLbQnK1CJGptKdXhLL24KPSCDJVKT1RFpXbaZmqt72/ZHmBWVn4
 Xgb2xz1g+pv+wVSJm3xlvfi1rbrvAjLroVJPngPZm4vUlYqvHtsyXOJ4TjfYBgIpGoy1rD881GH
 HVOxq3vpJW5z+l8PgwVNOprfmP1P+ooJsIQOwoPihDfhsd2pVKfw0uCYCVdISue6YIqU9zef2/n
 MPtk/EXuEeWn4NphsD6EOZFqMki5LyOtgMAmUiBbC93fz6vk99H9iX13xESCF4ndCzuVCJFJ4Zx
 j4VhmH/r9j1K+iIvgt1Y0NEUG5JzIZd1s/FHz8WVr88kLq/syUS5hB1twoVVuI
X-Received: by 2002:a05:6a00:80b:b0:82c:e5d0:5249 with SMTP id
 d2e1a72fcca58-82f8c7dd16emr32029291b3a.8.1777004997751; 
 Thu, 23 Apr 2026 21:29:57 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe92desm21712867b3a.44.2026.04.23.21.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:29:57 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>,
 Jim Shu <jim.shu@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 2/2] target/riscv: Add standard B extension implied rule
Date: Fri, 24 Apr 2026 12:29:46 +0800
Message-ID: <20260424042946.3875690-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424042946.3875690-1-frank.chang@sifive.com>
References: <20260424042946.3875690-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42d.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add the missing implied rule for standard B extension.
Standard B extension implies Zba, Zbb, Zbs extensions.
We can also remove the auto-enables in riscv_cpu_validate_b()
as Zba, Zbb, Zbs extensions can be enabled by the implied rule.

RISC-V B spec: https://github.com/riscv/riscv-b

Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 18 +++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f806d0536a0..e87d1b6cd9a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2260,6 +2260,17 @@ static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVB_IMPLIED = {
+    .is_misa = true,
+    .ext = RVB,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zba), CPU_CFG_OFFSET(ext_zbb),
+        CPU_CFG_OFFSET(ext_zbs),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2647,7 +2658,8 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED,
+    &RVB_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 8247cf1b4c9..91751439752 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -564,27 +564,15 @@ static void riscv_cpu_validate_b(RISCVCPU *cpu)
     const char *warn_msg = "RVB mandates disabled extension %s";
 
     if (!cpu->cfg.ext_zba) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
-            cpu->cfg.ext_zba = true;
-        } else {
-            warn_report(warn_msg, "zba");
-        }
+        warn_report(warn_msg, "zba");
     }
 
     if (!cpu->cfg.ext_zbb) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
-            cpu->cfg.ext_zbb = true;
-        } else {
-            warn_report(warn_msg, "zbb");
-        }
+        warn_report(warn_msg, "zbb");
     }
 
     if (!cpu->cfg.ext_zbs) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
-            cpu->cfg.ext_zbs = true;
-        } else {
-            warn_report(warn_msg, "zbs");
-        }
+        warn_report(warn_msg, "zbs");
     }
 }
 
-- 
2.43.0


