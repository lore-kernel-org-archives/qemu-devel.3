Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCABAC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSw-0005dH-BG; Tue, 22 Apr 2025 15:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSE-00043r-7F
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:50 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSB-0007LL-PE
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:49 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224019ad9edso79480395ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350726; x=1745955526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9hCTYp5xbc1UwKRhEJl2katxrg6RoRKPLw5poUutPU=;
 b=mFgmsxSgwWsr+B5lvIxF+GUF70OoMPt2jv3yMhMm3gh+Y3Ed5REdY96UMEG0GhGtQc
 2k2vY7q7PTSJJET0XDaQv9QnIxcFBK1WhlmNRPTB7hnVot5J7kWeXOEJCzTeTrwbRViK
 4ELSqzWTo6hM2DtnUe9u5oHEa9ADV5ixXwcm/KjwG4cBCmLIrAQhiT2beIqPqoxPyp3j
 4OsX4CBSbYKD+SK7dTRva4O+89AdR2qix76vBcLAO20yLoMETVMuxa1HxNQ8wLoWvvF0
 sjk7PvBADAZusd0WFysrKWeL1cMYp5R4dnHF9d3+yjx5mDSbX1fQqnhA8wDlhI5jhnMb
 39Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350726; x=1745955526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9hCTYp5xbc1UwKRhEJl2katxrg6RoRKPLw5poUutPU=;
 b=WbdfTFXf1nyu/+kMCkqmlGLD2bHzJ7Y8USvFlamcN1Ghle+UNqhqgUHDyzRIQGLJGz
 1w6LjuGPbQF4Agh8hxeh1SFFA+peNty2klkNsJ7MLnrGH2op/N+m8D2bNb66ixd2T0+e
 pZRz8/vcB4w3z1EcJ3aLWa73Lh+ma59T8AugD+eBOTQXsijXVcVUU4KEhM9JQP4wlKwo
 1yNH+6q9IzKV9nijR6obb03cg9cxlk7GRs1PB9cdU5rR6RPl+xb5W0+P8mL+/UwNvMr7
 I0eHQDxbLq822EFf3qau9BCv7hzl27qb470MakpaSajmWBTzFYVsTINPkcFHBFR3eIc5
 h3Dg==
X-Gm-Message-State: AOJu0YznXe5G5Ed9wVYlgZityHUaKywQo5Ov02IHWIghgePig4LVF/0e
 RiGpNcVqO+gEOcxU88nJcfJdDaQSC7jnjiTCSpZ75BZVf3zNF2FuDE85Yqn1rGPrHMbxl/QOAmx
 E
X-Gm-Gg: ASbGncuhbhtLOwXLgJWVTkXsalkOW7LdJHkIGN2yvOEspGoS3tAyNlQja/1xB8M2dKB
 yg3TBLL9Yjo30fnsPSmn08lJizld/Z0KYMCchlFCOjTYGwAPAZmAyRSYk0sUpvE4B75xgVDtitA
 x9AOlJqNV6oqw2ar8N/tPwnIX2+rK4pZEisClwtCmz8QJXFaoKfwZWhJgX038mdHK1h1eVyhUOb
 4GmP0FT1pLwNmZbtN9oU5yGB5rGQV4PuzOip6g5xmsZFa0jF8Rn2fVloY3c2XaesCGK6JsGtNr4
 i5qUWXPbRJ/BXFCh4Csy+Fwb0oAeqOkkGlJEPMV8IY89keM4OSobiewXZvP3ZVTCrCmObbMesOs
 =
X-Google-Smtp-Source: AGHT+IE6+ndLa99vawrNFOV77Qiv8JDm7j3LxrCmsErU5G20MqwCt8BnkQKlHyIbeFZbuHSyeaNgOw==
X-Received: by 2002:a17:902:f546:b0:210:f706:dc4b with SMTP id
 d9443c01a7336-22c535a3de3mr219606655ad.13.1745350725708; 
 Tue, 22 Apr 2025 12:38:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 129/147] exec: Restrict 'cpu-ldst-common.h' to accel/tcg/
Date: Tue, 22 Apr 2025 12:27:58 -0700
Message-ID: <20250422192819.302784-130-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{exec => accel/tcg}/cpu-ldst-common.h | 6 +++---
 include/exec/cpu_ldst.h                       | 2 +-
 accel/tcg/translator.c                        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename include/{exec => accel/tcg}/cpu-ldst-common.h (97%)

diff --git a/include/exec/cpu-ldst-common.h b/include/accel/tcg/cpu-ldst-common.h
similarity index 97%
rename from include/exec/cpu-ldst-common.h
rename to include/accel/tcg/cpu-ldst-common.h
index c46a6ade5d..8bf17c2fab 100644
--- a/include/exec/cpu-ldst-common.h
+++ b/include/accel/tcg/cpu-ldst-common.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef CPU_LDST_COMMON_H
-#define CPU_LDST_COMMON_H
+#ifndef ACCEL_TCG_CPU_LDST_COMMON_H
+#define ACCEL_TCG_CPU_LDST_COMMON_H
 
 #ifndef CONFIG_TCG
 #error Can only include this header with TCG
@@ -119,4 +119,4 @@ uint32_t cpu_ldl_code_mmu(CPUArchState *env, vaddr addr,
 uint64_t cpu_ldq_code_mmu(CPUArchState *env, vaddr addr,
                           MemOpIdx oi, uintptr_t ra);
 
-#endif /* CPU_LDST_COMMON_H */
+#endif /* ACCEL_TCG_CPU_LDST_COMMON_H */
diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index 63847f6e61..74761ba5f3 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -67,7 +67,7 @@
 #endif
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/abi_ptr.h"
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c53bbdef99..034f2f359e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,7 +11,7 @@
 #include "qemu/bswap.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/target_page.h"
 #include "exec/translator.h"
-- 
2.43.0


