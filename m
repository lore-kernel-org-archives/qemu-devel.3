Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB606A93B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RqNbFzdf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8ve-0003Mn-MT; Thu, 19 Nov 2026 15:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v7-0003B2-8S
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:53 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007It-9P
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:48 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1KNn3655666
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sJbkU6RkldJ
 b8/sxSgpi48gbpiNdinIrZynp3hs/mfI=; b=RqNbFzdf//t2HBQH1kD6EkqovtI
 7knwlkzJOx0/8LeaPZDWexfV4IDaiJZBkFK5zWp4bQQie28hrm2OVYaGO68OdgIQ
 RNdolAQy0gVqtRZx3p2O/9cU/msNPVIUGyQUI3SAu28mHstCz+iv7Y6YnlnaNTzO
 12wNZcPmVWGvEzsLBp4YwVBnZnUovW2C3OV6JTr6N5+CiXTLDXxarkzMJKlGtHOu
 NSAcQfxmcrkkTosnrUVn8z7Rxk0iS8Wci81jT0scLRLh/8qEK8zvmcWnlYsKzD2u
 v/ywMDdaIaeh8ihdiE5YjIAPxFDDqm17WLnBve0rN85+V25f97KL633G4UQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j20guaqau-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdf971670339; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJKdfKF1670302
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 896A425782; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 07/13] target/hexagon: retain both scalar packet fault
 addresses
Date: Thu, 19 Nov 2026 12:39:35 -0800
Message-ID: <20261119203941.899748-8-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX1PKsGmLfnFIt
 CHevPzB418ssoy5G8NiNKE/f04EI4c8Cgu+HIVl2trcUavs1F425D1bDRnkAUOgBV8qq+6dkiaC
 kl0r+RIdXQOC+Ne33c1Bi33NSBXwmx0=
X-Proofpoint-ORIG-GUID: iGbXpfGr39n2DKQuaOz2XR_kdfDZylvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfXzD4OFIZEkuXd
 1FywbPrAsMW4mw551L+sXgipIUkoXTLvupuUYp1R0dojr2FactKxVWXhLbgRlLb6rnNLLNHBtwk
 CR3tQsfvLGLefhj3yTnI20KOO8qDrl9iFf0q9C2ny5v3xJqyLlYVXnN8/B58dypNEooDviQPtao
 AyoKJCel6patwvf3M6oVbUAkGMoiV74EWgxEQS6+xWFq46QZOW7aElbXtjpiT2DMVhd5I0bse4q
 W8zHuAka0dOXhcI0nXvkXHyi39ChUAANjhcyCRbQBOhgjpNYpogIZH9D978yMXATuCl+o1lTMDE
 OHdwznn6wxWNLYhX6XUztwrAMolnWMMWs7xxyDcaDijldTSTs6U72289b/ZUPyBJPXhgll60o1/
 e7VqjWZ4k+KPMos5weH8WfHcQjDeqrCDxdyw8V5zTgVkQwJ8N8iH7JzkY4/3++hsZ1uu2AVpA9M
 5W5aVhcXLpn8es7UBBA==
X-Proofpoint-GUID: iGbXpfGr39n2DKQuaOz2XR_kdfDZylvp
X-Authority-Analysis: v=2.4 cv=XutvqlF9 c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=9Yne1IhLnBY4bJs1OgIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Generate address-only code from scalar memory semantics. Record both
active slots before memory execution, without loads, stores, or pointer
updates. Use the recorded addresses and validity bits on a data fault.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c                 | 16 ++++++++++++
 target/hexagon/cpu.h                 |  2 ++
 target/hexagon/gen_tcg_func_table.py |  6 +++++
 target/hexagon/gen_tcg_funcs.py      | 38 ++++++++++++++++++++++++++++
 target/hexagon/genptr.c              | 17 +++++++++++++
 target/hexagon/genptr.h              |  4 +++
 target/hexagon/hex_common.py         | 22 ++++++++++++++++
 target/hexagon/translate.c           | 16 ++++++++++++
 target/hexagon/translate.h           |  1 +
 9 files changed, 122 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 11d622948e..34f80d6671 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -759,6 +759,22 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
 {
     env->t_sreg[HEX_SREG_BADVA] = VA;
 
+    if (access_type != MMU_INST_FETCH && env->mem_access_valid) {
+        uint32_t valid = env->mem_access_valid | (1U << slot);
+        for (int i = 0; i < 2; i++) {
+            if (valid & (1U << i)) {
+                env->t_sreg[HEX_SREG_BADVA0 + i] =
+                    i == slot ? VA : env->mem_access_va[i];
+            } else {
+                env->t_sreg[HEX_SREG_BADVA0 + i] = INVALID_BADVA;
+            }
+        }
+        SET_SSR_FIELD(env, SSR_V0, valid & 1);
+        SET_SSR_FIELD(env, SSR_V1, (valid >> 1) & 1);
+        SET_SSR_FIELD(env, SSR_BVS, slot);
+        return;
+    }
+
     if (access_type == MMU_INST_FETCH || slot == 0) {
         env->t_sreg[HEX_SREG_BADVA0] = VA;
         env->t_sreg[HEX_SREG_BADVA1] = INVALID_BADVA;
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index d6a513988c..915da339a0 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -167,6 +167,8 @@ typedef struct CPUArchState {
     uint32_t t_sreg[NUM_SREGS];
     /* Slot of the memory operation currently being executed or probed. */
     uint32_t mem_slot;
+    uint32_t mem_access_valid;
+    uint32_t mem_access_va[2];
 
     uint32_t greg[NUM_GREGS];
 
diff --git a/target/hexagon/gen_tcg_func_table.py b/target/hexagon/gen_tcg_func_table.py
index ba56ede568..3ec136d6f1 100755
--- a/target/hexagon/gen_tcg_func_table.py
+++ b/target/hexagon/gen_tcg_func_table.py
@@ -22,6 +22,12 @@ def main():
             f.write(f"    [{tag}] = generate_{tag},\n")
 
         f.write("};\n\n")
+        f.write("#ifndef CONFIG_USER_ONLY\n")
+        f.write("const SemanticInsn opcode_address[XX_LAST_OPCODE] = {\n")
+        for tag in hex_common.tags:
+            if not hex_common.tag_ignore(tag) and hex_common.packet_memory_info(tag):
+                f.write(f"    [{tag}] = address_{tag},\n")
+        f.write("};\n#endif\n\n")
         f.write("#endif    /* HEXAGON_FUNC_TABLE_H */\n")
 
 
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs.py
index eb2e5f3a7e..f67056049e 100755
--- a/target/hexagon/gen_tcg_funcs.py
+++ b/target/hexagon/gen_tcg_funcs.py
@@ -154,11 +154,49 @@ def gen_tcg_func(f, tag, regs, imms):
     f.write("}\n\n")
 
 
+def gen_memory_address(f, tag, regs, imms):
+    info = hex_common.packet_memory_info(tag)
+    if info is None:
+        return
+    ea, pred, width = info
+    for reg in ("SP", "FP", "GP", "LR"):
+        ea = ea.replace(f"fREAD_{reg}()", f"hex_gpr[HEX_REG_{reg}]")
+    f.write("#ifndef CONFIG_USER_ONLY\n")
+    f.write(f"static void address_{tag}(DisasContext *ctx)\n{{\n")
+    f.write("    Insn *insn G_GNUC_UNUSED = ctx->insn;\n")
+    f.write("    TCGv EA = tcg_temp_new();\n")
+    for i, (regtype, regid) in enumerate(regs):
+        name = f"{regtype}{regid}V"
+        if regtype == "R" and re.search(rf"\b{name}\b", ea):
+            f.write(f"    TCGv {name} = hex_gpr[insn->regno[{i}]];\n")
+    for immlett, bits, shift in imms:
+        name = hex_common.imm_name(immlett)
+        if re.search(rf"\b{name}\b", ea):
+            i = 1 if immlett.isupper() else 0
+            f.write(f"    int {name} = insn->immed[{i}];\n")
+    if pred:
+        name = pred.group(3)
+        i = next(i for i, (t, r) in enumerate(regs)
+                 if f"{t}{r}" == name[:-1])
+        source = "ctx->new_pred_value" if pred.group(1) == "NEW" else "hex_pred"
+        f.write("    TCGv LSB = tcg_temp_new();\n")
+        f.write("    TCGLabel *skip = gen_new_label();\n")
+        f.write(f"    tcg_gen_andi_tl(LSB, {source}[insn->regno[{i}]], 1);\n")
+        cond = "NE" if pred.group(2) else "EQ"
+        f.write(f"    tcg_gen_brcondi_tl(TCG_COND_{cond}, LSB, 0, skip);\n")
+    f.write(f"    {ea};\n")
+    f.write("    gen_log_mem_address(ctx, EA);\n")
+    if pred:
+        f.write("    gen_set_label(skip);\n")
+    f.write("}\n#endif\n\n")
+
+
 def gen_def_tcg_func(f, tag, tagregs, tagimms):
     regs = tagregs[tag]
     imms = tagimms[tag]
 
     gen_tcg_func(f, tag, regs, imms)
+    gen_memory_address(f, tag, regs, imms)
 
 
 def main():
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 954dea6622..e270a41b8d 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1722,6 +1722,23 @@ static void vec_to_qvec(size_t size, TCGv_ptr dstbase, intptr_t dstoff,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+void gen_log_mem_address(DisasContext *ctx, TCGv va)
+{
+    unsigned slot = ctx->insn->slot;
+    TCGv valid = tcg_temp_new();
+
+    tcg_debug_assert(slot < 2);
+    tcg_gen_st_i32(va, tcg_env,
+                   offsetof(CPUHexagonState, mem_access_va[slot]));
+    tcg_gen_ld_i32(valid, tcg_env,
+                   offsetof(CPUHexagonState, mem_access_valid));
+    tcg_gen_ori_i32(valid, valid, 1U << slot);
+    tcg_gen_st_i32(valid, tcg_env,
+                   offsetof(CPUHexagonState, mem_access_valid));
+}
+#endif
+
 void probe_noshuf_load(TCGv va, int s, int mi)
 {
     TCGv size = tcg_constant_tl(s);
diff --git a/target/hexagon/genptr.h b/target/hexagon/genptr.h
index 270375251f..99dff75973 100644
--- a/target/hexagon/genptr.h
+++ b/target/hexagon/genptr.h
@@ -23,6 +23,10 @@
 #include "translate.h"
 
 extern const SemanticInsn opcode_genptr[];
+#ifndef CONFIG_USER_ONLY
+extern const SemanticInsn opcode_address[];
+void gen_log_mem_address(DisasContext *ctx, TCGv va);
+#endif
 
 void gen_store32(TCGv vaddr, TCGv src, uint32_t width, uint32_t slot);
 void gen_store1(TCGv_env cpu_env, TCGv vaddr, TCGv src, uint32_t slot);
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
index f85f063f52..6d335e9423 100755
--- a/target/hexagon/hex_common.py
+++ b/target/hexagon/hex_common.py
@@ -299,6 +299,28 @@ def need_pkt_has_multi_cof(tag):
     return False
 
 
+def packet_memory_info(tag):
+    """Return a side-effect-free scalar address expression, if available."""
+    attrs = attribdict[tag]
+    if not ("A_LOAD" in attrs or "A_STORE" in attrs):
+        return None
+    if any(a in attrs for a in ("A_CVI", "A_HVX", "A_HLX", "A_HMX")):
+        return None
+    sem = semdict[tag]
+    ea = re.search(r"fEA_(?:RI|RRs|IRs|IMM|REG|BREVR)\([^;]+\)", sem)
+    if not ea:
+        return None
+    # A locked store is conditional on the reservation, not a predicate.
+    if "fSTORE_LOCKED" in sem:
+        return None
+    width = next((n for n in (1, 2, 4, 8)
+                  if f"A_MEMSIZE_{n}B" in attrs), None)
+    if width is None:
+        return None
+    pred = re.search(r"fLSB(OLD|NEW)(NOT)?\((P\w+)\)", sem)
+    return ea.group(0), pred, width
+
+
 def need_pkt_need_commit(tag):
     return 'A_IMPLICIT_WRITES_USR' in attribdict[tag]
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 3105101aa3..163b22bc75 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -814,6 +814,7 @@ static void gen_start_packet(DisasContext *ctx)
      * gen phase, so clear it again.
      */
     bitmap_zero(ctx->pregs_written, NUM_PREGS);
+    ctx->mem_addresses_generated = false;
 #ifndef CONFIG_USER_ONLY
     for (i = 0; i < HEX_SREG_GLB_START; i++) {
         ctx->t_sreg_new_value[i] = NULL;
@@ -1021,6 +1022,21 @@ static void gen_insn(DisasContext *ctx)
 
 #ifndef CONFIG_USER_ONLY
     if (GET_ATTRIB(opcode, A_LOAD) || GET_ATTRIB(opcode, A_STORE)) {
+        if (!ctx->mem_addresses_generated) {
+            Insn *saved = ctx->insn;
+
+            tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                           offsetof(CPUHexagonState, mem_access_valid));
+            for (int i = 0; i < ctx->pkt.num_insns; i++) {
+                Insn *in = &ctx->pkt.insn[i];
+                if (opcode_address[in->opcode]) {
+                    ctx->insn = in;
+                    opcode_address[in->opcode](ctx);
+                }
+            }
+            ctx->insn = saved;
+            ctx->mem_addresses_generated = true;
+        }
         tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,
                        offsetof(CPUHexagonState, mem_slot));
     }
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index f1aa56e463..55d95fd3ab 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -88,6 +88,7 @@ typedef struct DisasContext {
     DECLARE_BITMAP(insn_qregs_read, NUM_QREGS);
     bool pre_commit;
     bool need_commit;
+    bool mem_addresses_generated;
     TCGCond branch_cond;
     target_ulong branch_dest;
     bool is_tight_loop;
-- 
2.43.0


