Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106BACD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVI8-0005V4-Jm; Mon, 11 May 2026 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHs-0004vn-Dl
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:29 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHn-0002vX-V5
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:27 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479e4835e26so2728430b6e.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523802; x=1779128602; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SF46Ie01DLslR/zPpTrDVLJ05rXRIvlLY6V2tFlAdCY=;
 b=PqZFDQ7gf1D4kAqNCJpJmtn138h603q6VdwV5QDTd9c49WUr3KTe8fjKBDE3ek/bJB
 vbGq8FtBjI+4dP7JhrBlxR7jqufTzeroepv0YCoPiuBDhxc9jxw/GcuoiddY9TzGQxdw
 SNn+nWjwu86N2TCjbjStfrr7+qC1sMWEWf5TZ2MQxdvuV5we2fwLROo4p9TZmrlpQJNh
 v1gPaqX0EO+0rYvo5WPJTWExSHbFQSxB2WWNxXqopfbKtCGbUpqwW9vN01A80uF8VoQL
 /0xOOob+6w92tb77YYBXo+S7KzKchPsk9QO+1Bl4P45+NueYcKCMJq9iWc6Ri4bHb/jm
 CTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523802; x=1779128602;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SF46Ie01DLslR/zPpTrDVLJ05rXRIvlLY6V2tFlAdCY=;
 b=qqOrfFe459Vqz1cKMAclxSftcxVhOb0gKxIwr56YWASi1Vr1hXIj5g3FBeBfEBGmQL
 3oM0GKLaEWOW2hWgPqI8lElTkCMh1Kj4EI12dEtasTydKhiKsRzZBZxZcOr+GMrTzYTr
 PJd52AtBPEPJ1w0tVpgRgAxCDd3P5L7bGvcatBE9Nmr0biMJv5ZbZGb3UdPbLjJorpS9
 jMsyrz5sXila7UVDqM323BVwn3Uutng5ACsYqsBRTsT8QK6kUCdos3dkirKTzdZ0Whhq
 keraPFw8vywTOJQwnu35KocwZFSkctWGB8LapPVsdh9PSscA9x8Wuemr0jToeNnHch+I
 tyJA==
X-Gm-Message-State: AOJu0YwzeB4vABPYrseEWPHEW5hifdVWcjbwzC5R9n+nLRtB+SNLq/1s
 Vznh1zROyIC8gtjMy8PXz3m971LauNjsoVz1zcU3DElSuRtKe+oU68SK
X-Gm-Gg: Acq92OHYeWzeDxg4TmiZsnBXCOIsWIG69GkCIGfwrZ5tR/fv+pqIiix7hN3Ge413UeT
 rZRykX8ARBWhPM782zuRPxrDbFO98Ho55MF9VyB7T7UweNq1FfyQ7cIR91DES9Qi7BFlcDvLPab
 vV4FQPwfdfYMdWfqMfCk0mYb7XdpvUVIvKiXpRXQo4ZIiw8RXmhqeASYQVBOjpYix1b4B3CAkNR
 Tmb7ebJ2A4dqAwxeT7OGW4Q9o5/p1J9KnqqHNBHn/NbyX2EVGQfTQIrMb9+b/15rbotjkkedxef
 k0C28KsOTzDvl1D3lI7pv2Jfh2z88vtUnnQbuGWG47mYUfXDhUKmlOhe2SO0DUSuAHzq+xjq6C1
 /8shkMXFDesHuiFiHGsQlJBuhUct6DhKGs99GeXc4GYxUKtkEp59QepfGd4Vn64uwsm6spajp8s
 KJprUHDWjNEEErJFhfgIzDyADTFUXE75H/KfWKAl6/TeY5NCjUJnF4159AU8DGSRjROrTRn6VoI
 E5svhwqWOeYEq25vjwCEC4npptzlxxzdBsIqS71U+Kt6Zo+ZbF+edNAwPFM5PWpiB8k
X-Received: by 2002:a05:6808:302b:b0:47b:d07b:ec96 with SMTP id
 5614622812f47-4804252ae05mr13856474b6e.40.1778523801915; 
 Mon, 11 May 2026 11:23:21 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:21 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:23:03 -0600
Subject: [PATCH v6 32/35] target/mips: add Octeon CHORD and LLM COP2
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-32-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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

Add the Octeon CHORD hardware register access path and the LLM
36-bit and 64-bit read and write windows.

Model both CHORD access forms, including the rdhwr $30 path and the
legacy dmfc2 alias, and implement sparse backing storage for the two LLM
sets so user-mode code can save, restore, and probe the architectural
state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Use neutral selector-slot wording for the LLM/CHORD alias comment.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)

Changes v5 -> v6:
  - Rename sparse LLM backing fields from llm_narrow/llm_wide to
    llm36/llm64 to match the 36-bit and 64-bit selector windows.
---
 target/mips/cpu.c                  | 67 +++++++++++++++++++++++++++++++++++
 target/mips/cpu.h                  | 20 +++++++++++
 target/mips/helper.h               |  1 +
 target/mips/internal.h             |  3 ++
 target/mips/system/machine.c       | 67 +++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_crypto.c    | 72 ++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_translate.c | 13 +++++++
 target/mips/tcg/op_helper.c        |  6 ++++
 target/mips/tcg/translate.c        |  8 +++++
 9 files changed, 257 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 6e827c72de..9bf9b67202 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -27,6 +27,7 @@
 #include "internal.h"
 #include "kvm_mips.h"
 #include "qemu/module.h"
+#include "qemu/qtree.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
@@ -183,6 +184,57 @@ static bool mips_cpu_has_work(CPUState *cs)
 
 #include "cpu-defs.c.inc"
 
+static gint mips_octeon_u64_tree_compare(gconstpointer a, gconstpointer b,
+                                         gpointer user_data)
+{
+    uint64_t av = *(const uint64_t *)a;
+    uint64_t bv = *(const uint64_t *)b;
+
+    return (av > bv) - (av < bv);
+}
+
+QTree *mips_octeon_llm_tree_new(void)
+{
+    return q_tree_new_full(mips_octeon_u64_tree_compare,
+                           NULL, g_free, g_free);
+}
+
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr)
+{
+    uint64_t key = addr;
+    uint64_t *value = tree ? q_tree_lookup(tree, &key) : NULL;
+
+    return value ? *value : 0;
+}
+
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value)
+{
+    uint64_t *key;
+    uint64_t *stored;
+
+    if (!*treep) {
+        *treep = mips_octeon_llm_tree_new();
+    }
+
+    key = g_new(uint64_t, 1);
+    stored = g_new(uint64_t, 1);
+    *key = addr;
+    *stored = value;
+    q_tree_replace(*treep, key, stored);
+}
+
+static void mips_octeon_destroy_llm_state(MIPSOcteonCryptoState *crypto)
+{
+    if (crypto->llm36) {
+        q_tree_destroy(crypto->llm36);
+        crypto->llm36 = NULL;
+    }
+    if (crypto->llm64) {
+        q_tree_destroy(crypto->llm64);
+        crypto->llm64 = NULL;
+    }
+}
+
 static void mips_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
@@ -194,6 +246,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 
+    mips_octeon_destroy_llm_state(&env->octeon_crypto);
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
     /* Reset registers to their default values */
@@ -248,6 +301,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->octeon_crypto.chord = 1;
+    }
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -264,6 +320,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      * hardware registers.
      */
     env->CP0_HWREna |= 0x0000000F;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->CP0_HWREna |= 0x40000000u;
+    }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
     }
@@ -422,6 +481,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
+static void mips_cpu_finalize(Object *obj)
+{
+    MIPSCPU *cpu = MIPS_CPU(obj);
+
+    mips_octeon_destroy_llm_state(&cpu->env.octeon_crypto);
+}
+
 static void mips_cpu_disas_set_info(const CPUState *cs, disassemble_info *info)
 {
     const MIPSCPU *cpu = MIPS_CPU(cs);
@@ -648,6 +714,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index ba886735d5..b1974c367f 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -617,6 +618,21 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
     OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
     OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
+    /*
+     * Selector 0x0400 is the 36-bit LLM read selector and is also used as a
+     * DMFC2 alias for the CHORD POW tag-switch completion bit.
+     */
+    OCTEON_COP2_SEL_LLM_READ_ADDR0 = 0x0400,
+    OCTEON_COP2_SEL_CHORD = OCTEON_COP2_SEL_LLM_READ_ADDR0,
+    OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0 = 0x0401,
+    OCTEON_COP2_SEL_LLM_DATA0 = 0x0402,
+    OCTEON_COP2_SEL_LLM_READ64_ADDR0 = 0x0404,
+    OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0 = 0x0405,
+    OCTEON_COP2_SEL_LLM_READ_ADDR1 = 0x0408,
+    OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1 = 0x0409,
+    OCTEON_COP2_SEL_LLM_DATA1 = 0x040a,
+    OCTEON_COP2_SEL_LLM_READ64_ADDR1 = 0x040c,
+    OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1 = 0x040d,
     OCTEON_COP2_SEL_CRC_POLYNOMIAL = 0x0200,
     OCTEON_COP2_SEL_CRC_IV = 0x0201,
     OCTEON_COP2_SEL_CRC_LEN = 0x0202,
@@ -754,6 +770,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t zuc_lfsr[16];
     uint32_t zuc_window[3];
     uint32_t zuc_tresult;
+    uint64_t llm_data[2];
+    uint64_t chord;
+    QTree *llm36;
+    QTree *llm64;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 52fe18a8f8..410a9b8090 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -202,6 +202,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 23e1ada185..026dc0ea4f 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -93,6 +93,9 @@ extern const int mips_defs_number;
 
 int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+QTree *mips_octeon_llm_tree_new(void);
+uint64_t mips_octeon_llm_load(QTree *tree, uint64_t addr);
+void mips_octeon_llm_store(QTree **treep, uint64_t addr, uint64_t value);
 
 #define USEG_LIMIT      ((target_ulong)(int32_t)0x7FFFFFFFUL)
 #define KSEG0_BASE      ((target_ulong)(int32_t)0x80000000UL)
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 9bcb066245..1ec05f0600 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -131,6 +131,69 @@ static const VMStateDescription vmstate_octeon_multiplier_tc = {
     }
 };
 
+typedef struct OcteonLLMTreePutData {
+    QEMUFile *f;
+} OcteonLLMTreePutData;
+
+static gboolean put_octeon_llm_tree_entry(gpointer key, gpointer value,
+                                          gpointer user_data)
+{
+    OcteonLLMTreePutData *data = user_data;
+
+    qemu_put_be64(data->f, *(uint64_t *)key);
+    qemu_put_be64(data->f, *(uint64_t *)value);
+    return false;
+}
+
+static int put_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc)
+{
+    QTree *tree = *(QTree **)pv;
+    OcteonLLMTreePutData data = { .f = f };
+    uint32_t nnodes = tree ? q_tree_nnodes(tree) : 0;
+
+    qemu_put_be32(f, nnodes);
+    if (tree) {
+        q_tree_foreach(tree, put_octeon_llm_tree_entry, &data);
+    }
+
+    return 0;
+}
+
+static int get_octeon_llm_tree(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field)
+{
+    QTree **treep = pv;
+    uint32_t nnodes = qemu_get_be32(f);
+
+    if (*treep) {
+        q_tree_destroy(*treep);
+    }
+    *treep = mips_octeon_llm_tree_new();
+
+    for (uint32_t i = 0; i < nnodes; i++) {
+        uint64_t addr = qemu_get_be64(f);
+        uint64_t value = qemu_get_be64(f);
+
+        mips_octeon_llm_store(treep, addr, value);
+    }
+
+    return 0;
+}
+
+static const VMStateInfo vmstate_info_octeon_llm_tree = {
+    .name = "octeon_llm_tree",
+    .get = get_octeon_llm_tree,
+    .put = put_octeon_llm_tree,
+};
+
+#define VMSTATE_OCTEON_LLM_TREE(_f, _s) {                         \
+    .name = stringify(_f),                                        \
+    .version_id = 1,                                              \
+    .info = &vmstate_info_octeon_llm_tree,                        \
+    .offset = vmstate_offset_pointer(_s, _f, QTree),              \
+}
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -316,6 +379,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_lfsr, MIPSCPU, 16),
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_window, MIPSCPU, 3),
         VMSTATE_UINT32(env.octeon_crypto.zuc_tresult, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm36, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm64, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 27e34b7f43..b845bdff07 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -16,6 +16,42 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 
+#define OCTEON_LLM_NARROW_MASK ((1ULL << 36) - 1)
+
+static uint64_t octeon_llm_pack_narrow(uint64_t value)
+{
+    value &= OCTEON_LLM_NARROW_MASK;
+    return value | ((uint64_t)(ctpop64(value) & 1) << 36);
+}
+
+static void octeon_llm_read(MIPSOcteonCryptoState *crypto, unsigned int set,
+                            uint64_t addr, bool wide)
+{
+    uint64_t value;
+
+    if (wide) {
+        value = mips_octeon_llm_load(crypto->llm64, addr);
+    } else {
+        value = octeon_llm_pack_narrow(
+            mips_octeon_llm_load(crypto->llm36, addr));
+    }
+
+    crypto->llm_data[set] = value;
+}
+
+static void octeon_llm_write(MIPSOcteonCryptoState *crypto, unsigned int set,
+                             uint64_t addr, bool wide)
+{
+    uint64_t value = crypto->llm_data[set];
+
+    if (wide) {
+        mips_octeon_llm_store(&crypto->llm64, addr, value);
+    } else {
+        mips_octeon_llm_store(&crypto->llm36, addr,
+                              value & OCTEON_LLM_NARROW_MASK);
+    }
+}
+
 static inline void octeon_set_shared_mode(MIPSOcteonCryptoState *crypto,
                                           MIPSOcteonSharedMode mode)
 {
@@ -2001,6 +2037,12 @@ uint64_t helper_octeon_cop2_dmfc2(CPUMIPSState *env, uint32_t sel)
         return crypto->crc_len;
     case OCTEON_COP2_SEL_CRC_IV_REFLECT:
         return octeon_crc_reflect32_by_byte(crypto->crc_iv);
+    case OCTEON_COP2_SEL_CHORD:
+        return crypto->chord;
+    case OCTEON_COP2_SEL_LLM_DATA0:
+        return crypto->llm_data[0];
+    case OCTEON_COP2_SEL_LLM_DATA1:
+        return crypto->llm_data[1];
     case OCTEON_COP2_SEL_HSH_DATW0:
     case OCTEON_COP2_SEL_HSH_DATW1:
     case OCTEON_COP2_SEL_HSH_DATW2:
@@ -2157,6 +2199,36 @@ void helper_octeon_cop2_dmtc2(CPUMIPSState *env, uint64_t value,
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
         crypto->aes_keylen = data;
         break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR0:
+        octeon_llm_read(crypto, 0, data, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, data, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA0:
+        crypto->llm_data[0] = data;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR0:
+        octeon_llm_read(crypto, 0, data, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, data, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR1:
+        octeon_llm_read(crypto, 1, data, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, data, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA1:
+        crypto->llm_data[1] = data;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR1:
+        octeon_llm_read(crypto, 1, data, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, data, true);
+        break;
     case OCTEON_COP2_SEL_CAMELLIA_FL:
         octeon_camellia_fl_layer(crypto, data, false);
         break;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ad8a38f927..b10886b199 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -78,6 +78,9 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_GFM_RESINP0:
     case OCTEON_COP2_SEL_GFM_RESINP1:
     case OCTEON_COP2_SEL_GFM_POLY:
+    case OCTEON_COP2_SEL_CHORD:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_DATA1:
         return true;
     default:
         return false;
@@ -113,6 +116,16 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
     case OCTEON_COP2_SEL_AES_KEYLENGTH:
     case OCTEON_COP2_SEL_CAMELLIA_FL:
     case OCTEON_COP2_SEL_CAMELLIA_FLINV:
+    case OCTEON_COP2_SEL_LLM_READ_ADDR0:
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR0:
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0:
+    case OCTEON_COP2_SEL_LLM_READ_ADDR1:
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1:
+    case OCTEON_COP2_SEL_LLM_DATA1:
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR1:
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1:
     case OCTEON_COP2_SEL_CRC_WRITE_POLYNOMIAL:
     case OCTEON_COP2_SEL_CRC_IV:
     case OCTEON_COP2_SEL_CRC_WRITE_LEN:
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 0a892e31a8..67854f08df 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -412,6 +412,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
     return (env->CP0_Config5 >> CP0C5_XNP) & 1;
 }
 
+target_ulong helper_rdhwr_chord(CPUMIPSState *env)
+{
+    check_hwrena(env, 30, GETPC());
+    return env->octeon_crypto.chord;
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 767d64718a..3e39f3460a 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10923,6 +10923,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         }
         break;
 #endif
+    case 30:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        gen_helper_rdhwr_chord(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);

-- 
2.54.0


