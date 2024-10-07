Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23689CFB448
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxppD-0002Kp-2f; Mon, 07 Oct 2024 11:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp7-0002H5-DL; Mon, 07 Oct 2024 11:39:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sxpp3-0001Up-Fc; Mon, 07 Oct 2024 11:39:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4978uWBv014928;
 Mon, 7 Oct 2024 15:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=8i+5+GtSz5gH+
 7EzCjfSswNrQ+4SBpA9kD03g52vXH8=; b=mBeztLGA5920xpYSIw8iDzwzpx+IN
 tJgA5kHLUWFsdYbcDD6sEjikqWsjHt5X7ANchR85atJp/gptrvNyWWgYgdHQf59b
 FpCG3gTHB6z8L0sPhZ94Oo9yRmeJ7IIhbhznkk7TZa2AynG3q5WJzUPmKKCxLo5f
 9iwvJCBV8mOqAWO0x/nYBDHOkhqA7ht28oaku9TsUJdw4Dmua4ZGaRifseJmaYXA
 /6jJVcbj5G0g5MGxuJ3N+mSxbwfhYpSDY0cpRn67XtSvdF/hYjzCtHa3YAS0An7B
 sFCBKnxQYu8obqO5uusirdU2+zeOjPTaSrkiMhtm6lK4hpGpjz/jTj03A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424cjm2b6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 497FY52T021349;
 Mon, 7 Oct 2024 15:38:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424cjm2b67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 497FWSWA022840;
 Mon, 7 Oct 2024 15:38:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 423jg0q3bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Oct 2024 15:38:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 497Fcg5Y52298116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2024 15:38:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CACC220043;
 Mon,  7 Oct 2024 15:38:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0A9820040;
 Mon,  7 Oct 2024 15:38:41 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2024 15:38:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
Subject: [PATCH v3 00/14] ppc/spapr: remove deprecated machines specific code
Date: Mon,  7 Oct 2024 21:08:24 +0530
Message-ID: <20241007153838.1085522-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IHFDv0-A8bkx27qN3g6t00s1ovOKt7qc
X-Proofpoint-ORIG-GUID: bm9ekJJS4D3PFKsLbLzMPOs1JfCeqx_X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=540 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410070108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

As per Qemu's deprecation policy [1], and the legacy pseries machines
being marked as deprecated in earlier commits, this patchset aims at
removing the respective code for machines which are now deprecated.

[1] https://www.qemu.org/docs/master/about/deprecated.html

v3: Addressed review comments from Cedric on v2 patchset
    Removed some more pre-2.10 migration hacks in patch 9/14
    Removed pseries-2.12 and pseries-3.10 also as due for removal.

v2: <20241001092910.1030913-1-harshpb@linux.ibm.com>
v1: <20240917060300.943496-1-harshpb@linux.ibm.com>

Harsh Prateek Bora (14):
  ppc/spapr: remove deprecated machine pseries-2.1
  ppc/spapr: remove deprecated machine pseries-2.2
  ppc/spapr: remove deprecated machine pseries-2.3
  ppc/spapr: remove deprecated machine pseries-2.4
  ppc/spapr: remove deprecated machine pseries-2.5
  ppc/spapr: remove deprecated machine pseries-2.6
  ppc/spapr: remove deprecated machine pseries-2.7
  ppc/spapr: remove deprecated machine pseries-2.8
  ppc/spapr: remove deprecated machine pseries-2.9
  ppc/spapr: remove deprecated machine pseries-2.10
  ppc/spapr: remove deprecated machine pseries-2.11
  ppc/spapr: remove deprecated machine pseries-2.12-sxxm
  ppc/spapr: remove deprecated machine pseries-2.12
  ppc/spapr: remove deprecated machine pseries-3.0

 docs/about/deprecated.rst       |   8 -
 include/hw/pci-host/spapr.h     |   5 -
 include/hw/ppc/spapr.h          |   4 -
 include/hw/ppc/spapr_cpu_core.h |   1 -
 include/hw/ppc/spapr_irq.h      |   1 -
 target/ppc/cpu.h                |  10 -
 hw/intc/xics.c                  |  16 --
 hw/ppc/spapr.c                  | 412 +-------------------------------
 hw/ppc/spapr_cpu_core.c         |  12 +-
 hw/ppc/spapr_events.c           |   8 -
 hw/ppc/spapr_irq.c              |  16 +-
 hw/ppc/spapr_pci.c              | 124 +---------
 hw/ppc/spapr_vio.c              |   9 -
 migration/savevm.c              |  19 --
 target/ppc/cpu_init.c           |   6 +-
 target/ppc/machine.c            |  70 +-----
 16 files changed, 23 insertions(+), 698 deletions(-)

-- 
2.45.2


