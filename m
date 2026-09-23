Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD51C98304
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Nkz-0007gF-FB; Wed, 23 Sep 2026 10:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nkw-0007eV-Nf; Wed, 23 Sep 2026 10:15:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x9Nku-0005v1-ME; Wed, 23 Sep 2026 10:15:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8ZNff2908705; Wed, 23 Sep 2026 14:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dztpV4sHbP6jXWmT6
 PTrhJ71EXX91O3F0lfOYDQfLz8=; b=WV3nmUHcvcC67jeWxRQkp/hXeVdDDxmDV
 bPK41GKltf+QnfUUOLAk7Q/HXFcMGYXfc9yvanErQIozDH77l9YqN1JrBOyeCA7J
 3VRTjgkBihzFD9pp74OoJe6FcsuBAac9qLX0/g7bqUo9nkh5WU0/Z/qYPHAoglq5
 ObEUAlaWjFFPPt04m8YL8SaXFc9V0IMBJRQnxygg0zvYkn9fK1nGK4WttwnTVzug
 NrRfvpW9n+W99F7xKZXbLyZOwPF4kA9Y6OSPRF/IP4vUTNlJzZRFkTyhoLtqMROL
 d2cir+fIqPkAq4WXyNw41RtKklzmW4X4js30QZkN+bT1I2JRBFIlg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2kts2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NCFq4A2891629; Wed, 23 Sep 2026 14:15:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkhawy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 14:15:24 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68NEFNRB11993616
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Sep 2026 14:15:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECF7A5805C;
 Wed, 23 Sep 2026 14:15:22 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48D7B58058;
 Wed, 23 Sep 2026 14:15:22 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.60.171])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Sep 2026 14:15:22 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v10 02/16] s390x/pci: Create function to contain translation
 status check
Date: Wed, 23 Sep 2026 09:15:04 -0500
Message-Id: <20260923141518.960364-3-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923141518.960364-1-kshk@linux.ibm.com>
References: <20260923141518.960364-1-kshk@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MwcGE19ZsAXCfxPmFF7ALgff5Jvro9u5
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab3defc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=aCv-BzsnQx_gTHabB28A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXw7iW6bELodXV
 Nghn3LqbIght+KIvZjtUCXYerMDI1ybtbvMZpcACQHqowfsN/5YRrsWNa0gqda8n1TS5eIqOfUI
 XqkfuWarFM4kuX32RaAu5sGu+ojFevuGch68xOiL0F7pBlaAqv3jA8lNDukWb53bpL/NasvtBA3
 ko0jgr8aaJ1Dnm14MPrPSSpzsXwcx4khraMp7Got+vvaLqM8WAEzoyaM2uqve9V/OblRPrObw3t
 sBZkXmx1/+yj5bRbGposMfp+eSLdngPwAwAtG+PvxJlucNHp0OnIgEAsBb8XKq1XUtPEfb5vqjH
 0RXdQloInsBoQzrzeLWUCsKszYfzkrnDu5i9TNRLc+QbtdY5trEv9k6XNGQuCp53Rvxx2VEky4V
 DIAPokeek8T/7pkqXXIcJ1lWR9rogAcUgXCgrtA0EegN2XNnLmAXoIOdDPqTI5YRa6kbMUfNjfe
 1Zx+GbwUKB/f3QnhTVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXznAE9PRJzsi0
 3KZKqrqxeybnYeh+AN5KyIRKfd2bS6F3TbJsK2XziBdTDI5DDhTSIdbOXnY6hsDCid6ki/igtnc
 XK1NMVc7fVnxAS/GMRtjrPiGJ2gCf58=
X-Proofpoint-GUID: MwcGE19ZsAXCfxPmFF7ALgff5Jvro9u5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
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
index 37ca70dcf1..00a847f493 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -1021,6 +1021,11 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
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
@@ -1029,7 +1034,7 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
     uint64_t pal = ldq_be_p(&fib.pal);
     uint64_t g_iota = ldq_be_p(&fib.iota);
     uint8_t dt = (g_iota >> 2) & 0x7;
-    uint8_t t = (g_iota >> 11) & 0x1;
+    bool t = s390_pci_is_translation_enabled(g_iota);
 
     pba &= ~0xfff;
     pal |= 0xfff;
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..eb15cb8b2d 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -390,6 +390,7 @@ int pci_chsc_sei_nt2_get_event(void *res);
 int pci_chsc_sei_nt2_have_event(void);
 void s390_pci_sclp_configure(SCCB *sccb);
 void s390_pci_sclp_deconfigure(SCCB *sccb);
+bool s390_pci_is_translation_enabled(uint64_t g_iota);
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_direct_map_enable(S390PCIIOMMU *iommu);
 void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
-- 
2.34.1


