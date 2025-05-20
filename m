Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E3C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 17:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHQgz-0000ui-KM; Tue, 20 May 2025 13:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQgy-0000uV-7F
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:52 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHQgw-0005AX-Ad
 for qemu-devel@nongnu.org; Tue, 20 May 2025 13:23:51 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-87bfe95866fso922842241.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747761828; x=1748366628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiOIogb77POCkOKpPU+UL0d8rryZQYDWuDZAi1v/Gsc=;
 b=E6kAf+KDsjVjal1m2Lr/BEshsMw0DYGryADAqjk8/aAWtdL1qk1KTIqD3JEfzpZ8HU
 +Itpw286VA1Vdw3KvYIri+T69ma4bY2W17JVEQj9xvnqDLNlw/nWU8jFZLYY09QuLjwl
 kBWSSuiqbV7m6WuUb2FQAVvKdYccsKQ96AJZ7BtiqhhINpDRFosAqJH8cxA0GPj25EFb
 MiSXrbE1aq8dyyhUYqqcBzBiBpqAHl+oLx9tzKx4i2UFK7nD3HUW9/mV0QC3zKxGK/jf
 Npo/v3souXj/CbJl9iYHw0slEIAKFhMDS7e6XiCd8P+zrcehD1IYT4H2pH1hkmusTUSC
 iKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747761828; x=1748366628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiOIogb77POCkOKpPU+UL0d8rryZQYDWuDZAi1v/Gsc=;
 b=SD9VI7NcUFnMxykKurwcJADjBtnFRv9/zMhonMa0x4t848aQoeOjPXLSBeofgvPESz
 uueOCkpUNlwk+QhKU2lll6EqQwqGFnKuBMx076Arwfy7xkWH7IZq/kBytNsYevcdUszS
 dka5Mc/PfDbxggxTiY6Aw7g0S9DlfF7PRLCWW52fIIJGlDH4xiUirXFenawkS5c9ZhXl
 ovIDVhZ4aXlvOZxYu+PbJpTZ2R3tM4WfdcxRBgWul4y+z2XMDFd9r4c5LlTOKzDuZ8xi
 VYRRSBvr6WuzCz8HronA8wMQOKTib7XOlWasyX+dH3GtyJfZy/nGCw9WRkq67tDZX87G
 1EFg==
X-Gm-Message-State: AOJu0YzlUz/mmgCBit3CZ5DDwmnTXkEyVyHwmrz4rxkemkbD2qVc45CU
 dQzLIEn6NVFX7Qxvo68mmITpKxWv1nzlyZ+c4EByD3r/kOZFnVdQ+2P2D9VPcHAxZtZ6PBNY+YY
 q2Qwf
X-Gm-Gg: ASbGncvCqtUe7Dy12QPwIkG52UTbBKEXdf2ymiSrvypTCiAjjjVsxoZqqW8oaCkgQ16
 6RGc7zL7g1YBfrwJCNKENZ6jV9RmxZh6ijp9i0Xw/0VbxiM/BOCLUiXFAlHbCfa6LlbaxA+tyew
 RpbxD9+H7eaN5G1qDNI4GjkSDZhORU3m/GsKjRB+5K3Wv3ThQvK5pk6HNNsvjTPWF2gZ/9x01qg
 nSAtff4CqtdWRy9WhqLf4gjKPuiVNbBMLQiPmRi1VhBUaMmkdCwcYFQ2SdsFUH2BqLIQGViffgT
 3ENPVlYO4J3UvUQzKpYzbsh+vKKkV/AR5JshxnMvgSFAx3aN7kARBqNdF+aNDlZWolhOJxTaqj8
 RUHCX
X-Google-Smtp-Source: AGHT+IHD8WLGLCSDbtECWPjaY2484p77Lq/lOtihUU0sqwVxobXsDrz16oo7+9R9gh99ZXc/5evZvA==
X-Received: by 2002:a05:6102:1512:b0:4df:93e0:fbb with SMTP id
 ada2fe7eead31-4dfa6c66bb3mr17045492137.25.1747761828541; 
 Tue, 20 May 2025 10:23:48 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-87bec155e21sm7698107241.17.2025.05.20.10.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 10:23:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, ajones@ventanamicro.com,
 bjorn@kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/3] target/riscv/tcg: decouple profile enablement from user
 prop
Date: Tue, 20 May 2025 14:23:35 -0300
Message-ID: <20250520172336.759708-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520172336.759708-1-dbarboza@ventanamicro.com>
References: <20250520172336.759708-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have code in riscv_cpu_add_profiles() to enable a profile right away
in case a CPU chose the profile during its cpu_init(). But we're using
the user callback option to do so, setting profile->user_set.

Create a new helper that does all the grunt work to enable/disable a
given profile. Use this new helper in the cases where we want a CPU to
be compatible to a certain profile, leaving the user callback to be used
exclusively by users.

Fixes: fba92a92e3 ("target/riscv: add 'rva22u64' CPU")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 127 +++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7f93414a76..af202c92a3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1139,6 +1139,70 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
 }
 
+static void riscv_cpu_set_profile(RISCVCPU *cpu,
+                                  RISCVCPUProfile *profile,
+                                  bool enabled)
+{
+    int i, ext_offset;
+
+    if (profile->u_parent != NULL) {
+        riscv_cpu_set_profile(cpu, profile->u_parent, enabled);
+    }
+
+    if (profile->s_parent != NULL) {
+        riscv_cpu_set_profile(cpu, profile->s_parent, enabled);
+    }
+
+    profile->enabled = enabled;
+
+    if (profile->enabled) {
+        cpu->env.priv_ver = profile->priv_spec;
+
+#ifndef CONFIG_USER_ONLY
+        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
+            object_property_set_bool(OBJECT(cpu), "mmu", true, NULL);
+            const char *satp_prop = satp_mode_str(profile->satp_mode,
+                                                  riscv_cpu_is_32bit(cpu));
+            object_property_set_bool(OBJECT(cpu), satp_prop, true, NULL);
+        }
+#endif
+    }
+
+    for (i = 0; misa_bits[i] != 0; i++) {
+        uint32_t bit = misa_bits[i];
+
+        if  (!(profile->misa_ext & bit)) {
+            continue;
+        }
+
+        if (bit == RVI && !profile->enabled) {
+            /*
+             * Disabling profiles will not disable the base
+             * ISA RV64I.
+             */
+            continue;
+        }
+
+        cpu_misa_ext_add_user_opt(bit, profile->enabled);
+        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
+    }
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        ext_offset = profile->ext_offsets[i];
+
+        if (profile->enabled) {
+            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
+                riscv_cpu_enable_named_feat(cpu, ext_offset);
+            }
+
+            cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
+        }
+
+        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
+        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
+    }
+}
+
 /*
  * We'll get here via the following path:
  *
@@ -1305,7 +1369,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     RISCVCPUProfile *profile = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
     bool value;
-    int i, ext_offset;
 
     if (riscv_cpu_is_vendor(obj)) {
         error_setg(errp, "Profile %s is not available for vendor CPUs",
@@ -1324,64 +1387,8 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     }
 
     profile->user_set = true;
-    profile->enabled = value;
-
-    if (profile->u_parent != NULL) {
-        object_property_set_bool(obj, profile->u_parent->name,
-                                 profile->enabled, NULL);
-    }
-
-    if (profile->s_parent != NULL) {
-        object_property_set_bool(obj, profile->s_parent->name,
-                                 profile->enabled, NULL);
-    }
-
-    if (profile->enabled) {
-        cpu->env.priv_ver = profile->priv_spec;
-
-#ifndef CONFIG_USER_ONLY
-        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
-            object_property_set_bool(obj, "mmu", true, NULL);
-            const char *satp_prop = satp_mode_str(profile->satp_mode,
-                                                  riscv_cpu_is_32bit(cpu));
-            object_property_set_bool(obj, satp_prop, true, NULL);
-        }
-#endif
-    }
-
-    for (i = 0; misa_bits[i] != 0; i++) {
-        uint32_t bit = misa_bits[i];
-
-        if  (!(profile->misa_ext & bit)) {
-            continue;
-        }
 
-        if (bit == RVI && !profile->enabled) {
-            /*
-             * Disabling profiles will not disable the base
-             * ISA RV64I.
-             */
-            continue;
-        }
-
-        cpu_misa_ext_add_user_opt(bit, profile->enabled);
-        riscv_cpu_write_misa_bit(cpu, bit, profile->enabled);
-    }
-
-    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
-        ext_offset = profile->ext_offsets[i];
-
-        if (profile->enabled) {
-            if (cpu_cfg_offset_is_named_feat(ext_offset)) {
-                riscv_cpu_enable_named_feat(cpu, ext_offset);
-            }
-
-            cpu_bump_multi_ext_priv_ver(&cpu->env, ext_offset);
-        }
-
-        cpu_cfg_ext_add_user_opt(ext_offset, profile->enabled);
-        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
-    }
+    riscv_cpu_set_profile(cpu, profile, value);
 }
 
 static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
@@ -1396,7 +1403,7 @@ static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
 static void riscv_cpu_add_profiles(Object *cpu_obj)
 {
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
-        const RISCVCPUProfile *profile = riscv_profiles[i];
+        RISCVCPUProfile *profile = riscv_profiles[i];
 
         object_property_add(cpu_obj, profile->name, "bool",
                             cpu_get_profile, cpu_set_profile,
@@ -1408,7 +1415,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
          * case.
          */
         if (profile->enabled) {
-            object_property_set_bool(cpu_obj, profile->name, true, NULL);
+            riscv_cpu_set_profile(RISCV_CPU(cpu_obj), profile, true);
         }
     }
 }
-- 
2.49.0


