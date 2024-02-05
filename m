Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D0EC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 11:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWx47-0001lH-FD; Mon, 05 Feb 2024 06:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx44-0001k4-UG
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rWx43-0006ka-FW
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 06:23:04 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415AlqJL030861; Mon, 5 Feb 2024 11:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oD7GZIhNzA2xLm812IxZp3imLj9DqV3pXGd/C+ZWouc=;
 b=i1xAxUsmyoFNlqIkAGtNDGp7qjUK2SCyGgSTkWwDUg2rugoyL86/mwKa8zdav2cTBAzc
 r5NWSAQIKvZu/Apz616gYtc/K2VZSgTIpxsJEO6Qz6OA45BD0yPgiGGp7tPfmKLIRBCM
 m2oScWSuo6G0hIJgXRaq6RXEh0u4/elWt9o6xDdyMEokLhI8qqaF6vJnbi31aM2tNBbg
 QGLS07M1hhwSNju6vpw6R1p2Ghpu0PbKFbTF6LSWCsb+8sytVzTK4BaQ2+Cuq8rvmPQj
 MlHlSdse9z24bIl16NOeGMSfo8cLBjhmkdRf3IpGLR2HdXq7kR3mZATDmhr53Ul365Zf uw== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w2x82gse7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:00 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415A0Sjg008738; Mon, 5 Feb 2024 11:23:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y87w4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 11:23:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415BMwte54264170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 11:22:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C5392004F;
 Mon,  5 Feb 2024 11:22:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C529C2004B;
 Mon,  5 Feb 2024 11:22:57 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.32.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Feb 2024 11:22:57 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 03/11] gdbstub: Introduce gdbserver_fork_start()
Date: Mon,  5 Feb 2024 12:22:17 +0100
Message-ID: <20240205112251.121569-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205112251.121569-1-iii@linux.ibm.com>
References: <20240205112251.121569-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u0ijmKaqsz3INQ4BghPxwDTzO_3YL8n_
X-Proofpoint-ORIG-GUID: u0ijmKaqsz3INQ4BghPxwDTzO_3YL8n_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_06,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=806 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
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

The upcoming follow-fork-mode child support requires knowing when
fork() is about to happen in order to initialize its state. Add a hook
for that.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c        | 1 +
 gdbstub/user.c         | 4 ++++
 include/gdbstub/user.h | 5 +++++
 linux-user/main.c      | 1 +
 4 files changed, 11 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4140edc8311..bfe6888ea89 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -106,6 +106,7 @@ void fork_start(void)
     start_exclusive();
     cpu_list_lock();
     mmap_fork_start();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
diff --git a/gdbstub/user.c b/gdbstub/user.c
index e6809da2243..85fd44b6aa9 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,6 +356,10 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+void gdbserver_fork_start(void)
+{
+}
+
 static void disable_gdbstub(void)
 {
     CPUState *cpu;
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 68b6534130c..e33f8d9a9a6 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -45,6 +45,11 @@ static inline int gdb_handlesig(CPUState *cpu, int sig)
  */
 void gdb_signalled(CPUArchState *as, int sig);
 
+/**
+ * gdbserver_fork_start() - inform gdb of the upcoming fork()
+ */
+void gdbserver_fork_start(void);
+
 /**
  * gdbserver_fork() - disable gdb stub for child processes.
  * @cs: CPU
diff --git a/linux-user/main.c b/linux-user/main.c
index e6427d72332..8c7bea1c631 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -144,6 +144,7 @@ void fork_start(void)
     mmap_fork_start();
     cpu_list_lock();
     qemu_plugin_user_prefork_lock();
+    gdbserver_fork_start();
 }
 
 void fork_end(int child)
-- 
2.43.0


