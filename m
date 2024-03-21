Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0D7C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFI8-000702-6S; Thu, 21 Mar 2024 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI5-0006z9-EG; Thu, 21 Mar 2024 06:04:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI4-0007Yj-0g; Thu, 21 Mar 2024 06:04:53 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L909GO029214; Thu, 21 Mar 2024 10:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wVLaWr76AoctQk49cJDQDzreMkcU6eOg5rvm4HCvmvM=;
 b=duJvqyjXTnEWwlSoesSbAQQexIyPnuUbMgtvLDhCFVnSK5R2bZrBO62TrDjc5Oe9K5sd
 xopxvrSJBd0wpK50XX6js4IQXy6HqPthKfCkuF/JOyPPMNf07GiyqdZv9DUnGBv62qqm
 +TWd4gyRFaf9wGcGcUhszLXWWXEE7dI/bj3Jv1pamqpw9p3u1/BGKcLT+GqkeL9TUYdA
 LxOKScg7xsXarj/tvba+sGMjb+mejdfbVQ0q/75nKdZUWkQopbHPjtvY2OYO1/oU/HMO
 Mdu9d44Gh4Hd7RE755sImeg0qBRvUoON5TpGBtbuRKuxzoklUGO+D9+bSWLEd0YD/8yd gQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hvg84v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:37 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LA4bXk020292;
 Thu, 21 Mar 2024 10:04:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0hvg84v0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:37 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L8t9uv015781; Thu, 21 Mar 2024 10:04:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wwp50cfk0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:36 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LA4X0H16188048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 10:04:35 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8009758056;
 Thu, 21 Mar 2024 10:04:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C6AD5805A;
 Thu, 21 Mar 2024 10:04:33 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 10:04:32 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH 00/10] pnv/phb4: Update PHB4 to the latest spec PH5
Date: Thu, 21 Mar 2024 05:04:12 -0500
Message-Id: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FAejxHE-HZ0nvWfeDt4fefPGh_vuaM52
X-Proofpoint-GUID: kUoUT43k_OCnnCqYUc-PCO2s33WeV6wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=829 priorityscore=1501 clxscore=1011 mlxscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210069
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,

This series updates the existing PHB4 model to the latest spec:
"Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".

Updates include the following:
- implemented sticky reset logic
- implemented read-only, write-only, W1C and WxC logic
- return all 1's on read to unimplemented registers
- update PCIE registers for link status, speed and width
- implement IODA PCT debug table without any functionality
- set write-mask bits for PCIE Link-Control-2 register that is read/written by PHB4
- update LSI Source-ID register based on small/big PHB number of interrupts

Also, a new testbench for PHB4 model is added that does XSCOM read/writes
to various registers of interest and verifies the values.

Regards.

Saif Abrar (10):
  qtest/phb4: Add testbench for PHB4
  pnv/phb4: Add reset logic to PHB4
  pnv/phb4: Implement sticky reset logic in PHB4
  pnv/phb4: Implement read-only and write-only bits of registers
  pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
  pnv/phb4: Set link-active status in HPSTAT and LMR registers
  pnv/phb4: Set link speed and width in the DLP training control register
  pnv/phb4: Implement IODA PCT table
  hw/pci: Set write-mask bits for PCIE Link-Control-2 register
  pnv/phb4: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb4.c                    | 601 ++++++++++++++++++++--
 hw/pci/pcie.c                             |   6 +
 include/hw/pci-host/pnv_phb4.h            |   9 +
 include/hw/pci-host/pnv_phb4_regs.h       |  66 ++-
 include/standard-headers/linux/pci_regs.h |   3 +
 tests/qtest/meson.build                   |   1 +
 tests/qtest/pnv-phb4-test.c               | 177 +++++++
 7 files changed, 805 insertions(+), 58 deletions(-)
 create mode 100644 tests/qtest/pnv-phb4-test.c

-- 
2.39.3


