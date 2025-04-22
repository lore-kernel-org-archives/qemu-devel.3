Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE778C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIH-0002Pe-Lu; Tue, 22 Apr 2025 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIC-0002ND-M4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIA-00069Z-Ei
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so5238682a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350104; x=1745954904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1yx9YkYhatf0BqQ0DpUnwACHStmKGMnjqmqyTQwR00=;
 b=p/EsYfY3V81DGtCHyKkkbZji7mh3lSxIpj4/vODa93umWwVvoOYVOfwriUw0hwoVh+
 Jg1W1AroSEcyNRnj5eBuKBQN52UhSWL/BEeY4lp0DGxsTjRv/QeK7YaPd/SvbAFyJVnD
 /V3nFEtPkxpNf9aWkDi7e6nsT46VXdfUvJIto/Kzd5DKGEJBSYWGv9sWF0UK5+LaUOwC
 tLX5sMizzHertLnjtZg7SjKveFKimj/na3I8H7sCs9B8P5yoqXj9P+zWVj63EfN3bQzY
 hSZ0qx8s1FHx4CyppMgZMWQGRknv7ITaUE3bqbfbpty1l23o1EfXvDhC9SX/uAxcK4lM
 AQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350104; x=1745954904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1yx9YkYhatf0BqQ0DpUnwACHStmKGMnjqmqyTQwR00=;
 b=CzERWVB5qDWcbXrOsgvOTxJc4JsOeD2t/gLAGVi3aqS3Fw93hOvbiamglNYCSNx5t0
 1aaHtxHPiUKfb78W1Q7ZHIiL5ouXmWTDwzJ0S8FLZS37KbbNTSbjjLshSmppZf5JrgbM
 2tm/sZEE2RQvBAJZyNhH7z7q4It318jbmByzYZy4zEHXv8P8VVORTlE4EV3tycr2W/Iw
 JnDKRLkFnraDaID/KQWd+aGYZ2OsfDny+LHFot6ul3rtsTwWtJBizP5G8ajI+ZBf0hv5
 Ro+zOe1ljh0h4TusjP3If/zB1efbd7zBpZYvK0s9QELKOlhN9N0pIwXEi+oIYTSljrsx
 11jg==
X-Gm-Message-State: AOJu0YxXv0wWV7bU7mlhsOc/jnEGxIFfaQDvwNuZbYOo+h8R7Zk8HF+0
 0W3F7UHZCjpAejtLnBBgxmj8OaVVLyysWvMEEsG1vzQeNBUfAXJXaLldeXBuLI9GhDcDTyTXw8J
 9
X-Gm-Gg: ASbGncsLROXPrZKv2YtKIjPQ45sm9c5vjzo786AU/uKKyGSigtvpXtT4jRo1pC03xE2
 4NnXMSRqku+stdWxguvCesFZA4hFgdPKHD+6/C4Whq4heUOBc3CKicao3ShixGPvRKGl6FiSp/t
 HWI58BrC/gEBIgjTZIJeI5sTvlULqyPLyiTcPn6ChgBg+AeRoeAf0kUX1IhjCzQnNbsilwCk4AM
 vH7uJdoV9azqevTM3QyoZvF9mqPshduyx7yfdoNkIhisTQP1GyKkOdTIM1p4X98XxFCrHc9UcZa
 xWPt7kosedRbiSsVuY6WFBBwoxE/s5xkpywCLJKih8zR+UPz4/rAlUa2gdDFslqz2H8iVOqNfan
 vszmLQ3ikaA==
X-Google-Smtp-Source: AGHT+IFH4ijhVzDfLpoNMxKVJLcdgCKkca5HAeGWLy+fn6mpy1i0lksLHjt+Ol25VYPtRrPZ7cwI5Q==
X-Received: by 2002:a17:90b:5748:b0:2ff:7ad4:77af with SMTP id
 98e67ed59e1d1-3087bb6e9dbmr24385547a91.20.1745350104595; 
 Tue, 22 Apr 2025 12:28:24 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 006/147] codebase: prepare to remove cpu.h from exec/exec-all.h
Date: Tue, 22 Apr 2025 12:25:55 -0700
Message-ID: <20250422192819.302784-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


