Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05364C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxxD-0008AK-7P; Fri, 16 Feb 2024 08:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxB-00089C-BB
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxx8-0001OF-Rj
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:33 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GC3NhD013559; Fri, 16 Feb 2024 13:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=OLSjPd7J/cyxl3WgYmfRtuKVnGb4JgkUncQXyXMKBW0=;
 b=TdoFVSwPPeKxHC0a99Y//w0gr12mR2lt3eIa8Sux50EkC/N8hvwk2uF/C9g7XsxOa9T4
 sGBhGIcKuf/+QhvcfCgDu5MAXPF2kEKDH1aKUeAX7kb4KER/0PXHwjrh+2XJ2xQTbxkE
 nj0f6vR81YXyzs4MlbsPfPXKIhPbFyBzDb5DrR5TZQHazM0vLtE7SPDTFkSD7fedAiiK
 8r8U44GoP7I5HrzWJXgMIN+NH+8WG+UPTk4o3GZkJhuwRPtx3TpSSQpuTLvs4p8iuyH/
 1ugQTqQQb1+Ej3dSnySxjspxOhy1gsqcfHDAG5dP8ytV1+tkcqzs6r9bCtnULQJYpq7k eA== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa5cuup9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GAf7f3010060; Fri, 16 Feb 2024 13:08:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmb0hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GD8LlW43123132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 13:08:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BFB52004B;
 Fri, 16 Feb 2024 13:08:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F68420043;
 Fri, 16 Feb 2024 13:08:21 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Feb 2024 13:08:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 00/11] gdbstub: Implement follow-fork-mode child
Date: Fri, 16 Feb 2024 14:05:27 +0100
Message-ID: <20240216130817.369377-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZiDrSVa8I7R1cIqdrsLWJdAfPqZW8N-Q
X-Proofpoint-ORIG-GUID: ZiDrSVa8I7R1cIqdrsLWJdAfPqZW8N-Q
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=908 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106
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
restriction (one still cannot debug past exec() though). Patches 1-9
are preliminary refactorings, patch 10 is the implementation, and patch
11 is the test.

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06424.html

Best regards,
Ilya

Ilya Leoshkevich (11):
  gdbstub: Support disablement in a multi-threaded process
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

 bsd-user/freebsd/os-proc.h                    |   6 +-
 bsd-user/main.c                               |   9 +-
 bsd-user/qemu.h                               |   2 +-
 gdbstub/gdbstub.c                             |  29 ++-
 gdbstub/internals.h                           |   3 +
 gdbstub/user.c                                | 244 +++++++++++++++++-
 include/gdbstub/user.h                        |  11 +-
 linux-user/main.c                             |   8 +-
 linux-user/syscall.c                          |   6 +-
 linux-user/user-internals.h                   |   2 +-
 tests/tcg/multiarch/Makefile.target           |  17 +-
 tests/tcg/multiarch/follow-fork-mode.c        |  56 ++++
 .../gdbstub/follow-fork-mode-child.py         |  40 +++
 .../gdbstub/follow-fork-mode-parent.py        |  16 ++
 14 files changed, 424 insertions(+), 25 deletions(-)
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

-- 
2.43.0


