Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CCE606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M+X60pYq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTO3A-0001JC-Iy; Tue, 17 Nov 2026 13:37:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2n-0001Ez-3n
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:37 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xTO2i-0000ol-QK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:36:36 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFQZNq4169753
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=b4HglQ/U/rf
 q8n46lr2rKI4qtkdZzlBgfT9pOsZc2Hw=; b=M+X60pYqSoZK3UxMvBN60v70fCf
 docD3NeLXlNn7cKhn2XMbBqjLPEXQYqmx/xrlbGq0ISc9XUiWb5sLbvdO3EvyXIj
 0XuniCt7MHhwinNsIcCuHYK08FZH+NGVhz+Ur4yoCJuzf7TV+IbZpFZmb4amRtTP
 pm/f/acVG6J0Qeb9BQBtpLtfD89L7hj4RIQSfcAOI3BNRlRky6ZKIbsxOCPdql4k
 OJAWm8fj5hW61b18wr0OHPQwQ9DqIJO2ak+w8HaPB3D7rfK6xjYgEcXDlCpfAg1u
 FaEifdHrvt3vBjo6NyGh5dEUT2bQGS7RPK7T8adlqZpbyWpxjYIZxNNJrsw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hve31mj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:36:31 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
 by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHIaU0h3045984; Tue, 17 Nov 2026 18:36:30 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 6AHIaUFj3045970
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 17 Nov 2026 18:36:30 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id A3E63254EB; Tue, 17 Nov 2026 10:36:29 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH 06/14] target/hexagon: distinguish packet-page instruction TLB
 misses
Date: Tue, 17 Nov 2026 10:36:21 -0800
Message-ID: <20261117183629.2002840-7-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX8qzetDEyrhZ4
 OvbSKKTi2bpMWyMnAaJHG4JwhU/JEc05f0vIrsazshcPf5pQ/uzVdBW2oJqQE9UskzGIBstJVxX
 YYBdAcWrP5eXo/ak8rHYsvkabMXLXiU=
X-Proofpoint-GUID: W-PApgJeBnuSMLPzb3Eju_ivO7SKYlRA
X-Proofpoint-ORIG-GUID: W-PApgJeBnuSMLPzb3Eju_ivO7SKYlRA
X-Authority-Analysis: v=2.4 cv=dqhOmFg4 c=1 sm=1 tr=0 ts=6afc9eaf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=y542WfLQcSmRoA_04BIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NCBTYWx0ZWRfX9aCdyxDtJNJQ
 ZNc1NSkAYx0nZK6sXMYqC9T7jSv+G3u2T+rLYIOKFggKcZKQB7b7h4nHbj70arcFFuyWfKPVhwW
 DAoTnJmDfR5xFf9bGJKAFeTRrUO3mbDSy7kQVE6w6H5KJY2FnmofTuRW4PVTYRWZ0mT56VndQBQ
 LxObleWStgV4pDmviee8g+eRvF2Wl9zRO01XjFbvJWWM6L4RunkbAtt7lNfWMdg/kDqyk5gzGUi
 07WHHVKLwV0invqgmDlM1zPh5bKEYaS5QxYv8saDRU+Z0z1plYhWsVdbqF5ApDbfPlU4yVlqcTm
 vrRhd1NpaMe7loAG6a6sWAgZMkYXp5eGSxl9yO+pb65HhCZvS0VonXFvQgB8DguH5Y2PxMVS0sh
 87fRoENQ/3Bt8/28G0pEE4nnpDV67pE8fg+2OLiy8ADGukdhgzrSPNpbLHTM8XRikYahYMRP26L
 XKYHWiEk5Wjrry71e2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
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

A page-aligned fault address does not imply a straddling packet.
Compare its page with the packet PC page to select cause 0x60 or 0x61.

Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 3575b31d19..2f3545e0a9 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -784,7 +784,8 @@ static void raise_tlbmiss_exception(CPUState *cs, uint32_t VA, int slot,
     switch (access_type) {
     case MMU_INST_FETCH:
         cs->exception_index = HEX_EVENT_TLB_MISS_X;
-        if ((VA & ~TARGET_PAGE_MASK) == 0) {
+        if ((VA & TARGET_PAGE_MASK) !=
+            (env->gpr[HEX_REG_PC] & TARGET_PAGE_MASK)) {
             env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NEXTPAGE;
         } else {
             env->cause_code = HEX_CAUSE_TLBMISSX_CAUSE_NORMAL;
-- 
2.43.0


