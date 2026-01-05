Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827FC2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJg-0000yk-C5; Mon, 05 Jan 2026 06:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJZ-0000tZ-3e
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:58 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJV-0001nB-FQ
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:56 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so226188745ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610792; x=1768215592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiKcOcTTz94ABpJ/GtmfSGPNcCi/kbiWMe2ly8GnX9Q=;
 b=lts3tBiUF1T2bqKHb4qZOPzZ45xrpEqJ4jVj9cWLmOOEXNGF3lfNSkJEM3Rn5Cstok
 lVdt935zxodHLh8hjsHjn1YBNloLxLTbM8F+cUPAQTlZ+aahoGiDqyoPgq9B9ovq2cok
 5UFv6MGBwZ6czgLqbIwEcnN2d/EVVXaJ9XmMnZXrn9ZryNhjNCJc7mRrx+Nuxm2NjAqD
 XvuEHd23sj8Ckh/NnjMqQHVIj5Mmdn13Wrn6ZWh9oCBuk7JJRO3ssxbumeiiPbEbsWTi
 0teIUpxyitE0CexXi7DLBdQuwPdHNIvaJFm17uJs+5Q9WlSyhRALnKa2ZX9yYgYXuNoI
 YGJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610792; x=1768215592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiKcOcTTz94ABpJ/GtmfSGPNcCi/kbiWMe2ly8GnX9Q=;
 b=uDau51IkVa6dWs0V8MvHhR36JLo02JYl9I7wj+86P1q6Es+zUB6nd/4D1LxA3oJIQa
 UfO/AKrLCjysYIh6ScCj9v1ql31wd8cUTwI9dtvC3+gaMA3mZShCw6+f2sNlBgbdGKO7
 sMmWH/CweUgt00SiLf9A2MehQfkoFH9ldTza32XI80TP+8mv4fc3kRhyASBjlzF8rPP8
 zsP0moiWtZketUJk6jcAT2kqCNk1Y3bkknVueBfIkavVQ1kjc+vtLeZEMN7dG43ZxF48
 KfUUDjY5nD/hwK6YlcjnoCnnaK3IYAjXeFIVesiwYnqAMExIwz+8jmHC1eHdEyhVcGpg
 I2Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkw9lspZYA86kaD/toJeIILtLQPr8byg7TSlaH1ujbfecNWJlfyr+VWFUPsqgp7kZ5Yazn1wQCNgLl@nongnu.org
X-Gm-Message-State: AOJu0Yw2vdAuNRJp5Pq3tdzQzwv4cOOdhdATb9eahunkUQ1uhknWovPS
 qPqRF3YSAbk5bnonuL0O2+tyJGiN0rISvLSahP+IXnMO0nE/i+8a0yYxSxAS03bV5Fg=
X-Gm-Gg: AY/fxX5K69oI9YVeNPe6hplYhr2PUd6U7AjZBnFZgi9hvBrhPK9iuCINLX+EG5YxTaH
 R8ptBf+dUM1oOHY+vNWQPubAl7HOJnNI33/rOVwj5fhEpztEWwTrE0cwLoUQRmHUcIYn13Gi4AQ
 Mr1rhTaWQVS82rWDveMUl5iFkSvDxvMCIwyoPP9OoPLg1+AE0KIptgPkOJZ4uVwlKRuZRNIRDc9
 2ZUq3OvljQWvavVzw2j4WGdkBPfspRjSi5ympLnT05G+IF7zhSylvOIZ3kfkKCE7sFiQGQltE2o
 iWRCm9ujP05Wyjs0b5EWmesMh7CwkJU5vUQbPG8siKj55xTipPmgloSxwb6CZXj7IeydOMh0AnP
 y3L5xZGgtjSXkB5pFOAQ9ADPQ66cGLBsRHBpCvvk4omr/XTq7Z5kriBT2f0PeJdoDuNj2x2sn/8
 hDqckwZALV7NNjgmJAbaxH6FCk74yJH0jADF3TsEv6gPwBIMI=
X-Google-Smtp-Source: AGHT+IHlfQV5bh9Oba/TzK2O6mXkvoZukjO4FsxjfHmysCQLPhMoZzmri8ID+ux2xpIvdYvIw6OfCg==
X-Received: by 2002:a17:902:f552:b0:2a0:c933:beed with SMTP id
 d9443c01a7336-2a2f2209461mr486488005ad.4.1767610792036; 
 Mon, 05 Jan 2026 02:59:52 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 02:59:51 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 1/5] target/riscv: Add arch=dump CPU property for ISA
 introspection
Date: Mon,  5 Jan 2026 18:59:36 +0800
Message-ID: <20260105105940.3567112-2-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x632.google.com
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

---
 docs/system/target-riscv.rst              |  60 ++++++++++
 target/riscv/cpu.c                        | 128 ++++++++++++++++++++++
 target/riscv/cpu_cfg_fields.h.inc         |   3 +
 target/riscv/tcg/tcg-cpu.c                |  33 ++++++
 tests/functional/riscv32/meson.build      |   4 +
 tests/functional/riscv32/test_cpu_arch.py |  61 +++++++++++
 tests/functional/riscv64/meson.build      |   4 +
 tests/functional/riscv64/test_cpu_arch.py |  80 ++++++++++++++
 8 files changed, 373 insertions(+)
 create mode 100644 tests/functional/riscv32/test_cpu_arch.py
 create mode 100644 tests/functional/riscv64/test_cpu_arch.py

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c2..3ec53dbf9e5 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -73,6 +73,66 @@ undocumented; you can get a complete list by running
    riscv/virt
    riscv/xiangshan-kunminghu
 
+RISC-V CPU options
+------------------
+
+RISC-V CPUs support various options to configure ISA extensions and other
+features. These options can be specified using the ``-cpu`` command line
+option.
+
+ISA extension configuration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Individual ISA extensions can be enabled or disabled using boolean properties::
+
+  $ qemu-system-riscv64 -M virt -cpu rv64,v=true,zba=false
+
+The ``arch`` property
+^^^^^^^^^^^^^^^^^^^^^
+
+The ``arch`` property provides a convenient way to inspect the current ISA
+configuration:
+
+* ``arch=dump``
+
+  Print the current ISA configuration and exit. This shows the full ISA string
+  and the status of all supported extensions::
+
+    $ qemu-system-riscv64 -M virt -cpu rv64,arch=dump
+    $ qemu-riscv64 -cpu rv64,v=true,arch=dump /bin/true
+
+  The dump shows the final configuration after all CPU properties are applied,
+  regardless of where ``arch=dump`` appears in the option list. For example,
+  both of the following commands show the same result with vector extension
+  enabled::
+
+    $ qemu-riscv64 -cpu rv64,v=true,arch=dump /bin/true
+    $ qemu-riscv64 -cpu rv64,arch=dump,v=true /bin/true
+
+Privilege-implied extensions
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some RISC-V extensions cannot be individually enabled or disabled. These
+extensions are automatically enabled based on the privilege specification
+version configured for the CPU. Examples include:
+
+- ``shcounterenw``, ``shgatpa``, ``shtvala``, ``shvsatpa``, ``shvstvala``,
+  ``shvstvecd`` - Enabled when privilege spec 1.12 or later is supported
+- ``ssccptr``, ``sscounterenw``, ``ssstrict``, ``sstvala``, ``sstvecd``,
+  ``ssu64xl`` - Enabled when privilege spec 1.12 or later is supported
+- ``ziccamoa``, ``ziccif``, ``zicclsm``, ``za64rs`` - Enabled when
+  privilege spec 1.12 or later is supported
+
+These extensions appear in the ``arch=dump`` output under "Privilege Implied
+Extensions" section. To control these extensions, use the ``priv_spec``
+property to set the privilege specification version::
+
+  $ qemu-riscv64 -cpu rv64,h=false,priv_spec=v1.11.0,arch=dump /bin/true
+
+Note: Some extensions like H (Hypervisor) require a minimum privilege spec
+version. When lowering the privilege spec, you may need to disable such
+extensions first.
+
 RISC-V CPU firmware
 -------------------
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f26d8b8b07..2886b7ebcdd 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -896,6 +896,129 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 }
 #endif
 
+static inline const char *riscv_ext_status_str(bool enabled)
+{
+    return enabled ? "enabled" : "disabled";
+}
+
+/*
+ * Helper function to print multi-letter extension entries for arch=dump.
+ * Does not print section header.
+ */
+static void riscv_cpu_dump_multiext_entries(RISCVCPU *cpu,
+                                            const RISCVCPUMultiExtConfig *exts)
+{
+    for (const RISCVCPUMultiExtConfig *prop = exts;
+         prop && prop->name; prop++) {
+        bool enabled = isa_ext_is_enabled(cpu, prop->offset);
+        qemu_printf("  %-20s  %-8s\n",
+                    prop->name,
+                    riscv_ext_status_str(enabled));
+    }
+}
+
+/*
+ * Helper function to print multi-letter extensions for arch=dump.
+ */
+static void riscv_cpu_dump_multiext(RISCVCPU *cpu, const char *title,
+                                    const RISCVCPUMultiExtConfig *exts)
+{
+    qemu_printf("%s:\n", title);
+    qemu_printf("  %-20s  %-8s\n", "Name", "Status");
+    qemu_printf("  %-20s  %-8s\n", "----", "------");
+
+    riscv_cpu_dump_multiext_entries(cpu, exts);
+    qemu_printf("\n");
+}
+
+/*
+ * Check if an extension offset corresponds to a privilege-implied extension.
+ * These are extensions that map to has_priv_1_11, has_priv_1_12, or
+ * has_priv_1_13 instead of individual ext_* fields.
+ */
+static bool riscv_ext_is_priv_implied(uint32_t offset)
+{
+    return offset == CPU_CFG_OFFSET(has_priv_1_11) ||
+           offset == CPU_CFG_OFFSET(has_priv_1_12) ||
+           offset == CPU_CFG_OFFSET(has_priv_1_13);
+}
+
+/*
+ * Helper function to print privilege-implied extensions for arch=dump.
+ * These are extensions that are automatically enabled based on the
+ * privilege specification version.
+ */
+static void riscv_cpu_dump_priv_implied_exts(RISCVCPU *cpu)
+{
+    qemu_printf("Privilege Implied Extensions:\n");
+    qemu_printf("  %-20s  %-8s\n", "Name", "Status");
+    qemu_printf("  %-20s  %-8s\n", "----", "------");
+
+    for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
+        if (riscv_ext_is_priv_implied(edata->ext_enable_offset)) {
+            bool enabled = isa_ext_is_enabled(cpu, edata->ext_enable_offset);
+            qemu_printf("  %-20s  %-8s\n",
+                        edata->name,
+                        riscv_ext_status_str(enabled));
+        }
+    }
+    qemu_printf("\n");
+}
+
+/*
+ * Print detailed ISA configuration and exit.
+ * Called when arch=dump is specified.
+ */
+static G_NORETURN void riscv_cpu_dump_isa_config(RISCVCPU *cpu)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    CPURISCVState *env = &cpu->env;
+    g_autofree char *isa_str = riscv_isa_string(cpu);
+    int xlen = riscv_cpu_max_xlen(mcc);
+
+    qemu_printf("\n");
+    qemu_printf("RISC-V ISA Configuration (arch=dump)\n");
+    qemu_printf("=====================================\n\n");
+
+    /* Print full ISA string */
+    qemu_printf("Full ISA string: %s\n\n", isa_str);
+
+    /* Print base information */
+    qemu_printf("Base: RV%d\n", xlen);
+    qemu_printf("Privilege spec: %s\n\n", priv_spec_to_str(env->priv_ver));
+
+    /* Print single-letter extensions */
+    qemu_printf("Standard Extensions (single-letter):\n");
+    qemu_printf("  %-20s  %-8s\n", "Name", "Status");
+    qemu_printf("  %-20s  %-8s\n", "----", "------");
+
+    for (int i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+        const char *name = riscv_get_misa_ext_name(bit);
+        bool enabled = env->misa_ext & bit;
+
+        qemu_printf("  %-20s  %-8s\n",
+                    name,
+                    riscv_ext_status_str(enabled));
+    }
+    qemu_printf("\n");
+
+    /* Print multi-letter standard extensions (including named features) */
+    qemu_printf("Standard Extensions (multi-letter):\n");
+    qemu_printf("  %-20s  %-8s\n", "Name", "Status");
+    qemu_printf("  %-20s  %-8s\n", "----", "------");
+    riscv_cpu_dump_multiext_entries(cpu, riscv_cpu_extensions);
+    riscv_cpu_dump_multiext_entries(cpu, riscv_cpu_named_features);
+    qemu_printf("\n");
+
+    riscv_cpu_dump_multiext(cpu, "Vendor Extensions", riscv_cpu_vendor_exts);
+    riscv_cpu_dump_multiext(cpu, "Experimental Extensions",
+                            riscv_cpu_experimental_exts);
+    riscv_cpu_dump_priv_implied_exts(cpu);
+
+    exit(0);
+}
+
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
@@ -943,6 +1066,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Check for arch=dump request after all features are finalized */
+    if (cpu->cfg.arch_dump_requested) {
+        riscv_cpu_dump_isa_config(cpu);
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index a154ecdc792..87ef228a17d 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -155,6 +155,9 @@ BOOL_FIELD(misa_w)
 
 BOOL_FIELD(short_isa_string)
 
+/* arch= property flags */
+BOOL_FIELD(arch_dump_requested)
+
 TYPED_FIELD(uint32_t, mvendorid, 0)
 TYPED_FIELD(uint64_t, marchid, 0)
 TYPED_FIELD(uint64_t, mimpid, 0)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index bb03f8dc0ca..f7187472cd2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1551,6 +1551,37 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
     }
 }
 
+/*
+ * arch= property handler for ISA string configuration.
+ * This is a write-only property used to trigger actions like arch=dump.
+ */
+static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    g_autofree char *value = NULL;
+
+    if (!visit_type_str(v, name, &value, errp)) {
+        return;
+    }
+
+    if (g_strcmp0(value, "dump") == 0) {
+        cpu->cfg.arch_dump_requested = true;
+    } else {
+        error_setg(errp, "unknown arch option '%s'. "
+                   "Supported options: dump", value);
+    }
+}
+
+static void riscv_cpu_add_arch_property(Object *obj)
+{
+    object_property_add(obj, "arch", "str",
+                        NULL, cpu_set_arch,
+                        NULL, NULL);
+    object_property_set_description(obj, "arch",
+        "ISA configuration string (write-only). Use 'dump' to print ISA config.");
+}
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1570,6 +1601,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
     riscv_cpu_add_profiles(obj);
+
+    riscv_cpu_add_arch_property(obj);
 }
 
 /*
diff --git a/tests/functional/riscv32/meson.build b/tests/functional/riscv32/meson.build
index f3ebbb8db5d..a3f7a3dffce 100644
--- a/tests/functional/riscv32/meson.build
+++ b/tests/functional/riscv32/meson.build
@@ -8,3 +8,7 @@ tests_riscv32_system_quick = [
 tests_riscv32_system_thorough = [
   'tuxrun',
 ]
+
+tests_riscv32_linuxuser_quick = [
+  'cpu_arch',
+]
diff --git a/tests/functional/riscv32/test_cpu_arch.py b/tests/functional/riscv32/test_cpu_arch.py
new file mode 100644
index 00000000000..7b2f87cad88
--- /dev/null
+++ b/tests/functional/riscv32/test_cpu_arch.py
@@ -0,0 +1,61 @@
+#!/usr/bin/env python3
+#
+# Test RISC-V CPU arch= property
+#
+# Copyright (c) 2026 SiFive, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from subprocess import run
+
+from qemu_test import QemuUserTest
+
+
+class RiscvCpuArch(QemuUserTest):
+    """Test RISC-V CPU arch= property"""
+
+    def run_qemu(self, cpu_opt, bin_path='/bin/true'):
+        """Run qemu-riscv32 with specified CPU option"""
+        cmd = [self.qemu_bin, '-cpu', cpu_opt, bin_path]
+        return run(cmd, text=True, capture_output=True)
+
+    def test_arch_dump(self):
+        """Test arch=dump prints ISA configuration and exits"""
+        res = self.run_qemu('rv32,arch=dump')
+
+        self.assertEqual(res.returncode, 0,
+                         f"arch=dump should exit with 0, got {res.returncode}")
+
+        # Check for expected output sections
+        self.assertIn('RISC-V ISA Configuration', res.stdout)
+        self.assertIn('Full ISA string:', res.stdout)
+        self.assertIn('Standard Extensions (single-letter):', res.stdout)
+        self.assertIn('Standard Extensions (multi-letter):', res.stdout)
+        self.assertIn('Vendor Extensions:', res.stdout)
+        # Check it's RV32
+        self.assertIn('Base: RV32', res.stdout)
+
+    def test_arch_dump_shows_enabled_extensions(self):
+        """Test arch=dump correctly shows enabled extensions"""
+        res = self.run_qemu('rv32,arch=dump')
+
+        # Default rv32 should have these enabled
+        self.assertRegex(res.stdout, r'i\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'd\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
+    def test_arch_invalid_option(self):
+        """Test invalid arch= option shows error with supported options"""
+        res = self.run_qemu('rv32,arch=invalid')
+
+        self.assertNotEqual(res.returncode, 0,
+                            "Invalid arch option should fail")
+        self.assertIn("unknown arch option 'invalid'", res.stderr)
+        self.assertIn("Supported options:", res.stderr)
+
+
+if __name__ == '__main__':
+    QemuUserTest.main()
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c1704d92751..82a29dcc974 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -13,3 +13,7 @@ tests_riscv64_system_thorough = [
   'sifive_u',
   'tuxrun',
 ]
+
+tests_riscv64_linuxuser_quick = [
+  'cpu_arch',
+]
diff --git a/tests/functional/riscv64/test_cpu_arch.py b/tests/functional/riscv64/test_cpu_arch.py
new file mode 100644
index 00000000000..b0af8991397
--- /dev/null
+++ b/tests/functional/riscv64/test_cpu_arch.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python3
+#
+# Test RISC-V CPU arch= property
+#
+# Copyright (c) 2026 SiFive, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from subprocess import run
+
+from qemu_test import QemuUserTest
+
+
+class RiscvCpuArch(QemuUserTest):
+    """Test RISC-V CPU arch= property"""
+
+    def run_qemu(self, cpu_opt, bin_path='/bin/true'):
+        """Run qemu-riscv64 with specified CPU option"""
+        cmd = [self.qemu_bin, '-cpu', cpu_opt, bin_path]
+        return run(cmd, text=True, capture_output=True)
+
+    def test_arch_dump(self):
+        """Test arch=dump prints ISA configuration and exits"""
+        res = self.run_qemu('rv64,arch=dump')
+
+        self.assertEqual(res.returncode, 0,
+                         f"arch=dump should exit with 0, got {res.returncode}")
+
+        # Check for expected output sections
+        self.assertIn('RISC-V ISA Configuration', res.stdout)
+        self.assertIn('Full ISA string:', res.stdout)
+        self.assertIn('Standard Extensions (single-letter):', res.stdout)
+        self.assertIn('Standard Extensions (multi-letter):', res.stdout)
+        self.assertIn('Vendor Extensions:', res.stdout)
+
+    def test_arch_dump_shows_enabled_extensions(self):
+        """Test arch=dump correctly shows enabled extensions"""
+        res = self.run_qemu('rv64,arch=dump')
+
+        # Default rv64 should have these enabled
+        self.assertRegex(res.stdout, r'i\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'd\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
+    def test_arch_dump_with_vector(self):
+        """Test arch=dump shows vector extension when enabled"""
+        res = self.run_qemu('rv64,v=true,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'v\s+enabled')
+
+    def test_arch_dump_position_independence(self):
+        """Test arch=dump shows final config regardless of position"""
+        # arch=dump before v=true
+        res1 = self.run_qemu('rv64,arch=dump,v=true')
+        # arch=dump after v=true
+        res2 = self.run_qemu('rv64,v=true,arch=dump')
+
+        self.assertEqual(res1.returncode, 0)
+        self.assertEqual(res2.returncode, 0)
+
+        # Both should show v enabled
+        self.assertRegex(res1.stdout, r'v\s+enabled')
+        self.assertRegex(res2.stdout, r'v\s+enabled')
+
+    def test_arch_invalid_option(self):
+        """Test invalid arch= option shows error with supported options"""
+        res = self.run_qemu('rv64,arch=invalid')
+
+        self.assertNotEqual(res.returncode, 0,
+                            "Invalid arch option should fail")
+        self.assertIn("unknown arch option 'invalid'", res.stderr)
+        self.assertIn("Supported options:", res.stderr)
+
+
+if __name__ == '__main__':
+    QemuUserTest.main()
-- 
2.52.0


