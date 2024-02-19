Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6317DC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Si-0007mb-Bx; Mon, 19 Feb 2024 09:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SY-0007d3-D8
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rc4SU-0000cJ-Nf
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 09:17:29 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JEFwt3008152; Mon, 19 Feb 2024 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wv5q55T7DBUCSPfm1dqGkC3td6hrm7zqdhz9jAaq6As=;
 b=PBi2Iyqbf3vETS/VAXLs5VPOX3Zta++sv3greCLHjAytHjX8mVZyP5RKGXwGbyIMiq9N
 HC+xIM/i4prdyeJoErYqcadRRn/brDWq1y/e0U+VrISyCdvlrEANkO+cE4aZmRySRgUn
 uyxuAJ6OOwx6pBqy9yS+ukiW7r0IU/3fRpT6mo0MrQ1tnrK86ewAkkKWF4295DamuWiM
 jdOEdZgkvXgF/eizsy/UMYuOlNOOm8d1Mh13dUIHs4z8T0ipcxvz9F1AbVp3AzvvItBT
 Qqic6iFpXIC24UyOoFWmjXmP1OHNhOZPR5yObM5lYXYArNWdIn/pF9+yFpfuXs+wNUHt zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwjvmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:06 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41JEGCYm008954;
 Mon, 19 Feb 2024 14:17:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wbdgwjvma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:05 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41JBfmoH017278; Mon, 19 Feb 2024 14:17:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mm1gdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Feb 2024 14:17:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41JEH0dI39453080
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Feb 2024 14:17:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC22A20043;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1FCF2004F;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Feb 2024 14:16:59 +0000 (GMT)
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
Subject: [PATCH v4 10/12] gdbstub: Introduce gdb_handle_detach_user()
Date: Mon, 19 Feb 2024 15:15:58 +0100
Message-ID: <20240219141628.246823-11-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219141628.246823-1-iii@linux.ibm.com>
References: <20240219141628.246823-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eR_9EridOe01Yh_exa2meT9DXXriUOBl
X-Proofpoint-ORIG-GUID: G3eUXmZXRpyz7Ty0hUgGF1FBV39AAaSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The upcoming follow-fork-mode child support needs to perform certain
actions when GDB detaches from the stopped parent or the stopped child.
Introduce a user-specific hook for this.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c   | 6 ++++++
 gdbstub/internals.h | 1 +
 gdbstub/user.c      | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 05fcdd86527..219b0422f9a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -991,6 +991,12 @@ static void handle_detach(GArray *params, void *user_ctx)
         pid = get_param(params, 0)->val_ul;
     }
 
+#ifdef CONFIG_USER_ONLY
+    if (gdb_handle_detach_user(pid)) {
+        return;
+    }
+#endif
+
     process = gdb_get_process(pid);
     gdb_process_breakpoint_remove_all(process);
     process->attached = false;
diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index b4905c7181a..b4724598384 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -198,6 +198,7 @@ void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_supported_user(const char *gdb_supported); /* user */
 bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
+bool gdb_handle_detach_user(uint32_t pid); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index b048754c4f8..1a7b582a40d 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -391,6 +391,11 @@ bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid)
     return false;
 }
 
+bool gdb_handle_detach_user(uint32_t pid)
+{
+    return false;
+}
+
 /*
  * Execution state helpers
  */
-- 
2.43.2


