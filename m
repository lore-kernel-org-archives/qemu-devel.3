Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D40CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJNU-0007NQ-E9; Thu, 18 Sep 2025 14:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJN3-0007Hg-PO; Thu, 18 Sep 2025 14:28:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uzJMz-0006Q2-UH; Thu, 18 Sep 2025 14:28:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEnEk1028332;
 Thu, 18 Sep 2025 18:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=No5lPYj+EeBvzFq5VG0D+mNzOYbM
 VP8QEtx4i7chYx8=; b=EhX+cdeyZ34q2dLfa/DOKi7ghTvfKellWslnvl0uWloN
 myHw0xQxPF38uelFSwsnvHXCrOO/nm6TMuNVbkanbRd7DR4emjJbmmxHoA0Drbc6
 vNL7DNjZdQ6SI5QyRKXkzjY1rzA5vCYzwNacaCf1nk4mqcis96OTrxS7lyMrOxQ4
 gcTP1tSG71uUu9FBTMkcACH04oCY9Ef73CM8lvEZ9+G+54bjJ5GDVMsSPYGU8USN
 HtzQZIYGOiywNMgWwWLVESXt0/Kv3wh8G0QERIIlzRe3YD6y+wqT50+x0z+e7TXo
 4WGBMKsG9KwKjyjGNCy4fOXXhj/MYJJgy+Vj5+gN9g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc76e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IIPmh6002425;
 Thu, 18 Sep 2025 18:28:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc76b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58II91DB009367;
 Thu, 18 Sep 2025 18:28:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3quxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Sep 2025 18:28:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58IIS0lm25166280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 18:28:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78C5758059;
 Thu, 18 Sep 2025 18:28:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC4C258058;
 Thu, 18 Sep 2025 18:27:59 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Sep 2025 18:27:59 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v5 0/9] Add IBM PPE42 CPU support
Date: Thu, 18 Sep 2025 13:27:07 -0500
Message-ID: <20250918182731.528944-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXzA2N5LZTZvyh
 6w82i091d3E8ZqoyrUYqdTM6GzzXXarwstqBn2sb4Pf7v2jowiuy4bS/snTeQrMdMcWoKDLflr8
 vBas6Y3GVk7vPMSExpVt6PoYhnBbzcI4euQtmlpsKehq/nbXGOozj7w1ieK+DNBdmLV4GSKAHdJ
 rgHliif9duxqqPrvrv8LYp9un02Oz+nPPwuCgrWCLGy2ltUlPX0XWrnzHDBM/HrMEm0e2zQeA0i
 qiofDPvqDylkJGNkOQuj+aXf5g1hNXSBSIN7e7vCDLmfIOqTGrnZb8mGzhX6AdbANbUgWjz1nXe
 fNp1RLJObXEeG2gggxMvyGYLFnKIA9uxRSzwmg6JYkRko1M7mkSCUcFFgL54zJ1O6CqZvZ64hh6
 tfCRHBd8
X-Proofpoint-ORIG-GUID: X4ZLAdpPdeKtrwVZkSAWLq1IUv8ueYem
X-Proofpoint-GUID: 0DqgGeJlYl-DcDTYpNWRDGM_3gCuUc2q
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc4f34 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8
 a=jdePcm41jcmF87SOckgA:9 a=QEXdDO2ut3YA:10 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

v5:
  Patch 6:
  - Added ability to run in TARGET_PPC64 context (Thomas)
  - Verified 32 and 64 bit targets compile with clang (Cedric)
  - Verified PPE42 test passes in 32/64 bit contexts

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
 target/ppc/cpu_init.c               | 241 +++++++++--
 target/ppc/excp_helper.c            | 163 ++++++++
 target/ppc/helper_regs.c            |  45 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 610 ++++++++++++++++++++++++++++
 tests/functional/ppc/meson.build    |   1 +
 tests/functional/ppc/test_ppe42.py  |  79 ++++
 18 files changed, 1396 insertions(+), 67 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/ppc/test_ppe42.py

-- 
2.43.0


