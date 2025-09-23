Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BC8CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay7-0006Kx-Sm; Tue, 23 Sep 2025 17:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay3-0006JJ-OB
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:35 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay1-0003ie-0E
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:35 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-279e2554b5fso3463645ad.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664471; x=1759269271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyCevuOZBxjdSdzWhJH69VXeS030D/A2jQgzyM1Qqts=;
 b=FSH9XLuVVLy4NYY603pw7fDI/XocqrL2tmHgfqpqCeOZ+H8W+IGNmO0/CHkgxjKAlF
 KckV4EG0zfTkpDIXq+s/CnhOnO+vCA9jImhN+FKD3bNmWNcWQfWC8aI1kxlsqMuBxkZ6
 RC9fv43QePUJhHJHEIFboOyJFQzWcqIv2dEqH68aUVdGvFNrjfWNW7uB/1sEPAXDTyF4
 XuZwo8kDsKzopW+c8CuYJk2TBtXM7VscHEM38gTEkUqdyMUMK+6NbaNPvA9ZsS0FTZRB
 7RmKZG4bTMkncojeoyGTyLsNEAcSo0NoiiZFqCV6Mxlg9rlLxd7C3wFds67YioI7tGS4
 aOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664471; x=1759269271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyCevuOZBxjdSdzWhJH69VXeS030D/A2jQgzyM1Qqts=;
 b=w3b57C7CDY35dFCBF9Nk30noPnhitzgkG0I6hUCePHzD72neayudCVJjc1pR7iCUY8
 1u6Gg/3VVGaY3cCqTL2UwXQ6hpdwGXyRxkbu1DpExVYBy4DhxoMj3Tu6awNtpcFN9MlV
 WlDhC/TbVA+xOcf8ItVMsIUeXdVe961aLCJlKwejUCu3fo8FaVIAKotVZTsJpn3TWMp+
 HtSHhBAEfciZehNzp0js2m1kWtYtFOyC0CZu64ekYn6ZMxkd96Sv+kwSKWg8pCyCPl+A
 BeJCH6NR5BVnZE83o5Son5j3sRzsNe+3+/AWx+VekRDoM6ZOCP7Y7PZ2m68zmUwKuHXW
 3pQg==
X-Gm-Message-State: AOJu0Yz7h6AtUP50bcdY74DQCGP6Zctaki/0okMix7kPwch0ZpLZIGvT
 fZ+XHm/xHIjaTWinBCuMOrB0TTnnjH6u2K4j1ymUK9r9tlgDDzv6+B/VtHpNJFz8PRS8aScb4RT
 D5Csg
X-Gm-Gg: ASbGncvl/dcci943Pp+l20naQs64B0UqXw7FI4Y02xLQ4eiVKuv/2mfGDAz+cahdE/M
 /rblXjE1TDJP5CKCDd04fUpPTGVynGxZKma+atdPkpH2PZcDSaRAdP/WQsVmZHBp1wcNsbH7wkG
 A4afnOkDY91cvNw/A9Nm6qcKQENNYRcc7cM8REZROETC+95GlYiQYkD8UiMLg3O1hehRJmG/a+9
 CZ2ZZUFMkeu2uQskydR5hvh29ZHy/1YpiqY2wy1JqGIhZ1elNbMNbNAnHBbfig5t4V3mc/KUvRj
 V40l+DcIFoCLsMKdTN6PW7CBynbsvTcblSDX6mmMGjzQFBubr5UFTgiMX8uDR7jmW3d9iNn8qoD
 8wev+Pt2agpg3EePNCnNexGFkXnek
X-Google-Smtp-Source: AGHT+IFzzV/MEWIj7fjPW8nwQCJZO/2VGgCI3t1y/MiNQVrW6WH+QNjzbxT/ls5IPSjLTzx80U4a8A==
X-Received: by 2002:a17:902:e752:b0:267:44e6:11d6 with SMTP id
 d9443c01a7336-27ec114dca0mr2219105ad.6.1758664471243; 
 Tue, 23 Sep 2025 14:54:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 06/10] accel/tcg: Move post-load tb_flush to
 vm_change_state hook
Date: Tue, 23 Sep 2025 14:54:20 -0700
Message-ID: <20250923215425.3685950-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

We need not call tb_flush once per cpu, only once per vmload.

By moving the call from cpu_common_post_load to a tcg-specific
vm_change_state_handler, we do even better than that: we only
flush when called from HMP triggered loadvm, when we had old
state to flush.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c  | 21 +++++++++++++++++++++
 hw/core/cpu-system.c |  9 ---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5125e1a4e2..18ea0c58b0 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,8 @@
 #include "qemu/target-info.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "exec/tb-flush.h"
+#include "system/runstate.h"
 #endif
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
@@ -82,6 +84,23 @@ static void tcg_accel_instance_init(Object *obj)
 
 bool one_insn_per_tb;
 
+#ifndef CONFIG_USER_ONLY
+static void tcg_vm_change_state(void *opaque, bool running, RunState state)
+{
+    if (state == RUN_STATE_RESTORE_VM) {
+        /*
+         * loadvm will update the content of RAM, bypassing the usual
+         * mechanisms that ensure we flush TBs for writes to memory
+         * we've translated code from, so we must flush all TBs.
+         *
+         * vm_stop() has just stopped all cpus, so we are exclusive.
+         */
+        assert(!running);
+        tb_flush__exclusive_or_serial();
+    }
+}
+#endif
+
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
     TCGState *s = TCG_STATE(as);
@@ -124,6 +143,8 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
     default:
         g_assert_not_reached();
     }
+
+    qemu_add_vm_change_state_handler(tcg_vm_change_state, NULL);
 #endif
 
     tcg_allowed = true;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 09c928c1f9..f601a083d1 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -23,7 +23,6 @@
 #include "system/address-spaces.h"
 #include "exec/cputlb.h"
 #include "system/memory.h"
-#include "exec/tb-flush.h"
 #include "qemu/target-info.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
@@ -207,14 +206,6 @@ static int cpu_common_post_load(void *opaque, int version_id)
         cpu_reset_interrupt(cpu, 0x01);
 
         tlb_flush(cpu);
-
-        /*
-         * loadvm has just updated the content of RAM, bypassing the
-         * usual mechanisms that ensure we flush TBs for writes to
-         * memory we've translated code from. So we must flush all TBs,
-         * which will now be stale.
-         */
-        tb_flush(cpu);
     }
 
     return 0;
-- 
2.43.0


