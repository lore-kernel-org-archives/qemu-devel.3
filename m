Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B379C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 21:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYuot-00045p-2l; Tue, 30 Jul 2024 17:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sYuor-00045I-DK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:55:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sYuop-0002u8-4a
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 17:55:44 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ULN3au025278;
 Tue, 30 Jul 2024 21:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=54QxnoIfTYgpZ2igM8irFJMiO8
 75+1J60Q8Am2iQT4M=; b=VhrTSi1I5B3uNjhg4syBZytXWtWu/lb83xrQpeKuyF
 lCsV2JZb/dQSFhXBTDGl4T88S7ypP3Xdv/MUkmmVIKZS7JdKtT1SL3kIhE3NMwMM
 KVtxa5F4TVddikIxXp/sdK5aYHITY3kYV3zqy0ohw1OBFYvUnCmWgKG3bTJaVL+k
 /1J/UkvLDHVbeV9XZEj4A4gJko6XtqhBKonayriaTDZ1GmsHzTvbKu2PQXVaC9st
 3oTUGcQF62ayGtjDnt10iNwcfPG3o7kk9Qkcsr6iL41MC8oSFAHFhQY2duxFqu9Y
 1vyJB4BuAI3kXp/4BLmOTRlz5vwgCXNcClvH2MWOaxhg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q5xf0fnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 21:55:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46ULHgOC009211; Tue, 30 Jul 2024 21:55:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx2y9nf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2024 21:55:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46ULtZbU8126888
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jul 2024 21:55:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 162452004B;
 Tue, 30 Jul 2024 21:55:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD6A420043;
 Tue, 30 Jul 2024 21:55:34 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.30.41])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jul 2024 21:55:34 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user/main: Allow setting tb-size
Date: Tue, 30 Jul 2024 23:54:57 +0200
Message-ID: <20240730215532.1442-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3vO_gS9AmXrhRafLypkW8bwJUzjFdeKh
X-Proofpoint-GUID: 3vO_gS9AmXrhRafLypkW8bwJUzjFdeKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_17,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 mlxlogscore=851 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300151
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

While qemu-system can set tb-size using -accel tcg,tb-size=n, there
is no similar knob for qemu-user. Add one in a way similar to how
one-insn-per-tb is already handled.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index d502945222b..6c5123aac57 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -72,6 +72,7 @@ char *exec_path;
 char real_exec_path[PATH_MAX];
 
 static bool opt_one_insn_per_tb;
+static unsigned long opt_tb_size;
 static const char *argv0;
 static const char *gdbstub;
 static envlist_t *envlist;
@@ -418,6 +419,13 @@ static void handle_arg_one_insn_per_tb(const char *arg)
     opt_one_insn_per_tb = true;
 }
 
+static void handle_arg_tb_size(const char *arg)
+{
+    if (qemu_strtoul(arg, NULL, 0, &opt_tb_size)) {
+        usage(EXIT_FAILURE);
+    }
+}
+
 static void handle_arg_strace(const char *arg)
 {
     enable_strace = true;
@@ -507,6 +515,8 @@ static const struct qemu_argument arg_table[] = {
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
+    {"tb-size",    "QEMU_TB_SIZE",     true,  handle_arg_tb_size,
+     "size",       "TCG translation block cache size"},
     {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
      "",           "log system calls"},
     {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
@@ -803,6 +813,8 @@ int main(int argc, char **argv, char **envp)
         accel_init_interfaces(ac);
         object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                                  opt_one_insn_per_tb, &error_abort);
+        object_property_set_int(OBJECT(accel), "tb-size",
+                                opt_tb_size, &error_abort);
         ac->init_machine(NULL);
     }
 
-- 
2.45.2


