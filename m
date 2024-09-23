Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13606CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpY-0006WW-Sa; Mon, 23 Sep 2024 12:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0006TG-AG
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpQ-0000bX-PZ
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:27 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7VKu9003950;
 Mon, 23 Sep 2024 16:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=6LuTJ7XZ1WjC3
 WAFGOgII7433AsF/nIYoE/QHLxR5CA=; b=RM5yjuhLR6xGFNTLFs3R3Lsdtmd19
 +dqkrNPXh6AmirA5XxnQOC5yEZWY56MDSSKXKn2pPdkPbsC2BWH9m9ypyLjxc4kU
 3t8Z7Dd1z29p1yAXSww9EpOR+6ileOUlSsbpeqyPqt8VdPicQ3dIexDR3crFJL+a
 Ib1exRNvOVHiJSwF2rEA4VvhBzouGd9AcFnNvk1pZk0EJFlK7ZUIlX7u5y4dwg5T
 EFI+ylz+mU3te3b6cVIRjTqboBzuV+80AWtOr2jXUMeXCefTkskvMlFbaad2OF/L
 totnZJ/TFLQVrM+EmXXeQGdrFDgjOZavvGtPO3QG1a1Yf5aBuhtFG+BtA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjmwd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMMNU026002;
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjmwd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NETGbi012495;
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpqg0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:22 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMKwU57999636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D3C920040;
 Mon, 23 Sep 2024 16:22:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCBB620043;
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 08/18] replay: Add replay_mutex_{lock,
 unlock}() stubs for qemu-user
Date: Mon, 23 Sep 2024 18:13:03 +0200
Message-ID: <20240923162208.90745-9-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IriPYQqzJOf8kLjEmQtldDwECNzckHyv
X-Proofpoint-GUID: RxSmclyiGrhgn6MPaMHX7t1awLZ3bY5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Sharing pause_all_vcpus() with qemu-user requires providing no-op
definitions of replay mutex functions. Make these functions available
via replay-core.h and move the existing stubs to a separate file.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/exec/replay-core.h | 13 +++++++++++++
 include/sysemu/replay.h    | 13 -------------
 replay/stubs-system.c      |  8 ++++++++
 stubs/meson.build          |  4 ++++
 stubs/replay-mutex.c       | 10 ++++++++++
 stubs/replay-tools.c       |  8 --------
 6 files changed, 35 insertions(+), 21 deletions(-)
 create mode 100644 stubs/replay-mutex.c

diff --git a/include/exec/replay-core.h b/include/exec/replay-core.h
index 244c77acce5..74766bae90d 100644
--- a/include/exec/replay-core.h
+++ b/include/exec/replay-core.h
@@ -77,4 +77,17 @@ void replay_save_random(int ret, void *buf, size_t len);
 /* Loads the saved values for the random number generator */
 int replay_read_random(void *buf, size_t len);
 
+/* Replay locking
+ *
+ * The locks are needed to protect the shared structures and log file
+ * when doing record/replay. They also are the main sync-point between
+ * the main-loop thread and the vCPU thread. This was a role
+ * previously filled by the BQL which has been busy trying to reduce
+ * its impact across the code. This ensures blocks of events stay
+ * sequential and reproducible.
+ */
+
+void replay_mutex_lock(void);
+void replay_mutex_unlock(void);
+
 #endif
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 8102fa54f01..d6e0342b27c 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -51,19 +51,6 @@ typedef struct ReplayNetState ReplayNetState;
 /* Name of the initial VM snapshot */
 extern char *replay_snapshot;
 
-/* Replay locking
- *
- * The locks are needed to protect the shared structures and log file
- * when doing record/replay. They also are the main sync-point between
- * the main-loop thread and the vCPU thread. This was a role
- * previously filled by the BQL which has been busy trying to reduce
- * its impact across the code. This ensures blocks of events stay
- * sequential and reproducible.
- */
-
-void replay_mutex_lock(void);
-void replay_mutex_unlock(void);
-
 /* Processing the instructions */
 
 /*! Returns number of executed instructions. */
diff --git a/replay/stubs-system.c b/replay/stubs-system.c
index 50cefdb2d69..45984e3b098 100644
--- a/replay/stubs-system.c
+++ b/replay/stubs-system.c
@@ -94,3 +94,11 @@ void qmp_replay_seek(int64_t icount, Error **errp)
     error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
               "replay support not available");
 }
+
+void replay_mutex_lock(void)
+{
+}
+
+void replay_mutex_unlock(void)
+{
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 772a3e817df..ab4b98a0e18 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -46,6 +46,10 @@ if have_block or have_ga
   stub_ss.add(files('qmp-quit.c'))
 endif
 
+if have_block or have_ga or have_user
+  stub_ss.add(files('replay-mutex.c'))
+endif
+
 if have_block or have_user
   stub_ss.add(files('qtest.c'))
   stub_ss.add(files('vm-stop.c'))
diff --git a/stubs/replay-mutex.c b/stubs/replay-mutex.c
new file mode 100644
index 00000000000..08c69139bcb
--- /dev/null
+++ b/stubs/replay-mutex.c
@@ -0,0 +1,10 @@
+#include "qemu/osdep.h"
+#include "exec/replay-core.h"
+
+void replay_mutex_lock(void)
+{
+}
+
+void replay_mutex_unlock(void)
+{
+}
diff --git a/stubs/replay-tools.c b/stubs/replay-tools.c
index 3e8ca3212d9..2bca8ab6657 100644
--- a/stubs/replay-tools.c
+++ b/stubs/replay-tools.c
@@ -41,14 +41,6 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
     return true;
 }
 
-void replay_mutex_lock(void)
-{
-}
-
-void replay_mutex_unlock(void)
-{
-}
-
 void replay_register_char_driver(struct Chardev *chr)
 {
 }
-- 
2.46.0


