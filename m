Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0A4F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8QT-0007Ub-DE; Sun, 08 Mar 2026 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8QA-0007Fw-8y
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:26 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8Q8-0001jo-J0
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:19:26 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2be06c02f66so3614257eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954363; x=1773559163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cU5ggE2u6aLlLixaS9h0GjEcrnhAydxbWKbYIqniY1s=;
 b=nbFQEx++gSd1Zw9Gt7zdkJ4+Ek5DzdIR4b4qoMoP/Jxqy317Ao3itjmp0wFjoyHth7
 AIPuujycKNh6i5LDyEudr21Gf2pXsqksFEpyLMJ5QmGVf3T6ePO+d89jDOkp/IK8fPDy
 wXU926zv8RlxUOTFCRgEKFc3wKFCWRuvJp5rc+OypTPV7f1wndlqw0prEnj0JsLsf/Sp
 izrYs6Y15F8MTzubra0fkXm2ttkkNLOnWW6E2DBiVYHDFnVk57wbXjAWekcNZLCTaZDY
 r3yzfW+hudpqAKI+o5CCQ6WxeVxELThGP2fcTPyd/nThCxpczwQ2wmaDmiZhSC6a0f41
 4B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954363; x=1773559163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cU5ggE2u6aLlLixaS9h0GjEcrnhAydxbWKbYIqniY1s=;
 b=Fw5/qDRkvlaF3jq0rmnt4tJKNX+mQhqMbXmaPIPEVf+PkeVYouu6uGtgK5XilrRG5a
 gtZxrTIbTWUDOgg7+RX/WsWGjtSXV0lw5xYyMFMLVB/dOBIA7McNrVmh2OzS0WVG3iR6
 2gcn0VmjqDQK2x2s6nUR3E3m9W4EfR6NiifRdUgI4vIXSIRte5qWD+KqdABc1AKAAb/l
 QYvy1LvOs0tXclLLtlILtmAyJk15B2KO3x1qaguFMUHFLf87RWA+HdW1pkyLgppn+giD
 8LUAquZ5PlFGoTWIupV9omzBpFDcZDuDsrkXQpiCvfWSwkzP50mIwlrlH+TYwj69jDRu
 3q2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBJxQocR9Pmx9uBqyBLomhSDwaVgaionZ4JpdcTlmyggrzZx59ALRPQ/M+v/+gwLltXDZxISMP4Bfc@nongnu.org
X-Gm-Message-State: AOJu0YyYMk6hcgbbbLVE2oUL8iUAh4r4g32VQgA/1FuWzOgHZy9EUMx4
 dSE9nAWTRPS7O4H+LirIRNRMMubC7zNRd4oHzzGacmFv2kqXsRdQsCpL
X-Gm-Gg: ATEYQzycohyKt1UkJopII5WEbDemTX05h31LRWlvVSxl+vxL7Sjyv0PAZv39Xgc5B2b
 5aWSAubHyCeW2tuP8prYejKbYwjH6Ty03dh9gEKYE48RAOkfPB7bkhjPSxTppYyygIZTgIfE1mA
 M1v3nYyGRDFJWCBHYpJTmFESINVaY4Oy59XtKp52QKofaIuRHMTYxdhRTni4p09fRO18radaeyJ
 Abdh/1znquIGBrLXz++iTaohChQIxNE4gZTdG4mTVDctykkhNtawfxYQgEG2/4gu+92hhHqFkED
 z/47AKN/v8uAi5BIZaYtK61eUwtiIz1lfhW93dxF0rPxWih6LFadRSq5Pb4SuPOV13bHLrQJFaZ
 CI2ABsEwNrqf0U6cVLqGXfL5LmFe52/IorCXTWMZY/Yk1gZ9Jqrjy8xwDX3p6qdCtBfgNJ9xk2B
 AoUgSdFMlw6ryynB+c627KayXO8LNROpJb3iSWrsgFWLIn4m5CS0zl8uO6wtFkDyfe3EdSCtFhk
 ee/jCeDoTsLZXu5bru1sX/Vwvd857j/uC56bg==
X-Received: by 2002:a05:7300:ed0b:b0:2bd:d04c:a430 with SMTP id
 5a478bee46e88-2be4dfdd7ccmr3082416eec.12.1772954363103; 
 Sat, 07 Mar 2026 23:19:23 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:19:21 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 09/28] target/riscv: track the exact watchpoint trigger hit
Date: Sun,  8 Mar 2026 15:17:12 +0800
Message-ID: <c36fc1572d3b7c947dae579f80c50e291594883f.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Extend trigger-hit tracking to CPU watchpoints so load and store
triggers preserve the exact matching trigger index across
exception delivery.

This simplifies the watchpoint hit path for the same reason as
the breakpoint case: the trigger programming code has already
expanded the load/store bits, size, and address into the concrete
QEMU watchpoint object stored in env->cpu_watchpoint[i]. When
QEMU reports a watchpoint hit, matching that object back to the
trigger slot is enough; there is no need to repeat the address
and access-type comparisons in the debug exception handler. The
remaining dynamic privilege and textra conditions are still
revalidated before the trigger action is taken.

This gives watchpoint-based debug entry the same precise trigger
information that breakpoint triggers now carry in CPU state.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 103 +++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 63 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index ef2fafcbef..eb03f306b1 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -586,6 +586,29 @@ static int riscv_debug_find_breakpoint_trigger(CPUState *cs)
     return -1;
 }
 
+static int riscv_debug_find_watchpoint_trigger(CPUState *cs, CPUWatchpoint *wp)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
+    for (int i = 0; i < RV_MAX_TRIGGERS; i++) {
+        int trigger_type = get_trigger_type(env, i);
+
+        if (!trigger_common_match(env, trigger_type, i)) {
+            continue;
+        }
+
+        if (wp != env->cpu_watchpoint[i]) {
+            continue;
+        }
+
+        env->badaddr = wp->hitaddr;
+        return i;
+    }
+
+    return -1;
+}
+
 static void type2_reg_write(CPURISCVState *env, target_ulong index,
                             int tdata_index, target_ulong val)
 {
@@ -1012,17 +1035,21 @@ void riscv_cpu_debug_excp_handler(CPUState *cs)
         return;
     }
 
-    if (cs->watchpoint_hit) {
-        if (cs->watchpoint_hit->flags & BP_CPU) {
-            do_trigger_action(env, DBG_ACTION_BP);
-        }
-    } else {
-        if (hit < 0) {
-            hit = riscv_debug_find_breakpoint_trigger(cs);
-        }
-        if (hit >= 0) {
-            do_trigger_action(env, hit);
-        }
+    if (hit < 0 && cs->watchpoint_hit && (cs->watchpoint_hit->flags & BP_CPU)) {
+        hit = riscv_debug_find_watchpoint_trigger(cs, cs->watchpoint_hit);
+    }
+
+    if (cs->watchpoint_hit &&
+        (hit >= 0 || (cs->watchpoint_hit->flags & BP_CPU))) {
+        cs->watchpoint_hit = NULL;
+    }
+
+    if (hit < 0) {
+        hit = riscv_debug_find_breakpoint_trigger(cs);
+    }
+
+    if (hit >= 0) {
+        do_trigger_action(env, hit);
     }
 }
 
@@ -1039,59 +1066,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    target_ulong ctrl;
-    target_ulong addr;
-    int trigger_type;
-    int flags;
-    int i;
-
-    for (i = 0; i < RV_MAX_TRIGGERS; i++) {
-        trigger_type = get_trigger_type(env, i);
-
-        if (!trigger_common_match(env, trigger_type, i)) {
-            continue;
-        }
-
-        switch (trigger_type) {
-        case TRIGGER_TYPE_AD_MATCH:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE2_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE2_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
 
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        case TRIGGER_TYPE_AD_MATCH6:
-            ctrl = env->tdata1[i];
-            addr = env->tdata2[i];
-            flags = 0;
-
-            if (ctrl & TYPE6_LOAD) {
-                flags |= BP_MEM_READ;
-            }
-            if (ctrl & TYPE6_STORE) {
-                flags |= BP_MEM_WRITE;
-            }
-
-            if ((wp->flags & flags) && (wp->vaddr == addr)) {
-                return true;
-            }
-            break;
-        default:
-            /* other trigger types are not supported */
-            break;
-        }
-    }
-
-    return false;
+    env->pending_trigger_hit = riscv_debug_find_watchpoint_trigger(cs, wp);
+    return env->pending_trigger_hit >= 0;
 }
 
 void riscv_trigger_realize(CPURISCVState *env)
-- 
2.53.0


