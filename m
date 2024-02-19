Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0338C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Ws-0007Ft-Ly; Mon, 19 Feb 2024 09:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4Wr-0007FD-HE
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:21:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4Wp-0001YX-Sl
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:21:57 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDm2xF013563; Mon, 19 Feb 2024 14:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=wZiWpuKxoJTJGQ8MEG+Gyeo10ajYjpSZrt+Au4q38Jk=;
 b=tVOv5STLjwEfED9N22BaMaUYjnoH8Xlds/yXiZuOW+euWIELemUYXDupjhkkH2q5rXen
 Ut6zGChdj7RQuPWGFeo7NntIFKlCcMHsDyqWQTspt3NCw0710NoILYGPsZjCPfhVkezd
 1fak3BSz7KSPTDonQ6odgxGapu5Dfw/pW1cgDQxjeKMsyJnhmnAMumIZdI5AdRYpJ6bN
 7k2QvftWJsdFeCjZtLJPkmqWaEb00KTCW6XehQmEvbSgKD8k3ZUMGElantqhQqb72BoJ
 OE5N+upvVynraFbH2jAiuVOEW479qlT/57BvwnRK20m86vsO+9x7iPKjJqmdGh4FLmHF cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc86jh0ye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:21:47 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JELdjE022695;
 Mon, 19 Feb 2024 14:21:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc86jgxtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:21:38 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JDPLju013532; Mon, 19 Feb 2024 14:16:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h01w68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:16:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGgsH11928116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:16:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25A0F20040;
 Mon, 19 Feb 2024 14:16:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1230920043;
 Mon, 19 Feb 2024 14:16:39 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:39 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 00/12] gdbstub: Implement follow-fork-mode child
Date: Mon, 19 Feb 2024 15:15:48 +0100
Message-ID: <20240219141628.246823-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UaEPhbOulORkqKL9iYEFBHx0MHNpkdTb
X-Proofpoint-GUID: VDupl8xReepigIkq0qBmWi-_F1hnKq2X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=800
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v3: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg03142.html
v3 -> v4: Address the review comments, add R-bs.
          Add the get_task_state() refactoring.
          Keep passing CPUState to gdbserver_fork_end() for tb_flush().
          Patches that need review: 02/12, 09/12-12/12.

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00810.html
v2 -> v3: Rebase on top of master.
          Fix a typo in the 01/11 commit message.

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06646.html
v1 -> v2: Factor out a number of prep patches;
          Add a state transition diagram comment (Alex).
          Improve a few comments;
          Extend the ts_tid fix to bsd.

Hi,

I needed to debug a linux-user crash between fork() and exec() [1] and
realized that gdbstub does not allow this. This series lifts this
restriction (one still cannot debug past exec() though). Patches 1-10
are preliminary refactorings, patch 11 is the implementation, and patch
12 is the test.

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06424.html

Best regards,
Ilya

Ilya Leoshkevich (12):
  gdbstub: Support disablement in a multi-threaded process
  {linux,bsd}-user: Introduce get_task_state()
  {linux,bsd}-user: Update ts_tid after fork()
  gdbstub: Introduce gdbserver_fork_start()
  {linux,bsd}-user: Pass pid to fork_end()
  {linux,bsd}-user: Pass pid to gdbserver_fork()
  gdbstub: Call gdbserver_fork() both in parent and in child
  gdbstub: Introduce gdb_handle_query_supported_user()
  gdbstub: Introduce gdb_handle_set_thread_user()
  gdbstub: Introduce gdb_handle_detach_user()
  gdbstub: Implement follow-fork-mode child
  tests/tcg: Add two follow-fork-mode tests

 bsd-user/bsd-file.h                           |   2 +-
 bsd-user/freebsd/os-proc.h                    |   6 +-
 bsd-user/main.c                               |   9 +-
 bsd-user/qemu.h                               |   7 +-
 bsd-user/signal.c                             |  20 +-
 gdbstub/gdbstub.c                             |  29 ++-
 gdbstub/internals.h                           |   3 +
 gdbstub/user-target.c                         |   4 +-
 gdbstub/user.c                                | 244 +++++++++++++++++-
 include/gdbstub/user.h                        |  10 +-
 include/user/safe-syscall.h                   |   2 +-
 linux-user/aarch64/cpu_loop.c                 |   2 +-
 linux-user/arm/cpu_loop.c                     |   4 +-
 linux-user/arm/signal.c                       |   2 +-
 linux-user/cris/cpu_loop.c                    |   2 +-
 linux-user/elfload.c                          |   6 +-
 linux-user/hppa/signal.c                      |   2 +-
 linux-user/linuxload.c                        |   2 +-
 linux-user/m68k/cpu_loop.c                    |   2 +-
 linux-user/m68k/target_cpu.h                  |   2 +-
 linux-user/main.c                             |   8 +-
 linux-user/mips/cpu_loop.c                    |   2 +-
 linux-user/ppc/signal.c                       |   4 +-
 linux-user/qemu.h                             |   5 +
 linux-user/riscv/cpu_loop.c                   |   2 +-
 linux-user/signal-common.h                    |   2 +-
 linux-user/signal.c                           |  30 +--
 linux-user/syscall.c                          |  32 +--
 linux-user/user-internals.h                   |   2 +-
 linux-user/vm86.c                             |  18 +-
 linux-user/xtensa/signal.c                    |   2 +-
 plugins/api.c                                 |   8 +-
 semihosting/arm-compat-semi.c                 |   8 +-
 tests/tcg/multiarch/Makefile.target           |  17 +-
 tests/tcg/multiarch/follow-fork-mode.c        |  56 ++++
 .../gdbstub/follow-fork-mode-child.py         |  40 +++
 .../gdbstub/follow-fork-mode-parent.py        |  16 ++
 37 files changed, 511 insertions(+), 101 deletions(-)
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

-- 
2.43.2


