Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C2E7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFl9-0004CH-VK; Fri, 10 Jan 2025 09:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFl7-0004BF-QF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tWFl5-0004Er-2s
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:13:09 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50AD7xtN001639;
 Fri, 10 Jan 2025 14:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=nGyCvAY3sdiA0jaPv9viSJKnNp+T
 oMXvr666R+WDOTg=; b=jujRiqeAYzMy13YfTBK1EGUZJcOZ7pUFn+vrygeGv4pp
 zZO5JdhBWiISnyHqO5gVONBF7I2Uc+Cdp/tvVY5CNclDlUlmQTpWCaWi7pMgYcQr
 d2zKcfBUET/WR5SMqJqBoaieYnq3FR2MWGBsGS/5yXQABlD9pLLWvxvqyybFJ51h
 280ml3amnSEHt3nyNvuwgY0lfzDfl9ONncGQncp6HZnSXtztoaF4wlkerI+MMQ/Q
 B3le6OD67OJpEubc2j8D+XsSDURlgRAhj7RrZHGBha5FEuw+0I3oqXmjRx5XYEzP
 LGVI+Y1Xp1rydkP/DTiirl8wVJ/gpwJFc+wVrAnujQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhu0ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:12:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50AB0eC3026171;
 Fri, 10 Jan 2025 14:12:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj12j96n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 14:12:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50AECuwA64422184
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2025 14:12:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DFF592004F;
 Fri, 10 Jan 2025 14:12:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CB8420040;
 Fri, 10 Jan 2025 14:12:56 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2025 14:12:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5 0/8] gdbstub: Allow late attachment
Date: Fri, 10 Jan 2025 15:09:32 +0100
Message-ID: <20250110141255.2328-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9WVLEF-RawZypsWCdHutCunwais6ozWp
X-Proofpoint-GUID: 9WVLEF-RawZypsWCdHutCunwais6ozWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=779 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v4: https://lore.kernel.org/qemu-devel/20250108202625.149869-1-iii@linux.ibm.com/
v4 -> v5: Fix the qemu-user-only build by adding qemu-sockets.c to it.
          Drop the qapi_bool_parse() changes (Daniel).

v3: https://lore.kernel.org/qemu-devel/20241216123412.77450-1-iii@linux.ibm.com/
v3 -> v4: Rebase.
          Add missing "\n"s to error messages.
          Use unix_listen() (Alex).
          Use qapi_bool_parse() and patch it to accept NULL (Alex).
          Remove a leftover include (Alex).
          Rename port_or_path to path, set it to NULL after freeing (Alex).

v2: https://lore.kernel.org/qemu-devel/20241106223629.2608-1-iii@linux.ibm.com/
v2 -> v3: Rebase.
          Patches that need review:
          - [PATCH 2/8] gdbstub: Try unlinking the unix socket before binding
          - [PATCH 4/8] user: Introduce host_interrupt_signal  # linux part
          - [PATCH 6/8] gdbstub: Allow late attachment
          - [PATCH 7/8] docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
          - [PATCH 8/8] tests/tcg: Add late gdbstub attach test

v1: https://lore.kernel.org/qemu-devel/20241024200031.80327-1-iii@linux.ibm.com/
v1 -> v2: Rebase, fix conflicts with the QEMU_RTSIG_MAP patch.
          Use qemu_get_thread_id() for %d (Helge, Richard, Warner).
          Add R-bs, except for the Richard's one on 4/8, since
          conflict resolution caused a noticeable change.

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
 gdbstub/user.c                             | 154 +++++++++++++++++----
 include/qemu/osdep.h                       |   9 ++
 include/user/signal.h                      |  25 ++++
 linux-user/main.c                          |   1 -
 linux-user/signal-common.h                 |   1 -
 linux-user/signal.c                        |  26 +++-
 linux-user/syscall.c                       |   1 +
 stubs/meson.build                          |   2 +
 stubs/monitor-fd.c                         |   9 ++
 tests/guest-debug/run-test.py              |  15 +-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 ++++
 tests/tcg/multiarch/late-attach.c          |  41 ++++++
 util/meson.build                           |   2 +
 util/oslib-posix.c                         |  15 ++
 19 files changed, 326 insertions(+), 43 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 stubs/monitor-fd.c
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py
 create mode 100644 tests/tcg/multiarch/late-attach.c

-- 
2.47.1


