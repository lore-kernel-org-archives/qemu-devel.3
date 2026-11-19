Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A02606A93E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FReA09GC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8vl-0003NZ-AZ; Thu, 19 Nov 2026 15:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v5-0003Aq-3r
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:51 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xU8v3-0007Io-73
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 15:39:46 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1S6b095162
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=obaYNB5+EMm
 2OLpXASkG5Fo78WwbSU4KyHhou3DNGqo=; b=FReA09GCKy2BYya8yOq0N1sqbMw
 aeDN4Q6XcenOTbndSa8e0jQwe7ugeigYp9jWo/dTsRZb/rEdFK9M3QndvLDdE06E
 bCQ2Noun51EWj5XTWElqyT+ZH9bXdKz1bWid3d9bikPPVAQpC3FkNXlQar/I63M0
 JKk4s5EZY8KVxiFmQMNmSb2mfcMKl/sxvJhj+ATFHeZ/P8Zk3fbwyHDmWhisIv5m
 4xOUCsiO9/uT8y6q1pQkZnxSbL+IwZQDSmnxdHMbelmRN5S2i1gcMk++4tFESvo7
 yphl4gWM94nfU7KxPClMA33osPhuQXONak66vMG7XNBDab08Cy93XQoAneA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1xx1b48d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 20:39:42 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJKdgWt3698925; Thu, 19 Nov 2026 20:39:42 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AJKdfEE3698908
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 20:39:41 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 930CD2578D; Thu, 19 Nov 2026 12:39:41 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v2 09/13] target/hexagon: probe scalar packet memory in slot
 priority order
Date: Thu, 19 Nov 2026 12:39:37 -0800
Message-ID: <20261119203941.899748-10-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
References: <20261119203941.899748-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=PcBqFShd c=1 sm=1 tr=0 ts=6aff5e8e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=dMN3z6l-B7iZEtH36-MA:9
X-Proofpoint-ORIG-GUID: FsXaQXyrM0_CfSBCIENgBcbKzYtrFNGl
X-Proofpoint-GUID: FsXaQXyrM0_CfSBCIENgBcbKzYtrFNGl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX/FyW03U4sTm2
 HhAQHNUZSfkXiqr2a0+vwVZq3EBMm8Kxe5m5C+EinSdVz9z+lOs5WbhLum+cI2r/JuqOSskb8Q+
 9CQZsknrapyn5UgRO9HWirAbHhsBDcWHr7ZPK1Q+lumc5HzxFEgmVTQmjELqc/Q9pxX8fWsGvel
 jrp1SJ5UD04Xoq4F7dWLWLBV/VOI81qR1V1CLSqBSK+9fdbg61VUV5AQ9VMjzGH2dD839Tzu6Yx
 9L9o63Tx32LCvPgimMLRmb3sVjF89d9oYDveEhYyvj/2Sy4b814hsLNKQ5LZKJK3lqC7azzQBvu
 daK69Ozn0Xv2ThauP/btHkYS0pCzyrbLju7gIMcpTyej2gHQyQhlSVLj7ktkPStY8tVwPmf70eW
 2n8yc6jC0VvwBlIx+exXNz5sOevv8Oer/rR5J6Wpvjq8ewsf7NgIpHtvDb7XOnrHvYVMIvo+VL1
 wtupoVyzjOCnl6LusBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4MiBTYWx0ZWRfX1Vbe466D8rY7
 Yb1f8hcCbC+yOrrDXUCOs0dpxN5JNbZQnUg1cemBpiUutEXnPE1fi1h6Y71feWSmV3GYGQLa51S
 lq9xX3mlaaJAs60PKcDCldHbII99/+g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
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

Probe slot 1 before slot 0 without committing either access. A slot 1
store miss must win over a slot 0 load miss in a mem_noshuf packet.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index be5ce7d89c..f22353302b 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -459,6 +459,12 @@ void HELPER(probe_noshuf_load)(CPUHexagonState *env, target_ulong va,
 {
     uintptr_t retaddr = GETPC();
 #ifndef CONFIG_USER_ONLY
+    /* The slot 1 store fault must precede the slot 0 load fault. */
+    if (env->mem_access_valid & (1U << 1)) {
+        env->mem_slot = 1;
+        probe_write(env, env->mem_access_va[1],
+                    env->mem_log_stores[1].width, mmu_idx, retaddr);
+    }
     env->mem_slot = 0;
 #endif
     probe_read(env, va, size, mmu_idx, retaddr);
@@ -555,6 +561,10 @@ static void check_noshuf(CPUHexagonState *env, bool pkt_has_scalar_store_s1,
 {
     if (slot == 0 && pkt_has_scalar_store_s1 &&
         ((env->slot_cancelled & (1 << 1)) == 0)) {
+#ifndef CONFIG_USER_ONLY
+        probe_store(env, 1, MMU_USER_IDX, false, ra);
+        env->mem_slot = 0;
+#endif
         probe_read(env, vaddr, size, MMU_USER_IDX, ra);
         commit_store(env, 1, ra);
     }
-- 
2.43.0


