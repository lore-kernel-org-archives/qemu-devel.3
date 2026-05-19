Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4E3CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHm4-0001rY-Rp; Tue, 19 May 2026 06:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHm3-0001qR-He; Tue, 19 May 2026 06:34:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wPHm1-0005Mx-Sa; Tue, 19 May 2026 06:34:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J85YjB2561525; Tue, 19 May 2026 10:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fLZtxzPiE//1Grmg/
 9b6/lfDSHW7DBwxC8JordvpkLM=; b=Us6JG5cm5Ps6qUrVFV7ZjuF1iXzPIAutY
 KZAwOfXckXxOpuplGAv4LIGVjojm2Tix0Exa54QH4VhGCasWs7FRXG7b2g6F05CG
 Xk+XJWJqUYaudN+LYN+Z/Lc5zsdG5Z2pzl8gtzJAEBvOnM7+3J+jsyP7R4ystdra
 GMnFy2cViAU4oGPRsSB/5SyKm+r0rKjpKq9VhFNuiVX2b2jnEr3Elktw4HoiAIVK
 HxDSaIBjKLSvip+uRX3G9cEjHLwZWw1T4FbM5sfnCZQ6W2wweKsnLIRq8NDwdd/F
 5C3kkbaV4VRxlVWysDpJb6x49N5Mi8ZzZJgSkzBBLpIh4Xf1XUNqA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mmdu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:34:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JAOAhB027407;
 Tue, 19 May 2026 10:34:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky1tyv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 10:34:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64JAXwKt44630452
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 May 2026 10:33:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 922FB20043;
 Tue, 19 May 2026 10:33:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CDEE20040;
 Tue, 19 May 2026 10:33:56 +0000 (GMT)
Received: from dhcp-9-123-10-31.bl1-in.ibm.com (unknown [9.123.10.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 May 2026 10:33:56 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support
Date: Tue, 19 May 2026 16:03:24 +0530
Message-ID: <20260519103325.8056-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
References: <20260519103325.8056-1-nnmlinux@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: moBvh3zeXDNcHQsrB6V7jTJDHCBWDml0
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c3c9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8
 a=VcH14TYERV92i4gI124A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: cTc5-aWEzMvGJ9hV_zlODUSzIoHugTtW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA5OSBTYWx0ZWRfX1Mxzyaqp3FNM
 bFLm02EdXGg7FLhWJasjebwRuWmZTweOUw5RodoP1jl9BZf7+/050p/bzxfHe95PFULvVZ4zrxF
 F9OEmQpoAVzd7PHXLuGPV0p7IyH3el4VjkyADkzswVYJdwPHRpKQXN2WfiDvftt0Zol+x2Wf7LE
 GMSJrxzHreHH41AUqVY17lWKvdVL9oangw+aCzMB/YmkVN3Srt3aBClVPGnGTrOxjmL8Ri1W6o3
 yGKSWxXLLrUJkdGoUw/pQAg8XpZ8Hh4qvcQdphxqsqUpk7qfYVt3v5nw8Hx0zwMiqTUYjuW7ZC1
 5o1jnvFXgb0aTRktiL+L0m1QI2Q2r3mTUWFK0HG3gWSYHrtAVRTaEEpoBudhNCEERFmmF98UVr7
 EbIuXks5ZCds0wQepptVJqcx1IOt7GroQN771NJNnDaTliK68nfpovOA7xukNNOiu2FfZCrbMN5
 cOD7+f1dtV11pZBXlug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190099
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


