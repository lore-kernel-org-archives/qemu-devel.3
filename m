Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D86CE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnlK-0004jb-V5; Mon, 09 Dec 2024 19:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlE-0004iK-Ki; Mon, 09 Dec 2024 19:05:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlA-0001oE-Pl; Mon, 09 Dec 2024 19:05:56 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9NbIjD032425;
 Tue, 10 Dec 2024 00:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=0jt6cDCmJ1XykFONUOw3HWGo0fy1xe++KdqvCVEYL
 nU=; b=HyenW9ip77rRhMNLACrIbJl+q7bbt7EUXYytXYzdv5TXnOQ5RCxnJCHWr
 ORMzPKO2resC79olMz6uVdwC1RCaQD+2olqVAPsN6v0Mf3FPVinYMzaqOudXF6Yg
 eo+fgjsR9QPEYFd49qzJJ+79WX8lmrvmEd7bMR+OzF+GV6KQXVWaGpxlD52Go3cr
 Xacmkh3UpfkANhR2DrgvdESWzx78jqvF4shJcgn5YWnOdbNNUeutvbAmu28kVerk
 bgtqec1KutsQYXQaVkSth2TnDRlJnoPJhPHBe2WGDJaXPGs+RfOYc/iW8cb7YTKS
 jJu4y1q4qE1nGS09wtuf4xtiza+YA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38m56r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA03ZuI010555;
 Tue, 10 Dec 2024 00:05:40 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce38m56j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9M2ocl032760;
 Tue, 10 Dec 2024 00:05:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps985h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05aJl16515542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA5C22004B;
 Tue, 10 Dec 2024 00:05:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2269920040;
 Tue, 10 Dec 2024 00:05:34 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:33 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 00/14] XIVE2 changes to support Group and Crowd operations
Date: Mon,  9 Dec 2024 18:05:03 -0600
Message-Id: <20241210000527.9541-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PmNeZXwdNdEPBPLZwJytylYFhLNj-R2z
X-Proofpoint-ORIG-GUID: QMseO42sm8KqqYJgJ912V7bgmsB8YXKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=629
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

XIVE2 has the concepts of a Group of interrupts and a Crowd of interrupts
(where a crowd is a group of Groups). These patch sets are associated with:
 - NVGC tables
 - Group/Crowd level notification
 - Incrementing backlog countets
 - Backlog processing
 - NVPG and NVC Bar MMIO operations
 - Group/Crowd testing
 - ESB Escalation
 - Pool interrupt testing

version 2:
 - Removed printfs from test models and replaced with g_test_message()
 - Updated XIVE copyrights to use: 
   SPDX-License-Identifier: GPL-2.0-or-later
 - Set entire NSR to 0, not just fields
 - Moved rename of xive_ipb_to_pipr() into its own patch set 0002
 - Rename xive2_presenter_backlog_check() to 
   xive2_presenter_backlog_scan()
 - Squash patch set 11 (crowd size restrictions) into 
   patch set 9 (support crowd-matching)
 - Made xive2_notify() a static rou

Frederic Barrat (10):
  ppc/xive2: Update NVP save/restore for group attributes
  ppc/xive2: Add grouping level to notification
  ppc/xive2: Support group-matching when looking for target
  ppc/xive2: Add undelivered group interrupt to backlog
  ppc/xive2: Process group backlog when pushing an OS  context
  ppc/xive2: Process group backlog when updating the CPPR
  qtest/xive: Add group-interrupt test
  ppc/xive2: Add support for MMIO operations on the NVPG/NVC BAR
  ppc/xive2: Support crowd-matching when looking for target
  ppc/xive2: Check crowd backlog when scanning group backlog

Glenn Miles (3):
  pnv/xive: Support ESB Escalation
  pnv/xive: Fix problem with treating NVGC as a NVP
  qtest/xive: Add test of pool interrupts

Michael Kowal (1):
  ppc/xive: Rename ipb_to_pipr() to xive_ipb_to_pipr()

 include/hw/ppc/xive.h              |  41 +-
 include/hw/ppc/xive2.h             |  25 +-
 include/hw/ppc/xive2_regs.h        |  30 +-
 include/hw/ppc/xive_regs.h         |  25 +-
 tests/qtest/pnv-xive2-common.h     |   1 +
 hw/intc/pnv_xive.c                 |  10 +-
 hw/intc/pnv_xive2.c                | 166 +++++--
 hw/intc/spapr_xive.c               |   8 +-
 hw/intc/xive.c                     | 200 +++++---
 hw/intc/xive2.c                    | 750 +++++++++++++++++++++++++----
 hw/ppc/pnv.c                       |  35 +-
 hw/ppc/spapr.c                     |   7 +-
 tests/qtest/pnv-xive2-flush-sync.c |   6 +-
 tests/qtest/pnv-xive2-nvpg_bar.c   | 153 ++++++
 tests/qtest/pnv-xive2-test.c       | 249 +++++++++-
 hw/intc/trace-events               |   6 +-
 tests/qtest/meson.build            |   3 +-
 17 files changed, 1475 insertions(+), 240 deletions(-)
 create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c

-- 
2.43.0


