Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9B1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KE-0004OE-CT; Sun, 12 Jan 2025 17:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6K1-00049H-2b
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:43 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jy-0006rI-8B
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso25505175e9.2
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720436; x=1737325236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sio+Ya9Jtq0ztZ7UXdsNT1P9BXGr2RmzsMYT4fsV77Y=;
 b=BpQvceSelT+Mjhm/2roZD8LtxHJXMB1LXP2iAHVGfpc2Aj3VGmaQtn4Q/AVDwIXDzU
 D7qqMB61ST0Cx5wmZl9gouRXj6IDTc8H5n5oJNy9hy/qXUHYrThxHWx1+oXP/P1Wk2z0
 w5ktSP9Bupg4qCoGAQNUGtb1XJKrCBeOp3txKpa7eBxsms+YEPi3NMqnOgt8ACjFyycZ
 7jwJOjifAtHi2LJCCRTJLJrotZFVqbPVEiAa8NMUL6gFfc18CLp5Jyl1SygY/eabjpN4
 LaGrRjI7RVc2jJFzyGMilJqjmSLRLUagt4jYcX1ljQqNWw8r2khl5BLeFBRlD7rYb08l
 r0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720436; x=1737325236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sio+Ya9Jtq0ztZ7UXdsNT1P9BXGr2RmzsMYT4fsV77Y=;
 b=onNgmcWu+2KDBzharZtePa/XWF+1yYXswFbeM9pWzaQdefdBmnkdD6T9en4brxF7Bb
 +2gEuDBJGtDlJiv9rDMNdqeojDqHsjzZ7UigYLklHi9zgcAjhyDwoiH7uqiHf1ika3oJ
 yF73hUNscpQ8IoZFKfJIVOB4XhzSMIEdywRll0Zc6wulVAdRRqZxah94Ah8Y/3bdG2kT
 m3fu7wApncyF5Ck6NljQBb4ID83YZSKwJE8lTWKhZq+p0/HSNfbu5RKxczKtBnOic62t
 1Dsg6Zl5dqjysDbTIfTY4KJLsl5tt3mMz3+1duMu1qWLECPv0BQ3J85QTxVyLxJtgEaf
 9/DQ==
X-Gm-Message-State: AOJu0YzLHCmdQF9CANJJHzePojvuuUFkAmxY8PTVZ2tX+NzpbNZkaWb7
 bWbUrX6+VKh0WS7DeQihv6qGSvjNhCAotS2965gi0rhY/ZVHdtEFmN4iUmt4cqZfwShamND49fj
 GRqQ=
X-Gm-Gg: ASbGncuQhLD90UgItWEe0fKxsu5pHPya3xdtwwBTMeDVTKrOspQa+EhwO4WtQRX9uCo
 G/uOL+ojHbTVpIQ1Jpic03HkLLueox9TAku2/2cWgYrBnOqKM9guHqEkBlNWSwKgYlUlG3T1SZQ
 3Dwwyk/CTNVc5Qafx9yl3EsemSu+4GYLihbUlE09cIQRgr4S98THfJ8rdyfUDjQc3lxbSpGDwyv
 HRW2ArPauYxX3IB349omzh7VRKBSPFTUbbWBt20NLLUpgxNjI8sH4M1ZwAqQCNxyD6mZkdSogqK
 nIiBfvgoXPZTTGDvMm5k9CSYqvJMIIQ=
X-Google-Smtp-Source: AGHT+IGqzQxpwu4a9mUfJEYlqMit4m/505Adpl4QnKgZpDBmq7QKxLFZt79YtccJWivm9LwxbJpw6A==
X-Received: by 2002:a05:600c:871b:b0:434:f297:8e85 with SMTP id
 5b1f17b1804b1-436e26932eamr187966275e9.10.1736720436296; 
 Sun, 12 Jan 2025 14:20:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1bebsm10629170f8f.95.2025.01.12.14.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/49] hw/hppa: Reset vCPUs calling resettable_reset()
Date: Sun, 12 Jan 2025 23:17:14 +0100
Message-ID: <20250112221726.30206-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Helge Deller <deller@gmx.de>

Rather than manually (and incompletely) resetting vCPUs,
call resettable_reset() which will fully reset the vCPUs.
Remove redundant assignations.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241231190620.24442-4-philmd@linaro.org>
---
 hw/hppa/machine.c | 6 +++---
 target/hppa/cpu.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 65259308e2e..8230f43e41c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -655,12 +655,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     for (i = 0; i < smp_cpus; i++) {
         CPUState *cs = CPU(cpu[i]);
 
+        /* reset CPU */
+        resettable_reset(OBJECT(cs), RESET_TYPE_COLD);
+
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
-
-        cs->exception_index = -1;
-        cs->halted = 0;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index d784bcdd602..41538d39d62 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -204,6 +204,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
         scc->parent_phases.hold(obj, type);
     }
     cs->exception_index = -1;
+    cs->halted = 0;
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1


