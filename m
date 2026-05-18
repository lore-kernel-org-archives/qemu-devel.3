Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DDFCD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOy2D-0000gE-Kh; Mon, 18 May 2026 09:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elbeheri95@gmail.com>)
 id 1wOukE-0005oL-Pj
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:58:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elbeheri95@gmail.com>)
 id 1wOukC-0007nV-SO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 05:58:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so1954941f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 02:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779098318; x=1779703118; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lWnpI8K2Mvl9ynhlYEigGDky9pIVwx8nFFsIb5PVaXo=;
 b=aiIWOZ7zuRwXe22gm9oSz9pjQtGeu2h5bFStrp8hbqKIQ7l79UA+vI7xlbLdc6aK6A
 RFSjRP1iOwnkme1ywLdNm8CA50eWysdstozprgRndCZ9jtFtuTLns8vxUt7vVe5l8a54
 nUlwcs5pLtM304rlN/qcDRmGseLqVsBKx6khXZPDLVn0MZaC0O79sr4EmA1h6YAjeO36
 wlY8rdvoY9plltxoKGyKDEBVf6N0Vrqgbdu4/rS+mqqjDhoGWf5vRT3NWA98zXWap82b
 rXpNS2gN255oa8KFjYFwhfNZhk4hKrAWCIqYbsUlXz0QjnDaVwj/F7d+t9ypwn97uQNi
 943A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098318; x=1779703118;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWnpI8K2Mvl9ynhlYEigGDky9pIVwx8nFFsIb5PVaXo=;
 b=H+8zI7NoGt4h1rFmx2WfG3CSnamdXEEPtkdm9gnf+IV6SoBe2HTVNYxpwZ7ci7Vd90
 kExPiq2K++xFLX+xjg39qtQpLK8fMYUuZOTcOjgv4GKPV3LkWQmhBJwGGFb3ugtfEQGA
 YilwQVi7z8loh8he0GWcOiocuE+mozmDuVMgZCgFNth8dNo75omyPDoRsFky337l/CTQ
 HfsXHrhUXQ/8uGzpdm5yR9baVkgYsVWrn7qHbXx4ahmPmzs6FzQ6JUls6UHjStGgkbWa
 QIY3o/FsnNmrvPFNUmWEtnUbjRF4UZ40GGnDJOxn8XeKytX6eAdnakNxOpSS186EeSvn
 /uXw==
X-Gm-Message-State: AOJu0Ywx8DUK8kFC+m/5fpEHmR7I/+YtoEvA/fVNCxJ9MEBj1zacn6ZO
 oESSV3So51c+m9UJiKzy+S9c0ZMeljgIWeBOKZVEbKHBoScT/qr1CmuW
X-Gm-Gg: Acq92OEyTc9KxMbI4wNssfdmxt0Gurpj5Kqn+4VAZAx2s7JMCFhpn8q4NI8ujfr9cI/
 m7+Iqe13zl1P+3/1qXQf1BvQ/FAw7qZfHSLovt8UE3gkr10bN5zwQgwdJVVJl6ZKc9TafMG72l0
 0N/0rk1vutCwBC7IWGR7pVDfSndnwFClqQfnzqG4c2nVSzV9YB2EgIQtEMAItH9jJoSSdbRJqT6
 yqKXeAs/kiKLENq7cGGzOGnd5Q6pSZae1gVu4ARo+7Scj7xRgb3MLwowAghVnRsKD4P+S0h6e4W
 zzntZ9UkzMmrmwoYE6D2XjR9h49JqeF96CAdXUoa/I0TuquzHXPQkky8AU6oHnTBODXWi1WivvA
 cdszdBxleYmtsoxLeSUqsSiHh8xG/UsKQ1ySmQA7PHk6nb+8hrCafRtLNDnz3TcGAdjYam7GjRA
 YbD60eppg9dtcNwBQJmTuEgGZcGlpdHWgEzFAAmUfFy56n7O20EZFYLxFYCN9Q7uPvdA==
X-Received: by 2002:a05:6000:4011:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45e5c57d3b5mr21828633f8f.3.1779098317938; 
 Mon, 18 May 2026 02:58:37 -0700 (PDT)
Received: from [127.0.1.1] ([105.32.253.93]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe2464sm37566374f8f.32.2026.05.18.02.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:58:37 -0700 (PDT)
From: Abdelrahman Elbehery <elbeheri95@gmail.com>
Date: Mon, 18 May 2026 12:58:15 +0300
Subject: [PATCH] target/arm: replace cp_regs hashtable lookup with direct
 array index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-enhance_arm_gdb_get_sysreg_performance-v1-1-f0a5b22003c0@gmail.com>
X-B4-Tracking: v=1; b=H4sIALbiCmoC/x2N0QrCMBAEf6Xcs4EkxBr8FZGjNtuYh6blrohS+
 u9GH2cHdnZSSIHStdtJ8CpaltrAnToan0PNMCU1Jm99b88uGtQ2j+BBZs7pwRkb60cFmVfItMj
 80yb4GMMlBOtST+1sFUzl/Q/d7sfxBVbyI9J4AAAA
X-Change-ID: 20260518-enhance_arm_gdb_get_sysreg_performance-4288474401d6
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Abdelrahman Elbehery <elbeheri95@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6908; i=elbeheri95@gmail.com; 
 h=from:subject:message-id;
 bh=/wdbX57nyxVVoTtoLAbDqlJxwAOjWI4ITu9yT4WRpso=; 
 b=owGbwMvMwCUm/fee8JG43+sYT6slMWRxPTqTGmzxk3Od2P7QjfaeBWFRfMLrhLpWnF3i/Ov/b
 8akSW/rO0pZGMS4GGTFFFm+Jauyejmo7bE4dm8nzBxWJpAhDFycAjCR9tOMDOfE6hIMeAyM7x6S
 ar267GadN99lvqWCblt27mD4vff4z3JGhn2Cm7wXymsoXOR3uLQsa0l/UveKG2f8Poh+0+y0DDq
 /hR0A
X-Developer-Key: i=elbeheri95@gmail.com; a=openpgp;
 fpr=F66325054A4026BC38C6DEB91BFDDE13C45EFBAE
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=elbeheri95@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 18 May 2026 09:29:20 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Profiling showed g_hash_table_lookup as a hot spot when running TCG
plugins that log all CPU registers (e.g. execlog with reg=*).
Replace it with a direct array index to avoid lookup overhead.

Signed-off-by: Abdelrahman Elbehery <elbeheri95@gmail.com>
---
While profiling (via callgrind) a TCG plugin that logs all the CPU registers
(very identical to execlog with reg=*) i noticed that arm_gdb_get_sysreg is a hot spot,
mostly while calling g_hash_table_lookup. Probably this is due to some hashtable collision
that is handleded by glib internally.

Currently each DynamicGDBFeatureInfo item holds keys for cp_regs, and the keys are always
used to retrieve the ARMCPRegInfo pointer.

By replacing the keys array with a GPtrArray, we now just access reg info directly from
the given index.

The benchmarking was done on c2d-highcpu-16 (16 vCPUs, 32 GB memory) GCP

Setup was to run qemu-system-aarch64 against a buildroot kernel and rootfs
with and without the patch mostly using:
    --plugin contrib/plugins/libstoptrigger.so,icount=2000000
    --plugin contrib/plugins/libexeclog.so,reg=*
    -M virt -cpu cortex-a710 -smp 1

Benchmark showed ~15% performance gain when hashtable is not used.
For benchmarking, i used hyperfine with 3 warmup rounds and 10 iterations each.
---
 target/arm/cpu.h     |  6 +++---
 target/arm/gdbstub.c | 28 ++++++++++++++++------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 15a13b929276dad161032b61ba51ebbce7eeebc6..8816e94e3f8271ad403e77f6182fdb8cee31c527 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -121,15 +121,15 @@
  * DynamicGDBFeatureInfo:
  * @desc: Contains the feature descriptions.
  * @data: A union with data specific to the set of registers
- *    @cpregs_keys: Array that contains the corresponding Key of
- *                  a given cpreg with the same order of the cpreg
+ *    @cpregs_regs: Array that contains the corresponding Register info pointer
+ *                  of a given cpreg with the same order of the cpreg
  *                  in the XML description.
  */
 typedef struct DynamicGDBFeatureInfo {
     GDBFeature desc;
     union {
         struct {
-            uint32_t *keys;
+            GPtrArray *regs;
         } cpregs;
     } data;
 } DynamicGDBFeatureInfo;
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index d6e29c4cf46745dc7851bc5f8339c8d7c6857b8c..e66af8207b436fe8f1dd27441a587b1eb52ff928 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -238,19 +238,23 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
     const ARMCPRegInfo *ri;
-    uint32_t key;
 
-    key = cpu->dyn_sysreg_feature.data.cpregs.keys[reg];
-    ri = get_arm_cp_reginfo(cpu->cp_regs, key);
+    ri = g_ptr_array_index(cpu->dyn_sysreg_feature.data.cpregs.regs, reg);
     if (ri) {
         switch (cpreg_field_type(ri)) {
         case MO_64:
             if (ri->vhe_redir_to_el2 &&
                 (arm_hcr_el2_eff(env) & HCR_E2H) &&
                 arm_current_el(env) == 2) {
-                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
+                ri = g_ptr_array_index(
+                    cpu->dyn_sysreg_feature.data.cpregs.regs,
+                    ri->vhe_redir_to_el2
+                );
             } else if (ri->vhe_redir_to_el01) {
-                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el01);
+                ri = g_ptr_array_index(
+                    cpu->dyn_sysreg_feature.data.cpregs.regs,
+                    ri->vhe_redir_to_el01
+                );
             }
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
         case MO_32:
@@ -269,19 +273,18 @@ static int arm_gdb_set_sysreg(CPUState *cs, uint8_t *buf, int reg)
 
 static void arm_gen_one_feature_sysreg(GDBFeatureBuilder *builder,
                                        DynamicGDBFeatureInfo *dyn_feature,
-                                       ARMCPRegInfo *ri, uint32_t ri_key,
+                                       ARMCPRegInfo *ri,
                                        int bitsize, int n)
 {
     gdb_feature_builder_append_reg(builder, ri->name, bitsize, n,
                                    "int", "cp_regs");
 
-    dyn_feature->data.cpregs.keys[n] = ri_key;
+    g_ptr_array_index(dyn_feature->data.cpregs.regs, n) = ri;
 }
 
 static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
                                             gpointer p)
 {
-    uint32_t ri_key = (uintptr_t)key;
     ARMCPRegInfo *ri = value;
     RegisterSysregFeatureParam *param = p;
     ARMCPU *cpu = ARM_CPU(param->cs);
@@ -292,7 +295,7 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
                 arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                           ri, ri_key, 64, param->n++);
+                                           ri, 64, param->n++);
             }
         } else {
             if (ri->state == ARM_CP_STATE_AA32) {
@@ -302,10 +305,10 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
                 }
                 if (ri->type & ARM_CP_64BIT) {
                     arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                               ri, ri_key, 64, param->n++);
+                                               ri, 64, param->n++);
                 } else {
                     arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
-                                               ri, ri_key, 32, param->n++);
+                                               ri, 32, param->n++);
                 }
             }
         }
@@ -323,7 +326,8 @@ static GDBFeature *arm_gen_dynamic_sysreg_feature(CPUState *cs, int base_reg)
                              "org.qemu.gdb.arm.sys.regs",
                              "system-registers.xml",
                              base_reg);
-    cpu->dyn_sysreg_feature.data.cpregs.keys = g_new(uint32_t, num_regs);
+    cpu->dyn_sysreg_feature.data.cpregs.regs = g_ptr_array_new();
+    g_ptr_array_set_size(cpu->dyn_sysreg_feature.data.cpregs.regs, num_regs);
     g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_feature, &param);
     gdb_feature_builder_end(&param.builder);
     return &cpu->dyn_sysreg_feature.desc;

---
base-commit: ac6721b88df944ade0048822b2b74210f543d656
change-id: 20260518-enhance_arm_gdb_get_sysreg_performance-4288474401d6

Best regards,
-- 
Abdelrahman Elbehery <elbeheri95@gmail.com>


