Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55D6FD2D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzwUi-0005BL-Ju; Tue, 10 Mar 2026 08:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwUI-00055F-LM; Tue, 10 Mar 2026 08:47:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vzwUG-0003Ao-4M; Tue, 10 Mar 2026 08:47:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A99TI11605875; Tue, 10 Mar 2026 12:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9In4IW
 yOETzf1NjxZzx8uGE/CodIaAPboOABe4mb3Sw=; b=opOHh7Le3Wf1SgV2RBwnT9
 8DZQL1BCDRg5vQqgwfzbrZdMNob5k66yaLw0+/6z8t9soitmODOpTofUNuKmCvLQ
 MOhGp8y6qIdBJsxVgEcprQvkJPzmlLHWLUPydbVPeO5nP4nxaji/RWHGM7VAaK0u
 f0CijX9dOehzQJ8rdYE7XH6ofcDu+SqMQUXUsIA1JTDrRnHW1H38iM+Tvmhk9BNO
 /KZRMhVSRc2WAH3F6qm2jI9qry6Sn1MGASxYOxN6qhGVRkm1FZ5PhtX8ep9kNX7a
 ApyGYuHj67PZjsT9QNcQ4oJhhB6QYFeEXJBHhlPIVNceY6VIF3Y5U/PMCDr+m1BQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyaucu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABQiOR023007;
 Tue, 10 Mar 2026 12:46:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng21e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 12:46:56 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62ACkroW52625830
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 12:46:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F037C2004B;
 Tue, 10 Mar 2026 12:46:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C64020043;
 Tue, 10 Mar 2026 12:46:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.210])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 12:46:50 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH v5 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
Date: Tue, 10 Mar 2026 18:16:17 +0530
Message-ID: <20260310124619.3909045-11-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310124619.3909045-1-adityag@linux.ibm.com>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b012c2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=xAhUsU6pBgj2HNqxJKAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEwOSBTYWx0ZWRfX1jLMQLvvrfuD
 deKixvMvJHMGnSXO17HZYEbTTyq7IFhXJ80PZOqvBj8TZPET/gQvXhtLw4tH+15t3gyJwVqTJzW
 bezd2pZ4pvj5Sj69t2j9ITTwS05wj+LgoAyuzJuEyNAuyi2//eGr1WNhSLRSJuJhqntG1o6xWAz
 2rQw2mLWcyeGaqB143RW+2K/Zk9YZc5CLpzqJ9GLienJN224Tk6P6eQa6vfDRShyaW7+5b9qlOA
 +KT0lrzuHcaxhFaUHfHlCvqjrcA+AhiCzFpvs533Pq8rP0I2X4AzDMewbVyke1Zpo1cBgl5jTd1
 644ekiEo0acRnhr1kVaP5mjjUcKZPZOHznsUZKxp29ofKSpPVc0rABImIun7fURYTbMIKTdCWwp
 79Yw0Ex6taEptPmVIDydigy0YCTJXyeA8ewNq/tdjAU/+43YVHKSD1r5w45Ab9Ck+ihH6TuwZ1o
 r2xvQuYmToPmCnQXUDg==
X-Proofpoint-GUID: GcEuklIiEWy5R7_GSyUQSbW6j53UyZcc
X-Proofpoint-ORIG-GUID: yKNvrIsxnY2iTTeGKFFyJi__KL_sWQCd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100109
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add maintainer and reviewer for MPIPL subsystem.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6730cee490cf..a013277ccb95 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3302,6 +3302,14 @@ F: include/hw/ppc/spapr_fadump.h
 F: hw/ppc/spapr_fadump.c
 F: tests/functional/ppc64/test_fadump.py
 
+Memory-Preserving Initial Program Load (MPIPL) for PowerNV
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+S: Maintained
+F: include/hw/ppc/pnv_mpipl.h
+F: hw/ppc/pnv_mpipl.c
+F: tests/functional/ppc64/test_fadump.py
+
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.53.0


