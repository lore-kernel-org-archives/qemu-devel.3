Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59C2F327D4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFEtR-000432-Ew; Tue, 21 Apr 2026 13:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEtB-0003nV-Tv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:59 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wFEt6-0006iV-HE
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 13:27:56 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-40427db1300so3548943fac.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792471; x=1777397271; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DcO28109DGAtSGWJEOODDDT7/DgWjTQwYneNmi0yLWk=;
 b=n1tSLFzqpsWtUML8nxKYSH3oiWF1chZdThs3+73xo6JST1yj8ncRVASUm4nXhxRubp
 RO5VhSbS7jjvgPIGEZFb2GM7uRUozzI3+tDrqTFJxcmJb2epIR5X8RWtE7reVRYEaZJw
 dFKC1OlY3v7qSfuf8NT7eQOZr4rXVWiTrkB8HL8ySf/ga4TGYQoEmvE0oBbg1Qu8MBT8
 sZ373/3oLQgGjJ59CpLC2/wxpZ4LTn/dnbhhuQfZ8H6rzBqBYBtHt6aBJD7O54ZKijUs
 liHv1/Laollu6Rxre3FslddEWMeoHIrzomz44EM/9cIU8gTPmDJmG0AAMggryWIhhgRm
 Ijdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792471; x=1777397271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DcO28109DGAtSGWJEOODDDT7/DgWjTQwYneNmi0yLWk=;
 b=YK8J7aO2ZpxFAecXNj1y+0RJP7xmqngyhBuFPrA5hhcca1uBvXENXsDapdmJAasaPG
 s3k6Jk3+xhAtJfytscU3PNbxsRebQHTW+OlC8RLptz0cqnNOX6tpayLTaJqdrkxpy8G0
 MgaC/M/NTLP7hQNRBn7h5M5DzK7IKb/VPL2aD4g29Wddhm97vHB/cRckxsKfp/xQ/Tbf
 qbYTI0l5g1ahPASr9cnfUcLzhwgDNZ1wcFlGk5Vxekzr2pMHdTMleTuVu1FRjUbkkNwg
 Rwq57cWR8v0IcJL7VJZbF972NAKQ0GeWd6HdzfKMjO4Aer0YvoZXBdPcunDoMSJOQKBq
 AEJw==
X-Gm-Message-State: AOJu0Yy5uu8h+jocxA6LoS8ODLTeJycxtcHvjDgPlqnrakq2XlfwZjvx
 7q6jzbkCCT3Ox1uU4ZXL+VDMLnXUmvn6pha3+lzDVAqj5ilJ0aUUtrUy
X-Gm-Gg: AeBDietr/wXLEiKwPR1jrBe6I64oOVHGfbQZjeb50aijUPcwItSxE1fanMz0WS77rvT
 Y4p9M1Fbf/yW2M9xV9D/Fw0ypcydTdQpEveyv0xTLYP2wXiO2Wl+HOoMluxlqtB4CPfzuWPwXDM
 XaT3I2UOFADdKsIpV8fu+vvfDfEShM4hvBI6Nh6Vugb7+r2sz6TEaViZsxRPjgaKzCD7xuUUJhZ
 VgrZNp3aAVwRI8shi/RvRgcfAr/2AVY3t7kb4KfZEXhH+Etd6S4Qp9HrjpsEt09gP4HO+Rg3q+r
 9h71U859eapyd9o6u42HWGuQXiXeh7Yz5H+Il6fxTvm1BjKWsNtuLPK/f2tUg4JT3NHuWceDseC
 5RO6X5inKIX44nX4pFm15pKpPg3prD2xL/sZ5O4DDVF3AwyW72QvfP5YilDN7aa6g/3mVqJVPfH
 vA5OCPnNKeBjd/9HOkT+OEPpOZk9m6OQQS7xO2zD+2cZbU+DnPyK/urvCasIGF5KWeTNKhK5WIJ
 3l/2MUgvBHMFuunp9R84s79hFtXBP1dhkdHz8zHHC65SfF3zVeP1g6PJIewl147s/eQ0uLzBV8b
 SzhwQBiHOdfK2iFF
X-Received: by 2002:a05:6870:3047:b0:41c:c200:bfe0 with SMTP id
 586e51a60fabf-42abf2f8179mr10305104fac.15.1776792470540; 
 Tue, 21 Apr 2026 10:27:50 -0700 (PDT)
Received: from mac.localdomain (97-118-149-104.hlrn.qwest.net.
 [97.118.149.104]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b8fe2c52bsm12209290fac.0.2026.04.21.10.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:27:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 21 Apr 2026 11:27:39 -0600
Subject: [PATCH v2 12/13] target/mips: add Octeon CHORD and LLM COP2
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-mips-octeon-missing-insns-v2-v2-12-a0791df188c9@gmail.com>
References: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
In-Reply-To: <20260421-mips-octeon-missing-insns-v2-v2-0-a0791df188c9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x29.google.com
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
narrow/wide read and write windows.

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
index ec70c10985..ebcb814360 100644
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
+    if (crypto->llm_narrow) {
+        q_tree_destroy(crypto->llm_narrow);
+        crypto->llm_narrow = NULL;
+    }
+    if (crypto->llm_wide) {
+        q_tree_destroy(crypto->llm_wide);
+        crypto->llm_wide = NULL;
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
@@ -636,6 +702,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 8411ef7de4..e4ccb5e1c7 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -609,6 +610,21 @@ typedef enum MIPSOcteonCop2Sel {
     OCTEON_COP2_SEL_SMS4_ENC0 = OCTEON_COP2_SEL_AES_ENC0,
     OCTEON_COP2_SEL_SMS4_DEC_CBC0 = OCTEON_COP2_SEL_AES_DEC_CBC0,
     OCTEON_COP2_SEL_SMS4_DEC0 = OCTEON_COP2_SEL_AES_DEC0,
+    /*
+     * Selector 0x0400 is the narrow LLM read selector and is also used as a
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
@@ -746,6 +762,10 @@ typedef struct MIPSOcteonCryptoState {
     uint32_t zuc_lfsr[16];
     uint32_t zuc_window[3];
     uint32_t zuc_tresult;
+    uint64_t llm_data[2];
+    uint64_t chord;
+    QTree *llm_narrow;
+    QTree *llm_wide;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 899120d0ca..dad91d7451 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -200,6 +200,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index 28eb28936b..b40e65864a 100644
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
index 1176d879eb..1ec94680af 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -129,6 +129,69 @@ static const VMStateDescription vmstate_octeon_multiplier_tc = {
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
@@ -306,6 +369,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_lfsr, MIPSCPU, 16),
         VMSTATE_UINT32_ARRAY(env.octeon_crypto.zuc_window, MIPSCPU, 3),
         VMSTATE_UINT32(env.octeon_crypto.zuc_tresult, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm_narrow, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm_wide, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 9c5f19f41d..3369993fc9 100644
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
+        value = mips_octeon_llm_load(crypto->llm_wide, addr);
+    } else {
+        value = octeon_llm_pack_narrow(
+            mips_octeon_llm_load(crypto->llm_narrow, addr));
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
+        mips_octeon_llm_store(&crypto->llm_wide, addr, value);
+    } else {
+        mips_octeon_llm_store(&crypto->llm_narrow, addr,
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
         crypto->aes_keylen = q;
         break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR0:
+        octeon_llm_read(crypto, 0, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA0:
+        crypto->llm_data[0] = q;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR0:
+        octeon_llm_read(crypto, 0, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL0:
+        octeon_llm_write(crypto, 0, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_READ_ADDR1:
+        octeon_llm_read(crypto, 1, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, q, false);
+        break;
+    case OCTEON_COP2_SEL_LLM_DATA1:
+        crypto->llm_data[1] = q;
+        break;
+    case OCTEON_COP2_SEL_LLM_READ64_ADDR1:
+        octeon_llm_read(crypto, 1, q, true);
+        break;
+    case OCTEON_COP2_SEL_LLM_WRITE64_ADDR_INTERNAL1:
+        octeon_llm_write(crypto, 1, q, true);
+        break;
     case OCTEON_COP2_SEL_CAMELLIA_FL:
         octeon_camellia_fl_layer(crypto, q, false);
         break;
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 004b937412..d9c5d7ab83 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -82,6 +82,9 @@ static bool octeon_cop2_is_supported_dmfc2(uint16_t sel)
     case OCTEON_COP2_SEL_GFM_RESINP0:
     case OCTEON_COP2_SEL_GFM_RESINP1:
     case OCTEON_COP2_SEL_GFM_POLY:
+    case OCTEON_COP2_SEL_CHORD:
+    case OCTEON_COP2_SEL_LLM_DATA0:
+    case OCTEON_COP2_SEL_LLM_DATA1:
         return true;
     default:
         return false;
@@ -117,6 +120,16 @@ static bool octeon_cop2_is_supported_dmtc2(uint16_t sel)
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
index 47b13a583c..d73ec80af0 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -354,6 +354,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
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
index ca9cee7ed6..183ae940ff 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10920,6 +10920,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
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
2.53.0


