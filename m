Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB0BCA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHt5-0004uW-0F; Mon, 28 Sep 2026 16:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsx-0004ru-1I; Mon, 28 Sep 2026 16:23:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBHsv-0001JI-CH; Mon, 28 Sep 2026 16:23:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI5TL61823034; Mon, 28 Sep 2026 20:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QxwBoPc/nnLJS1VzS
 obFRaeb/KqcXoIOtJuNlf8OFag=; b=bKcNaOja3DSUeDhOHz1lhSDb7rqbrXZ4p
 as+TQKiUR98HPJAx0+2YlqS15o3oduNsJtMw60WW93Ag5nAq1F2VrpAjEH57T3Zo
 EOUqDlspWpya8peLkxAWcXtZIe06Ijy4/ymvetUul0IV/PGFnSRngBwDVrWb1nQ2
 IZrfaKgmr6/uQ51p63DRqsr0Z3q5tWrZ+UEGESjfoGrQXU+vXyEAEPdtMO8lqbpg
 5UCmOZpv+FRVnnpdSqROyd2OL+9PT5u9CoJF6PH1zsB42JdaGls76+ikQSgMA9aW
 uNjrlIfmOTrRLw+sfKikXljpuoyu2FiCJHHxz71JK1uHkZ/CgJHNg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pt33c0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI2f2e532487; Mon, 28 Sep 2026 20:23:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhet20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 20:23:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68SKNUd264225582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Sep 2026 20:23:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2451E5803F;
 Mon, 28 Sep 2026 20:23:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E32C658056;
 Mon, 28 Sep 2026 20:23:28 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Sep 2026 20:23:28 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH 2/3] s390x/pci: Use qemu_log_mask() for guest-triggered errors
 in reg_ioat()
Date: Mon, 28 Sep 2026 16:23:24 -0400
Message-ID: <20260928202325.309353-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928202325.309353-1-mjrosato@linux.ibm.com>
References: <20260928202325.309353-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8MsrspXrFcdcQouiKAGDhp_pOfQUSm5b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX42ZHfaZq8UO5
 6i45LA5wLyWSn0Fp/fsj5+ujBXieKJmJSx4zcFNSmBvdDWF3ouIBUipTe99P8nvpyjm2JT/RLn1
 E3O0yh9Xdipn9zDSEfgj4rL3JmXReLrcjK9CndEhSreuSshuMqpwm5YrnVAcLYMFqlt9Mv9fAFK
 mn67X9z/k0jU5oO8h2IHTdBQnYwvu0o7meNzaMYwlDUD27NgOtGyLrEsfT30iVM5qECaRR28H1m
 5BbQsQAHxowbSvSB8o8WvC2Sc//U2r5p+0hHz0FqaT3g66lEr5a9QNb4h3s02UE0RpzzuLRK0fW
 MT5v3ABgJFukWg6WtL+W0PoURFFToNb747KkmD2oXKxuPHQbXaBsGScZgpAqKKUdEqIGABUKhZ7
 9UHkoHTGQyg2Ttu+imDzhOQOs7ZXhoAET4vLkaSDTm2V0/8weoO4gf+50A/MiUjD2rFaT4af+S6
 K8Xoq4cu3hIye5PVpNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX5xEAW5m5WqrA
 KBylaYjCOLGyplaWnwRlJB35T9hYx4+ZWXdWmX4+YHa2QkXW1uPGmI7p1IgCOfC/4DBrisZRPuR
 6I6TCIBUsjI8PG5016B9KXnT9GNPzgs=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abaccc3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=Z9dgWC5d4jRJgd9rOkYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 8MsrspXrFcdcQouiKAGDhp_pOfQUSm5b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280080
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
---
 hw/s390x/s390-pci-inst.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index a51543df44..c6da3b4c07 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -17,6 +17,7 @@
 #include "system/memory.h"
 #include "qemu/error-report.h"
 #include "qemu/bswap.h"
+#include "qemu/log.h"
 #include "system/hw_accel.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_device.h"
@@ -1044,11 +1045,12 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
 
     /* currently we only support designation type 1 with translation */
     if (t && dt != ZPCI_IOTA_RTTO) {
-        error_report("unsupported ioat dt %d t %d", dt, t);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "unsupported ioat dt %d t %d", dt, t);
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     } else if (!t && !pbdev->rtr_avail) {
-        error_report("relaxed translation not allowed");
+        qemu_log_mask(LOG_GUEST_ERROR, "relaxed translation not allowed");
         s390_program_interrupt(env, PGM_OPERAND, ra);
         return -EINVAL;
     }
-- 
2.55.0


