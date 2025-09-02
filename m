Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D2BCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 07:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utLnS-00078A-Cd; Tue, 02 Sep 2025 03:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnF-000746-MI
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:06 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1utLnB-0001uj-F5
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 03:51:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7724fe9b24dso1321260b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756799458; x=1757404258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCnnXWfvqtRCVbfN0E52T8SkudA5RqZI+yQNyvWP9uU=;
 b=u91A5c6mTBnXlzyPcpFEK89nx9DpqbO7cMZMPnfLGU0agHKeJ1sZZLxOc57lOnNqCq
 BM1K10hI1Mr+5KjFBvEV6HR9RLC20RXUc0US0M4GZTJ6ZKnlw5WtmiAjBVMeMStqaPRS
 j88FL8UeRUWrPZBEyu06RJNHLJCN9P4XUlM2mmcNGKz1XJj7usdGVfKTD1zy9VxpUp9L
 UZcaGOhrJbdZEbbsqmGvHhi48hXBUrq30O1KQfr/rXIk2grcRD2BxJnkaQdrCyR+eCLt
 vffzf06Bev8ne7GwBeq7CgW/4r8Yxr/3B+TofVu5FsYhYUzUbaLSZ7w676au8UUPEQk5
 MwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756799458; x=1757404258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCnnXWfvqtRCVbfN0E52T8SkudA5RqZI+yQNyvWP9uU=;
 b=s+yFwckHlFa+x+i28S+7E+PbEVIR+lQxQoqjkSgY+XXuF1Dm+SD6aqQ/m7O7HSPZVz
 NQvKQng8tvQ0xW5XPymgDTDnwGVzcThpMdFzYoKDTKNoVW4nb9puwmYKA0Yq5j0xsTy0
 KNo9Che60Y/MtdLkzyE6OJz85oYKk388hoepirpmyyR5IMf5FqfoFsdPfg4wqPn4Xc2S
 7A8Ec6FmwJzlsbhEjxxFxuF2GSU85+6NMSNWnHmxQW0hfLzZ8Y+23GtMbGB1fmlzPHjq
 kDJNvGsnCu6izTkIz56TQIxMwUYrnzVjmr/uDyhjB6Y/T7G+Us0QEuhLZ2bY414e52gm
 6jgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOJr4xTvPcF87fi/yyDVWOzbvQP2FXeZGpVgVh4yv6FU9mlUbM2+MhSXgkenVtU5dJIIniqS+9vkct@nongnu.org
X-Gm-Message-State: AOJu0YwpO2TKSOJn41U1/0iqHP9B9ng++V5rg82fYLQ0ZWtaULxs2EGY
 U1tDI/ctRr9c5584RuGf3NUqCGuPCfNo43HcwqyhbRN7D8TQmoeGC4mW4vTdAGAFF0k=
X-Gm-Gg: ASbGncu2o3qhvxyZW9dKG5BIVJ6Tl1pRBZ3OxfEK3G/ROFR7snSJ+absufwJB0PyrtO
 YWKqnEefM8unSgvArdSPS72sgxhDEdQIXKivmDAppcN8DmF7WUFkxCWVqvjpUixy6yuD5wYNGj3
 OxfwpZt5VrykrVOJEUivfAwp7OVOTfDacqH6VtFUY5hfSVkxCqrKu8GKncC0SMsftrxwXuErtrO
 E7OhMIC/ytTaIDasez319/QYkmqaHcqTGEeTOqam50vyjaCTmsi4Evl3bjYeZC9OHwtCm4gO3pZ
 LHiNvFhjDNDWAZzJq+HWEa9meJVgDXn8S78PnFsFZMAlkGarMR8/r58YZS00F+W+LvKivaP3wMl
 co2FCRQ25fdLlk6Whj9PRg5+7LdGdLedlD3VJcbzOQxg=
X-Google-Smtp-Source: AGHT+IEXH6812YMC6JXK/8H0qgo14yZvWDYyItBrePQ1REDgL2+4/WWr38CWEXmUCZ7bxz5eGXfzLw==
X-Received: by 2002:a05:6a20:9144:b0:243:c6d1:777a with SMTP id
 adf61e73a8af0-243d6e5fb90mr16019365637.26.1756799457959; 
 Tue, 02 Sep 2025 00:50:57 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7723d79fcfesm9642766b3a.16.2025.09.02.00.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 00:50:57 -0700 (PDT)
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
Subject: [PATCH v7 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Date: Tue,  2 Sep 2025 00:50:35 -0700
Message-ID: <20250902075042.223990-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
References: <20250902075042.223990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

We define a new CpuOps structure that will be used to implement tracking
independently of guest architecture.

As well, we now instrument only instructions following ones that might
have touched the frame pointer.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 114 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index 4af0130b159..d060513446c 100644
--- a/contrib/plugins/uftrace.c
+++ b/contrib/plugins/uftrace.c
@@ -11,14 +11,94 @@
 
 #include <qemu-plugin.h>
 #include <glib.h>
+#include <stdio.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+typedef struct Cpu Cpu;
+
+typedef struct {
+    void (*init)(Cpu *cpu);
+    void (*end)(Cpu *cpu);
+    uint64_t (*get_frame_pointer)(Cpu *cpu);
+    bool (*does_insn_modify_frame_pointer)(const char *disas);
+} CpuOps;
+
 typedef struct Cpu {
     GByteArray *buf;
+    CpuOps ops;
+    void *arch;
 } Cpu;
 
+typedef struct {
+    struct qemu_plugin_register *reg_fp;
+} Aarch64Cpu;
+
 static struct qemu_plugin_scoreboard *score;
+static CpuOps arch_ops;
+
+static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
+{
+    GByteArray *buf = cpu->buf;
+    g_byte_array_set_size(buf, 0);
+    size_t sz = qemu_plugin_read_register(reg, buf);
+    g_assert(sz == 8);
+    g_assert(buf->len == 8);
+    return *((uint64_t *) buf->data);
+}
+
+static struct qemu_plugin_register *plugin_find_register(const char *name)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    for (int i = 0; i < regs->len; ++i) {
+        qemu_plugin_reg_descriptor *reg;
+        reg = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!strcmp(reg->name, name)) {
+            return reg->handle;
+        }
+    }
+    return NULL;
+}
+
+static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = cpu_->arch;
+    return cpu_read_register64(cpu_, cpu->reg_fp);
+}
+
+static void aarch64_init(Cpu *cpu_)
+{
+    Aarch64Cpu *cpu = g_new0(Aarch64Cpu, 1);
+    cpu_->arch = cpu;
+    cpu->reg_fp = plugin_find_register("x29");
+    if (!cpu->reg_fp) {
+        fprintf(stderr, "uftrace plugin: frame pointer register (x29) is not "
+                        "available. Please use an AArch64 cpu (or -cpu max).\n");
+        g_abort();
+    }
+}
+
+static void aarch64_end(Cpu *cpu)
+{
+    g_free(cpu->arch);
+}
+
+static bool aarch64_does_insn_modify_frame_pointer(const char *disas)
+{
+    /*
+     * Check if current instruction concerns fp register "x29".
+     * We add a prefix space to make sure we don't match addresses dump
+     * in disassembly.
+     */
+    return strstr(disas, " x29");
+}
+
+static CpuOps aarch64_ops = {
+    .init = aarch64_init,
+    .end = aarch64_end,
+    .get_frame_pointer = aarch64_get_frame_pointer,
+    .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
+};
 
 static void track_callstack(unsigned int cpu_index, void *udata)
 {
@@ -28,19 +108,37 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
+    /*
+     * Callbacks and inline instrumentation are inserted before an instruction.
+     * Thus, to see instruction effect, we need to wait for next one.
+     * Potentially, the last instruction of a block could modify the frame
+     * pointer. Thus, we need to always instrument first instruction in a tb.
+     */
+    bool instrument_insn = true;
     for (size_t i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
-        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
-        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
-                                               QEMU_PLUGIN_CB_R_REGS,
-                                               (void *) pc);
+        if (instrument_insn) {
+            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                                   QEMU_PLUGIN_CB_R_REGS,
+                                                   (void *) pc);
+            instrument_insn = false;
+        }
+
+        char *disas = qemu_plugin_insn_disas(insn);
+        if (arch_ops.does_insn_modify_frame_pointer(disas)) {
+            instrument_insn = true;
+        }
     }
 }
 
 static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
 {
     Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
+    cpu->ops = arch_ops;
+
+    cpu->ops.init(cpu);
     cpu->buf = g_byte_array_new();
 }
 
@@ -64,6 +162,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    if (!strcmp(info->target_name, "aarch64")) {
+        arch_ops = aarch64_ops;
+    } else {
+        fprintf(stderr, "plugin uftrace: %s target is not supported\n",
+                info->target_name);
+        return 1;
+    }
+
     score = qemu_plugin_scoreboard_new(sizeof(Cpu));
     qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_atexit_cb(id, at_exit, NULL);
-- 
2.47.2


