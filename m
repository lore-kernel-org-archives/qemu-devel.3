Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19A1CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZmk-0005nE-Nb; Tue, 29 Sep 2026 11:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmh-0005kV-Rb; Tue, 29 Sep 2026 11:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBZmf-0007wA-Vg; Tue, 29 Sep 2026 11:30:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TB5jFd3836778; Tue, 29 Sep 2026 15:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=6MOZU/NZWOwAIMtx6
 VsCx0AhvXr5R2udK8cfN1R7yE0=; b=lnCeABd2LuXoe7kFZ0B6g/lJojKJunMxV
 Bjf28EauWsnDZE/R35vvjYBMFuqft/tjcibGkw/BtmY376oys4RXZEPCwscC7yXM
 E55rZdCFQBxcsB9dv9jmC85KxSjrrD7Azl4nVmMGLuPeSfHys0QGCD75OqMf748d
 bZKvfGnLE8FFYhFwU+ZIRcLhcAmFnf88vUf1obbPjnebJZCnZs0paBN0aoRI2AHI
 mQj8NhjirBJfiA54qVDG2/DLaOuNy+sXp4H3kb8Y4sul6wHlb/7SaLwvhqzH4rzZ
 2GzVWLcScLTTuuWzvbdZnOvCqvTK+4Y5d6jLFnLXo58A9wCb/8E/Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk7eca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TF1toF1617010; Tue, 29 Sep 2026 15:30:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrwadkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 15:30:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68TFUGIL24904422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Sep 2026 15:30:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F23058059;
 Tue, 29 Sep 2026 15:30:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45E7A58055;
 Tue, 29 Sep 2026 15:30:15 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.92.210]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Sep 2026 15:30:15 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH v2 2/3] s390x/pci: Use qemu_log_mask() for guest-triggered
 errors in reg_ioat()
Date: Tue, 29 Sep 2026 11:30:11 -0400
Message-ID: <20260929153012.774530-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929153012.774530-1-mjrosato@linux.ibm.com>
References: <20260929153012.774530-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KIZkIQfbzoNBVA-PByCmFAEfKCq934Wq
X-Proofpoint-GUID: KIZkIQfbzoNBVA-PByCmFAEfKCq934Wq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX88bvJsIoJzg3
 cr27Fs7Uf9RHYub1oTTN3JZjJkN26n6JQRGdMrDJz6mK9uKZOH/51wgPi8/488bmBJzoQmmRyi3
 Xh2u+8ijEYrksgg9oobOVSMmC+412s4=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abbd989 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=Z9dgWC5d4jRJgd9rOkYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2MCBTYWx0ZWRfX+qygRfZUEYqh
 i/LYP6mWhF+9UiHm55I/OeEBhHaGfTr3Zzf39xc0vW8udSAL0ZLYNjhErHRAJjAS6mNM2PAFkwf
 8ZwIXtMS+mm39Jf9oMutRRPGsY6ghhU9eT5pPixiMZZaNqp/AV1GRXpFt8DmB7jZI3hMC63G/tP
 y+87VrbkAubqiYjoJxNLvz4P5BnaOsYMWD0I3zo9Mamkdxh89RUcMw4LO4a3sHnBB/JWTpBed4x
 3qt3cAjL2sRBqkpDMsiYJrqz418/TGdD6zSG6UbJZIjAqsJSv+PMQweIWmbtjMxw7KftWjV4B5t
 QNkrUUgnmVFDkMSj13LHrPqea3fW7FhICYGdBTH+n/YnqNv6vOZDw5QDVifAb9jDYn+EYlviiot
 QzK/A+Q5p84+i8Ag7Vj9gzPTCinjkvAAmKY/jtCvzimzSlJ4SZotdXVoSuqhRPcAqe0TQ658MxH
 2f1+ORPuhJq6cn8+GKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290060
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


