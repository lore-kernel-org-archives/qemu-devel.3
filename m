Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98CCC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxxB-00089E-Jb; Fri, 16 Feb 2024 08:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxA-000894-TU
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxx8-0001OD-Rv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:32 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GC86Lo011331; Fri, 16 Feb 2024 13:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zhs9QxDvGtIFjJ8pNr0Qfm2V7gj69ngviyLnvjqtTgE=;
 b=JUNWnLXG5F1rfOYcL5uAVcuxivRF+LTf97Ha3FM1ilIxnOj4aXkTH38C35U3vn8t5vb1
 MYEBVOxW5Vg7dnE5vVxtiQx3ekiIECJaQfyqxtSTBqMW8Sz2fo4SdMJoJc8hwPyugMvK
 OOhhKOFbAMzeHqmIZ8Dqo6lnT+0VS8tgSy97KenCv5iODT1zugzP3tno8hK6JJ1KjTfi
 tC+YEMGVbe/axPtu7Gjb5nNRNMEuunj83mq0cNlSptURq0HeAP4KdOxJ2tMKzQD3FkTf
 cJ1DNuiO1sT83SvlWBdogTA+LbwDexHTBon9KSb6C/m/CEUXj1Z1ION7ABMZbA0C9mRp 9A== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7eh9afd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GBoRLq004258; Fri, 16 Feb 2024 13:08:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0uk9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GD8NQH42205792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 13:08:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED8E02004F;
 Fri, 16 Feb 2024 13:08:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B40A020043;
 Fri, 16 Feb 2024 13:08:22 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Feb 2024 13:08:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 01/11] gdbstub: Support disablement in a multi-threaded
 process
Date: Fri, 16 Feb 2024 14:05:28 +0100
Message-ID: <20240216130817.369377-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216130817.369377-1-iii@linux.ibm.com>
References: <20240216130817.369377-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WZnNZt47bqsTSWCabh-4N8g4WpR5ZYKT
X-Proofpoint-GUID: WZnNZt47bqsTSWCabh-4N8g4WpR5ZYKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The upcoming follow-fork-mode child support will require disabling
gdbstub in the parent process, which may have multiple threads (which
are represented as CPUs).

Loop over all CPUs in order to remove breakpoints and disable
single-step. Move the respective code into a separate function.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 14918d1a217..e17f7ece908 100644
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


