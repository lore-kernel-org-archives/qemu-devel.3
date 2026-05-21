Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579C9CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7n6-0000H0-7E; Thu, 21 May 2026 14:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n0-0000G0-Ft
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:34 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7my-00024A-1I
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:34 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca00c1591so1858243a34.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386791; x=1779991591; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kmIEKhzDgkQkNcp3P+dm9kGl1W2xHcNBU4O9VF4nSws=;
 b=oNFrb+e9XqBKIMpTZD3f6vAqxmAw5LvNclkTyVElN3GUdBNKCae82K7iSlLBbUYQg7
 ku+7RTrRt89ByWid5mI1rDF9RmnNTSsU6qefI0DAVopmUfWBSnkLWwY0dswh2XJ9Pitj
 oq+/A0SSeCtC5JUKbt5kvhZS2rsd/a9E5ej75EDz92GrpP0eCunb9SIwRP0z00i133x5
 gFweS8p8xRPHXqSVzqRlqsrrbwtnurc43h/7CbonYQAIe1fRIidYhjt70FPHeTImqrhh
 SQ8mXnLvQuDMvP+OryYRNrgXsPcegcFC3boIGAXnR1C32CzgSZE9tWLzBSqS7j+GxJU1
 /cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386791; x=1779991591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kmIEKhzDgkQkNcp3P+dm9kGl1W2xHcNBU4O9VF4nSws=;
 b=ZY1AB/5nP0aU3dkU5aTF28YSs1W/h9TU+ZVfHkFjO31XWczTewB/HjaGoQCw6pwtcc
 qnGobsp1gEom9BTPQ95qbNJsRkhZsCcHksuSGHiy1kL131+dsqRaW9sfenJKet9OdZsS
 QowcvcBzl2zh1LCNGXW2h/0mbXj2d7K5ww/0Ws3xBZmfQy2CIoEdBFJ9fud4RkxSHLnn
 4HxzacllvBN+rpGZc5MBoWkcvifAM26c2WCopz0lfdOqALSG1jiVPNc8J+YgYTTh8nqe
 OtUwdtSF5x8MD2rVIxwpTJ0nhOtJWyOQG1CPf1pcxNrGjO/rAhvuTnJItgda3FAmXOkG
 GaXQ==
X-Gm-Message-State: AOJu0Yw8OGz09Gxrn+ONJXS+AykplrEdaJj1wHlxX7V+8mCr77tDg5w9
 3POPqT5TLhmBDINe7z3GQ4cc1J1IYuCvzEeOHG0H5laYJ7F/EQnB1CtK
X-Gm-Gg: Acq92OGVUVJTJGaomyK+K/lhFXWfwnruxJk93KbDutBN/hlrH5gfIz+0RNQntRGrX95
 RfX91MBJK+TkJ4ZSX5qUdow4AS+8u0D9bXhiY2FtIMfbnZtjldRuAwB0N7cFxv9J3OPCfViHmCe
 63js92kfIEFJtbcLzey7OGxitRKKV1bjA1c8V00D0vO3uKnWrbwbVr8SpP+N/TeZhZnjMfjBJ4J
 JS5XixSf7+0ZUZHM6oTyXjMH7Qi9PHPFMpvK3dEqQ08zOSBZgkEiT7JfFoDd4hgvpXQdhClrTk+
 vWpykZYdrY/LFm+yyoHeXu9XRbQhWVNPs5rNWQ9G+jbQBBghyvrnTy1jdGJeZrDB/KzLswZHLll
 cvJLZAnwDbqeoenrmHbrB1GJECgIkPwoqSmKl909APp/tBVvPjH9Z2wXh+UwCKfh1b+7FLo52lM
 2zat2JP9VxW9Rklpn2DDqPZFITxRgheXS4kenJTBhkQ7fx8UmV78UcD5FeMVmVxw28eh3EiB1rq
 Vyj0Bxv37IO2EeX8EZvG42Fd8nmnI4NgH/TCS40G65skNdry8IZA65NRTSYGcAyr3MU
X-Received: by 2002:a05:6830:828b:b0:7e3:d7d6:a4b7 with SMTP id
 46e09a7af769-7e5fee66317mr132417a34.3.1779386790763; 
 Thu, 21 May 2026 11:06:30 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:07 -0600
Subject: [PATCH v13 14/22] target/mips: add Octeon CHORD and LLM COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-14-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32e.google.com
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

Add the Octeon CHORD hardware register access path and the LLM 36-bit
and 64-bit read and write windows. Model both CHORD access forms,
including the RDHWR $30 path and the legacy DMFC2 alias.

Implement sparse backing storage for the two LLM sets so user-mode code
can save, restore, and probe the architectural state without allocating a
full hardware-sized backing array.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v10 -> v13:
  - Keep this patch limited to CHORD/LLM additions; existing crypto helpers
    and state fields stay in their original commit order.

Changes v8 -> v9:
  - Split CHORD and LLM helpers into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation LLM helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Rename sparse LLM backing fields from llm_narrow/llm_wide to
    llm36/llm64 to match the 36-bit and 64-bit selector windows.

Changes v1 -> v2:
  - Use neutral selector-slot wording for the LLM/CHORD alias comment.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/cpu.c               | 67 ++++++++++++++++++++++++++++++++++++
 target/mips/cpu.h               |  5 +++
 target/mips/helper.h            |  9 +++++
 target/mips/internal.h          |  3 ++
 target/mips/system/machine.c    | 67 ++++++++++++++++++++++++++++++++++++
 target/mips/tcg/octeon_crypto.c | 75 +++++++++++++++++++++++++++++++++++++++++
 target/mips/tcg/op_helper.c     |  6 ++++
 target/mips/tcg/translate.c     |  8 +++++
 8 files changed, 240 insertions(+)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index fccc7a711d..b223b767c9 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -26,6 +26,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/module.h"
+#include "qemu/qtree.h"
 #include "system/qtest.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
@@ -181,6 +182,57 @@ static bool mips_cpu_has_work(CPUState *cs)
 
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
@@ -192,6 +244,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 
+    mips_octeon_destroy_llm_state(&env->octeon_crypto);
     memset(env, 0, offsetof(CPUMIPSState, end_reset_fields));
 
     /* Reset registers to their default values */
@@ -246,6 +299,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->active_fpu.fcr31 = env->cpu_model->CP1_fcr31;
     env->msair = env->cpu_model->MSAIR;
     env->insn_flags = env->cpu_model->insn_flags;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->octeon_crypto.chord = 1;
+    }
 
 #if defined(CONFIG_USER_ONLY)
     env->CP0_Status = (MIPS_HFLAG_UM << CP0St_KSU);
@@ -262,6 +318,9 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      * hardware registers.
      */
     env->CP0_HWREna |= 0x0000000F;
+    if (env->insn_flags & INSN_OCTEON) {
+        env->CP0_HWREna |= 0x40000000u;
+    }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
     }
@@ -417,6 +476,13 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
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
@@ -645,6 +711,7 @@ static const TypeInfo mips_cpu_type_info = {
     .instance_size = sizeof(MIPSCPU),
     .instance_align = __alignof(MIPSCPU),
     .instance_init = mips_cpu_initfn,
+    .instance_finalize = mips_cpu_finalize,
     .abstract = true,
     .class_size = sizeof(MIPSCPUClass),
     .class_init = mips_cpu_class_init,
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 2dad7f538f..bc427adb97 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -11,6 +11,7 @@
 #include "fpu/softfloat-types.h"
 #include "hw/core/clock.h"
 #include "mips-defs.h"
+#include "qemu/qtree.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
 
@@ -554,6 +555,10 @@ typedef struct MIPSOcteonCryptoState {
     uint16_t gfm_poly;
     uint8_t aes_keylen;
     uint8_t crc_len;
+    uint64_t chord;
+    uint64_t llm_data[2];
+    QTree *llm36;
+    QTree *llm64;
 } MIPSOcteonCryptoState;
 
 typedef struct CPUArchState {
diff --git a/target/mips/helper.h b/target/mips/helper.h
index d18ade0094..c062863582 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -96,6 +96,14 @@ DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_read64_addr1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_llm_write64_addr1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
@@ -267,6 +275,7 @@ DEF_HELPER_1(rdhwr_cc, tl, env)
 DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
+DEF_HELPER_1(rdhwr_chord, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/internal.h b/target/mips/internal.h
index aab77b1b25..c5c286872e 100644
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
index 77f576a25b..bd1e4002cf 100644
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
@@ -301,6 +364,10 @@ static const VMStateDescription mips_vmstate_octeon_crypto = {
         VMSTATE_UINT16(env.octeon_crypto.gfm_poly, MIPSCPU),
         VMSTATE_UINT8(env.octeon_crypto.aes_keylen, MIPSCPU),
         VMSTATE_UINT8(env.octeon_crypto.crc_len, MIPSCPU),
+        VMSTATE_UINT64(env.octeon_crypto.chord, MIPSCPU),
+        VMSTATE_UINT64_ARRAY(env.octeon_crypto.llm_data, MIPSCPU, 2),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm36, MIPSCPU),
+        VMSTATE_OCTEON_LLM_TREE(env.octeon_crypto.llm64, MIPSCPU),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 92102636dd..77b4782f22 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -17,6 +17,41 @@
 #include "qemu/host-utils.h"
 
 #define OCTEON_SHA3_DAT15 15
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
 
 static inline uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
 {
@@ -2348,3 +2383,43 @@ void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
 
     octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
 }
+
+void helper_octeon_cp2_mt_llm_read_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr0(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 0, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_read_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_write_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, false);
+}
+
+void helper_octeon_cp2_mt_llm_read64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_read(&env->octeon_crypto, 1, value, true);
+}
+
+void helper_octeon_cp2_mt_llm_write64_addr1(CPUMIPSState *env, uint64_t value)
+{
+    octeon_llm_write(&env->octeon_crypto, 1, value, true);
+}
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 4502ae2b5b..3e586e3049 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -255,6 +255,12 @@ target_ulong helper_rdhwr_xnp(CPUMIPSState *env)
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
index 123d2c89c3..1f44932882 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10925,6 +10925,14 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
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


