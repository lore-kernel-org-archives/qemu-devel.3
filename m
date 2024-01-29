Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E016DC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUUoT-0006Xe-7K; Mon, 29 Jan 2024 11:48:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnQ-00019h-0q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:44 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUUnN-0004NV-M2
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 11:47:43 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40ef6f10b56so8563665e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 08:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706546860; x=1707151660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hwuuHYCScnVvYP7kr484+mrpPVY1E/98uP6CY+N7AAI=;
 b=RFKg3vCoowrAkLTqnIIURrSNTlEJlBXG3vjNksP7QymPt35OO3QJo2y1p51b0RVrRy
 Y40fLgxd36wiD2lyFhcC9Q85rlHi303u3Gb/ZWEnwoB4Y1+4XTz5SEns+4wKlLKYLBka
 iArpWMGOgRmiQoqTh42tmoumr7JRTp0NIsDaaOYLZ8btVNJJGWLCzzIuv79jS1hfiZG1
 zm0HVCivE9gGaEKnRU0uxxLgLhiBobMmaKtCwQ0LlbYBkbJdSIMQnR0P1ROs0bwdN0yU
 t8u14cGanoeIOLrfN7MdA8does6j5FSL3WEXmULzUgR4lXet0laqbvpbIug2Ta/3HBOP
 mhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706546860; x=1707151660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hwuuHYCScnVvYP7kr484+mrpPVY1E/98uP6CY+N7AAI=;
 b=kpgvnyNsLrJfO64arIH5J4VAYgJDM0U2pPUThAcWhk0hL/onLw39qw8q6JXyjdd4WE
 AubFN6YKTAJ2hCtvvAurPzd3OPlpYUZaZckLC6sCcw01rryoKF06JTx8E+4Ub2bSvRLn
 sfFmcWm8UwjGvWsDJi/P9j6BUzdKLVM1Vrg6KfTxMjMqTV8LmGjurLPIV0cN6Bk4NyNM
 BqcLBp5XybQZaFwVkQcCqjjVNKwiyeIrpwCR2l6ov7aTJ3+oO7JDjemDWHo2a1gh4zoh
 zEpSfCHBy6U2g1UMil4dxc4sPWV29V8v8ObM+4ixhfE0oa4T1+aCKYFhShlvdR0VXuq4
 DoGw==
X-Gm-Message-State: AOJu0YwTq3KOsykhnPnDcTYtFwbwMt/ejGAhtbtsmCOVxqTXypcNlJdJ
 Mb4aJdczMDyyjPPPsS1rnlf9tqSRL24RjEfhb0glq+FiKo8Gx0W3YVr7W+UDakvj/ObSiSQJSgy
 s
X-Google-Smtp-Source: AGHT+IFTnZ+wzzZWUdYzzOHHXq5N3vCTRzXyKyUR2LVbswqDwUPsHfY3FzalsZVCFAgzuwGQbmEO1g==
X-Received: by 2002:adf:f310:0:b0:33a:eae2:11a6 with SMTP id
 i16-20020adff310000000b0033aeae211a6mr2615980wro.37.1706546860049; 
 Mon, 29 Jan 2024 08:47:40 -0800 (PST)
Received: from m1x-phil.lan ([176.187.219.39])
 by smtp.gmail.com with ESMTPSA id
 v9-20020adff689000000b0033af5c43155sm657193wrp.56.2024.01.29.08.47.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jan 2024 08:47:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 23/29] target/rx: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Mon, 29 Jan 2024 17:45:05 +0100
Message-ID: <20240129164514.73104-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129164514.73104-1-philmd@linaro.org>
References: <20240129164514.73104-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Mechanical patch produced running the command documented
in scripts/coccinelle/cpu_env.cocci_template header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c       | 4 ++--
 target/rx/gdbstub.c   | 6 ++----
 target/rx/helper.c    | 6 ++----
 target/rx/translate.c | 3 +--
 4 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 58ca26184d..4689587fa9 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -66,9 +66,9 @@ static bool rx_cpu_has_work(CPUState *cs)
 
 static void rx_cpu_reset_hold(Object *obj)
 {
-    RXCPU *cpu = RX_CPU(obj);
+    CPUState *cs = CPU(obj);
     RXCPUClass *rcc = RX_CPU_GET_CLASS(obj);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
     uint32_t *resetvec;
 
     if (rcc->parent_phases.hold) {
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index d7e0e6689b..f222bf003b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -21,8 +21,7 @@
 
 int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    RXCPU *cpu = RX_CPU(cs);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
 
     switch (n) {
     case 0 ... 15:
@@ -53,8 +52,7 @@ int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    RXCPU *cpu = RX_CPU(cs);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
     uint32_t psw;
     switch (n) {
     case 0 ... 15:
diff --git a/target/rx/helper.c b/target/rx/helper.c
index dad5fb4976..80912e8dcb 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -45,8 +45,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 #define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
-    RXCPU *cpu = RX_CPU(cs);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
     int do_irq = cs->interrupt_request & INT_FLAGS;
     uint32_t save_psw;
 
@@ -122,8 +121,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
 
 bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    RXCPU *cpu = RX_CPU(cs);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
     int accept = 0;
     /* hardware interrupt (Normal) */
     if ((interrupt_request & CPU_INTERRUPT_HARD) &&
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 1829a0b1cd..26aaf7a6b5 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -131,8 +131,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 
 void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    RXCPU *cpu = RX_CPU(cs);
-    CPURXState *env = &cpu->env;
+    CPURXState *env = cpu_env(cs);
     int i;
     uint32_t psw;
 
-- 
2.41.0


