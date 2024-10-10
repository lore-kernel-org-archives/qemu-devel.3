Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FAACEE323
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 09:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sypUb-0001mU-II; Thu, 10 Oct 2024 05:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUW-0001kM-HJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sypUV-000425-3F
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 05:29:52 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A6XLxv029153;
 Thu, 10 Oct 2024 09:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=raGt82Lvie/fI
 t220smPBBRBaaTO+apes42SKzL3CmM=; b=LF2vd5yMjov8opxILyXbtJtUvvE9E
 1IcOSdjr1ge9LbvgzLGjc6D/Ox+gxesMOSxaixxTRbjnvvzD206U02tXYunL9D0y
 U7urlxN+v7cEGHbJywtj/EJSBeAHaJZFLqrc8FshGkX4ptrpyJUuVUASteVKKFI2
 dH9Pl1h8+85hM8JWdKmh8LnuU48+baXXF6vBvDcBCUqaS2z77i8MIqL7vA5BO/VY
 YVzEDNCuCe7Kt6EcVIqnyQJsAK23s+s3JH/Nig/8/S4IIHMS12f3kDzivYmGdyuh
 Gjy4r0kyNTixHYt4aybEq/PvSman6f8hU9ypzTi+KwK9npt4b9m41mUUQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4269rn8us4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A6Wdgw010711;
 Thu, 10 Oct 2024 09:29:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 423j0jpr29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Oct 2024 09:29:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49A9TkEX51511720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Oct 2024 09:29:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEA662004B;
 Thu, 10 Oct 2024 09:29:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70ACC20040;
 Thu, 10 Oct 2024 09:29:46 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.88.135])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Oct 2024 09:29:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/4] gdbstub: Move gdb_syscall_mode to GDBSyscallState
Date: Thu, 10 Oct 2024 11:26:58 +0200
Message-ID: <20241010092938.226868-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241010092938.226868-1-iii@linux.ibm.com>
References: <20241010092938.226868-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rJMyV03N7z9aL8ARayiR51ZDx9no0kSV
X-Proofpoint-GUID: rJMyV03N7z9aL8ARayiR51ZDx9no0kSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_05,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100060
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Follow the convention that all the pieces of the global stub state must
be inside a single struct.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/syscalls.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 4ddd5cae067..bf6a6c01b4f 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -24,6 +24,11 @@
 typedef struct {
     char syscall_buf[256];
     gdb_syscall_complete_cb current_syscall_cb;
+    enum {
+        GDB_SYS_UNKNOWN,
+        GDB_SYS_ENABLED,
+        GDB_SYS_DISABLED,
+    } mode;
 } GDBSyscallState;
 
 static GDBSyscallState gdbserver_syscall_state;
@@ -37,12 +42,6 @@ static bool gdb_attached(void)
     return gdbserver_state.init && gdbserver_state.c_cpu;
 }
 
-static enum {
-    GDB_SYS_UNKNOWN,
-    GDB_SYS_ENABLED,
-    GDB_SYS_DISABLED,
-} gdb_syscall_mode;
-
 /* Decide if either remote gdb syscalls or native file IO should be used. */
 int use_gdb_syscalls(void)
 {
@@ -57,16 +56,17 @@ int use_gdb_syscalls(void)
 
     /* -semihosting-config target=auto */
     /* On the first call check if gdb is connected and remember. */
-    if (gdb_syscall_mode == GDB_SYS_UNKNOWN) {
-        gdb_syscall_mode = gdb_attached() ? GDB_SYS_ENABLED : GDB_SYS_DISABLED;
+    if (gdbserver_syscall_state.mode == GDB_SYS_UNKNOWN) {
+        gdbserver_syscall_state.mode = gdb_attached() ? GDB_SYS_ENABLED :
+                                                        GDB_SYS_DISABLED;
     }
-    return gdb_syscall_mode == GDB_SYS_ENABLED;
+    return gdbserver_syscall_state.mode == GDB_SYS_ENABLED;
 }
 
 /* called when the stub detaches */
 void gdb_disable_syscalls(void)
 {
-    gdb_syscall_mode = GDB_SYS_DISABLED;
+    gdbserver_syscall_state.mode = GDB_SYS_DISABLED;
 }
 
 void gdb_syscall_reset(void)
-- 
2.46.2


