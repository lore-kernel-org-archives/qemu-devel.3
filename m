Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 404D3CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 17:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP1j6-0007qk-U6; Mon, 18 May 2026 13:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1j2-0007oc-7M; Mon, 18 May 2026 13:25:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wP1iz-0005Le-9Z; Mon, 18 May 2026 13:25:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IDLwST1522114; Mon, 18 May 2026 17:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bWrbrH8Gbs1X+3YUy
 GyMnzOhsFrcZCHun3sMC4y2io8=; b=nr/xNdIQhEzEZwuuhbrUgkh3PPgncpNeI
 FUEpq16gPx5Cu3xG1JA++0X33d3pbx5K1y0JSuvaKvZTprHhbHLmy7fwIM2FHDzD
 nSko2hzjnh67kqvMMygmzNFw/4l3wSbUeCiPhoVP1FK+htk9Rp6XMWr1cJ+q+Rpn
 c1gmDhTw4dUFJf6TGGPajIE0HXbngV6mDGyVfhpLfjYHCnpfiK4xsBzRRZIk/gCJ
 /L8/S8uH+iSh6L+14AlkEt7NG4CcAWQZP9+wytcMB25hmVELK98tdrbpV7bdverc
 EjjWKazwUANu8k2n7+4YOxDLrrzUsGFZjZPQXFljvqbQGWYZyiQyA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xsafy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IHODWT006900;
 Mon, 18 May 2026 17:25:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhevva-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2026 17:25:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64IHPhOE19530156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2026 17:25:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65522004D;
 Mon, 18 May 2026 17:25:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7B2120043;
 Mon, 18 May 2026 17:25:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.56])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 May 2026 17:25:40 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] tests/qtest/libqtest: Fix const violation in
 qtest_verbose()
Date: Mon, 18 May 2026 22:55:16 +0530
Message-ID: <20260518172517.12466-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518172517.12466-1-amachhiw@linux.ibm.com>
References: <20260518172517.12466-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX6TePAApzi9PJ
 r/khQkeM2KYzNTMem6Uv9PtcoJiXRyDSRqDF68MskRO9KX7pUvW+AN5vTcMU5vjmM6S3GnEMu1y
 z7kBo1aPPfJYEyN4YaQGGabHrm6hcCJPi/FTIAXLMC7o9/SktclY1zyoGwLmW7bKCHUwP8FFgqi
 Sl8pnyM3tk/ap1BFiYdyvecyAEc1gLC51n7EYxXgnyjx4+xqc4vVLpJJyQ0Hbynqo9eOouET306
 hIy9nOrAIYzYsZv8/Y59ABSfn7h9eKvPqnyu+MtBsLa865urQyW0xH19YkiCJ41L86ipRkES3Zu
 AZeHPdu1RZ7GCvCgc5T6a8eFTo4+GyhsMh7fDTD3YfHr14PCrEtEj00zp21bodxVuJy4fwrH97o
 Y3kszocgAXHEKYTV9wc7f/3ecVdEuQNvJX120F96ep0nj7/YXpA2HErNQV+W47Uj6qPQthERXPg
 bQ/OOWeCX9m3UqlAirQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b4b9c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=jvbmTW_T06IUh0XMFxoA:9
X-Proofpoint-ORIG-GUID: 5R1BAxSEQDTbegTqlLIBGzJfZE4Z_8sJ
X-Proofpoint-GUID: 5R1BAxSEQDTbegTqlLIBGzJfZE4Z_8sJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180168
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

GCC 16 tightens const-correctness checking and reports:

  error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
        found = strstr(log, domain);
	      ^

in qtest_verbose() because strstr() returns a non-const pointer while
operating on a const-qualified string from getenv().

While getenv() returns char *, the returned environment string is
semantically treated as read-only. Use g_getenv() and g_strstr_len() so
that the local string pointers remain const-qualified throughout. This
maintains const correctness throughout and aligns with QEMU's use of
GLib string functions.

No functional change intended.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 tests/qtest/libqtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index bf9284b9a131..cb80ab23182a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2145,8 +2145,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
 bool qtest_verbose(const char *domain)
 {
-    const char *log = getenv("QTEST_LOG");
-    char *found;
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
 
-- 
2.50.1 (Apple Git-155)


