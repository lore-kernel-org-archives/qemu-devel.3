Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D8C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvPw-0005Rp-9K; Fri, 02 Feb 2024 10:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPu-0005R4-3P
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rVvPr-0006qw-Av
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:25:21 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 412EJ2N1019439; Fri, 2 Feb 2024 15:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dAmNi7SoMNLldnJhJ1LiMEGMQsPBnwlJKfRyF1v1VsY=;
 b=jQWgdFdeLkExY9F7yNSwdUZy4VcqzchUZi85QQmqNgZTeLRvilYnjSggR/p0y1RkWs8P
 aNZBlPWylvdHCRBc1CbvbKoXzhYH7rQwVcdt461hwC5vW0obRiSLWMXKA8ZKadHMrlwX
 PUjAYNzdl44ORJyUGZgdp++jqFJJJYfes7wpIFVQ70mX7JSJIDC0BJvWpi6euguRBw0g
 dybSTssjntJWtDOvGwYzBAnho9GxlOfUNz+4wGTthG3bdlRBgZ101ZDNzIy/wVQx6FVy
 KOfJqi4l3GUCfvbG9LA+sKwUfNLtkaWoITw9OsrG/7XpbSPV2jIWduqq3d82Vr2NFDII jQ== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w121vskbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 412FDu8E002230; Fri, 2 Feb 2024 15:25:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tvag6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Feb 2024 15:25:11 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 412FPAnM6685252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Feb 2024 15:25:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FEBB2004F;
 Fri,  2 Feb 2024 15:25:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EED4D2004B;
 Fri,  2 Feb 2024 15:25:09 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Feb 2024 15:25:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 2/5] gdbstub: Allow specifying a reason in stop packets
Date: Fri,  2 Feb 2024 16:23:44 +0100
Message-ID: <20240202152506.279476-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202152506.279476-1-iii@linux.ibm.com>
References: <20240202152506.279476-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uXGxla2ctzSmeEFBTXwHmj-__wYHnX6B
X-Proofpoint-GUID: uXGxla2ctzSmeEFBTXwHmj-__wYHnX6B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=552
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020112
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

The upcoming syscall catchpoint support needs to send stop packets with
an associated reason to GDB. Add an extra parameter to gdb_handlesig()
for that, and rename it to gdb_handlesig_reason(). Provide a
compatibility wrapper with an old name.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c         |  5 ++++-
 include/gdbstub/user.h | 16 ++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index dbe1d9b8875..63edca131ab 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -121,7 +121,7 @@ void gdb_qemu_exit(int code)
     exit(code);
 }
 
-int gdb_handlesig(CPUState *cpu, int sig)
+int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
 {
     char buf[256];
     int n;
@@ -141,6 +141,9 @@ int gdb_handlesig(CPUState *cpu, int sig)
                             "T%02xthread:", gdb_target_signal_to_gdb(sig));
             gdb_append_thread_id(cpu, gdbserver_state.str_buf);
             g_string_append_c(gdbserver_state.str_buf, ';');
+            if (reason) {
+                g_string_append(gdbserver_state.str_buf, reason);
+            }
             gdb_put_strbuf();
             gdbserver_state.allow_stop_reply = false;
         }
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index d392e510c59..1fc43e04af5 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -10,9 +10,10 @@
 #define GDBSTUB_USER_H
 
 /**
- * gdb_handlesig() - yield control to gdb
+ * gdb_handlesig_reason() - yield control to gdb
  * @cpu: CPU
  * @sig: if non-zero, the signal number which caused us to stop
+ * @reason: stop reason for stop reply packet or NULL
  *
  * This function yields control to gdb, when a user-mode-only target
  * needs to stop execution. If @sig is non-zero, then we will send a
@@ -24,7 +25,18 @@
  * or 0 if no signal should be delivered, ie the signal that caused
  * us to stop should be ignored.
  */
-int gdb_handlesig(CPUState *, int);
+int gdb_handlesig_reason(CPUState *, int, const char *);
+
+/**
+ * gdb_handlesig() - yield control to gdb
+ * @cpu CPU
+ * @sig: if non-zero, the signal number which caused us to stop
+ * @see gdb_handlesig_reason()
+ */
+static inline int gdb_handlesig(CPUState *cpu, int sig)
+{
+    return gdb_handlesig_reason(cpu, sig, NULL);
+}
 
 /**
  * gdb_signalled() - inform remote gdb of sig exit
-- 
2.43.0


