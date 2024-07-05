Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B490C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl02-0002dV-GM; Fri, 05 Jul 2024 11:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzu-0002aj-Hq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:18 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzs-0001H8-Sd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:18 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so2434633a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193835; x=1720798635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzA2EMsKf7CQ8lqPZMs8GAjfAh3DVBSL7qsQ3s3Y9XE=;
 b=mr61Th4ex8OBsmmNWv37GykglZ0JpsWZP5TOyG5UbAJPArL26dWNZZHfIaf5MDAh+i
 6E1nDF2xPP1CrIDRcL2s4yfsgsw7lR5Ec/lfLNXLgXPVzFHTE0PnpfwkZCw9sO8rURVl
 xdMLmVZSDDt0f2+1A7xeBLceyEl5TOIEii7HgHURzxohomATdzK2WAmexJCtBeOzh4h8
 5ICmTbD8Ux2QhM3kY409kt83suJG9fCZvnrn3AHPPqIm8L3Fh8TXuAr/P14mNXX+YeKf
 c9aqp8BhHIc4zQhJoHvspuTpEPfrJkEeE0r6nEWK9WXY56jI2yphhHC10CCjfyFg49mH
 6MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193835; x=1720798635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YzA2EMsKf7CQ8lqPZMs8GAjfAh3DVBSL7qsQ3s3Y9XE=;
 b=C/rF9vefZcfL94Kif2mFWobhKHceYY74P9fT5TORfIcsA39ZmxiEVY7AqZ3kbMD55N
 4r7It9WB/9adArwVmk/n0yWeGNldqXmdR1/2qqa9gVO1KCh/UinNbsoBfTwoSapdTCox
 BsF0m5pvo+mBpHkDQDvqQ7P4lVtnHJ5J0+mTeGLtRlyuFWhvT0U7n2bJqMOkGvkFB6XC
 dN0MojLgMRPSOaq/ECFeuwUnEQSfNBSm/78suoG1nSU8nQ+p+x76uJc+LezGgaogGo6T
 uWad34wPifPy86qkFj+rfjnW7/TcESd31awQwMvsY/KchE6K6Ackf4U9NpXQKD2kYBMc
 +OFQ==
X-Gm-Message-State: AOJu0YwSiqk41632bhvG9Tdaby9g8UDn87KYVAyoYwNQubAKbHtVPT8Q
 bPJyQWFTrPWAuJzHKDhYDFsF5d78IPie9bss9E9k2pu2EelQyhGYiZ8sY2SqRJQ=
X-Google-Smtp-Source: AGHT+IEPCetaNG5Cf400+fFPzzFGj7ghkDve4XAhmciBM8muzHyP8AnevjWFZVSlDTUs5v4fo6SBhw==
X-Received: by 2002:a05:6402:274c:b0:57c:6d9a:9149 with SMTP id
 4fb4d7f45d1cf-58e5adce5efmr3133130a12.15.1720193834775; 
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58eff6d1da5sm1537029a12.0.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA15962156;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 29/40] accel/tcg: Move qemu_plugin_vcpu_init__async() to
 plugins/
Date: Fri,  5 Jul 2024 16:30:41 +0100
Message-Id: <20240705153052.1219696-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Calling qemu_plugin_vcpu_init__async() on the vCPU thread
is a detail of plugins, not relevant to TCG vCPU management.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240606124010.2460-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-30-alex.bennee@linaro.org>

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


