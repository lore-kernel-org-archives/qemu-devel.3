Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4296D1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0orf-0003kr-Sp; Tue, 15 Oct 2024 17:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0ord-0003iy-6E; Tue, 15 Oct 2024 17:13:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0orb-0000NQ-Jk; Tue, 15 Oct 2024 17:13:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKo4G8009177;
 Tue, 15 Oct 2024 21:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=8lJ4a+QbSsLYEjEVSkSj7llX3/JHamFl3OqZ9E+r/
 I8=; b=hqL/t5pEG/46JzcMPccZk/l8OM1MSSoC95a8JoZpgsvpEY1aFSEZVTKrm
 dfKykvC4MAVIkWMVAp7cXBJVKp0tpS+EePArolEEZ+3Tsm7+552jckawRGF5qoOx
 S7sHorpkBXzGKNdmJ5jriWWKdw0TCzLHy4Hmii1BxCJVK5zs4QKTHi/ZyHOiNSgv
 HVEA6OJ8PdIOmy9gcodJ9GoyRPzXe1YJTVb9lc/iySlYAqkqAGHOWqI/gCY0Qpog
 x7WiR/BjX/oaW7QEDzrCVBxzR6ucPHUGrUtWNzH6jQARUMtH2GxQNrJMxzZjOrA2
 3xzpN5gegk702zr/7/LL7BFNFzstg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429ysbr27t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLDf0t021272;
 Tue, 15 Oct 2024 21:13:41 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429ysbr27p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJQWt8006338;
 Tue, 15 Oct 2024 21:13:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650wkxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLDbdd54198776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:13:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64C222004B;
 Tue, 15 Oct 2024 21:13:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4740E20043;
 Tue, 15 Oct 2024 21:13:35 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:13:35 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 00/14] XIVE2 changes to support Group and Crowd operations
Date: Tue, 15 Oct 2024 16:13:15 -0500
Message-Id: <20241015211329.21113-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UXv-a2SMKFrR3IMrbrSVZBnj47pg7-lC
X-Proofpoint-ORIG-GUID: JPFjBF0VSNY215Jzv5cOTE6ixkKE1soc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=556 clxscore=1011 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Frederic Barrat (10):
  ppc/xive2: Update NVP save/restore for group attributes
  ppc/xive2: Add grouping level to notification
  ppc/xive2: Support group-matching when looking for target
  ppc/xive2: Add undelivered group interrupt to backlog
  ppc/xive2: Process group backlog when pushing an OS context
  ppc/xive2: Process group backlog when updating the CPPR
  qtest/xive: Add group-interrupt test
  Add support for MMIO operations on the  NVPG/NVC BAR
  ppc/xive2: Support crowd-matching when looking for target
  ppc/xive2: Check crowd backlog when scanning group backlog

Glenn Miles (4):
  pnv/xive: Only support crowd size of 0, 2, 4 and 16
  pnv/xive: Support ESB Escalation
  pnv/xive: Fix problem with treating NVGC as a NVP
  qtest/xive: Add test of pool interrupts

 include/hw/ppc/xive.h            |  35 +-
 include/hw/ppc/xive2.h           |  19 +-
 include/hw/ppc/xive2_regs.h      |  25 +-
 include/hw/ppc/xive_regs.h       |  20 +-
 tests/qtest/pnv-xive2-common.h   |   1 +
 hw/intc/pnv_xive.c               |   5 +-
 hw/intc/pnv_xive2.c              | 161 +++++--
 hw/intc/spapr_xive.c             |   3 +-
 hw/intc/xive.c                   | 182 +++++---
 hw/intc/xive2.c                  | 741 +++++++++++++++++++++++++++----
 hw/ppc/pnv.c                     |  31 +-
 hw/ppc/spapr.c                   |   4 +-
 tests/qtest/pnv-xive2-nvpg_bar.c | 154 +++++++
 tests/qtest/pnv-xive2-test.c     | 240 ++++++++++
 hw/intc/trace-events             |   6 +-
 tests/qtest/meson.build          |   3 +-
 16 files changed, 1440 insertions(+), 190 deletions(-)
 create mode 100644 tests/qtest/pnv-xive2-nvpg_bar.c

-- 
2.43.0


