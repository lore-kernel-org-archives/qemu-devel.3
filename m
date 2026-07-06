Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9DAC44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmax-0006N6-F8; Mon, 06 Jul 2026 12:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmau-0006M3-3T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgmas-0002yw-Jw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:54:55 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIEUM611278; Mon, 6 Jul 2026 16:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=gsMva91G76yjbiV/M
 gVal1y7z2duRUKKtIvXqJTZDOc=; b=IFfWwemnBsiO4hePVW6QKfQdCPq0iLQeM
 VOySs8g3ysnjf1IQm7AhUns5R6miMKJsxxmOAb4sQDihU6Iga9bCgSG0bXOeRKYu
 igbjIrZOKoJt/H8c93kpbVUcxl48urbpuDbO/yBdSJhI7Bl4MRgp3RUrwce08wM/
 YYDWbqHs93x2SB1GC/YdGqHBhfsgmEfcTls2FT5ztYi/TLV6opJ9LSS8gwqBtaNk
 6/Zu844HU6g6yONu9bUJdyz2+k/eHmGeDSyW+oEa0hvFsel9gjR4ON06W2c3Pf87
 jWFVBcIsX7xkEH5t2ZNLxsq8CIhcLZMZbz0irtZDcWLrTAz0EfHBg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3jhvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666Gnjj9003708;
 Mon, 6 Jul 2026 16:54:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xx463-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 16:54:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666Gsnpa30278234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 16:54:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1D620040;
 Mon,  6 Jul 2026 16:54:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E72C62004B;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 16:54:48 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/3] tests/tcg/multiarch: Improve mutator randomness
Date: Mon,  6 Jul 2026 18:51:24 +0200
Message-ID: <20260706165445.57418-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706165445.57418-1-iii@linux.ibm.com>
References: <20260706165445.57418-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bdddb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=hE59dl1hCYpwDpkaMNEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX9vh0t3prrICM
 e+B19m9TbgOvdrxJmFW5TZDsPk1o7IIsz3O6btwBBEn1rODjQTmuE9NCehXUbSgawEXjEQk3cZa
 jelDJa+/0nC8TJxxmC6ZfoNJMXDSp0k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX+SaJqKRp4+ub
 pu3Br6vvDv+QuPMu132Wt4t52esYw0RDdm5wMGQ60Zx/xIrBbV1QVKgpGQH7CuRrJyZ1nStS5yn
 pXXOrdQldyuDH7sHFwINZ4ImeREtGMt9XFrEeRTvFOrssESoweOYcdSQAOfkWzpplyuNBZg9TZE
 cNeRaDiscgbeqE77mA3B2q23jhXwFDlLZO6SFFEjf7ARzOC9lYTcmg7hGEOrm/sp+ZFgmvZ9kJ2
 tSnlx6l95FRXj8l3YN1xzDlxVHZK8+awkxu6XQ9i/d77f+3ygGhwIXVsDs+RGwWZwMhiqeHD6fE
 VHqcEBnA36ZwleQk1t+XieocG2KqdUg0GvZzCAwZ6PSJ8HHMq53If0Gl6rNRHR31ZAfHjsNRLvh
 nwRa5mx0hi2kAyFhpUIMCj4/vitLNizE+qDmKyFDg5EndqdppNdk8kcDakubX0pZRM67u6h5OpW
 4ptamP76L6Q6jMRGPNw==
X-Proofpoint-ORIG-GUID: wx6Ma9gaKma8is53MmY8eli5daoqev8q
X-Proofpoint-GUID: wx6Ma9gaKma8is53MmY8eli5daoqev8q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Currently mutators perform the same actions, because the RNG seed is
derived from the current time in seconds. Mix in thread ID.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tests/tcg/multiarch/vma-pthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/vma-pthread.c b/tests/tcg/multiarch/vma-pthread.c
index 7045da08fc4..0b8ce9751be 100644
--- a/tests/tcg/multiarch/vma-pthread.c
+++ b/tests/tcg/multiarch/vma-pthread.c
@@ -11,6 +11,7 @@
  * pages, which are guaranteed to have the respective protection bit set.
  * Two mutator threads change the non-fixed protection bits randomly.
  */
+#define _GNU_SOURCE
 #include <assert.h>
 #include <fcntl.h>
 #include <pthread.h>
@@ -121,7 +122,7 @@ static void *thread_mutate(void *arg)
     unsigned int seed;
     int prot, ret;
 
-    seed = (unsigned int)time(NULL);
+    seed = (unsigned int)time(NULL) + (unsigned int)gettid();
     for (i = 0; i < 10000; i++) {
         start_idx = rand_r(&seed) & PAGE_IDX_MASK;
         end_idx = rand_r(&seed) & PAGE_IDX_MASK;
-- 
2.54.0


