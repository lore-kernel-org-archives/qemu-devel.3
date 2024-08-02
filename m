Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZp7A-0007Ah-UI; Fri, 02 Aug 2024 06:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp78-00078i-Jn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp76-0004ct-HU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:22 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729wYtD005048;
 Fri, 2 Aug 2024 10:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=67D/psam2pBIbOJ5yrm3XI/eqD
 jbaXCyF59EYQmlD0E=; b=ZBkkrBas/bp6fT0mNcCZ1HcfbNc8A4KRmpV7IBRbT/
 aDoRQdjZ8A8ximIqQljgy5P9C3GesDgO8I+ijxt3cnO0HZ4TCxv5zkxoStdsgmsv
 I5meixuS2IX/KBUw5VuoJkD2ag2SK2qDd4Dzn2dAMWZBheFgVGkQihkKQf/cD+R9
 mnvHvb6KDp8FOoTP/RuofUo8q7ksnXg0EdAQlsZowFSFzJw+Qf23V3d3fORZJspv
 FHrER89YSe2g6XnYCUZkbSsQSEtQOqWoBoCxZJJB26OVm6gKJAQo++1E7UX8v/rP
 dJqZt3cI3Qe0UFczRiHxCXjismpmPGyY7shJgdVmvVfQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9vr098-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472A2Gff011264;
 Fri, 2 Aug 2024 10:02:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9vr090-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 47271LWb018770; Fri, 2 Aug 2024 10:02:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q6n2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472A2Avx44696002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 10:02:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C79262004E;
 Fri,  2 Aug 2024 10:02:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FC322004F;
 Fri,  2 Aug 2024 10:02:10 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.14.120])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2024 10:02:10 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] linux-user/i386: Emulate orig_ax
Date: Fri,  2 Aug 2024 11:59:13 +0200
Message-ID: <20240802095942.34565-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sjl18K1M0tV6oluNCZ8Nh2phsvJs-vTn
X-Proofpoint-GUID: JDYJYH7NhJ9kFsCpl7edgN2YWdme1v9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=842
 clxscore=1011 priorityscore=1501 impostorscore=0 suspectscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 linux-user/qemu.h                             |   5 +
 target/i386/cpu.c                             |   1 +
 target/i386/cpu.h                             |   1 +
 target/i386/gdbstub.c                         | 103 ++++++++++++++----
 .../multiarch/gdbstub/test-proc-mappings.py   |  17 +--
 12 files changed, 137 insertions(+), 38 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-linux.xml
 create mode 100644 gdb-xml/i386-64bit-linux.xml

-- 
2.45.2


