Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E683FCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9SH4-0002kb-CM; Thu, 16 Oct 2025 14:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGz-0002iF-3A; Thu, 16 Oct 2025 14:00:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v9SGu-0002xC-2v; Thu, 16 Oct 2025 14:00:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GBotgt021944;
 Thu, 16 Oct 2025 18:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VsSOpe6pgGj5wbRdO
 8x5We83G5GYrOJq7kqoOz19YGc=; b=TS3JTZDxFo1jsplT6WmD96jo1eGPe2lcA
 ks7TQGKbdzwVpl7yLEEFE0FWTnsFltIoRkfwXLey0z17Qo7sZ0cEpRlCsbwCrgfV
 QHt44Ca1NAvrKY6uwmcIDnXWkBuZfVP8U7hbLfNZVqWiavchFo/tuNjFH5mblnm3
 G4e/ePZyptroPQteVAARaGm/hkmRkuJQZuwY2MlpmfdeQB4r1g86fKuKqRO6Q4uM
 u7ds6RspsCkdjlmTd/tmxEuq5AxQiguad4M/Ou5UbqKnjmf+i5ZBROhUh75uwIty
 ptMV/q2H1rmsgLdLjistMtv0cNsQMEoPZKl3ufwyEZu5trBaFlFIQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey94f4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GH4fwL003603;
 Thu, 16 Oct 2025 18:00:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy784r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 18:00:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GI07lQ47907280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 18:00:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A87A20087;
 Thu, 16 Oct 2025 18:00:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A181F20082;
 Thu, 16 Oct 2025 18:00:06 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 18:00:06 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v4 1/4] target/s390x: Fix missing interrupts for small CKC
 values
Date: Thu, 16 Oct 2025 19:58:30 +0200
Message-ID: <20251016175954.41153-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175954.41153-1-iii@linux.ibm.com>
References: <20251016175954.41153-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Oen8N2DO2jp1q3ylw63vflpIGjDCTfyo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX7aQBmwIRYwfg
 qq+PpbhVPtNbL4fZNJEKtSbIgZCuVewoU1uWSC4icCPYdVvUfA+CO0PZeRaJFVTVp214SwJmvyc
 4tZ6On1gBWs85W+Spyf4jTR3vluWHzZSinmdoEV1dnORYVQWLv3ri5uVuT5yXAkrYKrsXz2NTx+
 hkUQiDV62KLWZQNgBJUZrROap7CoN2F+gRfhPqnNH4DMWSct+Z4dWPi5sXSOLLe0fjeh+U7UujM
 JQyZWzK9nrsPJrF170QYn3Xp9/ggaRiNo8DWOVjhc7Ps1ovodH8OzWFamU2yuVhNCTx66Gp2WW9
 2Ite7MZuLFsQL5bIRqlG7jba+ERnGuN7hvcYrE4iXscO/jMU0vPbC3RGyyO1M4nBcLIkrbQqc46
 k6ebwSf/j83bmrMQdmgm9BtVSAXm5g==
X-Proofpoint-GUID: Oen8N2DO2jp1q3ylw63vflpIGjDCTfyo
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68f132aa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=69wJf7TsAAAA:8 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=DMoVdRysFPNM0ZNGwSsA:9 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suppose TOD clock value is 0x1111111111111111 and clock-comparator
value is 0, in which case clock-comparator interruption should occur
immediately.

With the current code, tod2time(env->ckc - td->base.low) ends up being
a very large number, so this interruption never happens.

Fix by firing the timer immediately if env->ckc < td->base.low.

Cc: qemu-stable@nongnu.org
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/s390x/tcg/misc_helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index 6d9d601d29a..215b5b9d933 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -199,11 +199,15 @@ static void update_ckc_timer(CPUS390XState *env)
         return;
     }
 
-    /* difference between origins */
-    time = env->ckc - td->base.low;
+    if (env->ckc < td->base.low) {
+        time = 0;
+    } else {
+        /* difference between origins */
+        time = env->ckc - td->base.low;
 
-    /* nanoseconds */
-    time = tod2time(time);
+        /* nanoseconds */
+        time = tod2time(time);
+    }
 
     timer_mod(env->tod_timer, time);
 }
-- 
2.51.0


