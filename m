Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD0D59F7D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 22:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8odp-0005Ix-VX; Wed, 06 Nov 2024 17:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8odp-0005II-4e
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:36:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t8odn-0005PL-9w
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 17:36:44 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6M9whS021178;
 Wed, 6 Nov 2024 22:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=kzP/BVkZ83DBEJfcayiQu7tszhbaJmfOFMveuXREE
 Go=; b=RkG35W8+VPtjL7PpxLI8Y2nmNy6ZMm1nIYlCumGLUzsLJyn7NCh5X3rBy
 4Cw9hquEdW5R5PIrUZ2UOceprVlzPIbGjBAe3kagilNH8tIGeM//xl+VwBgTgyDe
 3v5q8Oz2EQCkfmct3tqmMHzvn9n6lxJUaRQxKc3WWMIr4A70dYB65jyqAaKfduUi
 C3eCEzT3LwduCEGfsZxxG5nZIgfJmE0ebZit6WuoucP/dhvgplDb/YmhDSrSPKL9
 RKzAy8FFc1Rsoux4V0lotB+h/+sSj2jVIdCk2Y6SyUxSQd8/2Xc9xgk6fBAl9+R7
 Lw0QVCM3PxXesaNgBWJoD91knUc1g==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rh0rg3ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 22:36:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6KoYZp023983;
 Wed, 6 Nov 2024 22:36:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyrg3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Nov 2024 22:36:33 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A6MaVov43450628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Nov 2024 22:36:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CD912004B;
 Wed,  6 Nov 2024 22:36:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 714FA20043;
 Wed,  6 Nov 2024 22:36:30 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Nov 2024 22:36:30 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/8] gdbstub: Allow late attachment
Date: Wed,  6 Nov 2024 23:30:59 +0100
Message-ID: <20241106223629.2608-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1CZ2w-etX8bt3FszA6BG9KZWowTEOyMG
X-Proofpoint-GUID: 1CZ2w-etX8bt3FszA6BG9KZWowTEOyMG
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 mlxlogscore=610
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411060174
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

v1: https://lore.kernel.org/qemu-devel/20241024200031.80327-1-iii@linux.ibm.com/
v1 -> v2: Rebase, fix conflicts with the QEMU_RTSIG_MAP patch.
          Use qemu_get_thread_id() for %d (Helge, Richard, Warner).
          Add R-bs, except for the Richard's one on 4/8, since
          conflict resolution caused a noticeable change.
          Patches that need review:
          - [PATCH 2/8] gdbstub: Try unlinking the unix socket before binding
          - [PATCH 4/8] user: Introduce host_interrupt_signal  # linux part
          - [PATCH 6/8] gdbstub: Allow late attachment
          - [PATCH 7/8] docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
          - [PATCH 8/8] tests/tcg: Add late gdbstub attach test

Hi,

This series adds the ability to attach GDB to a running qemu-user
instance. This is useful for debugging multi-process apps.

Patches 1 and 2 implement a small related feature: the ability to
create individual UNIX sockets for each child process.

Patches 3-5 add the required infrastructure. In particular, we need
to reserve a host signal for waking up threads, as discussed in [1].
By the way, the problem with atomicity of checking for pending signals
and invoking syscalls that I'm describing in that thread seems to
have already been solved by the safe_syscall infrastructure, so the
changes are fairly simple.

If this series is accepted, I will rebase the all-stop series on top
of it.

Patch 6 is the implementation, patch 7 is a documentation update,
patch 8 is a test. I tested this series on Linux and only
compile-tested on the BSDs.

Best regards,
Ilya

[1] https://lore.kernel.org/qemu-devel/94ebebf2-e775-4fd2-8fcf-921610261a7e@linaro.org/

Ilya Leoshkevich (8):
  gdbstub: Allow the %d placeholder in the socket path
  gdbstub: Try unlinking the unix socket before binding
  user: Introduce user/signal.h
  user: Introduce host_interrupt_signal
  osdep: Introduce qemu_kill_thread()
  gdbstub: Allow late attachment
  docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
  tests/tcg: Add late gdbstub attach test

 bsd-user/main.c                            |   1 -
 bsd-user/signal-common.h                   |   1 -
 bsd-user/signal.c                          |  13 ++
 docs/user/main.rst                         |  16 ++-
 gdbstub/user.c                             | 131 +++++++++++++++++++--
 include/qemu/osdep.h                       |   9 ++
 include/user/signal.h                      |  25 ++++
 linux-user/main.c                          |   1 -
 linux-user/signal-common.h                 |   1 -
 linux-user/signal.c                        |  26 +++-
 linux-user/syscall.c                       |   1 +
 tests/guest-debug/run-test.py              |  15 ++-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 +++++
 tests/tcg/multiarch/late-attach.c          |  41 +++++++
 util/oslib-posix.c                         |  15 +++
 16 files changed, 308 insertions(+), 25 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py
 create mode 100644 tests/tcg/multiarch/late-attach.c

-- 
2.47.0


