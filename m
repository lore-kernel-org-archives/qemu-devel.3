Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E7AC47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 22:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTULQ-0003U0-U8; Fri, 26 Jan 2024 17:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKw-0001xI-IW
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:10 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rTUKs-0004R5-B9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 17:06:08 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40ee82d040dso9921965e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706306761; x=1706911561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Fp9tWfUnWpTWSY0wSSNV5XB5wPrgNqsnYE0Bp5WmMs=;
 b=FaMf0o5ELztjZZjY0qxxwlGRIwT8Pe+zfZjIqDoPSDmX4nfIA6CQh2CxJO6btaabAi
 ygzNvz/1Ft7F0mTk4cTgQ+phOHFzlmKtSVCtFjOqSUbZotquJ7e75jwmO/Bt1Mm/qNy6
 3fHRiMp0FAxIThUk3lphL1NiQRXfzOIol6FiaZqW3TG2kHbagkdgWmAQW+kJJRlLeK4p
 XtQ9G3iqORnzztKZtHuS9pU+dtvfVMGUIYRr1t4yLNgwtyXIUtus5ij1/YdiT66k1HeK
 Unv/H8gWiFtZdpCu7WmqnCsUcQZcRm454YXr52J7xJ2GyZQ41IM51E9RFxZ47rI5cmIa
 jV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706306761; x=1706911561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Fp9tWfUnWpTWSY0wSSNV5XB5wPrgNqsnYE0Bp5WmMs=;
 b=G3SEx84ZgobYV5HcVIK9rUxhmFEua9Qkv3SjelDcgN/vCXSfI9dNHfS8bOLZva0qwY
 8MMq9BLD8+1SMCbKwH6RHht2pFCx69lFouznmPOOeX3E0klFFKnexw2bH2Hd72aeTR8a
 U4XGUd6qd/08SxMsI4RBrz0h9ATKAZhE/kBelo4RP1gJb7rKc5Ty/SL1lFkBSwKiD56O
 zw2toZrn1yAH0PmT2OzAB/vgGClypycWXBqhZVkirwQ1/l3cYZV2pWvxIpUlLK3g4Y3z
 dU7CNzapwInug6tDZgUQ8J4ivrU1e/RvFu0E9J8qV+2uX6aAVMKd2PfAuUnKLJrgARbr
 QQkw==
X-Gm-Message-State: AOJu0YxKiH824Aw9aIW+yY2gR0Ctes1nDrZS1A86OscZYEt0jxPoZhCO
 VGrMTC9H12gL80R+n6mszYGQQlwoGh/OXtAVl0Qdb6e8tNC1RLcS0vM2XMX8hLcbDhBUqQ72nhI
 S
X-Google-Smtp-Source: AGHT+IFd1IbswSIXEXRwvvayIHbXjba/igiz3MLifb8MrBXCEI38IVU61Lu9pQK0loQXCyARtTly0w==
X-Received: by 2002:a05:600c:5187:b0:40e:d44a:ca9c with SMTP id
 fa7-20020a05600c518700b0040ed44aca9cmr330302wmb.48.1706306761345; 
 Fri, 26 Jan 2024 14:06:01 -0800 (PST)
Received: from m1x-phil.lan ([176.176.142.39])
 by smtp.gmail.com with ESMTPSA id
 bi19-20020a05600c3d9300b0040ee51f1025sm1819887wmb.43.2024.01.26.14.05.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Jan 2024 14:06:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v2 18/23] target/rx: Prefer fast cpu_env() over slower CPU QOM
 cast macro
Date: Fri, 26 Jan 2024 23:04:00 +0100
Message-ID: <20240126220407.95022-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240126220407.95022-1-philmd@linaro.org>
References: <20240126220407.95022-1-philmd@linaro.org>
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
---
 target/rx/gdbstub.c   | 6 ++----
 target/rx/helper.c    | 6 ++----
 target/rx/translate.c | 3 +--
 3 files changed, 5 insertions(+), 10 deletions(-)

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


