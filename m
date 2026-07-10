Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0586C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1Px-0008Dm-0Q; Thu, 09 Jul 2026 22:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pp-00086o-AD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:39 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1Pn-0008Pb-3B
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:36 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so454258a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652194; x=1784256994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+3sVn41qQP2uUAyxtwutz6qbxh5RBUmjSJBoY3fMVHU=;
 b=ghBM6XrnRvy27yjGPZEUUlws6NLo5WRz4rvDoKvGcR+n8hnoDORWuVsBzMSJzt8RKz
 yIUUu6EPvsRNuIMmdsqsRYF6Gjt/AAw4f+T8nF9X648WNOiGzyNAendHJL/MYEG/j6zw
 Hsa5VjmDl7ebhVabX2Goy98NuvdNgSkuTzTquoj0qBZvQ/2KpIUK3IJVrLSwlgqFASyx
 j94phy98FLU3oVoumY9fbINvA5SwA5XJv+LD0dL5rWDF5I8i7ogRxoDKO11YuDQIRFMs
 8OyM9Os7tFcQfAe++oFxblGD9H0GQyMBlKABey2AYNGiFsjNQngECeMppN2+mpnPVnGp
 OVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652194; x=1784256994;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+3sVn41qQP2uUAyxtwutz6qbxh5RBUmjSJBoY3fMVHU=;
 b=Llg3DiFm5rTsQp15MtvEcJvRVsG8ItWpDVoQaQkRE88AIXDp64U56uJgE27Keo9UJO
 brnffAx6IvfukqoQQxTJN7QJJZWe1gX3KbIhVwCH8hHh9JoLrp/KHjmT+xqPtyG75DmR
 v1Y/3RyM/NS2UP9UKSNJqHyJTMjVpetDTuUGcDVZrq67eXX5Q0GvOXhHYZQAa9Qs8FCo
 k5W32YiCtrwvDLUHGpzZ+kCYs/ZYUelOuTqYW2lH5PFfmcIYIhDQghhb1LZ88DmatU3e
 n5UfkjaR5tEOeuPw79jTIMYBVajblm1MuYuqVu+27Zm7+m08dAGcH942LkO5gyQzgvir
 UEVw==
X-Gm-Message-State: AOJu0YyR4mGFPW4VmxZZRDLYqEEturlXjiDm31N+Jnznwb655RhtFH8F
 +1Gs2+hj2bRrhNh5iaWjFF2JNJAfD0Luc5pkCj5TesGKdXQQyZ+1T6tNWQzLsw==
X-Gm-Gg: AfdE7cmWzjzUGcEsyuUjur9GrGXtoz5YM/ZENVndCrP2rSj3L2DOVXj4j7UIjnwGkPW
 DsOhKSj1TWBy1cO8faJEfDbCwDJGD7FtV0O8PhMevd9tMjjVFRmARFQy5XMMkvGq+g3y8GlVktd
 kWcFOrdJfspAcqXjJi1IYA41nWkT6iB0xsqaYyJQyGB5/HnM48gbFzk9Qyc3UqSnQzgLFH//ppw
 isMA1QgDAIZfvVetcO0cwKIKtE7iqwWXFPD0U2h+xNyxk6G6KMW9fzfMvDLDS0Ctj2kmTGFcotd
 lLvTn5M459HfPNLtUO+p+m7v9qNA4+qQXGQSf2amGutwyg/xGyMg49y8sEqnmO4a+b0dXfl78X4
 5ZNaJ5yF0FSsghGzdn4PZjzgxSGMxj7rvgb5XNGtPIi+OyR93sA0KBaKxvc47w6Sj0SXt0w1QaZ
 Hw80WkXWUqBuGgz/S7PBhY8xHgEybGg8M=
X-Received: by 2002:a05:6a20:3d0c:b0:3b4:93b9:2b91 with SMTP id
 adf61e73a8af0-3c0bcf16364mr11525816637.12.1783652193450; 
 Thu, 09 Jul 2026 19:56:33 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:32 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/40] target/riscv: move custom_csrs logic to tcg-cpu.c
Date: Fri, 10 Jul 2026 12:55:02 +1000
Message-ID: <20260710025525.1704417-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We have a couple of CPUs that has a set of custom CSRs that uses TCG
specific APIs.  Move the related code to tcg-cpu.c and do not set
.custom_csrs if we're not in a TCG build.

What we'll end up doing, sooner or later, is punting all these CPUs to
tcg-cpu.c since they're all TCG specific and KVM has nothing to do with
them.  Another time.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260703180538.3346781-12-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  2 ++
 target/riscv/cpu.c         | 26 +++++---------------------
 target/riscv/tcg/tcg-cpu.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index a8c7e21bec..82430ecec6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -591,7 +591,9 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     const RISCVCSR *custom_csrs;
+#endif
     /* This is just a setter for env->num_triggers.  */
     uint32_t num_triggers;
 } RISCVCPUDef;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c5b03847bf..bbce58ee58 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -544,19 +544,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
-#ifndef CONFIG_USER_ONLY
-static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
-{
-    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
-        int csrno = csr_list[i].csrno;
-        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
-        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
-            riscv_set_csr_ops(csrno, csr_ops);
-        }
-    }
-}
-#endif
-
 /* Used by csr.c and the KVM driver */
 target_ulong riscv_new_csr_seed(target_ulong new_value,
                                 target_ulong write_mask)
@@ -1268,11 +1255,6 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
         cpu->env.vext_ver = mcc->def->vext_spec;
     }
-#ifndef CONFIG_USER_ONLY
-    if (mcc->def->custom_csrs) {
-        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
-    }
-#endif
 
     accel_cpu_instance_init(CPU(obj));
 }
@@ -2846,10 +2828,12 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         if (def->custom_csrs) {
             assert(!mcc->def->custom_csrs);
             mcc->def->custom_csrs = def->custom_csrs;
         }
+#endif
     }
 
     if (!object_class_is_abstract(c)) {
@@ -3202,7 +3186,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.mvendorid = THEAD_VENDOR_ID,
 
         .cfg.max_satp_mode = VM_1_10_SV39,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3248,7 +3232,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         .cfg.marchid = 0x8d143000,
         .cfg.mvendorid = THEAD_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = th_csr_list,
 #endif
     ),
@@ -3454,7 +3438,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_xmipscmov = true,
         .cfg.marchid = 0x8000000000000201,
         .cfg.mvendorid = MIPS_VENDOR_ID,
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
         .custom_csrs = mips_csr_list,
 #endif
     ),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fe6350f497..fef66557c2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -38,6 +38,7 @@
 #include "system/tcg.h"
 #include "exec/icount.h"
 #include "target/riscv/tcg/debug.h"
+#include "target/riscv/tcg/csr.h"
 #endif
 
 /* Hash that stores user set extensions */
@@ -1650,10 +1651,30 @@ static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
     return object_dynamic_cast(cpu_obj, TYPE_RISCV_CPU_MAX) != NULL;
 }
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
+{
+    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
+        int csrno = csr_list[i].csrno;
+        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
+        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
+#endif
+
 static void riscv_tcg_cpu_instance_init(CPUState *cs)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     Object *obj = OBJECT(cpu);
+#ifndef CONFIG_USER_ONLY
+    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
+
+    if (mcc->def->custom_csrs) {
+        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
+    }
+#endif
 
     misa_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
     multi_ext_user_opts = g_hash_table_new(NULL, g_direct_equal);
-- 
2.54.0


