Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C855EEB575
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9w-00076T-B7; Thu, 12 Sep 2024 05:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9h-0006vS-1v
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9e-0004L5-KL
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BIwTwE003716;
 Thu, 12 Sep 2024 09:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-type
 :content-transfer-encoding:mime-version; s=pp1; bh=E0IALVm1jp3Qa
 S/zvd87+3h3Hqqd/3N8wY2gV8PtGSk=; b=rEkJbP/3jF3hn1zmy2X2gQoS3Vhiv
 Wtqh3H1S1BQP1jIG2cDNZzl6HZbpNJc116vBQNQkJ+OmGoHAK7+CiKeit0PYr4/6
 +Mr+wKjAsHCq/H/qvEy4UUcEkmf1ihvtty0wfzp5LCri14dvq3B3DmCBhNvqcflO
 YhPCdZlrW6UiiZnyqvGRjask3NYyj4eKTApCs9do4E/eAUDX9iKzz3aKjUUgKDIk
 DOsHz12dLVVtIW3Lzh9F3txXP5aRdunAdNPOBX68fVf0lD15W9G4/kjl6CpxjBbi
 YdR6lmyvDG4CMT8oRqoAIZfJSX0Xh7LYV1vdMstyVq7wIKu1Qe8/1+9LA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kthd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:18 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9UHf8019596;
 Thu, 12 Sep 2024 09:30:18 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kthct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6mT0o013468;
 Thu, 12 Sep 2024 09:30:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmes7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UFg646858656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 797832004D;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A17120043;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.24.155])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/5] linux-user/i386: Emulate orig_ax
Date: Thu, 12 Sep 2024 11:28:19 +0200
Message-ID: <20240912093012.402366-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AC2U5lF8UUSqEYI5LRD6iysoE739MrG5
X-Proofpoint-ORIG-GUID: eTGn_P36WKrc1niy6Z46y7_v-D_b4oKd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

v1: https://lore.kernel.org/qemu-devel/20240802095942.34565-1-iii@linux.ibm.com/
v1 -> v2: Move orig_ax declaration higher, simplify gdb_write_reg()
          for TARGET_LONG_BITS == 32 (Richard).

Hi,

Currently gdbstub is barely usable with i386-linux-user: GDB cannot
even parse a shared library list, so no symbols are available. This
boils down to unavailability of info proc, which is gated behind
org.gnu.gdb.i386.linux. See amd64_linux_init_abi(); info proc is
enabled by amd64_linux_init_abi_common() -> linux_init_abi().

This series adds orig_ax support to the emulator and gdbstub, and
enables the existing test-proc-mappings.py on i386.

Best regards,
Ilya

Ilya Leoshkevich (5):
  include/exec: Introduce env_cpu_const()
  linux-user/i386: Emulate orig_ax
  target/i386/gdbstub: Factor out gdb_get_reg() and gdb_write_reg()
  target/i386/gdbstub: Expose orig_ax
  tests/tcg: Run test-proc-mappings.py on i386

 configs/targets/i386-linux-user.mak           |   2 +-
 configs/targets/x86_64-linux-user.mak         |   2 +-
 gdb-xml/i386-32bit-linux.xml                  |  11 ++
 gdb-xml/i386-64bit-linux.xml                  |  11 ++
 include/exec/cpu-common.h                     |  13 ++-
 linux-user/elfload.c                          |   6 +-
 linux-user/i386/cpu_loop.c                    |   3 +
 linux-user/qemu.h                             |   4 +
 target/i386/cpu.c                             |   1 +
 target/i386/cpu.h                             |   1 +
 target/i386/gdbstub.c                         | 102 ++++++++++++++----
 .../multiarch/gdbstub/test-proc-mappings.py   |  17 ++-
 12 files changed, 135 insertions(+), 38 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-linux.xml
 create mode 100644 gdb-xml/i386-64bit-linux.xml

-- 
2.46.0


