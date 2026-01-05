Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBBDC2A074
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 11:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vciJn-00012H-2h; Mon, 05 Jan 2026 06:00:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJe-0000yA-8M
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kito.cheng@sifive.com>)
 id 1vciJb-0001og-Mc
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 06:00:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso187801545ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 02:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767610798; x=1768215598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItC8uyuV9MEuPPK+zE/fnv1fLQkursu/U/pJyg29yX0=;
 b=f/1mQs60mavIxsOsOeap9l7PetIlTSCW2EQ1UobsIsZ8WvaX/WZqqshyGzpMCq7i/d
 BEGvISzmjWIvHGHzKUInipnbVCgBi5zFz+9XqV3hOgbZ8puIywL+XvXq94T7y7EQ3yIJ
 aQwX6LZuE6DLHY6btcwtruSXUc1t+FlMZN0/a4hyL/o2Ljvppv2tSKwXEa188q62gQXS
 /Agt7FqXXI0Ib6qUv+4fa8qApqiRCrP8vPI/EBsHcPHR5iMhlGjKwsWyegZhUTKV3Q0E
 S6RyFu2nVrTHauHSXR7uqQk3Vr1n6B3YcsYjmq+Sa7vh0HLYvb0BwH1Mh2AK0Ijz17p7
 x+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767610798; x=1768215598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ItC8uyuV9MEuPPK+zE/fnv1fLQkursu/U/pJyg29yX0=;
 b=kL+hY8owmzDai07uyeFcRNH19YH+BCFHOz3iSNIs6z4cJ3hkCokjdtua3Rz87+4Q7u
 rzTRX6fXyhe39rZMtFt9kP2ZM7C+cRXrhPIRRD+1YKq9+FqBhwAF79BfkEQ143yaTMc9
 VgoB1hSUFrKG6ZbLg2/IQBzsxV6eIwreu6AifpPhdiK20hEuPIBwxnLvs33ouO/ut9/b
 /JkDCqRsZPE5WPmoh7QPA3YI47GHkLdGq0/eAqjQGw3t4AxZVusqwjV/gGd9T5sxrORH
 l+GQQK95AekayYT1uTzDAySxaklsdy/SyZc+coCY/ESn0wFJ4E2LGRYGSrImX4WpRtTY
 0g4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqHKydlJybUI4q39Jtcudy7vFrbbhkxsusyTwXt6yvE2u3jOzrcrGGMFdSP6VqXEA19RJmmXxnsolh@nongnu.org
X-Gm-Message-State: AOJu0YyxH3keqGfBgKkZWQESrha5EYp1rydsSSrrNeZcyiQCaIkDwR42
 vZjuvQ1mc4+wn4q73Kskl1vtCjWRZw92GDg6CA8usZ8xm5mLTJTWuEljbFHqk3BY4EA=
X-Gm-Gg: AY/fxX6c1ag/9NneK/fvRr7JyOniiXEsKno+GTZcFWv1gOBhTngcFXB3OGT+jhONFG5
 hQKGWAdEJHg8QiEV6MsUkd9M30b6vXHBYll5W0/p2cvsErvvecM+4QYtzuXDTMTuOahtFQZDOhH
 t2/eZE4hFUKJqHuuARN7l9iExpE9JXbV228ks3aRFvMdQup7wSxG+HKNygB3XDttdQEMoFIedfB
 aAb72RFX+PfBa6xcOOTmV6HWb44mNcJ39e22RErDOQZ9TTTsQRt9QwAml58epJGp6KYWzF7Gnfh
 LA6PlMj2o2+6xOBUXrGMB0HXtFQ9gf2J5zMzZ155wjio+hVvHpTpUopPThn6HoDQ01XFA+tp/rK
 wSnk9RRegt//ZWr+DsgEczvMjQioWHJvnr6vVt9gEDyDgwc11CRayhQSAFsTWrJ1beJvtcBOlT5
 rSVNb989I/IMJd8gMwK0zu+vvSk1agYYW6WzmM1t3ybOQ87BQ=
X-Google-Smtp-Source: AGHT+IH2dAOgb7q5OjCkQW0AFKUJuQJSmLdQx7ODCszegrKc/2QxebCubAWcPbTE9NXD5UL9YKwchA==
X-Received: by 2002:a17:903:b90:b0:29f:301a:f6da with SMTP id
 d9443c01a7336-2a2f2a34f54mr488443665ad.43.1767610798421; 
 Mon, 05 Jan 2026 02:59:58 -0800 (PST)
Received: from hsinchu18.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6661esm440193975ad.2.2026.01.05.02.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 02:59:58 -0800 (PST)
From: Kito Cheng <kito.cheng@sifive.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 kito.cheng@gmail.com, Kito Cheng <kito.cheng@sifive.com>
Subject: [PATCH 4/5] target/riscv: Add arch=PROFILE to configure CPU using
 RISC-V profiles
Date: Mon,  5 Jan 2026 18:59:39 +0800
Message-ID: <20260105105940.3567112-5-kito.cheng@sifive.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105105940.3567112-1-kito.cheng@sifive.com>
References: <20260105105940.3567112-1-kito.cheng@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=kito.cheng@sifive.com; helo=mail-pl1-x62f.google.com
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

Add support for configuring RISC-V CPUs using standard RISC-V profiles
with the arch= property. The format is:

  arch=<profile-name>[_extension]*

Examples:
  -cpu rv64,arch=rva23u64
  -cpu rv64,arch=rva22s64
  -cpu rv64,arch=rva23u64_zbkb_zkne

Key features:
- Profiles are detected by prefix matching (case-insensitive)
- Additional extensions can be appended after the profile name
- Profiles are only available for 64-bit CPUs

Available profiles:
- rva22u64 - RVA22 User-mode profile
- rva22s64 - RVA22 Supervisor-mode profile
- rva23u64 - RVA23 User-mode profile (includes mandatory vector)
- rva23s64 - RVA23 Supervisor-mode profile

Profiles automatically enable all mandatory extensions defined by the
RISC-V profile specification. Additional extensions can be appended
after the profile name using underscores (following the RISC-V toolchain
convention).

The arch=help command now lists available profiles in addition to
extensions.

Signed-off-by: Kito Cheng <kito.cheng@sifive.com>
---
 docs/system/target-riscv.rst              |  24 +++++
 target/riscv/cpu.c                        |   8 ++
 target/riscv/tcg/tcg-cpu.c                | 103 +++++++++++++++++++++-
 tests/functional/riscv64/test_cpu_arch.py |  72 +++++++++++++++
 4 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index a16c17a22c2..12807974a8a 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -167,6 +167,30 @@ extensions:
 
     $ qemu-riscv64 -cpu rv64,arch=rv64gc_zba_zbb,arch=dump /bin/true
 
+* ``arch=<PROFILE-NAME>[_extension]*``
+
+  Configure the CPU using a standard RISC-V profile, optionally with additional
+  extensions. Profiles define sets of mandatory extensions for specific use
+  cases. Available profiles (64-bit only):
+
+  - ``rva22u64`` - RVA22 User-mode profile
+  - ``rva22s64`` - RVA22 Supervisor-mode profile
+  - ``rva23u64`` - RVA23 User-mode profile (includes mandatory vector)
+  - ``rva23s64`` - RVA23 Supervisor-mode profile
+
+  Examples::
+
+    $ qemu-riscv64 -cpu rv64,arch=rva23u64 /bin/true
+    $ qemu-riscv64 -cpu rv64,arch=rva22s64,arch=dump /bin/true
+    $ qemu-riscv64 -cpu rv64,arch=rva23u64_zbkb_zkne /bin/true
+
+  Profiles automatically enable all mandatory extensions defined by the RISC-V
+  profile specification. For example, RVA23 profiles enable the vector extension
+  (V) which was optional in RVA22. Additional extensions can be appended after
+  the profile name using underscores (following the RISC-V toolchain convention).
+
+  Use ``arch=help`` to see all available profiles.
+
 Privilege-implied extensions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b1d8438cd14..092635b1050 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1028,7 +1028,15 @@ G_NORETURN void riscv_cpu_list_supported_extensions(void)
     riscv_cpu_help_multiext("Experimental Extensions",
                             riscv_cpu_experimental_exts);
 
+    /* Print available profiles */
+    qemu_printf("Profiles (64-bit only):\n");
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        qemu_printf("  %s\n", riscv_profiles[i]->name);
+    }
+    qemu_printf("\n");
+
     qemu_printf("Use '-cpu <cpu>,<ext>=true' to enable an extension.\n");
+    qemu_printf("Use '-cpu <cpu>,arch=<profile>' to enable a profile.\n");
     qemu_printf("Use '-cpu <cpu>,arch=dump' to show current configuration.\n");
 
     exit(0);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 87f1a5c9c73..aa947337cf1 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1725,9 +1725,99 @@ static bool riscv_cpu_parse_isa_string(RISCVCPU *cpu, const char *isa_str,
     return true;
 }
 
+/*
+ * Find a profile by prefix (case-insensitive).
+ * The profile name must be followed by end of string or underscore.
+ * Returns the profile and sets *end_ptr to point after the profile name.
+ */
+static RISCVCPUProfile *riscv_find_profile_by_prefix(const char *str,
+                                                      const char **end_ptr)
+{
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        size_t len = strlen(riscv_profiles[i]->name);
+        if (g_ascii_strncasecmp(str, riscv_profiles[i]->name, len) == 0) {
+            char next_char = str[len];
+            if (next_char == '\0' || next_char == '_') {
+                if (end_ptr) {
+                    *end_ptr = str + len;
+                }
+                return riscv_profiles[i];
+            }
+        }
+    }
+    return NULL;
+}
+
+/*
+ * Parse profile string with optional extensions.
+ * Format: <profile-name>[_<extension>]*
+ * Examples: rva23u64, rva23u64_zbkb_zkne
+ */
+static bool riscv_cpu_parse_profile_string(RISCVCPU *cpu, const char *str,
+                                           Error **errp)
+{
+    const char *p;
+    RISCVCPUProfile *profile;
+
+    profile = riscv_find_profile_by_prefix(str, &p);
+    if (profile == NULL) {
+        error_setg(errp, "unknown profile in '%s'", str);
+        return false;
+    }
+
+    /* Check CPU compatibility */
+    if (riscv_cpu_is_vendor(OBJECT(cpu))) {
+        error_setg(errp, "Profile %s is not available for vendor CPUs",
+                   profile->name);
+        return false;
+    }
+    if (riscv_cpu_is_32bit(cpu)) {
+        error_setg(errp, "Profile %s is only available for 64-bit CPUs",
+                   profile->name);
+        return false;
+    }
+
+    /* Enable the profile */
+    profile->user_set = true;
+    riscv_cpu_set_profile(cpu, profile, true);
+
+    /* Parse additional extensions after the profile name */
+    while (*p == '_') {
+        p++;  /* Skip underscore */
+
+        if (*p == '\0') {
+            break;  /* Trailing underscore is ok */
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
+        /* Look up the extension */
+        const RISCVIsaExtData *edata = riscv_find_ext_data(ext_name);
+        if (edata == NULL) {
+            error_setg(errp, "unknown extension '%s' in profile string",
+                       ext_name);
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
 /*
  * arch= property handler for ISA configuration.
- * Supports: dump, help, or an ISA string like rv64gc_zba_zbb.
+ * Supports: dump, help, ISA string (rv64gc_zba_zbb),
+ * or profile with optional extensions (rva23u64, rva23u64_zbkb_zkne).
  */
 static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
@@ -1743,13 +1833,17 @@ static void cpu_set_arch(Object *obj, Visitor *v, const char *name,
         cpu->cfg.arch_dump_requested = true;
     } else if (g_strcmp0(value, "help") == 0) {
         riscv_cpu_list_supported_extensions();
+    } else if (riscv_find_profile_by_prefix(value, NULL) != NULL) {
+        /* Parse as profile with optional extensions */
+        riscv_cpu_parse_profile_string(cpu, value, errp);
     } else if (g_ascii_strncasecmp(value, "rv", 2) == 0) {
         /* Parse as ISA string */
         riscv_cpu_parse_isa_string(cpu, value, errp);
     } else {
         error_setg(errp, "unknown arch option '%s'. "
-                   "Supported options: dump, help, or ISA string (e.g., "
-                   "rv64gc_zba_zbb)", value);
+                   "Supported options: dump, help, ISA string (e.g., "
+                   "rv64gc_zba_zbb), or profile (e.g., rva23u64, "
+                   "rva23u64_zbkb)", value);
     }
 }
 
@@ -1761,7 +1855,8 @@ static void riscv_cpu_add_arch_property(Object *obj)
     object_property_set_description(obj, "arch",
         "ISA configuration (write-only). "
         "Use 'help' to list extensions, 'dump' to show current config, "
-        "or provide an ISA string (e.g., rv64gc_zba_zbb).");
+        "provide an ISA string (e.g., rv64gc_zba_zbb), "
+        "or use a profile (e.g., rva23u64).");
 }
 
 /*
diff --git a/tests/functional/riscv64/test_cpu_arch.py b/tests/functional/riscv64/test_cpu_arch.py
index 204247cdb73..c12e1c7fce4 100644
--- a/tests/functional/riscv64/test_cpu_arch.py
+++ b/tests/functional/riscv64/test_cpu_arch.py
@@ -266,6 +266,78 @@ def test_arch_isa_string_underscore_separated_single(self):
         self.assertRegex(res.stdout, r'd\s+enabled')
         self.assertRegex(res.stdout, r'c\s+enabled')
 
+    def test_arch_profile_rva23u64(self):
+        """Test arch=rva23u64 enables RVA23 profile extensions"""
+        res = self.run_qemu('rv64,arch=rva23u64,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # RVA23U64 mandates vector extension
+        self.assertRegex(res.stdout, r'\bv\s+enabled')
+
+        # RVA23U64 mandates these extensions
+        self.assertRegex(res.stdout, r'zicond\s+enabled')
+        self.assertRegex(res.stdout, r'zimop\s+enabled')
+        self.assertRegex(res.stdout, r'zcmop\s+enabled')
+        self.assertRegex(res.stdout, r'zcb\s+enabled')
+        self.assertRegex(res.stdout, r'zfa\s+enabled')
+        self.assertRegex(res.stdout, r'zvbb\s+enabled')
+
+    def test_arch_profile_rva22u64(self):
+        """Test arch=rva22u64 enables RVA22 profile extensions"""
+        res = self.run_qemu('rv64,arch=rva22u64,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+
+        # RVA22U64 mandates these MISA extensions
+        self.assertRegex(res.stdout, r'\bi\s+enabled')
+        self.assertRegex(res.stdout, r'm\s+enabled')
+        self.assertRegex(res.stdout, r'a\s+enabled')
+        self.assertRegex(res.stdout, r'f\s+enabled')
+        self.assertRegex(res.stdout, r'd\s+enabled')
+        self.assertRegex(res.stdout, r'c\s+enabled')
+
+        # RVA22U64 mandates zicsr and zifencei
+        self.assertRegex(res.stdout, r'zicsr\s+enabled')
+        self.assertRegex(res.stdout, r'zifencei\s+enabled')
+
+    def test_arch_profile_case_insensitive(self):
+        """Test arch=PROFILE is case-insensitive"""
+        res = self.run_qemu('rv64,arch=RVA23U64,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        # Should enable vector like lowercase version
+        self.assertRegex(res.stdout, r'\bv\s+enabled')
+
+    def test_arch_help_shows_profiles(self):
+        """Test arch=help lists available profiles"""
+        res = self.run_qemu('rv64,arch=help')
+
+        self.assertEqual(res.returncode, 0)
+        self.assertIn('Profiles', res.stdout)
+        self.assertIn('rva22u64', res.stdout)
+        self.assertIn('rva22s64', res.stdout)
+        self.assertIn('rva23u64', res.stdout)
+        self.assertIn('rva23s64', res.stdout)
+
+    def test_arch_profile_with_extensions(self):
+        """Test arch=PROFILE_EXT enables profile plus additional extensions"""
+        res = self.run_qemu('rv64,arch=rva23u64_zbkb_zkne,arch=dump')
+
+        self.assertEqual(res.returncode, 0)
+        # Profile extensions should be enabled
+        self.assertRegex(res.stdout, r'\bv\s+enabled')
+        # Additional extensions should also be enabled
+        self.assertRegex(res.stdout, r'zbkb\s+enabled')
+        self.assertRegex(res.stdout, r'zkne\s+enabled')
+
+    def test_arch_profile_with_unknown_extension(self):
+        """Test arch=PROFILE_EXT rejects unknown extensions"""
+        res = self.run_qemu('rv64,arch=rva23u64_unknown')
+
+        self.assertNotEqual(res.returncode, 0)
+        self.assertIn("unknown extension 'unknown'", res.stderr)
+
 
 if __name__ == '__main__':
     QemuUserTest.main()
-- 
2.52.0


