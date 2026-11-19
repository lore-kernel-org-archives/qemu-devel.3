Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2E606B743
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EzFIjLIC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vl-0003NM-9L; Thu, 19 Nov 2026 15:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8vA-0003BB-2D
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007JE-SQ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:49 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJelJT3279091
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4iT11E3LHVE
 BfqejpW9UwuSL/16Wu6MMPFRqencprq8=; b=EzFIjLICIvxqgjEEnkFzbHWN7oq
 Olj+ItZ1rs3aOJxHsC7BaFYZZLHY+FdM3OorVmELIuuE2/rVda6ikW+aiOimAE7N
 IE4qJcqv5zi2KHJUuSHsEZwxfnb4OOXKtGUKQOZGreHmarX6cghjiBoJpYR/xddN
 5JYlepHSQoW4r08peBuoBBx8J/UJsCJcaYE96UjUNJBdlsIhcFvrl9eP4Bvk4N5M
 fvuiDRFW9CDkEib0WmlZRF7iTAuDXe6+Q09ZLlfA8xLYINg4D+2yiwp0n/431I6n
 AuraD8Pv968Nnb2a+CtzeeHxTxl5nk/dz7oN8dDgynREiJWEuzFpe4qC+Ig==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27fyg914-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdfAD1670338; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJKdfXq1670301
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 84D162577E; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 06/13] target/hexagon: report the faulting memory slot
Date: Thu, 19 Nov 2026 12:39:34 -0800
Message-ID: <20261119203941.899748-7-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX39QEHASYDnrC
 7DHepfjf66mzFZ9ktA/y8Uyiy6JfenVyrgfVQqLdiOioamHvMc9PEBNZRtdyVXMZLmsYYaxQcns
 rAfUVvLuC7D2+gpNBH9c3Y2eUuxNxyg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX0AqVurm+l8JS
 lGf9dQifdyseKDCdyldS3XwNw2slXPnzwmLotCqSHn2GhuFtt0TqpZnE/cSo1FJ2ZM0JSr40Uq2
 ipxepmZxrUtzxREPunq25jBySHaUssXhxRGfRUbLeNmXhY4gNl0ozbZPyhW8omtBsl8G+/7rWfr
 Pjv6Dc9FFZh952dUHjgiXBXFutlq2eAm/Mzp7Ww7qbfq7ybYPBj6cRcdkoYXaRDLcGA8AaCN16b
 zFf/APeO0gLgNndAlxnOZ8N78MsNRfMKkz0ChdjDDouW1/bUZV8sj+/cFURk9CqiZX/Oqay1zHQ
 LWuTrdkGzsER2Kx/cnpXuS3aJ0NuaFVx+9sSWYITzaJvi2ImjrizpbAKIAnR29HhPe6nxo8yDAj
 ogVOXEU06WyzL4ha+t1oKalQ8LR2V/RveHC8VC2/f872Q6NJ7dC/+81pV13NUtr56V7qVA7Mk8x
 yka3AMrdpRd1XwAJr/g==
X-Authority-Analysis: v=2.4 cv=GZKCDgXL c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=uZvwfCfAbIog8kgrQSkA:9
X-Proofpoint-ORIG-GUID: jREK2SxlW0QvibsVFaO74njud8ecsXd0
X-Proofpoint-GUID: jREK2SxlW0QvibsVFaO74njud8ecsXd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190082
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
index 220328147f..3105101aa3 100644
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


