Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C71606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zjx0bshV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO2p-0001Fg-Mi; Tue, 17 Nov 2026 13:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2k-0001Di-VF
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2i-0000ow-Nl
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQuJN1663464
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0H73VeEHQPL
 lpa3KjaOX5VDhYt9/ZHmxf0aG+mH7de8=; b=Zjx0bshV9u0zuPuj6IssSkM8EX6
 4ZzdSs30huIfqT3ofjKuG8Sw/mU/vrjtEVBZQJ6ETzPd40b+d9orz925gbkGAEbS
 AGuQ+NLoXKtDINTCHxLe87oKKdoklkbfI7b93rDf9AO4o1zf+hJi1Jw84twovPpO
 XZ9QAzwPEkAGLA1jpP5uD8R2ga7ZyHrx12q9cPK2CmbaIzbVeEmf5avO74d3YfDm
 0VJjj15xtVLSIY7Lpj+CgJapi5b9vKJbt6ILsGwEOwsxp6RNZinxyle3BrNyc7WG
 /GHpUgf0uY1Lgnr/2cQZ081OjtkyHffDnairFEjQdtVrTq0L4iPK0b6uw/Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccahy7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUuj3041138; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AHIaU773041112
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id C68A1256EF; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 14/14] target/hexagon: probe VMEMU upper transactions before
 lower ones
Date: Tue, 17 Nov 2026 10:36:29 -0800
Message-ID: <20261117183629.2002840-15-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8qqCHkGrCaAI
 Y0A3B2V1JkXdl+fpR2PnB/99rNlsVIo/5ohmlMJ5AvVCKR2gpry/pJ1xAnIReEjfjRCKlNSM+y7
 c4P3AoSa7jxfHzpFNrqUtSMq30j+mA4=
X-Proofpoint-ORIG-GUID: t1j0CMc85qZuVovqFFfK_WthGCEnZ_9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX6clVG/locC69
 RYo+ApNhPPX91XMFr/77fVwOdjGkuiwT3WrIFx1msTO34dzH7KX1XkXYh8OUuOb7DFtrskxY4XM
 4Rv7zc9+fgszGRxE90QsQ6fvHv5q9rqvp6CBiiMO20MAYkcRCnqLK4X28J15srjrEfeGQGVKnII
 oPL5snhB633yEXzUS4CJUoEKvook1gC1d1t9TJlRdEGkUlFocBm7giOkuuigUzXsp22eSV+w2bM
 oudutMOnPh7g+Lbnx3FsYbfuxwz7UoY6hXEGHa/8PPJ6Rr7fnvwBc9RE4tZRJkklrjwQhu7/awN
 gexfccxgbGEcrhQgkZhJ2HxVoymu8drkmvp1m2jS/7tmI4ta18gcW2QBHIXSlxVkDWuR7P+A6EE
 EuJ9ehHo1+MyRh7On3N0bUIslvYTKqBOJc5G7E1LWw2RFqkOnw3d8DAKkMVtK2tq8KY1Dt70sK2
 XhVHFz/dRI5vNoR4AOg==
X-Proofpoint-GUID: t1j0CMc85qZuVovqFFfK_WthGCEnZ_9Y
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=gtXRB7oiKyt7bUs4DXEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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

Record both unaligned VMEMU addresses and probe the upper transaction
first. Report the architectural address, not the page boundary found
by a split TLB access. Preserve both validity bits on load and store
faults.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c       |  4 +++-
 target/hexagon/genptr.c    | 10 ++++++++++
 target/hexagon/helper.h    |  1 +
 target/hexagon/op_helper.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index bc8e51ee61..2965c92a77 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -760,9 +760,11 @@ static void set_badva_regs(CPUHexagonState *env, uint32_t VA, int slot,
         for (int i = 0; i < 2; i++) {
             if (valid & (1U << i)) {
                 env->t_sreg[HEX_SREG_BADVA0 + i] =
-                    i == slot ? VA : env->mem_access_va[i];
+                    (env->mem_access_valid & (1U << i)) ?
+                    env->mem_access_va[i] : VA;
             }
         }
+        env->t_sreg[HEX_SREG_BADVA] = env->t_sreg[HEX_SREG_BADVA0 + slot];
         SET_SSR_FIELD(env, SSR_V0, valid & 1);
         SET_SSR_FIELD(env, SSR_V1, (valid >> 1) & 1);
         SET_SSR_FIELD(env, SSR_BVS, slot);
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 954dea6622..d9830b230d 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -1634,6 +1634,11 @@ static void gen_vreg_load(DisasContext *ctx, TCGv_ptr dstbase,
                           intptr_t dstoff, TCGv src, bool aligned)
 {
     TCGv_i64 tmp = tcg_temp_new_i64();
+#ifndef CONFIG_USER_ONLY
+    gen_helper_probe_hvx_mem(tcg_env, src, tcg_constant_i32(ctx->insn->slot),
+                             tcg_constant_i32(aligned), tcg_constant_i32(0),
+                             tcg_constant_i32(ctx->mem_idx));
+#endif
     if (aligned) {
         tcg_gen_andi_tl(src, src, ~((int32_t)VECTOR_SIZE_BYTE - 1));
     }
@@ -1656,6 +1661,11 @@ static void gen_vreg_store(DisasContext *ctx, TCGv EA, TCGv_ptr srcbase,
         return;
     }
 
+#ifndef CONFIG_USER_ONLY
+    gen_helper_probe_hvx_mem(tcg_env, EA, tcg_constant_i32(slot),
+                             tcg_constant_i32(aligned), tcg_constant_i32(1),
+                             tcg_constant_i32(ctx->mem_idx));
+#endif
     tcg_gen_movi_tl(hex_vstore_pending[slot], 1);
     if (aligned) {
         tcg_gen_andi_tl(hex_vstore_addr[slot], EA,
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 754f341faf..160ab81ebc 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -26,6 +26,7 @@ DEF_HELPER_1(commit_hvx_stores, void, env)
 DEF_HELPER_3(hmx_check_address, void, env, i32, i32)
 DEF_HELPER_5(log_mem_address, void, env, i32, i32, i32, i32)
 DEF_HELPER_2(probe_packet_mem, void, env, i32)
+DEF_HELPER_6(probe_hvx_mem, void, env, i32, i32, i32, i32, i32)
 #endif
 DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
 DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 95e9f8b912..231855fdd6 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -108,6 +108,33 @@ void HELPER(hmx_check_address)(CPUHexagonState *env, uint32_t va, uint32_t pc)
         do_raise_exception(env, HEX_EVENT_PRECISE, pc, GETPC());
     }
 }
+
+void HELPER(probe_hvx_mem)(CPUHexagonState *env, uint32_t va, uint32_t slot,
+                           uint32_t aligned, uint32_t store, uint32_t mmu_idx)
+{
+    uintptr_t ra = GETPC();
+    uint32_t base = va & ~(VECTOR_SIZE_BYTE - 1);
+
+    if (aligned) {
+        HELPER(log_mem_address)(env, base, slot, VECTOR_SIZE_BYTE, store);
+    } else {
+        /* VMEMU uses both slots; BADVA records the unaligned addresses. */
+        HELPER(log_mem_address)(env, va, 0, VECTOR_SIZE_BYTE, store);
+        HELPER(log_mem_address)(env, va + VECTOR_SIZE_BYTE, 1,
+                                VECTOR_SIZE_BYTE, store);
+    }
+    int first = aligned ? slot : 1;
+    int last = aligned ? slot : 0;
+    for (int s = first; s >= last; s--) {
+        uint32_t address = base + (aligned ? 0 : s * VECTOR_SIZE_BYTE);
+        env->mem_slot = s;
+        if (store) {
+            probe_write(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
+        } else {
+            probe_read(env, address, VECTOR_SIZE_BYTE, mmu_idx, ra);
+        }
+    }
+}
 #endif
 
 #ifdef CONFIG_USER_ONLY
@@ -553,6 +580,9 @@ static void probe_hvx_stores(CPUHexagonState *env, int mmu_idx,
     /* Normal (possibly masked) vector store */
     for (int i = 0; i < VSTORES_MAX; i++) {
         if (env->vstore_pending[i]) {
+#ifndef CONFIG_USER_ONLY
+            env->mem_slot = i;
+#endif
             target_ulong va = env->vstore[i].va;
             int size = env->vstore[i].size;
             for (int j = 0; j < size; j++) {
-- 
2.43.0


