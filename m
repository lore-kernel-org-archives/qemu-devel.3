Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C01C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 16:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb16r-0004cO-1M; Fri, 16 Feb 2024 11:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb16o-0004YU-B6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:30:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rb16e-0002AR-3u
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 11:30:42 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411a5b8765bso13421105e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 08:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708101029; x=1708705829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LdcVDf8Ux5HUL43SJs6bcSDbxjQQY72FOgDdjsf9tWM=;
 b=x6cSbXcxHKFyTf7w3bTy4M9azncNxYqcWzi5tLxrBqebDjXRg3GCve9XEsF0x0qqxp
 ARa52BnqRdhyOaPXtghCKzJiwD5zK1Kf+fdkAxzkKSEuQInR4X1kT3nqO6NfEXw4xtrI
 b6fJNar7z3duuMaFm9jxC6K7eCaha23vrRmz9cOg8KIPrcZwEeXJ/O9dmKKVRP1HQpxg
 ck/IXUv24oRVWLA0DpWDbblQy8+J1rz0F2N+BR06vqnVaKLR8b3ytbOEPAZsjlqYN6XM
 Dfvl3Nhidq2wLnqENfh99jQ/jTdFYQ2dkKepW0aBhHRNSsoAA/5Ry+jGW2NGDZjI5v87
 JIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708101029; x=1708705829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LdcVDf8Ux5HUL43SJs6bcSDbxjQQY72FOgDdjsf9tWM=;
 b=t4PUpyLZo1fFsfYqVqrWMOj5CByxqlrZSBGl3AD/Oqdah/WXrtXgW6T1u197qcdxsZ
 1NtL3wK2IhT3iU60HOrNF2i2YqAEeOM+llPPF54ys88RydUHgVh9jYOzZ/Rz5AfvjFB/
 XToN27ceDBXN95GujF534ieL5cOozMruQxHyWkRbRZ9UnqqxNXhxgQjgQimGNg2f3TXG
 SZp3qaeOHaU3SDlq1+US3pE+8ge3i7wPMmt3q7Lx5/t5Q+rhtN7heK4UwdUQsTT1odFJ
 0qPByAzx66abtWp++WuCcrtucyIZxXGpRhun3+v1yeGSeSZ0udjj1Eid3xaEV+EvIP8L
 rMeA==
X-Gm-Message-State: AOJu0YwWN+72MJMU5glP42kym/hmZLRFYRazJyze2me0pb+sRbCPM8FR
 EPv4GDXMyZn9pWdh+jAdtdjSyQnWSGwNTU2VOYb+WS9Fgrvb9E1EUaxhGQ7/jsM=
X-Google-Smtp-Source: AGHT+IHySOoIcYkHi/lL2dejM81P99Bsg38dTDYXlIB6YzrCLkEp2oanjxR76bC5xfXanF91JAnCug==
X-Received: by 2002:a05:600c:19c7:b0:412:5296:9737 with SMTP id
 u7-20020a05600c19c700b0041252969737mr1544501wmq.12.1708101029554; 
 Fri, 16 Feb 2024 08:30:29 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m4-20020a05600c280400b0040fe308ff25sm2716578wmb.24.2024.02.16.08.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 08:30:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D5E45F9D0;
 Fri, 16 Feb 2024 16:30:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Yanan Wang <wangyanan55@huawei.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 04/23] target/riscv: Use GDBFeature for dynamic XML
Date: Fri, 16 Feb 2024 16:30:06 +0000
Message-Id: <20240216163025.424857-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216163025.424857-1-alex.bennee@linaro.org>
References: <20240216163025.424857-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

In preparation for a change to use GDBFeature as a parameter of
gdb_register_coprocessor(), convert the internal representation of
dynamic feature from plain XML to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-29-alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-3-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/cpu.h     |  5 +--
 target/riscv/cpu.c     |  4 +--
 target/riscv/gdbstub.c | 81 +++++++++++++++++++-----------------------
 3 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f52dce78baa..5d291a70925 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,6 +24,7 @@
 #include "hw/registerfields.h"
 #include "hw/qdev-properties.h"
 #include "exec/cpu-defs.h"
+#include "exec/gdbstub.h"
 #include "qemu/cpu-float.h"
 #include "qom/object.h"
 #include "qemu/int128.h"
@@ -445,8 +446,8 @@ struct ArchCPU {
 
     CPURISCVState env;
 
-    char *dyn_csr_xml;
-    char *dyn_vreg_xml;
+    GDBFeature dyn_csr_feature;
+    GDBFeature dyn_vreg_feature;
 
     /* Configuration Settings */
     RISCVCPUConfig cfg;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b8d001d237..1b62e269b90 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2305,9 +2305,9 @@ static const char *riscv_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
     RISCVCPU *cpu = RISCV_CPU(cs);
 
     if (strcmp(xmlname, "riscv-csr.xml") == 0) {
-        return cpu->dyn_csr_xml;
+        return cpu->dyn_csr_feature.xml;
     } else if (strcmp(xmlname, "riscv-vector.xml") == 0) {
-        return cpu->dyn_vreg_xml;
+        return cpu->dyn_vreg_feature.xml;
     }
 
     return NULL;
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index ca9b71f7bbc..d8da84fa52e 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -214,14 +214,15 @@ static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
+static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
-    GString *s = g_string_new(NULL);
+    GDBFeatureBuilder builder;
     riscv_csr_predicate_fn predicate;
     int bitsize = riscv_cpu_max_xlen(mcc);
+    const char *name;
     int i;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -233,9 +234,9 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
         bitsize = 64;
     }
 
-    g_string_printf(s, "<?xml version=\"1.0\"?>");
-    g_string_append_printf(s, "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">");
-    g_string_append_printf(s, "<feature name=\"org.gnu.gdb.riscv.csr\">");
+    gdb_feature_builder_init(&builder, &cpu->dyn_csr_feature,
+                             "org.gnu.gdb.riscv.csr", "riscv-csr.xml",
+                             base_reg);
 
     for (i = 0; i < CSR_TABLE_SIZE; i++) {
         if (env->priv_ver < csr_ops[i].min_priv_ver) {
@@ -243,72 +244,64 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
         }
         predicate = csr_ops[i].predicate;
         if (predicate && (predicate(env, i) == RISCV_EXCP_NONE)) {
-            if (csr_ops[i].name) {
-                g_string_append_printf(s, "<reg name=\"%s\"", csr_ops[i].name);
-            } else {
-                g_string_append_printf(s, "<reg name=\"csr%03x\"", i);
+            g_autofree char *dynamic_name = NULL;
+            name = csr_ops[i].name;
+            if (!name) {
+                dynamic_name = g_strdup_printf("csr%03x", i);
+                name = dynamic_name;
             }
-            g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
-            g_string_append_printf(s, " regnum=\"%d\"/>", base_reg + i);
+
+            gdb_feature_builder_append_reg(&builder, name, bitsize, i,
+                                           "int", NULL);
         }
     }
 
-    g_string_append_printf(s, "</feature>");
-
-    cpu->dyn_csr_xml = g_string_free(s, false);
+    gdb_feature_builder_end(&builder);
 
 #if !defined(CONFIG_USER_ONLY)
     env->debugger = false;
 #endif
 
-    return CSR_TABLE_SIZE;
+    return &cpu->dyn_csr_feature;
 }
 
-static int ricsv_gen_dynamic_vector_xml(CPUState *cs, int base_reg)
+static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int base_reg)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
-    GString *s = g_string_new(NULL);
-    g_autoptr(GString) ts = g_string_new("");
-    int reg_width = cpu->cfg.vlenb << 3;
-    int num_regs = 0;
+    int reg_width = cpu->cfg.vlenb;
+    GDBFeatureBuilder builder;
     int i;
 
-    g_string_printf(s, "<?xml version=\"1.0\"?>");
-    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
-    g_string_append_printf(s, "<feature name=\"org.gnu.gdb.riscv.vector\">");
+    gdb_feature_builder_init(&builder, &cpu->dyn_vreg_feature,
+                             "org.gnu.gdb.riscv.vector", "riscv-vector.xml",
+                             base_reg);
 
     /* First define types and totals in a whole VL */
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
         int count = reg_width / vec_lanes[i].size;
-        g_string_printf(ts, "%s", vec_lanes[i].id);
-        g_string_append_printf(s,
-                               "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
-                               ts->str, vec_lanes[i].gdb_type, count);
+        gdb_feature_builder_append_tag(
+            &builder, "<vector id=\"%s\" type=\"%s\" count=\"%d\"/>",
+            vec_lanes[i].id, vec_lanes[i].gdb_type, count);
     }
 
     /* Define unions */
-    g_string_append_printf(s, "<union id=\"riscv_vector\">");
+    gdb_feature_builder_append_tag(&builder, "<union id=\"riscv_vector\">");
     for (i = 0; i < ARRAY_SIZE(vec_lanes); i++) {
-        g_string_append_printf(s, "<field name=\"%c\" type=\"%s\"/>",
-                               vec_lanes[i].suffix,
-                               vec_lanes[i].id);
+        gdb_feature_builder_append_tag(&builder,
+                                       "<field name=\"%c\" type=\"%s\"/>",
+                                       vec_lanes[i].suffix, vec_lanes[i].id);
     }
-    g_string_append(s, "</union>");
+    gdb_feature_builder_append_tag(&builder, "</union>");
 
     /* Define vector registers */
     for (i = 0; i < 32; i++) {
-        g_string_append_printf(s,
-                               "<reg name=\"v%d\" bitsize=\"%d\""
-                               " regnum=\"%d\" group=\"vector\""
-                               " type=\"riscv_vector\"/>",
-                               i, reg_width, base_reg++);
-        num_regs++;
+        gdb_feature_builder_append_reg(&builder, g_strdup_printf("v%d", i),
+                                       reg_width, i, "riscv_vector", "vector");
     }
 
-    g_string_append_printf(s, "</feature>");
+    gdb_feature_builder_end(&builder);
 
-    cpu->dyn_vreg_xml = g_string_free(s, false);
-    return num_regs;
+    return &cpu->dyn_vreg_feature;
 }
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
@@ -324,10 +317,9 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  32, "riscv-32bit-fpu.xml", 0);
     }
     if (env->misa_ext & RVV) {
-        int base_reg = cs->gdb_num_regs;
         gdb_register_coprocessor(cs, riscv_gdb_get_vector,
                                  riscv_gdb_set_vector,
-                                 ricsv_gen_dynamic_vector_xml(cs, base_reg),
+                                 ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs)->num_regs,
                                  "riscv-vector.xml", 0);
     }
     switch (mcc->misa_mxl_max) {
@@ -347,9 +339,8 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 
     if (cpu->cfg.ext_zicsr) {
-        int base_reg = cs->gdb_num_regs;
         gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                                 riscv_gen_dynamic_csr_xml(cs, base_reg),
+                                 riscv_gen_dynamic_csr_feature(cs, cs->gdb_num_regs)->num_regs,
                                  "riscv-csr.xml", 0);
     }
 }
-- 
2.39.2


