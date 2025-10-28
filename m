Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C7BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDekL-00024n-IT; Tue, 28 Oct 2025 04:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeia-00008r-Py
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:06:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vDeiT-0001Cz-E0
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:06:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RHUbTD011771;
 Tue, 28 Oct 2025 08:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=FgHfu5vHtVD9hL+RtkDX4JU+u0S3A87S6EbZImgsy
 2s=; b=sP30pYZ6/EUTJTu7CHlsIjUAnPGtR2m4BUb2/tkj549TC+xiMNocDN9Mg
 DjrD+/y45Xr+OuJth35Ah7a1cl949k0UIJ3j3YDBOYAcwslTsAeWoA6qI8ykyQJQ
 cE/BonoP6Ylv3BfoZpOKVM331mWP+ECbM7rHJOOPs+ZhPe9Qz1Lj4Tpxr8z4bVTr
 sqmiqAd5mJIQXh2UtRIEC2RHIYqshnPYsn/xbp7MQREyg/AcX1XSgTgyuwE2KfxX
 8WZ0UXJ0lFeIT9jH6zAQmZ0RclyHBve2bGZos4YMxLk89+MEyeDpsN1xiqe/dCjy
 1iC+Gn8Q8MvCubSxKNCQ/ZzebrFIQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kytaqxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 08:06:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S52oUU006764;
 Tue, 28 Oct 2025 08:06:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk11dhm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Oct 2025 08:06:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59S85v9o30409108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Oct 2025 08:05:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C1CB2004E;
 Tue, 28 Oct 2025 08:05:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B96B20040;
 Tue, 28 Oct 2025 08:05:55 +0000 (GMT)
Received: from shivang.com (unknown [9.39.28.67])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Oct 2025 08:05:55 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: peter.maydell@linaro.org
Cc: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 shivangu@linux.ibm.com, sourabhjain@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v2 0/2] ppc: Fixes for fadump feature
Date: Tue, 28 Oct 2025 13:35:49 +0530
Message-ID: <20251028080551.92722-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tO5q6IzcA-zC_mPyuIqAcuIKrQKbiQ2r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX4aGQZSS5ZrTW
 uxaKRDbgU7Gz8o8X7x5xP6P+TCF6aA1UB/yUXapkOR763uSfTkB4ZBtMcaKoZ8Sno2QahJQ/WU6
 w9IkbXQEvtFcLSobZvqVDTdkHHSiYXK12p76SY7IZ3VsHL+s2x9577QX+mSCra57Sa4233ZCBMr
 NiGYQlFzzBeIYlF+PQxzTuW6iVLIqN4gA4ZJ0zWUH46sJjCUGsUK8VwhHjEWudikGPfTmmK7x4H
 7fzqa1/PZ4Kx9UpPjPJjCHygUjE8ZD4g44kSrrIXTEGmBrAW7rSoPAe+5QiAg2O9F51di2Vvxp8
 0+6LtClUeGQoofb49wB9h1ilI3rmd6icHsOEmrBPmQoZ94L02iTKb4P9qDqaIy4Igf9lV/1nKFA
 qCNvxeOvK66OrnG5yAGBahE2jiQl7Q==
X-Proofpoint-GUID: tO5q6IzcA-zC_mPyuIqAcuIKrQKbiQ2r
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=69007969 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=R1-Dph2nwWWnCDRWubUA:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This patch series fixes the coverity issues on the Fadump
feature patch series by Aditya [1].

[1] https://lore.kernel.org/qemu-devel/20251021134823.1861675-1-adityag@linux.ibm.com/

Changelog
=========

v2:
  + addressed review comments from Philippe

Shivang Upadhyay (2):
  hw/ppc: Fix missing return on allocation failure
  hw/ppc: Fix memory leak in get_cpu_state_data()

 hw/ppc/spapr_fadump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.51.0


