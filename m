Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24339C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nlq-00082P-Ok; Wed, 23 Sep 2026 10:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9NlG-0007mL-Ml; Wed, 23 Sep 2026 10:15:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nl6-0005xY-VI; Wed, 23 Sep 2026 10:15:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZWGo2940615; Wed, 23 Sep 2026 14:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W+f+JO2e8qxZ3Zvx4
 oLm4IpAwBrGrJrZTq4c5akzEZ8=; b=UrWhBOEGPiaUecE4hJJeKQH6IFMfz5FJj
 4AzOfygHNkJJkp5876tqsKV0MWuRHf8C0c+OoJEc9Ho6oJMhIUJYQpXwp+fYtk5d
 h/2Jub3aW5aA75/s6jQ9obpl4fruJwHgFt8fucqIqWYISO0TWm2nPJFl2UZPROfq
 NuXKMkYFX/JCah1GAEaGmwdKbCXnhypbkyVz3cAeWYcWiZoOJRRAKnutCsQJ6VBT
 j/Ug1s+aQ6ahXtEIYwFfSNakmNHOmWsgOsEAFpWa8ikkDCxrLsT2sWb+k0naDPvp
 vxYqwm+AB/LAtv0MeP2kmU7dRWa07HjkZ7dDssjXxRZaAqLdeH9Ig==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvba78-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCvOX7008037; Wed, 23 Sep 2026 14:15:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2s7h4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFZgd46465314
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E21CE58059;
 Wed, 23 Sep 2026 14:15:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E31D5805B;
 Wed, 23 Sep 2026 14:15:34 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:34 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 16/16] s390x/pci: Create function to contain fmb_timer
 start
Date: Wed, 23 Sep 2026 09:15:18 -0500
Message-Id: <20260923141518.960364-17-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3vaDSj-DSI_TmNOSXB6AwH8pxz_TlQDg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXwFZhRIGShvwY
 HIj1hu6UzJ6rfVh+Nalsdbrg8SO27MHD0q+Gh05NQ8I/qxzM3b5V2W7oKV4NssRHlCWYUGGR6TJ
 ONwPLk7K29Kf0h3W4Hfih0EbWF8RWQc=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab3df08 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Q_XnuvSB35syRjF9fnEA:9
X-Proofpoint-GUID: 3vaDSj-DSI_TmNOSXB6AwH8pxz_TlQDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX5euA7D2y50C4
 wO3SU7TTEw3JwxltJ/C+dDzLW1n+zYjr3Eb1WcOdLZwpDfKaAjnrMtPgZ5TIxFnad3G3xh4/SC4
 2VfX58O/OUnWUwwxSJq1MGFKoit0eKhfauzpsEhk2SXZtCjd1AX44ifuBgubmXz18KzvzbBCyHy
 xMBB5doKM8hsJy03Rbcv4ZHgylboBEd4Sm+DZU/sibQxBCKC91op003b8pi2WSleBzl2FjcvyVc
 8Z3hdvazt6Hh8pG+Tr9FKyjaICAaqzrBsIwWIdKfa/fhtBmXLrsu/oYvD1/bHXTR7uloksECWIH
 HiEONyZ1mH0P2rIdXJTlFCTKrfkY3MORwVXb0fUcB/SNJYBKTuBnmzhvl6yGqKFbw87bU8uCUbr
 YULf4ZTSXBTrq+A8d3co65AGsTMDB0KDxQHtFxz0RknznjasnRJu8kZY2z2YAlv2GSqubfsfx0e
 x0a30+UGz3T08mHbG9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230056
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
 hw/s390x/s390-pci-bus.c          |  5 ++---
 hw/s390x/s390-pci-inst.c         | 14 ++++++++++----
 include/hw/s390x/s390-pci-inst.h |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 41d43974cf..be170698f6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1867,9 +1867,8 @@ static bool s390_pci_device_post_load_errp(void *opaque, int version_id,
         }
         pbdev->fmb_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                         fmb_update, pbdev);
-        timer_mod(pbdev->fmb_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                                    pbdev->pci_group->zpci_group.mui);
+        s390_pci_schedule_fmb_timer(pbdev,
+                                    qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL));
     }
     return true;
 }
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 962910327b..8162d79fa0 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1138,9 +1138,16 @@ static int fmb_do_update(S390PCIBusDevice *pbdev, int offset, uint64_t val,
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
 
@@ -1177,7 +1184,7 @@ void fmb_update(void *opaque)
                       sizeof(pbdev->fmb.last_update))) {
         return;
     }
-    timer_mod(pbdev->fmb_timer, t + pbdev->pci_group->zpci_group.mui);
+    s390_pci_schedule_fmb_timer(pbdev, t);
 }
 
 static int mpcifc_reg_int_interp(S390PCIBusDevice *pbdev, ZpciFib *fib)
@@ -1370,9 +1377,8 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
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
diff --git a/include/hw/s390x/s390-pci-inst.h b/include/hw/s390x/s390-pci-inst.h
index e31497069b..0c27e5bcfb 100644
--- a/include/hw/s390x/s390-pci-inst.h
+++ b/include/hw/s390x/s390-pci-inst.h
@@ -114,6 +114,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
                          uintptr_t ra);
 void fmb_timer_free(S390PCIBusDevice *pbdev);
 void fmb_update(void *opaque);
+void s390_pci_schedule_fmb_timer(S390PCIBusDevice *pbdev, uint64_t start);
 uint32_t s390_pci_update_iotlb(S390PCIBusDevice *pbdev, S390IOTLBEntry *entry);
 
 #define ZPCI_IO_BAR_MIN 0
-- 
2.34.1


