Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DA5CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 20:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvi3K-0001kw-Va; Mon, 08 Sep 2025 16:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3H-0001jq-M5; Mon, 08 Sep 2025 16:01:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvi3D-0006og-HU; Mon, 08 Sep 2025 16:01:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588I8You016992;
 Mon, 8 Sep 2025 20:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=9eN1uAUhaI8f0Ht+HEdZOXleMnqXRj83pDKfxVzyd
 T0=; b=n7MHN9wUWu+d6d9n07BRos2jufEnYLUHNzASWMAWUON+aCmLK5oGwzW1q
 Klld4QAvw0WdlKJXJDUwzfFx7+4ucMtDf2G/mmQLI1QCsnlR5hXSAjs+qQZzN38z
 YEItUxCs4qvlUf5csf15qP+nqCiqZu+14v5WGSFSJ+P2z1c5JmxVUXVeg2cbB+mA
 96Sit+9jM32lL5GH9SknP7Eb88tItD8nt9OJIc6xXsUDLH+U4nc3TnfRYF/0fq5X
 WXGhdX5GF+ttlyWWrWXZTSOWFv3Axa54Xsd7vv3r7Vsbe9sJQUfUhbJgUZDJ7bTv
 2vF3q0LbX7zoeUQiaiHAjFbmrrkpQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff3pww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588K0uhh003119;
 Mon, 8 Sep 2025 20:01:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff3pwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588G4htA020458;
 Mon, 8 Sep 2025 20:01:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0quum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 20:01:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 588K19n423921334
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Sep 2025 20:01:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED2CB58059;
 Mon,  8 Sep 2025 20:01:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A01958058;
 Mon,  8 Sep 2025 20:01:08 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Sep 2025 20:01:08 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v3 0/9] Add IBM PPE42 CPU support
Date: Mon,  8 Sep 2025 15:00:10 -0500
Message-ID: <20250908200028.115789-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n6igRwhXQspQH9IdJfA-9gq2BcqlX7-4
X-Proofpoint-GUID: LPpUS5Zkqf4GLdLzLXW42M2_vYy_blQ0
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68bf3608 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8 a=jdePcm41jcmF87SOckgA:9
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfXwIseKYyog3qM
 K/N8XChaEDipMP5cvOqG+RsRfYRbQ4WCNfRnOLxP0V8zauDGLUyTbQOpmrppaWUl+Mph3JNct6m
 PHjsc/dR3DrP1GoWsfoE3KHuCNUC+3dWPULTWN+HIwpAd/yEQUZ8xcvxAi14NLNJyu5rlq0wVfS
 JAFr3660RUtaLunZgKF/Vpu7TvCwf8tYEHXSCmhZVtzrMCcV54slhyD/0gT7DjGI9v0jxhBjlNs
 VGmuDMDX0JU3Z0Qpnej3hri9AqqLV5d740AkFE+qtGzIGAdSHfXO0/U7hF0SQHP/DstxrNstlCP
 PF0srsQBBPvlXzOamP4+YeGDV2VMc5spSGnKt+JAaDKwhVCam+LmurWHiVX2u3vV+CYbIuojk91
 KKrqy7f/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020
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

v3:
  - Split v2 patch 1 into smaller patches 1 through 5 (Cedric)
  - Moved special PPE42 decrementer support into distinct patch (Cedric)
  - Introduced a specific MachineState for the ppe42 Machine (Cedric)
  - Use qdev_realize to create the machine (Cedric)
  - Use valid_cpu_types to determine validity of CPU (Cedric)
  - Changed machine ram limit from 2GB to 512KB (Cedric)
  - Utilize the TRANS macro to reduce TCG code (Chinmay)

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
 hw/ppc/Kconfig                      |   9 +
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
 target/ppc/translate/ppe-impl.c.inc | 663 ++++++++++++++++++++++++++++
 tests/functional/meson.build        |   1 +
 tests/functional/test_ppc_ppe42.py  |  79 ++++
 18 files changed, 1453 insertions(+), 67 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/test_ppc_ppe42.py

-- 
2.43.0


