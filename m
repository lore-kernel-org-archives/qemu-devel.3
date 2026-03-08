Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81918F55132
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8PV-0006bX-Of; Sun, 08 Mar 2026 03:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PT-0006ay-U7
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:44 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8PS-0001He-8b
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:18:43 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso9940140eec.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954321; x=1773559121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK9Uyjy96zs7twHNYpg5aWknY8afXFteBSqdlJa3j3g=;
 b=TomvkPgq7YOqx0j7KRMg7C5JttXpWAPozXSQrEOhN5LlgKEXr39z5P92m5l3S7NFRK
 tHf9Crk567/D/jKh8bke5LFycLYYZ8wrQWOnVccesJhbcYP1wUyJu9el3KHbu5HYYp7W
 9z+vKZDuREH5TNwAONI1GRA3fqvfDNaNIs3Q8iAXkxLNwXvnlQJbE3Ft0sUcUVVLxMRi
 619bd+wWBtx016Y0k0ZiCSSiLB555/cX1NO+E4+rShlP96a2zoaFHBNkYT9yFPFyEt0R
 dKpoQs4PGE9FwxGY0ptxc5pqjd5sfggZlQCzl3q2gAmAVBH+cIRPsbodfTb/7TQ2YkiX
 UGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954321; x=1773559121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KK9Uyjy96zs7twHNYpg5aWknY8afXFteBSqdlJa3j3g=;
 b=k0og5926VNs/b4ML6wtAwHOP1Joa9g7t/laDrx20xxP5t5wwhzY/9b9d6zyPsP7GP0
 3xycsJ/nkPKtB44OiVRe4uHxb4KLhBzTIoBJpXZ30FilIfoWrh7ZB6VcjWd7lb71FLGe
 1v3icunzAnS2WaHkoKPGuMg8HsMP+mZAwQwmD6BS6QWfiWXxYisT2naiLbaCaC7FQXl4
 hAHai1IjKlxPoXBr7BhNc4KCISe3XpfrInrYXL3+Ox/06nq6updYBJw2wlKmEt9S8Cbk
 9RUM9dLeMMeLfm8XObK3TXiA3l5dIJY2MEN7hkMYFOwJE8DQc1TVr4th/tUJ6Zf8kvnI
 zNaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLVxaYA/IMR4MwrcvvMrTG9aNjWUjpLGl6BveHtLVM+2KSswEgIC88JQzyMtJghbuSzWfI7OSKhZuz@nongnu.org
X-Gm-Message-State: AOJu0YyDlgakQlebC6LwOZQ+HLPrxjc9d3ElKh99pA5eib+7TJjZwigl
 5CiQOS0OwPqi5I/m0nDa12OCOnGBmLF3a74T33pOAZgq+N5vsOLdKcwg
X-Gm-Gg: ATEYQzzrWDfXOXtJAaEuMywYfgb/A08g428lmk1Frhzc25PCOMSoJZrFQLsfkZC8HB9
 cuP0lFKmK6UGOnNX+Gz1HjDFJhg7pztaN7ZhQgCmTxEas4I00XtodIRSMpgaItKpvK/UnpYJHif
 s9tJNoIHKkFqNzdUDU2EHzlejH+416HsdpzM84tho8OZO/dvT6nmD2VfsHPXPWCVrHsOAJFNHu9
 EdZjDRtfckLqmv0vQXu3+Bl9JOAIX3naHvngqUp+TBWYoE/bBQGPGJdbaBXtUVJetrjPnkU+8fm
 cU1f6fEnET7OkNYfjKk+yw9aEQgK3JRjduu7l6F6hFtdY+6bA6b/E+o+JNQPDbvWPNWf4bWpv1L
 nmyK/UcGKmgxhy9d0R/hyOBwqRVFsgZcifKZoZN54h+znQhZiHk5bM3nEg6pb7Y4XnPOfNG01lj
 0JB1b2blw3jydaQ61XHlQGoc3Pv7EW+CLvpuP0Jw5m6aC1/LH1YJ/j6hS8uhGLGRnPoI/qPjn9y
 9tu3Kop4bnSOMBMz9ytajNI1IY=
X-Received: by 2002:a05:7300:cb17:b0:2b7:3281:6c64 with SMTP id
 5a478bee46e88-2be4e007aebmr3003941eec.14.1772954320781; 
 Sat, 07 Mar 2026 23:18:40 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:18:40 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 02/28] target/riscv: keep Debug Mode active when a DM ROM
 is present
Date: Sun,  8 Mar 2026 15:17:05 +0800
Message-ID: <50bb827520cc1fc9e913a6293e5fe30c355a5a69.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
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

Record whether a hart has a Debug Module ROM entry point and keep
the CPU in Debug Mode while that ROM is active, instead of always
returning to dpc on the next exec loop entry.

This updates Debug Mode entry so dpc follows the architectural
cause rules, switches ROM and Program Buffer execution to M-mode,
and lets later DM patches hand control to the ROM park loop.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.h         |  4 +++-
 target/riscv/cpu_helper.c  | 27 ++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 10 ++++++++++
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6fb255c7c3..0bc14f6953 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -481,9 +481,11 @@ struct CPUArchState {
     target_ulong dpc;
     target_ulong dscratch[2];
 
-    /* Pending Debug Module halt request from the board-level controller. */
+    /* DM halt request (set by external Debug Module GPIO) */
     bool dm_halt_request;
     uint8_t dm_halt_cause;
+    bool dm_rom_present;
+    uint64_t dm_halt_addr;
 
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a0874f4e23..714dcb446e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -141,6 +141,24 @@ static bool riscv_sdext_enabled(CPURISCVState *env)
 {
     return riscv_cpu_cfg(env)->ext_sdext;
 }
+
+/*
+ * Debug Spec v1.0 Table 9:
+ * - ebreak: dpc = address of the ebreak instruction.
+ * - step/trigger/haltreq (and reset/group/other): dpc = next instruction
+ *   to execute when Debug Mode was entered.
+ */
+static target_ulong riscv_debug_dpc_on_entry(CPURISCVState *env,
+                                             target_ulong trap_pc,
+                                             uint32_t cause)
+{
+    switch (cause & 0x7) {
+    case DCSR_CAUSE_EBREAK:
+        return trap_pc & get_xepc_mask(env);
+    default:
+        return env->pc & get_xepc_mask(env);
+    }
+}
 #endif
 
 void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
@@ -152,7 +170,7 @@ void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
     }
 
     env->debug_mode = true;
-    env->dpc = pc & get_xepc_mask(env);
+    env->dpc = riscv_debug_dpc_on_entry(env, pc, cause);
     env->dcsr &= ~(DCSR_CAUSE_MASK | DCSR_PRV_MASK | DCSR_V);
     env->dcsr |= ((target_ulong)(cause & 0x7)) << DCSR_CAUSE_SHIFT;
     env->dcsr |= env->priv & DCSR_PRV_MASK;
@@ -168,6 +186,13 @@ void riscv_cpu_enter_debug_mode(CPURISCVState *env, target_ulong pc,
         }
         env->elp = false;
     }
+
+    /*
+     * Per RISC-V Debug Spec v1.0 Section 4.1:
+     * "All operations are executed with machine mode privilege."
+     * Switch to M-mode so ROM/progbuf fetches use physical addressing.
+     */
+    riscv_cpu_set_mode(env, PRV_M, false);
 #endif
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 53d862080c..4674ff3e3c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -280,6 +280,16 @@ static void riscv_cpu_exec_enter(CPUState *cs)
     if (!cpu->cfg.ext_sdext || !env->debug_mode) {
         return;
     }
+
+    /*
+     * When a DM ROM is present, the CPU must stay in debug mode and
+     * execute ROM code. DRET will leave debug mode later. Without a DM
+     * ROM, leave debug mode immediately (legacy shortcut).
+     */
+    if (env->dm_rom_present) {
+        return;
+    }
+
     target_ulong pc = env->dpc;
     riscv_cpu_leave_debug_mode(env);
     env->pc = pc;
-- 
2.53.0


