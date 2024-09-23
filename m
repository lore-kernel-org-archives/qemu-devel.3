Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49502CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpq-00079L-CU; Mon, 23 Sep 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpY-0006VB-1N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpQ-0000bI-Ry
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:31 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NG8I2k012818;
 Mon, 23 Sep 2024 16:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=T0Mfm1u3RqJjDjfSiYtkCQIr9cdPLq2u+hhg3lm
 gesA=; b=eiU/5LyNJxyzcMLQ4hVcoXsuIQudM5mTBJ5SlwBm82BoMkH3gFYAhPS
 f1w/vOOfRPVLzky5LcG/63x/7oCkYL4hq/oh+s9zT0xmw9uNCmCTvukWPXHqpkOs
 ImRzs7L3PUvuohLP6B//nMHTbeGxHGu68XZ1hswbmn8cAT1UNcWhE+Ivn5LGrZaP
 tNw7uOTLt3PzUs+gfHGyjk4FHQc7LDCZbX6ygo7CwDBH07zQNBcejqN0vPuUbS+e
 Q+tmHBmyjCEs1uA6ssMT9jQbm94V2ldxKUGvNxjizAywZQXoPcvohlD9P2Ga7zdY
 PdYp5qUKFUsR6mvIpYRh8+/biWZHMIQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna58rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMJMk012179;
 Mon, 23 Sep 2024 16:22:19 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna58rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDH0BO000636;
 Mon, 23 Sep 2024 16:22:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fufp6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMGIe42598856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B4F220043;
 Mon, 23 Sep 2024 16:22:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41C4A20040;
 Mon, 23 Sep 2024 16:22:16 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
Date: Mon, 23 Sep 2024 18:12:55 +0200
Message-ID: <20240923162208.90745-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CaY9Bp7UbTiSlnFDdGaRAcZXdKOfrlnx
X-Proofpoint-ORIG-GUID: 9zolA3zJ9LCMz6EwGIqr2wEhHEDt5Hws
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=710 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi,

On reporting a breakpoint in a non-non-stop mode, GDB remotes must stop
all threads. Currently qemu-user doesn't do that, breaking the
debugging session for at least two reasons: concurrent access to the
GDB socket, and an assertion within GDB [1].

This series fixes this by importing pause_all_vcpus() from qemu-system.
This in turn requires introducing BQL and a few stubs to qemu-user.

Best regards,
Ilya

[1] https://gitlab.com/qemu-project/qemu/-/issues/2465

Ilya Leoshkevich (18):
  gdbstub: Make gdb_get_char() static
  gdbstub: Move phy_memory_mode to GDBSystemState
  gdbstub: Move gdb_syscall_mode to GDBSyscallState
  gdbstub: Factor out gdb_try_stop()
  accel/tcg: Factor out cpu_exec_user()
  qemu-thread: Introduce QEMU_MUTEX_INITIALIZER
  qemu-thread: Introduce QEMU_COND_INITIALIZER
  replay: Add replay_mutex_{lock,unlock}() stubs for qemu-user
  qemu-timer: Provide qemu_clock_enable() stub for qemu-user
  cpu: Use BQL in qemu-user
  accel/tcg: Unify user implementations of qemu_cpu_kick()
  cpu: Track CPUs executing syscalls
  cpu: Implement cpu_thread_is_idle() for qemu-user
  cpu: Introduce cpu_is_paused()
  cpu: Set current_cpu early in qemu-user
  cpu: Allow pausing and resuming CPUs in qemu-user
  gdbstub: Pause all CPUs before sending stop replies
  tests/tcg: Stress test thread breakpoints

 accel/tcg/user-exec-stub.c                    |   4 -
 accel/tcg/user-exec.c                         |  55 ++++++
 bsd-user/aarch64/target_arch_cpu.h            |   6 +-
 bsd-user/arm/target_arch_cpu.h                |   5 +-
 bsd-user/freebsd/os-syscall.c                 |  10 +
 bsd-user/i386/target_arch_cpu.h               |   5 +-
 bsd-user/main.c                               |   8 +-
 bsd-user/x86_64/target_arch_cpu.h             |   5 +-
 cpu-common.c                                  | 179 ++++++++++++++++++
 gdbstub/gdbstub.c                             |  17 +-
 gdbstub/internals.h                           |   4 +-
 gdbstub/syscalls.c                            |  20 +-
 gdbstub/system.c                              |  18 +-
 gdbstub/user.c                                |  28 ++-
 include/exec/cpu-common.h                     |  15 ++
 include/exec/replay-core.h                    |  13 ++
 include/hw/core/cpu.h                         |   1 +
 include/qemu/thread-posix.h                   |   8 +
 include/qemu/thread-win32.h                   |   8 +
 include/sysemu/cpus.h                         |   6 -
 include/sysemu/replay.h                       |  13 --
 linux-user/aarch64/cpu_loop.c                 |   5 +-
 linux-user/alpha/cpu_loop.c                   |   5 +-
 linux-user/arm/cpu_loop.c                     |   5 +-
 linux-user/hexagon/cpu_loop.c                 |   5 +-
 linux-user/hppa/cpu_loop.c                    |   5 +-
 linux-user/i386/cpu_loop.c                    |   5 +-
 linux-user/loongarch64/cpu_loop.c             |   5 +-
 linux-user/m68k/cpu_loop.c                    |   5 +-
 linux-user/main.c                             |   9 +-
 linux-user/microblaze/cpu_loop.c              |   5 +-
 linux-user/mips/cpu_loop.c                    |   5 +-
 linux-user/openrisc/cpu_loop.c                |   5 +-
 linux-user/ppc/cpu_loop.c                     |   5 +-
 linux-user/riscv/cpu_loop.c                   |   5 +-
 linux-user/s390x/cpu_loop.c                   |   5 +-
 linux-user/sh4/cpu_loop.c                     |   5 +-
 linux-user/sparc/cpu_loop.c                   |   5 +-
 linux-user/syscall.c                          |  12 ++
 linux-user/xtensa/cpu_loop.c                  |   5 +-
 replay/stubs-system.c                         |   8 +
 stubs/meson.build                             |   8 +
 stubs/qemu-timer.c                            |   6 +
 stubs/replay-mutex.c                          |  10 +
 stubs/replay-tools.c                          |   8 -
 system/cpus.c                                 | 172 +----------------
 tests/tcg/multiarch/Makefile.target           |  13 +-
 .../gdbstub/test-thread-breakpoint-stress.py  |  28 +++
 .../tcg/multiarch/thread-breakpoint-stress.c  |  92 +++++++++
 49 files changed, 552 insertions(+), 327 deletions(-)
 create mode 100644 stubs/qemu-timer.c
 create mode 100644 stubs/replay-mutex.c
 create mode 100644 tests/tcg/multiarch/gdbstub/test-thread-breakpoint-stress.py
 create mode 100644 tests/tcg/multiarch/thread-breakpoint-stress.c

-- 
2.46.0


