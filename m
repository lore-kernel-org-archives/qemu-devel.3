Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4F9FC6165
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8zE-0006NP-AC; Fri, 13 Sep 2024 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8z4-0005qz-1M; Fri, 13 Sep 2024 12:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8z2-0006jb-4h; Fri, 13 Sep 2024 12:17:21 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBYa3003690;
 Fri, 13 Sep 2024 16:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=XmvU8qCvVzU0MF2i0QpXEoBFpI
 CWtORXT5pbPcOicE8=; b=PJLpaIjYk1LKDMgpNZ4QlbD8BTUvf/kuZbtAD5jrVM
 juxSbZr8zMBqEZQXzXk1tmYHUyvMgxO1ynYuoPGxKpfxBSMQMSptXEbrl3cbUpgI
 91dxXP15V72Df3FL7wJ7eezQZPI0sS+m0ET+YqLrd16m5IptDrgUrNW7+nYARU8Z
 CGorO+4uxvCeWQ1+iNo8XTRTYyewRCAUXUpdEfVDekhWGe0jwl+wzifrE/WmIAU4
 7UeKgCLO5UX75SzgSBSXipl05MhECKrJsxwt2prPPycQMDa/S4XQaxoFrMgWADqG
 p0dz2w6hvA1iF8Xt71jrWZJvGAWgMNbUrsGf8z5FzfZw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejb39m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGDG2A005955;
 Fri, 13 Sep 2024 16:17:10 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejb39m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFh8hn013566;
 Fri, 13 Sep 2024 16:17:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmq30q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DGH6Hh38732148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 16:17:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C032004D;
 Fri, 13 Sep 2024 16:17:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E74B120040;
 Fri, 13 Sep 2024 16:17:04 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 16:17:04 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 00/14] XIVE2 changes for TIMA operations
Date: Fri, 13 Sep 2024 11:16:45 -0500
Message-Id: <20240913161659.1981-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tAkt1Cn9pRymEZt42Tzx62huAtaiplAx
X-Proofpoint-GUID: farvDHPy9CUfKBfoIBO4_NvluwHqbYse
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=718 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

version 4:
- fixed rebase error in patch set 9 xive2_cam_decode().  Complete changes
  for this are in patch set 10.
- version 3 reviewed tags:
  - added 10/14

version 3:
- moved some of ring functions from patch set 9 to 10
- version 2 reviewed-by tags:
$ b4 am 20240909211038.27440-1-kowal@linux.ibm.com
Grabbing thread from lore.kernel.org/all/20240909211038.27440-1-kowal@linux.ibm.com/t.mbox.gz
Analyzing 23 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
---
  [PATCH v2 1/14] pnv/xive: TIMA patch sets pre-req alignment and formatting changes
  [PATCH v2 2/14] pnv/xive2: Define OGEN field in the TIMA
  [PATCH v2 3/14] ppc/xive2: Support TIMA "Pull OS Context to Odd Thread Reporting Line"
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 4/14] pnv/xive2: Support for "OS LGS Push" TIMA operation
  [PATCH v2 5/14] ppc/xive2: Dump more NVP state with 'info pic'
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 6/14] ppc/xive2: Dump the VP-group and crowd tables with 'info pic'
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 7/14] ppc/xive2: Allow 1-byte write of Target field in TIMA
  [PATCH v2 8/14] ppc/xive2: Support "Pull Thread Context to Register" operation
  [PATCH v2 9/14] ppc/xive2: Change context/ring specific functions to be generic
  [PATCH v2 10/14] ppc/xive2: Support "Pull Thread Context to Odd Thread Reporting Line"
  [PATCH v2 11/14] pnv/xive: Add special handling for pool targets
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 12/14] pnv/xive: Update PIPR when updating CPPR
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 13/14] pnv/xive2: TIMA support for 8-byte OS context push for PHYP
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH v2 14/14] pnv/xive2: TIMA CI ops using alternative offsets or byte lengths
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>

version 2:
- use dma_memory_write() instead of cpu_physical_memory_write()
- use ternery operator in NVG/NVC pnv_xive2_vst_read/write()
- removed xive2_nvgc_set_backlog() until it is needed
- re-defined word 2 valid bits since it is the same in each Reporting
- provided better fix for possible NSR operation overflow
- moved changes for operations that can occur on ring, in a new patch set (10/13)
- version 1 reviewed-by tags:
$b4 am 20240801203008.11224-1-kowal@linux.ibm.com
Analyzing 35 messages in the thread
Analyzing 0 code-review messages
---
  [PATCH 1/13] pnv/xive: TIMA patch sets pre-req alignment and formatting changes
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 2/13] pnv/xive2: Define OGEN field in the TIMA
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 3/13] ppc/xive2: Support TIMA "Pull OS Context to Odd Thread Reporting Line"
  [PATCH 4/13] pnv/xive2: Support for "OS LGS Push" TIMA operation
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 5/13] ppc/xive2: Dump more NVP state with 'info pic'
  [PATCH 6/13] ppc/xive2: Dump the VP-group and crowd tables with 'info pic'
  [PATCH 7/13] ppc/xive2: Allow 1-byte write of Target field in TIMA
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 8/13] ppc/xive2: Support "Pull Thread Context to Register" operation
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 9/13] ppc/xive2: Support "Pull Thread Context to Odd Thread Reporting Line"
  [PATCH 10/13] pnv/xive: Add special handling for pool targets
  [PATCH 11/13] pnv/xive: Update PIPR when updating CPPR
  [PATCH 12/13] pnv/xive2: TIMA support for 8-byte OS context push for PHYP
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>
  [PATCH 13/13] pnv/xive2: TIMA CI ops using alternative offsets or byte lengths
    + Reviewed-by: Cédric Le Goater <clg@redhat.com>

Frederic Barrat (4):
  pnv/xive2: Define OGEN field in the TIMA
  ppc/xive2: Support TIMA "Pull OS Context to Odd Thread Reporting Line"
  ppc/xive2: Dump more NVP state with 'info pic'
  ppc/xive2: Dump the VP-group and crowd tables with 'info pic'


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

Michael Kowal (3):
  pnv/xive: TIMA patch sets pre-req alignment and formatting changes
  ppc/xive2: Change context/ring specific functions to be generic
  pnv/xive2: TIMA CI ops using alternative offsets or byte lengths

 include/hw/ppc/xive.h       |   2 +-
 include/hw/ppc/xive2.h      |  18 ++
 include/hw/ppc/xive2_regs.h |  25 ++-
 include/hw/ppc/xive_regs.h  |  45 +++--
 hw/intc/pnv_xive2.c         |  44 ++++-
 hw/intc/xive.c              | 201 ++++++++++++++++++-----
 hw/intc/xive2.c             | 317 ++++++++++++++++++++++++++++++------
 7 files changed, 537 insertions(+), 115 deletions(-)

--
2.43.0


