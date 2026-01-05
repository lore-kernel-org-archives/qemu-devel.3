Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28179C2A099
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJk-000114-3x; Mon, 05 Jan 2026 06:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJc-0000wc-SC
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:01 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJa-0001o8-8c
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:00 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so123643495ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610796; x=1768215596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVt84wL5z8nWmHQsPvVEJWwZQBhNHUCqqOx+s1/1LQ8=;
 b=Yf7CP83Ldv8guY63khSCxDIqF0mr9q86bspLgShgaSzVpvDdFduZEPfhwW74uZcgzB
 5N6S9RwIRJeK4YRm7pobUyZY7U3BtH9G8eN1No9Fys2YCh67HCtF+O9QZ+doJfrtuiUu
 +Akgoml4tfKHCwL0E+rfhiQ5RM+RnbltnILKzOEkOnrVuv+zpy77tAzko8WGjCy8d9G7
 NXJ3pfntt1EVdxbeIstk5hZbYlZgO3rn5cwQipTk2f5LM2/soBVZ3BkwqCKwzjyUIzrQ
 qGEE+MQ43Zx+lhhPURaOQ8aG+6LD7KgagXvvxYqUP1YRtFE3CF1gywVf9FFwXKSsXzzt
 KlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610796; x=1768215596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVt84wL5z8nWmHQsPvVEJWwZQBhNHUCqqOx+s1/1LQ8=;
 b=KgCSB71Eds7tSCPb57V5K3YNrwklh62hpkLOLYMOCfdtU2wf3tOTFhqUJUWcr1uMo7
 JV9cgVFj26Mf3sSjlwSR0JbVWsqSm4amDjizZw7Vjqo1zW+2ir7HNgcbbclmb1LXXjS7
 VtkrCBkSl4fSST6SgpLdfsFRdANy7mTSe//D+r449VXkNT1Q5rAsuV4n9y+pmV2VEkiB
 EzhGcFAeVEeggqp9cAR1IYFOUnH5BcgitpktpGfBV3jFyqOp+M3Na8w2el2N1phIT3qJ
 tRPU0tM7DXTszWASTWCgORSWN9hnhvq/b70x+UeQJ7hhcfV4KiAmGZr6L4ZM6jPPTnK+
 ZEEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAyb37UL0rM1vczi6c/PP4M7w3kVVL8JLvZUl6uhBN5SBq+bAicVO9AKtkU01Vk6BHcGodE2v21zYX@nongnu.org
X-Gm-Message-State: AOJu0Yx+DoiKBmvt96hk/6ymytIZUPi4PZ2kmSH1mNvl+kSp4bSAeWb+
 mpZWzxdL07WXNM0ck17xZ8GYWkTm3mGv3mITR8bz2/dQULEEY5xgcxkPP8tzYSP8PNo=
X-Gm-Gg: AY/fxX5kUI+y1VbHS7646yNN1ETBf5gJ8DSRTZtpjfrDGKmFVahKyG3xNx2gsn6KyMF
 KqJkmbFooqkYwovV/PqWTA63/ZfAmktGIE5IGE4IDzqh8zj61GsbLZsz1tJ9F2aWjlXsbHZArC0
 0ix6wJ4g+xD+Y2hgkPXwc+BohiHHZsmazs+R3zBo7YI2BAdvK3wp4s/y7w1q7NYY+8DoQdHolrJ
 qPXFbsnsNL42ohlQbOkZd3xCSSawuBv7eT31znKMfMXoI7Z2v87SpqNut4hhTcvkGUuQlN0tTV8
 w/rEvdU2MNW0jzVf0GUqE12ZVFbNezfgq6lqMiihk3HDcVGFRB4XC4KZqMRsL8vWPSdDYXESMtI
 mBIE7eBJB/4M66wAQLv9V9BscXyza1O8ujGJCCZNY7hHJLMjrsk4cjkEWX4sVOvEAqYCGL+1zgt
 rWQUkFGKYbKeHCzR/zPndAZF0+lVOGVpjlVwZG
X-Google-Smtp-Source: AGHT+IHP/CHaRo7H+0csiHOeg8Q6+thQPPb3KS9NvrIyn+Ljb/gif9eBSdfHsMGbjBJo8TJnYf1ScQ==
X-Received: by 2002:a17:903:2342:b0:2a0:e5cd:80a1 with SMTP id
 d9443c01a7336-2a2f2a34fa1mr477949365ad.41.1767610796360; 
 Mon, 05 Jan 2026 02:59:56 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 02:59:55 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 3/5] target/riscv: Add arch=ISA-STRING to configure extensions
 via ISA string
Date: Mon,  5 Jan 2026 18:59:38 +0800
Message-ID: <20260105105940.3567112-4-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x631.google.com
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

Add support for configuring RISC-V ISA extensions using standard ISA
strings with the arch= property. The format is:

  rv{32|64}[single-letter-exts][_multi-letter-ext]*

Examples:
  -cpu rv64,arch=rv64gc_zba_zbb
  -cpu rv64,arch=rv64imafdc_zba_zbb_zbc
  -cpu rv32,arch=rv32gc

Key features:
- First extension after rv{32|64} must be 'i', 'e', or 'g' (base ISA)
- Single-letter extensions can be concatenated (rv64imafdc)
- Single-letter extensions can also use underscore separators
  (rv64i_m_a_f_d_c)
- Multi-letter extensions are separated by underscores (_zba_zbb)
- Single-letter extensions can transition directly to multi-letter
  (rv64imazba is equivalent to rv64ima_zba)
- Extensions i, e, g can only appear as the first extension
- When arch= is specified, all extensions are first reset to disabled,
  then only the specified extensions are enabled
- G expands to imafd_zicsr_zifencei
- B expands to zba_zbb_zbs
- ISA string XLEN must match CPU type (rv32 for 32-bit, rv64 for 64-bit)

Individual extension properties (e.g., zba=true) can be combined with
arch= and will override the ISA string settings when specified after
arch=.

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
---
 docs/system/target-riscv.rst              |  48 ++++++
 target/riscv/tcg/tcg-cpu.c                | 187 +++++++++++++++++++++-
 tests/functional/riscv32/test_cpu_arch.py |  21 +++
 tests/functional/riscv64/test_cpu_arch.py | 166 +++++++++++++++++++
 4 files changed, 418 insertions(+), 4 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 9acc51fbc2b..a16c17a22c2 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -119,6 +119,54 @@ extensions:
     $ qemu-riscv64 -cpu rv64,v=true,arch=dump /bin/true
     $ qemu-riscv64 -cpu rv64,arch=dump,v=true /bin/true
 
+* ``arch=<ISA-STRING>``
+
+  Configure extensions using a standard RISC-V ISA string. The format is
+  ``rv{32|64}[single-letter-exts][_multi-letter-ext]*``. Examples::
+
+    $ qemu-riscv64 -cpu rv64,arch=rv64gc_zba_zbb /bin/true
+    $ qemu-riscv64 -cpu rv64,arch=rv64imafdc_zba_zbb_zbc /bin/true
+
+  Single-letter extensions are specified immediately after the base ISA
+  (e.g., ``rv64gc`` enables G and C extensions). Multi-letter extensions
+  are separated by underscores.
+
+  Special extensions:
+
+  - ``g`` expands to ``imafd_zicsr_zifencei`` (General purpose)
+
+  The ISA string must match the CPU's XLEN. For example, ``arch=rv32i`` will
+  fail on a 64-bit CPU.
+
+  **Important behavioral notes:**
+
+  - When ``arch=<ISA-STRING>`` is specified, all extensions are first reset
+    to disabled, then only the extensions in the ISA string are enabled.
+    For example, ``-cpu rv64,zba=true,arch=rv64gc`` will have ``zba`` disabled
+    because ``arch=`` resets extensions before applying the ISA string.
+
+  - Extensions can be specified in any order and can be repeated. For example,
+    ``rv64gc_zba_zbb`` and ``rv64gc_zbb_zba`` produce the same result.
+
+  - Single-letter extensions can appear anywhere in the string separated by
+    underscores. For example, ``rv64im_zba_afc`` is equivalent to
+    ``rv64imafc_zba``.
+
+  - The individual extension properties (e.g., ``zba=true``) still work and
+    can be combined with ``arch=``. Properties specified after ``arch=`` will
+    override the ISA string settings::
+
+      $ qemu-riscv64 -cpu rv64,arch=rv64gc,zba=true /bin/true
+
+  - Some extensions are controlled by the privilege specification version
+    and cannot be enabled or disabled via ``arch=``. See the
+    "Privilege-implied extensions" section below for details.
+
+  You can combine ``arch=<ISA-STRING>`` with ``arch=dump`` to verify the
+  configuration::
+
+    $ qemu-riscv64 -cpu rv64,arch=rv64gc_zba_zbb,arch=dump /bin/true
+
 Privilege-implied extensions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c9600a52e1c..87f1a5c9c73 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1552,8 +1552,182 @@ static void riscv_cpu_add_multiext_prop_array(Object *obj,
 }
 
 /*
- * arch= property handler for ISA string configuration.
- * This is a write-only property used to trigger actions like arch=dump.
+ * Get MISA bit from single-letter extension name.
+ * Returns 0 if not found.
+ */
+static uint32_t riscv_get_misa_bit_from_name(char ext_char)
+{
+    for (int i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+        const char *name = riscv_get_misa_ext_name(bit);
+
+        if (name && name[0] == ext_char && name[1] == '\0') {
+            return bit;
+        }
+    }
+    return 0;
+}
+
+/*
+ * Find multi-letter extension data by name.
+ * Returns NULL if not found.
+ */
+static const RISCVIsaExtData *riscv_find_ext_data(const char *name)
+{
+    for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
+        if (g_ascii_strcasecmp(edata->name, name) == 0) {
+            return edata;
+        }
+    }
+    return NULL;
+}
+
+/*
+ * Disable all ISA extensions to prepare for ISA string configuration.
+ */
+static void riscv_cpu_disable_all_extensions(RISCVCPU *cpu)
+{
+    /* Disable all MISA extensions */
+    for (int i = 0; misa_bits[i] != 0; i++) {
+        riscv_cpu_write_misa_bit(cpu, misa_bits[i], false);
+    }
+
+    /* Disable all multi-letter extensions */
+    for (const RISCVIsaExtData *edata = isa_edata_arr; edata->name; edata++) {
+        isa_ext_update_enabled(cpu, edata->ext_enable_offset, false);
+    }
+}
+
+/*
+ * Parse ISA string and configure CPU extensions.
+ * Format: rv{32|64}[single-letter-exts][_multi-letter-ext]*
+ * Examples: rv64gc, rv64imafdc_zba_zbb, rv32i
+ *
+ * This first disables all extensions, then enables only those specified
+ * in the ISA string.
+ */
+static bool riscv_cpu_parse_isa_string(RISCVCPU *cpu, const char *isa_str,
+                                       Error **errp)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
+    int xlen = riscv_cpu_max_xlen(mcc);
+    const char *p = isa_str;
+    int expected_xlen;
+
+    /* Parse rv32/rv64 prefix */
+    if (g_ascii_strncasecmp(p, "rv32", 4) == 0) {
+        expected_xlen = 32;
+        p += 4;
+    } else if (g_ascii_strncasecmp(p, "rv64", 4) == 0) {
+        expected_xlen = 64;
+        p += 4;
+    } else {
+        error_setg(errp, "ISA string must start with rv32 or rv64");
+        return false;
+    }
+
+    /* Verify XLEN matches the CPU type */
+    if (expected_xlen != xlen) {
+        error_setg(errp, "ISA string specifies RV%d but CPU is RV%d",
+                   expected_xlen, xlen);
+        return false;
+    }
+
+    /* First extension must be i, e, or g */
+    char first_ext = g_ascii_tolower(*p);
+    if (first_ext != 'i' && first_ext != 'e' && first_ext != 'g') {
+        error_setg(errp, "first extension after rv%d must be 'i', 'e', or 'g'",
+                   expected_xlen);
+        return false;
+    }
+
+    /* Disable all extensions first, then enable only those in ISA string */
+    riscv_cpu_disable_all_extensions(cpu);
+
+    /*
+     * Parse extensions. Both single-letter and multi-letter extensions
+     * can be separated by underscores (e.g., rv64i_m_a_f_d_c_zba_zbb).
+     * Single-letter extensions can also be concatenated (e.g., rv64imafdc).
+     */
+    bool is_first_ext = true;
+    while (*p) {
+        if (*p == '_') {
+            p++;  /* Skip underscore */
+            if (*p == '\0') {
+                break;  /* Trailing underscore is ok */
+            }
+        }
+
+        /* Find the end of this extension name */
+        const char *ext_start = p;
+        while (*p && *p != '_') {
+            p++;
+        }
+
+        /* Extract extension name */
+        size_t ext_len = p - ext_start;
+        g_autofree char *ext_name = g_strndup(ext_start, ext_len);
+
+        /*
+         * Parse single-letter extensions at the beginning of the group.
+         * Single-letter extensions can be followed directly by a multi-letter
+         * extension without underscore (e.g., "imazba" = "ima" + "zba").
+         */
+        size_t single_count = 0;
+        for (size_t i = 0; i < ext_len; i++) {
+            char c = g_ascii_tolower(ext_name[i]);
+            if (riscv_get_misa_bit_from_name(c) == 0) {
+                break;
+            }
+            single_count++;
+        }
+
+        /* Process single-letter extensions */
+        for (size_t i = 0; i < single_count; i++) {
+            char ext_char = g_ascii_tolower(ext_name[i]);
+
+            /*
+             * 'i', 'e', 'g' can only appear as the first extension.
+             * They define the base ISA and cannot be specified elsewhere.
+             */
+            if (ext_char == 'i' || ext_char == 'e' || ext_char == 'g') {
+                if (!is_first_ext) {
+                    error_setg(errp, "'%c' must be the first extension in ISA "
+                               "string", ext_char);
+                    return false;
+                }
+            }
+
+            uint32_t bit = riscv_get_misa_bit_from_name(ext_char);
+            riscv_cpu_write_misa_bit(cpu, bit, true);
+            is_first_ext = false;
+        }
+
+        /* If entire group was single-letter extensions, we're done */
+        if (single_count == ext_len) {
+            continue;
+        }
+
+        /* Process the remaining multi-letter extension */
+        const char *multi_ext = ext_name + single_count;
+
+        /* Look up the extension */
+        const RISCVIsaExtData *edata = riscv_find_ext_data(multi_ext);
+        if (edata == NULL) {
+            error_setg(errp, "unknown extension '%s' in ISA string", multi_ext);
+            return false;
+        }
+
+        /* Enable the extension */
+        isa_ext_update_enabled(cpu, edata->ext_enable_offset, true);
+    }
+
+    return true;
+}
+
+/*
+ * arch= property handler for ISA configuration.
+ * Supports: dump, help, or an ISA string like rv64gc_zba_zbb.
  */
 static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
@@ -1569,9 +1743,13 @@ static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
         cpu->cfg.arch_dump_requested = true;
     } else if (g_strcmp0(value, "help") == 0) {
         riscv_cpu_list_supported_extensions();
+    } else if (g_ascii_strncasecmp(value, "rv", 2) == 0) {
+        /* Parse as ISA string */
+        riscv_cpu_parse_isa_string(cpu, value, errp);
     } else {
         error_setg(errp, "unknown arch option '%s'. "
-                   "Supported options: dump, help", value);
+                   "Supported options: dump, help, or ISA string (e.g., "
+                   "rv64gc_zba_zbb)", value);
     }
 }
 
@@ -1582,7 +1760,8 @@ static void riscv_cpu_add_arch_property(Object *obj)
                         NULL, NULL);
     object_property_set_description(obj, "arch",
         "ISA configuration (write-only). "
-        "Use 'help' to list extensions, 'dump' to show current config.");
+        "Use 'help' to list extensions, 'dump' to show current config, "
+        "or provide an ISA string (e.g., rv64gc_zba_zbb).");
 }
 
 /*
diff --git a/tests/functional/riscv32/test_cpu_arch.py b/tests/functional/riscv32/test_cpu_arch.py
index b2042f1e5d8..f5526cd1e1b 100644
--- a/tests/functional/riscv32/test_cpu_arch.py
+++ b/tests/functional/riscv32/test_cpu_arch.py
@@ -68,6 +68,27 @@ def test_arch_invalid_option(self):
         self.assertIn("unknown arch option 'invalid'", res.stderr)
         self.assertIn("Supported options:", res.stderr)
 
+    def test_arch_isa_string_basic(self):
+        """Test arch=ISA-STRING enables specified extensions"""
+        res = self.run_qemu('rv32,arch=rv32gc_zba_zbb,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # Check single-letter extensions from 'gc'
+        self.assertRegex(res.stdout, r'g\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
+        # Check multi-letter extensions
+        self.assertRegex(res.stdout, r'zba\s+enabled')
+        self.assertRegex(res.stdout, r'zbb\s+enabled')
+
+    def test_arch_isa_string_xlen_mismatch(self):
+        """Test arch=ISA-STRING rejects XLEN mismatch"""
+        res = self.run_qemu('rv32,arch=rv64i')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("RV64 but CPU is RV32", res.stderr)
+
 
 if __name__ == '__main__':
     QemuUserTest.main()
diff --git a/tests/functional/riscv64/test_cpu_arch.py b/tests/functional/riscv64/test_cpu_arch.py
index 4ec807b7276..204247cdb73 100644
--- a/tests/functional/riscv64/test_cpu_arch.py
+++ b/tests/functional/riscv64/test_cpu_arch.py
@@ -100,6 +100,172 @@ def test_arch_invalid_option(self):
         self.assertIn("unknown arch option 'invalid'", res.stderr)
         self.assertIn("Supported options:", res.stderr)
 
+    def test_arch_isa_string_basic(self):
+        """Test arch=ISA-STRING enables specified extensions"""
+        res = self.run_qemu('rv64,arch=rv64gc_zba_zbb,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # Check single-letter extensions from 'gc' (g = imafd_zicsr_zifencei)
+        self.assertRegex(res.stdout, r'g\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
+        # Check multi-letter extensions
+        self.assertRegex(res.stdout, r'zba\s+enabled')
+        self.assertRegex(res.stdout, r'zbb\s+enabled')
+
+    def test_arch_isa_string_g_expands(self):
+        """Test arch=rv64g enables IMAFD + Zicsr + Zifencei"""
+        res = self.run_qemu('rv64,arch=rv64g,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # G expands to IMAFD_Zicsr_Zifencei
+        self.assertRegex(res.stdout, r'i\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'd\s+enabled')
+        self.assertRegex(res.stdout, r'zicsr\s+enabled')
+        self.assertRegex(res.stdout, r'zifencei\s+enabled')
+
+    def test_arch_isa_string_b_expands(self):
+        """Test arch=rv64ib enables Zba + Zbb + Zbs"""
+        res = self.run_qemu('rv64,arch=rv64ib,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # B expands to Zba_Zbb_Zbs
+        self.assertRegex(res.stdout, r'b\s+enabled')
+
+    def test_arch_isa_string_flexible_order(self):
+        """Test extensions can be in any order"""
+        # Both should produce equivalent results
+        res1 = self.run_qemu('rv64,arch=rv64gc_zba_zbb,arch=dump')
+        res2 = self.run_qemu('rv64,arch=rv64gc_zbb_zba,arch=dump')
+
+        self.assertEqual(res1.returncode, 0)
+        self.assertEqual(res2.returncode, 0)
+        self.assertRegex(res1.stdout, r'zba\s+enabled')
+        self.assertRegex(res1.stdout, r'zbb\s+enabled')
+        self.assertRegex(res2.stdout, r'zba\s+enabled')
+        self.assertRegex(res2.stdout, r'zbb\s+enabled')
+
+    def test_arch_isa_string_mixed_single_multi(self):
+        """Test single-letter extensions can appear after underscores"""
+        # rv64im_zba_afc should be equivalent to rv64imafc_zba
+        res = self.run_qemu('rv64,arch=rv64im_zba_afc,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'\bi\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+        self.assertRegex(res.stdout, r'zba\s+enabled')
+
+    def test_arch_isa_string_no_underscore_before_multi(self):
+        """Test multi-letter extension can follow single-letter directly"""
+        # rv64imazba should be equivalent to rv64ima_zba
+        res1 = self.run_qemu('rv64,arch=rv64imazba,arch=dump')
+        res2 = self.run_qemu('rv64,arch=rv64ima_zba,arch=dump')
+
+        self.assertEqual(res1.returncode, 0)
+        self.assertEqual(res2.returncode, 0)
+
+        # Both should have ima and zba enabled
+        for res in [res1, res2]:
+            self.assertRegex(res.stdout, r'\bi\s+enabled')
+            self.assertRegex(res.stdout, r'm\s+enabled')
+            self.assertRegex(res.stdout, r'a\s+enabled')
+            self.assertRegex(res.stdout, r'zba\s+enabled')
+
+    def test_arch_isa_string_repeated_extension(self):
+        """Test extensions can be repeated"""
+        res = self.run_qemu('rv64,arch=rv64gc_zba_zba,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'zba\s+enabled')
+
+    def test_arch_isa_string_resets_extensions(self):
+        """Test arch= resets all extensions first"""
+        # zba=true before arch= should be reset
+        res = self.run_qemu('rv64,zba=true,arch=rv64gc,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'zba\s+disabled')
+
+    def test_arch_combined_with_property(self):
+        """Test arch= can be combined with individual properties"""
+        # arch=rv64gc,zba=true should enable zba
+        res = self.run_qemu('rv64,arch=rv64gc,zba=true,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'zba\s+enabled')
+
+    def test_arch_isa_string_xlen_mismatch(self):
+        """Test arch=ISA-STRING rejects XLEN mismatch"""
+        res = self.run_qemu('rv64,arch=rv32i')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("RV32 but CPU is RV64", res.stderr)
+
+    def test_arch_isa_string_unknown_extension(self):
+        """Test arch=ISA-STRING rejects unknown extension"""
+        # Unknown extension after valid single-letters (ix -> i + x)
+        res = self.run_qemu('rv64,arch=rv64ix')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("unknown extension 'x'", res.stderr)
+
+        # Unknown multi-letter extension after underscore
+        res = self.run_qemu('rv64,arch=rv64i_xyzfoo')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("unknown extension 'xyzfoo'", res.stderr)
+
+    def test_arch_isa_string_first_ext_validation(self):
+        """Test arch=ISA-STRING requires first extension to be i, e, or g"""
+        # First extension must be i, e, or g
+        res = self.run_qemu('rv64,arch=rv64m')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("first extension after rv64 must be 'i', 'e', or 'g'",
+                      res.stderr)
+
+    def test_arch_isa_string_base_ext_only_first(self):
+        """Test i, e, g can only appear as the first extension"""
+        # 'e' cannot appear after other extensions
+        res = self.run_qemu('rv64,arch=rv64imae')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("'e' must be the first extension", res.stderr)
+
+        # 'g' cannot appear after 'i'
+        res = self.run_qemu('rv64,arch=rv64ig')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("'g' must be the first extension", res.stderr)
+
+        # 'i' cannot appear after underscore
+        res = self.run_qemu('rv64,arch=rv64g_i')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("'i' must be the first extension", res.stderr)
+
+    def test_arch_isa_string_underscore_separated_single(self):
+        """Test single-letter extensions can be separated by underscores"""
+        # rv64i_m_a_f_d_c should be equivalent to rv64imafdc
+        res = self.run_qemu('rv64,arch=rv64i_m_a_f_d_c,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertRegex(res.stdout, r'\bi\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'd\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
 
 if __name__ == '__main__':
     QemuUserTest.main()
-- 
2.52.0


