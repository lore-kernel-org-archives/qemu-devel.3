Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE23FFB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Ay-0005Oa-Us; Fri, 24 Apr 2026 00:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8Aw-0005Nm-WC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:29:59 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wG8Au-00028D-Qn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:29:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-82f69adeecbso3127410b3a.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777004995; x=1777609795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iqc7VTbeyjOi8/9VHDPDSeLdUciW2u+roO8j+QjxNso=;
 b=dxbB762t4j0udnGQ7lxFV1afKiO6rhywVks+CkwK+Q1/vTVbrz5/2b/UBsePyoCaIr
 dIs25D8nWy5dHV/KG+TCHd8bGLmw2I1oEpuJlmOFxH/JEc4KUQT/IbRwdFbjc/vzRlAb
 s9oZU8QZgmTXU2upMMHSvW6XvLNH/SGC3V8f+kzYwlVUMnwq5n4DnaSQIxfLWDbk8/Nj
 a9cBSFNA+aBR4x/PNdQc1m9ws2/l/LbIB0ZmIrXy54+oGhv9/8GHcaPFBwpWvMgda/P0
 F0X0rqj8wsoNdpP5xF85v3ReFj3kk3dR23jCL7kR3oNqx7TvpPneLqup3BOzidyaYlS4
 B+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777004995; x=1777609795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iqc7VTbeyjOi8/9VHDPDSeLdUciW2u+roO8j+QjxNso=;
 b=fXZKttxlLgV5dkPkIUV/EKWI0wKKwuJBAKghLq3W5PpaP/QQpIPvskWL72GPVf/7Ho
 mOB1Lzd902/h9hmsr9o2Iu+sRIcnXNBMcAeOo1tkbuPdHfjKKOq3Fjl4/8EyjixPQJks
 54+/TmoYA9XwPrfiip4OynbrA2hIuuRm8SXj5pc4UKbntyeaRcYmVtYEe+YMsnjuCagP
 vYlUHXvrW/J06oP0v7DvMC22+IyIkDG7UPWJpaN0ZE0XgepyteCW5MsiI2gO+5frbrWw
 iauvgkB5Mla2kiri6Dh9QQWHr4H5Kz56N3wxQO9xu308ceuFNEdWAAJx9Mebu0YeV5hh
 wRxg==
X-Gm-Message-State: AOJu0YzTh/e5wYZ2pWa57jhTfnNH7+AfglPCO97GLkIPPCWgkldCfLkD
 gSAY2je4bbJn9fXZQOlWc9/AjSNJNfL5A5ovB64BlCzdevuvdpEtlX7hYxBGD5ghXM8QANj6oAJ
 18SgM3H0+qL+Suii4bOPFGnOWsUgKVuwZOrLStPUU5kbsu7WGSl7HAVM+L0DooEJFreAtObnbvZ
 g2LyU4DK049SiLRl9YHBtGfB6dt1svS/CbZMaL8K0FlMZ+JZnQ
X-Gm-Gg: AeBDietPUud4YBTmkvnuiNSVZVbCNIaTOHEUNiCE7u9dt4cFETEaF982h5PY897r6J6
 3lCivFOBj1iwg4WfNVJV0JXayDj1am52shuvDyJRrQ1c2YGoDhUj+EH0plNvMahCE2S1dRRIAdl
 n8z5eGrYJD+WDXhDQnp5EQb7iNVA+aE/aAtQVqzbzN24f5UUUdBXarUkZwf2MXrSxp7EPE9eAkh
 LbyI7UGJ/31vFZp+1skkYLRcl0o1TSSgTTjRFNF5ShEe1osMiunX9WhTNGedlQTgCY7uu9Xj6Xj
 M1E1h1DbTLLT94rPw9/J4LDfdncScQJiBi0lalBLKSDEXe1PtrUjLJ28vDk7jYUDoTJ0knXrm37
 cKqaKVFD6sw9t6GCvkkFGK/AKnGTM6D25fWrUBmQyMZEEq5YglzK+iJzoU41ebbqzG6TH0OJbec
 hPVRrRze2e/GoyVICAjBILm8CZk4xPXmyQAFCYhUkCKG1n9Y3Z9CW52JQTboZ0
X-Received: by 2002:a05:6a00:1826:b0:82f:2384:212a with SMTP id
 d2e1a72fcca58-82f8c961ef5mr32139147b3a.26.1777004994884; 
 Thu, 23 Apr 2026 21:29:54 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe92desm21712867b3a.44.2026.04.23.21.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:29:54 -0700 (PDT)
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
Subject: [PATCH v3 1/2] target/riscv: Add the implied rule for G extension
Date: Fri, 24 Apr 2026 12:29:45 +0800
Message-ID: <20260424042946.3875690-2-frank.chang@sifive.com>
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

From: Jim Shu <jim.shu@sifive.com>

Add the missing implied rule from G to imafd_zicsr_zifencei.
We can also remove the auto-enables in riscv_cpu_validate_g() as
IMAFD, Zicsr, Zifencei extensions can be enabled by the implied rule.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 21 ++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37d..f806d0536a0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2248,6 +2248,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
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
@@ -2635,7 +2647,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f78088956..8247cf1b4c9 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -545,30 +545,17 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
             continue;
         }
 
-        if (!cpu_misa_ext_is_user_set(bit)) {
-            riscv_cpu_write_misa_bit(cpu, bit, true);
-            continue;
-        }
-
         if (send_warn) {
             warn_report(warn_msg, riscv_get_misa_ext_name(bit));
         }
     }
 
-    if (!cpu->cfg.ext_zicsr) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
-            cpu->cfg.ext_zicsr = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zicsr");
-        }
+    if (!cpu->cfg.ext_zicsr && send_warn) {
+        warn_report(warn_msg, "zicsr");
     }
 
-    if (!cpu->cfg.ext_zifencei) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
-            cpu->cfg.ext_zifencei = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zifencei");
-        }
+    if (!cpu->cfg.ext_zifencei && send_warn) {
+        warn_report(warn_msg, "zifencei");
     }
 }
 
-- 
2.43.0


