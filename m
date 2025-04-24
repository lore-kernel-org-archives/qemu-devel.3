Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66768C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmh-0005BF-Vw; Wed, 23 Apr 2025 20:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmd-00058G-IX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kma-0004IT-OG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:43 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso358746b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455779; x=1746060579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1yx9YkYhatf0BqQ0DpUnwACHStmKGMnjqmqyTQwR00=;
 b=Z+mYzs7xyoV/qA0Nd7Sds0Mc7BlxWIIIxccFODiQ3JwdhkVoBRWcITU3TjNbN57o2l
 V9iS0eEljClHEiftpdJh2G27zANDssXFkJsVIUUe9G5LZTDx5upsdtVSNRMVOB7yQEnX
 Klg5PkwJ5G4AszAPTyR5rGmPgl7Yty+EqXgoImhN9PSZ98Qkaqupf1PEJj5tQ8oMBNt9
 CXV6bCP4DkpYKLbRN6PjKFZebjrmG1mJcnszN4Ze5mdu1em/PLWiSTblxJh6yYBE4ORY
 D6CswNZHH2T9DDmXroMxO/5XG0iwc0wJzj71Nd1BPD4uXp92OeGXoK9ZwmjlUBlKI29t
 /mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455779; x=1746060579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1yx9YkYhatf0BqQ0DpUnwACHStmKGMnjqmqyTQwR00=;
 b=o0qhybhn6ItKrD6xrfUW8/aV55aolLlaqFVJ40FqUQnRBQ8zqWCfk3lDQDpisVOjOU
 7CU1VzteXvDCUJlnvk4TD/E4vuwIaO1IeK9Nu8ocenamcE3Vu7hWkWtfuNohqSJWiD59
 7wnEo5lyihbNWMJkTuaIoHfFu9e/kCHK0NW15PhhuppXC7UZNM/GNmvnC8ERtYT5vNYM
 lIbPcmqqK2uctxAgnzrIIA8ljFc8Rfb3q3UHnY9HpsyJNpPlzW0wwq6x40axBeQammDn
 WwU5MgXCw5H72qFKImgHtif8GzNHYXMXJB4pJbkq6pW89bN+ujqw+dOuuf4N1M1BDJWa
 bc+A==
X-Gm-Message-State: AOJu0YzmfoFtbdIQwiRbkf5wQTr9HSzn9RHEBd7Jl4FvCEGhBXvQ5N6Q
 lQ76CnUvaR8g5JPwCZR1EA8tEXF3OvU/k6Na39w5Btf/XCb0/W9rR6CkS9bDpgarLd2qNoj9sCW
 s
X-Gm-Gg: ASbGncuxSYGTvgtuqHY5wi1iyAtUmjaaoPIBtW4LLdVps5nycciWQgC/Sz/AGlPJN8W
 YxqEOPa4YLrxwxoRy+J5C4AQ7CF6Ikgz84ciUIcyL9Yowh8iNNQkYt6ghuyLknj2W4XYdH92SpS
 bhYq8jWor2YEb+iULXDlvhDmgfD1GAKLrJSUVW2uDaXiuZXc8mVVfIRqbkz0WPbh42muZwAU46K
 wIFyBfpgCINSe/H2xkAWIdSfnKdETbm1cfO02fBbHU3dpubLuyXWgSzlPh/8ieSmddAZZekZ1wm
 3j+zsLJZBRW7xzsWAA9nAQNc2nTGydUza5Z4Dak+bpVlQlGQe1WFb/DWyY6y1g38pjb2EwcayOI
 =
X-Google-Smtp-Source: AGHT+IF/zzFtMqQxRLYlLarEZHiggyycaTVH21mHm8p3axwCDvtYkFZGfxygeLrDrnLTXCaBGrJceg==
X-Received: by 2002:a05:6a00:1947:b0:736:b400:b58f with SMTP id
 d2e1a72fcca58-73e2660902fmr738730b3a.0.1745455779398; 
 Wed, 23 Apr 2025 17:49:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 006/148] codebase: prepare to remove cpu.h from exec/exec-all.h
Date: Wed, 23 Apr 2025 17:47:11 -0700
Message-ID: <20250424004934.598783-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-7-pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h           | 1 +
 target/ppc/helper_regs.h       | 2 ++
 hw/ppc/spapr_nested.c          | 1 +
 hw/sh4/sh7750.c                | 1 +
 page-vary-target.c             | 2 +-
 target/ppc/tcg-excp_helper.c   | 1 +
 target/riscv/bitmanip_helper.c | 2 +-
 7 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583b..bc46b5570c 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_H
 
 #include "tcg/tcg-op-common.h"
+#include "exec/target_long.h"
 
 #ifndef TARGET_LONG_BITS
 #error must include QEMU headers
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346d..b928c2c452 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -20,6 +20,8 @@
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
+#include "target/ppc/cpu.h"
+
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 201f629203..a79e398c13 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -2,6 +2,7 @@
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/target_long.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6faf0e3ca8..41306fb600 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
+#include "target/sh4/cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
diff --git a/page-vary-target.c b/page-vary-target.c
index 3f81144cda..84ddeb7c26 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
-#include "exec/exec-all.h"
+#include "exec/target_page.h"
 
 bool set_preferred_target_page_bits(int bits)
 {
diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
index 5a189dc3d7..c422648cfd 100644
--- a/target/ppc/tcg-excp_helper.c
+++ b/target/ppc/tcg-excp_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
+#include "target/ppc/cpu.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
index b99c4a39a1..e9c8d7f778 100644
--- a/target/riscv/bitmanip_helper.c
+++ b/target/riscv/bitmanip_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
+#include "exec/target_long.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 
-- 
2.43.0


