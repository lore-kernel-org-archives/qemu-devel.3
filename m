Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BB4C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 14:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reypP-0003KE-BM; Tue, 27 Feb 2024 09:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypL-00035Q-VY
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:04 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1reypD-0004o3-Di
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 09:53:03 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33dc3fe739aso1726735f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709045574; x=1709650374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXDxBEkC2CFS7m0UvHeEw8KC6OyK5f7eV2u61Rlbk5g=;
 b=cYIouQgCxk1hjqSOcsaWqHULu/c9y8H+xZjPbx+a6cxFdtbaVSiS1rJc4g2uvVpqGI
 BKlpd4SAI0BtWmhAMkb2kVMGVH5zs03KogU/uDyuKRVVAqNF6DrNvhg7g1Dx0G0rQ1Mx
 fxq3lctQv/4CE3oa2tzFLiakVbqLeX8i+284RjdkhfRsRTB52ePBk3Pcq2gk0dZL+rIc
 n7SjdSLQOd9kBET0oRTDUPwXXsMFlha05XRKT7H16yMvuXsk3ZLt73vl/hyk73mvg/vb
 sgUoNw3CeNyzIaAWDFJ7RBFV2ZXuG4ITAgpIJfacr2gSFfE09DJd2NiuIbMlu4BfNshY
 xPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709045574; x=1709650374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXDxBEkC2CFS7m0UvHeEw8KC6OyK5f7eV2u61Rlbk5g=;
 b=S6+gn6xtP/1sHGCk/bm5Ddt/3J3PJgAGvnjzVjVZaupalqG98PMUFX7dCJ0/PNCdFv
 qlYcgqzEy8z3fVCK4/vtTi7Hfp7bNhxBjFDBRE5QPkCLxOWFHlQP7NUm4IVysMisgXfr
 0XjVc2H9uGvKr8MPSFA7PZZQDpuaCHki7NIIyC02jmGsDlptjfBiEIep+A8JlNFmxzf+
 AfFM9Yv55Je3cumGqbHJNFThTtU/3DcCbzp9GhlX1jZQisY6Sd95av0nlP/f7SqH16Od
 /T1oDBgvXpSTXboDfhqnOxMvaVyFDA/KAWCqLFxSKWqz0EdMnqFJi5n1Q/bMtATV76GK
 mdlw==
X-Gm-Message-State: AOJu0YwFVkEKGxEwmU4iakHXwqnQrKaKvYdAw4kCHpo2fHxFi8vJxsMq
 hvEWPsuL8/7vu/TplrcxZh+xTFvChyBcM1zROmVxcVCQYPbD4JNKpIinHUvWJzU=
X-Google-Smtp-Source: AGHT+IEcFMsC2JJwKC0bBneainqEcvPcDmG2A+BFpPsnm18l2mIDy/CHEn9AzQ2NlkvPeq7z9bbO+A==
X-Received: by 2002:adf:f303:0:b0:33d:c0c3:fe0a with SMTP id
 i3-20020adff303000000b0033dc0c3fe0amr8838773wro.0.1709045573764; 
 Tue, 27 Feb 2024 06:52:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 by15-20020a056000098f00b0033da933b250sm11807543wrb.5.2024.02.27.06.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 06:52:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 005245F92D;
 Tue, 27 Feb 2024 14:43:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-arm@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Michael Rolnik <mrolnik@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-s390x@nongnu.org, Kyle Evans <kevans@freebsd.org>,
 Brad Smith <brad@comstyle.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <bcain@quicinc.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 26/29] contrib/plugins: extend execlog to track register
 changes
Date: Tue, 27 Feb 2024 14:43:32 +0000
Message-Id: <20240227144335.1196131-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227144335.1196131-1-alex.bennee@linaro.org>
References: <20240227144335.1196131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

With the new plugin register API we can now track changes to register
values. Currently the implementation is fairly dumb which will slow
down if a large number of register values are being tracked. This
could be improved by only instrumenting instructions which mention
registers we are interested in tracking.

Example usage:

  ./qemu-aarch64 -D plugin.log -d plugin \
     -cpu max,sve256=on \
     -plugin contrib/plugins/libexeclog.so,reg=sp,reg=z\* \
     ./tests/tcg/aarch64-linux-user/sha512-sve

will display in the execlog any changes to the stack pointer (sp) and
the SVE Z registers.

As testing registers every instruction will be quite a heavy operation
there is an additional flag which attempts to optimise the register
tracking by only instrumenting instructions which are likely to change
its value. This relies on the QEMU disassembler showing up the register
names in disassembly so is an explicit opt-in.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240223162202.1936541-25-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Based-On: <20231025093128.33116-19-akihiko.odaki@daynix.com>

---
v3
  - just use a GArray for the CPU array
  - drop duplicate of cpu_index
v4
  - rebase and api fixups
  - I accidentally squashed the optimisation last round so update
  commit message with the details.
v5
  - qemu_plugin_get_registers always returns an array
---
 docs/devel/tcg-plugins.rst |  17 +-
 contrib/plugins/execlog.c  | 316 +++++++++++++++++++++++++++++++------
 2 files changed, 281 insertions(+), 52 deletions(-)

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index 81dcd43a612..fa7421279f5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -497,6 +497,22 @@ arguments if required::
   $ qemu-system-arm $(QEMU_ARGS) \
     -plugin ./contrib/plugins/libexeclog.so,ifilter=st1w,afilter=0x40001808 -d plugin
 
+This plugin can also dump registers when they change value. Specify the name of the
+registers with multiple ``reg`` options. You can also use glob style matching if you wish::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,reg=\*_el2,reg=sp -d plugin
+
+Be aware that each additional register to check will slow down
+execution quite considerably. You can optimise the number of register
+checks done by using the rdisas option. This will only instrument
+instructions that mention the registers in question in disassembly.
+This is not foolproof as some instructions implicitly change
+instructions. You can use the ifilter to catch these cases:
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libexeclog.so,ifilter=msr,ifilter=blr,reg=x30,reg=\*_el1,rdisas=on
+
 - contrib/plugins/cache.c
 
 Cache modelling plugin that measures the performance of a given L1 cache
@@ -583,4 +599,3 @@ The following API is generated from the inline documentation in
 include the full kernel-doc annotations.
 
 .. kernel-doc:: include/qemu/qemu-plugin.h
-
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index f262e5555eb..a1dfd59ab71 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2021, Alexandre Iooss <erdnaxe@crans.org>
  *
- * Log instruction execution with memory access.
+ * Log instruction execution with memory access and register changes
  *
  * License: GNU GPL, version 2 or later.
  *   See the COPYING file in the top-level directory.
@@ -15,29 +15,40 @@
 
 #include <qemu-plugin.h>
 
+typedef struct {
+    struct qemu_plugin_register *handle;
+    GByteArray *last;
+    GByteArray *new;
+    const char *name;
+} Register;
+
+typedef struct CPU {
+    /* Store last executed instruction on each vCPU as a GString */
+    GString *last_exec;
+    /* Ptr array of Register */
+    GPtrArray *registers;
+} CPU;
+
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-/* Store last executed instruction on each vCPU as a GString */
-static GPtrArray *last_exec;
+static GArray *cpus;
 static GRWLock expand_array_lock;
 
 static GPtrArray *imatches;
 static GArray *amatches;
+static GPtrArray *rmatches;
+static bool disas_assist;
+static GMutex add_reg_name_lock;
+static GPtrArray *all_reg_names;
 
-/*
- * Expand last_exec array.
- *
- * As we could have multiple threads trying to do this we need to
- * serialise the expansion under a lock.
- */
-static void expand_last_exec(int cpu_index)
+static CPU *get_cpu(int vcpu_index)
 {
-    g_rw_lock_writer_lock(&expand_array_lock);
-    while (cpu_index >= last_exec->len) {
-        GString *s = g_string_new(NULL);
-        g_ptr_array_add(last_exec, s);
-    }
-    g_rw_lock_writer_unlock(&expand_array_lock);
+    CPU *c;
+    g_rw_lock_reader_lock(&expand_array_lock);
+    c = &g_array_index(cpus, CPU, vcpu_index);
+    g_rw_lock_reader_unlock(&expand_array_lock);
+
+    return c;
 }
 
 /**
@@ -46,13 +57,10 @@ static void expand_last_exec(int cpu_index)
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
                      uint64_t vaddr, void *udata)
 {
-    GString *s;
+    CPU *c = get_cpu(cpu_index);
+    GString *s = c->last_exec;
 
     /* Find vCPU in array */
-    g_rw_lock_reader_lock(&expand_array_lock);
-    g_assert(cpu_index < last_exec->len);
-    s = g_ptr_array_index(last_exec, cpu_index);
-    g_rw_lock_reader_unlock(&expand_array_lock);
 
     /* Indicate type of memory access */
     if (qemu_plugin_mem_is_store(info)) {
@@ -73,32 +81,91 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t info,
 }
 
 /**
- * Log instruction execution
+ * Log instruction execution, outputting the last one.
+ *
+ * vcpu_insn_exec() is a copy and paste of vcpu_insn_exec_with_regs()
+ * without the checking of register values when we've attempted to
+ * optimise with disas_assist.
  */
-static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+static void insn_check_regs(CPU *cpu)
 {
-    GString *s;
+    for (int n = 0; n < cpu->registers->len; n++) {
+        Register *reg = cpu->registers->pdata[n];
+        int sz;
 
-    /* Find or create vCPU in array */
-    g_rw_lock_reader_lock(&expand_array_lock);
-    if (cpu_index >= last_exec->len) {
-        g_rw_lock_reader_unlock(&expand_array_lock);
-        expand_last_exec(cpu_index);
-        g_rw_lock_reader_lock(&expand_array_lock);
+        g_byte_array_set_size(reg->new, 0);
+        sz = qemu_plugin_read_register(reg->handle, reg->new);
+        g_assert(sz == reg->last->len);
+
+        if (memcmp(reg->last->data, reg->new->data, sz)) {
+            GByteArray *temp = reg->last;
+            g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
+            /* TODO: handle BE properly */
+            for (int i = sz; i >= 0; i--) {
+                g_string_append_printf(cpu->last_exec, "%02x",
+                                       reg->new->data[i]);
+            }
+            reg->last = reg->new;
+            reg->new = temp;
+        }
+    }
+}
+
+/* Log last instruction while checking registers */
+static void vcpu_insn_exec_with_regs(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
+
+    /* Print previous instruction in cache */
+    if (cpu->last_exec->len) {
+        if (cpu->registers) {
+            insn_check_regs(cpu);
+        }
+
+        qemu_plugin_outs(cpu->last_exec->str);
+        qemu_plugin_outs("\n");
+    }
+
+    /* Store new instruction in cache */
+    /* vcpu_mem will add memory access information to last_exec */
+    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
+    g_string_append(cpu->last_exec, (char *)udata);
+}
+
+/* Log last instruction while checking registers, ignore next */
+static void vcpu_insn_exec_only_regs(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
+
+    /* Print previous instruction in cache */
+    if (cpu->last_exec->len) {
+        if (cpu->registers) {
+            insn_check_regs(cpu);
+        }
+
+        qemu_plugin_outs(cpu->last_exec->str);
+        qemu_plugin_outs("\n");
     }
-    s = g_ptr_array_index(last_exec, cpu_index);
-    g_rw_lock_reader_unlock(&expand_array_lock);
+
+    /* reset */
+    cpu->last_exec->len = 0;
+}
+
+/* Log last instruction without checking regs, setup next */
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    CPU *cpu = get_cpu(cpu_index);
 
     /* Print previous instruction in cache */
-    if (s->len) {
-        qemu_plugin_outs(s->str);
+    if (cpu->last_exec->len) {
+        qemu_plugin_outs(cpu->last_exec->str);
         qemu_plugin_outs("\n");
     }
 
     /* Store new instruction in cache */
     /* vcpu_mem will add memory access information to last_exec */
-    g_string_printf(s, "%u, ", cpu_index);
-    g_string_append(s, (char *)udata);
+    g_string_printf(cpu->last_exec, "%u, ", cpu_index);
+    g_string_append(cpu->last_exec, (char *)udata);
 }
 
 /**
@@ -111,6 +178,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     struct qemu_plugin_insn *insn;
     bool skip = (imatches || amatches);
+    bool check_regs_this = rmatches;
+    bool check_regs_next = false;
 
     size_t n = qemu_plugin_tb_n_insns(tb);
     for (size_t i = 0; i < n; i++) {
@@ -131,7 +200,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         /*
          * If we are filtering we better check out if we have any
          * hits. The skip "latches" so we can track memory accesses
-         * after the instruction we care about.
+         * after the instruction we care about. Also enable register
+         * checking on the next instruction.
          */
         if (skip && imatches) {
             int j;
@@ -139,6 +209,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                 char *m = g_ptr_array_index(imatches, j);
                 if (g_str_has_prefix(insn_disas, m)) {
                     skip = false;
+                    check_regs_next = rmatches;
                 }
             }
         }
@@ -153,8 +224,39 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             }
         }
 
+        /*
+         * Check the disassembly to see if a register we care about
+         * will be affected by this instruction. This relies on the
+         * dissembler doing something sensible for the registers we
+         * care about.
+         */
+        if (disas_assist && rmatches) {
+            check_regs_next = false;
+            gchar *args = g_strstr_len(insn_disas, -1, " ");
+            for (int n = 0; n < all_reg_names->len; n++) {
+                gchar *reg = g_ptr_array_index(all_reg_names, n);
+                if (g_strrstr(args, reg)) {
+                    check_regs_next = true;
+                    skip = false;
+                }
+            }
+        }
+
+        /*
+         * We now have 3 choices:
+         *
+         * - Log insn
+         * - Log insn while checking registers
+         * - Don't log this insn but check if last insn changed registers
+         */
+
         if (skip) {
-            g_free(insn_disas);
+            if (check_regs_this) {
+                qemu_plugin_register_vcpu_insn_exec_cb(insn,
+                                                       vcpu_insn_exec_only_regs,
+                                                       QEMU_PLUGIN_CB_R_REGS,
+                                                       NULL);
+            }
         } else {
             uint32_t insn_opcode;
             insn_opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
@@ -167,30 +269,124 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
                                              QEMU_PLUGIN_MEM_RW, NULL);
 
             /* Register callback on instruction */
-            qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
-                                                   QEMU_PLUGIN_CB_NO_REGS, output);
+            if (check_regs_this) {
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, vcpu_insn_exec_with_regs,
+                    QEMU_PLUGIN_CB_R_REGS,
+                    output);
+            } else {
+                qemu_plugin_register_vcpu_insn_exec_cb(
+                    insn, vcpu_insn_exec,
+                    QEMU_PLUGIN_CB_NO_REGS,
+                    output);
+            }
 
             /* reset skip */
             skip = (imatches || amatches);
         }
 
+        /* set regs for next */
+        if (disas_assist && rmatches) {
+            check_regs_this = check_regs_next;
+        }
+
+        g_free(insn_disas);
     }
 }
 
+static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
+{
+    Register *reg = g_new0(Register, 1);
+    g_autofree gchar *lower = g_utf8_strdown(desc->name, -1);
+    int r;
+
+    reg->handle = desc->handle;
+    reg->name = g_intern_string(lower);
+    reg->last = g_byte_array_new();
+    reg->new = g_byte_array_new();
+
+    /* read the initial value */
+    r = qemu_plugin_read_register(reg->handle, reg->last);
+    g_assert(r > 0);
+    return reg;
+}
+
+static GPtrArray *registers_init(int vcpu_index)
+{
+    g_autoptr(GPtrArray) registers = g_ptr_array_new();
+    g_autoptr(GArray) reg_list = qemu_plugin_get_registers();
+
+    if (rmatches && reg_list->len) {
+        /*
+         * Go through each register in the complete list and
+         * see if we want to track it.
+         */
+        for (int r = 0; r < reg_list->len; r++) {
+            qemu_plugin_reg_descriptor *rd = &g_array_index(
+                reg_list, qemu_plugin_reg_descriptor, r);
+            for (int p = 0; p < rmatches->len; p++) {
+                g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
+                g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
+                if (g_pattern_match_string(pat, rd->name) ||
+                    g_pattern_match_string(pat, rd_lower)) {
+                    Register *reg = init_vcpu_register(rd);
+                    g_ptr_array_add(registers, reg);
+
+                    /* we need a list of regnames at TB translation time */
+                    if (disas_assist) {
+                        g_mutex_lock(&add_reg_name_lock);
+                        if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
+                            g_ptr_array_add(all_reg_names, reg->name);
+                        }
+                        g_mutex_unlock(&add_reg_name_lock);
+                    }
+                }
+            }
+        }
+    }
+
+    return registers->len ? g_steal_pointer(&registers) : NULL;
+}
+
+/*
+ * Initialise a new vcpu/thread with:
+ *   - last_exec tracking data
+ *   - list of tracked registers
+ *   - initial value of registers
+ *
+ * As we could have multiple threads trying to do this we need to
+ * serialise the expansion under a lock.
+ */
+static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    CPU *c;
+
+    g_rw_lock_writer_lock(&expand_array_lock);
+    if (vcpu_index >= cpus->len) {
+        g_array_set_size(cpus, vcpu_index + 1);
+    }
+    g_rw_lock_writer_unlock(&expand_array_lock);
+
+    c = get_cpu(vcpu_index);
+    c->last_exec = g_string_new(NULL);
+    c->registers = registers_init(vcpu_index);
+}
+
 /**
  * On plugin exit, print last instruction in cache
  */
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     guint i;
-    GString *s;
-    for (i = 0; i < last_exec->len; i++) {
-        s = g_ptr_array_index(last_exec, i);
-        if (s->str) {
-            qemu_plugin_outs(s->str);
+    g_rw_lock_reader_lock(&expand_array_lock);
+    for (i = 0; i < cpus->len; i++) {
+        CPU *c = get_cpu(i);
+        if (c->last_exec && c->last_exec->str) {
+            qemu_plugin_outs(c->last_exec->str);
             qemu_plugin_outs("\n");
         }
     }
+    g_rw_lock_reader_unlock(&expand_array_lock);
 }
 
 /* Add a match to the array of matches */
@@ -212,6 +408,18 @@ static void parse_vaddr_match(char *match)
     g_array_append_val(amatches, v);
 }
 
+/*
+ * We have to wait until vCPUs are started before we can check the
+ * patterns find anything.
+ */
+static void add_regpat(char *regpat)
+{
+    if (!rmatches) {
+        rmatches = g_ptr_array_new();
+    }
+    g_ptr_array_add(rmatches, g_strdup(regpat));
+}
+
 /**
  * Install the plugin
  */
@@ -223,11 +431,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
      * Initialize dynamic array to cache vCPU instruction. In user mode
      * we don't know the size before emulation.
      */
-    if (info->system_emulation) {
-        last_exec = g_ptr_array_sized_new(info->system.max_vcpus);
-    } else {
-        last_exec = g_ptr_array_new();
-    }
+    cpus = g_array_sized_new(true, true, sizeof(CPU),
+                             info->system_emulation ? info->system.max_vcpus : 1);
 
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
@@ -236,13 +441,22 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
             parse_insn_match(tokens[1]);
         } else if (g_strcmp0(tokens[0], "afilter") == 0) {
             parse_vaddr_match(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "reg") == 0) {
+            add_regpat(tokens[1]);
+        } else if (g_strcmp0(tokens[0], "rdisas") == 0) {
+            if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &disas_assist)) {
+                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
+                return -1;
+            }
+            all_reg_names = g_ptr_array_new();
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
         }
     }
 
-    /* Register translation block and exit callbacks */
+    /* Register init, translation block and exit callbacks */
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
 
-- 
2.39.2


