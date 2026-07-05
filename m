Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F2EC44500
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEfE-0003bB-80; Sun, 05 Jul 2026 00:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfC-0003R4-6p
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEf9-0006KJ-8x
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-8479f1a86ecso1096202b3a.1
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226462; x=1783831262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lp+19HN1hDJRD/nyQTZDKaLa3PwvYZGSdAI5w9aXD2A=;
 b=Tm/77rzeuVGtDOkeLoJjHRKT6uVoS9K8GJo8roiNq2X58+jSwHxQBHo4l1TyzqYmLX
 CblQEANpICtc4qAnryaTKH4+uPPWhVd7Zc6SdVgrZPOC6DdQy1TQWd03h/ak7i/l/oI2
 3MVbdcmKrqQ7YGL+01iZFCXBV2BdjX7dwWozK4UBkPfUQptog2SJPyXW6tv9hDt4WZ27
 Z/Ei8umF+M5RMM5vMhM7xpIsD3i/E8z8YGHat+Bx3Hypq45BJarMTv9y62fw9DjGj828
 WEQ/5IlMkJCwgDo2nC1IyN8P+LjYpGH5Z1A7UyyXRUAZMDDblezWEH8HQjpkDVyg6dwg
 JZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226462; x=1783831262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lp+19HN1hDJRD/nyQTZDKaLa3PwvYZGSdAI5w9aXD2A=;
 b=r9XinfymdVa87ufhWX25bCYreav5RBX3iOBWbpLb0Ku2s3lohkIlGP/TwQKzmFdZcY
 MWrHJMTVhi2uak7/B6IfkkkqQJT0PxfrbVUz2/nxwdTVR07rLc9kUSzS/LtQYkHFM3yX
 SJ37GI3621TmXzy3ds1j3IECgoARHjwV7tyAwK/FDo97VJmjiLpo0KMEJvi5AtbjGcki
 6qdu3jBIgyA7RTu8KyENmXw5DJ2dYByiUVLKsLuMjzvLDWr6VhCdAZoTPhNuluFCbF3k
 RrMDJr/O1OEgXlJ2YX3ll2ZtEPhSOdqvpiXKZqtCARkxizITV0jhOGCL43WUzXkY0b4F
 X6wg==
X-Gm-Message-State: AOJu0YxWACRVMLLwLoEdobHHn3NSlzwVWsnonUYOLz8hC6h5Tl5n9N5B
 Sgd6IxlYnLonhvbyK6cg9zzstzdsTwAZyKrwKXeRmFoiZnz8MURJZO7ljU/jUcv6v/Q/hAsidnO
 og0wo
X-Gm-Gg: AfdE7cnxpmQCjDengnffeUEzOAfhUWu/zBHsap95kpW17BhdT+ZgRqTC9kMN5L1vjT0
 Wk1n8KFBrXhDEoEeWfyRESn7DpOEAkJTqrVDwvycXDkFJmgxAuLWdDnXVdiaHJyq0Ptlp4OC0Ja
 fhO4Xmv70+xA3NrJ0/wJg5XqUL1+ckvlacQ8fpua6vxamWuYW9FZ/KW4HXUkeA4+k8J4Wdh1i4M
 RqMZQQ6+MJN1perpum0Sxso0zVmfT8jiyAS3x3xF1e1j1QGaa6StQJRPeqiRmy3KipmA1exwNDZ
 DqsdekVxsCvV2xYeH+bjsuhTssddYzCxLkQmF29e+I+9RuMkKkp0CICC0cUoUmKIw0NNL9GmLmI
 CAvm3ESltfPugjqbszp++uKzcWcv3JAZj3+VrnZXS8Ei3AFP7nkd/RZlFNsZ2aPeprbuLscjJrC
 YCB377MDbVntwpeJfUqlp4Om2yhh0u395k0um6HIA1NQj9iEE9m2sIJlcpDw==
X-Received: by 2002:a05:6a00:a383:b0:847:871a:94d3 with SMTP id
 d2e1a72fcca58-847f6f369e1mr4758980b3a.44.1783226461531; 
 Sat, 04 Jul 2026 21:41:01 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6952a0dsm1952615b3a.0.2026.07.04.21.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:41:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 40/46] target/riscv: Set badaddr in
 riscv_cpu_debug_excp_handler
Date: Sat,  4 Jul 2026 21:37:19 -0700
Message-ID: <20260705043725.1373137-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Setting badaddr in riscv_cpu_debug_check_breakpoint was a minor
buglet as that function should only be testing if the breakpoint
should trigger.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c | 4 ----
 target/riscv/debug.c      | 8 ++------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index c318dcd633..f9556c04a5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -2373,10 +2373,6 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             break;
         case RISCV_EXCP_BREAKPOINT:
             tval = env->badaddr;
-            if (cs->watchpoint_hit) {
-                tval = cs->watchpoint_hit->hitaddr;
-                cs->watchpoint_hit = NULL;
-            }
             break;
         case RISCV_EXCP_SW_CHECK:
             tval = env->sw_check_code;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 994a77fd31..f4689519d8 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -919,6 +919,7 @@ void riscv_cpu_debug_excp_handler(CPUState *cs, CPUBreakpoint *hit)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
 
+    env->badaddr = hit->hitaddr;
     do_trigger_action(env, DBG_ACTION_BP);
 }
 
@@ -929,12 +930,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs, CPUBreakpoint *bp)
     int i = bp->id;
     trigger_type_t trigger_type = get_trigger_type(env, i);
 
-    if (trigger_common_match(env, trigger_type, i)) {
-        env->badaddr = env->tdata2[i];
-        return true;
-    }
-
-    return false;
+    return trigger_common_match(env, trigger_type, i);
 }
 
 bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUBreakpoint *wp)
-- 
2.43.0


