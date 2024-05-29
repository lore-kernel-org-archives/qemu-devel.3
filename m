Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9B3C27C43
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCL8M-0001de-7q; Wed, 29 May 2024 11:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCL8L-0001dS-8T
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:22:33 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCL8J-0001nS-6M
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:22:32 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2e9819a630fso5280941fa.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716996149; x=1717600949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fTksdLPLiWK2it8kbCH0j2Wz6G5Oz9kxuWwnHiWElfQ=;
 b=L4XcBMv4gzLkB6c6XgYzQJuxc66ORCjFJ2aS0Gdu68Mc6OVDlsi8fnwXQ35S0iQNNA
 jR6XzRmsdsiSjavWooXvWxw+g0I0EQm+v5EF0NWIh8mEHdzXB6OUK3cHs1Z3Xn81PPcf
 pDYzgcBdx8YInuMcWvYoUtJam7PCnT2lWaT9L0pNE67pxkHry+EhgqXTLb+Vk822nLV6
 4PLWe8uk2lxcPMk+t00R7FS/Nd1G0qzwBjOXHf5JieZlTonsTsbxsI3A1J7iY0BuPSUk
 NApVllyHSKq4C7f2cGa1fh6KAY6sRMHqOplAg/JEhAA6SJfooGwZ/mLl0bhjzrhRqCZ/
 zQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716996149; x=1717600949;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fTksdLPLiWK2it8kbCH0j2Wz6G5Oz9kxuWwnHiWElfQ=;
 b=SxtsX1YWTlMEuWH47ex5Elcrr9V3VTUNNabXptXZElx4jb9rpcbDe/dlNDPO2vP98u
 zz8EoLfTycAdTvetxjfiYLaqmS8N3OTjcC7di1lZ/Etrd96uUSCkLPGyxdOxkIxUx3IS
 Q6YMVEuQz+9/clkuNvBh4DvBjkb0m8XUJ6EjTK5s1f6UiibdjPtCyVHbdBKKyA5l9GoJ
 ViL4O/yQJfTYDbOJTYeAVGgrIdIpSJBDzH3BCKT5v8w+fbrc5gvzIe98n1es6NGkH++I
 EYnTee6sOLvCYZJwrUT00/mXVOGpbDJ+OhZxmKTIx0YL8bS5ciDgGmA5BPbC+pOOq50G
 fN9A==
X-Gm-Message-State: AOJu0YzmkADj2YjFE95tZbvKq5fHRgDnRHThLQlq3f6x6D1iXZqJallX
 OPJ9XYYXQ4hHcngZNrFozTof6yMVosOLQMlbzv8yf7iy+ziKVcRVPm3i/q8LYb0=
X-Google-Smtp-Source: AGHT+IF5eR4sWKw2z3eI3paegCXz0ZAlCdgc4BX3+0dZMQOdhcHihMAJr7wN5cgxSi5s8PekT+RA8A==
X-Received: by 2002:a2e:804b:0:b0:2ea:8163:5f4f with SMTP id
 38308e7fff4ca-2ea816360bcmr4005311fa.41.1716996148999; 
 Wed, 29 May 2024 08:22:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda31b4sm729528466b.191.2024.05.29.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 08:22:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 081345F760;
 Wed, 29 May 2024 16:22:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread creation
Date: Wed, 29 May 2024 16:22:19 +0100
Message-Id: <20240529152219.825680-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

This ensures we don't start the thread until cpu_common_realizefn has
finished. This ensures that plugins will always run
qemu_plugin_vcpu_init__async first before any other states. It doesn't
totally eliminate the race that plugin_cpu_update__locked has to work
around though. I found this while reviewing the ips plugin which makes
heavy use of the vcpu phase callbacks.

An alternative might be to move the explicit creation of vCPU threads
to qdev_machine_creation_done()? It doesn't affect user-mode which
already has a thread to execute in and ensures the QOM object has
completed creation in cpu_create() before continuing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h      |  8 ++++++++
 accel/tcg/user-exec-stub.c |  5 +++++
 hw/core/cpu-common.c       |  7 ++++++-
 plugins/core.c             |  5 +++++
 system/cpus.c              | 15 ++++++++++-----
 5 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bb398e8237..6920699585 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1041,6 +1041,14 @@ void end_exclusive(void);
  */
 void qemu_init_vcpu(CPUState *cpu);
 
+/**
+ * qemu_start_vcpu:
+ * @cpu: The vCPU to start.
+ *
+ * Create the vCPU thread and start it running.
+ */
+void qemu_start_vcpu(CPUState *cpu);
+
 #define SSTEP_ENABLE  0x1  /* Enable simulated HW single stepping */
 #define SSTEP_NOIRQ   0x2  /* Do not use IRQ while single stepping */
 #define SSTEP_NOTIMER 0x4  /* Do not Timers while single stepping */
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc8..162bb72bbe 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -18,6 +18,11 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
+void qemu_start_vcpu(CPUState *cpu)
+{
+    /* NOP for user-mode, we already have a thread */
+}
+
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 0f0a247f56..68895ddd59 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -230,7 +230,12 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
     }
 #endif
 
-    /* NOTE: latest generic point where the cpu is fully realized */
+    /*
+     * With everything set up we can finally start the vCPU thread.
+     * This is a NOP for linux-user.
+     * NOTE: latest generic point where the cpu is fully realized
+     */
+    qemu_start_vcpu(cpu);
 }
 
 static void cpu_common_unrealizefn(DeviceState *dev)
diff --git a/plugins/core.c b/plugins/core.c
index 0726bc7f25..1e5da7853b 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -65,6 +65,11 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
+    /*
+     * There is a race condition between the starting of the vCPU
+     * thread at the end of cpu_common_realizefn and when realized is
+     * finally set.
+     */
     if (DEVICE(cpu)->realized) {
         async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
     } else {
diff --git a/system/cpus.c b/system/cpus.c
index d3640c9503..7dd8464c5e 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -488,11 +488,13 @@ void cpus_kick_thread(CPUState *cpu)
 
 void qemu_cpu_kick(CPUState *cpu)
 {
-    qemu_cond_broadcast(cpu->halt_cond);
-    if (cpus_accel->kick_vcpu_thread) {
-        cpus_accel->kick_vcpu_thread(cpu);
-    } else { /* default */
-        cpus_kick_thread(cpu);
+    if (cpu->halt_cond) {
+        qemu_cond_broadcast(cpu->halt_cond);
+        if (cpus_accel->kick_vcpu_thread) {
+            cpus_accel->kick_vcpu_thread(cpu);
+        } else { /* default */
+            cpus_kick_thread(cpu);
+        }
     }
 }
 
@@ -674,7 +676,10 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu->num_ases = 1;
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
+}
 
+void qemu_start_vcpu(CPUState *cpu)
+{
     /* accelerators all implement the AccelOpsClass */
     g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
     cpus_accel->create_vcpu_thread(cpu);
-- 
2.39.2


