Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82BDC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk6G-0004TZ-2v; Fri, 20 Jun 2025 18:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYU-0007BB-IB
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYS-0005x4-W9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so22254415e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440571; x=1751045371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LOqF9IQUgckxNreMVaINjrct4R3Ylg/3ClAi13j+TI=;
 b=FCWFDbOPRFGXZkoaBxsHSUjUsmHOuzXD7kU3x65tHGvSAbG0wdnt9/SvLHXgCHWxyi
 tp9CBKi7oz0pf+E8cEmdJJTLO5Ka/iqdiwqL4nD7jtKjS33jeJ1pyWwO3i7oxzVkS4WL
 wz00Y6saJ839pgr2S1Fwp483aQK4UO/g9OTbuCeWyrF6jZU+y1VcMzTbvQEVCnPmwUa8
 gmtS/LR3q8kpuk14av/6Ilt092ZWGLlwa4paOl8ubGfUf0LHBmtRnnZvzT0xcLhs2GRL
 aVPvzreb6ZBOW+GxqpQN6gjFx4xnL0QqOVT71Pw44Pp2RrBWDpwWtCnThKo5A3sJvDtd
 80jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440571; x=1751045371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3LOqF9IQUgckxNreMVaINjrct4R3Ylg/3ClAi13j+TI=;
 b=g65To+m00GTjER+ZNgyRb8IkNGq1/pLN9GHYtdfu7k22BGgGKsbqNFYGk79zXm+GQe
 H7Gb+bxg8PBH/GKHU1Og8amFfLyTFQOUQbFxA0k2kaHoSJbfsKHYlIFgWuTsLFrhE59F
 7fzKSqqQPNakc/MfpZ0NOmNhjtJ6e+tCrUUKpvyDmzBVf5YXAP2zSmIHXMBX7p5ZQNPD
 H1Bk/NdpDsyrCwQ0XKChGMAof+QRm1eU3FHS4cqlCTMSao0SNBZeRRv+FYVFF+eX9lhj
 wzgRas6TK69hU+vCHEyfmQVYUfa54WPZF7WMXnr0ndhd6upbbvBXE9Ritf523D4GsgHo
 V9yA==
X-Gm-Message-State: AOJu0YxISpl91YEmkaCdRU+MzuPuJ4D9kaNEhDvWLPcMJ/d1GLjfaR3k
 Lilcg4grOhGBKOjacZvkHdhvXTd56tfZKcunEE09fcOb2rhkK5/sUt3CLz7Vkk6fcTXSm2fa2Mo
 NtZknWP35aA==
X-Gm-Gg: ASbGnct2k1nIobk7hdRTxmJyOpWcvDjCz/dBqYzN4OceMUMq5Y9Q24I87QaEcfwUwO1
 rRb9t/EN/kbfUSHi8d28sOj4LrKyA78lmGz6ofhuGw/zYlNNSDmRglU/02VSRTfmc0xw0/B+Es5
 y5/Fzg7/CNReTIo/yDSY5Syy+mLSNG5FJwYWouuP0fUSz9pE7Ia3a/KMzjWu8VFzGzHt+4RLGCS
 v3YCd6eqNRef9hT9Skzv37a8nGas8Ktxd1uQbNC0mFNDLU+SRMhR4MKsjCCmwYqFeMmKOX1aeuD
 4dxkbjYjy1ON4FxxSAoM73ylMkgrR1juuXntpUo11RTVEZ4xGq6hbdsyXo8rY2x+9WxOmw/Gh7c
 2O/kPrkza46RL8WGk/fp9NW7CSVJXXQkuJbhLrpbJuy4f4uSqikNsHeLB
X-Google-Smtp-Source: AGHT+IEJDjF+CuMUKvj4nqVX4trUEDa9OAkJGVyxv+86MXrbA/A7V/0y1E7iYN5XIETOyuL0GnYSKw==
X-Received: by 2002:a05:600c:4747:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-453659c0c2fmr40909735e9.31.1750440571163; 
 Fri, 20 Jun 2025 10:29:31 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187df7sm2591455f8f.66.2025.06.20.10.29.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 12/42] accel/split: Have thread routine ready to
 dispatch over HW/SW
Date: Fri, 20 Jun 2025 19:27:20 +0200
Message-ID: <20250620172751.94231-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 2c7945b6331..39495fdff14 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -19,12 +19,18 @@
 static void *split_cpu_thread_routine(void *arg)
 {
     AccelState *as = current_accel();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    AccelOpsClass *hwops = hwc->ops;
+    AccelOpsClass *swops = swc->ops;
     void *sw_force_rcu;
     CPUState *cpu = arg;
     AccelCPUState *acs;
     int r;
 
-    /* TODO: check accel allowed */
+    assert(swc->allowed);
+    assert(hwc->allowed);
 
     rcu_register_thread();
     sw_force_rcu = mttcg_vcpu_register(cpu);
@@ -35,7 +41,8 @@ static void *split_cpu_thread_routine(void *arg)
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
 
-    /* TODO: init_vcpu_thread() */
+    hwops->init_vcpu_thread(cpu);
+    swops->init_vcpu_thread(cpu);
     cpu->accel = g_renew(AccelCPUState, cpu->accel, 1); /* XXX only with current TCG */
     acs = cpu->accel;
     acs->accel = as;
@@ -49,10 +56,12 @@ static void *split_cpu_thread_routine(void *arg)
     cpu->exit_request = 1;
 
     do {
-        r = 0;
-
         if (cpu_can_run(cpu)) {
-            r = 0; /* TODO: exec_vcpu_thread() */
+            if (acs->use_hw) {
+                r = hwops->exec_vcpu_thread(cpu);
+            } else {
+                r = swops->exec_vcpu_thread(cpu);
+            }
             switch (r) {
             case 0:
                 break;
@@ -83,7 +92,8 @@ static void *split_cpu_thread_routine(void *arg)
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
-    /* TODO: destroy_vcpu_thread() */
+    hwops->destroy_vcpu_thread(cpu);
+    swops->destroy_vcpu_thread(cpu);
 
     cpu_thread_signal_destroyed(cpu);
     bql_unlock();
-- 
2.49.0


