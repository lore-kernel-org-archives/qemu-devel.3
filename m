Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B03C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcNf-0006zq-3i; Thu, 01 Aug 2024 16:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZcNS-0006xj-PC; Thu, 01 Aug 2024 16:26:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1sZcNP-0006Um-Aa; Thu, 01 Aug 2024 16:26:21 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JMXuV006513;
 Thu, 1 Aug 2024 20:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=xY4rUoAL0RCl2l0h8JdFmjmqQR
 S67f9QZ2RFIrSgCzE=; b=Hb0zx+ZZy5kMypB+giuInRNyntbNa41q/gEQt2QtPh
 cyR1+FEBKAymDrhL/JP4z1/DApZriWUTj8y6vifNM8H6OJeztL++BbOO2t6Ql6NQ
 /b7kHxc3WVyvKHcyJm1qXfipCpsOGlr2gXgEsk/DNypq+uJw11N0cjc7kFebjtvC
 hQRaJTsRAZth0oWUAuuba/08xpHjh2Z7SPz1Qa08sc6ibrjLXBRs7RewFd+v+9wb
 FxUM8hWYEJa83hcZU7EkvBhfWha2IRjaOV4kL0nySP5RmdUsABp2Mf9M9sA5HLga
 +cjXNdl8JokUqWoZ4bZJk8GKKCWq5uYAuzxvVeACj04g==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rebqgc7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:26:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471J5He4011295; Thu, 1 Aug 2024 20:23:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn3nhn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:23:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KNgtA31326850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:23:44 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51A3C20040;
 Thu,  1 Aug 2024 20:23:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E53C820043;
 Thu,  1 Aug 2024 20:23:41 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.14.120])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:23:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] linux-user/elfload: Fix pr_pid values in core files
Date: Thu,  1 Aug 2024 22:23:22 +0200
Message-ID: <20240801202340.21845-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GKN4UiD4jdY1DoPxIpjTlHbbQ-Gi9_Jb
X-Proofpoint-ORIG-GUID: GKN4UiD4jdY1DoPxIpjTlHbbQ-Gi9_Jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010135
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

Analyzing qemu-produced core dumps of multi-threaded apps runs into:

    (gdb) info threads
      [...]
      21   Thread 0x3ff83cc0740 (LWP 9295) warning: Couldn't find general-purpose registers in core file.
    <unavailable> in ?? ()

The reason is that all pr_pid values are the same, because the same
TaskState is used for all CPUs when generating NT_PRSTATUS notes.

Fix by using TaskStates associated with individual CPUs.

Cc: qemu-stable@nongnu.org
Fixes: 243c47066253 ("linux-user/elfload: Write corefile elf header in one block")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7ecbc8a7cc0..0861f115fc4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4102,8 +4102,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
     bswap_phdr(phdr, 1);
 }
 
-static void fill_prstatus_note(void *data, const TaskState *ts,
-                               CPUState *cpu, int signr)
+static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
 {
     /*
      * Because note memory is only aligned to 4, and target_elf_prstatus
@@ -4113,7 +4112,7 @@ static void fill_prstatus_note(void *data, const TaskState *ts,
     struct target_elf_prstatus prstatus = {
         .pr_info.si_signo = signr,
         .pr_cursig = signr,
-        .pr_pid = ts->ts_tid,
+        .pr_pid = get_task_state(cpu)->ts_tid,
         .pr_ppid = getppid(),
         .pr_pgrp = getpgrp(),
         .pr_sid = getsid(0),
@@ -4428,8 +4427,7 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         CPU_FOREACH(cpu_iter) {
             dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
                              sizeof(struct target_elf_prstatus));
-            fill_prstatus_note(dptr, ts, cpu_iter,
-                               cpu_iter == cpu ? signr : 0);
+            fill_prstatus_note(dptr, cpu_iter, cpu_iter == cpu ? signr : 0);
         }
 
         if (dump_write(fd, header, data_offset) < 0) {
-- 
2.45.2


