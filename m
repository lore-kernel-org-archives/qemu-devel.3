Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0FFC47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUO29-00026v-DV; Mon, 29 Jan 2024 04:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rUO26-00025V-Is; Mon, 29 Jan 2024 04:34:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rUO23-0008SX-OG; Mon, 29 Jan 2024 04:34:26 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T85Obw023580; Mon, 29 Jan 2024 09:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Uo/P5DOfd/mC752ox9LxZ0KMLZd6oY1pK+x7qsIkXEY=;
 b=JcrhZhziQPcEz9G4bR4I38kWwu6xhNIdVZxnQCLh9+cUxeEgJekBINWbarWRMZ59UmNT
 n5Fpeqcj3MfkxK+jox2Tfo75cbFYIK5bxku3yWG0jeTcqMBgkB5Jh5L+Y1O+A3kpeWvz
 kQy4XEi4jmxbE++wl+RDsMccHkLdDSQIPlVb+AfKdJhPf4vcppLeZrlUyQBUr4f3XgLW
 x4ETdWLcxoG/XWQUcqd9m6+1O1MUew/nrTR8Uk9oFXskMd3KKX9xpz6O5dsUxuTwtpDP
 6IBKv4pUYvrVWAFqb8J2h/30+8PVl8nGVFEsRklr/X7v0MIg8tG75FmwFM6d0A+4RNIF GA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx86vsvtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:34:19 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40T8u7ck028262;
 Mon, 29 Jan 2024 09:34:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vx86vsvtf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:34:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40T8UkVU010535; Mon, 29 Jan 2024 09:34:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nfarg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jan 2024 09:34:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40T9YFAT48300434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jan 2024 09:34:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B764120040;
 Mon, 29 Jan 2024 09:34:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B5D22004B;
 Mon, 29 Jan 2024 09:34:15 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.7.240])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jan 2024 09:34:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/3] linux-user: Allow gdbstub to ignore page protection
Date: Mon, 29 Jan 2024 10:32:13 +0100
Message-ID: <20240129093410.3151-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zGjFIcyXJaG8wQvH2S_g3kG3RCTnkLbV
X-Proofpoint-ORIG-GUID: 1r95fTB8Mnr8Fz80ZUVuKMhTv8NHiDgL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxlogscore=829 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401290068
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v3: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02907.html
v3 -> v4: Hide InteractiveConsole behind QEMU_TEST_INTERACTIVE (Alex).
          Probe /proc/self/mem in the PROT_NONE test.

v2: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg01592.html
v2 -> v3: Add Richard's R-b on [1/3].
          Fix printing the architecture name and the number of failures
          in test_gdbstub.py.
          Patches that need review: [2/3] and [3/3].

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg01314.html
v1 -> v2: Use /proc/self/mem as a fallback. Handle TB invalidation
          (Richard).
          Test cross-page accesses.

RFC: https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02044.html
RFC -> v1: Use /proc/self/mem and accept that this will not work
           without /proc.
           Factor out a couple functions for gdbstub testing.
           Add a test.

Hi,

I've noticed that gdbstub behaves differently from gdbserver in that it
doesn't allow reading non-readable pages. This series improves the
situation by using the same mechanism as gdbserver: /proc/self/mem.

Best regards,
Ilya

Ilya Leoshkevich (3):
  linux-user: Allow gdbstub to ignore page protection
  tests/tcg: Factor out gdbstub test functions
  tests/tcg: Add the PROT_NONE gdbstub test

 cpu-target.c                                  | 78 +++++++++++++++----
 tests/guest-debug/run-test.py                 |  7 +-
 tests/guest-debug/test_gdbstub.py             | 60 ++++++++++++++
 tests/tcg/aarch64/gdbstub/test-sve-ioctl.py   | 34 +-------
 tests/tcg/aarch64/gdbstub/test-sve.py         | 33 +-------
 tests/tcg/multiarch/Makefile.target           |  9 ++-
 tests/tcg/multiarch/gdbstub/interrupt.py      | 47 ++---------
 tests/tcg/multiarch/gdbstub/memory.py         | 41 +---------
 tests/tcg/multiarch/gdbstub/prot-none.py      | 36 +++++++++
 tests/tcg/multiarch/gdbstub/registers.py      | 41 ++--------
 tests/tcg/multiarch/gdbstub/sha1.py           | 40 ++--------
 .../multiarch/gdbstub/test-proc-mappings.py   | 39 +---------
 .../multiarch/gdbstub/test-qxfer-auxv-read.py | 37 +--------
 .../gdbstub/test-thread-breakpoint.py         | 37 +--------
 tests/tcg/multiarch/prot-none.c               | 40 ++++++++++
 tests/tcg/s390x/gdbstub/test-signals-s390x.py | 42 +---------
 tests/tcg/s390x/gdbstub/test-svc.py           | 39 +---------
 17 files changed, 247 insertions(+), 413 deletions(-)
 create mode 100644 tests/guest-debug/test_gdbstub.py
 create mode 100644 tests/tcg/multiarch/gdbstub/prot-none.py
 create mode 100644 tests/tcg/multiarch/prot-none.c

-- 
2.43.0


