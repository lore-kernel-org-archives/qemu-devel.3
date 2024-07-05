Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4304BC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVq-00021r-Ie; Fri, 05 Jul 2024 04:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVG-00009h-FT
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:16 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVD-0003IH-In
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:14 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-58b447c51bfso1786014a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168869; x=1720773669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+z1akQCdvD4EPIckgvY2ywucJ1AQ3R2DHXwf7IjKDc=;
 b=ndxaD3ACtGucNmxTduEJYr7U1uNmPv+WMKgXwsqf0o4Tn9HDH4+rspT45KH7wheQ8+
 z5Un7TXQPgIfasrBZMBpxgNjGVvTPcIr0lzn/hAIeU3ooRXQwzPMwXawUePmg6Ylr74G
 tj7idwWtD6EbAheulxdsFKbFfSoPopJsVSMwV3lEnknm7Pu+M+Q73qaspuxFeOL7KwFL
 nR0780dOSn/DiHSerwZE1LMdnpdMXcJ28tWhLT8yKld0xvWVxeo/9G7tnuHbzOX0BTft
 s2fGo33ab7xq/h/QaRTxVMMjVynyxUcqNFfGw4zuOKCl+TgfQpiELDr4WLUFw6SVAPd7
 D6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168869; x=1720773669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+z1akQCdvD4EPIckgvY2ywucJ1AQ3R2DHXwf7IjKDc=;
 b=OWO5quiJPjWH5hcoWCM5pRNP5Kz5TRR1aptjjt3da2HJV/Lq6kKsscx6ws98W82hnM
 ZwjyJgrtTMhtmo/i++azWCJESyJjF3i2RyMqPXKkh6pzoufP9Obfjuc/XEUBNh44J+X/
 GxoWYBwl01ibek3O2td4d/OiIK+mQYcoYIqOaBeJxUAYeknh8QQ/6CfLrxuI8spsQeLN
 AUI6pJ2uCkbNl0HL86bu2MxQ4fcjN/5e/8ZILY9foFx6TfZnI7AivyWsBHK0Yc9YScXo
 dFKBjgRdEzlDAr9WM03TgSao8p6ncHSejUQCA5XPKgT6PBnu91xRzjc039vsh8KNODTR
 HZIA==
X-Gm-Message-State: AOJu0YwvSh+HneYxAxmBZvCikcxoUQu6mym2BKwthGQkDzp8XlN1fWs1
 +PYBSY0BKTm/c9yKcvjFDwm/vZ6uYi7fj8gCrxd78+b3MWLWnME7Ha+yeMv4QyM=
X-Google-Smtp-Source: AGHT+IFyHg2rkZgGiY42rqPAYRhZULZTk8PAfnHDMb2P387ScVI/ThA5hJE8jhCFt/yupzymWrXSyQ==
X-Received: by 2002:a05:6402:5ce:b0:58e:dbd:65cd with SMTP id
 4fb4d7f45d1cf-58e5b5a68b0mr2957743a12.26.1720168868595; 
 Fri, 05 Jul 2024 01:41:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58fbfccf0f9sm444538a12.75.2024.07.05.01.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:41:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D4CF62156;
 Fri,  5 Jul 2024 09:40:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 29/40] accel/tcg: Move qemu_plugin_vcpu_init__async() to
 plugins/
Date: Fri,  5 Jul 2024 09:40:36 +0100
Message-Id: <20240705084047.857176-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Calling qemu_plugin_vcpu_init__async() on the vCPU thread
is a detail of plugins, not relevant to TCG vCPU management.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/cpu-common.c | 9 +--------
 plugins/core.c       | 8 +++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 8f6cb64da3..b19e1fdacf 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -192,13 +192,6 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
-#ifdef CONFIG_PLUGIN
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
-{
-    qemu_plugin_vcpu_init_hook(cpu);
-}
-#endif
-
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -274,7 +267,7 @@ static void cpu_common_initfn(Object *obj)
 #ifdef CONFIG_PLUGIN
     if (tcg_enabled()) {
         cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+        qemu_plugin_vcpu_init_hook(cpu);
     }
 #endif
 }
diff --git a/plugins/core.c b/plugins/core.c
index a864275ae7..12c67b4b4e 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -241,7 +241,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
     end_exclusive();
 }
 
-void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
 {
     bool success;
 
@@ -258,6 +258,12 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
 }
 
+void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+{
+    /* Plugin initialization must wait until the cpu start executing code */
+    async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+}
+
 void qemu_plugin_vcpu_exit_hook(CPUState *cpu)
 {
     bool success;
-- 
2.39.2


