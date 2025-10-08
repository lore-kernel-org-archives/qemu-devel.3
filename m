Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22869CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 20:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6arb-0003rp-MN; Wed, 08 Oct 2025 16:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6arY-0003r8-Q6; Wed, 08 Oct 2025 16:34:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6arM-0002dH-Q2; Wed, 08 Oct 2025 16:34:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HI0O7006926;
 Wed, 8 Oct 2025 20:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pcgjrZTgBOe6aZW+Tgc8+tHmOONY6XQqB1Qm9mCn5
 tQ=; b=EiTMwJkvTeAHAV6S93r98aHIQPIUpsvmvn1vLO4EMhYeOsgN3vN3nsq1W
 RYDp36eKqmp49uEtdfRmYMTb2yeVSNBi6VXkHWA+ojmUsC5TLN9hAbqELfYZRqhu
 z0jtBdD22b0qU1CUH/L8kjQyBFvPpvLWkyNfk7w9ewZRbRNrNjkmGMjNpWe4vovx
 lxY4wxe5duoMws6aM2X04AKp8UVycNi+QL+cFDolWZqUL26RaL0zwJmaMGoNau0/
 nNFOPN/shr8Nl/voG3xcQtiqSLi5P1PBZ+yD6cu/5zGSXnN3rLiWExHKERwWbsMe
 w5IVgGuTG0EnG2BsFo8uRlfVB1jgA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv800ua7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 20:33:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598HLOI7020966;
 Wed, 8 Oct 2025 20:33:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9mrrxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Oct 2025 20:33:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 598KXqOj61079840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Oct 2025 20:33:52 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2717C58056;
 Wed,  8 Oct 2025 20:33:52 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6CF1C5803F;
 Wed,  8 Oct 2025 20:33:51 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.90.117]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Oct 2025 20:33:51 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, alifm@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3] s390x/pci: set kvm_msi_via_irqfd_allowed
Date: Wed,  8 Oct 2025 16:33:50 -0400
Message-ID: <20251008203350.354121-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e6cab3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=Jh1niNn83vR3aBQrtXoA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6PICgU4pESIkpfMnAuEzXsLBAZdMO_89
X-Proofpoint-ORIG-GUID: 6PICgU4pESIkpfMnAuEzXsLBAZdMO_89
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+FHAC+tltvcQ
 P53zc7YvGLcYcCJLFnqj2QxftsWqhBynkaWSMWfZIsPXZjFHpoShn20YDTXx9G/vNfCiAPj5CPL
 Xgq4enEtV9psr90mKKkhWF7/y4uB0SybdkusgIaXMIjv/1O42spBonuKra6iqVkFmZWPCU1gYq3
 oaecbvUhbdyrENeedsYEo45fAmZ2uFVWCZMRWhz5dB+T66SFHrXwYTl0S+du8z/BoHTyQXGpYiz
 eV88BKFUPYP6bscn9cB6I9T1zEaJPVahqjr21sYhrRWpy6YUT9wgng7Xw8IZ1mLdi8sS/Lw3eKt
 PW+exu/bieoesOKht45O5HixE6Paqpx7jflSWzVdXhLwS06nPESyQs82Mh13KWv0QZTfWONd5Bk
 uc9d9rxoM8L1DSvGD2CCdE0OXmilXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Allow irqfd to be used for virtio-pci on s390x if the kernel supports
it.  This improves s390x virtio-pci performance when using kvm
acceleration by allowing kvm to deliver interrupts instead of QEMU.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
v3:
 - Fix builds when !KVM (Thomas). Tested build on x86 and s390.
 - Note: Dropped all review tags due to the code re-organization.
---
 hw/s390x/s390-pci-bus.c         | 1 +
 include/hw/s390x/s390-pci-kvm.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e8e41c8a9a..52820894fa 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    s390_pcihost_kvm_realize();
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
diff --git a/include/hw/s390x/s390-pci-kvm.h b/include/hw/s390x/s390-pci-kvm.h
index 933814a402..c33f2833a3 100644
--- a/include/hw/s390x/s390-pci-kvm.h
+++ b/include/hw/s390x/s390-pci-kvm.h
@@ -14,12 +14,19 @@
 
 #include "hw/s390x/s390-pci-bus.h"
 #include "hw/s390x/s390-pci-inst.h"
+#include "system/kvm.h"
 
 #ifdef CONFIG_KVM
+static inline void s390_pcihost_kvm_realize(void)
+{
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+}
+
 bool s390_pci_kvm_interp_allowed(void);
 int s390_pci_kvm_aif_enable(S390PCIBusDevice *pbdev, ZpciFib *fib, bool assist);
 int s390_pci_kvm_aif_disable(S390PCIBusDevice *pbdev);
 #else
+static inline void s390_pcihost_kvm_realize(void) {}
 static inline bool s390_pci_kvm_interp_allowed(void)
 {
     return false;
-- 
2.51.0


