Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B448C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLx-0002EW-5N; Fri, 04 Jul 2025 07:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLr-00023c-NT
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:07 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXeLo-000312-4r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:07 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23633a6ac50so12207825ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751627581; x=1752232381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpC4Yp9xAW0N3T6Tteiy7UBN259S4dShS5JJ++ECn+Q=;
 b=auRDZzubeYuRpiMVdAOxMpAGZf5yaas0VYnPmG7589MAy9m4AWOEWlgcBQ4B1dQ+Fa
 LSkj7s9OQQQ73Q9rXdqMTJDZV7hoWZPXhh/tmuoonmFSC7kyiji6ax0TYmw9LZC4XMnk
 WUEizgLCdZbUNBHpypiE2HxjGwgJeXGKT1krmnJcuf2soglod9XPIiqjCUh1ebYycWEb
 yzRRLgHiPLi2fcuymRIYLSAIX/ZxpANoiY7V/HMAs+noxaNy3/B1QpC92umQl/+GDK86
 m7/HCz+XAGt2CvdBFSksbfXbbNosHQBaqYcx0NUPoo3pfs9diW8BexO9KOmZOjpY8z42
 /oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751627581; x=1752232381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpC4Yp9xAW0N3T6Tteiy7UBN259S4dShS5JJ++ECn+Q=;
 b=oNrgjwsDvKebX0jUe1PQfFfOuwSIIrTylYUx0e3bOh0/+aJ5uNniJejQOfr4BVvXEG
 /dkLjYIuKJRH6Cl/YQ7ylozlrGO4MgHpjBbal4urTbbtTD8tLnuZYAyLaUUwoL+n1vGl
 y16BLsZu251ciJF9DwKaRhibwVdS0grsYKT1sUW0xRGGKigxwa7uVNQgTkSomvQxRocP
 CIrAQh+1SXArc4XR1rFFd4gEzOw8TJRXxT0L+KO/oV0nvZSC5yqwFsQx0/9Vyi1IRjNe
 7FsTLh6S5Zpn+0oZevAG/ynXicPouEv0MxkWqWQlHMBBST1GSXCSAI5HBE67oU9YGPGE
 dThw==
X-Gm-Message-State: AOJu0Yy8YNA9clUlnTykGxy7u82CS+wDp127+KIE2Z577TEjnfw2VeFq
 clIer4rDSK/6WLPVcatmqOa/zhkvsO1Q4VRRqIr8yxhx0imQ70GxvX1u69IpnA==
X-Gm-Gg: ASbGncuelFOmrZWVRP8ElFLJgFgmyxwS1wu3bwhHlPN1YI46XXn6GUHlgtRvR4oo5BG
 +RzYGNyZzpHKNdvFyZb37X+B5dYI45MgnZXZY9dxaPX8dX2DQw0rSsA/Zhc67PesouUqZyizt9+
 AhRd+WpP73Litv8dUVJV4tYz18JkgyQNWu35c3L1uknAggQT23SoFdVSjko09i5I1/dPPtlJGj4
 CF4NoZ/BSNXMedpedaQNLG0VRH/lRCqk4nfFrNR4HPh59qc7cTo+HWcPXmgwD/MTrs6bHScmQdY
 UsF0AY691VrvnfbHNWqbUb/ay2JI3me2I7ov8hJuzFiExeO5kMUiEzZ0MicUDZY9hPLJ109pKCM
 Q7f/7+t1Nm0GzNvr0jBy17QO6YuKbnIOFzplx+gMRlfCol/193eFVWn+cdDIwYHoOsy8=
X-Google-Smtp-Source: AGHT+IFG9pmmPG7wqpdzTObXC3oJblhN7r4WFFSKwXdh8QKBIt5IinMXklbMz49Kdc6cHH4LR5LtVw==
X-Received: by 2002:a17:902:ea06:b0:236:8df9:ab38 with SMTP id
 d9443c01a7336-23c860d4f93mr40811565ad.34.1751627581292; 
 Fri, 04 Jul 2025 04:13:01 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c8431a206sm18002655ad.28.2025.07.04.04.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 04:13:00 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/40] target/riscv: remove capital 'Z' CPU properties
Date: Fri,  4 Jul 2025 21:11:37 +1000
Message-ID: <20250704111207.591994-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704111207.591994-1-alistair.francis@wdc.com>
References: <20250704111207.591994-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

These properties were deprecated in QEMU 8.2, commit 8043effd9b.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250530134608.1806922-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  1 -
 target/riscv/cpu.c         | 17 -----------------
 target/riscv/tcg/tcg-cpu.c | 31 +------------------------------
 3 files changed, 1 insertion(+), 48 deletions(-)

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
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c5e260e360..81174de409 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1442,25 +1442,6 @@ static void riscv_cpu_add_profiles(Object *cpu_obj)
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
@@ -1473,13 +1454,6 @@ static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
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
@@ -1515,14 +1489,13 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
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
 
@@ -1565,8 +1538,6 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
-    riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
-
     riscv_cpu_add_profiles(obj);
 }
 
-- 
2.50.0


