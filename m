Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1EE606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cPDTobYU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQYcL-00075Q-Vj; Mon, 09 Nov 2026 18:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcI-00073l-4Q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:35 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xQYcF-0008HL-Hs
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 18:17:33 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9L9uph1392230
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 23:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WOsToZjxV/S
 tyWBlCAH8fYP1JTPp7quPeeXawjEduXM=; b=cPDTobYU/zhBRcTs9ocv2oKzI0S
 mryoAUkdR3i3ggE+PYbqRq28Impv8htvlt/+gQTYQ8IA9SUUWRgoWqYGVcoBgSls
 +LzMH8m/90aW+3eVb7IPFfZbG+Hc1r+c0mmooNvdmCmnwvI42cody5dZEC3hbzCr
 29/M0ymSeEHSp06jvB/smMbjs41nBjyXLGtwryo+jGs2TBvCYb9yT4XlXccg4ADa
 /zMcJEmI9JBpY+FBNGqVPsQxkb47xR1Rp27g0GwAKSucH2r/cX1bTFiTcuS3Q94o
 wIzHEyZsm4vsDboItbyGZc6C9r28KF3i+CAOziv47y+USVNUea3xYMqxpAg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5tjxc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 23:17:27 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
 by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9NHRxq2501723; Mon, 9 Nov 2026 23:17:27 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A9NHRCu2501706
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 23:17:27 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id D618A2573C; Mon,  9 Nov 2026 15:17:26 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 3/3] target/hexagon: leave stack exchange to virtual SPSWAP
Date: Mon,  9 Nov 2026 15:17:26 -0800
Message-ID: <20261109231726.4062010-4-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109231726.4062010-1-marco.liebel@oss.qualcomm.com>
References: <20261109231726.4062010-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfX5/zPSOhw/W4H
 mGAlw/vYozSSCLw7I1VxTUwlOWm96uxfM3CXAhOW0m5+3VrYbcDyIq1WOnc9r4E+SdOv9MaEmn3
 lvZZWBXrPxktFkGOkLe3mcTqOiUdeN0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5MiBTYWx0ZWRfX//eN0XwVwPSc
 JuR15FT+ZxyE3ns/5MtYQFcqD/4bwbtmcc1f1yp9+MPh9T730QazCz1GswrlS/RIPI0OnUxVulA
 3glZCQHJGUjEkYc/QVczckmwrXoe9A5U/idKiJ8MZ8wo6+MYBJVwu17FBYIS1U2NpGWAnvhsb+a
 ykBhoyfsmT6GONOJ7mcWushbwZ1Ym4ACR/MO6uURr7C4a7H9aqreVMklp5Jg0F+g5azJGaSqIK2
 EMwHnl6/+8yLZ1uGi+nT00QGNHZQDxiQElGNc1N27N0oTOG07G9Wt6QLKbGpZ5rRFnXlqpoyuFo
 BRY5pxEKB1RCMwo+Qf5b4+/N0G681Hfv6/kdIk2/oNcZRl9ALSlpljZwBbzQQf7Aqle+U6Lr2/7
 9dS8VcWZxyidv+P4/YRmXxNw7C8nn7IuVJkyw41G8xv1gBtyS119ZbK2JYqHZB7Of51wT5UIkx0
 XCWp7tq8YieDPSQLwWA==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af25487 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=PqpY7W32g4bzf9rcTroA:9
X-Proofpoint-ORIG-GUID: HbvvchdqraxR5wNWlsEnEMDqKWlSBlWt
X-Proofpoint-GUID: HbvvchdqraxR5wNWlsEnEMDqKWlSBlWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090092
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Virtual RTE must restore status and branch to GELR without swapping
SP and GOSP. An implicit swap undoes the explicit exit SPSWAP and
resumes guest user code on the kernel stack.
---
 target/hexagon/hexswi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index f22d4a77516..acc68aa6c23 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -831,12 +831,6 @@ void hexagon_vmrte(CPUHexagonState *env)
     uint32_t old_ssr = env->t_sreg[HEX_SREG_SSR];
     CPUState *cs = env_cpu(env);
 
-    if (GET_FIELD(GSR_UM, gsr)) {
-        uint32_t sp = env->gpr[HEX_REG_SP];
-
-        env->gpr[HEX_REG_SP] = env->greg[HEX_GREG_GOSP];
-        env->greg[HEX_GREG_GOSP] = sp;
-    }
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS,
                      GET_FIELD(GSR_SS, gsr));
     SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM,
-- 
2.43.0


