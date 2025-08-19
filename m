Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D1ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoTtn-0007Nq-1L; Tue, 19 Aug 2025 17:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTtj-0007Mr-Jk; Tue, 19 Aug 2025 17:29:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uoTth-0006oO-H8; Tue, 19 Aug 2025 17:29:39 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JLJ0Cx020240;
 Tue, 19 Aug 2025 21:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=epQnemxaAg8uIGrBFSbeFmX+u9qwuhcfxp+E2BUx+
 EQ=; b=GI2LSrZxkvS7kO6C0/QCQxbUx3bFg+XcSNSZRJZUVDb9lVmY+2l6Nsd5R
 L6gGgTdCEKon6oL8KaYVFcTXaA2E2NWYPS2JugaSYkCVj3kQAjKMH1G2SeZSrxrw
 kg90LQvPv853JdaHfCjoxUiu0bAQFx894LVWKbcZZ7WHEURMvyffeGMH7Q9om+MM
 yHWHAVUdIeR1VGYoc3StvlXudxOdRwKyNSE7jQH+cnUeHjn9j0KlwSGq07PfKoum
 RJzggW/IvaxH03cCR6fV/g+zf41GMHHt0yv+/0+J4gpzDifoMYjMDClLWYJItZiS
 y0IaBP4cUsmWt0Wq36ATXD9m1mxKQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n12ur160-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:35 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57JLKIWE023501;
 Tue, 19 Aug 2025 21:29:34 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n12ur15y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ9BJD032003;
 Tue, 19 Aug 2025 21:29:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5y0e39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Aug 2025 21:29:33 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57JLTWgA57868606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Aug 2025 21:29:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CB725804E;
 Tue, 19 Aug 2025 21:29:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C6EE5803F;
 Tue, 19 Aug 2025 21:29:31 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 19 Aug 2025 21:29:31 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, thuth@redhat.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH 0/4] Add IBM PPE42 CPU support
Date: Tue, 19 Aug 2025 16:28:44 -0500
Message-ID: <20250819212856.219932-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bq8VxEai c=1 sm=1 tr=0 ts=68a4ecbf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8 a=xvqACAhl3sTSZSjITogA:9
 a=yloqiLrygL2q3s9aD-8D:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6Vzh_U5GEWvlMoKwL1QuKUu6OS6n6e0n
X-Proofpoint-ORIG-GUID: Jc364gw_bBBXy7ep2TMNS-KOpmW_9K4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5OCBTYWx0ZWRfX78Lb2t8Zbze+
 fjzvUqO/pnd9+Azin+WnjusTJAw0LT7Z/JTfgQJ6r4w+9jconT+s2ieCOJ5+FxkMT+vx+GBxg2Y
 BhklWhc6//H4c9wAdK7Q5ZeQ4bCl4g6/c0x14d3FW2NUfP+Ztmctk1vs0HHnjjk81Te0sPGzNo6
 Rg41QJymi10bW1JTJa+bosn1xHd/xwULxbQ/99Kr5SsfI3cZfQPyRBdjYMIOUikDDOwX9fpBorw
 ErBlRWZlK0ZSyPgeA3HvAiApVhGC8rw6dSvN/1t/M4VYcinijiUlJuO+ebAqhvhtik3+ZRUSwsv
 19MvILf84jKTh9Ym0Q9+DMbRf+hlzEdWI+6ZuPVN+UZrLIo0Xvp2Xoc3zRxcka0Bj5+rkuKgK4n
 yAqU/zOSNwPfAEakU+Z5V6p/cdEr/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190198
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

 hw/ppc/Kconfig                      |   9 +
 hw/ppc/meson.build                  |   2 +
 hw/ppc/ppc_booke.c                  |   7 +-
 hw/ppc/ppe42_machine.c              |  69 +++
 include/hw/ppc/ppc.h                |   1 +
 target/ppc/cpu-models.c             |   7 +
 target/ppc/cpu-models.h             |   4 +
 target/ppc/cpu.h                    |  66 ++-
 target/ppc/cpu_init.c               | 286 ++++++++--
 target/ppc/excp_helper.c            | 171 ++++++
 target/ppc/helper_regs.c            |  28 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 805 ++++++++++++++++++++++++++++
 tests/functional/meson.build        |   1 +
 tests/functional/test_ppc_ppe42.py  |  79 +++
 17 files changed, 1592 insertions(+), 56 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc
 create mode 100644 tests/functional/test_ppc_ppe42.py

-- 
2.43.0


