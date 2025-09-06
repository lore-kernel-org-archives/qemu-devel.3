Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D6BCA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 05:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uulKC-0000ND-HR; Sat, 06 Sep 2025 01:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulK4-0000KA-Fz
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uulJs-0006oj-1y
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 01:18:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so12185095e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 22:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757135907; x=1757740707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkAyCPDIiOkuBSXCSpnCNIWVLui0hP9Os+Bwwzusze0=;
 b=IeVvfYh6/75Np0dhkOrt9c9TaFleuAR1SGsK9UWpYEkFCIxIdAFQKsnhikAcoEgF31
 wYcdCEWgYmlhOgN4Ypk48LmLs4vwVBVFw+I7OnV+m2Me3SFDikdOjf+3a4PhkLz7oMl9
 kXmI7nrSuNqmzlTbzoBG7HY+XAPIX88JCWbox5nOyDhyfV4DOlohDlR2PVY+Pe2Fgznx
 FCvCgbWvuvpaZeSm4En+muPOC85kqd5o3JvuXrfeDR/mqfM+cTZRkTrFeA8HZde5ES5v
 MD+IkGrcBbuZ0/fZpi60Cgib5jFPYIuk1nxVvK2qHdl1x9YsTRsPaUAfKOYRBvAF4GQK
 jl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757135907; x=1757740707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkAyCPDIiOkuBSXCSpnCNIWVLui0hP9Os+Bwwzusze0=;
 b=oCkf6SMgJLpPCXXqMaHPsZJU8K23nOBpVTy1Hx3uG79Z6lqs305v2z3CkYa/KdOZLG
 cHDHDz42U3A+9tVWtQjvWxnWJAAc/bg5bDWeUhBfDAau8FHdkJQokpZGweTLfPCmUMg9
 E1WnwQRPuQxNWfbpJrhJCKuU/75jRKXS19SqIpt9r9nwuEfIA95ziFTG2ARvClbhAeI0
 tXACxLkg1wAxvVOpJdsKbxTF/UGXv5pe0ILMhtNlZuRjoR5HYCnEPGvTxnquhoJBT4J7
 b+E0qHrDfIsKz+j2gKT5aQmZDSkzzuL08o2QvqpuqSrcLFH/sqFsjn6HQXGXEkxvmEBI
 b3gQ==
X-Gm-Message-State: AOJu0Yxypd3KweWDYNMdjQRoV5KzP8quteoLccKtj1n0w5y6T5lHTC9F
 fEuTPkK7sv1yM4kBwVImgntIOYNElUeby9g40TpswxOH6yQOmouyRuSfBDQmgYVCj0V7ReSmiZz
 fAv7q/Os=
X-Gm-Gg: ASbGncsxVZZlsop8r8MyLzPuT4wPB7s1eB10Wt7+55DSdN1an07/EI+rpasRMcwnr4J
 Dokb7vCLsxtjDat98GDzcOCf/gd+VZOPDKXurgCWmCMYYjwMUnmKAutTWI3ISkgfIK988EKGxUH
 S5gnogpGfWdHhTf2YH8Hl1ZBG7cDeWk0agZCkndBGJvkmJmAWHzFUY3104fifVmvcKuLSxzP9gE
 qEs38KRaDMaJyd1P45VHKDs0esuHqe0l0ngcnrhglAoyk55OJ667nzuJAenDL670CoyIdJMZffq
 gnPBH3WFuqkGBIfSvPyL31EOlgctgTdm5b9JCxAuVAoUkda+nAnmvY8GDA+JJZFa2L/3ov36oS9
 fupTks6XWPnVTWen8hwlry6mjdq9nyy96PHcrM9BunKapEW0F5yIi5oMt3fUvWvCgwlz+4DCP
X-Google-Smtp-Source: AGHT+IGXpd6hXEUPXfBL/PndXzMtuesXiAmPhqA3jq+gaxOx2xdLg2rEVRYR106izpa5y+Oheky/3g==
X-Received: by 2002:a05:600c:354f:b0:45c:b61a:b1bd with SMTP id
 5b1f17b1804b1-45dde220a2emr7328645e9.18.1757135906611; 
 Fri, 05 Sep 2025 22:18:26 -0700 (PDT)
Received: from stoup.21wol.it (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306c22sm441197735e9.13.2025.09.05.22.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 22:18:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH 05/11] accel/tcg: Move post-load tb_flush to vm_change_state
 hook
Date: Sat,  6 Sep 2025 07:18:14 +0200
Message-ID: <20250906051820.160432-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906051820.160432-1-richard.henderson@linaro.org>
References: <20250906051820.160432-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Move the call from cpu_common_post_load to a tcg-specific
vm_change_state_handler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c  | 21 +++++++++++++++++++++
 hw/core/cpu-system.c |  8 --------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5125e1a4e2..a0bc0e58c7 100644
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
+        tb_flush__exclusive();
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
index a975405d3a..c9099c6e7a 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -207,14 +207,6 @@ static int cpu_common_post_load(void *opaque, int version_id)
         cpu->interrupt_request &= ~0x01;
 
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


