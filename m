Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRn-0003wI-Vk; Thu, 01 Aug 2024 16:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRb-0003Kz-Sf; Thu, 01 Aug 2024 16:30:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRZ-0007KE-3j; Thu, 01 Aug 2024 16:30:38 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KI4D1001559;
 Thu, 1 Aug 2024 20:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=VK5bh0MWtT9iyy62BXZdwxCdX5
 Gk+MesFaXtA4DntRU=; b=koIrZAS/0Vq9jd2Z6T6+ioxoXz56HY+iEVrVk5Ywn1
 QvyF0LWN3M+diuuS6kcmOwmi5zMywGqFN9m4qCLSFIRwYUo7BWhpj+ajzbxoNoP+
 dHX+yIzTdNldhC+kk7uhtcqOtv80lqMHBd/25BzWpX7nBSl3dPqwEqTk0IAfjqkT
 2VEmj8nQQWRN9vbkPD3QHr5IHs7yl5c3pOZhtQ/f3CR+OrV1y8GMb42ct17tXAPV
 +WbMu8qX31I6lnz+YM9oZBMStnJXYa/2kXuCW7tVgw3B7MbvLlFRw+qP6l49UTOl
 mOdnhfkAy/6OaCYv71++jZ8ct3/wVYLwRnrxsZtOoczQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rg4805jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:26 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUQlZ021817;
 Thu, 1 Aug 2024 20:30:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rg4805j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471IFMw3011142; Thu, 1 Aug 2024 20:30:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn3pbj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUJRV52560170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B36620043;
 Thu,  1 Aug 2024 20:30:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1D1E20040;
 Thu,  1 Aug 2024 20:30:17 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:17 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 00/13] XIVE2 changes for TIMA operations
Date: Thu,  1 Aug 2024 15:29:55 -0500
Message-Id: <20240801203008.11224-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 74neHqzgsiO4M9jEXav8xbCGVubiRHAq
X-Proofpoint-ORIG-GUID: Ltc1NZk8thFRgeGQb6-usRNB_fOAY0xZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=639
 malwarescore=0 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In XIVE Gen 2 there are many operations that were not modeled and are
needed for PowerVM.  These changes are associated with the following Thread
Interrupt Management Area subjects:
 - OS context
 - Thread context
 - Pulling contexts to 'cache lines'
 - Pool targets
 - Enhaced trace data for XIVE Gen2


Frederic Barrat (4):
  pnv/xive2: Define OGEN field in the TIMA
  ppc/xive2: Support TIMA "Pull OS Context to Odd Thread Reporting Line"
  ppc/xive2: Dump more NVP state with 'info pic'
  ppc/xive2: Dump the VP-group and crowd tables with 'info pic'

Glenn Miles (7):
  pnv/xive2: Support for "OS LGS Push" TIMA operation
  ppc/xive2: Allow 1-byte write of Target field in TIMA
  ppc/xive2: Support "Pull Thread Context to Register" operation
  ppc/xive2: Support "Pull Thread Context to Odd Thread Reporting Line"
  pnv/xive: Add special handling for pool targets
  pnv/xive: Update PIPR when updating CPPR
  pnv/xive2: TIMA support for 8-byte OS context push for PHYP

Michael Kowal (2):
  pnv/xive: TIMA patch sets pre-req alignment and formatting changes
  pnv/xive2: TIMA CI ops using alternative offsets or byte lengths

 include/hw/ppc/xive.h       |   2 +-
 include/hw/ppc/xive2.h      |  18 ++
 include/hw/ppc/xive2_regs.h |   9 +
 include/hw/ppc/xive_regs.h  |  45 +++--
 hw/intc/pnv_xive2.c         |  56 +++++-
 hw/intc/xive.c              | 201 +++++++++++++++++-----
 hw/intc/xive2.c             | 332 +++++++++++++++++++++++++++++++-----
 7 files changed, 555 insertions(+), 108 deletions(-)

--
2.43.0


