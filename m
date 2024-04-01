Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52528CD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 05:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrAdc-0001fV-9i; Mon, 01 Apr 2024 01:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAda-0001ew-HC
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1rrAdY-0004UK-RU
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 01:55:18 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43153AYL028211
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2a78/MH5VwcIonY/mbwHVKg/ARYCHc2QnQm4Qv6TGgs=;
 b=BE7vKldT7xp07vZVb+9r1QmiAtp4t3tGrSk05mBPNX5wOrXecbT6ixdUy+fzCW4jNZr9
 fq63cftbrhUzoDIqx8Pwt+mH4TQCgtKe+rBcn0pHMnKH1Hbyl/q7OmNR8uVOIZDxZwPY
 h9g0xA5DpYXqjvdanx9t2NiFggf2PF9U/idk8ZVxG2snx1rARdpGttfyvXWgRzkz0Usi
 mA3tr00fjUnV6wg6Z55VXaQahtmsEvp33f9CGyXobvRo/InBMc6LpjFcKq1yPyAmwKZS
 ZWcAC0DfuKNmkgUr9Mq8AC3AQtJ6fDbx2YhK3qOJVwPsEMGxAwFO4EIHqcxFGH1JE6jw yA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7pdy82p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:55:13 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4315tDlU009287
 for <qemu-devel@nongnu.org>; Mon, 1 Apr 2024 05:55:13 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x7pdy82p2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:13 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4313oPkG025753; Mon, 1 Apr 2024 05:55:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x6x2nxh66-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Apr 2024 05:55:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4315t77d44302684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Apr 2024 05:55:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E408C2004F;
 Mon,  1 Apr 2024 05:55:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 60F0B2004D;
 Mon,  1 Apr 2024 05:55:05 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown
 [9.109.199.72]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Apr 2024 05:55:05 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 0/2] P11 support for QEMU
Date: Mon,  1 Apr 2024 11:25:01 +0530
Message-ID: <20240401055503.1880587-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: D52zoTKM-TQidJfzbO5AJJYHXEmar8RF
X-Proofpoint-GUID: dEq07Qx1t_0I5hT1ELy3sgF0Ayi01EGl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_02,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxlogscore=718
 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403210000 definitions=main-2404010039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch series adds support for Power11 pseries and powernv machine targets
to emulate VMs running on Power11.

Most of the P11 support code has been taken from P10 code in QEMU.
And has been tested in pseries, powernv, with and without compat mode.

Git Tree for Testing: https://github.com/adi-g15-ibm/qemu/tree/p11

Aditya Gupta (2):
  ppc: pseries: add P11 cpu type
  ppc: powernv11: add base support for P11 PowerNV

 docs/system/ppc/pseries.rst |   6 +-
 hw/ppc/pnv.c                | 409 ++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c           |  94 +++++++++
 hw/ppc/pnv_homer.c          |  64 ++++++
 hw/ppc/pnv_lpc.c            |  14 ++
 hw/ppc/pnv_occ.c            |  14 ++
 hw/ppc/pnv_psi.c            |  21 ++
 hw/ppc/pnv_sbe.c            |  19 ++
 hw/ppc/spapr_cpu_core.c     |   1 +
 include/hw/ppc/pnv.h        |  51 +++++
 include/hw/ppc/pnv_chip.h   |  30 +++
 include/hw/ppc/pnv_homer.h  |   3 +
 include/hw/ppc/pnv_lpc.h    |   4 +
 include/hw/ppc/pnv_occ.h    |   2 +
 include/hw/ppc/pnv_psi.h    |   2 +
 include/hw/ppc/pnv_sbe.h    |   2 +
 include/hw/ppc/pnv_xscom.h  |  55 +++++
 target/ppc/compat.c         |   7 +
 target/ppc/cpu-models.c     |   2 +
 target/ppc/cpu-models.h     |   2 +
 target/ppc/cpu_init.c       | 162 ++++++++++++++
 21 files changed, 961 insertions(+), 3 deletions(-)

-- 
2.43.0


