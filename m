Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C1ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwXm-0004Kp-W7; Fri, 31 Oct 2025 17:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwXj-0004KA-U5
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:20:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwXb-0002aW-F6
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:20:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1769673f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945608; x=1762550408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TRkWFU/aapO0FF6y9Y4J4SN7vpy3bH8aWYMTVG70Hn8=;
 b=IkTlWL1z3PVjSKCJeaqvDUIsu38aEd7FI60q3RN127YVMnqsytGzNQzX7HkiNV5PGf
 9AS7NrZ5+g794PeZQMJdtAMmghiloMthvZAHzS3nW1XwVS4PbrD9ELrMAp4t68DPDzgw
 aIx3/DQJYAk9wMN8yiBYzQYo3+QxFxQyGl6jj/D814CD42IASlB2G6HKEf/nldnQ5D5s
 lHUWMWlxCj0bziRboCsC32z2jugb7CmrKmF8FApDrUc3uGWtkr3uIOa12mulK4YWKDD0
 KJuRCiMzs9jn9M9WWF8UHZLQN/Mzu9vPT3D+MeauJo4nDX+kHblHbYY0tdxBEH3YutR3
 V5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945608; x=1762550408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRkWFU/aapO0FF6y9Y4J4SN7vpy3bH8aWYMTVG70Hn8=;
 b=Vssx/nZXPv8asu+yM2GMS1yUv0O+4hjD3Zd0gcLNlaRZCxBN0fdbtKEgYouZ2h/dKv
 lkM/F48Ef+q8d036TSz9o6jxyV2p94r0KhTfzhDGTwRDPBWa6eaPF/k4eiTSWOG2eQhs
 9oIslRLytWDKn3EW6uBjmpwvMNsodd7EuGP//SH2KVHd1aSjVxOMMHKFkEhnQFlI4ZP0
 r8tUPB5kvlNnoBFggPQYgmGsQW1yNtbqdzuw8/UTCE2/np3IKa0V0PPVI/TA55VCtGJG
 JX6XsgWRtq2M3sAwHqr/88ExLyhJ/XvvuvpdqMf8kZ96VZ//oVLLsgCXMUhtQ5kPYmBn
 q/+Q==
X-Gm-Message-State: AOJu0YxDuu/lRgI1U/5Wd3FcwminiUzGwDMYi3meOaaEZZxbKwknem2U
 FLoP3Hff30/xwOUl/DhCu20BxaAOmWyb2nw3xfkl7EiLpP6yNPnDolUxiDeRMCWBJqXJzPe0qj1
 jUj/9mfrKkg==
X-Gm-Gg: ASbGnctLEJ9gnAUedccr83j/Z1EsVO5Or5Jj4iGeclkephqLwZ+ZXzhmwl7D6Tysj7s
 XIvqwhruJGQCgSYcvkRJb3tB4DuGTuPP9Ym/wv70nE+ct7nXt8tXav+HISQIB6lPcXb+n0VtKWG
 JsQFH4zuD/nLFrlHHbGqAfS9QTEdVU0jwqBGc5wVjPPAzasSJcUIn5ZBMl512JGRploHYMXH3al
 EQwAtQMO9Znnj6D9bQyuv4OKaZn6dnESpIUCVViEyOjwVV2J70o0db0bfEI89AwagtttJQxNrTB
 KDyMwwhASdj/bVzif8tAun6nl2BWKRxVlYXuxU2GcnLmsySkTvGgs76apJR0N4pbGWMbBzREsHW
 VDCiD7U50zlWLKZ9gFncXuAuf516+7wg8nSDdlArxd4QNS2ieICfyy7QFZFc1MTAu1xlEyMvSs9
 f2PyqwaKu8sI21dOhK4Q5zPBgQmqEXSYL3MXr9oTqPW3H6HNoV
X-Google-Smtp-Source: AGHT+IEcvUahVrXqdQpda5Jmzh00TDRKdk7K7n7yUy3kWYWRimLq4lodPyYuNRcgonQioDY8GNflkA==
X-Received: by 2002:a05:6000:1acb:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-429bd680bb9mr4527610f8f.16.1761945608366; 
 Fri, 31 Oct 2025 14:20:08 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e16f4sm5639277f8f.27.2025.10.31.14.20.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:20:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] rx: cpu: fix interrupts check in rx_cpu_do_interrupt()
Date: Fri, 31 Oct 2025 22:15:18 +0100
Message-ID: <20251031211518.38503-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Igor Mammedov <imammedo@redhat.com>

Commit 87511341c30 broke interrupt handling, replacing interrupts
fetch with a bool and then the remaining code attempting to check
individual bits on that bool value, which effectively masked those
interrupts.

Fix it by checking individual interrupt bits directly instead of
old 'fetch then check' approach.

Fixes: 87511341c30d ("add cpu_test_interrupt()/cpu_set_interrupt() helpers and use them tree wide")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251030165932.138512-1-imammedo@redhat.com>
[PMD: Rebased on commit dde21df2393 "call plugin trap callbacks"]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/rx/helper.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/target/rx/helper.c b/target/rx/helper.c
index ef47e32add8..e9a7aaf610d 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -41,11 +41,9 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
     env->psw_c = FIELD_EX32(psw, PSW, C);
 }
 
-#define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
     CPURXState *env = cpu_env(cs);
-    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
     uint32_t save_psw;
     uint64_t last_pc = env->pc;
 
@@ -59,29 +57,26 @@ void rx_cpu_do_interrupt(CPUState *cs)
     save_psw = rx_cpu_pack_psw(env);
     env->psw_pm = env->psw_i = env->psw_u = 0;
 
-    if (do_irq) {
-        if (do_irq & CPU_INTERRUPT_FIR) {
-            env->bpc = env->pc;
-            env->bpsw = save_psw;
-            env->pc = env->fintv;
-            env->psw_ipl = 15;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
-            qemu_set_irq(env->ack, env->ack_irq);
-            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-            qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
-        } else if (do_irq & CPU_INTERRUPT_HARD) {
-            env->isp -= 4;
-            cpu_stl_data(env, env->isp, save_psw);
-            env->isp -= 4;
-            cpu_stl_data(env, env->isp, env->pc);
-            env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
-            env->psw_ipl = env->ack_ipl;
-            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-            qemu_set_irq(env->ack, env->ack_irq);
-            qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
-            qemu_log_mask(CPU_LOG_INT,
-                          "interrupt 0x%02x raised\n", env->ack_irq);
-        }
+    if (cpu_test_interrupt(cs, CPU_INTERRUPT_FIR)) {
+        env->bpc = env->pc;
+        env->bpsw = save_psw;
+        env->pc = env->fintv;
+        env->psw_ipl = 15;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_FIR);
+        qemu_set_irq(env->ack, env->ack_irq);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        qemu_log_mask(CPU_LOG_INT, "fast interrupt raised\n");
+    } else if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD)) {
+        env->isp -= 4;
+        cpu_stl_data(env, env->isp, save_psw);
+        env->isp -= 4;
+        cpu_stl_data(env, env->isp, env->pc);
+        env->pc = cpu_ldl_data(env, env->intb + env->ack_irq * 4);
+        env->psw_ipl = env->ack_ipl;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        qemu_set_irq(env->ack, env->ack_irq);
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        qemu_log_mask(CPU_LOG_INT, "interrupt 0x%02x raised\n", env->ack_irq);
     } else {
         uint32_t vec = cs->exception_index;
         const char *expname = "unknown exception";
-- 
2.51.0


