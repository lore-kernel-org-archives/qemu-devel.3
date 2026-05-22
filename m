Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1875FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQLD3-0000ab-6F; Fri, 22 May 2026 04:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQLD1-0000aC-Gh; Fri, 22 May 2026 04:26:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wQLCz-0003ga-NL; Fri, 22 May 2026 04:26:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0ghB1795743; Fri, 22 May 2026 08:26:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=gP4eIMrCm/sjEeUVWJ/H2/1+92DRkNvRRdjEsCA5u
 zE=; b=EZUYK/RZQdmRgJKW/uG9orqaK4+GqwG0HSsnQBd9bau4FCHax3EaLKH2U
 bIzEjUx4cddexsR9oEdBjXLiZRdZwu0up9f5Coa1WJiddOVPGD6fCBLCIBq1o7xT
 T5F3xXhKgHpvKrwpkQeNIbCBstvdMrLc+39Fo77vzwW2vm94gQzIl2sSUOnathIP
 SrRvqjXKNtC5hXIaB/fnxHiGdQ36FSThwYK1awHTxThxoXp2W8y6A+d1zC8TYX38
 oU8b7J3AYIUAMt0lZshm4I6oqeX4H3pmXa/+QNmtlt1ZB7ACOPZ5RYlvUoO2vuV/
 ceG374d5Ir1VX4QJKyvmQig6wM0QQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n3171-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:26:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M8OOgU015157;
 Fri, 22 May 2026 08:26:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkg3j8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 08:26:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64M8Q3YL50266560
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 08:26:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 530A920043;
 Fri, 22 May 2026 08:26:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 568FC2004E;
 Fri, 22 May 2026 08:26:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.216.126])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 08:26:00 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Penney <matt@matthewpenney.net>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] tests/qtest/libqtest: Use GLib functions for proper const
 correctness
Date: Fri, 22 May 2026 13:55:55 +0530
Message-ID: <20260522082555.54918-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jxzMo7E-6-I9o4TFBibHTJU6ZoJrlJZf
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a101320 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jvaL8Bd8GjUaJr6_dqQA:9
X-Proofpoint-ORIG-GUID: jxzMo7E-6-I9o4TFBibHTJU6ZoJrlJZf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MCBTYWx0ZWRfX8uWH51xXqymb
 Qp03ypU+pwM9kkTTmj4ViLSWJ8oXRRCwrZy+kxPtmlJTl4qyOujes7UXYI7dfCxVda8/hxt/9gG
 Q/czK+sCNG5CYJ/KKuWbPaHObq6X2YB9K5/Nhc2oHPO3llqhh5WGh6cRNaF2trtbT7IH8A5pDa+
 ljdw+lxoGd6WoTZoKAqpxHFt+hXrN5L+xGKVslAqvVC7oDy1E/PxXZKN/GvrZELgg94gwRBZhi6
 c7fejsbkSHuE89SoWl6rV0HWGnOBtw46Q8JvxfYgacATGW16hlIXf72X56m0PU9BMKCFHt76vw3
 oHjV/4Sf/A2pyvDZ5vyTKNDR4e027u19HRG1+Bp6KXH6n66im58g5kDEGIr8ZD+cjJc5Bvlcwu5
 yVVSJAqqptl7tlfzwph/eC8bRSI6puAYNoq8iX325jV7ZWl0B/EK2theufgTUnnSIO3VVvVnAav
 E53glHcvZaVGreQbNVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While commit e68da5b7a2cd ("tests/qtest: fix discarded const qualifier
warning") addressed the immediate strstr() warning by making 'found'
const, there's still a room for improvement: getenv() returns char *, but
environment strings are semantically read-only and should be treated as const
throughout their lifetime.

Replace getenv() with g_getenv() and strstr() with g_strstr_len() to
maintain const correctness from source to use. This approach:

- Uses g_getenv() which returns const gchar *, matching the read-only
  semantics of environment variables
- Employs g_strstr_len() for consistent use of GLib string functions,
  aligning with QEMU conventions
- Eliminates all const-correctness warnings with strict compilers

Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
v2:
- Rebased on top of e68da5b7a2cd ("tests/qtest: fix discarded const qualifier warning")
- Split from previous patch series and sent as standalone patch
- Updated commit message to clarify relationship with prior fix
- Retaining tags from previous version as no major changes

 tests/qtest/libqtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1e06ea364ec..cb80ab23182a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2145,8 +2145,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
 bool qtest_verbose(const char *domain)
 {
-    const char *log = getenv("QTEST_LOG");
-    const char *found;
+    const gchar *found, *log = g_getenv("QTEST_LOG");
 
     assert(domain);
 
@@ -2172,11 +2171,11 @@ bool qtest_verbose(const char *domain)
          *  QTEST_LOG=<domain1>,-<domain2> (only false for domain2)
          *  allows other separators, except - and +
          */
-        found = strstr(log, domain);
+        found = g_strstr_len(log, -1, domain);
 
         if (found) {
             /* reject options given twice */
-            assert(!strstr(found + strlen(domain), domain));
+            assert(!g_strstr_len(found + strlen(domain), -1, domain));
 
             if (found > log) {
                 ptrdiff_t i = found - log - 1;
@@ -2190,7 +2189,7 @@ bool qtest_verbose(const char *domain)
              * If filtering out a specific domain, all others are
              * enabled.
              */
-            return !!strstr(log, "-");
+            return !!g_strstr_len(log, -1, "-");
         }
     }
 

base-commit: f5a2438405d4ae8b62de7c9b39fac0b2155ee544
-- 
2.50.1 (Apple Git-155)


