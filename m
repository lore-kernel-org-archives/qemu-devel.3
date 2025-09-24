Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F3ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UrM-0003t5-Jv; Wed, 24 Sep 2025 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmF-00071n-EP
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:45 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007v2-71
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:35 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-323266d6f57so200393a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740487; x=1759345287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyCevuOZBxjdSdzWhJH69VXeS030D/A2jQgzyM1Qqts=;
 b=UYiTbnrDNRSdIfhRWsbr4CkQbJenqgFs/coVDeWMVue69tNIDGNZPwTFg0GErEoFUd
 3/XI1qv8H8OYjaVVbcTGGo3VLo0x1aJMla07SZEWXJaT32ZdNmxtGrsXvVyVgaz2JvyT
 58yigGcmbydHcpNTlguIAzdpqg+zGr+NgQByX6GxUNXqHYRvkogW8a3lizkL+gsiombw
 ff8QgMu8Z1u9vlSoH2drCkqIYpFBTXeqPzSwqTZiNXQl5rQOJIbYCzORkShj+40GS58g
 WmJQVp7j8zTKVEHoLCnrR+G5AH4+W6DONNwcVmWTXROmKhDRW4ipm+vF/qaFRdHuASIS
 kM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740487; x=1759345287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyCevuOZBxjdSdzWhJH69VXeS030D/A2jQgzyM1Qqts=;
 b=wM406omQhDy0zSGjuuX3X8Xc846gy5ScR2yweDbfAGhQFyzuEm2470I4x0ufs9dyVM
 G3oOG1/Zm9DDanZCjyZruUcUmyNjg8Fl7dM7bL9e2lqK9A+c8jFh6Kk3lQOskC4u/Ph6
 gzQvx4+IsiekWevuaYZg/Ltt8d/aw1Nk4d0WnW+w6jLvlu2B52F/XfPy/Z2sywBi1PFR
 19C8qKrnWXJEvx3lmcp0qtvD2i7kZuwSsLpAzWZIEttPZPcPEh9GonViRFv+SfOR6s5x
 duQo3n626KaA9WaVLGWH1l44AJRRS0mN63imP8OyNKzykSLRQE/ocSTN0Z4pMqjycw7y
 Yx0g==
X-Gm-Message-State: AOJu0YyxY7DIXh219F/wYnstdtcRSzIt98gYbunWgxv1hw9LiEsQONqc
 7M6J5aw58S9JfVabhye/lcD6VHN+n+8nDwiBkUj5X5V/bZYfMMrt8QRCoF/lzwd5Fkm6bZVemP1
 vIp/h
X-Gm-Gg: ASbGncvG3iK5MUPXaiQG13vATjS14bSxuJ5sdVbrootuujIFgXO2WNlHBHVcKbDzIEn
 DgegX0RsgsIE0G3rQnvet+Y9Z/RzLIr3q0J6Bk4RWj6Pk8XkkOLfIBRGFJj1Tnr7mVFgwWGLnL9
 1Ewv3OUZoh4EzX2iys/Hbl6GskG6SzYSttBP95R+ksCZLeQFZMWs9a1MaRhPJI6LBkq3OUIbZ5V
 gmUzw04nIJJDe6JnaKsQinAMHPghSHbZQZ0oD8cRFs8MeXEGVD3mJfsU+1vYu/S9sSrAEz5QVt4
 +1jY2Eunoge6szc0bgVTcehrgUkCL7wzgAYIxyt9yxTeTQVM1dX3VDzlO0nm17hQZkKgGmQQxfg
 wElnqCEWKDGmgVlCajBtAXBMVyaM5
X-Google-Smtp-Source: AGHT+IEAJ+Bs5OtTMywz0Iu1RjGvy61lYf/y2xYuvxLD5C83uyJlMbBQEvAt0kF6lJY0NjwHw6/n5Q==
X-Received: by 2002:a17:90b:2684:b0:32b:94a2:b0d5 with SMTP id
 98e67ed59e1d1-3342a318acbmr789061a91.37.1758740486957; 
 Wed, 24 Sep 2025 12:01:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 26/32] accel/tcg: Move post-load tb_flush to vm_change_state
 hook
Date: Wed, 24 Sep 2025 12:00:59 -0700
Message-ID: <20250924190106.7089-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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


