Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6258C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2p8-00057n-3y; Thu, 24 Jul 2025 16:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p5-00055o-Ms
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uf2p2-0007NL-3F
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:45:51 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b3f7404710aso464634a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753389942; x=1753994742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnYNV82V/hf4sGHaMrMgGS5MLgMIqFR5EpaSxp5dO0I=;
 b=X9TyR/125lGSBu3gBtxdYrMJz/SxuU9D9LsCIb+e020A2Xl6lt401CiHTEMdcNhBQE
 wg0/IEdRkfOic6zEEXZFB+KusMEjcc0uxJINf9T1HHv0bijrgup6MprkMVPJTr2f/A7c
 QrWqqonBYN/DORwPU2LqAKUPguyhbRMkcWdkmeLqKd6JbLq3PPVjhojY0WTV4GYWx9dL
 oe9Iryg9bBfGuxcJNt7KmUChcpZ76tWF6DVC9BuaXNmC6nUTK6MGp0cpjHyJhY/2VKAw
 RPeKBvokiJ2PnAjiCjyLBm7vZDU1EFiZXhKbY9P3RcsXzlJYBF8fvzBg8BZ/jf2I1V+c
 cG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753389942; x=1753994742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnYNV82V/hf4sGHaMrMgGS5MLgMIqFR5EpaSxp5dO0I=;
 b=Su4TcCDIR0tzGSmRZgkydDPxgjJQokTkXvqe9Y3t1WjBYtBzMvIr0lDk+XyHbXVKr2
 haS4mII1xHLaatelmFIrgSL9PZeXzr6Z4g3+O15UrVM7js4AQ9OLA4Rs4IvoAGUQrZ4w
 OpGuBaV5yiEkelT+1LEouLLpd9Mwqr5oQ9+OKgoyi3VjCQ/CTQ0FzS+IWQZPiQhymtAw
 Mfjt7Fd+Qc1D1zPZWUj3DRHUXePV1DKb5FFvoKbT522smpXHAM4foXsuLUZrUKyMXVJd
 7GTPHdIOFk2PeZBPwT7WcqwdboRK9pft0m6wDZQkYuIKpCNV0BqfNU6e69Afbsx8YD9T
 fDQw==
X-Gm-Message-State: AOJu0Yw6iiaAq6Z99CgF0mKG+n0cCYPI91mpDWBI++8H56jregFtpN1/
 XF8qB0iY4fYTdsH2HV1KHTYX6z/EXVlxx16UHoEox23xodkjlzo+VFvxgqbIuGe3Ky2eK5woebt
 f5CVk
X-Gm-Gg: ASbGncvOkRwPuBOl30cGdBV4G5wrrHRi/BJAMEvc31dVC8svTIK+zflNLSwY245Y7XK
 jAoAoib3Pgi37yVK6pG/yr06hDZ9z3eUhyNTRy29E+bdluGHl180qIj8Eja+e2hvQSPBEmG26XW
 fDOIiH75c6FcHXGPZ6n6fitUv7zxQEDm243TRnZDgWUaVOGjU4mriSihZjL+YsolP4zQIB3D5r6
 cyPzT0ilPGev0F+9Vn0ZdcPIw0K6pTDAsRWm4uOlpttqeNIGQJwAna/1aAzw6ztEPqwAjCPe976
 wKcqG6yOvG6q1B4DjJvsnJQs+Ie1zIRz+TEhAap80zQXgOSzUilyKTsaWSI0OECLUsICyiIROvQ
 mNarAEnzvW0cXfrg3WudIig==
X-Google-Smtp-Source: AGHT+IGmXppgDcILUdYyBMVlLqeBAuYT2d+CQGo50adD/LDYXpmQhGG2hdH7rXmvvrZPVw5ZWvmKXg==
X-Received: by 2002:a17:90b:3809:b0:31e:326e:4d2d with SMTP id
 98e67ed59e1d1-31e5073f566mr10507541a91.5.1753389941776; 
 Thu, 24 Jul 2025 13:45:41 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662f6be0sm2008849a91.35.2025.07.24.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 13:45:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 7/7] contrib/plugins/uftrace: add support for x64
Date: Thu, 24 Jul 2025 13:45:26 -0700
Message-ID: <20250724204527.3175839-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
References: <20250724204527.3175839-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

Stack layout is the same as aarch64, so we can reuse the same code.
We don't track stack in real mode, but it does not really matter as it's
usually very short, when the machine boots.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst  | 14 ++++--
 contrib/plugins/uftrace.c | 94 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 118f059711f..7f45dc209b6 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -824,9 +824,8 @@ Uftrace
 This plugin generates a binary trace compatible with
 `uftrace <https://github.com/namhyung/uftrace>`_.
 
-Plugin supports aarch64 only (x64 support should be trivial to add), and works
-in user and system mode, allowing to trace a system boot, which is not something
-possible usually.
+Plugin supports aarch64 and x64, and works in user and system mode, allowing to
+trace a system boot, which is not something possible usually.
 
 In user mode, the memory mapping is directly copied from ``/proc/self/maps`` at
 the end of execution. Uftrace should be able to retrieve symbols by itself,
@@ -842,7 +841,8 @@ default again on x64
 <https://www.brendangregg.com/blog/2024-03-17/the-return-of-the-frame-pointers.html>`_.
 On aarch64, this is less of a problem, as they are usually part of the ABI,
 except for leaf functions. That's true for user space applications, but not
-necessarily for bare metal code.
+necessarily for bare metal code. You can read this `section
+<uftrace_build_system_example>` to easily build a system with frame pointers.
 
 Timestamps used for events are the number of instructions executed so far by
 default. As it's tracked per vcpu, each timeline should be considered
@@ -964,6 +964,8 @@ find below some sequences taken from this trace:
 Build and run system example
 ++++++++++++++++++++++++++++
 
+.. _uftrace_build_system_example:
+
 Building a full system image with frame pointers is not trivial.
 
 We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
@@ -972,6 +974,10 @@ and debian userland. It's based on containers (``podman`` only) and
 ``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
 on machine where you build it.
 
+You can follow the exact same instructions for a x64 system, combining edk2,
+Linux, and Ubuntu, simply by switching to
+`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
+
 To build the system::
 
     # Install dependencies
diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 9cbadda0aae..8fc22302989 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -81,6 +81,20 @@ typedef struct {
     struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
+typedef enum {
+    X64_RING0,
+    X64_RING1,
+    X64_RING2,
+    X64_RING3,
+    X64_REAL_MODE,
+} X64PrivilegeLevel;
+
+typedef struct {
+    struct qemu_plugin_register *reg_rbp;
+    struct qemu_plugin_register *reg_cs;
+    struct qemu_plugin_register *reg_cr0;
+} X64Cpu;
+
 typedef struct {
     uint64_t timestamp;
     uint64_t data;
@@ -600,6 +614,84 @@ static CpuOps aarch64_ops = {
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t x64_num_privilege_levels(void)
+{
+    return X64_REAL_MODE + 1;
+}
+
+static const char *x64_get_privilege_level_name(uint8_t pl)
+{
+    switch (pl) {
+    case X64_RING0: return "Ring0";
+    case X64_RING1: return "Ring1";
+    case X64_RING2: return "Ring2";
+    case X64_RING3: return "Ring3";
+    case X64_REAL_MODE: return "RealMode";
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint8_t x64_get_privilege_level(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    uint64_t cr0 = cpu_read_register64(cpu_, cpu->reg_cr0);
+    uint64_t protected_mode = (cr0 >> 0) & 0b1;
+    if (!protected_mode) {
+        return X64_REAL_MODE;
+    }
+    uint32_t cs = cpu_read_register32(cpu_, cpu->reg_cs);
+    uint32_t ring_level = (cs >> 0) & 0b11;
+    return ring_level;
+}
+
+static uint64_t x64_get_frame_pointer(Cpu *cpu_)
+{
+    X64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_rbp);
+}
+
+static void x64_init(Cpu *cpu_)
+{
+    X64Cpu *cpu = g_malloc0(sizeof(X64Cpu));
+    cpu_->arch = cpu;
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    for (int i = 0; i < regs->len; ++i) {
+        qemu_plugin_reg_descriptor *reg;
+        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!strcmp(reg->name, "rbp")) {
+            cpu->reg_rbp = reg->handle;
+        } else if (!strcmp(reg->name, "cs")) {
+            cpu->reg_cs = reg->handle;
+        } else if (!strcmp(reg->name, "cr0")) {
+            cpu->reg_cr0 = reg->handle;
+        }
+    }
+    g_assert(cpu->reg_rbp);
+    g_assert(cpu->reg_cs);
+    g_assert(cpu->reg_cr0);
+}
+
+static void x64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool x64_does_insn_modify_frame_pointer(const char *disas)
+{
+    return strstr(disas, "rbp");
+}
+
+static CpuOps x64_ops = {
+    .init = x64_init,
+    .end = x64_end,
+    .get_frame_pointer = x64_get_frame_pointer,
+    .get_privilege_level = x64_get_privilege_level,
+    .num_privilege_levels = x64_num_privilege_levels,
+    .get_privilege_level_name = x64_get_privilege_level_name,
+    .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
+};
+
 static void track_privilege_change(unsigned int cpu_index, void *udata)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
@@ -905,6 +997,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
+    } else if (!strcmp(info->target_name, "x86_64")) {
+        arch_ops = x64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.2


