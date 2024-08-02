Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315B0C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZp7D-0007JC-8q; Fri, 02 Aug 2024 06:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp7B-0007Cl-Ca
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp78-0004gT-Lk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:25 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729Iqd9021203;
 Fri, 2 Aug 2024 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=iIVjvu85D9K1q
 hEziIv0wA1/t1l4O02FOAAC99avhnI=; b=kGXhBYRZhVgpnS6IEm4WOSCjUUkt2
 PV2Q0i4Q159oq7JQeMUQtzQmi/S04T3pH3ts8TQlwQItKR7nPwsWM1F73+2sg5nt
 L7EhcvaNS2Bx2IcFesInEmgMRvJhjZZmCTW4SDqQIYxqtvLXsEPR7IwcFockNXQs
 n8ebj2tc4PJcDjFUncX1/t8zpzmEyOjPIHyxQcPbOiKDeqyApmiHiZ1SkdotnmvT
 Vf/v7WMkyOFXfJLl/9UAyFGReGsVVd1mYF3JzoGiNl4k2I4TYd4XhDDPHWnPk+sG
 Oh0Q692XqVVe5aFk6swHFgchu3thQG0Wbq9hilNLk6e2xqww1wgVuvkNQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3j89c1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:18 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472A2HOU000924;
 Fri, 2 Aug 2024 10:02:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ru3j89bv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4727dOEr018863; Fri, 2 Aug 2024 10:02:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q6n2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472A2DQD57868674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 10:02:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8F9A2005A;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9268B2006E;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.14.120])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 5/5] tests/tcg: Run test-proc-mappings.py on i386
Date: Fri,  2 Aug 2024 11:59:18 +0200
Message-ID: <20240802095942.34565-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802095942.34565-1-iii@linux.ibm.com>
References: <20240802095942.34565-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RBWOLJJzSaSMZfGJ5dRc78Qk-HuEJr-K
X-Proofpoint-ORIG-GUID: Ihzb_VpYyTY_hOeEi1ds0RAZP0Iz8hq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=983 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408020066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that orig_ax is exposed and GDB is happy, don't skip
test-proc-mappings.py on i386. In fact, it's broken only on
m68k now, so skip only this architecture.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../tcg/multiarch/gdbstub/test-proc-mappings.py | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
index 564613fabf0..0f687f3284a 100644
--- a/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
+++ b/tests/tcg/multiarch/gdbstub/test-proc-mappings.py
@@ -8,17 +8,12 @@
 
 def run_test():
     """Run through the tests one by one"""
-    try:
-        mappings = gdb.execute("info proc mappings", False, True)
-    except gdb.error as exc:
-        exc_str = str(exc)
-        if "Not supported on this target." in exc_str:
-            # Detect failures due to an outstanding issue with how GDB handles
-            # the x86_64 QEMU's target.xml, which does not contain the
-            # definition of orig_rax. Skip the test in this case.
-            print("SKIP: {}".format(exc_str))
-            return
-        raise
+    if gdb.selected_inferior().architecture().name() == "m68k":
+        # m68k GDB supports only GDB_OSABI_SVR4, but GDB_OSABI_LINUX is
+        # required for the info proc support (see set_gdbarch_info_proc()).
+        print("SKIP: m68k GDB does not support GDB_OSABI_LINUX")
+        exit(0)
+    mappings = gdb.execute("info proc mappings", False, True)
     report(isinstance(mappings, str), "Fetched the mappings from the inferior")
     # Broken with host page size > guest page size
     # report("/sha1" in mappings, "Found the test binary name in the mappings")
-- 
2.45.2


