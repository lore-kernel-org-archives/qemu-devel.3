Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B7ECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d62-0006Gx-7b; Mon, 22 Sep 2025 05:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d59-0005Qp-0B
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:39 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0d4p-0001zy-Il
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:43:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso2364315e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758534193; x=1759138993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GRsJV0VAPOLcd8y8nlS+oqJKDqNktygqxz6o8+pfd4=;
 b=JQz1DxL8QuRXlkOTtdHivr6qOQRQ7jVEHe1DNBfmnTl2u98Pz36JnbO/Kc0h+pM+Ge
 iZFjfhckIpEoBmCKj8BnH0/uCGbJ4k0k0+w3xQHOXXlTHwhWx7eNNXx0WHfy0HThXamb
 LbLlD1Ej5Nrv+R6gQVfk2lRo1/4BnkdjT/7iI3UgFl5gdXZNBBh5tfxplOvA6rEmwmSg
 zE8McGCoqnUHwex2UIgAgvscTM8tgQWq2Ijs+UBQQSPynoxcxm0oGYVug9I+McQsAXkV
 h5+s/J/rCy7NxJtPeWtKV834svC6NGFVOW3XErVsdxSBU5xkwZikwZ6i/s/FJKYa7bWU
 J20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758534193; x=1759138993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GRsJV0VAPOLcd8y8nlS+oqJKDqNktygqxz6o8+pfd4=;
 b=g6rgVyn1Z2eJAwnGKBMHDO2t+IFQFYvzrYDcey5dZme3GvToo0yBUxKlSFoROqF4oq
 DAl+gdNbSvnSTYO6rNjlp1Cwrm/AtZ1E/mXT73dhb0Az0ExWDFHu075bBLRGHX7BldKZ
 lr6zZFo41RUmvdlr7nyPxyqaJGGTfJphVf+8bvokTKQE3ibL+J0e9DqVAODTKhuOX8Pw
 l6bTaD2xbPcygOpY3K0T0SIpU2+9lje6iv5RFNibn9dtcDVty3fMmOHYcoS1uH5f1sJV
 h5SZnuT+XeYEN2ePyrESNqEwTeZYFBgAASNQHJZC2USgvFvld1G8aH7YRXeTF+7MSWux
 iDtg==
X-Gm-Message-State: AOJu0Yxn3is+VCJLlb6h9kyOTJ5EXMewa0xbsgxIKNGTYc2t/SyfqmsX
 7TLH7f2/pQNElAjbvKV/B1OsAZgTrl/38R9jnlE0OTHtts9VDhm53V0XPpirBrgczMA=
X-Gm-Gg: ASbGncsxISy6WL5b+pvWCK/DI6dtJUZYOV2YxT9QRTZPPJO1mIBRtpJ7s3ASNkjCeh7
 5IRr3KHtEzMhLYd7VrI73NgPfEYLpwBFgL5iZmER7iu7U9KaDGfjlOCyIOi3FNYjuw0AucEQQaa
 FeDdYdobr/VhfOXXXG2wxY2lBj6uJ2021Ny7BH1UVghNHAxkAZhKiu6/HZLs2ajatH7RpLuHXmC
 wGBTHU80KOFHCOTvVO2slXOwsxXqA/ZY2g8awhliJKZ7XZwIMVoHP7T+lEitwwCHsVGi0oYWFbW
 HQs/ayeKA/Wt7EnEpMB5jwn1xxSY/rjBHDPNKHSXjlV3Fd65lw2RU6Q5982AytqgCK/C0fvmj/m
 2rnuazFylXvRF9ftl2NQLjNw=
X-Google-Smtp-Source: AGHT+IGog4+Y0WnU5KswDpjQ1MvsxTCEtNhvD3dapvSYl1WAcp7YJ15rUMx6prxALge0mIrPKtA+PA==
X-Received: by 2002:a05:600c:3593:b0:45b:8477:de1a with SMTP id
 5b1f17b1804b1-467ead67316mr122960165e9.7.1758534193220; 
 Mon, 22 Sep 2025 02:43:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f527d6cdsm220145955e9.12.2025.09.22.02.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:43:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 42BE95FA2E;
 Mon, 22 Sep 2025 10:37:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 18/25] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Date: Mon, 22 Sep 2025 10:37:03 +0100
Message-ID: <20250922093711.2768983-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
2.47.3


