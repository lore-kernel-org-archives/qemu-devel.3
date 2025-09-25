Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF396CAC5BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 20:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1sRO-0004F2-NV; Thu, 25 Sep 2025 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1sQr-0003pr-VG; Thu, 25 Sep 2025 16:19:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1sQZ-0006FB-Uh; Thu, 25 Sep 2025 16:19:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIlqnG029534;
 Thu, 25 Sep 2025 20:18:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=z+LY5dkLXbzHeiIQF9t/zOuSQepF
 CIJvs1v563fZykM=; b=Kr+rgW5RsGqogiaciZEXcHyeaHu9rJ2kP4OvpArY6M9N
 nDypr8JhKDuaDGKOqSL424OpRR6VxXsc6Xxvbf2iouC8TWR4AyNB0upmFNXWKbAM
 SFHlv34lwKdHhMzCOUtCO1XDGNXwgzhMpaIOL3gdFhZWJBidR/OwIzfIq4sUVSgn
 77wo5d8qYRLW+0BySrSUF326mCrDwnrPa04/NggsOg9dRns2n6msMPb48p4R6kFa
 VcYPmdRp2ElE0f29vzhvhC3lUXTqx8fdYPRVdVQNYaERGQYNp0ih3gqp8ftjPg96
 c14c4p3pGQrHPeBJVOTM7pYhmGlbfBUQWPa/+eFRww==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb3rfp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:18:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PK8M2w010724;
 Thu, 25 Sep 2025 20:18:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49dbb3rfp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:18:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIJDa0025844;
 Thu, 25 Sep 2025 20:18:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49dawprjfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 20:18:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PKIeoJ33423898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 20:18:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EAC15805A;
 Thu, 25 Sep 2025 20:18:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C5A558051;
 Thu, 25 Sep 2025 20:18:40 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 20:18:40 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH v6 0/9] Add IBM PPE42 CPU support
Date: Thu, 25 Sep 2025 15:17:38 -0500
Message-ID: <20250925201758.652077-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3NCBTYWx0ZWRfX46kElZe5IbHn
 ZGFvPOHUm13WmaRMQC6gwAuGtPC23dxJejuesYHxdOwkW6kosO47MauOSUfJDXdH78KBTJAY/wW
 xeV4hJHg2cVYYoXkDObb5cGmbBqRWTWFJkjLNn3+9T+mVwRIpXheIQpmCNtOCLp4LbbuXfXnpTU
 reuLmB5zCW6mmnXXMqP+2ofNJK/BaDQCh9x8laOa2nztKFV57Hrh6MRiWcJhB4aNK/mXIxSWsOV
 eKf3Fgn38LzS5/UDPZFKhh5F7k/gqr2IfhZ0NWEWu/MLsVy7YtO4ryqznCVenvMnxVlQw+LF78q
 oU4UzdgxEtfyFaI0HWUIolOXjvsUrw+I6oCrWRpqkMnAk1F+wWSIe9xp0SjwoMIjL1QDVSo1n7v
 t7kou6OlPxY31abCxz20RFX5YJDb+g==
X-Proofpoint-GUID: tpeO4sWps7qbD8eStavB3t6vvRKKtzoY
X-Authority-Analysis: v=2.4 cv=T/qBjvKQ c=1 sm=1 tr=0 ts=68d5a3a4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8
 a=jdePcm41jcmF87SOckgA:9 a=QEXdDO2ut3YA:10 a=yloqiLrygL2q3s9aD-8D:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: tiYUNawwkRviUbB3lxKT4a25lGy2PfX6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250174
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

v6:
  Patch 2:
  - Added missing POWERPC_FLAG_PPE42 check (Chinmay)

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
 target/ppc/cpu_init.c               | 244 +++++++++--
 target/ppc/excp_helper.c            | 163 ++++++++
 target/ppc/helper_regs.c            |  45 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 610 ++++++++++++++++++++++++++++
 tests/functional/ppc/meson.build    |   1 +
 tests/functional/ppc/test_ppe42.py  |  79 ++++
 18 files changed, 1398 insertions(+), 68 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/ppc/test_ppe42.py

-- 
2.43.0


