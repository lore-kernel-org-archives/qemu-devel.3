Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D59CD11DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 19:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpvMo-0000wy-Ir; Thu, 28 Mar 2024 15:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rpvMm-0000vl-16; Thu, 28 Mar 2024 15:24:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rpvMj-0001RM-Us; Thu, 28 Mar 2024 15:24:47 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SJKisD014385; Thu, 28 Mar 2024 19:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WQqruD1lZOjZzWn8spIOjCc0pZx9Q4EItYOvVw3ppQQ=;
 b=pXWANVVb6DolchUFMQwT6qG4NFhKixTQsGIsRUl+l5ZgSM1ltQNZlfuuin9qw/NmSESt
 uCplzQr+ekz+TZZ7dp0eJRY2sfRzJiIchR4+nZVVSY17UWFLcvGxeDsdTq2/QyWCBRRo
 W2RWt9TtPcGXRteezIuSAPY7mqY7fPOjOQCSLcoanFYlfMi1B7zgiPnwT1IEAetn0IWT
 scjTIijShULQIuClMSfEpiHlVGzGfP+McUHCOt60U70b3+Gxd4Q59MwvzraabT+Vw3ZC
 rSS+UzuN2p4IBwfA1P4f0g9e4MGIU8DC5qS/ZFVbaqRkMqH21Gr571aTbEDWKhF/fpCw qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5dua0498-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:28 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42SJOS0r019765;
 Thu, 28 Mar 2024 19:24:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5dua0497-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42SJM4gK012965; Thu, 28 Mar 2024 19:24:26 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x29t0yp0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 28 Mar 2024 19:24:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42SJOO6N62587312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 19:24:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86BF758066;
 Thu, 28 Mar 2024 19:24:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06A4358054;
 Thu, 28 Mar 2024 19:24:24 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 28 Mar 2024 19:24:23 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 0/4] Add BHRB Facility Support
Date: Thu, 28 Mar 2024 14:23:52 -0500
Message-Id: <20240328192356.2144086-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Ol4_miF-hgmK5jxJvBA4pnnOaDgx3BR
X-Proofpoint-GUID: lXAB08f20FqFcRElrq7efthtalzxjgc0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0
 bulkscore=0 mlxlogscore=440 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403280136
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

This is a series of patches for adding support for the Branch History
Rolling Buffer (BHRB) facility.  This was added to the Power ISA
starting with version 2.07.  Changes were subsequently made in version
3.1 to limit BHRB recording to instructions run in problem state only
and to add a control bit to disable recording (MMCRA[BHRBRD]).

Changes from previous version:
 - Rebased on latest master head (req'd changing cpu_env to tcg_env)
 - Fixed compiler errors for non ppc64-softmmu targets
 - Fixed compiler errors from compiling on 32-bit platforms

Glenn Miles (4):
  target/ppc: Add new hflags to support BHRB
  target/ppc: Add recording of taken branches to BHRB
  target/ppc: Add clrbhrb and mfbhrbe instructions
  target/ppc: Add migration support for BHRB

 target/ppc/cpu.h                       |  24 ++++++
 target/ppc/cpu_init.c                  |  41 +++++++++-
 target/ppc/helper.h                    |   8 ++
 target/ppc/helper_regs.c               |  37 +++++++++
 target/ppc/insn32.decode               |   8 ++
 target/ppc/machine.c                   |  23 +++++-
 target/ppc/misc_helper.c               |  50 ++++++++++++
 target/ppc/power8-pmu-regs.c.inc       |   5 ++
 target/ppc/power8-pmu.c                |  48 +++++++++++-
 target/ppc/power8-pmu.h                |  11 ++-
 target/ppc/spr_common.h                |   1 +
 target/ppc/translate.c                 | 102 +++++++++++++++++++++++--
 target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
 target/ppc/translate/branch-impl.c.inc |   2 +-
 14 files changed, 386 insertions(+), 17 deletions(-)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

-- 
2.31.8


