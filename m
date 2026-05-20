Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A1BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf7V-0005A3-Ug; Wed, 20 May 2026 07:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPf7Q-000516-Nb; Wed, 20 May 2026 07:29:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPf7O-0004fh-Sf; Wed, 20 May 2026 07:29:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JLiE6S552016; Wed, 20 May 2026 09:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fLZtxzPiE//1Grmg/
 9b6/lfDSHW7DBwxC8JordvpkLM=; b=OmsmAHX1x4whNGXUWG5bptoffrJIRsd79
 PFyjRgQJ2bhubbtyKzv7xF9laC0pyzZurCim7HS0HufA1YfqtTt1HjXVnoRdn+po
 pXbK0BEi7SDxEkwxe8B4bopo0/aJZ981O2XPCBfzUeWX7ots+iINOPJfylrkf44C
 /9zx0qqcXm28U4XWhB/9eJMaRUhogIgTLKoipOnoMpbszkL3o+z+Im2MQE6Ecmcb
 7dgv/hUe1PIByroKNhSOa544mdYXY1uxtTpBxUKnZ2A0h3POo/va5rn83Ca3tFIF
 3KxALiU3pCachxSXVHHcvwbBC9Qv2Gu06OHBLs7V4ocQjopTba2fQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9y1fpj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K9s6gh004432;
 Wed, 20 May 2026 09:55:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754geja3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 May 2026 09:55:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64K9tFlE41943486
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 May 2026 09:55:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B0A120043;
 Wed, 20 May 2026 09:55:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC84E20040;
 Wed, 20 May 2026 09:55:12 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 20 May 2026 09:55:12 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support
Date: Wed, 20 May 2026 15:24:46 +0530
Message-ID: <20260520095446.64206-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA5MiBTYWx0ZWRfX57wHYTpLb0EU
 UGttwwp/U4SoKcLqi8sjx11cxnVW8vE5tb2rpTXdnsYXOP80OGJNG6mcDZjszUx3wTe9CMcgyph
 LQvPVeHadUcSrueaNm/LU8RW3Uy3hnp2xOsPNlb1pnvsvv0riMtjKjNREBsur202PIrKxhhPXdd
 EOAAWXNBUuuVBBVHGLtIrDO8t7NIjyoQRdPC1wQU/WEqSuG48ooR0r7fNkZ+YNUSTz8b2xq/A/x
 XPAunzIc//Q7nOQiOZLQhyl9pedBIdOQ+WxT3p5n5wgWk+si9zFEzHkAMD20Za9+Q6dCjYc0r/f
 bBEKnNZqf/tEJagM01Q61n/x8p1RAHFdyt+hsXis4CYO2n27PtZiD/qhVjXWe/e+CRVkMpfo/8x
 TmQpKjJy2tRhO8MBmwt/DFnwlBSAS611lL5nTptBr16FPesZ3Yqdf91eO2NOj7dEfG/5Kk+GDq6
 TlQFHR28minZEZsREIw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0d8507 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=VcH14TYERV92i4gI124A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: vMORU3o3Yya-1QWTay3gV7ak3bFQNsFW
X-Proofpoint-GUID: cJxZ9t-gQKZcPQmdpr4nUZo02Y9Mj7lY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200092
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

Add a dedicated MAINTAINERS entry for hw/ppc/spapr_pci_vfio_eeh.c,
which implements Extended Error Handling (EEH) support for VFIO-based
PCI devices on PowerPC sPAPR platforms.

EEH provides error detection, isolation, and recovery mechanisms for
PCI devices, allowing the system to handle and recover from hardware
errors without requiring a full system reboot.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3d645953..03a638cab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1656,6 +1656,12 @@ F: tests/functional/ppc64/test_pseries.py
 F: tests/functional/ppc64/test_hv.py
 F: tests/functional/ppc64/test_tuxrun.py
 
+sPAPR PCI VFIO Extended Error handling (EEH)
+M: Narayana Murty <nnmlinux@linux.ibm.com>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/spapr_pci_vfio_eeh.c
+
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Aditya Gupta <adityag@linux.ibm.com>
-- 
2.54.0


