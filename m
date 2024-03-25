Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF74C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romKR-0006e5-Le; Mon, 25 Mar 2024 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKN-0006dH-N6
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKL-0001B1-Lt
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:35 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PEP2m7031552; Mon, 25 Mar 2024 15:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hFZ1QLM+qgGGBfDxQWtAZRO+me8V0VMtmEwBTGqEQnk=;
 b=BRrrw41MznN5OHmNg9CWY5nx7H8fvqEZ26oQ0fWqrkRWxDijY0NrohDVZVXZ668z7KEC
 TERoQhLL56ifVCwmf7fODGsJ9C/61dzCRPWuc9ppy7CzLQfVXrR3z4ibmUTW+W1OBaB8
 SBntP7Q1SrYfGUd/p15pWGkuEjjnPUkhH9KFHpO7Yztf5XCf6V9POh3gAaiYABDAvd7H
 kGyU7ftfDd32DJFuruPVAkNw00jtLVm5d0QxIKoK6Pw9DaVCzheQwSgqx+HnWqicvcqU
 YEStONvFMxWPJJlCjAPizuo8TwmpkQNfcYMzIqSS+ar3cIrMbzzc6bStMQD2c8g0lOFM WA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x2hh6am6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PD8ClZ003753; Mon, 25 Mar 2024 15:33:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2c42hg5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:29 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PFXPRH34013660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 15:33:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEA822004D;
 Mon, 25 Mar 2024 15:33:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F6772004B;
 Mon, 25 Mar 2024 15:33:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 15:33:25 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/4] linux-user: Fix semctl() strace
Date: Mon, 25 Mar 2024 16:07:38 +0100
Message-ID: <20240325153313.526888-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325153313.526888-1-iii@linux.ibm.com>
References: <20240325153313.526888-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zVBgrLdTi-IYoqGWq1VsmobGxfDm5Fle
X-Proofpoint-GUID: zVBgrLdTi-IYoqGWq1VsmobGxfDm5Fle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The indices of arguments used with semctl() are all off-by-1, because
arg1 is the ipc() command. Fix them. While at it, reuse print_semctl().

New output (for a small test program):

    3540333 semctl(999,888,SEM_INFO,0x00007fe5051ee9a0) = -1 errno=14 (Bad address)

Fixes: 7ccfb2eb5f9d ("Fix warnings that would be caused by gcc flag -Wwrite-strings")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/strace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9934e2208e2..9be71af4016 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -657,7 +657,7 @@ print_newselect(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_semctl
+#if defined(TARGET_NR_semctl) || defined(TARGET_NR_ipc)
 static void
 print_semctl(CPUArchState *cpu_env, const struct syscallname *name,
              abi_long arg1, abi_long arg2, abi_long arg3,
@@ -698,10 +698,8 @@ print_ipc(CPUArchState *cpu_env, const struct syscallname *name,
 {
     switch(arg1) {
     case IPCOP_semctl:
-        qemu_log("semctl(" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ",",
-                 arg1, arg2);
-        print_ipc_cmd(arg3);
-        qemu_log(",0x" TARGET_ABI_FMT_lx ")", arg4);
+        print_semctl(cpu_env, &(const struct syscallname){ .name = "semctl" },
+                     arg2, arg3, arg4, arg5, 0, 0);
         break;
     case IPCOP_shmat:
         print_shmat(cpu_env, &(const struct syscallname){ .name = "shmat" },
-- 
2.44.0


