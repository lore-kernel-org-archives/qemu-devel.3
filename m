Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C510C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SV5-0002Rc-Vj; Tue, 01 Sep 2026 13:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUr-0002MV-Ug; Tue, 01 Sep 2026 13:42:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1x1SUp-0001Cp-Lt; Tue, 01 Sep 2026 13:42:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H59sB4103685; Tue, 1 Sep 2026 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0QrwSQeR0N20e1F+N
 zsy8JTAu4+yKFP9WP/PCl0+8MY=; b=T3BT1SpcK6mW4dubXbvQQMq7MnjOCnpNp
 utGEpOXq/HCBIjF/+Ys6ktq8Eap6fr/3SIStmkJeYaFeIoTbPk1Zkn+p0gs5vxLE
 DhLWKquSzqNfB4Yuyj8O0lBBdGOYmIcLvBkUSkxyqg9ZLfR5hWHK2RgpYoVgS6l/
 AVvoIv2KdMN3z7BHcSAc54S8ITtyTmIUhd3++6xSM5DmVLHFQnaU5eZUpcuTjaak
 aQ5a9Ez6OidbdWEiuG0hNP6KOUBLqdhXT/qr8LPxkZ1U4x+hK39VU6h6/aV7sxIB
 86geZE19FD5TbltDy/33qDjLFY4buDMV9hnD2EL7NQp36lr4cM1Uw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r9esq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:42:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HQGUN026037;
 Tue, 1 Sep 2026 17:42:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark52as-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 17:42:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 681HfwGH36635118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 17:41:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A0FB2004E;
 Tue,  1 Sep 2026 17:41:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B056220043;
 Tue,  1 Sep 2026 17:41:54 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.219.126])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 17:41:54 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mahesh@linux.ibm.com,
 sbhat@linux.ibm.com, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
Subject: [PATCH v5 6/6] MAINTAINERS: Add self as sPAPR EEH reviewer under PPC
 RAS
Date: Tue,  1 Sep 2026 23:11:10 +0530
Message-ID: <20260901174110.45356-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a970e6d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=uPrgHAJC8kndP_WudMUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX3wIYsaVwU8Ev
 BmfcfKtOhkoZheM4WIt5Dohm1yjhYK6dWUoqJQm52GNPGCUAfglJdUXTERGBVNwVPI4MslwdOMD
 D346KxFWov66pl71rZ51xmh/x19F6WEfxnFFROiL3PMRJjaYBu0O2ptFeO6I9jIcCjgRcWnly8u
 g/5HIJx+yeU+hx/sKK2Bd2XYJTviG4oGpZPhojd1If+ME3s8P2V8ZWmUx3dt78jsab0RQxP3Tol
 RgQAhGmOS+QDrgHuwnahN2s8dprF2FLBTsjE6Js0igjOf2BYzjYr9Ab/663ZUxv4kxySFrNZMgL
 3Jl4TIGwHScRqDRujdYYR7ALltLjDV3h2j67l34wUA5C5qLdLNtC4EyQf5UjUgfKjx9yZzC7b4p
 NyhpqCuONuL9DgWKSiE1HCPW1m42ffkiWlwTknd1fW32JiuRxHcGIEZ26H2+EIjcwem9G3rEp8U
 8NNDVVD/WeIxEEVjb5A==
X-Proofpoint-GUID: al1gmiawX35B4ef9Ef6MOmbqMz6V4N87
X-Proofpoint-ORIG-GUID: Tov-IPP0wpwkFLFjXRUV1KC9P6E01auc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX87cQk8qLH1kp
 iGiGLQ7p1Xz21FhxmXNESyKu+7Ntsy4bjTQnFkxcXlYkQnW+ft+Lw1hnVAUCh+YRSZRbwaDQCZA
 DaXqzR8Oqx/cKkXshhb4ssq1kgLoYEQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a49a40294..581c109392 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1770,11 +1770,13 @@ M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
 R: Shivang Upadhyay <shivangu@linux.ibm.com>
+R: Narayana Murty N <nnmlinux@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
 F: hw/ppc/spapr_fadump.c
 F: hw/ppc/spapr_pci_vfio.c
+F: hw/ppc/spapr_eeh.c
 F: hw/ppc/spapr_rtas.c
 F: hw/ppc/pnv_mpipl.c
 F: include/hw/ppc/spapr_fadump.h
-- 
2.51.1


