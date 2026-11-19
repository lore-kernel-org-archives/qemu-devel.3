Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F9606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UXvE2l0D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9q-0003DK-6A; Thu, 19 Nov 2026 16:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9m-0003BE-NE
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9h-0006aV-CS
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:02 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1T7C095221
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2wxLsk8Lysw
 oL/FOKGmQWGaYChPMzCUkeHVru0yxP4Q=; b=UXvE2l0DH9pCJBnuQ7e3rCVtzXM
 78s7AJQCogXrqgKQ9o9GAPKmyd8taYkvQ3rFaJxV32r+X5kJG8z6tJETSFeBrR2Y
 EM//FLwC0mD6PLZcnsRYBcN3KryRzfGv/ouHB9jzq9+12Hnh+3YE5zGi4ymjsdeB
 fVKWcLWrKX5jPR3PD87LKjiusvqOza8Ht8YqhFDCVtiA+5bOlqCkwX/PMJeJwZc4
 Dmf+L5gpP62joXoJtl1407K/xzf1XzPLz6/V4DVq28sVyqzqbMMnvkG6m1IO5fVM
 mbqWdCMMiiFHaLrt1D7YBShvnNyhC4p5z0EXTt1eSV71pna7ZLFfumsWvFw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1bf6y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:55 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwsH23812792; Thu, 19 Nov 2026 21:58:54 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJLwsMR3812748
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 5AA8F25785; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 08/15] target/hexagon: report the faulting memory slot
Date: Thu, 19 Nov 2026 13:58:46 -0800
Message-ID: <20261119215853.987158-9-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff711f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=uZvwfCfAbIog8kgrQSkA:9
X-Proofpoint-ORIG-GUID: NfjhXz3v11sXU8MMWoBalrNVJlIv5zfh
X-Proofpoint-GUID: NfjhXz3v11sXU8MMWoBalrNVJlIv5zfh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX8dYf69rPrSwS
 F/RJe8KeLO3glw3mMyOiUprmZ6mkFGQ2T0Bdqg7gai7X9nuyHLEWYP8DnSguIpZfTO7GyU+9evN
 gbzqkBn/oghSpp2OKk/YIjBH9xtlfwo3J6QOf+htPtY2OSM2Duiyt5sUS0xQLtZRYmZrfJS1bDB
 HIjnrsg7FWCfwuRNw9TcK3iLEsfm8jvNany+KKSaOAFI4b2VSmR43KnRtWyBc2ccVyfUTh64E0j
 /o/luSNo4+Q2H8BVs7s+hKsUJRZVzr7HmBQZ0nWi/sPOpRcJPotISLc/iZIkUQGFIxOD3Y3fdeL
 xwJGAf8BXF2DR7h3rQCtihj9acmQB/I8mkWDJQa7dRLzExwUTqTtLdBm+HZ5DvuMY3qGfBcKQpB
 mK2KX5Q+NnRWMlh/Kv8xRIkS7IU0gC8F0TOdRSQIvF3KMXpkGKsbIg51d+tg0nZoijQP2IZSVcd
 q1+JPa8JA5sQcnvrw3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX9XFyMTAnSYl7
 Q1qaD1p5AzBuJknWblBPYNmw0ZnvjhDQ6Pevqv2vRn4JYYC79a0aG2lu0OKKH2Ru+PNzjn8KEdi
 1QeitFc4uIGhPOfMTQuXAxoaiT0r4yk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190088
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

Track the slot during memory execution and store probes. Use it for
TLB and alignment faults so a slot 1 fault selects BADVA1 and BVS.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c       |  4 ++--
 target/hexagon/cpu.h       |  2 ++
 target/hexagon/op_helper.c |  6 ++++++
 target/hexagon/translate.c | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 1159b0cac9..11d622948e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -836,7 +836,7 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
                              uintptr_t retaddr)
 {
     CPUHexagonState *env = cpu_env(cs);
-    int slot = 0;
+    int slot = access_type == MMU_INST_FETCH ? 0 : env->mem_slot;
     hwaddr phys;
     int prot = 0;
     uint64_t page_size = 0;
@@ -918,7 +918,7 @@ void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 {
     CPUHexagonState *env = cpu_env(cs);
 
-    raise_misaligned_exception(cs, addr, 0, access_type);
+    raise_misaligned_exception(cs, addr, env->mem_slot, access_type);
     do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
                        retaddr);
 }
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 1eb6c7d8bf..d6a513988c 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -165,6 +165,8 @@ typedef struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     /* Some system registers are per thread and some are global. */
     uint32_t t_sreg[NUM_SREGS];
+    /* Slot of the memory operation currently being executed or probed. */
+    uint32_t mem_slot;
 
     uint32_t greg[NUM_GREGS];
 
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 71b27ef07f..be5ce7d89c 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -441,6 +441,9 @@ static void probe_store(CPUHexagonState *env, int slot, int mmu_idx,
                         bool is_predicated, uintptr_t retaddr)
 {
     if (!is_predicated || !(env->slot_cancelled & (1 << slot))) {
+#ifndef CONFIG_USER_ONLY
+        env->mem_slot = slot;
+#endif
         uint32_t width = env->mem_log_stores[slot].width;
         target_ulong va = env->mem_log_stores[slot].va;
         probe_write(env, va, width, mmu_idx, retaddr);
@@ -455,6 +458,9 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
                                int size, int mmu_idx)
 {
     uintptr_t retaddr = GETPC();
+#ifndef CONFIG_USER_ONLY
+    env->mem_slot = 0;
+#endif
     probe_read(env, va, size, mmu_idx, retaddr);
 }
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 73676f6346..68d6a64fe6 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1019,6 +1019,13 @@ static void gen_insn(DisasContext *ctx)
 {
     uint16_t opcode = ctx->insn->opcode;
 
+#ifndef CONFIG_USER_ONLY
+    if (GET_ATTRIB(opcode, A_LOAD) || GET_ATTRIB(opcode, A_STORE)) {
+        tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,
+                       offsetof(CPUHexagonState, mem_slot));
+    }
+#endif
+
     if (GET_ATTRIB(opcode, A_RELEASE) ||
         GET_ATTRIB(opcode, A_CVI_SCATTER_RELEASE)) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
@@ -1175,6 +1182,10 @@ void process_store(DisasContext *ctx, int slot_num)
     }
     {
         TCGv address = tcg_temp_new();
+#ifndef CONFIG_USER_ONLY
+        tcg_gen_st_i32(tcg_constant_i32(slot_num), tcg_env,
+                       offsetof(CPUHexagonState, mem_slot));
+#endif
         tcg_gen_mov_tl(address, hex_store_addr[slot_num]);
 
         /*
@@ -1221,6 +1232,13 @@ void process_store(DisasContext *ctx, int slot_num)
     if (is_predicated) {
         gen_set_label(label_end);
     }
+#ifndef CONFIG_USER_ONLY
+    /* An early mem_noshuf store is followed by the slot 0 load. */
+    if (ctx->pre_commit) {
+        tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,
+                       offsetof(CPUHexagonState, mem_slot));
+    }
+#endif
 }
 
 static void process_store_log(DisasContext *ctx)
-- 
2.43.0


