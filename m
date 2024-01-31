Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAA1C4828E
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVHXl-00049j-K2; Wed, 31 Jan 2024 15:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXj-00049R-96
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVHXh-0004OG-7T
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:50:47 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VK2IKK009478; Wed, 31 Jan 2024 20:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UYFns5Tg6je/SYhOl/b1MELJsg3gXp+xiUbhXtGGmyw=;
 b=dtpJul8Nd6gBAoRZ24Z0jFsD4WSr1fNkA179vFmQ+tGexjDb6/cVA3fh9ahkP6dEoFuF
 hxktg+Uh1qzNA8dGWznsMOsY4ZNDhBu+k9VqsDwNIPKUvKrMRde3uYe2xDeXV+9l2wWJ
 oSm7oy9LCDg9nFiy4pe1Kdz0W3hY+3VcyVfGtyD36xff9M/VSi7qUzWhrrhEKUkI+PZn
 hkyt/XXKYykrhcp/QJS7O4GTRu8yBljWD2r9TxPbyI+iz9DzhyBbALnl0V4u0NJmfD+h
 Q6JpuFFtKLlGqf6QXnaiV6MTDqnn1YqgDQ0E+GHJuxNl9e5Dz0jz+bOQmGwjNO+IcU2S 5g== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyvvws6kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:41 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VIZTbQ011292; Wed, 31 Jan 2024 20:50:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vweckqf4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jan 2024 20:50:40 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40VKocGp3277322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 20:50:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74D7B20040;
 Wed, 31 Jan 2024 20:50:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13FBE20043;
 Wed, 31 Jan 2024 20:50:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.74.74])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jan 2024 20:50:37 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] gdbstub: Implement follow-fork-mode child
Date: Wed, 31 Jan 2024 21:43:38 +0100
Message-ID: <20240131205031.144607-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p7_aVqvrB2d-9a5LQ1OXOMLNmBzCMEbm
X-Proofpoint-ORIG-GUID: p7_aVqvrB2d-9a5LQ1OXOMLNmBzCMEbm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=608 spamscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310161
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Based-on: <20240116094411.216665-1-iii@linux.ibm.com>

Hi,

I needed to debug a linux-user crash between fork() and exec() [1] and
realized that gdbstub does not allow this. This series lifts this
restriction (one still cannot debug past exec() though). Patch 1 is a
preliminary refactoring, I can split it if necessary. Patch 2 is the
implementation, and patch 3 is the test.

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg06424.html

Best regards,
Ilya

Ilya Leoshkevich (3):
  gdbstub: Refactor fork() handling
  gdbstub: Implement follow-fork-mode child
  tests/tcg: Add two follow-fork-mode tests

 bsd-user/freebsd/os-proc.h                    |   6 +-
 bsd-user/main.c                               |   8 +-
 bsd-user/qemu.h                               |   2 +-
 gdbstub/gdbstub.c                             |  29 ++-
 gdbstub/internals.h                           |   3 +
 gdbstub/user.c                                | 225 +++++++++++++++++-
 include/gdbstub/user.h                        |  11 +-
 linux-user/main.c                             |   8 +-
 linux-user/syscall.c                          |   4 +-
 linux-user/user-internals.h                   |   2 +-
 tests/tcg/multiarch/Makefile.target           |  17 +-
 tests/tcg/multiarch/follow-fork-mode.c        |  56 +++++
 .../gdbstub/follow-fork-mode-child.py         |  40 ++++
 .../gdbstub/follow-fork-mode-parent.py        |  16 ++
 14 files changed, 403 insertions(+), 24 deletions(-)
 create mode 100644 tests/tcg/multiarch/follow-fork-mode.c
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-child.py
 create mode 100644 tests/tcg/multiarch/gdbstub/follow-fork-mode-parent.py

-- 
2.43.0


