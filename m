Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FD606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ujc1j4v9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYcN-00077b-66; Mon, 09 Nov 2026 18:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcG-00073b-Q3
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:33 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcF-0008HH-61
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:32 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LE13c316463
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Pi/jjRPuC/x
 HwLj9w278w5saMhVL7d67fan8+QA9Umw=; b=Ujc1j4v9ofVCPuURtu6X1cm2s/5
 /rGUnSXB2wDH+zurXRiUKAEoKcAhzS+vgzjNfDz/PsHZHX/y5auvrMRr9Q3hoffA
 +mkhqRQuA0TPx57BSS+dqB7eH+oX3Bw0bDIjMQ33jCV6qaVjZ4p8wGZIJIWEvFG4
 nBC0SQxjVok7FEgaw9MAu39NsgWxD5v9pi+fFhz4OqaB/v1KV1SiKK9vuVU9EAvJ
 Df417L3Bfx89Lkjj5X75RxUIaQgl3q7/W3GOYXUEbbPb6IELc/KLk8n9gf6ECUgu
 InhCRiGhcB42Ca1uDIZ8UzYF9/6FoHe+BEUgJi2mbEiF5rbpa9o+irL+TGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkgcq6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:17:28 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
 by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NHRuQ2601282; Mon, 9 Nov 2026 23:17:27 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6A9NHRnn2601268
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:17:27 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id CCBED23F29; Mon,  9 Nov 2026 15:17:26 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 1/3] target/hexagon: preserve guest event fault and CFI state
Date: Mon,  9 Nov 2026 15:17:24 -0800
Message-ID: <20261109231726.4062010-2-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109231726.4062010-1-marco.liebel@oss.qualcomm.com>
References: <20261109231726.4062010-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: gmVHcRr_cbAic0S4XSHtjQp76NXipwyv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfX/xk88YMTaUWW
 np++q+PdJisI8BLk2b8JBN+nI85wgPL0P0ASunPldMOA9quXnAWBiDzKYc9FNTA9YDp5Mpe4W//
 l9aYU/Jp4EDTF2K4znMVD7QK6WPZvGM=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af25488 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=MTNzgN7s884OyKAPA0UA:9
X-Proofpoint-ORIG-GUID: gmVHcRr_cbAic0S4XSHtjQp76NXipwyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfXwK/SQicTomO0
 xHaBnGBbhtUQgcSLdZPzm60bNjYjarw+NIJtDfGfNUAXHPvPn4pMqQzPsf8tqJE5H3/lMu7NW4E
 sGJdUSfG9KT+8qN6t52A5lghyS6GQeyK1+u5V2XiFfGB565zTRCgERAuc4RKsazaykELgaLT+Wf
 opCwJWnychsX25lYvqP2jHxh/8cqBerPsnoYIBq2l/xYBLOeRr2fheyvxb3E9rVOCM2bQFxGLhU
 dMEJedFsQ7+RaJ5N6sdmGP2t3tIoVWeeretMu2n/jiANjZUz44N0Zn1u25scPqUuwvewyWdKNvZ
 RUpa6KOYTD8o0qret7NV6RTZfEHgVIkJB7o3C4whucvUpGH22dcg7AqGeGJWvkuQpQmzaMGKY6z
 vNpFDvIkDHn+2+gLO5+s9X0evkV0LB+GkT/Xm3nX9G1dDMFExUypO9SXsiC1QljMs4lewRSkCEG
 NeE1YfzDtsbbyCj0Cgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090092
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Guest event entry must select BADVA0 or BADVA1 through SSR.BVS
instead of copying the stale BADVA array slot. It must also save
SSR.CFI into GSR.CFI so guest return can restore the interrupted
CFI state.
---
 target/hexagon/hexswi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 663d9fe49ea..f22d4a77516 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -809,6 +809,9 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
     gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
                     reg_field_info[GSR_IE].width,
                     GET_FIELD(CCR_GIE, env->t_sreg[HEX_SREG_CCR]));
+    gsr = deposit32(gsr, reg_field_info[GSR_CFI].offset,
+                    reg_field_info[GSR_CFI].width,
+                    GET_FIELD(SSR_CFI, old_ssr));
     env->greg[HEX_GREG_GSR] = gsr;
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS, 0);
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM, 1);
@@ -816,7 +819,8 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
     SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
     env->greg[HEX_GREG_GELR] = event_pc;
     if (set_gbadva) {
-        env->greg[HEX_GREG_GBADVA] = env->t_sreg[HEX_SREG_BADVA];
+        env->greg[HEX_GREG_GBADVA] = env->t_sreg[
+            GET_FIELD(SSR_BVS, old_ssr) ? HEX_SREG_BADVA1 : HEX_SREG_BADVA0];
     }
     env->gpr[HEX_REG_PC] = gevb + vec_offset;
 }
-- 
2.43.0


