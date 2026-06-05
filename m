Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66809CD6E75
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 02:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVK83-0005Ln-21; Thu, 04 Jun 2026 22:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK81-0005Jw-Oy; Thu, 04 Jun 2026 22:17:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wVK7y-0001mW-MU; Thu, 04 Jun 2026 22:17:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6550tooG2350781; Fri, 5 Jun 2026 02:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xuCd9Rv/6MxO6KmEZ
 jxXbtVmsFJBA739WxF+h1lv6g4=; b=S0wewUHqIyKmQzyOWRritHQLBMbpL2PJN
 LoU9kI0Jpr4GL/7KNZ03fQHPbaZ+4vnlZKHbmbuH8ZNxsEaP25/p/6jxaX/ZmkiR
 XUU2RCSRWE7aCDAudCgnfLTfMu6OvLnxjcEoXbQkKDybVq32PBZVV3vIyVKKj3g1
 fDGah2oyHrmVcOfolE6QPolKHBgS1/RBJus0UN6etLeDtWS09cpGJoMZbFScBTob
 JiA2S3eNNjayFHrx2qbn/wD2ClRSEO/HiCW9lPz3kq5ETgyF3RDI1HAU7cNUH18y
 ysvp2KLSrMRx0iiih1pLDrtsj9l1J/0njoZiue0XX3HV6JG6r200Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqjf1q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65529C7v009455;
 Fri, 5 Jun 2026 02:17:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhqnck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 05 Jun 2026 02:17:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6552HaHR29033138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Jun 2026 02:17:36 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FB7658056;
 Fri,  5 Jun 2026 02:17:36 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 146E358065;
 Fri,  5 Jun 2026 02:17:36 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.240.22])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  5 Jun 2026 02:17:36 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v3 15/15] s390x/pci: Create function to contain fmb_timer start
Date: Thu,  4 Jun 2026 21:17:28 -0500
Message-Id: <20260605021728.1125090-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605021728.1125090-1-kshk@linux.ibm.com>
References: <20260605021728.1125090-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BMnp8VfBfKN3tHMDymuMGr9J76E83_b1
X-Proofpoint-GUID: BMnp8VfBfKN3tHMDymuMGr9J76E83_b1
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a2231c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=sKQJ3MkoBbxYwW_cRDQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAxOCBTYWx0ZWRfX4CQS0oeCK4ei
 wXOqdkngeMGpVyXzWF82HkXHqHPgJTo0fjE3zVhFFMbtzpqKu7VoTceAqeLI/iHqn/TUGbVpcAQ
 JM/fdft9xDH5JCVsg8Uc6YVl9akruD+yWgWWv/IDJmoHXNW+C1ACVAMPF0s5jaPtHixftEJASne
 GwlSlYP37DY+lXpmdw/1piYPavCDQ8Ig1B/o3ubg/zL5AStg2kB3jeCLSYcr5feH4L+KRejOIAp
 Xlk1xdjbU4G+iNMLd5zBnMHwo+upE2kvA0TGtdMBmC8zWzpw1w6hyq0Rr847a8QjNDvzNvq3fxZ
 Yx4nyrWkOVsWOAB/OAyKq6Fa7KzogMGEeygVQFqPhP0yZE9r6uNDyz256kbbKwiIF/GYu15pIms
 4M6UJmYf1tDsgu54ru38StP4c6ZRd+BxwTA6WpCEvdCYZxRScn1IuQGfoq4gFeLn5NRUVtNMuJk
 5UFD1uJp9BAW2uRJrFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
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

fmb_timer is now started in 3 different places. The new function will encapsulate
that to make sure mui is added in all cases.

Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  5 ++---
 hw/s390x/s390-pci-inst.c        | 14 ++++++++++----
 include/hw/s390x/s390-pci-bus.h |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b05c4b43d1..49efed2724 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1744,9 +1744,8 @@ static int s390_pci_device_post_load(void *opaque, int version_id)
         assert(pbdev->pci_group);
         pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                         fmb_update, pbdev);
-        timer_mod(pbdev->fmb_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                                    pbdev->pci_group->zpci_group.mui);
+        s390_pci_schedule_fmb_timer(pbdev,
+                                    qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
     }
     return 0;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index a9c0a4effb..62ecd50dcb 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1094,9 +1094,16 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
     return ret;
 }
 
+void s390_pci_schedule_fmb_timer(S390PCIBusDevice *pbdev, uint64_t start)
+{
+    timer_mod(pbdev->fmb_timer, start + pbdev->pci_group->zpci_group.mui);
+}
+
 void fmb_update(void *opaque)
 {
     S390PCIBusDevice *pbdev = opaque;
+
+    /* Must be read before updating U bit */
     int64_t t = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     int i;
 
@@ -1133,7 +1140,7 @@ void fmb_update(void *opaque)
                       sizeof(pbdev->fmb.last_update))) {
         return;
     }
-    timer_mod(pbdev->fmb_timer, t + pbdev->pci_group->zpci_group.mui);
+    s390_pci_schedule_fmb_timer(pbdev, t);
 }
 
 static int mpcifc_reg_int_interp(S390PCIBusDevice *pbdev, ZpciFib *fib)
@@ -1326,9 +1333,8 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
             timer_del(pbdev->fmb_timer);
         }
         pbdev->fmb_addr = fmb_addr;
-        timer_mod(pbdev->fmb_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                                    pbdev->pci_group->zpci_group.mui);
+        s390_pci_schedule_fmb_timer(pbdev,
+                                    qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
         break;
     }
     default:
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 3840f6a48f..0385c1aba8 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -419,5 +419,6 @@ S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
 void fmb_update(void *opaque);
+void s390_pci_schedule_fmb_timer(S390PCIBusDevice *pbdev, uint64_t start);
 
 #endif
-- 
2.34.1


