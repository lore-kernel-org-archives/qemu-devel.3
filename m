Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5430606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NyBgN58G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTbYt-0008KH-GV; Wed, 18 Nov 2026 04:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYh-0008G5-Pl; Wed, 18 Nov 2026 04:02:27 -0500
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xTbYc-00042K-42; Wed, 18 Nov 2026 04:02:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794992519; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=zwmTj/RrGDC4hJstDrXF4lWrvPbUyb5kwAi9xLRE+/o=;
 b=NyBgN58Gl/S8EfUfKrcd7lqmbWa0n1kMWyBWOws50NGbyNfV9tOeuaBJUWIkPEK6j520QyrTz8f/eMYYSeD/cg4VZWRHBK9rPYlLO26ldg9jjcHqUqBTZZhe7l1iWJyYorTol5daxZe85ZpIhHwg/K/lP7ihY0OpU6HwyT6X4ow=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XF0GqiU_1794992517; 
Received: from
 riscv-project-v011122129236.ea134.tbsite.net(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF0GqiU_1794992517 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 18 Nov 2026 17:01:58 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Wed, 18 Nov 2026 17:01:33 +0800
Subject: [PATCH RFC 6/8] target/riscv: Fetch 48-bit and 64-bit instructions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-zl-master-v1-6-129f85e0f887@linux.alibaba.com>
References: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
In-Reply-To: <20261118-zl-master-v1-0-129f85e0f887@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794992514; l=8064;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=dgNNi/AxEfDMDs61yp/J0K1XFRfOSGAWZ5Uhm6hTxeY=;
 b=fDJ7vsiK8SSl0kvhLZn+X1TsAEtgiXR6Mpsb3786YfVBCAJ2a/aG3HeOP+iPRzsYk988VJ28M
 lcVSZ2Q7XHLBevRzFn0OPeWoK4IgaxX/lVHv8p75v83aKLpXnh4rCkW
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Preserve the existing aligned word fetch and halfword fetch sequence.
When Zl is enabled, use parcels A and C to determine the instruction
length and fetch parcel D only for 64-bit encodings.

Keep the complete encoding in ctx->opcode so gen_exception_illegal()
can report it through env->bins.

For an undefined length, stop after parcel C and set env->bins to zero.
This implementation reports no instruction bits rather than fetching
additional parcels solely for trap reporting.

Stop translation near page ends before a subsequent instruction could
require another page.

Link: https://github.com/riscv/riscv-long-instruction/blob/65c377a665feb29a4848384ad566a9873c5fd423/src/unpriv/zl.adoc

Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/internals.h     |  7 ++++
 target/riscv/tcg/translate.c | 97 ++++++++++++++++++++++++++++++++------------
 2 files changed, 79 insertions(+), 25 deletions(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 4e11888b03e0dcb050426892e1758d733273bf99..ddd5ca65adc99d9538c98f4ce28c3c723a967824 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -185,6 +185,13 @@ static inline float16 check_nanbox_bf16(CPURISCVState *env, uint64_t f)
     }
 }
 
+/* Long encodings must already include parcel C. */
+static inline bool riscv_zl_insn_has_undefined_length(uint64_t opcode)
+{
+    return riscv_insn_is_long(opcode) &&
+           riscv_zl_insn_length(opcode >> 32) == 0;
+}
+
 static inline target_ulong get_xepc_mask(CPURISCVState *env)
 {
     RISCVCPU *cpu = env_archcpu(env);
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 51024ee9a37df548ec27587c9b4bb240afd1d5a5..b301c41d3341dce777422a9c70a407818d3407bd 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -30,6 +30,7 @@
 #include "semihosting/semihost.h"
 
 #include "internals.h"
+#include "insn_length.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -64,7 +65,7 @@ typedef struct DisasContext {
     RISCVMXL xl;
     RISCVMXL address_xl;
     uint32_t misa_ext;
-    uint32_t opcode;
+    uint64_t opcode;
     RISCVExtStatus mstatus_fs;
     RISCVExtStatus mstatus_vs;
     uint32_t mem_idx;
@@ -265,7 +266,11 @@ static void generate_exception(DisasContext *ctx, RISCVException excp)
 
 static void gen_exception_illegal(DisasContext *ctx)
 {
-    tcg_gen_st_i64(tcg_constant_i64(ctx->opcode), tcg_env,
+    uint64_t bits = ctx->cfg_ptr->ext_zl &&
+        riscv_zl_insn_has_undefined_length(ctx->opcode) ? 0 : ctx->opcode;
+
+    /* Undefined lengths have no complete instruction to report. */
+    tcg_gen_st_i64(tcg_constant_i64(bits), tcg_env,
                    offsetof(CPURISCVState, bins));
     if (ctx->virt_inst_excp) {
         generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
@@ -1240,8 +1245,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
 
-/* The specification allows for longer insns, but not supported by qemu. */
-#define MAX_INSN_LEN  4
+#define MAX_INSN_LEN  8
 
 const RISCVDecoder decoder_table[] = {
     { always_true_p, decode_insn32 },
@@ -1254,12 +1258,11 @@ const RISCVDecoder decoder_table[] = {
 
 const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
 
-static void decode_opc(CPURISCVState *env, DisasContext *ctx)
+static bool fetch_insn(CPURISCVState *env, DisasContext *ctx)
 {
-    uint32_t opcode;
+    uint64_t opcode;
     bool pc_is_4byte_align = ((ctx->base.pc_next % 4) == 0);
 
-    ctx->virt_inst_excp = false;
     if (pc_is_4byte_align) {
         /*
          * Load 4 bytes at once to make instruction fetch atomically.
@@ -1276,42 +1279,82 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx)
          * For unaligned pc, instruction preload may trigger additional
          * page fault so we only load 2 bytes here.
          */
-        opcode = (uint32_t) translator_lduw_end(env, &ctx->base,
-                                                ctx->base.pc_next,
-                                                MO_LE);
+        opcode = translator_lduw_end(env, &ctx->base, ctx->base.pc_next, MO_LE);
     }
-    ctx->ol = ctx->xl;
 
     ctx->cur_insn_len = insn_len((uint16_t)opcode);
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
         ctx->opcode = (uint16_t)opcode;
+        return true;
+    }
+
+    if (!pc_is_4byte_align) {
+        /* Load last 2 bytes of instruction here */
+        opcode = deposit64(opcode, 16, 16,
+                           translator_lduw_end(env, &ctx->base,
+                                               ctx->base.pc_next + 2, MO_LE));
+    }
+    ctx->opcode = opcode;
+
+    if (ctx->cfg_ptr->ext_zl && riscv_insn_is_long(opcode)) {
+        uint16_t third_parcel =
+            translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 4, MO_LE);
+        unsigned len = riscv_zl_insn_length(third_parcel);
+
+        ctx->opcode = deposit64(ctx->opcode, 32, 16, third_parcel);
+        if (len == 8) {
+            uint16_t fourth_parcel =
+                translator_lduw_end(env, &ctx->base, ctx->base.pc_next + 6,
+                                    MO_LE);
+
+            ctx->opcode = deposit64(ctx->opcode, 48, 16, fourth_parcel);
+        }
+        /* An undefined length stops fetching after three parcels. */
+        ctx->cur_insn_len = len ? len : 6;
+        return len != 0;
+    }
+    return true;
+}
+
+static void decode_opc(CPURISCVState *env, DisasContext *ctx)
+{
+    bool valid_length;
+
+    ctx->virt_inst_excp = false;
+    ctx->ol = ctx->xl;
+    valid_length = fetch_insn(env, ctx);
+    if (!valid_length) {
+        goto illegal;
+    }
+
+    switch (ctx->cur_insn_len) {
+    case 2:
         /*
          * The Zca extension is added as way to refer to instructions in the C
-         * extension that do not include the floating-point loads and stores
+         * extension that do not include the floating-point loads and stores.
          */
         if ((has_ext(ctx, RVC) || ctx->cfg_ptr->ext_zca) &&
-            decode_insn16(ctx, opcode)) {
+            decode_insn16(ctx, (uint16_t)ctx->opcode)) {
             return;
         }
-    } else {
-        if (!pc_is_4byte_align) {
-            /* Load last 2 bytes of instruction here */
-            opcode = deposit32(opcode, 16, 16,
-                               translator_lduw_end(env, &ctx->base,
-                                                   ctx->base.pc_next + 2,
-                                                   MO_LE));
-        }
-        ctx->opcode = opcode;
-
+        break;
+    case 4:
         for (guint i = 0; i < ctx->decoders->len; ++i) {
             riscv_cpu_decode_fn func = g_ptr_array_index(ctx->decoders, i);
-            if (func(ctx, opcode)) {
+            if (func(ctx, (uint32_t)ctx->opcode)) {
                 return;
             }
         }
+        break;
+    case 6:
+    case 8:
+        break;
+    default:
+        g_assert_not_reached();
     }
 
+illegal:
     gen_exception_illegal(ctx);
 }
 
@@ -1419,7 +1462,11 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
 
-            if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
+            if (ctx->cfg_ptr->ext_zl) {
+                if (page_ofs > TARGET_PAGE_SIZE - MAX_INSN_LEN) {
+                    ctx->base.is_jmp = DISAS_TOO_MANY;
+                }
+            } else if (page_ofs > TARGET_PAGE_SIZE - 4) {
                 uint16_t next_insn =
                     translator_lduw_end(env, &ctx->base, ctx->base.pc_next,
                                         MO_LE);

-- 
2.43.0


