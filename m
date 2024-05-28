Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9C8C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sByJY-0000jV-5L; Tue, 28 May 2024 11:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJW-0000j8-1Y
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:34 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sByJU-00078y-CU
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:00:33 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5295f201979so1055197e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716908429; x=1717513229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFr0hL1Ar1UbWkc2eKqlJoQWp8y4Pl+E2QiBqPA7F5Y=;
 b=U5WlW2S6zWgelvtLovxI/v4ub50XSEMhTdcTCwQHDVH1YF1Ibs7qjpC+6QIwXQssjF
 l1KigkKv1vTJ8oIl9DBOyynkUA5ZtvZB0QZIEFM15Ig8NhPENFM/a7wDRXeDbzpxjCK8
 s/TPwtyTFW9t/uYd8btdp1y2Km80Qbd8uBGaLkS7OSGxWwNMr/wAqWW4qC160E0eLAdW
 5Wu/DcDl7AneoTJAbFm9tpc7UIrGIcPvhtSk1HvWGGhp2tvi3fJxTDjKVflutrGhUjZ/
 VpG90SRMmKCNfz7qykoC0ZftnSOMxHVuAx++FreJw3Yf5slMUjdjWVoaMtUW+ZdOSGEP
 +0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716908429; x=1717513229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFr0hL1Ar1UbWkc2eKqlJoQWp8y4Pl+E2QiBqPA7F5Y=;
 b=tGwWn+8p+TlB+CUmwl1+B3D7vyJsSdA2PcYCFTdx01aDVZyzCBUSK/brZeMdXh1wf0
 UziJE5ZujXMhYAC4VVedixAo5813lGbD3W9XnAqsNpT5IExZxREiIxjZwCqJh0BrEDMi
 bbVFG0REJ1tGCWh6x+090frwerQT3kAhHTNVFy7cM7W+pDZ1yTobGDJCiAG094GaPMmd
 m0KupU4BGHQIGHqK6Kx4rwdYxOL4WAa3VMhRk0hnMICDyLQTC30azVnkoOJnNvX/PF8P
 KxsWE7v13GbvtUemx6Ez52vzyn4HocCiVAvU8rG9RJ2esVm6n0zLoeYZVUQc10ItwEpJ
 Kc4w==
X-Gm-Message-State: AOJu0YwKXNO8sVzDs3qML+OCJPG/SFTRoCdOG2KzPW84C9OYAx0UD/E6
 CY89P/WALX7TJk9mD+w7mE8At6jY8qZixKcog3xH4/rixEiS255cmbXSIby7pY5yuR6feVqXekw
 9
X-Google-Smtp-Source: AGHT+IGeYA1BZtkeWhNA6Lx+7kLkCJ57cTtE63409GLF7cKVa/bTw40tpfc7j+6F0EDDMCgj8OfmMQ==
X-Received: by 2002:ac2:4acf:0:b0:529:593f:3f3c with SMTP id
 2adb3069b0e04-529666d5dfemr8138200e87.53.1716908429187; 
 Tue, 28 May 2024 08:00:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.214.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc4feadsm617200466b.127.2024.05.28.08.00.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 08:00:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 6/6] accel/tcg: Move qemu_plugin_vcpu_init__async() to plugins/
Date: Tue, 28 May 2024 16:59:52 +0200
Message-ID: <20240528145953.65398-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240528145953.65398-1-philmd@linaro.org>
References: <20240528145953.65398-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Calling qemu_plugin_vcpu_init__async() on the vCPU thread
is a detail of plugins, not relevant to TCG vCPU management.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec-common.c | 11 ++---------
 plugins/core.c              |  8 +++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 3c4a4c9f21..02499bfb1d 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -57,19 +57,12 @@ void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc)
     cpu_loop_exit_restore(cpu, pc);
 }
 
-#ifdef CONFIG_PLUGIN
-static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
-{
-    qemu_plugin_vcpu_init_hook(cpu);
-}
-#endif
-
 bool tcg_exec_realize_assigned(CPUState *cpu, Error **errp)
 {
 #ifdef CONFIG_PLUGIN
     cpu->plugin_state = qemu_plugin_create_vcpu_state();
-    /* Plugin initialization must wait until the cpu start executing code */
-    async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+
+    qemu_plugin_vcpu_init_hook(cpu);
 #endif
 
     return true;
diff --git a/plugins/core.c b/plugins/core.c
index 0726bc7f25..0eda47ba33 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -245,7 +245,7 @@ static void plugin_grow_scoreboards__locked(CPUState *cpu)
     end_exclusive();
 }
 
-void qemu_plugin_vcpu_init_hook(CPUState *cpu)
+static void qemu_plugin_vcpu_init__async(CPUState *cpu, run_on_cpu_data unused)
 {
     bool success;
 
@@ -261,6 +261,12 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
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
2.41.0


