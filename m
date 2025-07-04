Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCD3C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeM0-0002TP-Aa; Fri, 04 Jul 2025 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLo-0001yE-DT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLd-0002mI-BS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:02 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23694cec0feso7598505ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627571; x=1752232371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YdLnpcgCTV0XB5ow8eV7/MKeKU1pwUDrFprn8g+bog=;
 b=NotIgmkTZzIaMTC4oZXUQQ/t9ec7vOpsCi4FJvViUKpcqA7/IA3qVbzT+BaIRliT5u
 J6HbnlJ4LzCCLKZYrA5RudSvbpaJ+WdnGfceYsmMqTE7R4/QSyiVcx4Iu44ZTNoRgRVq
 ocdXD1RlURFpmUokivdQSuOqo6wf8t/ciJo0ytX7E4UdPut7a5gTrcBnm3KOP2tmtXx4
 sol0S/gYcH7mlBpeOUFUuFdnvaODn9VOS6ou4ViSENsDNVD9dLx5tkCVjMv85e1EFT4c
 8F7Gd4N4VYAkI0bN0kEWH1YqiFNhMqb+ZyACYTe2Xc7hL2yAgyKv8+D3jsNYVv8r0zrq
 RFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627572; x=1752232372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YdLnpcgCTV0XB5ow8eV7/MKeKU1pwUDrFprn8g+bog=;
 b=fVBO2QMX0VD22Pm0PLPgBn5xshZNluIN+iWkRch+TiwZbpgfoK2nhnIJETew50cliU
 IXjOZFrf1ePFZa0TgDS7jy+QLsONPlA8+l5sI4A1A6MaKmXQIN5DxMECdd/5mJYdoWoH
 fxmrjdyeGTIqKZq3QphIMFmBz8rKvTO/Wxu65nRqldAl5avDqYtHY/6PggcDUQ7s1evs
 VVKCfoKj/XDrtFp4VbWJfUgxciE6e1uypymyJILUzjUB3UBmorc/HVKr7auWfsZXRHUS
 9YfFsiaZiefYK3sx0rt+8i06Lzm/vcWtfyoHB2BloCRXmtrA7C7hnqqipuOnV0kXS171
 RZ8Q==
X-Gm-Message-State: AOJu0YwRSymHzHTGOQrd63KIGqlMxF64+h9sTWWwWjJlvbf2fLSoGzvk
 DiJoEkRoIgOlTDkTV1pUgZwjYm1XI4n3DREagFDpYX+W9OoIpnfdWVPqL2yPTQ==
X-Gm-Gg: ASbGnctVZnPanur31nrNff0MvPsk3w9VWu7VagYA/rPdzUaOA3EMrrcSFo+B0Q8l2Kh
 fgjN/BRsuYBMpphZYgN9Z2uYwP7jPP1iMGVUlQKesGd71OGl8N1sRN6TPxwj3sig/X5aaWTapHP
 +0C4UUDZDGX/wdzeDnKaHHnfp5LEJ6pvW6yX7rsbYB3ikTJFffiLshJVcg69BqR9EjOhL98P42R
 t7qYF4AKvQ9dfBn3s7yqI73GxVBM3F31JJYcGi7xc2Tg0Q6nqzQ9d/pdklaaqms54j7TLhxJ78+
 OcgWNHcpeg2IOx/2l5eR+4k9DTafhOFKu35x4y8uK4mQbryaVZ8a00vd6+zDR5jP13ycnhS9zF8
 DMJwaI4TkNGvc//fOGLVMK5ZtbZjZi88iflNr8NH//QX5+r25ZtovLSKlH1Uk5NOjltMpK/IdmA
 xHMg==
X-Google-Smtp-Source: AGHT+IEdvIuadjWzlkK+ILzCJbDiAR5xuW6Zruu6F68t13m2y8EmrHg0vBSWmbuPbPWFyo4mDI4ibg==
X-Received: by 2002:a17:903:1ac6:b0:23c:7876:e6a8 with SMTP id
 d9443c01a7336-23c86244ed0mr38107665ad.51.1751627571516; 
 Fri, 04 Jul 2025 04:12:51 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:12:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/40] target/riscv/tcg: decouple profile enablement from user
 prop
Date: Fri,  4 Jul 2025 21:11:34 +1000
Message-ID: <20250704111207.591994-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

We have code in riscv_cpu_add_profiles() to enable a profile right away
in case a CPU chose the profile during its cpu_init(). But we're using
the user callback option to do so, setting profile->user_set.

Create a new helper that does all the grunt work to enable/disable a
given profile. Use this new helper in the cases where we want a CPU to
be compatible to a certain profile, leaving the user callback to be used
exclusively by users.

Fixes: fba92a92e3 ("target/riscv: add 'rva22u64' CPU")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
Message-ID: <20250528184407.1451983-3-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 127 +++++++++++++++++++------------------
 1 file changed, 67 insertions(+), 60 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 39de32cf76..e10e03a577 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1166,6 +1166,70 @@ static bool riscv_cpu_is_generic(Object *cpu_obj)
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
@@ -1332,7 +1396,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
     RISCVCPUProfile *profile = opaque;
     RISCVCPU *cpu = RISCV_CPU(obj);
     bool value;
-    int i, ext_offset;
 
     if (riscv_cpu_is_vendor(obj)) {
         error_setg(errp, "Profile %s is not available for vendor CPUs",
@@ -1351,64 +1414,8 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
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
@@ -1423,7 +1430,7 @@ static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
 static void riscv_cpu_add_profiles(Object *cpu_obj)
 {
     for (int i = 0; riscv_profiles[i] != NULL; i++) {
-        const RISCVCPUProfile *profile = riscv_profiles[i];
+        RISCVCPUProfile *profile = riscv_profiles[i];
 
         object_property_add(cpu_obj, profile->name, "bool",
                             cpu_get_profile, cpu_set_profile,
@@ -1435,7 +1442,7 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
          * case.
          */
         if (profile->enabled) {
-            object_property_set_bool(cpu_obj, profile->name, true, NULL);
+            riscv_cpu_set_profile(RISCV_CPU(cpu_obj), profile, true);
         }
     }
 }
-- 
2.50.0


