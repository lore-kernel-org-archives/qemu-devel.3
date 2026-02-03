Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EB5E87824
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 12:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnFxS-0004cy-3q; Tue, 03 Feb 2026 07:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxQ-0004c2-CX
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:40 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vnFxN-0003zJ-QY
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 07:56:40 -0500
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-c635559e1c3so375017a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770123396; x=1770728196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVAc4z8gitavmkRZr8FajGktAnHfEjUwrCrJ1zLBgdM=;
 b=hAMoWeCRLyq2rzKagrZxPR+3rbomS7zW7x9cPS78hVhR+9MiX8KFREC3ZJLD1sHBvp
 xtcH7OOzc0CwhrwXRqm6lZV16cpx4Ek+FCbzxsOj09LJbxs02ySeFztULN6GCG7sFYQv
 0sM49qrWK0dCRIjirCNXMGuqKswRR2tu4Ty7zkLtxkuMTHIOi5uyQNx7+eZNkCU4sRDL
 UobU5WxwVI4Ukvki4FPN6eFXfBCXYRCYycoBBf8WB9r/6JyPQEhZP41qzgZQx+bmKump
 fGEoby1Q+/z+KCEVWRCkcf3SC85P1B/G5oeyEqvTgomOFTmB5Yi0C7FmHggE91HC1RIR
 Juew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770123396; x=1770728196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZVAc4z8gitavmkRZr8FajGktAnHfEjUwrCrJ1zLBgdM=;
 b=bU0g6xAT1pmHFm1nZCK0m/BhMymvhUcAscQu2YSklJfkZMOj4sqtOQpiTbj1ZHlnup
 J3wuON6rtA1MOMviHcOGov+D3Q8A/aT34vmKWvUIxGLDTV7yLyeur/SYruTw366ESAyh
 Oei+R+FNjgN7AZL5mHBF/TGvHqtpUz4kI/hVxRX7mAk1I8ZwCb8xtqSWEmP4/goLCxNL
 2yAs5IxWiIufRwuvYBZHe/u/AFfkzwTEQv/I38eLB3edS8b7mHCpaWNFNV8LBy1pVAt4
 vIt5UrkPB5hVoQaCF5AZ8tIn0HdbowjZokfiNpBfbeoD092o7TyLBzIXAUnDf0zdg0tS
 FeZw==
X-Gm-Message-State: AOJu0Yxa1JLHUmqkJ2ArhmiGskEjNVDXXoiQ8MqjR57NnM5btFrPGp/n
 +dm+et5h7kmTRTDfuuM8ORaXeQe8h4cVuOF9dg+ArQv2wMuvq6+vFPAE
X-Gm-Gg: AZuq6aIpvcgEbKR9ZbDBQnSRXu8CJjtC4o2+HDFs/L8PHsi5UMJOgsincajlRF9sDAH
 nr/P5Z+4ittC5Q7Vt9dJx2clwZCuiX1fe5YC1NtjRljn6pM9KN5lTHFzrizKf9292Ai4YzMoK/m
 qGl1IyYMvfrxFlVvP0mY4dA005xT3SMNErfNkicAy5DPlGPW2sCI4VUwY4YpukL0PxidocwHetd
 1zESKuVZugs4H1XzLqXyhtufXSRUV0kUJ0AFO1tAHWHHyE+k50G+iGTkxxFIWWD15zmwocHIKsr
 03HYEpgn2nAKviOMQTE+zPf3Hksqr0sEZkbcbw5fvzP5ZAQYcrbOvey4Cuia6xIvRazgKJip7HI
 +kKsVlhtqbyEDFiaVsneJdZkviRl2Ywb5sS70GUeTtUC9RFOYtfFchLVI8NtKC/h6nNxXTJ4QPT
 GCqQRSWGImYdnxMwAkpUQhDZjU8ImBq/ytd4d0vO2n47f/qVkG8/Y/r3cq
X-Received: by 2002:a05:6a21:3a41:b0:364:14f3:a5b with SMTP id
 adf61e73a8af0-39355ee41f2mr3051779637.2.1770123396372; 
 Tue, 03 Feb 2026 04:56:36 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([183.195.22.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642aaf1308sm18214796a12.30.2026.02.03.04.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 04:56:36 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [RFC PATCH v5 7/7] target/riscv: add sdtrig trigger action=debug mode
Date: Tue,  3 Feb 2026 20:56:06 +0800
Message-ID: <64437c414673426f43b8973e706e1d2982eae03a.1770104280.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/debug.c | 53 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 5877a60c50..6c69c2f796 100644
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
+            qemu_log_mask(LOG_GUEST_ERROR,
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
2.53.0


