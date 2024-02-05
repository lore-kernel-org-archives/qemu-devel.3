Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5519C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx45-0001k6-3X; Mon, 05 Feb 2024 06:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx43-0001jm-9G
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx41-0006kA-H8
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:03 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415BHYOp031762; Mon, 5 Feb 2024 11:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FoDQcm4B9d4dxrUFYFz/YJpQzUau6P5KzNZa+jKioLU=;
 b=SaP0od9GPNyPRaWb8Eb4dCWDH+Hsm1SueQBcnt4Pk0oq0ov1iDPgvKv8pl0oJDFdKo5t
 ykry9CD1wBwffEBO44aTxXiVd9sxLN8gjy2LyYaGMtvkGrD/2Vw6/9Q7YkLTSdm4jPu1
 c69ikXAFz9oaqOLU0Vd5GscwJAYdKGmYFvvQkWf03nE20rAJm0BsGarH7IZO0enotRaf
 nL0sg4RB7KI56gjNH84VN38s0EhrlNXJX0scYBeHc5U9Fc+oht+2FNuTyDPDB0tYJVqY
 HLprQ7dyaUFCSttXgU0vOK9ew4Uhxbh1tqaruos7aqDXn0GIb28Yk/1HM21LgTn6hBjC 0Q== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2xp2g5hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:22:58 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415A36Fe020383; Mon, 5 Feb 2024 11:22:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytsrb39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:22:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BMuUX22610526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:22:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0234920049;
 Mon,  5 Feb 2024 11:22:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ACF320040;
 Mon,  5 Feb 2024 11:22:55 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:22:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 01/11] gdbstub: Support disablement in a multi-threaded
 process
Date: Mon,  5 Feb 2024 12:22:15 +0100
Message-ID: <20240205112251.121569-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: znwOAv8q7O_wDXLp670tem3U7KF9lj08
X-Proofpoint-GUID: znwOAv8q7O_wDXLp670tem3U7KF9lj08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050086
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

The upcoming follow-fork-mode child support will require disabling
gdbstub in the parent process, which may have multiple threads (which
are represented as CPUs).

Loop over all CPUs in order to remove watchpoints and disable
single-step. Move the respective code into a separate function.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 8f3affbad47..e6809da2243 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,16 +356,27 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+static void disable_gdbstub(void)
+{
+    CPUState *cpu;
+
+    close(gdbserver_user_state.fd);
+    gdbserver_user_state.fd = -1;
+    CPU_FOREACH(cpu) {
+        cpu_breakpoint_remove_all(cpu, BP_GDB);
+        /* no cpu_watchpoint_remove_all for user-mode */
+        cpu_single_step(cpu, 0);
+        tb_flush(cpu);
+    }
+}
+
 /* Disable gdb stub for child processes.  */
 void gdbserver_fork(CPUState *cpu)
 {
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return;
     }
-    close(gdbserver_user_state.fd);
-    gdbserver_user_state.fd = -1;
-    cpu_breakpoint_remove_all(cpu, BP_GDB);
-    /* no cpu_watchpoint_remove_all for user-mode */
+    disable_gdbstub();
 }
 
 /*
-- 
2.43.0


