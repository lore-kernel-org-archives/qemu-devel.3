Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0B606B74D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gyXrEZdR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8w2-0003QF-UG; Thu, 19 Nov 2026 15:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v7-0003B1-8W
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:53 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007IW-9O
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:48 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1Q0E3595248
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XeA+MHJPwbG
 CI5x48+len4cjrkLeW9r3ihdyS0XYQs0=; b=gyXrEZdR/0toCanpEDkPfdIA1KP
 MhlYrDWrEf16Xkcu8AKhSmsMfTTVRkxcYkbtL3/D+Fa89ZSWFmXXEJU9VTufa6PX
 u2nnr1srOwl2LIJiuq9/HrpQkwBk5VX2ofrZz7LI+RwgxU6q20nNaYfg+Tq/nQ4f
 30M1y/isSeE5hpZkrL9v1iRtYoaT4S2kTyY9Iw0p2MFqJtgLgSsfffJbTrCGm+xa
 03+JRPLnHyDP7eoOCjPesEM7fPHxtnJt20qCgqmxApcEZk8vhgZ5IrHfDz6PFf6Q
 aPkmvLrD5LuhjNAIPtweEZV2ADCBOR130uNaZGWtLuhB7Fi2qFstdZJ9l2g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j255wh6a0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgvd3570598; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AJKdfO13570567
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 996342578E; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 10/13] target/hexagon: prioritize packet alignment in the
 fault path
Date: Thu, 19 Nov 2026 12:39:38 -0800
Message-ID: <20261119203941.899748-11-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX3cRpGG8beb0Q
 lGiYq5YsJ9zorw0y09GfT+dI4O9eUERODOMemjAvCcADpqO2anZ/qY8N0hjGDv/mJZadQsSf0lW
 0B/GNZSQgJ3RoAF19gBVlLaBK/GDnTA=
X-Proofpoint-GUID: hxSaMUVfiGFfuQkIZ7BFJ-_H69Pcrtbv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX9WlLNT/3QEH3
 r4wYV/3UIgt517mo7i8qkVpNvK9xlB+/k+pGUVoufqD/Zma0emfLSitkFTqJYulUCgJxaSikMkT
 Hb8WwomRX1Hx0gyBeSKK6iAoNG6pdxc5qD/GfCNkzxTUKNbDkkZyPyBcXmrPkPmK0k7CWuUsCO7
 clpK1swH2fF5S+c/HyJ6YB/WNsSWv1BWcsibhmOexdn9HX1XNpwS+Jt+FKWYVesxhhKJwA4wh7D
 LM+1F74+Uu/T14PXzxWsn0Tc0TRGMG5AXV+iFCNj6f0Jx7hwLBFynCNksj6p4nChTcUkKn18f/S
 fsIv6HWPLxMPgvpmxS0UJbs4uECa5V+7CUvXHOxZ4PQWkKpjSlJZ8mfgwqb2dlYAZHaEkRiFBAh
 oeyExrLTjSUiCnHjTCuu2OO0NoCdI+7IpHBT9XpC8j3VBYZCzVFCWRT//XMYEJZbHOY0ka349NG
 +g/fKsyiIUjsTZC2khg==
X-Authority-Analysis: v=2.4 cv=da0VTnXe c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=aDDlNDSNT8dN0QXSkRAA:9
X-Proofpoint-ORIG-GUID: hxSaMUVfiGFfuQkIZ7BFJ-_H69Pcrtbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Use MO_ALIGN for normal scalar memory accesses. On a memory fault,
check the recorded active addresses for alignment before reporting a
translation fault. Give slot 1 priority when both accesses are unaligned.

Keep constant access widths and types in insn_start unwind metadata so
the precedence checks add no runtime metadata stores or packet-wide TCG
alignment checks. Retain per-access checks in commit probes to prevent
partial stores.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c            | 47 +++++++++++++++++++++++++++++++++
 target/hexagon/cpu.h            |  6 +++++
 target/hexagon/gen_tcg_funcs.py |  2 +-
 target/hexagon/genptr.c         | 10 ++++++-
 target/hexagon/genptr.h         |  2 +-
 target/hexagon/internal.h       |  5 ++++
 target/hexagon/op_helper.c      |  2 ++
 target/hexagon/translate.c      |  1 +
 target/hexagon/translate.h      |  1 +
 9 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 5ebe67d024..1eb0fc588c 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -30,6 +30,7 @@
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "accel/tcg/cpu-ops.h"
+#include "accel/tcg/cpu-loop.h"
 #include "cpu_helper.h"
 #include "hex_mmu.h"
 
@@ -835,6 +836,45 @@ static void raise_misaligned_exception(CPUState *cs, uint32_t VA, int slot,
     env->cause_code = excp;
 }
 
+static void check_packet_alignment(CPUHexagonState *env, uintptr_t retaddr)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t data[INSN_START_WORDS];
+
+    if (!env->mem_access_valid || !retaddr ||
+        !cpu_unwind_state_data(cs, retaddr, data)) {
+        return;
+    }
+
+    /* Alignment wins over translation faults; slot 1 wins over slot 0. */
+    for (int slot = 1; slot >= 0; slot--) {
+        unsigned info = data[1] >> (slot * HEX_SCALAR_MEM_ACCESS_BITS);
+        unsigned width = info & HEX_SCALAR_MEM_SIZE_MASK;
+        uint32_t va = env->mem_access_va[slot];
+
+        if ((env->mem_access_valid & (1U << slot)) && width &&
+            (va & (width - 1))) {
+            raise_misaligned_exception(cs, va, slot,
+                                      info & HEX_SCALAR_MEM_STORE ?
+                                      MMU_DATA_STORE : MMU_DATA_LOAD);
+            do_raise_exception(env, cs->exception_index, data[0], retaddr);
+        }
+    }
+}
+
+void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
+                             unsigned size, int slot,
+                             MMUAccessType access_type, uintptr_t retaddr)
+{
+    if (va & (size - 1)) {
+        CPUState *cs = env_cpu(env);
+        check_packet_alignment(env, retaddr);
+        raise_misaligned_exception(cs, va, slot, access_type);
+        do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
+                           retaddr);
+    }
+}
+
 static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
                                            "MMU_INST_FETCH" };
 
@@ -870,6 +910,9 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
         if (probe) {
             return false;
         }
+        if (access_type != MMU_INST_FETCH) {
+            check_packet_alignment(env, retaddr);
+        }
         raise_perm_exception(cs, address, slot, access_type, excp);
         do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
                            retaddr);
@@ -877,6 +920,9 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
     if (probe) {
         return false;
     }
+    if (access_type != MMU_INST_FETCH) {
+        check_packet_alignment(env, retaddr);
+    }
     raise_tlbmiss_exception(cs, address, slot, access_type);
     do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
 }
@@ -928,6 +974,7 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 {
     CPUHexagonState *env = cpu_env(cs);
 
+    check_packet_alignment(env, retaddr);
     raise_misaligned_exception(cs, addr, env->mem_slot, access_type);
     do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
                        retaddr);
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 915da339a0..f177a56148 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -231,6 +231,12 @@ typedef struct CPUArchState {
     HmxState *hmx_state;
 } CPUHexagonState;
 
+#ifndef CONFIG_USER_ONLY
+void hexagon_check_alignment(CPUHexagonState *env, uint32_t va,
+                             unsigned size, int slot,
+                             MMUAccessType access_type, uintptr_t retaddr);
+#endif
+
 typedef struct HexagonCPUClass {
     CPUClass parent_class;
 
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index f67056049e..4f89be8449 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -185,7 +185,7 @@ def gen_memory_address(f, tag, regs, imms):
         cond = "NE" if pred.group(2) else "EQ"
         f.write(f"    tcg_gen_brcondi_tl(TCG_COND_{cond}, LSB, 0, skip);\n")
     f.write(f"    {ea};\n")
-    f.write("    gen_log_mem_address(ctx, EA);\n")
+    f.write(f"    gen_log_mem_address(ctx, EA, {width});\n")
     if pred:
         f.write("    gen_set_label(skip);\n")
     f.write("}\n#endif\n\n")
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index e270a41b8d..339f43b7ae 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -24,6 +24,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
 #include "insn.h"
+#include "attribs.h"
 #include "opcodes.h"
 #include "sys_macros.h"
 #include "translate.h"
@@ -1723,12 +1724,18 @@ static void vec_to_qvec(size_t size, TCGv_ptr dstbase, intptr_t dstoff,
 }
 
 #ifndef CONFIG_USER_ONLY
-void gen_log_mem_address(DisasContext *ctx, TCGv va)
+void gen_log_mem_address(DisasContext *ctx, TCGv va, unsigned width)
 {
     unsigned slot = ctx->insn->slot;
+    unsigned info = width;
     TCGv valid = tcg_temp_new();
 
     tcg_debug_assert(slot < 2);
+    if (GET_ATTRIB(ctx->insn->opcode, A_STORE)) {
+        info |= HEX_SCALAR_MEM_STORE;
+    }
+    ctx->scalar_mem_info |= info << (slot * HEX_SCALAR_MEM_ACCESS_BITS);
+    tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->scalar_mem_info);
     tcg_gen_st_i32(va, tcg_env,
                    offsetof(CPUHexagonState, mem_access_va[slot]));
     tcg_gen_ld_i32(valid, tcg_env,
@@ -1737,6 +1744,7 @@ void gen_log_mem_address(DisasContext *ctx, TCGv va)
     tcg_gen_st_i32(valid, tcg_env,
                    offsetof(CPUHexagonState, mem_access_valid));
 }
+
 #endif
 
 void probe_noshuf_load(TCGv va, int s, int mi)
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
index 99dff75973..c104ef65c2 100644
--- a/target/hexagon/genptr.h
+++ b/target/hexagon/genptr.h
@@ -25,7 +25,7 @@
 extern const SemanticInsn opcode_genptr[];
 #ifndef CONFIG_USER_ONLY
 extern const SemanticInsn opcode_address[];
-void gen_log_mem_address(DisasContext *ctx, TCGv va);
+void gen_log_mem_address(DisasContext *ctx, TCGv va, unsigned width);
 #endif
 
 void gen_store32(TCGv vaddr, TCGv src, uint32_t width, uint32_t slot);
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 6def331a83..d00c288ad2 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -20,6 +20,11 @@
 
 #include "target/hexagon/cpu.h"
 
+/* Per-slot scalar access fields in the second insn_start unwind word. */
+#define HEX_SCALAR_MEM_ACCESS_BITS 5
+#define HEX_SCALAR_MEM_SIZE_MASK 0xf
+#define HEX_SCALAR_MEM_STORE (1U << 4)
+
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index f22353302b..354b9a2c91 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -466,6 +466,7 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
                     env->mem_log_stores[1].width, mmu_idx, retaddr);
     }
     env->mem_slot = 0;
+    hexagon_check_alignment(env, va, size, 0, MMU_DATA_LOAD, retaddr);
 #endif
     probe_read(env, va, size, mmu_idx, retaddr);
 }
@@ -564,6 +565,7 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
 #ifndef CONFIG_USER_ONLY
         probe_store(env, 1, MMU_USER_IDX, false, ra);
         env->mem_slot = 0;
+        hexagon_check_alignment(env, vaddr, size, 0, MMU_DATA_LOAD, ra);
 #endif
         probe_read(env, vaddr, size, MMU_USER_IDX, ra);
         commit_store(env, 1, ra);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 163b22bc75..83b1ecd898 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -816,6 +816,7 @@ static void gen_start_packet(DisasContext *ctx)
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
     ctx->mem_addresses_generated = false;
 #ifndef CONFIG_USER_ONLY
+    ctx->scalar_mem_info = 0;
     for (i = 0; i < HEX_SREG_GLB_START; i++) {
         ctx->t_sreg_new_value[i] = NULL;
     }
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index 55d95fd3ab..1b6c326052 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -46,6 +46,7 @@ typedef struct DisasContext {
     bool implicit_usr_write;
 #ifndef CONFIG_USER_ONLY
     uint32_t cpu_mode;
+    uint32_t scalar_mem_info;
     bool ss_active;
     int greg_log[GREG_WRITES_MAX];
     int greg_log_idx;
-- 
2.43.0


