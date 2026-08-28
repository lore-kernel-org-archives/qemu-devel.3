Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73339C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzpmH-0001IF-P3; Fri, 28 Aug 2026 02:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmG-0001GO-9Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpmE-00014Q-G8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:09:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S23aqC516823
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6D51jdCOFur0DiOOi
 K8fIJ3W3ZcyUZRtpP+Rosq/x9Y=; b=e6oISo19916/7kpte2wyJ/tqrNKho/XUM
 sRUfwkFGTicYdcOnmaMaoP0v0PmikSmtJb3e//NZxRleyuBTE58HpmA+uE2y5SPF
 uSEW6DqR+3150hkx70bHhmoWmZrhgOtFDq3PjZy3RFfU+GjXiWDDSoi9jGokaP+A
 1W10Ued2SazJTS8HXlwsFHQlbj8uF10CT54IKulFyKE1VV45zSmzjo5FRS/ugnGy
 Vm5gRpCQDcC5pR6IvBBOzrXyEKt4Bz9xS8vQRor7ZJmU3+/cG97J1FCBycpwN+vQ
 4/J3dxqmIfXa9LSzXFNhgRqlT4v+VwxM0UkbJKiMBZ3qIffM4U0kA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716jadv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:09:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uGuo025178
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:09:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvggu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:09:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S69FOc40239414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:09:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9642720043;
 Fri, 28 Aug 2026 06:09:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5097120040;
 Fri, 28 Aug 2026 06:09:13 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:09:13 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 41/41] target/ppc: Add self as maintainer for PowerPC TCG CPUs
Date: Fri, 28 Aug 2026 11:37:16 +0530
Message-ID: <20260828060716.91672-42-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX8Mykeh1+7oLH
 HFoMcBCEiGnxV0enHiTd2ODv0bTtDguwtDw9UWjxbGThGCEr/xydsnSCVvLBCCOGT/p/mlXw3Wf
 Uh9GLU1hj/+U2lnKJ9RDGBH6chAADgg=
X-Proofpoint-GUID: UIuFJrbasX4TokLoA94nEWs7q8HGRLRB
X-Proofpoint-ORIG-GUID: UIuFJrbasX4TokLoA94nEWs7q8HGRLRB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX9c8tty6Zl0j/
 2Qp3eiMf/Ezf6IaOrVnfXxr5sJ9PRfU90bbWS6iyl5PymyK1BXlKbK+pJMxMGrjy3xbRr3gvmZy
 vfRAqCB5M//MWZLZ/AfVIpGh/wdkqiTjtuEsqzilj6t+kLKLAxSM8EFCf8yaJ8wFBQu5KiNH51L
 yIU49UeRK3f0UBlgxnPALy2jsxaNmWlBEN3oUOPVqk19T3eumsU5l45Zx+PhsiwPlYZ26+G5QsF
 h5cgdXFgHBuy+74SS9aBm0K1Wj6maKbeT5kWwLiWeVfFqrZu6b9PyJpk9Jf0hqVZAK4ayFrkjLg
 tFss5hDwHUgJqpOpG4veNh7D4ow5Qc6/xEf+V87qiiaznJnnaVWh9JCM0AOSb11U6xAENxWnPFO
 tjgkObZMHd6U++2GWAsZucIN+J7954MTztHtr73p88HhsifaoPczw5ZBiF2fELXBsWXYMFcsVVS
 5A3e4RfXfPW7oneT3LA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a912610 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=DMFimjnSe9RxGpnCFIEA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Chinmay Rath <rathc@linux.ibm.com>

I have been contributing and reviewing code in the PowerPC TCG CPUs
module for a long time now. Stepping up as an active maintainer to
better reflect the current status.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Acked-by: Gautam Menghani <gautam@linux.ibm.com>
Acked-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-38-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c18b8a419..4a49a40294 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -337,8 +337,8 @@ F: tests/functional/or1k/meson.build
 F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
+M: Chinmay Rath <rathc@linux.ibm.com>
 M: Nicholas Piggin <npiggin@gmail.com>
-R: Chinmay Rath <rathc@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-- 
2.52.0


