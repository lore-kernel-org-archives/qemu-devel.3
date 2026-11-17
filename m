Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15638606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c4fNb/71
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO2z-0001HA-H8; Tue, 17 Nov 2026 13:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2l-0001E9-T7
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2i-0000ok-NA
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:35 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR4Ga3503943
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PXuJdFyhI1V
 7nnFpbPE24dcvAf7bsmjeBcYS8lQKv1E=; b=c4fNb/71M7JvhTpIHluAnwr6Ram
 FD4ZK52Ir3I1bj6UWpiMTuYZBhcQwuxdl/AytTzwWY/ei1A7RrQMKla3dPQLfGHq
 vPXP7LYk82qeifjn7bU5ebhTbpWSpaEMZxPNe7FjwhOr51pXLrqtsPE3+uP6ZFnR
 fCuAdg4YeL2ScMQxhnOziaODr6LEtBj1PjleEZWLm8ukUupBM6OxP2CpywD/Gqfv
 ndod7qA14QPwx3imZ1zK5bYXNu7K52P3x9sWQEk5WoMGprK/PN6Dh58EtDl9AxFu
 8LVQ5Xsd6AA/mW9d3DoHIRzTYXawhRk+vHiBUI88TAy2b7Ty3uLgCWJKnsg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv125f3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUpC3041143; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AHIaU9O3041109
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id B9F5725515; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 11/14] target/hexagon: probe scalar packet memory in slot
 priority order
Date: Tue, 17 Nov 2026 10:36:26 -0800
Message-ID: <20261117183629.2002840-12-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: DMFNOARIemI4q_q3_hHS8n4PH4JFhgB9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8iDUBi4uGD3Y
 20KW7CxXoAU3vRBSDX6Xf8rsiP9DGRidvsFWEDFyyCrmqEHT5Wh+pnMEjiHN9ekMsjixXSzVfXR
 icHKDDhPYBxm55+qqIEsm1paU8u5Ulc=
X-Proofpoint-ORIG-GUID: DMFNOARIemI4q_q3_hHS8n4PH4JFhgB9
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=Ugnt4rVhruAp-E07vEsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8w7PZCdbZPPL
 f/n9LsYwN0+IG079C5IAgCAXRqspfYb/XQnSN+ZfqJN5IErFEZn0lwuEBcauk05vAkOMCRcd4YL
 GX6bBDpqjhcI7kAgPGGyL2gZ8Hezo0WdQ6ZOk4UR+f1Bz6k8WWiCjGJ4dt/Hf38kpmiyp1UQdLj
 VyL0N/zszRcj7ZgklJQDYOqdrPiyBHHyu0GBXItcvato3HMq1nJGdpLFAEaU1eAXS2UJCNcXvLs
 gFwMJiShjG6Clg7xRXxuSf3nhxL9PXxI8FHLL6fJcXvNZg3AEm/fRWww+XA+n54lmCUQxX4lGPF
 6tIDh1XqrjBaScI89hc3A5qMdTakNftXliHA9FHna/lei9wNKaX5fOO7ElEMNIyJQ3pRvvqKt8S
 pWshumqlH4I8HCVQR+7Be8Z+Ud8OWQZX+nJkU95aNPL4jFnws7lw8SQ8Sheo4B+wP9PJ+gJB2L3
 FjAYYJrCgR9J6V03kQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170074
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

Probe slot 1 before slot 0 without committing either access. A slot 1
store miss must win over a slot 0 load miss in a mem_noshuf packet.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/helper.h    |  1 +
 target/hexagon/op_helper.c | 18 ++++++++++++++++++
 target/hexagon/translate.c |  2 ++
 3 files changed, 21 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index ccd55e385d..32d71d84b5 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -25,6 +25,7 @@ DEF_HELPER_1(commit_hvx_stores, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(hmx_check_address, void, env, i32, i32)
 DEF_HELPER_5(log_mem_address, void, env, i32, i32, i32, i32)
+DEF_HELPER_2(probe_packet_mem, void, env, i32)
 #endif
 DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
 DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index af7e9c3de4..0814a32fa3 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -66,6 +66,24 @@ void HELPER(log_mem_address)(CPUHexagonState *env, uint32_t va,
     env->mem_access_store[slot] = store;
 }
 
+void HELPER(probe_packet_mem)(CPUHexagonState *env, uint32_t mmu_idx)
+{
+    uintptr_t ra = GETPC();
+
+    for (int slot = 1; slot >= 0; slot--) {
+        if (env->mem_access_valid & (1U << slot)) {
+            env->mem_slot = slot;
+            if (env->mem_access_store[slot]) {
+                probe_write(env, env->mem_access_va[slot],
+                            env->mem_access_size[slot], mmu_idx, ra);
+            } else {
+                probe_read(env, env->mem_access_va[slot],
+                           env->mem_access_size[slot], mmu_idx, ra);
+            }
+        }
+    }
+}
+
 void HELPER(hmx_check_address)(CPUHexagonState *env, uint32_t va, uint32_t pc)
 {
     HexagonCPU *cpu = env_archcpu(env);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 137fe60ca8..130e1be8ed 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1021,6 +1021,8 @@ static void gen_insn(DisasContext *ctx)
                 }
             }
             ctx->insn = saved;
+            gen_helper_probe_packet_mem(tcg_env,
+                                        tcg_constant_i32(ctx->mem_idx));
             ctx->mem_addresses_generated = true;
         }
         tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,
-- 
2.43.0


