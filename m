Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12609CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnV-0007BT-45; Tue, 02 Sep 2025 03:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnH-00074e-Nk
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnE-0001vF-2U
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:07 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7725de6b57dso1821124b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799462; x=1757404262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JF7wvMHp6QGg+A1XjfDgDm08vP8DadjlUvjQUOqc8Gw=;
 b=jqqRF6W0MJuCu2Uc22EGKtFURteO7MF35e1RCcyYFJsYvTZyzZdsuRAr1JDR7noDwY
 /UFvdmqQkA+UJF92hXY1q929ZQbFPf8Z95FKlihQpf8NgT5FjlaTL6Zpj1YC4pFp3IaX
 o/tz5hp3vC22cQLGaGbdmyslArKq+btQkPY7lYVwXmsgsJi9EIAimoya1JWt9FLeWfWJ
 dnS5PCj5Z2l34wDn0GXnLggNCUEgHAnB9+TCP4jjX6DkLmVMcfGrgZj9Xh5ojEGWZ5Bz
 6dqA8IVf3FV+soCQwG34tRh58R3E7FuhUPHhV6T/g0szfPrNulBPhZD1rfAhHzJTVrnr
 dBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799462; x=1757404262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JF7wvMHp6QGg+A1XjfDgDm08vP8DadjlUvjQUOqc8Gw=;
 b=E1vEtlpmtSSU2UhnWe+qKbImfoBZMyJ6MGSX3nqauAkipZKF04tZplSA+MBvpHXeyh
 sdgxHWsjFZN8w7VjyeB1eTtaXOyaB3rBTNXcV9niYEUjKDaOImgsn79zzjDYm6VvRp2d
 RPs43zm/PLYHFUCjOkM8o3tu8txrHyBzSjkp9bZStXGfq5saYtCnuEiQ5z6HxL5bkjaq
 vj48SeTLmiJCOy96arVVhnGXaI0JLmeTeA5idKow4v0zjHU/A9/a5A+hGrtY6lzz/q90
 +aLsqHhspVuCi1z1SPxiLDDRYPTjbeR2GSWyPqz7p5WUXO0hpnAGz1FUUhFHyE6cKQMX
 PKFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURW7yr4LkOkvrRTmhHUnSEV/8wO1H/Z7f5FqxklkhAYoGhyfkBJJoVFJbx7mLCiUa2VkTSR+8hSp6B@nongnu.org
X-Gm-Message-State: AOJu0YxvcTYsMfz+3b6TXF1da8DFNDgJSN8X/6CGzCBDEmshhSyVRZGh
 +fY1cC5IabbmtpMQWh2pMVpfgEsuweMZJg4GFoAmZSNPsbqpZPNvH2jvhcR7MqrqGsg=
X-Gm-Gg: ASbGncvUmo0GFqwXWwWqs5HxkP8t5e0OBNA9HiQqqBVvBvs3NiMgtSZ6/H5MH/bfzJJ
 evYYlt7XPFhbL0RozFCGb/lJmXTQ4mX1qePo0NNt+rh0URT15jpr+JiaHbcTLOLJXuwaXLcgDdi
 Cr9Bd3gmae+KzesCs6tm++rhR4iAe1yP5y4mrsI4RvOOFa5iOU7B5jTaJMSBJLRYAzeu2Na4ZSO
 SIu9qcgszT+Atd+sY8H806HvH8GNVYtQtslCke6XfTx9c1mcObCmP/xaYjy9pHL7OShAldpbXQS
 JIZmtdqyAxpo+6fcXaXh+edHRQ0Gz7QTeQCSQKjjRGIyF8wPMktatauHOpIa+1QDMZJtVnDII7e
 wgWMuQBgv5P36JaSPxDJFONNrbN6qWkt/ElePU/PVDiZHnFslCpdrDA==
X-Google-Smtp-Source: AGHT+IEFd0bzmxs49ftcNLfKyXUu9LuUM7GjvR9Fe7tRGOJouvt1tnqn1NFGNrAoEgHJ9TVPVuYhkA==
X-Received: by 2002:a05:6a00:39a0:b0:757:ca2b:48a3 with SMTP id
 d2e1a72fcca58-7723e259561mr11901971b3a.9.1756799462583; 
 Tue, 02 Sep 2025 00:51:02 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:51:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH v7 7/9] contrib/plugins/uftrace: implement x64 support
Date: Tue,  2 Sep 2025 00:50:40 -0700
Message-ID: <20250902075042.223990-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

It's trivial to implement x64 support, as it's the same stack layout
as aarch64.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 86 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 2386cc723bc..b7d6124d2f5 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -82,6 +82,21 @@ typedef struct {
     struct qemu_plugin_register *reg_scr_el3;
 } Aarch64Cpu;
 
+typedef enum {
+    X64_RING0,
+    X64_RING1,
+    X64_RING2,
+    X64_RING3,
+    X64_REAL_MODE,
+    X64_PRIVILEGE_LEVEL_MAX,
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
@@ -570,6 +585,75 @@ static CpuOps aarch64_ops = {
     .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
 };
 
+static uint8_t x64_num_privilege_levels(void)
+{
+    return X64_PRIVILEGE_LEVEL_MAX;
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
+    X64Cpu *cpu = g_new0(X64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_rbp = plugin_find_register("rbp");
+    g_assert(cpu->reg_rbp);
+    cpu->reg_cs = plugin_find_register("cs");
+    g_assert(cpu->reg_cs);
+    cpu->reg_cr0 = plugin_find_register("cr0");
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
@@ -777,6 +861,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (!strcmp(info->target_name, "aarch64")) {
         arch_ops = aarch64_ops;
+    } else if (!strcmp(info->target_name, "x86_64")) {
+        arch_ops = x64_ops;
     } else {
         fprintf(stderr, "plugin uftrace: %s target is not supported\n",
                 info->target_name);
-- 
2.47.2


