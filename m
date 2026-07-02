Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C44C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKwN-0000Jw-Hc; Thu, 02 Jul 2026 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKwI-0000J4-KI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:11:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfKwG-0002Un-KI
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:11:02 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37cab825ec9so2224244a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783012259; x=1783617059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TEjRBe7VBaAE6CoIJmyeuVYkGDzs+ItPUGbcShRXyGE=;
 b=puILz3vtDQ8XNMeXGv3HX+v9DEgEqiS+0fjC5Naig7Wy0ofD0lKXgotBSiPntsSj6J
 IlULLdW+qNLJoTo71IPBwcBG1HyHhWjR8LqtwBxKNhDpW3SrvOSphiqVbsdCO/fb4iZi
 z4u09qeiisVC0myj5Gw35GdJSDVg28swGYykDZo+XA0DlUmjqOp+Cjv8Jykcs9pvU5L7
 kdSzqO5qrMSorxOzEpuDHJqr3we8hFz6FYDabhyVSKqj/Z8DGfgkSM261UGxRWmItUOM
 WM3S6UoYGFwEz2zVIcigegNXJqxKOhqu+x4/3TEjJ9o4N2z+ZIdnCApN/Hz+4abs168Z
 J1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783012259; x=1783617059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TEjRBe7VBaAE6CoIJmyeuVYkGDzs+ItPUGbcShRXyGE=;
 b=TIb+ROxZ32UKoaEU0QUh69Q5pd1D8NPz+sogtmdyH0RlEc1/w/WLAfqwQH5xcb1InJ
 HRT/ETpDtodQuIvGwHtJEgGiRYR7/gjeoVz39CWlL8EZS9zIX7rzczhS43Dl1JsLtaBV
 1N4XGmcrt5gXjpKKVJ9bXMoC5wulZQ7f3h9Mtro/w07mHn40gUcLu7+pU1c1dqWdLqkL
 ONyvYzBtUA0NTmbwPFUOogQs+VHSuWxXTx5QIWx3wbtDRDILe+QmVuLg/W1WHKIOmg8X
 7K3j9++X/eAZD/D1dp8gwffD5dArRDXikqhpaaCY8fSQCHbMMquDSV8iCfHZyxuY1ru/
 3Dgw==
X-Gm-Message-State: AOJu0Yz6h2TJslHDAQ+CRRP9FAtIvJnCplZ1uQtssSJhyOpcUBqDnjc9
 rkc/4V5NwpLcOww0DP0+LOS/UttuMatkjZ0Dq+pY0tKOBhiSwyStXmlWql9f+Kr7djKpWkpQG9y
 DciE9
X-Gm-Gg: AfdE7cl8GBFhoMKKCccEqQL47yAnEMCTMq3dXrgVy82hZ+5wf17wmhDIpkM4STqexiY
 rq5IlwMBP5ZylDCz6llDCLuaAvQkfmJkx7Ycx4WwrepHG+MUXCU9MMX/CGcbvA17Usws5QgeAp5
 kv4aOdZdQfRCS2298YJNBD65tVYMrsZESmKoBL53RYjjor1cnuN05aWhkMU4oVECxAzE/ia3kBH
 /zRxXx8awiitDMAlSnuSoTZkm/xjn/QsHUz3lzjCEEJgsZqC9Q77qUPCOLSvB/Y7EL2YnQe1n+3
 JVtRFO0/Fn2PJEG6rBcFZqeQ6FY/3Ct9e1jc/+CQowsnW70lGvgezSfT9WfHu7ewM8JzDM3pzIB
 qbn1m1uSM54yK8gN5D0QaVFwLzEiendZGhvNYHb4Mj51eJWEDXGNFFYmO0fuL4mI9o5qug2dx7s
 SY2iXdSMFXb9clXL4491By+tVGHABblbPvUBNCw9zmKMocQUYNiTG84l5XJGav
X-Received: by 2002:a17:90b:184e:b0:37f:bd85:38b5 with SMTP id
 98e67ed59e1d1-380aa1a4117mr7101939a91.22.1783012258497; 
 Thu, 02 Jul 2026 10:10:58 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-380e165be46sm1427026a91.7.2026.07.02.10.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 10:10:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
	qemu-stable@nongnu.org
Subject: [PATCH] accel/tcg: Use TLB_FORCE_SLOW not TLB_MMIO for user-only
 plugins
Date: Thu,  2 Jul 2026 10:10:56 -0700
Message-ID: <20260702171057.47998-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

In 6d03226b422 we set TLB_MMIO to a non-zero value for user-only
so that we could return a non-zero value from probe_* functions
so that we could force callers like Arm SVE vector moves to use
the slow path rather than direct access.  All for the sake of
exposing these accesses to plugins.

Back then, TLB_FORCE_SLOW did not exist, so TLB_MMIO seemed like
a reasonable solution.  However, user-only doesn't really have
MMIO and this has knock-on effects, like forcing Arm SVE first-fault
vector loads to stop.  Better to use TLB_FORCE_SLOW as a more exact
exact trigger for plugins.

Cc: qemu-stable@nongnu.org
Fixes: 6d03226b422 ("plugins: force slow path when plugins instrument memory ops")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/tlb-flags.h | 7 ++++---
 accel/tcg/user-exec.c    | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/exec/tlb-flags.h b/include/exec/tlb-flags.h
index 357e79095c..e12cddf234 100644
--- a/include/exec/tlb-flags.h
+++ b/include/exec/tlb-flags.h
@@ -27,12 +27,13 @@
 
 /*
  * Allow some level of source compatibility with softmmu.
- * Invalid is set when the page does not have requested permissions.
- * MMIO is set when we want the target helper to use the functional
+ * INVALID is set when the page does not have requested permissions.
+ * FORCE_SLOW is set when we want the target helper to use the functional
  * interface for load/store so that plugins see the access.
  */
 #define TLB_INVALID_MASK     (1 << 0)
-#define TLB_MMIO             (1 << 1)
+#define TLB_FORCE_SLOW       (1 << 1)
+#define TLB_MMIO             0
 #define TLB_WATCHPOINT       0
 
 #else
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7704e4017d..e4629b837d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -769,7 +769,7 @@ static int probe_access_internal(CPUArchState *env, vaddr addr,
         if (page_flags & acc_flag) {
             if (access_type != MMU_INST_FETCH
                 && cpu_plugin_mem_cbs_enabled(env_cpu(env))) {
-                return TLB_MMIO;
+                return TLB_FORCE_SLOW;
             }
             return 0; /* success */
         }
@@ -804,7 +804,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
     g_assert(-(addr | TARGET_PAGE_MASK) >= size);
     flags = probe_access_internal(env, addr, size, access_type, false, ra);
-    g_assert((flags & ~TLB_MMIO) == 0);
+    g_assert((flags & ~TLB_FORCE_SLOW) == 0);
 
     return size ? g2h_vaddr(env_cpu(env), addr) : NULL;
 }
-- 
2.43.0


