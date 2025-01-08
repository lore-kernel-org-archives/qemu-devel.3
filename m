Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A79E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 20:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVcdW-0007Bh-8A; Wed, 08 Jan 2025 15:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdU-0007BF-AJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tVcdS-0006qe-L9
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 15:26:40 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508C2ZBq027089;
 Wed, 8 Jan 2025 20:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=x55OOGktqZtKRfAR0eO/4uQ2zOwn
 5OS/er4K1EhtRyo=; b=YfyANmI9uy7bI29mavliyzV9NwDaq+cqkAqLG3WKuq/Y
 Iorc+kzLvqGojcqp7AC22AdklC4qrnQWCXisgvBd3YOTCVAn50C2xXBIpTttK6HB
 A7vJHR0hdOMoYSj0dsAmosZbpmsGIYFtZavM8g+/SVYqUho+iF/+gTdn4wKzP2+F
 Z/nYLmeT4aYBdI3uN5kT3mD7Mm2SaIeoaBtWhnKYFzUz0Udtpjue9wtVycR3F4UG
 zrTDbQ3q1Ydj4357YJg8F9waaMWB1qr9KyapTfiuwsxhvGri/9cS+MkbEu31ApYu
 N8moiw2s/Bnx7iJG7zMiKnhUjqBJUvGF0BVB2itiNw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441e3b4x6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508KD5mC013645;
 Wed, 8 Jan 2025 20:26:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap1jqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jan 2025 20:26:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 508KQRAX14287292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jan 2025 20:26:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8569420043;
 Wed,  8 Jan 2025 20:26:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E18A820040;
 Wed,  8 Jan 2025 20:26:26 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.127])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jan 2025 20:26:26 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/9] gdbstub: Allow late attachment
Date: Wed,  8 Jan 2025 21:04:55 +0100
Message-ID: <20250108202625.149869-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GwBxyhED7Kgmp2tnsQ6y6gsJH0lzE_P7
X-Proofpoint-GUID: GwBxyhED7Kgmp2tnsQ6y6gsJH0lzE_P7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=725 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080163
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ilya Leoshkevich (9):
  qapi: Make qapi_bool_parse() gracefully handle NULL value
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
 gdbstub/user.c                             | 150 +++++++++++++++++----
 include/qemu/osdep.h                       |   9 ++
 include/user/signal.h                      |  25 ++++
 linux-user/main.c                          |   1 -
 linux-user/signal-common.h                 |   1 -
 linux-user/signal.c                        |  26 +++-
 linux-user/syscall.c                       |   1 +
 qapi/qapi-util.c                           |  16 +--
 tests/guest-debug/run-test.py              |  15 ++-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 ++++
 tests/tcg/multiarch/late-attach.c          |  41 ++++++
 util/oslib-posix.c                         |  15 +++
 17 files changed, 317 insertions(+), 51 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py
 create mode 100644 tests/tcg/multiarch/late-attach.c

-- 
2.47.1


