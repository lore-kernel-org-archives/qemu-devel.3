Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BCFCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKl7-0002Zv-Qp; Fri, 29 Mar 2024 18:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkx-0002XK-Kg
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:28 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkv-0003Vr-L8
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:27 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e0bfc42783so20766435ad.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751484; x=1712356284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aKcsx9JEOh52ndAdHyeqzgetKk3eTEnbQJ4vqbujCg=;
 b=wMA0iGpu2cLOuysjP68A9Al3LryRGIua/rbMTOTHgdtw+vwMd1SdFbIywEUAV1PfJ0
 qoPFd0HPb+2FOrwliPKv3g+tM6bxWh9jrfamh2Y/GjXtfFaCRso6bATzaSxhwdzG71TQ
 A8dGHn44WaOAm9g1PV5I/wwsFvbLsZ8b+cZ3vwnAa+fmMxiHobYhgsKsFIkKNGpCTqHq
 SWO+A4ZiyNJRW6kCecgI5Rw0kEoVlgHeoB9qP+d0EKCLlQ9+Bd/AWcbImespMJMe1Q6a
 u5p6rP88pxKczzvh36leQ5FlLk6/b27rrb7ge3HO7QveUwAxzqo5pk/RQgJ+3c3uxiNl
 qqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751484; x=1712356284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aKcsx9JEOh52ndAdHyeqzgetKk3eTEnbQJ4vqbujCg=;
 b=p4yJ8/XXIi8OeFrNbFpJaZ9hRiPaunHQpll2UTDmwD2F55JIU0Pi69CFfnIG7HGhF6
 rNXOFdShs1EeWXRHLBgTKirKiIPfz2msqK0w3MT0Nc1ch7KT/MIE/3uaHQ9vZpgjCFSS
 eG4BXwVWZyLyjlF214qrfqntMqi/cQVnOefm2IePTE++wRW/1pETBlS34NcUXIMMXR//
 p4gDs/R8BBOztzgzgWvlJ0HVVn72DA7Zq3gU3xTTzC9NdOvMPHOxDhhIGtLYTeixsYAu
 DQtxbRsniFVvPAEZ5hNMsNCbfeymWtn0zVuzkbl3l2Gn55qsBAMa5MkVlmn+7qofYLlf
 bAWg==
X-Gm-Message-State: AOJu0Yyi4fALZReB+YBkzVze6jCARQfzT3bFDoXzy38O70PXIlMArGAn
 8vIIdFro83ppprwqyFIq1Yg6MyKjQsVd1geJRDGMjgJzcvHEpu0SlagV6o5Ek+JipExRQvPmfRx
 j
X-Google-Smtp-Source: AGHT+IFXcT/cv617vs94V0olUk1qtvB+asP3RutnVEut1XBYxIxnfg2HWbuT+MfbO611UJ0kqXe2YQ==
X-Received: by 2002:a17:902:d2cf:b0:1dd:5f85:1191 with SMTP id
 n15-20020a170902d2cf00b001dd5f851191mr4433009plc.53.1711751484466; 
 Fri, 29 Mar 2024 15:31:24 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 07/18] target/hppa: Fix EIRR, EIEM versus icount
Date: Fri, 29 Mar 2024 12:31:00 -1000
Message-Id: <20240329223111.1735826-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Call translator_io_start before write to EIRR.
Move evaluation of EIRR vs EIEM to hppa_cpu_exec_interrupt.
Exit TB after write to EIEM, but otherwise use a straight store.

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c | 14 ++++----------
 target/hppa/translate.c  | 10 +++++++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 1bdbcd8f98..8fd7ba65d8 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -91,7 +91,6 @@ DEF_HELPER_1(rfi, void, env)
 DEF_HELPER_1(rfi_r, void, env)
 DEF_HELPER_FLAGS_2(write_interval_timer, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(write_eirr, TCG_CALL_NO_RWG, void, env, tl)
-DEF_HELPER_FLAGS_2(write_eiem, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_2(swap_system_mask, TCG_CALL_NO_RWG, tl, env, tl)
 DEF_HELPER_FLAGS_3(itlba_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(itlbp_pa11, TCG_CALL_NO_RWG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index efe638b36e..90437a92cd 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -28,7 +28,7 @@
 static void eval_interrupt(HPPACPU *cpu)
 {
     CPUState *cs = CPU(cpu);
-    if (cpu->env.cr[CR_EIRR] & cpu->env.cr[CR_EIEM]) {
+    if (cpu->env.cr[CR_EIRR]) {
         cpu_interrupt(cs, CPU_INTERRUPT_HARD);
     } else {
         cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
@@ -89,14 +89,6 @@ void HELPER(write_eirr)(CPUHPPAState *env, target_ulong val)
     bql_unlock();
 }
 
-void HELPER(write_eiem)(CPUHPPAState *env, target_ulong val)
-{
-    env->cr[CR_EIEM] = val;
-    bql_lock();
-    eval_interrupt(env_archcpu(env));
-    bql_unlock();
-}
-
 void hppa_cpu_do_interrupt(CPUState *cs)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
@@ -280,7 +272,9 @@ bool hppa_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     }
 
     /* If interrupts are requested and enabled, raise them.  */
-    if ((env->psw & PSW_I) && (interrupt_request & CPU_INTERRUPT_HARD)) {
+    if ((interrupt_request & CPU_INTERRUPT_HARD)
+        && (env->psw & PSW_I)
+        && (env->cr[CR_EIRR] & env->cr[CR_EIEM])) {
         cs->exception_index = EXCP_EXT_INTERRUPT;
         hppa_cpu_do_interrupt(cs);
         return true;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5b8c1b06c3..46b2d6508d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2166,10 +2166,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
         gen_helper_write_interval_timer(tcg_env, reg);
         break;
     case CR_EIRR:
+        /* Helper modifies interrupt lines and is therefore IO. */
+        translator_io_start(&ctx->base);
         gen_helper_write_eirr(tcg_env, reg);
-        break;
-    case CR_EIEM:
-        gen_helper_write_eiem(tcg_env, reg);
+        /* Exit to re-evaluate interrupts in the main loop. */
         ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
         break;
 
@@ -2195,6 +2195,10 @@ static bool trans_mtctl(DisasContext *ctx, arg_mtctl *a)
 #endif
         break;
 
+    case CR_EIEM:
+        /* Exit to re-evaluate interrupts in the main loop. */
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE_EXIT;
+        /* FALLTHRU */
     default:
         tcg_gen_st_i64(reg, tcg_env, offsetof(CPUHPPAState, cr[ctl]));
         break;
-- 
2.34.1


