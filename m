Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AEBC98313
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 04:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgxus-00019e-SC; Fri, 16 Jan 2026 23:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxur-00017K-4s
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:28:01 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vgxuo-0001cQ-OX
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 23:28:00 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c227206e6dcso1718617a12.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 20:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768624077; x=1769228877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7WkHiVNJCD9TWHbxn4o1h9ogKNZelcybfMD61+3Zog=;
 b=UIJbqYWCO7eEpf1YYz1QR4+V0xuqtHEdZICDVtJNFGVXoNbwcHKKOC5JOFnb5J6Nao
 RyKch/70YtlDGDV0qgB7syPPJ4wsNgVhYLUNRdjpLnV1oXL64xNJBO/CPu6udtBpCGK4
 xH1LFJ1hTIkgpmzG8jriibYqdr5GWrSSpb3jzRm6QrDd7INQgxiwpfiswR0MmplVcTdi
 9lkp1yGjrF1l1wLX8LqtI6H7SCP2HqbytloncgcbImq/989RqTpDx1D2wuQcL5zr9BiT
 S6uIa5ZJpkcAXLA1X6acrpdJXZi4Rrpk4EojhT6uotSKfgGPqu8gwWebvBH0QpKpVm/6
 bKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768624077; x=1769228877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O7WkHiVNJCD9TWHbxn4o1h9ogKNZelcybfMD61+3Zog=;
 b=wrZWKsjV38XaCx6H7jij3/RxVKhhmBGrJypWd8eGzk3AXSMWk1ertEYIUpLRZrMa+S
 kNrWOS6yBA38NNQ7Yeoh6Hpuh3rUJzjM0YMnh6s6EwigdVeCdlOPPKVmIK8OJiRrD0GB
 DFc+TkyFnrlcpFLm5uh5byc7ZAKHqpfYQDvLAzmTGMR7uqpu+vQQ3G/9uPlTrZZahoP5
 19sAk2OS2/eToQ1ckG1RrJDvY8oDkNhntWudxxkP0f04IzedQlVYbYyrcYByZf/PndZ6
 vnzDmk5e5ABdC2FCeXr7+Ovxx0jYy8oRa7jQ0kDx/udu4AHger69Ivl/L5kTcl/I/4We
 g9uw==
X-Gm-Message-State: AOJu0YxmCcL1tF+BjBpXGpwyKos1hnASKOqMDZqq4WzPsCrk72L5WPsQ
 SHbEuft01Phbd62WSc0V06i4t9xsMOJzSzht+97yOkSZPfM/BbOX//DhlWfa6PBCeJ0=
X-Gm-Gg: AY/fxX7JHry8GEFet5Ky7a/m7kDF4Stoj3TwP85I98no69nR0ChSvtBNmwQJJ4uWh13
 Atkyi73g9Gdx8vtR2AmKIvgwWkL3HNRjUmkZSFl64pJdWr+r6Kv1ijvZe9omFiL9VKzpO3DDr0C
 eQKQgWPl8bMPfXZB7dkNH78cPhkeStpfgjRThn5zdtDjMMAzaMwbiLZ6aux/cljzWnnPkw5nbhB
 +sLn41DpZYcBA+hEwSf5Gphp63w6eXCxBa/W48a1FCKJ2870O95IfbJcsxndYr2pq1oSy08lYnc
 zj8x8vpYp5jQRshwcm4Euj7wlq4F1CEyJ8bLXWrB+iDCqEcF/Xpjk9LsQ05OHs+a6dGyV+UjztX
 u/Cc8lDcw6AHgIHmNTnw75HX7azj7Tnx4/Wqw2hYn9hpY/Bfg5GOveDJaX5MYDDwQw2YHZ9HQpI
 j1tQeAUQHuZgNLeUh3qSw8yET/PLIOt9OEYepUn1IXxj5QODRoAgN4yuU14wpaIpEedaFBS/hw
X-Received: by 2002:a05:6a20:2d08:b0:366:14b0:1a30 with SMTP id
 adf61e73a8af0-38dfe7c6703mr5554337637.62.1768624077548; 
 Fri, 16 Jan 2026 20:27:57 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([114.88.97.170])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf395851sm3273056a12.36.2026.01.16.20.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 20:27:57 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, wangjingwei@iscas.ac.cn,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [RFC PATCH v1 7/8] riscv: add sdtrig trigger action=debug mode
Date: Sat, 17 Jan 2026 12:27:28 +0800
Message-ID: <ac27935b3e3a1cac4f2ecaf521992a68f4c842a7.1768622882.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
References: <cover.1768622881.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pg1-x541.google.com
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

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Allow mcontrol/mcontrol6 action=1 when Sdext is enabled. When such a
trigger hits, enter Debug Mode with cause=trigger and stop with
EXCP_DEBUG.

Also report inst-count triggers in tinfo and read their action field.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5877a60c50..4e30d42905 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -110,6 +110,8 @@ static trigger_action_t get_trigger_action(CPURISCVState *env,
         action = (tdata1 & TYPE6_ACTION) >> 12;
         break;
     case TRIGGER_TYPE_INST_CNT:
+        action = tdata1 & ITRIGGER_ACTION;
+        break;
     case TRIGGER_TYPE_INT:
     case TRIGGER_TYPE_EXCP:
     case TRIGGER_TYPE_EXT_SRC:
@@ -280,6 +282,7 @@ static target_ulong textra_validate(CPURISCVState *env, target_ulong tdata3)
 
 static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
 {
+    CPUState *cs = env_cpu(env);
     trigger_action_t action = get_trigger_action(env, trigger_index);
 
     switch (action) {
@@ -289,6 +292,21 @@ static void do_trigger_action(CPURISCVState *env, target_ulong trigger_index)
         riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
         break;
     case DBG_ACTION_DBG_MODE:
+        if (!env_archcpu(env)->cfg.ext_sdext) {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+            riscv_raise_exception(env, RISCV_EXCP_BREAKPOINT, 0);
+        }
+        riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_TRIGGER);
+        /*
+         * If this came from the Trigger Module's CPU breakpoint/watchpoint,
+         * we're already returning via EXCP_DEBUG. Otherwise, stop now.
+         */
+        if (cs->exception_index != EXCP_DEBUG) {
+            cs->exception_index = EXCP_DEBUG;
+            cpu_loop_exit_restore(cs, GETPC());
+        }
+        break;
     case DBG_ACTION_TRACE0:
     case DBG_ACTION_TRACE1:
     case DBG_ACTION_TRACE2:
@@ -441,6 +459,7 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH);
@@ -448,11 +467,25 @@ static target_ulong type2_mcontrol_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE2_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE2_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE2_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE2_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE2_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE2_HIT, "hit");
 
+    action = (ctrl & TYPE2_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE2_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE2_ACTION;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = type2_breakpoint_size(env, ctrl);
     if (access_size[size] == -1) {
@@ -569,6 +602,7 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
 {
     target_ulong val;
     uint32_t size;
+    uint32_t action;
 
     /* validate the generic part first */
     val = tdata1_validate(env, ctrl, TRIGGER_TYPE_AD_MATCH6);
@@ -576,11 +610,25 @@ static target_ulong type6_mcontrol6_validate(CPURISCVState *env,
     /* validate unimplemented (always zero) bits */
     warn_always_zero_bit(ctrl, TYPE6_MATCH, "match");
     warn_always_zero_bit(ctrl, TYPE6_CHAIN, "chain");
-    warn_always_zero_bit(ctrl, TYPE6_ACTION, "action");
     warn_always_zero_bit(ctrl, TYPE6_TIMING, "timing");
     warn_always_zero_bit(ctrl, TYPE6_SELECT, "select");
     warn_always_zero_bit(ctrl, TYPE6_HIT, "hit");
 
+    action = (ctrl & TYPE6_ACTION) >> 12;
+    if (action == DBG_ACTION_BP) {
+        val |= ctrl & TYPE6_ACTION;
+    } else if (action == DBG_ACTION_DBG_MODE) {
+        if (env_archcpu(env)->cfg.ext_sdext) {
+            val |= ctrl & TYPE6_ACTION;
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                          "trigger action=debug mode requires Sdext\n");
+        }
+    } else {
+        qemu_log_mask(LOG_UNIMP, "trigger action: %u is not supported\n",
+                      action);
+    }
+
     /* validate size encoding */
     size = extract32(ctrl, 16, 4);
     if (access_size[size] == -1) {
@@ -919,6 +967,7 @@ target_ulong tinfo_csr_read(CPURISCVState *env)
 {
     /* assume all triggers support the same types of triggers */
     return BIT(TRIGGER_TYPE_AD_MATCH) |
+           BIT(TRIGGER_TYPE_INST_CNT) |
            BIT(TRIGGER_TYPE_AD_MATCH6);
 }
 
-- 
2.52.0


