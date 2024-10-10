Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7B8CF07A9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sym25-0006iQ-DS; Thu, 10 Oct 2024 01:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1x-0006Wg-J2; Thu, 10 Oct 2024 01:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1sym1w-0005aq-2x; Thu, 10 Oct 2024 01:48:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A3IL2L032512;
 Thu, 10 Oct 2024 05:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=9wS78mpteStOOQjv27RSW5G5b5
 6Y8E5dNgb8riFK/p0=; b=TYwqUZZhqbHtOgq9Dfr7FTvMZyt04Ey+0YdiE9UBv8
 TPsepAoRRC28Y62Me0T+EVYHnmrHsEernIklFiOwdWmfDtsVkllW2r2ErXJbc6mc
 EFvF3E9Wj0oPoqOinavi1WDxkoPFyIiwxXu1aMdxxWgQLmjFz96Yxt7u/xUdBPMB
 S182tsHJgU16a3fnceWewY2443x6NQ8p3H3qp+VeuFN1Ffos/neoLhZjpg0C9d36
 yuamyqWPTKfm7XHUYPO9iV3w/1FAppvr9BfIFV0kYaPVJ6y2NG1Mrhlrvd6nhouN
 D6q/f2osDPUUwnrdezBhCLYZG5FsSKNbMdhdbcajp7hw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266w6rg3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A5lkWs005584;
 Thu, 10 Oct 2024 05:47:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4266w6rg3p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A1w0Ju022640;
 Thu, 10 Oct 2024 05:47:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423h9k5ug0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 05:47:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A5lia635389982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 05:47:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA06720043;
 Thu, 10 Oct 2024 05:47:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D787020040;
 Thu, 10 Oct 2024 05:47:42 +0000 (GMT)
Received: from ltcrain34-lp1.aus.stglabs.ibm.com (unknown [9.3.101.40])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 05:47:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, balaton@eik.bme.hu, danielhb413@gmail.com
Subject: [PATCH v4 0/9] misc ppc improvements/optimizations
Date: Thu, 10 Oct 2024 11:17:31 +0530
Message-ID: <20241010054740.1106997-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gKBkjcGfvqoTW6M2LgqExCfDmQrTKPHz
X-Proofpoint-ORIG-GUID: bc4t3RjyeIrE-HozORTdEag3jTBORgGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_02,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=318 mlxscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This a set of misc ppc arch specific code improvements/optimizations.
Most of the improvements are done in Power9/8/7 exception handling code
alongwith some code cleanups.

Since patch 7/7 of v2 series have been picked by Aditya in his patchset
for P11 support, I have excluded that patch in this series and based on
top of his v6 series which contains the required patch as 1/5.

Based on: <20240731055022.696051-1-adityag@linux.ibm.com>

Changelog:
v4: squashed patch 4,5 (in v3) as 4/9 (Nick)
    moved 6/10 (in v3) to last 9/9 (Nick)
    Added R-bys from Nick, Balaton.
v3: extended improvements to other Power arch p7, p8 (Nick)
    other minor improvements
v2: addressed review comments from BALATON Zoltan
v1: Initial patch

Harsh Prateek Bora (9):
  target/ppc: use locally stored msr and avoid indirect access
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize hreg_compute_pmu_hflags_value
  target/ppc: optimize p9 exception handling routines
  target/ppc: optimize p8 exception handling routines
  target/ppc: optimize p7 exception handling routines
  target/ppc: simplify var usage in ppc_next_unmasked_interrupt
  target/ppc: combine multiple ail checks into one
  target/ppc: reduce duplicate code between init_proc_POWER{9, 10}

 target/ppc/cpu_init.c    |  58 ++--------
 target/ppc/excp_helper.c | 230 ++++++++++++++++++++-------------------
 target/ppc/helper_regs.c |  19 ++--
 3 files changed, 141 insertions(+), 166 deletions(-)

-- 
2.45.2


