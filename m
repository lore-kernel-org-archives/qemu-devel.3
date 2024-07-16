Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646B5C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 19:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sToIQ-0004SW-OD; Tue, 16 Jul 2024 15:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIN-0004JY-Gb; Tue, 16 Jul 2024 15:57:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sToIL-00068P-Bb; Tue, 16 Jul 2024 15:57:07 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GJU75Z007026;
 Tue, 16 Jul 2024 19:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=GDUs+6LsRPBNpMSc4fCR4NkoI/
 qg1HFJmV36lAxkUIo=; b=WztcjtnhZlVZGnvccJAEh1w4PuESVwZPqB3DDE/xz5
 NzOMeW4XUs4eF7JxxxjEY+VtfrL/+nmYRXK8q16O6Hl/2JBVN8tFCeAoStxuhWEV
 64zvWqel1u480V6iy7KTDiB3PxzzmWx9eXIv84Vk7WJF9N0u38TM1xjlXJizYHO7
 rB8HitE0TtYVgKev4ereL3tqjDLEBvRDQyasnXZISIY/EahzeGOyZX6RNzzGPOEP
 EvCx+swG1jsIyKquYnEW3b2rlreO4mSvyondy0PaeOXRs3hLI3oXsXX1OF+YvX2I
 WVOS7h92TXH3OeP3FEbvBpS1ZSiOh3LMbwFJ3nLCrH7Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dy20r1u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:53 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46GJurJU012604;
 Tue, 16 Jul 2024 19:56:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dy20r1tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46GHnA0u006109; Tue, 16 Jul 2024 19:56:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkm8g9j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jul 2024 19:56:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46GJukGG10682646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 19:56:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D823B20040;
 Tue, 16 Jul 2024 19:56:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AB7F92004D;
 Tue, 16 Jul 2024 19:56:45 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jul 2024 19:56:45 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 0/9] XIVE changes for Cache Watch, VSTs, STT and info pic
Date: Tue, 16 Jul 2024 14:56:24 -0500
Message-Id: <20240716195633.12679-1-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OJVa2nc3Vop2kuShZRffKHuKv7uxQr2l
X-Proofpoint-ORIG-GUID: TxaT9wJR0I_x8lUypopulNt_Mt7lF0wC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=563
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407160144
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

These changes provide enhanced support of the External Interrupt Virtualization
Engine.  The changes are focused on the following areas:
 - Cache Watch, Cache Flush and Sync Injection
 - Virtual Structure Tables
 - Set Translation Table
 - 'info pic' command data that is dumped

Frederic Barrat (7):
  pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
  pnv/xive2: Add NVG and NVC to cache watch facility
  pnv/xive2: Configure Virtualization Structure Tables through the PC
  pnv/xive2: Enable VST NVG and NVC index compression
  pnv/xive2: Set Translation Table for the NVC port space
  pnv/xive2: Fail VST entry address computation if table has no VSD
  pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c

Michael Kowal (1):
  pnv/xive2: Structure/define alignment changes

Nicholas Piggin (1):
  pnv/xive: Support cache flush and queue sync inject with notifications

 hw/intc/pnv_xive2_regs.h    | 108 +++++++
 include/hw/ppc/pnv_chip.h   |   1 +
 include/hw/ppc/xive2_regs.h |   9 +
 hw/intc/pnv_xive2.c         | 566 ++++++++++++++++++++++++++++++------
 hw/intc/xive.c              |  12 +-
 hw/intc/xive2.c             |  33 ++-
 6 files changed, 633 insertions(+), 96 deletions(-)

--
2.43.0


