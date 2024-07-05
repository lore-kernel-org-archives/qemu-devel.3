Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E3AC3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeVs-00026x-Dg; Fri, 05 Jul 2024 04:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVJ-0000Cj-Nn
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeVG-0003Jt-9R
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:17 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso1603682a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168872; x=1720773672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvX7+SgECJPhb0T5tWrIRbH04Gv0AGqro5YYirQFxyg=;
 b=L6MF1EHgBWcQcLw2SdqnhtDnOiqUi+b3NrurTwtiv25p7lVHijxk+nN/UlwBH5/lA9
 GvRalrmqHwVoMBwCUocuC/WUTh4PTSQeKB/rNHBbv0KPhLuHYIYmtSFKoktOE15bNmHU
 eRTDZotm6VfHxZJKhgE/+jLo2dFtDuLRfsFImHg4WvRqqoSFOS2TquncRVrcef4hsDhw
 CWvmUkPiM5x++8mI/kAV/UbOaV4nRTPpzRPHyEurhQAnXOLU7qa8168h17izwtIpCv9N
 Pb4obYFS1HS4+Af9G7ZyZRVTli8WM4OyMuKJKDMeYb5+5wHlYEZrzbXmLTLkUGM3/nwR
 pedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168872; x=1720773672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvX7+SgECJPhb0T5tWrIRbH04Gv0AGqro5YYirQFxyg=;
 b=Wsolt8YIvJr2dbun3BY+/bCqbdTTHY48YknOXVCu/iorOP7kTM4WtB8kL1dLvw3Xw/
 m7HCAa8Qi9mgWWnM2tjjIi+v/Lun2dSf0R61TtvezhwFC4LFdZPsTLZqKrhsB1hGWq+C
 OpWKbbXf0es5lbECRTKpwY1sx7HuZ71sz6E2idD2YANA8VS+UyWg9ldvKXtL5RyjAIsm
 HjSR0Ui6v9jlEylTGBMOUt+G8zk8hYorrm9mxN+T0lnRMnt/B6p1c9Po18WBV2cnL98x
 fDz/EWoDooV8QyTNMjXBXIqrxWXKNSesm9OdRLRzQtETQuny0Ckq174grNr9Sr9y/cty
 jCWQ==
X-Gm-Message-State: AOJu0YyD+jq4ug5PW/3dZBrKgv4n+pbIkXOkBTYmtAOO3xZUKwgtWf3g
 dVRMB7tnEjUi0hfGnbguDwlf0o7TRqViJYsuRx0MP61Qq3PkwQd1htlHDRmK2lg=
X-Google-Smtp-Source: AGHT+IFrpiaAN3+feRSdRsvnCvArcCwzJ1Q9bU/rUzThQ6cok8wKc04usnuqU91fT6rVmyhBE7/uwA==
X-Received: by 2002:a05:6402:909:b0:57d:1e27:65ea with SMTP id
 4fb4d7f45d1cf-58e5c824bc7mr3161580a12.34.1720168871463; 
 Fri, 05 Jul 2024 01:41:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58d75e20c30sm2718149a12.43.2024.07.05.01.41.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:41:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A4BE621B4;
 Fri,  5 Jul 2024 09:40:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH v2 39/40] gdbstub: Add support for MTE in user mode
Date: Fri,  5 Jul 2024 09:40:46 +0100
Message-Id: <20240705084047.857176-40-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

This commit implements the stubs to handle the qIsAddressTagged,
qMemTag, and QMemTag GDB packets, allowing all GDB 'memory-tag'
subcommands to work with QEMU gdbstub on aarch64 user mode. It also
implements the get/set functions for the special GDB MTE register
'tag_ctl', used to control the MTE fault type at runtime.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240628050850.536447-11-gustavo.romero@linaro.org>
---
 configs/targets/aarch64-linux-user.mak |   2 +-
 target/arm/internals.h                 |   6 +
 target/arm/cpu.c                       |   1 +
 target/arm/gdbstub.c                   |  46 +++++
 target/arm/gdbstub64.c                 | 223 +++++++++++++++++++++++++
 gdb-xml/aarch64-mte.xml                |  11 ++
 6 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 gdb-xml/aarch64-mte.xml

diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index ba8bc5fe3f..8f0ed21d76 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -1,6 +1,6 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml gdb-xml/aarch64-mte.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 11b5da2562..e1aa1a63b9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -358,6 +358,10 @@ void init_cpreg_list(ARMCPU *cpu);
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
+void arm_cpu_register_gdb_commands(ARMCPU *cpu);
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *, GArray *,
+                                       GArray *);
+
 void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data);
@@ -1640,6 +1644,8 @@ int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
 int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
 int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg);
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 35fa281f1b..14d4eca127 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2518,6 +2518,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
     register_cp_regs_for_features(cpu);
     arm_cpu_register_gdb_regs_for_features(cpu);
+    arm_cpu_register_gdb_commands(cpu);
 
     init_cpreg_list(cpu);
 
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index a3bb73cfa7..c3a9b5eb1e 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
+#include "gdbstub/commands.h"
 #include "sysemu/tcg.h"
 #include "internals.h"
 #include "cpu-features.h"
@@ -474,6 +475,41 @@ static GDBFeature *arm_gen_dynamic_m_secextreg_feature(CPUState *cs,
 #endif
 #endif /* CONFIG_TCG */
 
+void arm_cpu_register_gdb_commands(ARMCPU *cpu)
+{
+    GArray *query_table =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GArray *set_table =
+        g_array_new(FALSE, FALSE, sizeof(GdbCmdParseEntry));
+    GString *qsupported_features = g_string_new(NULL);
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+    #ifdef TARGET_AARCH64
+        aarch64_cpu_register_gdb_commands(cpu, qsupported_features, query_table,
+                                          set_table);
+    #endif
+    }
+
+    /* Set arch-specific handlers for 'q' commands. */
+    if (query_table->len) {
+        gdb_extend_query_table(&g_array_index(query_table,
+                                              GdbCmdParseEntry, 0),
+                                              query_table->len);
+    }
+
+    /* Set arch-specific handlers for 'Q' commands. */
+    if (set_table->len) {
+        gdb_extend_set_table(&g_array_index(set_table,
+                             GdbCmdParseEntry, 0),
+                             set_table->len);
+    }
+
+    /* Set arch-specific qSupported feature. */
+    if (qsupported_features->len) {
+        gdb_extend_qsupported_features(qsupported_features->str);
+    }
+}
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -507,6 +543,16 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
                                      gdb_find_static_feature("aarch64-pauth.xml"),
                                      0);
         }
+
+#ifdef CONFIG_USER_ONLY
+        /* Memory Tagging Extension (MTE) 'tag_ctl' pseudo-register. */
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            gdb_register_coprocessor(cs, aarch64_gdb_get_tag_ctl_reg,
+                                     aarch64_gdb_set_tag_ctl_reg,
+                                     gdb_find_static_feature("aarch64-mte.xml"),
+                                     0);
+        }
+#endif
 #endif
     } else {
         if (arm_feature(env, ARM_FEATURE_NEON)) {
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index caa31ff3fa..2e2bc2700b 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -21,6 +21,12 @@
 #include "cpu.h"
 #include "internals.h"
 #include "gdbstub/helpers.h"
+#include "gdbstub/commands.h"
+#include "tcg/mte_helper.h"
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#include <sys/prctl.h>
+#include "mte_user_helper.h"
+#endif
 
 int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
@@ -381,3 +387,220 @@ GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cs, int base_reg)
 
     return &cpu->dyn_svereg_feature.desc;
 }
+
+#ifdef CONFIG_USER_ONLY
+int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint64_t tcf0;
+
+    assert(reg == 0);
+
+    tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
+
+    return gdb_get_reg64(buf, tcf0);
+}
+
+int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    uint8_t tcf;
+
+    assert(reg == 0);
+
+    tcf = *buf << PR_MTE_TCF_SHIFT;
+
+    if (!tcf) {
+        return 0;
+    }
+
+    /*
+     * 'tag_ctl' register is actually a "pseudo-register" provided by GDB to
+     * expose options regarding the type of MTE fault that can be controlled at
+     * runtime.
+     */
+    arm_set_mte_tcf0(env, tcf);
+
+    return 1;
+}
+
+static void handle_q_memtag(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
+    uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
+    int type = gdb_get_cmd_param(params, 2)->val_ul;
+
+    uint8_t *tags;
+    uint8_t addr_tag;
+
+    g_autoptr(GString) str_buf = g_string_new(NULL);
+
+    /*
+     * GDB does not query multiple tags for a memory range on remote targets, so
+     * that's not supported either by gdbstub.
+     */
+    if (len != 1) {
+        gdb_put_packet("E02");
+    }
+
+    /* GDB never queries a tag different from an allocation tag (type 1). */
+    if (type != 1) {
+        gdb_put_packet("E03");
+    }
+
+    /* Note that tags are packed here (2 tags packed in one byte). */
+    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+                                    MMU_DATA_LOAD, true, 0);
+    if (!tags) {
+        /* Address is not in a tagged region. */
+        gdb_put_packet("E04");
+        return;
+    }
+
+    /* Unpack tag from byte. */
+    addr_tag = load_tag1(addr, tags);
+    g_string_printf(str_buf, "m%.2x", addr_tag);
+
+    gdb_put_packet(str_buf->str);
+}
+
+static void handle_q_isaddresstagged(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t addr = gdb_get_cmd_param(params, 0)->val_ull;
+
+    uint8_t *tags;
+    const char *reply;
+
+    tags = allocation_tag_mem_probe(env, 0, addr, MMU_DATA_LOAD, 8 /* 64-bit */,
+                                    MMU_DATA_LOAD, true, 0);
+    reply = tags ? "01" : "00";
+
+    gdb_put_packet(reply);
+}
+
+static void handle_Q_memtag(GArray *params, void *user_ctx)
+{
+    ARMCPU *cpu = ARM_CPU(user_ctx);
+    CPUARMState *env = &cpu->env;
+
+    uint64_t start_addr = gdb_get_cmd_param(params, 0)->val_ull;
+    uint64_t len = gdb_get_cmd_param(params, 1)->val_ul;
+    int type = gdb_get_cmd_param(params, 2)->val_ul;
+    char const *new_tags_str = gdb_get_cmd_param(params, 3)->data;
+
+    uint64_t end_addr;
+
+    int num_new_tags;
+    uint8_t *tags;
+
+    g_autoptr(GByteArray) new_tags = g_byte_array_new();
+
+    /*
+     * Only the allocation tag (i.e. type 1) can be set at the stub side.
+     */
+    if (type != 1) {
+        gdb_put_packet("E02");
+        return;
+    }
+
+    end_addr = start_addr + (len - 1); /* 'len' is always >= 1 */
+    /* Check if request's memory range does not cross page boundaries. */
+    if ((start_addr ^ end_addr) & TARGET_PAGE_MASK) {
+        gdb_put_packet("E03");
+        return;
+    }
+
+    /*
+     * Get all tags in the page starting from the tag of the start address.
+     * Note that there are two tags packed into a single byte here.
+     */
+    tags = allocation_tag_mem_probe(env, 0, start_addr, MMU_DATA_STORE,
+                                    8 /* 64-bit */, MMU_DATA_STORE, true, 0);
+    if (!tags) {
+        /* Address is not in a tagged region. */
+        gdb_put_packet("E04");
+        return;
+    }
+
+    /* Convert tags provided by GDB, 2 hex digits per tag. */
+    num_new_tags = strlen(new_tags_str) / 2;
+    gdb_hextomem(new_tags, new_tags_str, num_new_tags);
+
+    uint64_t address = start_addr;
+    int new_tag_index = 0;
+    while (address <= end_addr) {
+        uint8_t new_tag;
+        int packed_index;
+
+        /*
+         * Find packed tag index from unpacked tag index. There are two tags
+         * in one packed index (one tag per nibble).
+         */
+        packed_index = new_tag_index / 2;
+
+        new_tag = new_tags->data[new_tag_index % num_new_tags];
+        store_tag1(address, tags + packed_index, new_tag);
+
+        address += TAG_GRANULE;
+        new_tag_index++;
+    }
+
+    gdb_put_packet("OK");
+}
+
+enum Command {
+    qMemTags,
+    qIsAddressTagged,
+    QMemTags,
+    NUM_CMDS
+};
+
+static GdbCmdParseEntry cmd_handler_table[NUM_CMDS] = {
+    [qMemTags] = {
+        .handler = handle_q_memtag,
+        .cmd_startswith = true,
+        .cmd = "MemTags:",
+        .schema = "L,l:l0",
+        .need_cpu_context = true
+    },
+    [qIsAddressTagged] = {
+        .handler = handle_q_isaddresstagged,
+        .cmd_startswith = true,
+        .cmd = "IsAddressTagged:",
+        .schema = "L0",
+        .need_cpu_context = true
+    },
+    [QMemTags] = {
+        .handler = handle_Q_memtag,
+        .cmd_startswith = true,
+        .cmd = "MemTags:",
+        .schema = "L,l:l:s0",
+        .need_cpu_context = true
+    },
+};
+#endif /* CONFIG_USER_ONLY */
+
+void aarch64_cpu_register_gdb_commands(ARMCPU *cpu, GString *qsupported,
+                                       GArray *qtable, GArray *stable)
+{
+#ifdef CONFIG_USER_ONLY
+    /* MTE */
+    if (cpu_isar_feature(aa64_mte, cpu)) {
+        g_string_append(qsupported, ";memory-tagging+");
+
+        g_array_append_val(qtable, cmd_handler_table[qMemTags]);
+        g_array_append_val(qtable, cmd_handler_table[qIsAddressTagged]);
+
+        g_array_append_val(stable, cmd_handler_table[QMemTags]);
+    }
+#endif
+}
diff --git a/gdb-xml/aarch64-mte.xml b/gdb-xml/aarch64-mte.xml
new file mode 100644
index 0000000000..4b70b4f17a
--- /dev/null
+++ b/gdb-xml/aarch64-mte.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2021-2023 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.aarch64.mte">
+  <reg name="tag_ctl" bitsize="64" type="uint64" group="system" save-restore="no"/>
+</feature>
-- 
2.39.2


