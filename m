Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B8AC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 13:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL03z-000734-F9; Fri, 30 May 2025 09:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uL03y-00072X-Es
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:46:22 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uL03v-0000Th-Kk
 for qemu-devel@nongnu.org; Fri, 30 May 2025 09:46:21 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5308d2d76f4so50511e0c.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748612778; x=1749217578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iVefdb7qkX42XJzWCxv1YPV0+MjP7QAzAJ23vLZC8d8=;
 b=dn6T6cEH401MVzLkhJ2s3FaUk1XFnIhZda5f04jumqTX3tpAG4q8UVnDXpN/egn2or
 Y72KHfEXfhAT048yeTdgqzy41CWQefoqxFceYNm/G5YW8wKKpGQ9XUywZ0XdslM9/PnW
 GP2J8tNThADRD8CdRAsXJFXzsnVN07On9pVPhBxfyOaiOc3oJocQ8COdi6KJwJHtvnG9
 MgnUPlR1rOkGgT9uxLfDQVd6xpA77mKTNJR8NI/tHoPuPEWOXtYkR+et/Pn3voCsbHHr
 mWO+OhaR1rK9PShqlfP2mGoe/x1pZJGFW4VCm8yEVnfamDBx4ZmfsMAmS0P+jiA62eXY
 HsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748612778; x=1749217578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iVefdb7qkX42XJzWCxv1YPV0+MjP7QAzAJ23vLZC8d8=;
 b=UJCz3BkP4APlaPTzcURL8wN/ZvWufYMusF7jUNy36Dw+XRZcG3BcFWo6JKdptCj8Xc
 EiGH+PwJyG9dltdhCoEyvNjnQoKFj54FPNfcFwCLTqboDVX1NX2cvVLdRjVBCbSgtRwt
 zoRsl/LfXnzZeCHE5gaZcF0sfqdt1Lm6Bsak8/km58QkN56oDjaOpMXcUbfShCRcKXR1
 RdVIzqjjVoZtQEdEwI6Zng1sZ1AeSzui4hMEe45+uOFWYqOd06wL+8AGM0q9tECxlDID
 Lb8zO/p/K9gV1Pyl45EVg6oSeFgMou+7Kf8fMxVbPDkEemm2amGJLK4SOlK1d4Ih3fSG
 SF2w==
X-Gm-Message-State: AOJu0Yzrhj0PaLhHc5ArLFL/LyfUh7lGEs472XeLnZOM2ZqkaezrAdau
 0cXVoXxzE+W27O1blpQfWeS9CegQSvoA8ztuR6kccziDMgn3ZwMTByj2hXVpztkhw15xVrV7FHq
 41LJ7
X-Gm-Gg: ASbGncslrvwlPa9Pc1qne+ttqoPq8ybBYzt8wsPVO2MQYFCxyej8TeqQjRlVKpbsTFE
 jllxeNwj55TPR4Y3Vf2q5mDl7ENBumtTuiA2/GkAVStWcPWQ5y+YKZzHS/l9HQ2QCgnLEzvAC0n
 jls6Y9YdWOzQeOJUM353WnRf152ywLr97nKcF8e/zcEeC9oBSGsARveHYgZL3hEFL2ftgwvenc8
 iWcijqigb2c5p1m6UsSiVJ4WNugogMwu0Pzcnpo2Gq4wMu548b69iT6+ju5ogbfStnoHxJlXvuv
 jW76Zmeiakgj1pxorXTbsee3In8ZVQYMG7lPVE7Kye8cSXwmbLBmJ6T6QyyaG8Lj2YPDQCxAD/L
 v7A04
X-Google-Smtp-Source: AGHT+IG1v8EQAkTWfF4hA+q8IKy23d2tpb/Sy9O4CprezlMlXso0hGVEngkGkZpoH5YHP7qZKnmeWw==
X-Received: by 2002:a05:6122:4f83:b0:530:66e6:e21a with SMTP id
 71dfb90a1353d-53084bc1a70mr1450983e0c.3.1748612777960; 
 Fri, 30 May 2025 06:46:17 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.188.133.196])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53074bf86bcsm3121345e0c.35.2025.05.30.06.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 06:46:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH] target/riscv: remove capital 'Z' CPU properties
Date: Fri, 30 May 2025 10:46:08 -0300
Message-ID: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-vk1-xa2d.google.com
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

These properties were deprecated in QEMU 8.2, commit 8043effd9b.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c         | 17 -----------------
 target/riscv/cpu.h         |  1 -
 target/riscv/tcg/tcg-cpu.c | 31 +------------------------------
 3 files changed, 1 insertion(+), 48 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index fe21e0fb44..7c6e0844d0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1387,23 +1387,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_named_features[] = {
     { },
 };
 
-/* Deprecated entries marked for future removal */
-const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[] = {
-    MULTI_EXT_CFG_BOOL("Zifencei", ext_zifencei, true),
-    MULTI_EXT_CFG_BOOL("Zicsr", ext_zicsr, true),
-    MULTI_EXT_CFG_BOOL("Zihintntl", ext_zihintntl, true),
-    MULTI_EXT_CFG_BOOL("Zihintpause", ext_zihintpause, true),
-    MULTI_EXT_CFG_BOOL("Zawrs", ext_zawrs, true),
-    MULTI_EXT_CFG_BOOL("Zfa", ext_zfa, true),
-    MULTI_EXT_CFG_BOOL("Zfh", ext_zfh, false),
-    MULTI_EXT_CFG_BOOL("Zfhmin", ext_zfhmin, false),
-    MULTI_EXT_CFG_BOOL("Zve32f", ext_zve32f, false),
-    MULTI_EXT_CFG_BOOL("Zve64f", ext_zve64f, false),
-    MULTI_EXT_CFG_BOOL("Zve64d", ext_zve64d, false),
-
-    { },
-};
-
 static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
                              Error **errp)
 {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2a6793e022..17bf4e7579 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -951,7 +951,6 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
 extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
-extern const RISCVCPUMultiExtConfig riscv_cpu_deprecated_exts[];
 
 typedef struct isa_ext_data {
     const char *name;
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 66929f2e8d..8ebffe55bc 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1416,25 +1416,6 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
     }
 }
 
-static bool cpu_ext_is_deprecated(const char *ext_name)
-{
-    return isupper(ext_name[0]);
-}
-
-/*
- * String will be allocated in the heap. Caller is responsible
- * for freeing it.
- */
-static char *cpu_ext_to_lower(const char *ext_name)
-{
-    char *ret = g_malloc0(strlen(ext_name) + 1);
-
-    strcpy(ret, ext_name);
-    ret[0] = tolower(ret[0]);
-
-    return ret;
-}
-
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -1447,13 +1428,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (cpu_ext_is_deprecated(multi_ext_cfg->name)) {
-        g_autofree char *lower = cpu_ext_to_lower(multi_ext_cfg->name);
-
-        warn_report("CPU property '%s' is deprecated. Please use '%s' instead",
-                    multi_ext_cfg->name, lower);
-    }
-
     cpu_cfg_ext_add_user_opt(multi_ext_cfg->offset, value);
 
     prev_val = isa_ext_is_enabled(cpu, multi_ext_cfg->offset);
@@ -1489,14 +1463,13 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
                                    const RISCVCPUMultiExtConfig *multi_cfg)
 {
     bool generic_cpu = riscv_cpu_is_generic(cpu_obj);
-    bool deprecated_ext = cpu_ext_is_deprecated(multi_cfg->name);
 
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
                         cpu_set_multi_ext_cfg,
                         NULL, (void *)multi_cfg);
 
-    if (!generic_cpu || deprecated_ext) {
+    if (!generic_cpu) {
         return;
     }
 
@@ -1539,8 +1512,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
-
     riscv_cpu_add_profiles(obj);
 }
 
-- 
2.49.0


