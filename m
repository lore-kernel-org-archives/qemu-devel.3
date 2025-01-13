Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42EDE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eQ-0007S9-7W; Sun, 12 Jan 2025 19:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eK-0006wy-Os
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8eJ-0000zA-1s
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:48 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso26416475e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729385; x=1737334185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxFKXXK5VzgQk+VMHxLlV5NbZtRQAbvkWoWKwyBHWBc=;
 b=bDRnCsCTIduA/tdlJqw/jffvsp7GOiZOac9rtHam1qWaURNI6PVmc2m9dMlZ8MrX0m
 22dS5L3XzWuAyApr6tcOoDOIZmbcOcYUzGv1GezJaVVnXEosJ1mcs6YkmigTSquu4kLw
 2L7xdgE23RCySMcS3z3KWs0gw6xJBqJ55PB3tqFe/x6B9H4aM/zGF7RtdNfrmTTnoQIR
 I0HawKY7KtRaHOpBlCvs5ZF7Ryqe2qryUrdO1E9Aqz/4yYBvhdHL00adDmsL9FUS9bqs
 IER6ghYCtwB6+Pdkx1EFK/uQv1uXKm3oMYvCuk3px3eYC7YyAJzykEm1LGgrCOVYFlj4
 Gwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729385; x=1737334185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxFKXXK5VzgQk+VMHxLlV5NbZtRQAbvkWoWKwyBHWBc=;
 b=gu5ZU+d8N7OM5L3iEcTV6rh+12XoTaBIUW36QiX50FM7n5Sw6xUY2DEc4AeGJjVj3V
 hGmeKkSC2o5/eV7V+9QatrXtUVaA50MoreZCKpvP4Mpj1nvlTaGsond25hxjHv9F7e0k
 9CVZkPsVX0s1XVGo+kw+0KSyx/n1kh2eZ2Sk3Yw/650GnWkHHcwBYIBR+D3SRHFlA2w9
 VseoCC3Wssh/z1ojgixql1zfzuHRTEiJi97PS5CbFQkXV8zJ7L3qmAgt22wi/V1y27Aq
 KkgqvpcFgosB9n2/pox6swKfKAx710XSactScG7mURSjZ38LWKkqQ085XTcJSgN1X5UE
 8d6A==
X-Gm-Message-State: AOJu0YxV5h1nwWEYTovcSHJFMg2siw5EnRFeNpJEjixwrkrflP2ZI8r0
 rXvyzZflx83/5LveWA9T+olm2UEptj9nVEKq7lkC03xjagltMVS6dmQ/lKLwWaenq5enfPA/H5r
 rwqA=
X-Gm-Gg: ASbGncscR+akj/iptqQChyge1izjKJJCl4RiM3sVoV9qKjGqUz8gCG642ZnWoKnAcxi
 MbNmDgrDOmVTNsyTMhaoiNwVyr/RRLRtzwMjX8+BTn7QrT9oTZYdJU9AGE6JUrWh8D/y0sruI7x
 bZy4EJElMKwVe0oH44ch36BYbPNp3Cw5b2L4J+BauFNMv9GIQPG7Z3xiUUKD1eNoaG6ZPC9tPZk
 aBO2wCbU0uLvJBt9FsYsmouwd1R46Qgi4mV/p5NG4zbZF2aPnONpvlzRN/v8TGgqrcqFyWnMwWC
 d412PjDZYb4yUt2nQ+KioH/y6nt20fg=
X-Google-Smtp-Source: AGHT+IHeH/ubmLfesgunDG0PPKZJ/HXcyNYcyhxuKSk/XLr0oGh/WeW6MsqMmUg/ZeG8KFlt7AvIoA==
X-Received: by 2002:a05:600c:4449:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-436e26f481dmr58567575e9.21.1736729385335; 
 Sun, 12 Jan 2025 16:49:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e03f8bsm125389885e9.23.2025.01.12.16.49.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 20/23] hw/mips/malta: Keep reference of vCPUs in MaltaState
Date: Mon, 13 Jan 2025 01:47:45 +0100
Message-ID: <20250113004748.41658-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
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

When a QOM object create children with object_new(),
it is better to keep reference to them for further
use. This will be helpful to remove &first_cpu uses
in few commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 5ccff2cb0c1..a037ec2cc8d 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -107,6 +107,7 @@ struct MaltaState {
     SysBusDevice parent_obj;
 
     Clock *cpuclk;
+    MIPSCPU **cpus;
     MIPSCPSState cps;
 };
 
@@ -1037,6 +1038,7 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
     for (i = 0; i < ms->smp.cpus; i++) {
         cpu = mips_cpu_create_with_clock(ms->cpu_type, s->cpuclk,
                                          TARGET_BIG_ENDIAN);
+        s->cpus[i] = cpu;
 
         /* Init internal devices */
         cpu_mips_irq_init_cpu(cpu);
@@ -1063,6 +1065,7 @@ static void create_cps(MachineState *ms, MaltaState *s,
                             &error_fatal);
     qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+    memcpy(s->cpus, s->cps.cpus, ms->smp.cpus * sizeof(MIPSCPU *));
 
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
 
@@ -1070,9 +1073,11 @@ static void create_cps(MachineState *ms, MaltaState *s,
     *cbus_irq = NULL;
 }
 
-static void mips_create_cpu(MachineState *ms, MaltaState *s,
-                            qemu_irq *cbus_irq, qemu_irq *i8259_irq)
+/* Initialize MaltaState::cpus[] */
+static void mips_create_cpus(MachineState *ms, MaltaState *s,
+                             qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
+    s->cpus = g_new(MIPSCPU *, ms->smp.cpus);
     if ((ms->smp.cpus > 1) && cpu_type_supports_cps_smp(ms->cpu_type)) {
         create_cps(ms, s, cbus_irq, i8259_irq);
     } else {
@@ -1111,7 +1116,7 @@ void mips_malta_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     /* create CPU */
-    mips_create_cpu(machine, s, &cbus_irq, &i8259_irq);
+    mips_create_cpus(machine, s, &cbus_irq, &i8259_irq);
 
     /* allocate RAM */
     if (ram_size > 2 * GiB) {
-- 
2.47.1


