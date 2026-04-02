Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E56E1112259
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 02:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w87pW-0004lZ-I4; Wed, 01 Apr 2026 22:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87p3-0004Og-PK; Wed, 01 Apr 2026 22:30:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1w87ou-0001zc-TE; Wed, 01 Apr 2026 22:30:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631HmLoU3128138; Thu, 2 Apr 2026 02:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=b8UsqEhWMdLSrJ83v
 E86UE+4bGE1qV2cE0PriPUBNJA=; b=ku77+dM1o3pp/DR9sCknEEbzcBSC4lTo1
 9zVfP0dSfbLG49W3B3yaChHmg39zM662iKXD7zrOlyiR7Sr6qHQGPWaCzGSsUVZv
 c2V4SgpACFPlEA2LMr+soMbFrXHR3wzhjEvt8tPvhvMRaZksrePzlj/nLmaehWug
 2Vatqnk0fL4OUrCG1PVaLsBZvaMrZt4fZWuIKFlwcaZ9EAW065IXmW/MnvMmN6Jf
 bjeL08IUDWo6Losa8zdT3aW0hqAgdEQUm/4QPDJIlyDlx7O7lT2NaIU+IhOD16FR
 M4pB0wjzCrUX7wVMLkVjHeBWdNLGO3qa+UYc3EhA7GhwXzOXv4JQg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcj6df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:30:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321O8AM008703;
 Thu, 2 Apr 2026 02:30:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11r44e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 02:30:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6322U1k426411562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 02:30:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69C18580F4;
 Thu,  2 Apr 2026 02:30:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5DE4580F6;
 Thu,  2 Apr 2026 02:30:00 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.247.119])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 02:30:00 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH 15/15] s390x/pci: Create function to contain fmb_timer start
Date: Wed,  1 Apr 2026 21:29:21 -0500
Message-Id: <20260402022921.298818-16-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402022921.298818-1-kshk@linux.ibm.com>
References: <20260402022921.298818-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cdd4ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=7DrABjzRcPR44fYl4i4A:9
X-Proofpoint-GUID: 3kQW5gHHoFCKSOAwqAq50gJV67V_ooCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAxOSBTYWx0ZWRfXxM1JCWYabEjw
 uqfIKKWo3IWlyAfrVtwq44+u8d3bpRX6xu7i5wbiWdqSk1oqUadIBVVm5eksSha1otKUzVk4tP/
 99TfCtjaOrtbriZnDwTwHz+tf0KvvvoeQlZP+WXL3i86yQXXJ8YEjgfgmMmzSjRixVitqt8qQ83
 Fnx2fUC6RS59PF8Rn64RSqICNVNJCRxkwcVB+C1pLj09MoWzm12V628vrrv31SNYw4ghDbsdWtU
 swXNwAO+Hmu2dYcBANw/p8Gxv0yjiiFxA1uqor4Nd+6ztblVhNvsP9Bd2ShzzYtwikWI7At8RKb
 ML7Gw2NMJHFqmZGRaaKf6N2rwQYskwZDplXR3hOPr15lxqBG2cWJXyJBJfaaeR5+ePhHWL5A2XC
 X7Oq2H/ugxF3hWNBC3mu935iatXIVXOrBobCpYFm3eTzoGu5YU16iRZ4O9MO2BXrCKhPHoQG8iW
 RvPX7KIHweO+tvgu/Rg==
X-Proofpoint-ORIG-GUID: 3kQW5gHHoFCKSOAwqAq50gJV67V_ooCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_05,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020019
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kshk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index b3037b9a8a..1451dbd340 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1658,9 +1658,8 @@ static int s390_pci_device_post_load(void *opaque, int version_id)
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
index 2edb023112..966ae3ade5 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -417,5 +417,6 @@ S390PCIBusDevice *s390_pci_find_next_avail_dev(S390pciState *s,
                                                S390PCIBusDevice *pbdev);
 void s390_pci_ism_reset(void);
 void fmb_update(void *opaque);
+void s390_pci_schedule_fmb_timer(S390PCIBusDevice *pbdev, uint64_t start);
 
 #endif
-- 
2.34.1


