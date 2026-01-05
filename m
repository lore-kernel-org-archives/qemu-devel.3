Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E6CC2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJm-000126-EA; Mon, 05 Jan 2026 06:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJg-0000zy-PX
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:06 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJe-0001pJ-4d
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:04 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a110548cdeso186111205ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610800; x=1768215600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgFnjjxok3hH0hllst2R9+ZDtEpVszUSR75AJx8qMMQ=;
 b=lVE8XA8HqH1nPkWGXirPzoEdNA3xWKa/umiBR+n7VL0x+iEQu4a8fNiaAcIpxdHOxp
 y1frWu/9XpaP8UXIbt3V1//ldXQHt9VkOAtltYMJ9GKuD+bkNFXTrjyXSo3JsQWNZRmy
 fADzMZAKs2JtWoLEmPXYXCeh7YeqEvCFexTTYXsTDuMyoPXPPfi86bobmh9f391J7SB9
 PQcjlYCkEDKrnoqtekiwKuirbCcEoFZ9kODiLMxSe3ZkCeL0LvcUsPAMQKplzJ1bOVb/
 mEl5cqGhR9HF+EhF7Pu1Wf3WygeWVQ0aB/PV9javgMihozfyT4Wp0xpg36gEOAxtbepj
 c2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610800; x=1768215600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sgFnjjxok3hH0hllst2R9+ZDtEpVszUSR75AJx8qMMQ=;
 b=Do8rfradJ6mB7GzaHI2eJB3TlwSBWZ3Id7MHa0I5tlGdBAVl1CulMu0oWQE5l9Z0EL
 HDSdRSJRD34tfzOpU9HuN1qpisSUh6a3OuJIRaA0Bh74G9+xL2oX8dq1CtCzqS75g6Va
 ZECNwO31aUANp5RhWAnOQjwZXhNstQyfRikH+lWnVyG8j1DT0bRvBARmEsROFla3cs6M
 fRyqjOqHnnRHct0T0NfcNYbplBF3UyuvHts3YHUjsKC98sVHYj/CO2ORk93dgFHhOYl+
 R+rdrMbeKSYKXzbPz+QwWKtN5MVXkeKLi4EEDPN/P+cUuzllbOEsGDZATY0vhHU66Hz6
 7LZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnM5Yp0+IMm6xEex6EZ2Dv3d0TXjhxf3fXdPA0EGPT6J1VunXFjuQdtfQ3/StZjAuKerVIKf6vvSbw@nongnu.org
X-Gm-Message-State: AOJu0YybprL0eL30aZ6lEDT9rCgYhk6kRL2pGhwghX/7QlSetoc8MNma
 IePbqQNFqEsU75HeO58Sl461IQztqAksPuCJAqd3fPex9VNaF96xk+KB2HgSbNrTP3o=
X-Gm-Gg: AY/fxX7sXBtQtVK3J6QdARN+nJOAnHR63gZYcnLJV6UEV8xU5KezCvOMPQqoB/tR6WF
 vJuf76aMKDWACOeNRhnmWcY0mLc50pcQUqRkghMAwm22WRWsgfMxVLtgKSU3bYfU9RGG15Hx9v+
 rQGKfF+MBD8lm0NHYCpVL4swGGo7t81ZGx9vHPZV33Yg86IGdu1uyZuD8YJ+JmmpBlOxsOtPaN0
 HXxc/8lnuSRZw0YWPOeaKgj9mO6cC2PnJpmh/HWbl3YTqMIVX0ef3OZ4PB9E4vb2kvAkFt/hwuf
 cYSoFJaTq6WOpoyVpD+CIi9qmomw3+/uEkExacg4TIpDJMxJQjtrI2N86t2zibAHH1BqbN1wTvK
 pIVt4MjKVMOHm9cSpfOKVvif5OUXfPkM+d4d4x9ngSZVZZ7LCslJWxu99N2x243ZYToRDCsnfUP
 ciN7oGJS1Zrd9KvmGcOF4fTrrxEeHCWAl8q5TV
X-Google-Smtp-Source: AGHT+IGsQ7LNRPCLuIwd7jmcSpBo5gTc4t4rb6kI4JkaygDS6k6VQwEEw3rj75zwGdTBVWyN/VvqiA==
X-Received: by 2002:a17:902:f54f:b0:29d:584e:6349 with SMTP id
 d9443c01a7336-2a2f2231accmr544763805ad.13.1767610800485; 
 Mon, 05 Jan 2026 03:00:00 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 03:00:00 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 5/5] target/riscv: Add zvl*b extension support in arch=
 property
Date: Mon,  5 Jan 2026 18:59:40 +0800
Message-ID: <20260105105940.3567112-6-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x62e.google.com
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

Add support for specifying vector length (VLEN) using zvl*b extensions
in the arch= property. This allows explicit VLEN configuration when
using ISA strings or profiles.

Examples:
  -cpu rv64,arch=rv64gcv_zvl256b       # V with VLEN=256
  -cpu rv64,arch=rv64i_zve64f_zvl128b  # Zve64f with VLEN=128
  -cpu rv64,arch=rva23u64_zvl512b      # RVA23 profile with VLEN=512

Key features:
- zvl<N>b where N is VLEN in bits (must be power of 2, 32-65536)
- Valid extensions: zvl32b, zvl64b, zvl128b, zvl256b, zvl512b, etc.
- zvl*b requires v or zve* extension to also be specified
- Multiple zvl*b extensions take the maximum value
- Extensions imply minimum VLEN: v implies 128, zve64* implies 64,
  zve32* implies 32

The arch=dump output now shows:
- Vector length configuration (VLEN=N bits)
- zvl<N>b in the full ISA string

The arch=help output now lists available zvl*b extensions with
documentation.

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
---
 docs/system/target-riscv.rst              |   2 +
 target/riscv/cpu.c                        |  23 ++++-
 target/riscv/tcg/tcg-cpu.c                | 116 +++++++++++++++++++++-
 tests/functional/riscv64/test_cpu_arch.py |  68 +++++++++++++
 4 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 12807974a8a..6734c86848a 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -134,6 +134,8 @@ extensions:
   Special extensions:
 
   - ``g`` expands to ``imafd_zicsr_zifencei`` (General purpose)
+  - ``zvl<N>b`` specifies vector length (VLEN) in bits, where N must
+    be a power of 2 (e.g., ``zvl128b``, ``zvl256b``, ``zvl512b``)
 
   The ISA string must match the CPU's XLEN. For example, ``arch=rv32i`` will
   fail on a 64-bit CPU.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 092635b1050..8c3a0c94483 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1028,6 +1028,11 @@ G_NORETURN void riscv_cpu_list_supported_extensions(void)
     riscv_cpu_help_multiext("Experimental Extensions",
                             riscv_cpu_experimental_exts);
 
+    /* Print vector length extensions */
+    qemu_printf("Vector Length Extensions (zvl*b):\n");
+    qemu_printf("  zvl32b, zvl64b, zvl128b, zvl256b, zvl512b, zvl1024b, ...\n");
+    qemu_printf("  (Specifies VLEN in bits, must be power of 2)\n\n");
+
     /* Print available profiles */
     qemu_printf("Profiles (64-bit only):\n");
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
@@ -1062,7 +1067,14 @@ static G_NORETURN void riscv_cpu_dump_isa_config(RISCVCPU *cpu)
 
     /* Print base information */
     qemu_printf("Base: RV%d\n", xlen);
-    qemu_printf("Privilege spec: %s\n\n", priv_spec_to_str(env->priv_ver));
+    qemu_printf("Privilege spec: %s\n", priv_spec_to_str(env->priv_ver));
+
+    /* Print vector length configuration */
+    if (cpu->cfg.vlenb > 0) {
+        uint16_t vlen = cpu->cfg.vlenb << 3;
+        qemu_printf("Vector length: VLEN=%u bits (zvl%ub)\n", vlen, vlen);
+    }
+    qemu_printf("\n");
 
     /* Print single-letter extensions */
     qemu_printf("Standard Extensions (single-letter):\n");
@@ -3053,6 +3065,15 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
         }
     }
 
+    /* Add zvl*b if vector length is configured */
+    if (cpu->cfg.vlenb > 0) {
+        uint16_t vlen = cpu->cfg.vlenb << 3;
+        g_autofree char *zvl_ext = g_strdup_printf("zvl%ub", vlen);
+        new = g_strconcat(old, "_", zvl_ext, NULL);
+        g_free(old);
+        old = new;
+    }
+
     *isa_str = new;
 }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index aa947337cf1..03a748b7dcc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1596,6 +1596,73 @@ static void riscv_cpu_disable_all_extensions(RISCVCPU *cpu)
     for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
         isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
     }
+
+    /* Reset vector length to 0 (will be set by zvl*b or implied by zve/v) */
+    cpu->cfg.vlenb = 0;
+}
+
+/*
+ * Parse zvl*b extension name and return the minimum VLEN in bits.
+ * Returns 0 if the extension name is not a valid zvl*b pattern.
+ * Valid patterns: zvl32b, zvl64b, zvl128b, zvl256b, zvl512b, zvl1024b, etc.
+ */
+static int riscv_parse_zvl_vlen(const char *ext_name)
+{
+    int vlen;
+    char suffix;
+
+    if (g_ascii_strncasecmp(ext_name, "zvl", 3) != 0) {
+        return 0;
+    }
+
+    if (sscanf(ext_name + 3, "%d%c", &vlen, &suffix) != 2) {
+        return 0;
+    }
+
+    if (g_ascii_tolower(suffix) != 'b') {
+        return 0;
+    }
+
+    /* Validate VLEN is a power of 2 and within reasonable range */
+    if (vlen < 32 || vlen > 65536 || (vlen & (vlen - 1)) != 0) {
+        return 0;
+    }
+
+    return vlen;
+}
+
+/*
+ * Get the implied minimum VLEN (in bits) for an extension.
+ * Returns 0 if the extension doesn't imply a minimum VLEN.
+ *
+ * According to RISC-V specification:
+ * - zve32x, zve32f imply zvl32b (VLEN >= 32)
+ * - zve64x, zve64f, zve64d imply zvl64b (VLEN >= 64)
+ * - v implies zvl128b (VLEN >= 128)
+ */
+static int riscv_ext_implied_vlen(const char *ext_name)
+{
+    if (g_ascii_strcasecmp(ext_name, "v") == 0) {
+        return 128;
+    }
+    if (g_ascii_strncasecmp(ext_name, "zve64", 5) == 0) {
+        return 64;
+    }
+    if (g_ascii_strncasecmp(ext_name, "zve32", 5) == 0) {
+        return 32;
+    }
+    return 0;
+}
+
+/*
+ * Update vlenb if the new VLEN is larger than the current one.
+ */
+static void riscv_update_vlen(RISCVCPU *cpu, int vlen)
+{
+    uint16_t current_vlen = cpu->cfg.vlenb << 3;
+    if (vlen > current_vlen) {
+        cpu->cfg.vlenb = vlen >> 3;
+    }
 }
 
 /*
@@ -1700,6 +1767,9 @@ static bool riscv_cpu_parse_isa_string(RISCVCPU *cpu, const char *isa_str,
 
             uint32_t bit = riscv_get_misa_bit_from_name(ext_char);
             riscv_cpu_write_misa_bit(cpu, bit, true);
+            if (ext_char == 'v') {
+                riscv_update_vlen(cpu, 128);
+            }
             is_first_ext = false;
         }
 
@@ -1711,6 +1781,13 @@ static bool riscv_cpu_parse_isa_string(RISCVCPU *cpu, const char *isa_str,
         /* Process the remaining multi-letter extension */
         const char *multi_ext = ext_name + single_count;
 
+        /* Check for zvl*b extension (vector length) */
+        int zvl_vlen = riscv_parse_zvl_vlen(multi_ext);
+        if (zvl_vlen > 0) {
+            riscv_update_vlen(cpu, zvl_vlen);
+            continue;
+        }
+
         /* Look up the extension */
         const RISCVIsaExtData *edata = riscv_find_ext_data(multi_ext);
         if (edata == NULL) {
@@ -1720,6 +1797,29 @@ static bool riscv_cpu_parse_isa_string(RISCVCPU *cpu, const char *isa_str,
 
         /* Enable the extension */
         isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
+
+        /* Check for implied minimum VLEN (zve32*, zve64*) */
+        int implied_vlen = riscv_ext_implied_vlen(multi_ext);
+        if (implied_vlen > 0) {
+            riscv_update_vlen(cpu, implied_vlen);
+        }
+    }
+
+    /*
+     * Validate that zvl*b is only specified with a vector extension.
+     * zvl*b requires v or zve* extension to also be specified.
+     */
+    if (cpu->cfg.vlenb > 0) {
+        CPURISCVState *env = &cpu->env;
+        bool has_vector = (env->misa_ext & RVV) ||
+                          cpu->cfg.ext_zve32x || cpu->cfg.ext_zve32f ||
+                          cpu->cfg.ext_zve64x || cpu->cfg.ext_zve64f ||
+                          cpu->cfg.ext_zve64d;
+        if (!has_vector) {
+            error_setg(errp, "zvl*b requires v or zve* extension to also be "
+                       "specified");
+            return false;
+        }
     }
 
     return true;
@@ -1799,6 +1899,13 @@ static bool riscv_cpu_parse_profile_string(RISCVCPU *cpu, const char *str,
         size_t ext_len = p - ext_start;
         g_autofree char *ext_name = g_strndup(ext_start, ext_len);
 
+        /* Check for zvl*b extension */
+        int zvl_vlen = riscv_parse_zvl_vlen(ext_name);
+        if (zvl_vlen > 0) {
+            riscv_update_vlen(cpu, zvl_vlen);
+            continue;
+        }
+
         /* Look up the extension */
         const RISCVIsaExtData *edata = riscv_find_ext_data(ext_name);
         if (edata == NULL) {
@@ -1809,6 +1916,12 @@ static bool riscv_cpu_parse_profile_string(RISCVCPU *cpu, const char *str,
 
         /* Enable the extension */
         isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
+
+        /* Check for implied minimum VLEN */
+        int implied_vlen = riscv_ext_implied_vlen(ext_name);
+        if (implied_vlen > 0) {
+            riscv_update_vlen(cpu, implied_vlen);
+        }
     }
 
     return true;
@@ -1856,7 +1969,8 @@ static void riscv_cpu_add_arch_property(Object *obj)
         "ISA configuration (write-only). "
         "Use 'help' to list extensions, 'dump' to show current config, "
         "provide an ISA string (e.g., rv64gc_zba_zbb), "
-        "or use a profile (e.g., rva23u64).");
+        "or a profile with optional extensions (e.g., rva23u64, "
+        "rva23u64_zbkb_zkne).");
 }
 
 /*
diff --git a/tests/functional/riscv64/test_cpu_arch.py b/tests/functional/riscv64/test_cpu_arch.py
index c12e1c7fce4..b1f02db9dd2 100644
--- a/tests/functional/riscv64/test_cpu_arch.py
+++ b/tests/functional/riscv64/test_cpu_arch.py
@@ -266,6 +266,13 @@ def test_arch_isa_string_underscore_separated_single(self):
         self.assertRegex(res.stdout, r'd\s+enabled')
         self.assertRegex(res.stdout, r'c\s+enabled')
 
+    def test_arch_isa_string_zvl_requires_vector(self):
+        """Test zvl*b requires v or zve* extension"""
+        res = self.run_qemu('rv64,arch=rv64g_zvl128b')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("zvl*b requires v or zve* extension", res.stderr)
+
     def test_arch_profile_rva23u64(self):
         """Test arch=rva23u64 enables RVA23 profile extensions"""
         res = self.run_qemu('rv64,arch=rva23u64,arch=dump')
@@ -338,6 +345,67 @@ def test_arch_profile_with_unknown_extension(self):
         self.assertNotEqual(res.returncode, 0)
         self.assertIn("unknown extension 'unknown'", res.stderr)
 
+    def test_arch_help_shows_zvl(self):
+        """Test arch=help lists zvl*b extensions"""
+        res = self.run_qemu('rv64,arch=help')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertIn('Vector Length Extensions', res.stdout)
+        self.assertIn('zvl32b', res.stdout)
+        self.assertIn('zvl128b', res.stdout)
+
+    def test_arch_isa_string_zvl(self):
+        """Test arch=ISA-STRING accepts zvl*b extensions"""
+        res = self.run_qemu('rv64,arch=rv64gcv_zvl256b,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertIn('VLEN=256', res.stdout)
+        self.assertIn('zvl256b', res.stdout)
+        # Check zvl*b is included in Full ISA string
+        self.assertRegex(res.stdout, r'Full ISA string:.*_zvl256b')
+
+    def test_arch_dump_shows_vlen(self):
+        """Test arch=dump shows vector length configuration"""
+        res = self.run_qemu('rv64,arch=rv64gcv_zvl512b,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertIn('Vector length:', res.stdout)
+        self.assertIn('VLEN=512', res.stdout)
+
+    def test_arch_isa_string_zvl_takes_max(self):
+        """Test multiple zvl*b extensions take maximum value"""
+        # zvl128b followed by zvl512b - should use 512
+        res1 = self.run_qemu('rv64,arch=rv64gcv_zvl128b_zvl512b,arch=dump')
+        self.assertEqual(res1.returncode, 0)
+        self.assertIn('VLEN=512', res1.stdout)
+
+        # zvl512b followed by zvl128b - should still use 512
+        res2 = self.run_qemu('rv64,arch=rv64gcv_zvl512b_zvl128b,arch=dump')
+        self.assertEqual(res2.returncode, 0)
+        self.assertIn('VLEN=512', res2.stdout)
+
+        # Three zvl extensions - should use maximum (1024)
+        res3 = self.run_qemu('rv64,arch=rv64gcv_zvl256b_zvl1024b_zvl512b,arch=dump')
+        self.assertEqual(res3.returncode, 0)
+        self.assertIn('VLEN=1024', res3.stdout)
+
+    def test_arch_isa_string_implied_vlen(self):
+        """Test extensions imply minimum VLEN correctly"""
+        # zve64f implies zvl64b, so zvl32b should be ignored
+        res1 = self.run_qemu('rv64,arch=rv64i_zve64f_zvl32b,arch=dump')
+        self.assertEqual(res1.returncode, 0)
+        self.assertIn('VLEN=64', res1.stdout)
+
+        # v implies zvl128b, so zvl64b should be ignored
+        res2 = self.run_qemu('rv64,arch=rv64gcv_zvl64b,arch=dump')
+        self.assertEqual(res2.returncode, 0)
+        self.assertIn('VLEN=128', res2.stdout)
+
+        # zve64x alone should have VLEN=64
+        res3 = self.run_qemu('rv64,arch=rv64i_zve64x,arch=dump')
+        self.assertEqual(res3.returncode, 0)
+        self.assertIn('VLEN=64', res3.stdout)
+
 
 if __name__ == '__main__':
     QemuUserTest.main()
-- 
2.52.0


