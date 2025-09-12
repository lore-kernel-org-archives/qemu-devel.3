Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79912CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 16:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux6xP-0001mQ-V6; Fri, 12 Sep 2025 12:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6xA-0001ho-45; Fri, 12 Sep 2025 12:48:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ux6x5-0008IH-Od; Fri, 12 Sep 2025 12:48:50 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CFYTT8012151;
 Fri, 12 Sep 2025 16:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=CJQMmbB8u3AkG9Z66Lzq2lfxK7HM
 AE61lRXRB04KiTQ=; b=Mg36P29v1zs2bPylyRYhrl3lD3NjTxZ9RSKa4VIUFvsk
 qVu/BKC7d/YcjvKOS7r/uVDmAodxVqeR13od5aJ867RMhc4NAH4NyzP563GsvOkB
 Z4puKtk1T8l+2JvAUNlSP8J6TvKvP5N27ilPlID0QVvovfPJMxN+N2lDklGqn/Ku
 TZoRxiXFhWEJC4mXb3Ybk/1hCnaMvFEwh96PkySwo+0eqWjltJW0NmVbH/u58VAb
 5xE3gV84AAj3FwG3HJJH7v/xRHlLvPQAXh6mXQSOV6vIVtBKMJKB3o7JQX7e1Cgr
 K9M+Mh46xWzczhm6EqVxGOuVCaB0ZUdswgwy/0uq9g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydhjg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:42 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58CGmgJq019562;
 Fri, 12 Sep 2025 16:48:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydhjg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58CDjlPu011435;
 Fri, 12 Sep 2025 16:48:41 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uv5m4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Sep 2025 16:48:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58CGme4D55837152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 16:48:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 646D558062;
 Fri, 12 Sep 2025 16:48:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECA865805A;
 Fri, 12 Sep 2025 16:48:39 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Sep 2025 16:48:39 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v4 0/9] Add IBM PPE42 CPU support
Date: Fri, 12 Sep 2025 11:47:28 -0500
Message-ID: <20250912164808.371944-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mom3rs3gW1-KdJFx6iAHckzoqrbNsZdD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfXyYHacz9fReo6
 xB1ktl3c60BFa+wVXnWPTeqzj0HnUMqtItqwxt7Vi0mnDTvNrEZmxAgWjpBhwd0MICv3aR0vUQR
 CPRoanySmQqCtd65Iaf8JYzb6l3TDWr9KlAOMsuSUpPniPB/gzp1Xh+5I5dpYip1aC0MRUvJ7sv
 AQi8qoMAO4EqH5Hp8N8i1xRbMk+ufgNxKaxHAjmbX2pchejSgT3TpYRW3VyIJSNUXa/tPBigY2Z
 4kE3oP0WWDjObV0e7q03B4yNGyzueVdmq7LI0VmY5h1CH1Q4jQNNVv2MfMn+0LZjyuElkSMtLIt
 fFX2vWpQ895sdm3FFp6OOoyqYCcqacWByE4gYicf93u7B9205C1Fxy4UlaYMXi8JCULkxXTdSSA
 DuW2q9eJ
X-Proofpoint-GUID: BwVQFRGiM5DpuQ__DOrRao9XbFIixVge
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c44eea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8
 a=jdePcm41jcmF87SOckgA:9 a=QEXdDO2ut3YA:10 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v4:
  Patch 6:
  - Removed copy of CHECK_VDR (Chinmay)
  - Refactored ld/st functions (Chinmay)

  Patch 8:
  - Removed unnecessary modules from Kconfig file (Cedric>
  - Perform ram size check earlier (Cedric)

  Patch 9:
  - Rebase required moving test into tests/functional/ppc

This patchset adds support for the IBM PPE42 processor,
including a simple machine providing a platform for
testing the PPE42 instructions.

The PPE42 processor is used as an embedded processor in
the IBM Power9, Power10 and Power12 processors for various
tasks.  It is basically a stripped down version of the
IBM PowerPC 405 processor, with some added instructions
for handling 64-bit loads and stores and some 64-bit
logical operations.
    
For more information on the PPE 42 processor please visit:
    
https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf

A functional test is included.  This test downloads a
prebuilt test image from:

https://github.com/milesg-github/ppe42-tests

Building the image rquires a forked version of an old
version of GCC, which can be found here:

https://github.com/open-power/ppe42-gcc

Thanks,

Glenn


Glenn Miles (9):
  target/ppc: IBM PPE42 general regs and flags
  target/ppc: Add IBM PPE42 family of processors
  target/ppc: IBM PPE42 exception flags and regs
  target/ppc: Add IBM PPE42 exception model
  target/ppc: Support for IBM PPE42 MMU
  target/ppc: Add IBM PPE42 special instructions
  hw/ppc: Support for an IBM PPE42 CPU decrementer
  hw/ppc: Add a test machine for the IBM PPE42 CPU
  tests/functional: Add test for IBM PPE42 instructions

 MAINTAINERS                         |   7 +
 hw/ppc/Kconfig                      |   5 +
 hw/ppc/meson.build                  |   2 +
 hw/ppc/ppc_booke.c                  |   7 +-
 hw/ppc/ppe42_machine.c              | 102 +++++
 include/hw/ppc/ppc.h                |   1 +
 target/ppc/cpu-models.c             |   7 +
 target/ppc/cpu-models.h             |   4 +
 target/ppc/cpu.h                    |  76 +++-
 target/ppc/cpu_init.c               | 241 ++++++++--
 target/ppc/excp_helper.c            | 163 +++++++
 target/ppc/helper_regs.c            |  45 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
 tests/functional/ppc/meson.build    |   1 +
 tests/functional/ppc/test_ppe42.py  |  79 ++++
 18 files changed, 1451 insertions(+), 67 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/ppc/test_ppe42.py

-- 
2.43.0


