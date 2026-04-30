Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14C3FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIOt7-0008MY-70; Thu, 30 Apr 2026 06:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOt1-0008If-Ls
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIOsv-0005LC-NR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:44:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b150559bso5380835e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777545881; x=1778150681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcPSBiwzrF8PlqagZ+bzBqOtmIa2hTG8ka0zp0wOeJQ=;
 b=DsfR6PUzNJ8BWzigpIAZjf1xA7tNoZELc2oceB618l5Em9IP9AK2Y/1hxVKry8r6V1
 ZYYF9QES1wVz68R+vgaipJy4d0hfxh9O4oFZ3ok9NyG3xwx4j2pWodQDGKAi2/xVN5oS
 oX8STPHa+s+r5HQ/GhgH9V7VHzkUuxecseLltYBe+tPWTSzFCn6How2iGg35jGxaO1yP
 ilQwB5Jq1c6IwHRMA5JxDNa+lwS4TLxjtTKmSx3+ygR7fT4nzk9N7Ez9+Hid70EZpXzC
 QaQMzecuDvvp7e/pI49xZ1pnhSvle9ttujTNKq2xxnDCIiodC+bO5fJgcKCsKWH3Zuwo
 S9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777545881; x=1778150681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IcPSBiwzrF8PlqagZ+bzBqOtmIa2hTG8ka0zp0wOeJQ=;
 b=OfAR2XASVZreT6Y0nj2w/akC0x0u+RSg+hCHWXqJb8WXGyPjj6dhwtTS/K1DDXwJzD
 Md74UBeXRe2Lu4l/SbXWcXVX/34L0Cu9NJ7aGW675rsw6tPPCqy4zaE85SCIeS4AoZXq
 qL4BpN7UqqTMzK9U37myKH/XA3ABXn6rFXE8mnTFDwUB+6HQOKXVdpEjyxCKQZoZE2kd
 9juTOBJU3KH6YwGpB8H52MmEGne8Qx96+6PWz7JNgJcPftzFFzhbz+ja/2mGypVoKcjA
 VQMqcdEAlTsVre9e3xNgv6ZhupyvrQw0dX0WNIqv/X5EZnBhVNH+EV0MpfUcwr7YT+uQ
 w0EQ==
X-Gm-Message-State: AOJu0YxBcViUJHg3KIrgrwVILXD5/1p6dQvoro+zaZyWXsTJO8khVAVE
 t89RIE2aBZDs/86lUMVficWde6tJlBGvtABCOoyVkeEIXDtoc0Df/C/Jxehtdhr1Fa0=
X-Gm-Gg: AeBDieuMyQRblOWQGGWi1AL970kpah5t+80Si73oQylnIAKmSbhUGpLZPFOazSg604A
 I2i3rYcMe4jm8CulJREFyBa1id5J6WN74A0WjBPzGc3jRvDKxBlNTL5AGWG0swd30nFnTkaAfkD
 C8xIs41PhotdKqk4Ng1V5VBbZhSncwQmnbLE3da18V70Jxvr46Ybz7VGqMEXKcJQRUTOHC0NyhD
 EZkp5b3L/+dYBuzvOgYHBrL6DoHiCyg2r8Z1PwkidBsvBDowKwLwZky3A9wfWl3S37gqVFxQQBK
 T5Y7WV8LCWq3j3KGwRIec43T/3nGm3PrILHZhJZooOj/SwuteMn3DbGprzHww1Pnc2BvwE8LPQ/
 Xf7plivaQ/IuE58i+OnJ2p+xCCGFXX3jpowTYNDEpApnl8WYL2IZuN8W8OkKygKdEGlMcwEADV0
 qBkS54w0iK84q89rwqnWJRTkV7Sv/OLX1PXg==
X-Received: by 2002:a05:600c:3e10:b0:488:bc6a:528d with SMTP id
 5b1f17b1804b1-48a844721d9mr41943205e9.22.1777545880894; 
 Thu, 30 Apr 2026 03:44:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31c6ddsm39447895e9.27.2026.04.30.03.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 03:44:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 64EE35F944;
 Thu, 30 Apr 2026 11:44:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 6/7] target/arm: handle the WFE trap case
Date: Thu, 30 Apr 2026 11:44:33 +0100
Message-ID: <20260430104434.1482407-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430104434.1482407-1-alex.bennee@linaro.org>
References: <20260430104434.1482407-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Now WFE can actually suspend on A-profile we also need to handle when
its trapped. To do this we need to pass the instruction size so we can
deal with the is_16bit syndrome encoding.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/helper-defs.h   |  2 +-
 target/arm/tcg/op_helper.c     | 15 ++++++++++++++-
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     |  2 +-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index a05f2258f29..ebdf09be38a 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -54,7 +54,7 @@ DEF_HELPER_2(exception_swstep, noreturn, env, i32)
 DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
-DEF_HELPER_1(wfe, void, env)
+DEF_HELPER_2(wfe, void, env, i32)
 DEF_HELPER_2(wfit, void, env, i32)
 DEF_HELPER_1(yield, void, env)
 DEF_HELPER_1(pre_hvc, void, env)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index d0f45522b05..77ac6161e93 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -574,7 +574,7 @@ static int64_t gt_calc_next_event_stream(CPUARMState *env)
 }
 #endif
 
-void HELPER(wfe)(CPUARMState *env)
+void HELPER(wfe)(CPUARMState *env, uint32_t insn_len)
 {
 #ifdef CONFIG_USER_ONLY
     /*
@@ -592,12 +592,25 @@ void HELPER(wfe)(CPUARMState *env)
      */
     CPUState *cs = env_cpu(env);
     ARMCPU *cpu = ARM_CPU(cs);
+    uint32_t excp;
+    int target_el = check_wfx_trap(env, true, &excp);
 
     if (env->event_register) {
         env->event_register = false;
         return;
     }
 
+    /* We might sleep, so now we check to see if we should trap */
+    if (target_el) {
+        if (env->aarch64) {
+            env->pc -= insn_len;
+        } else {
+            env->regs[15] -= insn_len;
+        }
+        raise_exception(env, excp, syn_wfx(1, 0xe, 0, false, WFE, insn_len == 2),
+                        target_el);
+    }
+
     /*
      * If the CPU has entered the exclusive region we could sleep
      * until the global monitor moves from Exclusive to Open Access.
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8b97136e78b..a6f392a28f8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10938,7 +10938,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
          */
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(4));
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFI:
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 3ab49887ce6..686980b58e3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6836,7 +6836,7 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_WFE:
-            gen_helper_wfe(tcg_env);
+            gen_helper_wfe(tcg_env, tcg_constant_i32(curr_insn_len(dc)));
             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
-- 
2.47.3


