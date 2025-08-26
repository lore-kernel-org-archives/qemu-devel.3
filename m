Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981A9CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 20:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur0AT-0004VK-R0; Tue, 26 Aug 2025 16:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0AN-0004UI-W8; Tue, 26 Aug 2025 16:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1ur0AJ-0004vP-Rr; Tue, 26 Aug 2025 16:21:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFgIm4019325;
 Tue, 26 Aug 2025 20:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=5oa5t5MiTj/0Lc0F4RJztFGMG6R/CmhtEtVE7Ssnu
 gY=; b=h3+OEOwbEUlrYIv00IEwVgwOc4ZQlm4xxKCr9MCMpWKFvu4XURUsE2fnT
 lSaxKlZI8iHqGMRzJc2l0MgvB3DkBwO5Pcbwxm9X6gCDhB2cEm7vJLu/8gSsUl3B
 uW/xm25MSX1/2sqh+34kaqdc9vWnUg9MhyjAYBr/wT+klKLWFg+HmwOiRxDeG8qz
 XrLg9n4L5iwxrYMWeHkvGXdkMwgU+aOqef1/0Gzgf4D1h1kkN8wfUdb1ChhwVk5U
 WDvnchLV36vRjN7Z9lJpCUmW7wIClJkVNtcou+JFQmos+EGA3BmOrv3uBeVGOOJj
 XTtmKLMG0TZPEo3HdhOLZaJeZrf2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q97583ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:20:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57QKKjcN018331;
 Tue, 26 Aug 2025 20:20:45 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q97583ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:20:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QH3umq017974;
 Tue, 26 Aug 2025 20:20:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3c93h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 20:20:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57QKKhaL22282788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 20:20:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 242205805D;
 Tue, 26 Aug 2025 20:20:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68FFA5805A;
 Tue, 26 Aug 2025 20:20:42 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Aug 2025 20:20:42 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v2 0/4] Add IBM PPE42 CPU support
Date: Tue, 26 Aug 2025 15:17:47 -0500
Message-ID: <20250826201920.335308-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IaiiwA6ZhXNYsDKNgZfvX9r_DmahQ1SH
X-Proofpoint-ORIG-GUID: jb9jnROawLZznZfrggDex-KzSHx_31M-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA3MSBTYWx0ZWRfX1x+p9bOkCbbi
 w+kvWa1Y7wjAjVYvZ2VfYaKarzffXMSAusqvgI+MFGtQnYt2vjxsTwp/0iT2tT276W6ippXC5DG
 Lq8Kgy8s5NeL7xgwl/TUxaHr+mdnnAOx7QcRi50LMzeMMb0GqKWjRlkAgZCktLrhl2+00YvBsaX
 SXJtD59wH6DySOwOdHMlabXS8+yhcQB7ZHh3e62v0yR3hcPw3CYvfkRGEMvBlFqPGO6WGhArqir
 W2WwUSOaaONSdvwqoFnO4GQCw8i3Gw7MTwtCHtk885B9J2YPmvtERaKavXxX4sCVVAuwPd/zZMo
 4SN1w5Xmp19v6dM49x5wd8jratCy2uQHvV56B7Vazjod2sCGYsWHZW6oCtCghMQ3bKahxbbr3kd
 voGkdwTM
X-Authority-Analysis: v=2.4 cv=RtDFLDmK c=1 sm=1 tr=0 ts=68ae171e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8 a=jdePcm41jcmF87SOckgA:9
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230071
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

v2:
  Patch 1:
  - Added "32-bit" wording to commit message
  - Added 'unlikely' specifier to hreg_compute_hflags_value conditional
  - Added PPE42_ prefix to ISR definitions
  - Moved ISR_MCS* definitions from excp_helper.c to cpu.h
  - Moved common target/ppc/cpu_init.c code to a common function
  - Added 'likely' specifier to gen_mtmsr conditional
  - Formatting changes to fit comments within 80 character limit

  Patch 3:
  - Added hw/ppc/ppe42_machine.c to MAINTAINERS (myself as maintainer)

  Patch 4:
  - Added tests/functional/test_ppc_ppe42.py to MAINTAINERS file

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

Glenn Miles (4):
  target/ppc: Add IBM PPE42 family of processors
  target/ppc: Add IBM PPE42 special instructions
  hw/ppc: Add a test machine for the IBM PPE42 CPU
  tests/functional: Add test for IBM PPE42 instructions

 MAINTAINERS                         |   7 +
 hw/ppc/Kconfig                      |   9 +
 hw/ppc/meson.build                  |   2 +
 hw/ppc/ppc_booke.c                  |   7 +-
 hw/ppc/ppe42_machine.c              |  69 +++
 include/hw/ppc/ppc.h                |   1 +
 target/ppc/cpu-models.c             |   7 +
 target/ppc/cpu-models.h             |   4 +
 target/ppc/cpu.h                    |  76 ++-
 target/ppc/cpu_init.c               | 241 +++++++--
 target/ppc/excp_helper.c            | 163 ++++++
 target/ppc/helper_regs.c            |  28 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 805 ++++++++++++++++++++++++++++
 tests/functional/meson.build        |   1 +
 tests/functional/test_ppc_ppe42.py  |  79 +++
 18 files changed, 1556 insertions(+), 56 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/test_ppc_ppe42.py

-- 
2.43.0


