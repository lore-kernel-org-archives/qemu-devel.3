Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAD2CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28Pu-0006HZ-60; Fri, 26 Sep 2025 09:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Ps-0006Gp-5n
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Pm-0004vY-Ii
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:23:15 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1627009f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892982; x=1759497782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MRX+Cpo73yx+rWEIEKqZAU5Sre7tyLuOpCcwtQxBwO0=;
 b=dea6kKyZFq64pCSp18cHs48S86gl9iyCFuHBpown508ZPgGl2hS5C6ugrw+WebBQVW
 lnEfSntNKjLuqcO9R2TE2UuvwrfYtwYsKPHOyM62u08Xns5N0ArgWoZujCTdzpg0P18C
 MebycimbSZLTOaDjTgylQh7tbuAmmWDmdLPLX+XzhIa/prlPS69PeJCipm0M55UWJpZr
 HwH2twXhMr/nCs40LMnXPfW8cZFH0hIAP0/6I5jcwF2/8U7S2ULIJNgXTACktzSw1+2o
 +Qm4PGXcaPAmkKe6IJoLC8WwfRjYvtVC/0tpyv9hfy2waCg4wM+m360V/qrQ26zeAPRS
 ffVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892982; x=1759497782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MRX+Cpo73yx+rWEIEKqZAU5Sre7tyLuOpCcwtQxBwO0=;
 b=X7lvRFZp/Chj7F2KOAYxEivM6Xz6n2qasEZnp2LvAMpHlPiE0F16s4LdNfrCgCpbqX
 LVv7PP+gCFF0fXpcb3R8GPAmy8tzl+/qo9lJ83oWiYAPTZllhQPKViKsmiY6h0H/x1+f
 d6trUkpR143ww7d75TBBSikF6+UOx7ofaDZbGVI6WegEcDJLS/s4+59jqzZnVyB/5WqK
 8xd2/pkeEhdzYNEIo/kpa/whDrsaK97QbfXe/ft83eDn20TM67TiZKSJDgKxsHnN/MpI
 64Xm+w3l6dcCXYG9IhywHul/RRqKj1L2BmTYApnSNSEEwQX8UdBugK088HUVM6taD+zA
 bYlw==
X-Gm-Message-State: AOJu0YxNph/0y2qlTyYHddD+vGTKQ3eXDKaDDX5ZS++pLC9B1+czpWBQ
 Bg/i5BczcaN0h75oQbhWPu8qSm71X5SBvOwexcgdSCzskyj4NpgWc1cpuMbRtES4QFE=
X-Gm-Gg: ASbGncubKnA1N3es7b8JXhnSr1EqksNiJ2S7BTSnOVr/Jo/0DvNjx6NAIbCztWT4TIt
 BfUTtU+bgHEap9CaxK+iWGQlehboC+/N8PIZrtKDbXQHeebnz49LpoEcF8dhMluIOxFgjplp/iP
 4geTsaKh/jidASIWezaxlvaXZCxrdeYvfRAUq/ECyWPvB5juPrZyKLnrII8nY4ecLgMDH4Z/o3R
 1pGq7FxrfTkTr0/ISfwGXE0CZQkUQGW5VRGyACAue6CNNYtEhA5b2bQNsjxoqzLxnHzN8f8wp/W
 /EWh932fvg7bogZPCa0h8OdKk2qzI+fiHQmurNshEC4Mi/qerCD84gkfY07hrKjCWuI5s+dvV8+
 bj2SdNcyzkAH7tLi731l4ExShyGyzISUFjw==
X-Google-Smtp-Source: AGHT+IGm6h0yCBTll1ySHWuaEGoA1VDbE+OY1q9J4q55+McRnK8HlqjDKNZO8Jlc67L1YLyQqsEnUQ==
X-Received: by 2002:a05:6000:2909:b0:3ee:1494:27f5 with SMTP id
 ffacd0b85a97d-40f6203ae47mr6652530f8f.13.1758892981610; 
 Fri, 26 Sep 2025 06:23:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fe4237f32sm7012074f8f.63.2025.09.26.06.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:23:00 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 55C425F92A;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 17/24] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Date: Fri, 26 Sep 2025 14:17:36 +0100
Message-ID: <20250926131744.432185-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We define a new CpuOps structure that will be used to implement tracking
independently of guest architecture.

As well, we now instrument only instructions following ones that might
have touched the frame pointer.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250902075042.223990-3-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-19-alex.bennee@linaro.org>

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
2.47.3


