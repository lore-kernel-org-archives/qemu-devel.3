Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E772AE8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVI1-0007yf-EZ; Wed, 04 Feb 2026 00:18:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHz-0007v0-Oh
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:55 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHy-00086R-7V
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:55 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-352e2156450so3079012a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182333; x=1770787133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7RJutSKn1k65hDY8Ig9jUscMyGWjNCtLo7Y1bHL9Eo=;
 b=ZWVaCAumoW3t+DQg4q4R9oN+OeJDOEnVIM1huRVQP3K8L0QyiWluJgjquNM8FbwFve
 owmadV5me5q/UbtBsuWTF2JRFhvVZnlbYnX58YMBDMwZnNg+1cmWR982xzfc0o0SBJlH
 6jJn2+4HdWuBdpc9qEE/r+d1mLUS8CEL8oyWQZ837srNMTBD2LNVgfcfyd36fGiujzou
 hYBeTsy+xwGJYQo1Crk7XeVEtzwIED8Nr4T6gj492CiPaCIqpp5tqGLoPDI3sGmv4ngZ
 L0/C0iIivqaNQFK95LKhc8C/XWyK0qQShBtulU4gbQBWHQos27aEFfdXfGYCFkwaVss+
 +z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182333; x=1770787133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7RJutSKn1k65hDY8Ig9jUscMyGWjNCtLo7Y1bHL9Eo=;
 b=P18u+QUd+IrZL/HedYkJUOrvE8lBTeZkzNFA+nc/2Mp0scBj/k5R9tFDOSlbpNu0so
 tPnmf3+I6ebSVJRkzp2XYJ1TWz9UcX1qq5ARN4Spk/JVJKILF6lC8Vza22g5Lw3VdqXr
 pvuWmr091l9Uf8JopVsOSmUSu8s1uGnQ6oAaGzjk+krt231/wnvUUDj8uFV4eIBQFXbR
 enasUZfbIW9Vm7A0e1rDDl5aGWJogX9e9b7Pt1El4YHNqC5Ecr9c/reUSwAO+ro9f7dE
 PWLeqFzKfAP1aBVpREkqNdBYSvLEK3XuL1FMqtDXQhtjIm0QnzVXWTET0ntklhUQGMRy
 UKrA==
X-Gm-Message-State: AOJu0Yy0sykBx0WmQtPMTzJFHKzA60xRsUFs/s0JOSgV1P15GlC9bTkE
 z6eX7YvZZZbI1JA4UUzxylLWp5Ju+bRxy/jfzvPJ14mOCuyA3J59aU3I1TjhVoIw+i+FQMTDtSf
 y5d66eTWnbsuQ5PJj0i023H9nNArhx5MZCA+mWgSdoAj7owxklGzTEF0tQwwlO1//R547jSyQ7u
 T45C+a1VrCo8Orgmos52L2+3DU3A5bjDmOfldCDpiWHS/U
X-Gm-Gg: AZuq6aIm63cWxhNab8HBjrVegXv+ewakKpBUxCpBC4HL/G5ppx1ZvjWs2277djCo/ko
 8qWJAyvYvfj2LKWuYLEPfaOKIDXJXATz+E/lnIuWNLM8/jpuz0N+Bx3TCDIMx/Nf2aq5T8BrlGZ
 SSGF7DcYBftyohFmWTjfhjjII8NY6dMtO0aRnOCp0f0PAvl84sMAaZNDYVpa9zdD/O8J0NNZpBS
 120uq1aZhxD4DgPeGu091zW72IH4qgXl7OoxyEWNAJe887idilZSegH+Sv+4i1QetlR/u8WHW+c
 Iezoayk/zlVXPkXfosko7SfO+RyRMs/ibmr2QoFSlgc61+U34SCwungLXhmNTTrlf4eNsqcoe9e
 qeKIA78HgcFWkPBzGxzjj+PPrbq6gpOmcVn05/qihny7e8LZhBUgcyBbCi863arBr0PswavpnKI
 dd+aH3DCuM7e/RAj0H+8q8rroltKQUJl9Yzdq4dB2RMDXbdT+uWgawdVuOk3/Dg1J2XGw6Jr8wr
 akaz5zOAl3TtqU=
X-Received: by 2002:a17:90a:da88:b0:341:88d5:a74e with SMTP id
 98e67ed59e1d1-354871f7af7mr1255211a91.29.1770182332674; 
 Tue, 03 Feb 2026 21:18:52 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:52 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 16/19] target/riscv: Add implied rules for Zvfofp4min
 extension
Date: Wed,  4 Feb 2026 13:17:52 +0800
Message-ID: <20260204051756.667397-17-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add implied rules to enable the implied extensions of Zvfofp4min
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7823508615..87827441d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2520,6 +2520,15 @@ static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP4MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp4min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2648,9 +2657,10 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
-    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP4MIN_IMPLIED,
+    &ZVFOFP8MIN_IMPLIED, &ZVKN_IMPLIED, &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED, &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
 };
-- 
2.52.0


