Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C26CCD193
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8htO-0005in-Ip; Tue, 14 Oct 2025 12:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8htF-0005hj-7C; Tue, 14 Oct 2025 12:28:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8ht9-0000D9-Ok; Tue, 14 Oct 2025 12:28:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EF7bYw011625;
 Tue, 14 Oct 2025 16:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LBbTVeL3QV0aGhxbK
 kIXnlK/nxZWrd12azzvwHaSGPY=; b=KmuKz2WsxiWZnoczfJ/9QlIzh7SEyc+RM
 RpqC5a/DREQiCNvncALtThewM+wL5spUdEoz9Rj3wIjlXHM4NqTJfas5gt5V7ma+
 X413NBIdiVxywhMjnN1tenfUlswR990tMCTFniMDTdGnhzX/t3R9nyZ5IDl/qlBc
 uOSPSWF0hQEPPLoC8PMXzm+uoaBPIpxZsF//if07zPFNdb94H6APDb93vl/MdluX
 xWgLRgDgcXjsIn1D9G9uZj8ybUI5Es40YCOkGERmTkujMI4T4dLHbVXS/eWTI65t
 3Kph5PBTomKtrHuAJFeA+ImH1npj2X8vUZWNJIgtsmB1J9iohkftw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnr7gwb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:28:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFFRkV016759;
 Tue, 14 Oct 2025 16:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jut7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:28:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59EGSSGk52363692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 16:28:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 770DB20115;
 Tue, 14 Oct 2025 16:07:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08C6520114;
 Tue, 14 Oct 2025 16:07:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.67.246])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 16:07:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 1/3] target/s390x: Fix missing interrupts for small CKC values
Date: Tue, 14 Oct 2025 18:05:13 +0200
Message-ID: <20251014160743.398093-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014160743.398093-1-iii@linux.ibm.com>
References: <20251014160743.398093-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ee7a2e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DMoVdRysFPNM0ZNGwSsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 4HSuIqRRqWjsvX1pOxUyYoPCEC91cn8J
X-Proofpoint-ORIG-GUID: 4HSuIqRRqWjsvX1pOxUyYoPCEC91cn8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX0Qok/EQ8qj3l
 c3cXoQv0QWW05iAW8M2o4kY4/AuIu8eUfAC7am1PPZGhRHMVtGvY68hvGgTTt8QDzceJkP2BC5+
 bjJyF8asTIsRL51Rd3ag5iKXP0KcfUo4X/GNTOgKwzjCyXQoHQ7ndM/ZWUnwyScTbhRKamN41Xw
 MXQ4fDaeJKHruS1Fs9HHEqzyXbOaq5uAe7rjvWlW9peLiWjrgQG6nIQQBC47sGiWBTUOqRuWeB3
 zC336mrss8ZT6YPmjsZ5u9bBaogL/3RAumFAuGs5Zg4vg6GgRareihGTU+NmQJeyZpm6b/lxDpF
 CcDGNvxJrpdZRpIBlVtcC9+wFpGc3Ht2s3013bP4SDTR6r8rTpzeUs5zNm00ab1vJSMD6DgPi96
 FKm3PhI8e9os5b1fTi4sgfIWHD5wbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suppose TOD clock value is 0x1111111111111111 and clock-comparator
value is 0, in which case clock-comparator interruption should occur
immediately.

With the current code, tod2time(env->ckc - td->base.low) ends up being
a very large number, so this interruption never happens.

Fix by firing the timer immediately if env->ckc < td->base.low.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/misc_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 6d9d601d29a..afcf7688eda 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
         return;
     }
 
-    /* difference between origins */
-    time = env->ckc - td->base.low;
+    if (env->ckc < td->base.low) {
+	time = 0;
+    } else {
+	/* difference between origins */
+	time = env->ckc - td->base.low;
 
-    /* nanoseconds */
-    time = tod2time(time);
+	/* nanoseconds */
+	time = tod2time(time);
+    }
 
     timer_mod(env->tod_timer, time);
 }
-- 
2.51.0


