Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F15C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6Is-0000hN-KH; Thu, 23 Jul 2026 23:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6Ig-0000Y3-N9; Thu, 23 Jul 2026 23:10:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6Id-00005n-T8; Thu, 23 Jul 2026 23:10:14 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLfimJ4190632; Fri, 24 Jul 2026 03:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=kDfOTcYtE9t65w7ZW
 hL6971NYQFPH2r/K5DoQLGPpCs=; b=aRuSJch80sUfkCCUCyAKZWUR8sdF8HVvB
 AnRZinr/ZSZDcPLt5cIksHdYMuJHsurMWvmB3yCLMe2+xl3hbizXVF9G2nDWKA7z
 quxPfNvkKrfjc4e4vBpXsou3UeysmJvw/o2r7lb5Y5iH2DnhZ4cJZS6fXBcb/f3D
 TybAEXi6hSiByAwQdpporCjdxRBNqUUVxnVVK+T0ivkFIRTIUeiFYVskwv3+K+on
 i0k4t9oePnSFA/s6cW9/jY3cXrRlXAWAkgAazShEH4k3WrfCYolK2JjnHzEGcxF1
 YVr1+YXQiHRAPK2lUnK9Inpt7TpNG0qb8TDBq1NNCP+C7Ab5INhNg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahj3ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O34mfB021098;
 Fri, 24 Jul 2026 03:09:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wf8k0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O39gDT28377632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDA025805F;
 Fri, 24 Jul 2026 03:09:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5252458043;
 Fri, 24 Jul 2026 03:09:41 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:41 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 15/15] s390x/pci: Create function to contain fmb_timer start
Date: Thu, 23 Jul 2026 22:09:19 -0500
Message-Id: <20260724030919.123733-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724030919.123733-1-kshk@linux.ibm.com>
References: <20260724030919.123733-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ZAb2x8wll5jjMQ53iiI5-D9dbQj0z6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfXxT5lrru8zi4j
 wEdJ2WjFQLD1CVDtu9Ln3Epa/EMlKLHrwAe+sd1SP6/CzkWAxQdDTylRRrz9MpHq7NTR3LjR+LK
 PCXYjTgErIHBfjq3caFDZF4yf8VwB4q57s6HpAeMTkTlPVHLFX36P6GeTVy9A99c36kozoei8Vl
 Wtke/+Fze5iNgZc06gHmdS5tBmKFmEk7IGzteYjBPDclXqt4vLyp2g9MaqvYgPyYf4uUMPA6ZS9
 G4TMlYAoyuOLHkEKu4O8q5eFK4RNuSSse8cQQqUmktxfGIAnOtQ15NKEvTlLrAx0yC6J4+n5d0s
 zFWS2PjnW7SPenrQfgmPGmVdsvcsZ9UQaz5kpXrpo2LgeDV1FauqhK6YzlCGBSgANYW7AqCH+c3
 eZnObM0Pq+h5UGKhTnYzX0GAKM30FJzPV3OC3GqKeN67NEgEkVujX2mOusZ/mEnqMkuUS4VhTaH
 l1BSvr/iPdRF9TkrJ4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfX0bgIqR90+l/h
 scWUXirCrJrJGbYOi23lJsIyFk2wPhvIKDPucPBNo18S6ZwFcGg40zFps7eQ307cRseVY2X8qQv
 lCdl2pxibXv3ylgCibxV+afHwpisncQ=
X-Proofpoint-GUID: 6ZAb2x8wll5jjMQ53iiI5-D9dbQj0z6t
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a62d778 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Q_XnuvSB35syRjF9fnEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

fmb_timer is now started in 3 different places. The new function will
encapsulate that to make sure mui is added in all cases.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c         |  5 ++---
 hw/s390x/s390-pci-inst.c        | 14 ++++++++++----
 include/hw/s390x/s390-pci-bus.h |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 655667482d..e568a8f4e4 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1745,9 +1745,8 @@ static int s390_pci_device_post_load(void *opaque, int version_id)
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
index 6b0742d143..89e4830dcd 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1122,9 +1122,16 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
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
 
@@ -1161,7 +1168,7 @@ void fmb_update(void *opaque)
                       sizeof(pbdev->fmb.last_update))) {
         return;
     }
-    timer_mod(pbdev->fmb_timer, t + pbdev->pci_group->zpci_group.mui);
+    s390_pci_schedule_fmb_timer(pbdev, t);
 }
 
 static int mpcifc_reg_int_interp(S390PCIBusDevice *pbdev, ZpciFib *fib)
@@ -1354,9 +1361,8 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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
index 7386404ecc..95618f27de 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -422,5 +422,6 @@ S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
 void fmb_update(void *opaque);
+void s390_pci_schedule_fmb_timer(S390PCIBusDevice *pbdev, uint64_t start);
 
 #endif
-- 
2.34.1


