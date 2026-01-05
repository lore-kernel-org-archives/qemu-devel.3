Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39A4C2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJe-0000y4-4p; Mon, 05 Jan 2026 06:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJZ-0000tc-Jr
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:58 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJX-0001nU-Mc
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 05:59:57 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so151052875ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610794; x=1768215594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mvyYXT1r2G4eaZnd++PzL/PkomyAfdOWZbiHRB33pY=;
 b=U+rNTyRtWyPxaGl8hr10+7Ranet/TdxYsGg/7fdUDwFXWkw9aCu/AOYpjAykot8+X1
 4iK02EacXBu4sz0Nsv48bY4yzX0csg58Wd19DwerpYN/QCGoTEJFYw5+f4Z7JgsVsgfM
 Bq/k051JtXVR2WYdg+MOJOVBZOyUz//9wR1rn95FqP6dGuysLxKvLXdROFG7uQLikH5f
 7tf3FPjEy1jW5R8wWn9QuXCWLCsz6i6SHIFtFUnwytHL4XRgGlTNPHLCdZSK+tR2xRSU
 qJ7gGMY0eHYlf/teYHsj06uLA9h39g7vu18OcBAD1OTYjv6hu9R9k68vKfx7wGxQ6PRY
 Ts1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610794; x=1768215594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0mvyYXT1r2G4eaZnd++PzL/PkomyAfdOWZbiHRB33pY=;
 b=SZKh117Uzk6j34tOphRm6SPyKETAJNjkeM0RiLQpT86DnrBrruo7mA8gwM7eKo0AL+
 4U5L0eDaK0Fq/XC+9m/8l0tu7NTM5dL/+mjckEy5uF5eHXxFWTlUPXAfveR6mjeZ7Lwh
 qjX0lp2KsDwR/x1vVBsZjvNtYkpJvJMuVKqONCUqmtoMLmz/b/lW0r5ERlDVVUBPADP5
 cSKI1luytkul1PlZN9lI9n3OEF9/euGehZ654yLx5MKG14AOCwEJ+8mNH6HIRJxyhStU
 zGbApmGDg0VmRYZ8e9/WAYpEKfhPgTdbEApD62Vorj7KWNMFc/a4a0jB2yZVZLDk+lRR
 q68g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuKIeOsQdb3xFpwh65y3BeQVWaiE4KtJ/lg7YJq3h8w4/pFkGIesjZmid/SFyhnQ8tZSsQu33jJ2/N@nongnu.org
X-Gm-Message-State: AOJu0YzSCMRxpRvyiwm+hs+ZL0veNQYMN0AdXAVJUT2cnswnSqrCknlZ
 7E1NXr75VhlbSly62t15OOfOEn+q0MgznUnFfbY3oImgMzatIWHRQCVVfZtfqeLhO40oJurYWso
 Ic5TZ
X-Gm-Gg: AY/fxX5mDH1Cm2Kd/ItLJOXrNDcBr5zmByf+z8NQYjV+4PtA6vZ/kMqopuxcEz41GZx
 ly2b1M6MOCFumqxw5a/VVZGozzgw7B96U2HSlnl1+W6ZuqihinZ4B0W85mW28RQSsi0zlvdw5BY
 xbOga9FTVBsQOQdAtLiqEPAe37L1ivH620HhsddYMzLu3IVf52O9fOesVsDmKuUcxDzcvTLd4K6
 byFmWGUA5h1v1ApwmhgRJyGN0ZKKIflOKk/VknEAntTWSE6wNe0ESZ89k8YR5hP8yb+2r9qqpKi
 2WGpH7oEej4AIFM8gGSt9Sz165On5ZEZgzblgQnPsaY5coxifUgFb4ETPuufwAly0dcU4MEMJJz
 i5jjl3lAtGNRXRcMoFwNqdKFBBaUMLLjYHqDedaSkRzVO8fUawF10Flb0lO12c0OvxJTKtx/qiA
 GG3kXyAuo7KhvPoEj2tnLdpj1hABTYJOXgtp6E
X-Google-Smtp-Source: AGHT+IGirs0DCw14XjY7Q3i42GRevN1P9Txhl4P9zJ0/BtvbUydWMP2/nw2c09lgCayXYufeSGrasw==
X-Received: by 2002:a17:902:e541:b0:29f:1bf:6424 with SMTP id
 d9443c01a7336-2a2f221ff92mr504692105ad.18.1767610794156; 
 Mon, 05 Jan 2026 02:59:54 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 02:59:53 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 2/5] target/riscv: Add arch=help to list supported ISA
 extensions
Date: Mon,  5 Jan 2026 18:59:37 +0800
Message-ID: <20260105105940.3567112-3-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x62a.google.com
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
 docs/system/target-riscv.rst              | 14 ++++-
 target/riscv/cpu.c                        | 69 +++++++++++++++++++++++
 target/riscv/cpu.h                        |  1 +
 target/riscv/tcg/tcg-cpu.c                |  7 ++-
 tests/functional/riscv32/test_cpu_arch.py | 12 ++++
 tests/functional/riscv64/test_cpu_arch.py | 25 ++++++++
 6 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 3ec53dbf9e5..9acc51fbc2b 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -90,8 +90,18 @@ Individual ISA extensions can be enabled or disabled using boolean properties::
 The ``arch`` property
 ^^^^^^^^^^^^^^^^^^^^^
 
-The ``arch`` property provides a convenient way to inspect the current ISA
-configuration:
+The ``arch`` property provides convenient ways to discover and inspect ISA
+extensions:
+
+* ``arch=help``
+
+  Print a list of all supported ISA extensions and exit::
+
+    $ qemu-system-riscv64 -M virt -cpu rv64,arch=help
+    $ qemu-riscv64 -cpu rv64,arch=help /bin/true
+
+  This lists standard single-letter extensions (with descriptions), multi-letter
+  extensions, vendor extensions, and experimental extensions.
 
 * ``arch=dump``
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2886b7ebcdd..b1d8438cd14 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -896,6 +896,23 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 }
 #endif
 
+/*
+ * Helper function to print single-letter extensions for arch=help.
+ */
+static void riscv_cpu_help_misa_exts(void)
+{
+    qemu_printf("Standard Extensions (single-letter):\n");
+
+    for (int i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+        const char *name = riscv_get_misa_ext_name(bit);
+        const char *desc = riscv_get_misa_ext_description(bit);
+
+        qemu_printf("  %-4s  %s\n", name, desc);
+    }
+    qemu_printf("\n");
+}
+
 static inline const char *riscv_ext_status_str(bool enabled)
 {
     return enabled ? "enabled" : "disabled";
@@ -965,6 +982,58 @@ static void riscv_cpu_dump_priv_implied_exts(RISCVCPU *cpu)
     qemu_printf("\n");
 }
 
+/*
+ * Helper function to print multi-letter extension names for arch=help.
+ * Does not print section header.
+ */
+static void riscv_cpu_help_multiext_entries(const RISCVCPUMultiExtConfig *exts)
+{
+    for (const RISCVCPUMultiExtConfig *prop = exts;
+         prop && prop->name; prop++) {
+        qemu_printf("  %s\n", prop->name);
+    }
+}
+
+/*
+ * Helper function to print multi-letter extensions for arch=help.
+ */
+static void riscv_cpu_help_multiext(const char *title,
+                                    const RISCVCPUMultiExtConfig *exts)
+{
+    qemu_printf("%s:\n", title);
+
+    riscv_cpu_help_multiext_entries(exts);
+    qemu_printf("\n");
+}
+
+/*
+ * Print list of supported ISA extensions and exit.
+ * Called when arch=help is specified.
+ */
+G_NORETURN void riscv_cpu_list_supported_extensions(void)
+{
+    qemu_printf("\n");
+    qemu_printf("Supported RISC-V ISA Extensions\n");
+    qemu_printf("================================\n\n");
+
+    riscv_cpu_help_misa_exts();
+
+    /* Print multi-letter standard extensions (including named features) */
+    qemu_printf("Standard Extensions (multi-letter):\n");
+    riscv_cpu_help_multiext_entries(riscv_cpu_extensions);
+    riscv_cpu_help_multiext_entries(riscv_cpu_named_features);
+    qemu_printf("\n");
+
+    riscv_cpu_help_multiext("Vendor Extensions", riscv_cpu_vendor_exts);
+    riscv_cpu_help_multiext("Experimental Extensions",
+                            riscv_cpu_experimental_exts);
+
+    qemu_printf("Use '-cpu <cpu>,<ext>=true' to enable an extension.\n");
+    qemu_printf("Use '-cpu <cpu>,arch=dump' to show current configuration.\n");
+
+    exit(0);
+}
+
 /*
  * Print detailed ISA configuration and exit.
  * Called when arch=dump is specified.
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 90b3e951053..5c08c2ca4d6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -986,4 +986,5 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
+G_NORETURN void riscv_cpu_list_supported_extensions(void);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f7187472cd2..c9600a52e1c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1567,9 +1567,11 @@ static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
 
     if (g_strcmp0(value, "dump") == 0) {
         cpu->cfg.arch_dump_requested = true;
+    } else if (g_strcmp0(value, "help") == 0) {
+        riscv_cpu_list_supported_extensions();
     } else {
         error_setg(errp, "unknown arch option '%s'. "
-                   "Supported options: dump", value);
+                   "Supported options: dump, help", value);
     }
 }
 
@@ -1579,7 +1581,8 @@ static void riscv_cpu_add_arch_property(Object *obj)
                         NULL, cpu_set_arch,
                         NULL, NULL);
     object_property_set_description(obj, "arch",
-        "ISA configuration string (write-only). Use 'dump' to print ISA config.");
+        "ISA configuration (write-only). "
+        "Use 'help' to list extensions, 'dump' to show current config.");
 }
 
 /*
diff --git a/tests/functional/riscv32/test_cpu_arch.py b/tests/functional/riscv32/test_cpu_arch.py
index 7b2f87cad88..b2042f1e5d8 100644
--- a/tests/functional/riscv32/test_cpu_arch.py
+++ b/tests/functional/riscv32/test_cpu_arch.py
@@ -47,6 +47,18 @@ def test_arch_dump_shows_enabled_extensions(self):
         self.assertRegex(res.stdout, r'd\s+enabled')
         self.assertRegex(res.stdout, r'c\s+enabled')
 
+    def test_arch_help(self):
+        """Test arch=help prints list of supported extensions and exits"""
+        res = self.run_qemu('rv32,arch=help')
+
+        self.assertEqual(res.returncode, 0,
+                         f"arch=help should exit with 0, got {res.returncode}")
+
+        # Check for expected output sections
+        self.assertIn('Supported RISC-V ISA Extensions', res.stdout)
+        self.assertIn('Standard Extensions (single-letter):', res.stdout)
+        self.assertIn('Standard Extensions (multi-letter):', res.stdout)
+
     def test_arch_invalid_option(self):
         """Test invalid arch= option shows error with supported options"""
         res = self.run_qemu('rv32,arch=invalid')
diff --git a/tests/functional/riscv64/test_cpu_arch.py b/tests/functional/riscv64/test_cpu_arch.py
index b0af8991397..4ec807b7276 100644
--- a/tests/functional/riscv64/test_cpu_arch.py
+++ b/tests/functional/riscv64/test_cpu_arch.py
@@ -66,6 +66,31 @@ def test_arch_dump_position_independence(self):
         self.assertRegex(res1.stdout, r'v\s+enabled')
         self.assertRegex(res2.stdout, r'v\s+enabled')
 
+    def test_arch_help(self):
+        """Test arch=help prints list of supported extensions and exits"""
+        res = self.run_qemu('rv64,arch=help')
+
+        self.assertEqual(res.returncode, 0,
+                         f"arch=help should exit with 0, got {res.returncode}")
+
+        # Check for expected output sections
+        self.assertIn('Supported RISC-V ISA Extensions', res.stdout)
+        self.assertIn('Standard Extensions (single-letter):', res.stdout)
+        self.assertIn('Standard Extensions (multi-letter):', res.stdout)
+        self.assertIn('Vendor Extensions:', res.stdout)
+
+    def test_arch_help_shows_extensions(self):
+        """Test arch=help lists common extensions"""
+        res = self.run_qemu('rv64,arch=help')
+
+        # Check single-letter extensions with descriptions
+        self.assertIn('Base integer instruction set', res.stdout)
+        self.assertIn('Vector operations', res.stdout)
+
+        # Check multi-letter extensions are listed
+        self.assertIn('zba', res.stdout)
+        self.assertIn('zbb', res.stdout)
+
     def test_arch_invalid_option(self):
         """Test invalid arch= option shows error with supported options"""
         res = self.run_qemu('rv64,arch=invalid')
-- 
2.52.0


