Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A2CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJG-00026w-33; Tue, 14 Oct 2025 16:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJC-00024y-JF
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIv-0005L6-2b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-271067d66fbso55818855ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472446; x=1761077246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMmgovzsInT0Iqp/dEgmNQN2NAoXX8SnCQShyk1ZzAw=;
 b=zbsEB96vC9U/+6iV7YL25PzXQQPsOx8cqY3eSKZhYoH7tx0zxWz924J54j6pjWXYBL
 ejTCj2+g0uHfIMymGtcYV/2sj/Puyd/tzUmF6ERAinQjRR8vAQZS8aR7PlKQ0o+SvkQK
 634kjy1ExmZNP5i1JeoDpi6qUh03tGV//CBT3SwHjmUR7Iz0svz+yXKU18m1ldmX/XgQ
 KqpUA0a7qjYTBcluuUl6raNkzy6eZ/t3nHsA8Smn9J1bBTvmirq4ykD8flKDZQRGDizr
 XGkGXi/9Uqc9H5w2kCP2KC78tqg5P8jld9wNoFZzfQkK+X4qAnOWvMGvjlLowDgklw/0
 6ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472446; x=1761077246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMmgovzsInT0Iqp/dEgmNQN2NAoXX8SnCQShyk1ZzAw=;
 b=pC9UvKl8y9wTYYVbeLam6i9v0i8R1MFRuy1Xbn78OtKwgTctdXa3UL8eBYzvEOEpp/
 CUOQIjya8yrVs6KPW+VcrtgNxYN+u5RBuKw64xHo80fYdYWQQg2TcEWqlf47dzdSJcjt
 Gbol+ZPHRdpZku/aXwTxTNi56hE1kCKRDu4nMtNE5HNDT2xkMhL0XYXiQxy/kKxfO+Z3
 9zM1veKp4JNagyZNyAYHVjXTYBFK03iv9uRshGVS6B3FsG8o2EQqXsDiX9DCg0BqksF+
 odOj3AFoGuJJVdIVLFoEc6jXECqUUXK41EHtZtcC+wFzDFMqyntjKrwwzRBvAZmvRhbP
 4DwA==
X-Gm-Message-State: AOJu0YwNqJGBlBk4Tcwm/vj0BSLKl6/5+y26ogZU3G7aPkSNGqhOiPuT
 uxHphgGgoHU4+7Bz/IafpfLAa5HgEvaLFL46t6mjCjVcKabvQaOfD1HQR/6uMAVtql60luGcPrR
 y6UjQeIc=
X-Gm-Gg: ASbGncutq7zk9jcycwWjQWwY2ZbDpXj6bkec0KePQCHHJqg1hVC4cAXKQiEWg+Avv+e
 EbTffqXIZyK8YD8n49ISweLTz2zPYmrp71yeDXORHbB6NMaBMKFk0sc/zIDD/InIPV8FCzjVeE6
 +EGbkoFsolC1G5RJx9MUpNDgtkER+X8f5gIg7ZOQ4AND6eVghFJ++2l8rATJQQfZZ0KW5zYztHt
 v6dsIq59KPBXMBKV4Z7s8zPAINRCY82Njz15/bwRbuIspkW0/OIUeNp8VPyTvFuEXFQksDUH0pF
 bfgviLqxim7aL0Wwz1OXshEgEu0XPcReoW/VOFu9ZGOBbfyP4M26X9MDl7w7xBK+Mzn53XZUXr9
 GRdGqe9m1YrBHto0JKCA/0jLZKk+mTgkMVDzI2FjKTq1dvwAXRxIQmajGmm7e7A==
X-Google-Smtp-Source: AGHT+IE/lpWC3L326mcumtHN6vyXURbRXdUkndN5addPSnmRzF+u5bmOXW2cpf/pOsCYZmsfHy/KHw==
X-Received: by 2002:a17:903:2c06:b0:24b:4a9a:703a with SMTP id
 d9443c01a7336-29027373d80mr360058645ad.17.1760472446215; 
 Tue, 14 Oct 2025 13:07:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 10/37] target/arm: Handle MO_128 in arm_gdb_get_sysreg
Date: Tue, 14 Oct 2025 13:06:51 -0700
Message-ID: <20251014200718.422022-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Handle gdb reads of 128-bit system registers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8583057b58..f25bd50b71 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -247,15 +247,20 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
+        if (ri->vhe_redir_to_el2 &&
+            (arm_hcr_el2_eff(env) & HCR_E2H) &&
+            arm_current_el(env) == 2) {
+            ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
+        } else if (ri->vhe_redir_to_el01) {
+            ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el01);
+        }
         switch (cpreg_field_type(ri)) {
-        case MO_64:
-            if (ri->vhe_redir_to_el2 &&
-                (arm_hcr_el2_eff(env) & HCR_E2H) &&
-                arm_current_el(env) == 2) {
-                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
-            } else if (ri->vhe_redir_to_el01) {
-                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el01);
+        case MO_128:
+            {
+                Int128 v = read_raw_cp_reg128(env, ri);
+                return gdb_get_reg128(buf, int128_gethi(v), int128_getlo(v));
             }
+        case MO_64:
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
         case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
@@ -279,6 +284,7 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     RegisterSysregFeatureParam *param = p;
     ARMCPU *cpu = ARM_CPU(param->cs);
     CPUARMState *env = &cpu->env;
+    int bitsize, n;
 
     if (ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB)) {
         return;
@@ -297,10 +303,26 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
         }
     }
 
-    gdb_feature_builder_append_reg(&param->builder, ri->name,
-                                   8 << cpreg_field_type(ri),
-                                   param->n, "int", "cp_regs");
-    cpu->dyn_sysreg_feature.data.cpregs.keys[param->n++] = ri_key;
+    n = param->n++;
+    bitsize = 8 << cpreg_field_type(ri);
+    /*
+     * GDB generates an error for type="int" and bitsize=128.
+     * We need to use type="uint128" instead.
+     */
+    switch (bitsize) {
+    case 128:
+        gdb_feature_builder_append_reg(&param->builder, ri->name,
+                                       bitsize, n, "uint128", "cp_regs");
+        break;
+    case 64:
+    case 32:
+        gdb_feature_builder_append_reg(&param->builder, ri->name,
+                                       bitsize, n, "int", "cp_regs");
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    cpu->dyn_sysreg_feature.data.cpregs.keys[n] = ri_key;
 }
 
 static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
-- 
2.43.0


