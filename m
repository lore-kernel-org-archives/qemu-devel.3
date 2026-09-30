Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E255ACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAl-0008TV-13; Wed, 30 Sep 2026 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAi-0008Pf-51; Wed, 30 Sep 2026 11:24:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAg-00023y-FJ; Wed, 30 Sep 2026 11:24:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5SY23203201; Wed, 30 Sep 2026 15:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=WGKDOwyAAbz/W13ZP
 yY7RdkOhMc5m4fhhHfWqigi4bo=; b=r16noxJ3KScsrDllUJi+tJNKAn++RSvNq
 th0s6jhabkzmlw1lcA1TWeCJ8yRdzr4Qb2B4aUZOWr9BxeSh5thlfMwRIEyJkYbA
 lqo9X2CT79OHC2tCMvfUkCzOB2ZFrQBNQHhP7hAFxZ/r5WtGj5d2DIMG83j3tieC
 U+2v2zXp0vhrDQcYwSAk2aoeUkxUxCyb8EXFAYieLRA65LbRu2E4wtbBXG9Uzi9V
 YzIphzzuot8Q144TPGxuWsxCpcXFw7jW+gDVapAI1CSJYpryWPGCFkjQXytX+FAF
 HUZm7Jpj9P1+85RqDNVuwwuDJD/sHL6mBINzKY8T3j2RP1SRQ6bXQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5dykp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE38sO3541488; Wed, 30 Sep 2026 15:24:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcetr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOYBb20120206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:34 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3870358062;
 Wed, 30 Sep 2026 15:24:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B6D385805A;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:33 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-stable@nongnu.org,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 21/23] s390x/pci: Use qemu_log_mask() for guest-triggered
 errors in reg_ioat()
Date: Wed, 30 Sep 2026 11:24:18 -0400
Message-ID: <20260930152420.1956230-22-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930152420.1956230-1-farman@linux.ibm.com>
References: <20260930152420.1956230-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX3FRHK7JIivw6
 lnf3Sws8JPmj6q9YocBSPJ4LX0xFlRZR+w5bq3oyx/LxO9K2fI5/Qm/gy7CN33rjbll4SQtsz6W
 Aqj8P0oPkPU+UsOX7ZNIWfFikCrOJag=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX1jXtNhBLm9Oc
 O8D0HPppjcXLEAER4kI1FCbQzbu97JYiq+nlhx+G9XDxoDdCqV7OeA5xj3Dbt1/q0SfqlRH4WcL
 U1ABMcw+MjkMIRMqzUwW1fERCUxOEV4kJLz+LWGYCrmFwZwLj+sVIECXtUEDgA+6s8T7K8dwsdp
 K2W2eMEh31dffwLwjlK2NSufBzkdQL0aq8AjR78ACD9PaQn9cQWabdn7SutRWHH37G5nj6XL+VQ
 AeXLB7UsFR5mbfnoF/lQcYM6Oo0wORAqNDzHUggDXbKOtF/HWe3vtQmyESv9OxXMRpJS/9hJPCH
 XZQKXwo0GnDeIceqeyGBntSzMTIrciQxH3MN3rd5kMj0iUuRKTPuijH/VSjaoDCUrtmbXQRXvX+
 7F8Uk/DCFMPUNSgoVqe+PN9Wk0xHqoCNZTtj6uQQ9HLxqqQLhnvUkQVjtmBw6OLf0QUsuS1+4GV
 SiVjbJ6P8JfN1DXp1Ag==
X-Proofpoint-GUID: AXg-PJrV-nqcLe0IMSS3vO4lj66VFjHV
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd29b4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=kA0HU5bNTcLZE60lrGkA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: AXg-PJrV-nqcLe0IMSS3vO4lj66VFjHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Matthew Rosato <mjrosato@linux.ibm.com>

The error paths in reg_ioat() that are triggered by a guest providing
invalid MPCIFC arguments use error_report(), which writes unconditionally
to stderr.  A misbehaving guest can exploit this to flood the host log
by repeatedly issuing the instruction with bad arguments.

Replace these with qemu_log_mask(LOG_GUEST_ERROR, ...) so that the
messages are suppressible.

Fixes: 863f6f52b713 ("s390: implement pci instructions")
Fixes: dfcee1ea4c52 ("s390x/pci: add support for guests that request direct mapping")
Cc: qemu-stable@nongnu.org
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260929153012.774530-3-mjrosato@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index bac813fb6a..73417edade 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -15,8 +15,8 @@
 #include "exec/memop.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
-#include "qemu/error-report.h"
 #include "qemu/bswap.h"
+#include "qemu/log.h"
 #include "system/hw_accel.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_device.h"
@@ -1044,11 +1044,12 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     /* currently we only support designation type 1 with translation */
     if (t && dt != ZPCI_IOTA_RTTO) {
-        error_report("unsupported ioat dt %d t %d", dt, t);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unsupported ioat dt %d t %d\n", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     } else if (!t && !pbdev->rtr_avail) {
-        error_report("relaxed translation not allowed");
+        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not allowed\n");
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
-- 
2.55.0


