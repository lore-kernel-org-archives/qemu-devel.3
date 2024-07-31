Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25BCC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 14:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZAaJ-0003Yd-PS; Wed, 31 Jul 2024 10:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZAaI-0003Su-9A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZAaG-0004vo-4k
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 10:45:46 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VDWC6B022825;
 Wed, 31 Jul 2024 14:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=pp1; bh=oH3gOXuYb4jQME2X7pls3RH44T
 Qm1s20cNjtyqmX3bU=; b=Nic7him3SBiRmIZl7XGw6dykl4Op3QzoUev31eJMrQ
 zilpM9DjeLVmB6Apgs1RbR7t4Ert8UlQelui1/WIV4JrxJdVyFNWWRQ7sbCxevlA
 HuvypJqKhfvjj/ELi6x0ZlGm1CT3E2OafnFfZ1ZR/0qaP0BZXBi9YshVe6AdEf6Z
 OW/gGxruWmScpvu49QIVOYFbjNHJQhfXscLC9zYmUeNzK4wi95ugQc2NA4oljIxo
 v9IUq3RCaPdjwKQQJ4NN2+O5gsi912c20AfvRBUwa7rXAgn97qdj5cGK17iJeYue
 FLA/+hPk1G818FBwk0gqajlIp2PU7BR98YyJwwBXVTPA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qk46rtpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 14:45:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46VC654c011143; Wed, 31 Jul 2024 14:45:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmv2ka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 14:45:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46VEjXaJ38142246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jul 2024 14:45:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D61A2004B;
 Wed, 31 Jul 2024 14:45:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3073020043;
 Wed, 31 Jul 2024 14:45:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.57.89])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 Jul 2024 14:45:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] bsd-user/main: Allow setting tb-size
Date: Wed, 31 Jul 2024 16:45:20 +0200
Message-ID: <20240731144532.5997-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a43fRV3hzE8wZIEAjlkBF97z922Gem5o
X-Proofpoint-GUID: a43fRV3hzE8wZIEAjlkBF97z922Gem5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 phishscore=0 clxscore=1011 mlxscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=732 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310100
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

While qemu-system can set tb-size using -accel tcg,tb-size=n, there
is no similar knob for qemu-bsd-user. Add one in a way similar to how
one-insn-per-tb is already handled.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index cc980e6f401..7c230b0c7a5 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -60,6 +60,7 @@ uintptr_t qemu_host_page_size;
 intptr_t qemu_host_page_mask;
 
 static bool opt_one_insn_per_tb;
+static unsigned long opt_tb_size;
 uintptr_t guest_base;
 bool have_guest_base;
 /*
@@ -169,6 +170,7 @@ static void usage(void)
            "                  (use '-d help' for a list of log items)\n"
            "-D logfile        write logs to 'logfile' (default stderr)\n"
            "-one-insn-per-tb  run with one guest instruction per emulated TB\n"
+           "-tb-size size     TCG translation block cache size\n"
            "-strace           log system calls\n"
            "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
            "                  specify tracing options\n"
@@ -387,6 +389,11 @@ int main(int argc, char **argv)
             seed_optarg = optarg;
         } else if (!strcmp(r, "one-insn-per-tb")) {
             opt_one_insn_per_tb = true;
+        } else if (!strcmp(r, "tb-size")) {
+            r = argv[optind++];
+            if (qemu_strtoul(r, NULL, 0, &opt_tb_size)) {
+                usage();
+            }
         } else if (!strcmp(r, "strace")) {
             do_strace = 1;
         } else if (!strcmp(r, "trace")) {
@@ -452,6 +459,8 @@ int main(int argc, char **argv)
         accel_init_interfaces(ac);
         object_property_set_bool(OBJECT(accel), "one-insn-per-tb",
                                  opt_one_insn_per_tb, &error_abort);
+        object_property_set_int(OBJECT(accel), "tb-size",
+                                opt_tb_size, &error_abort);
         ac->init_machine(NULL);
     }
 
-- 
2.45.2


