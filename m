Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3DD10F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AJn-0006zo-D2; Fri, 27 Mar 2026 12:45:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AJ2-0006eW-Sv
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AIz-0003DQ-FH
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:45:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so25928205ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774629903; x=1775234703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXy9rBoaCMMTOp0VTinfarPcqqyC5TJjKb/l+a6N0ps=;
 b=xH6MTio6Pjdz3dToOQDa2R3dBe5k0De0kUiUL6rsOtEsaL6k9St2LxHL1WcuLcIpSw
 7jju5ci/ChbUuzdrVpj7zUeT6G0o7xTmH8xN3yHYXGpc0FJkb3BnA5M39CZ9oyd5nDq4
 1+RY8CenRTmrVcHPQ/aKLRgCzdc/vrkU/KgeHPoUO3GwYo34TFlMiI1nUNoaPH2psLNA
 43EqTWeWWJKGtJf4IblsoXRPoaLfq/QneqIG0xHHzCD/BJMZbwqCYl2RylNyZEc2FTM+
 Yg5qC+LZCz/0OZXi14xvTvpLHUL7AGj0T30+90hXzzzNH7laZ2Mr/Gic+ZSJHDUBM0TN
 g5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774629903; x=1775234703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zXy9rBoaCMMTOp0VTinfarPcqqyC5TJjKb/l+a6N0ps=;
 b=QBl4kB6u6KNEOHgHL6rok5ZFSPXr9mTbPOvRRy2MajqNzorzWrMth5BdFWwyA8g2Ir
 YmHQVxCfyCZM6XAlhdsZgjoB2KuF/JjJ7ZBOfM161LCKYNqiPlzGtINhd2z+Q8co1QOw
 TUwDXnmZx6KZTd5HthDmoQyl3t6PUC/LxNhWDWbtu73VqPIpUpgr/PeSn4bY9Gs6wOUz
 9mrQkQVpYx4d8edoctXxQAQBlRmQrMw2Rfvd6ZB2uWDKb6Irk4NvjTbGsIKGWqk/Iewg
 4b0w8pXk1orsuj+KnBhQvXupZZdd8/m1AlzaLvdl5VtxB7/xPNpZkcBzPTjKZ2B84ISC
 x7bQ==
X-Gm-Message-State: AOJu0YzcZKjYHDKZg6lY7bpKpl1lipzEjkXo6vtWYRw3Dj8S19XtlTv7
 IkJk+/ecFdKvcIFROxvhpA0pzYggTq9vpV6mdJWCuPpWJc6749nnwDe+79tl8CLGlRsMXrCUQPd
 R/rhTPSo=
X-Gm-Gg: ATEYQzzMrrbzixvNugjRqU7yPrU0nMn/m4ER+vYaOjxIHH2IZr1A68kXuL6GXjJ5kIk
 MbIpvYsyPxd0OM5V4s72awVYAILOio9lcSe6AcXdUgby92t6Ljvambd2XmVcNy7fgNOC9LzDtjM
 3QBtIgMJfFFhGm+Py0jE83Fqa1/5Je2u5jS4PCcPXpVZ6TUuUr//UcKmsYSsvM8F9ST9ODiFBRR
 ihImlpYlisOdkw2CE12nuuF1BxArCXFG8RZQ5eVNwRr6dILKgDLAcEETAggWtZq3hS1CPsIcs0t
 i+nVOdT/6BlE8U/mezv+A6gulcwPH9WsusxKkJq0V93F11tJymwrxN5s0GEut3BtNlUDk8cP0RJ
 SbQ6sVWntGLpdhzHpvcDYFPtz6d+SG9ymVZr/GoEXg9OwOZBf/tuXbPUNl7C3Prpd61g8SRP8ZA
 olkWbS1cB1EozWcbVcowQ+LkfphLEVUNv9XWfpKWtdCZMHmogOkCq9f04LnRHOramlSTampqlzf
 /Q5
X-Received: by 2002:a17:903:943:b0:2b0:b258:2a57 with SMTP id
 d9443c01a7336-2b0c4945e09mr58353355ad.27.1774629903000; 
 Fri, 27 Mar 2026 09:45:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc882339sm63890655ad.43.2026.03.27.09.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:45:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/12] target/arm/tcg/op_helper.c: make compilation unit common
Date: Fri, 27 Mar 2026 09:44:46 -0700
Message-ID: <20260327164449.596767-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..75ad53ec6c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index eb87eb63c1b..a2b944e81c4 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -69,6 +68,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -83,6 +83,7 @@ arm_user_ss.add(files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


