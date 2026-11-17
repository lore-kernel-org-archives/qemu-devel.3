Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8750606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gB/A5C3L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO2y-0001H0-88; Tue, 17 Nov 2026 13:36:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2k-0001Dj-TR
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2i-0000ov-PW
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQpuC1663289
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uVVCKyx2B8Y
 4M1LeFdoNeMmSOEDkrlDILSGJMdrFcbI=; b=gB/A5C3L/FjgpWjZpxz1T9HrX8f
 xVr//lkUYbV6/B3Kgk36+0yEFrmb6CZlczDec6SpHKGU/BgkV4XNKqYbP04Otzy5
 OkexPmR9i+ci60DfnKP5LtjPIikE4ZwTwWownhVW8kLHvqO9K5VPIORZW/5Fcllw
 WG4uKbyz/fmR2ecSWzrxPkVacQVG3PR2SXk7nL9cUm9I9wNkWFQOUac3ntIoYbnz
 WVeTJzagLlZ6IDKhj9C3CDXQzpx4ZK82CvUcEooEMjO//xLYMESX1RwptaH+HxIL
 qcWF06uNgaw83mf7mMfCgPs3AszZ4nStK94Z7ybX91f/ufNr8CRbrxcah0w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0kccahy4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaUVQ1153604; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AHIaTkG1153591
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 9B91025420; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 04/14] target/hexagon: reject HMX operands outside VTCM
Date: Tue, 17 Nov 2026 10:36:19 -0800
Message-ID: <20261117183629.2002840-5-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX2Xw7I6jeRsyf
 h8OQzBdKw4mISmYJAJ3Bns+woIP0dw2htAKHcs2vyNe33sVhJ39T7RoMnyXedtH4ylDBS7lFv5H
 cLJYigia8BkBClpTS4UCEzaCGS73TbY=
X-Proofpoint-ORIG-GUID: Nk6gMGx1g-GqYDALXmoDSF8vXKaDzY0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX9GoHUxi8CVYy
 jPoeQdqz7fQRhV7/s2/JESQHCfbtdqBAg3g/vb6WCai68KM8GoHn3rHxz+cSKmh4pMgLjWQk19G
 vnt0QYHXpqMhUJ5k8jNzYFQXEn4K5bKgda2T4AFmbd+InBPtbdQ1WuAXHLwtMzp4XVm4CdKxxD4
 681xh6IJMpAQxLptvFq8SGPmPbWCNzc1h2MqBe8z1/qzYCLsG63fOl4CEuRH38odeSgG65dr5r6
 Apxc32QKiFd/zBh+7ue6hFcAdBYCD0+YPHgnyVfRAAayOeZvFvyy5D/hg4ITXCWVz/pGBzrFPho
 NnUQ4WnOTsg47fUAGTEaYEIq6jKzc38OIVZa9jJmRL2R4ynPcWwYxBaoEynzd25F5GIl4arxE6I
 CsHfUF0Dt1LwWkzZRwoWY2FEDwrMljzDSqK2XYYAm8xQq6N7XR6F0O72f9Rs7eMLcMeDRw+stq1
 wJLR5YTZaOd+HlqvTDg==
X-Proofpoint-GUID: Nk6gMGx1g-GqYDALXmoDSF8vXKaDzY0n
X-Authority-Analysis: v=2.4 cv=ZP1CCn7b c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pZsbe2Yp_7pzwAaU698A:9
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

Check activation and weight addresses against the machine VTCM range
before executing packet instructions. An invalid operand raises the
precise coprocessor VMEM address error and prevents packet commit.
HMX arithmetic remains unimplemented.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/helper.h    |  3 +++
 target/hexagon/op_helper.c | 19 +++++++++++++++++++
 target/hexagon/translate.c | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 292ca8eb7c..eddde9ab34 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -22,6 +22,9 @@ DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
+#ifndef CONFIG_USER_ONLY
+DEF_HELPER_3(hmx_check_address, void, env, i32, i32)
+#endif
 DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
 DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
 DEF_HELPER_4(sfrecipa, i64, env, f32, f32, i32)
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 71b27ef07f..8ed9aff7ee 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -52,6 +52,25 @@
 #include "hw/intc/hex-l2vic.h"
 #include "hex_interrupts.h"
 #include "hexswi.h"
+#include "system/physmem.h"
+#endif
+
+#ifndef CONFIG_USER_ONLY
+void HELPER(hmx_check_address)(CPUHexagonState *env, uint32_t va, uint32_t pc)
+{
+    HexagonCPU *cpu = env_archcpu(env);
+    uint32_t config[2];
+    uint64_t base, size;
+
+    physical_memory_read(cpu->globalregs->config_table_addr + 0x38,
+                         config, sizeof(config));
+    base = (uint64_t)le32_to_cpu(config[0]) << 16;
+    size = (uint64_t)le32_to_cpu(config[1]) << 10;
+    if (va < base || va - base >= size) {
+        env->cause_code = 0x26; /* Coprocessor VMEM address error */
+        do_raise_exception(env, HEX_EVENT_PRECISE, pc, GETPC());
+    }
+}
 #endif
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 10ed73590c..de5baf9f6e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -946,6 +946,17 @@ static void gen_start_packet(DisasContext *ctx)
         gen_precise_exception(HEX_CAUSE_NO_COPROC2_ENABLE, ctx->pkt.pc);
         ctx->hmx_check_emitted = true;
     }
+    if (ctx->pkt.pkt_has_hmx) {
+        for (i = 0; i < ctx->pkt.num_insns; i++) {
+            Insn *insn = &ctx->pkt.insn[i];
+            if (GET_ATTRIB(insn->opcode, A_HMX) &&
+                (GET_ATTRIB(insn->opcode, A_PAIR_1OF2) ||
+                 GET_ATTRIB(insn->opcode, A_PAIR_2OF2))) {
+                gen_helper_hmx_check_address(tcg_env,
+                    hex_gpr[insn->regno[0]], tcg_constant_i32(ctx->pkt.pc));
+            }
+        }
+    }
 #endif
 }
 
-- 
2.43.0


