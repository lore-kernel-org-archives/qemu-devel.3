Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FFCC5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 17:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsO3Z-0003e3-Sq; Fri, 07 Aug 2026 13:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3Y-0003ax-D0; Fri, 07 Aug 2026 13:08:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wsO3W-0000xH-B1; Fri, 07 Aug 2026 13:08:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 677GlYpU153984; Fri, 7 Aug 2026 17:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ex8MMFHZcinDTjlk6
 43wvKeBmJ3ajDKgMmE6qkHjOtg=; b=gf+Ps6KLfSmxGLPRGPZoCtScSgQVOiLJS
 YkOT56trkwam9Z2x4S492KwMJtoYoP7XQx3ynt70r/XFXrwGk9f3ZashGPg5yJJ9
 vjak8bpX2xgWh//F3UCSVhUCBrCZGZfg23jOjZ7fgDyg6lWykJWfmnKZtBWXKc+h
 XyIlg57DINMpKeJ0iXa+/Heyzkn1cVa59JEV26FRJx2emDxjal3zV7LAZaVaL5m6
 ifawC59LZZHp9USlXe4uagg1E2dWDgLCvB42IyRxp/GQ0eipgMwAfTOKzgFE8K+x
 r62WqcbRMg51KZkpGcgkq0HSit8+FK4fwoT2vU2nD3v3PrlPYDafA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01n0g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuU8R027375;
 Fri, 7 Aug 2026 17:08:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kgkvp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Aug 2026 17:08:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 677H8Kul26477262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Aug 2026 17:08:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0169958056;
 Fri,  7 Aug 2026 17:08:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCE4958068;
 Fri,  7 Aug 2026 17:08:19 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Aug 2026 17:08:19 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v6 15/15] s390x/pci: Create function to contain fmb_timer start
Date: Fri,  7 Aug 2026 12:08:12 -0500
Message-Id: <20260807170812.658820-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807170812.658820-1-kshk@linux.ibm.com>
References: <20260807170812.658820-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wpabitQLJegxVNhzeQimx4R-hiuDGA3m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX2l8Py3fmSgoB
 ZltD3u10wpCd+XfPiZ8hPW2y1GAbYZVFtAKDyAhEVP3ptk+pDV1+YANlLnRVaFVduVxuhGWe7Wz
 vLjGzSouESfcxlMi+Px1reAjKS9C1pA=
X-Proofpoint-ORIG-GUID: wpabitQLJegxVNhzeQimx4R-hiuDGA3m
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a761106 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Q_XnuvSB35syRjF9fnEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX7gYHNNFnHfy0
 Ak3Z+k8q+jy/6IPwTetfoSJ4nNrlbdGWaNHFrlT/L233Dq9l0x9W9mHHjz1BvqOQTQmC+hlJWQP
 OdqdVPu+Iqdbr0/04Guw85JGIQm0x3Fzi6x2qKQR0ZXO8vHvKg9s0NzaTvMKfRs1ik2aYR8uXS1
 1D8Z6xfeSbzsv2LFl24k7AZgf79fFXOM5M4/gFUH/ndtMw6Le5Wtw49bg8Z8RnU0WtQQTNSC4k3
 CKe605+LaEddRHVCGuofJhJyMZ/PPTKk9Co8MGuwICCMg96iVffkPPuBv7NPAwPihFkmqHeXooo
 3KtDDDZ6qUZnm2d4WozQneEJZmK6cWi+4tHGBiv1GL2YcApqwjWtwy2yMMB77u22qQKV+Le41S/
 ZMEvWthXvsNHgpoVXulMI0zdPCX/Z0spNwwI2VVBppc1xlIA/oevjRkA/BKsNQ1LeNTUtRkaNkX
 w9y0Z9rU2kPqpPh6ZNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070131
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
index f043dc5524..0eac516b68 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1754,9 +1754,8 @@ static int s390_pci_device_post_load(void *opaque, int version_id)
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
index 66c1f04ead..25f69407df 100644
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


