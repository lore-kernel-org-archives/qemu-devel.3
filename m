Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04803C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCVx-0008Cn-0L; Thu, 07 Aug 2025 22:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVs-00087T-8k
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:21 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVl-0003Tx-7A
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:15 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76aea119891so2788010b3a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618831; x=1755223631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mz5cEembi0r5EM31bY2UE3YFcscP1MIRJopPm7hW/tY=;
 b=xNlcI4D5m6aARLMGVf2FD7ut12ItKahUgqOwtNGek7/E0NGpNKRhRJAOmrqVFuztft
 XfVRcU2OUuHbIbpsga7QRrKi6llJJ8waqjM7ptE3KkxUvFLMZqZ7XMnPWE1uJchxFxne
 ezILOIq559y3dIxbQkE7j+kgedipEtg7kA+RWrRpy+kDosLr0CcbpLZNf8nv07R6zEd1
 TKqBzwsUYPXCyw9LC1hRpA1QPqCCDpsSYmCGHkhtZs66o0UedBEYUkZfHgMJGMRiFNkg
 wvhEyzlLguA78NQ/6j/XC+a5B7a3LN8hkmgfPj30pFKvgbIDsdBzAs5Vgj30Uy70lHp6
 7UUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618831; x=1755223631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mz5cEembi0r5EM31bY2UE3YFcscP1MIRJopPm7hW/tY=;
 b=B6IQ6jbjuMoysAs/hT6GbQZYYQX538SoD3XwhBMQZLWzY/r1OoIb3TXoSWnrLWFbyd
 pb1pPqHx8DAYj6uoPdyAdXi5T1BQQuC0A4xdH7q5crTTrhAMytYE1SNX101FlBA264gc
 pPWPSm2bkG0+6UEvHXA74kd0PVX1ZzssyaZtMQ1rnFQ7dYXXCXXZ2ENE1c1bLNGCAeUz
 T8dBST2qOr9Lxta/vSPtluxDY4A23UpaTH4RLOln+MXMwOUjGRdtDhh8QmSZOgiUX8cs
 SqDuVOsOi4TM6NrJl0wFxvz3GLS7cD1kBlYMNSMDmd1s/K/NP76iZyqwEbWFN2sKNxN+
 QC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7kOYD2MroePLxu7Nvp3sHb7d3rEix6aCI/bqsisYne2k4HUoxdsOvvWHeaZbhjwM3vJjbLdZVJS29@nongnu.org
X-Gm-Message-State: AOJu0YwD9j9Ci2rrC/uRJly8fHUFskrwt2PoGAZE8C4PF/1SmipADCdj
 ckDRftbjXGr0y1lJL5ENqEmxjl8Jcscc1Q8AAZr3bxc5dtjKvO48jcvlSrcCqIiCl2k=
X-Gm-Gg: ASbGncvI/Nmwx0RbktXAJrLrlgYEAzfsvM3JmGmkWFVYWS2LmMSTFylkCEFwJrWBy9s
 eSPFm3+NLvYXh66dcyUDZHIZsunvfVrj89QhwdfEnNlO2SBSc9ctQ3+hSLNTGP7aBcmz3SsE02Z
 slSGBybYmK8aXjs8F6NHnggP+CWvCpALwfPfzc0RyO1dteEYW8+2pthr/w6j5EGRMb8ftbSeQbO
 GS5hL6n6J1y8S9TfiX7Zai3Y2GdITH1Qyv6KYZnnTO3EMk+tXcL4sfD4k8hQ7CECpxnm0HzNsa9
 oTQgLSZkwwo+4bKBl7m4lIOHB5UiG9C1Z/i9TsmXg0TP1RJrcxSqTXwAyWiR04JTjJKb6CqfoTa
 HdIk8s8ysQua1hNf75PR6Hg==
X-Google-Smtp-Source: AGHT+IEaNwVJK/tKNCXRGKFQaOaM7TCB5Tqy3IhB7JUAypFAcv9AVzUyi4miuRkUNEy0LJ6hfxFRWA==
X-Received: by 2002:a05:6a20:7286:b0:23f:fa35:d0b1 with SMTP id
 adf61e73a8af0-2404117c03fmr10489717637.3.1754618830731; 
 Thu, 07 Aug 2025 19:07:10 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 2/9] contrib/plugins/uftrace: define cpu operations and
 implement aarch64
Date: Thu,  7 Aug 2025 19:06:55 -0700
Message-ID: <20250808020702.410109-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
have touch the frame pointer.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/uftrace.c | 112 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 4 deletions(-)

diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
index d60c1077496..4b1a2f38143 100644
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
@@ -28,20 +108,36 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
+    /*
+     * We instrument all instructions following one that might have updated
+     * the frame pointer. We always instrument first instruction in block, as
+     * last executed instruction, in previous tb, may have modified it.
+     */
+    bool instrument_insn = true;
     for (int i = 0; i < n_insns; i++) {
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
-        uintptr_t pc = qemu_plugin_insn_vaddr(insn);
-        qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
-                QEMU_PLUGIN_CB_R_REGS,
-                (void *) pc);
+        if (instrument_insn) {
+            uintptr_t pc = qemu_plugin_insn_vaddr(insn);
+            qemu_plugin_register_vcpu_insn_exec_cb(insn, track_callstack,
+                                                   QEMU_PLUGIN_CB_R_REGS,
+                                                   (void *) pc);
+            instrument_insn = false;
+        }
 
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
 
@@ -65,6 +161,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


