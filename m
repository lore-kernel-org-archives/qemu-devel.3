Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F804C624C2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wMD-0006yT-Gj; Mon, 31 Aug 2026 03:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wMC-0006xU-1I; Mon, 31 Aug 2026 03:23:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x0wM9-0007Mv-J1; Mon, 31 Aug 2026 03:23:03 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V54Hpv1332388; Mon, 31 Aug 2026 07:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XJjAnixP4HBQQxpay
 xHuWnPscaiP4Q6HZXptSYnysDU=; b=r4B9tHSQmIJcHEJdrQ1XD480tVVS53zTA
 ZNXWi4eN9DK3z6ogJTSeGrojQm1EkSBOQuOp7RkcodrBtP80eY9At1YYpx8UhiUA
 ko/IbWuzM1kvLMdx4rTaWX1On3rrghR4MbtCxCzDMp5frPXRdqok7pntkjDwty5r
 YbtaZ1vFtaYcAVVJZ2NE7C9VPyaqE7g2A3kgS2aLYFWgYfyWuMyJThhNe/UIxky0
 TZmQCyBUAZSeF+xsJpYfm3NhA3XhuCNpbXCnoHJGdoREi5gVV32NYdFGqPA1rn3Y
 PgZ6ohRnyThDV0tzhnDM1o00jMal9/iFbCRigqpc0kQLTGKuEOn4Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2symde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V6uJih005235;
 Mon, 31 Aug 2026 07:22:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vvnc0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 07:22:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67V7MrUA41222548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 07:22:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0E9120049;
 Mon, 31 Aug 2026 07:22:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A0AF20040;
 Mon, 31 Aug 2026 07:22:50 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.3.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 07:22:49 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v4 6/6] MAINTAINERS: Add self as sPAPR EEH reviewer under PPC
 RAS
Date: Mon, 31 Aug 2026 12:49:58 +0530
Message-ID: <20260831071958.58824-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
References: <20260831071958.58824-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a952bd4 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=uPrgHAJC8kndP_WudMUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX9voYtAp87Szm
 jTWuo8J8uulIZgGastTjUms6fBGZ0VzaSpBnkFL19W/0DmLYXUcTR2lTOCfXwwOPR0dnWoIg6k4
 h1KVA+/dY+YsSPgBAD8eDpko5pqSdP8=
X-Proofpoint-ORIG-GUID: KOQ55Vy81MP1h1dSE3RC-F7uzDhzdBL-
X-Proofpoint-GUID: gY6gdkQ58foK2xR_UtFB8E4MvY1f8sBZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX7DvBKjhIYhgL
 wJMfs2eH/ooFJCVVplJ538ptrAidGd99ffDdLw18ghz8mU6JK93WbXQH/K92/O4xuvR++RrS0yb
 nIDNk4Y07c27fLpuocUY7M9HiDzw8sZdF/SetXaaJRNJhi2L1iKn2MvIvpU0rKqb711G3vhWLVc
 7VjgomwAi2XUKAED3sX7pIBg4rSy2S43grW+/c83LDqvEzOgbnNM25TMxkhc9NoTAg1KYABdbaL
 CazVRc/+Fmi+zraHDrzudoGC9o6M5MJLteqhVhjB3+2sF8IGcaySPaojUvozmbss4jOAq54Tqd6
 wIGz6Hvf5ugTtVcmWuy4U479nmw4AWk7YExKvReeK1rneK7vBq/yaZ3M73I3qWzad6QGY+ux+gl
 HieYlryqOPrBP7E6qD2TEufyA8qzrApPGWJre8MhaWLEIz0/miABwCxtTt1qVoVb3yNBKVXZjCK
 WXnUawRxpB3jO958bmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Adding self as reviewer for the sPAPR EEH under PPC RAS.
Updating the EEH specific file name as got updated in previous patches.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a49a40294..9271d849b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1770,11 +1770,12 @@ M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
 R: Shivang Upadhyay <shivangu@linux.ibm.com>
+R: Narayana Murty N <nnmlinux@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
 F: hw/ppc/spapr_fadump.c
-F: hw/ppc/spapr_pci_vfio.c
+F: hw/ppc/spapr_eeh.c
 F: hw/ppc/spapr_rtas.c
 F: hw/ppc/pnv_mpipl.c
 F: include/hw/ppc/spapr_fadump.h
-- 
2.54.0


