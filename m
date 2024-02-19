Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC537C54787
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Se-0007ie-Lu; Mon, 19 Feb 2024 09:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SY-0007d6-In
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SU-0000c6-Np
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:30 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JECaxJ015224; Mon, 19 Feb 2024 14:17:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wg7Kps3BVX1dQN42WcHLNaUJR8wG1Ah9/LwZ0BaSaKo=;
 b=InJxPbhvtbIrp6O/6BN09v3+vCO0qP3PthsCF9zNqKshMRSW5E2TsawjH9Skn4fKQtaS
 m7WcoYEeKXzobDDnqrf285qYcZDWe9uwsfBjHPAvEf26RSan/NdfhLrBXKDJaIa2a5x2
 e+lCcTHlVUfUMy/8aubKDhqFQFtHQ2DznC9MLMb1Fjnx4SvUQ0qWQlvJU344MIXQw5Jc
 2uLAEBJuejHoZLXUycnJBW/Utb/Nmea+wxzFFd7Gu1sG61uLUb/2cjdWBpmtgP7g9AAm
 jSy9l6Cl6G/pkTP3mivRy5+7dK+9ts+0Ot+EAClXSUD3H2UdoTO30158ACR2eoDZtUQH rQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc8hxg4nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JECeLQ015369;
 Mon, 19 Feb 2024 14:17:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wc8hxg4n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JBK6kM009627; Mon, 19 Feb 2024 14:17:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p1n4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:01 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEGviC32833792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:16:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9249520043;
 Mon, 19 Feb 2024 14:16:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBAFF2004E;
 Mon, 19 Feb 2024 14:16:56 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 04/12] gdbstub: Introduce gdbserver_fork_start()
Date: Mon, 19 Feb 2024 15:15:52 +0100
Message-ID: <20240219141628.246823-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WHYD9bWmSNRe5AZDZ0d26D5E6MgTcmwb
X-Proofpoint-ORIG-GUID: Nqew47rnNBnB0-9Cb-PFaBeOA_R6kGTf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The upcoming follow-fork-mode child support requires knowing when
fork() is about to happen in order to initialize its state. Add a hook
for that.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c        | 1 +
 gdbstub/user.c         | 4 ++++
 include/gdbstub/user.h | 5 +++++
 linux-user/main.c      | 1 +
 4 files changed, 11 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 72289673a94..35a27a07c8d 100644
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
index 3ce20b7bbfc..536fb43b03e 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -356,6 +356,10 @@ int gdbserver_start(const char *port_or_path)
     return -1;
 }
 
+void gdbserver_fork_start(void)
+{
+}
+
 static void disable_gdbstub(CPUState *thread_cpu)
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
index 1d53f708354..dce6233ee49 100644
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
2.43.2


