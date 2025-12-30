Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94654E9413E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 10:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaWs6-0004bz-0z; Tue, 30 Dec 2025 05:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs3-0004bW-QB; Tue, 30 Dec 2025 05:22:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vaWs2-00032x-7K; Tue, 30 Dec 2025 05:22:31 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BTFtC1L015958;
 Tue, 30 Dec 2025 10:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=wOSfhFRzRfu1eVZW/JCbw9h3oF6q
 xA6out/aHYn9308=; b=AR4bfnKUmGnDa3SoHw7XKyHCA/Q8fVrLeDLylxakJfGt
 ccWHinGRQoQvQf14dfDJwMKn/GpgwQRSj0uyh+jGWYhVCC0L47423KD+rRd+x4Lc
 ekNJ1x8iCZfe0KyCG7d+g36Q33gPalo+0vrEDiwElsNeeWP3DYVHo+9sCRfE4Gj7
 4yRrdprDH7vl9VpBQFspiSKuZOKeIGSxFPJkgPCcVWmZLXfxts9rTcI8Sy9UTVhX
 s3RPSCJVJ8Hd2TwXmE8J165i6Q6K+n1pA/WO/VvTBHmEt/ahbqVzzBEXPKy8b4+P
 pqfRz6WwTkKBr0xmKPfoojeN+4RUZNN/Vy7jnm8/Mw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjt2ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BUAFmlO001784;
 Tue, 30 Dec 2025 10:22:18 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba4vjt2dn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BU8jMuH003059;
 Tue, 30 Dec 2025 10:22:18 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bavg1s6eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Dec 2025 10:22:18 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BUAMGsN28705492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 10:22:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 589A05805D;
 Tue, 30 Dec 2025 10:22:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DA4F58054;
 Tue, 30 Dec 2025 10:22:15 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Dec 2025 10:22:14 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 0/9] pnv/phb4: Update PHB4 to the latest PHB5 spec
Date: Tue, 30 Dec 2025 04:21:18 -0600
Message-ID: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I7tohdgg c=1 sm=1 tr=0 ts=6953a7db cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=q-IcATsz3VWtJ-qQeYMA:9 a=QEXdDO2ut3YA:10 a=xUA898cCXu0A:10
X-Proofpoint-ORIG-GUID: oF-x1d5tZGNZ0BBdOUIIhUc0EjlaNo4j
X-Proofpoint-GUID: d9NFKz9lxxF85RI6lxs1NFmw-T-Cx_DQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA5MiBTYWx0ZWRfX5/y8v1AJwd4x
 WNTFgbUOHCpBQ/Gic5ygKrESmTjzowaB0l7IZ9BYEwjwiVXfEysHH+75WpxEbQIED9KF+ockSc+
 +BKp2jnMXJLo9IMSYhdXpmZWOlcERQnc9PvJnGIjl/MUvmincrcCE1zkMc/68EOix6Ff9t+74HK
 hGXLHvrSCF0+Liui4Ruri3fFy7ztkbvuJv0a6AmMDP699OCBEDu+opgMzN3U1XFhfaNv1opGOCJ
 gXLiS7aKSzqhh2httLXrcYL73EsYbLzOzt94DbQ9ZB9SzKjOPUgXdd87JBVuHXg7xDogQIL1K7y
 qpqSNtqLLwuPImiaPcCZgvaiqI6K384VhEozllhMJxZEhp5WDxamicTaq20XVpO72+tdSXPMViT
 3kCOlECY22dJuCNCAbGFet/QEJnmxUK605XECGKTSpXH4rRxHO4u6jhwp3aIYxuRmWeZDfHL4kX
 zMLzlVf0u4eLTr83Jxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512300092
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Addressing the review comments for the series v1:
https://lists.gnu.org/archive/html/qemu-devel/2024-03/msg05277.html

This series updates the existing PHB4 model to the latest spec:
"Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".

Updates include the following:
- implemented sticky reset logic
- implemented read-only, write-only, W1C and WxC logic
- return all 1's on read to unimplemented registers
- update PCIE registers for link status, speed and width
- implement IODA PCT debug table without any functionality
- update LSI Source-ID register based on small/big PHB number of interrupts

Also, a new testbench for PHB4 model is added that does XSCOM read/writes
to various registers of interest and verifies the values.

Regards.

Saif Abrar (9):
  qtest/phb4: Add testbench for PHB4
  pnv/phb4: Add reset logic to PHB4
  pnv/phb4: Implement sticky reset logic in PHB4
  pnv/phb4: Implement read-only and write-only bits of registers
  pnv/phb4: Implement write-clear and return 1's on unimplemented reg read
  pnv/phb4: Set link-active status in HPSTAT and LMR registers
  pnv/phb4: Set link speed and width in the DLP training control register
  pnv/phb4: Implement IODA PCT table
  pnv/phb4: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |   1 +
 hw/pci-host/pnv_phb4.c              | 579 +++++++++++++++++++++++++---
 include/hw/pci-host/pnv_phb4.h      |  16 +-
 include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-phb4-test.c         | 229 +++++++++++
 6 files changed, 834 insertions(+), 58 deletions(-)
 create mode 100644 tests/qtest/pnv-phb4-test.c

-- 
2.47.3


