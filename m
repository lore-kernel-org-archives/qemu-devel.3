Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E8DCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBvgC-0000r3-Jd; Wed, 30 Sep 2026 10:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvgA-0000qX-U0; Wed, 30 Sep 2026 10:53:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xBvg8-0006b7-Qv; Wed, 30 Sep 2026 10:53:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5J2h3203024; Wed, 30 Sep 2026 14:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eRrXmRYkp5zDKfvCQ
 AV9NBaRGfpoHysrhQTUFi8tdCg=; b=Lm+OldwLxbZLF1BksJdPwtEN9bNDD/jka
 4mcW7FO5zVx17LEcwhSFbi+ThwgBa6TpMmkSx9UDlws0oY4pdjy7yzUe5aYoUPVU
 UOVguyzv0xAbMlsW98b8Dv4dMCGNTegLw/FHPfh4I4/ngXin1CbL7HayLAzYkFiG
 AJ3IBJ2e8Sybjk5luZPj9V1rAMJsBcm/IwXNObwQQNAByrZ1HiHyOCMh+7c03Cub
 HlRRXt3vUW7shugYAWyI7NaVzVsla7jCt7ICpPf9f1n8jUo2ykI2Om9QJCuA58YU
 N6ugUne1N05HisGEdxczGSjibxAqecEStSZBoTv4mYL0Kybn5pAaw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5dsg7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UEHwXH3569222; Wed, 30 Sep 2026 14:53:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcs9gn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 14:53:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UEqxPR17826468
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 14:52:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5DB458059;
 Wed, 30 Sep 2026 14:52:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4172458055;
 Wed, 30 Sep 2026 14:52:58 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 14:52:58 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v11 02/16] s390x/pci: Create function to contain translation
 status check
Date: Wed, 30 Sep 2026 09:52:41 -0500
Message-Id: <20260930145255.140164-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145255.140164-1-kshk@linux.ibm.com>
References: <20260930145255.140164-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfXyEIWi00J4KLj
 inK52Ga6N9DXjpP2CiipeUZhdORbTUhoSH2SlUCog/KKfKPQED8wJvsJ4M0PvZkdORHZPRSa71P
 eZ0k3HG0fErFOFYaYa8cyEZfJDq7EpQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OCBTYWx0ZWRfX9wiPPLhOItzQ
 gfeqyILeYKiL1ZBI+BzJYMW5ZyfbEB0FLYW59Jxtbyo+0uyR42da9x7ve63kaOGErCtxwAeYL8A
 7DAl/KKspwgBDfvAVI68E5T2rmDABViYOIQ0od13vAsOQ94FeuuTliveXPdadzajjcxrmqMagp9
 apoXQE3OeODHp+mkYVPblUXvauflRF61m9fHQWsFJtUeblxflkFbXwFYFpMREqv9a4b86sy0CQS
 ub/hJ7O+FcVF+8gX1pq8aZzD4yRltZkQ0CLKAkuGJYGnqNI/95Wt4as+3nhabnXR879w92z1NxO
 2RNg39wtKINSOtqVu1G6PUdcFz8gTv9pekOIGi/0KKYQj2UY51ZoNRLgP4+Rl+WcbJ9oI4DgDEa
 xKsNpyLXkRNTyiD/hYbyXZVqBBVM2zAOKXQ3HCYjKrAuiYM6YPAXoJZG6DOhp+J2SxmKze5CEGu
 dME1zsnaOJXZMxfaxFg==
X-Proofpoint-GUID: naHXSnlheWIkCXuX3bc7BHrL_nbFb7B9
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd224d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=aCv-BzsnQx_gTHabB28A:9
X-Proofpoint-ORIG-GUID: naHXSnlheWIkCXuX3bc7BHrL_nbFb7B9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300058
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

Make it more clear what the bit means, and the new function will be called
from yet another place in the future.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
---
 hw/s390x/s390-pci-inst.c        | 7 ++++++-
 include/hw/s390x/s390-pci-bus.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 285ff0e089..c5d87aa615 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1025,6 +1025,11 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     return 0;
 }
 
+bool s390_pci_is_translation_enabled(uint64_t g_iota)
+{
+    return ((g_iota >> 11) & 0x1) != 0; /* "T" bit */
+}
+
 static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
                     uintptr_t ra)
 {
@@ -1033,7 +1038,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
     uint8_t dt = (g_iota >> 2) & 0x7;
-    uint8_t t = (g_iota >> 11) & 0x1;
+    bool t = s390_pci_is_translation_enabled(g_iota);
 
     pba &= ~0xfff;
     pal |= 0xfff;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index f182bab246..a732ad652b 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -391,6 +391,7 @@ int pci_chsc_sei_nt2_get_event(void *res);
 int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
+bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
-- 
2.34.1


