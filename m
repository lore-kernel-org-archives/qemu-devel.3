Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A113CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6EjU-0001QI-Jq; Tue, 07 Oct 2025 16:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6EjQ-0001PM-U7; Tue, 07 Oct 2025 16:56:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1v6EjO-00048O-Ml; Tue, 07 Oct 2025 16:56:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597Gina2020951;
 Tue, 7 Oct 2025 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KKSCcNrdAo5AiQlFpaNtat0ajNJc0eMY2n+K/ORZ5
 q8=; b=aQi1Jb+XI7afeTpzTuDaSJoJB994AkVff2y/S5k8A0TKxKXMOCkeXD/oP
 D1ybjUtf35IRd/TEYu/t6veuXsmPeGnVrtR7TBQl6K6MM4n3ZDNB/ytcZXHEdO6g
 vpb6kC5dBddUI+GaKnGQfFNgFBmzSMkbGtZitArNDFOlF2PlFFzB/UlN5Bs2qBGT
 XC2Vhbr5ekqeNi7zHsi32hPySNHzuil68LAOOA21dxUPC1GaYLLr/R1c2GF7M7bJ
 WI2WNCngdvXR4EFxJVV209xuLsv84f/qgSwqKHyc/l+1uYhrwJXyrxiCjDEX9m0E
 fmzwKjApwjig5vo8zIB1UgaUewS9w==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49js0sh6yj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 20:56:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597I6dD7021218;
 Tue, 7 Oct 2025 20:56:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1d0qb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Oct 2025 20:56:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 597KuGAN53150070
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Oct 2025 20:56:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3D0E58059;
 Tue,  7 Oct 2025 20:56:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EE6458057;
 Tue,  7 Oct 2025 20:56:15 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.90.117]) by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Oct 2025 20:56:15 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, qemu-devel@nongnu.org
Subject: [PATCH v2] s390x/pci: set kvm_msi_via_irqfd_allowed
Date: Tue,  7 Oct 2025 16:56:14 -0400
Message-ID: <20251007205614.188365-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e57e72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=UhhSZU4vrSmAJyTGk8cA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: oKtDNZoQMTudfCtovSd1fmdxvlSVcvak
X-Proofpoint-ORIG-GUID: oKtDNZoQMTudfCtovSd1fmdxvlSVcvak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDIwMSBTYWx0ZWRfX9/JyOwP4htZp
 GZzYlrPySB4M2GtLri2/n0R+9pCXkhDbKB8o6ox1z/hG9oSnvClM2OB+i8/XYoOdFnvaDC9f6XH
 u8cs1w1iFQ34oTDRvumO3St/fAZO7TffC+CA0LXUlMMU61wK47dOKEYdoohyyt73xc5WTMgXG5e
 tq6Xa1zcpjl1p4GAkeFk/Da7Y/2XjDYs9rb8pW0esAOYRrv+q/vnsRyOX05Oaw1glBjiwKmyUWg
 eGvNQcE7pA5E2IxqOW5/RvWSGa6cfPSWtHVMWqYKid7xz8HAwH8DwthTo2KfOzGVJbmEJqQ9o27
 agHBjLblA/t6mMQ6F2WIvNrejErEvaOfBFRJZKjRCyyg5ebMDU310hkVHWmn4tHgp435ezGGzbQ
 bfDJbmjb6Z6JBeElYvGA0CBo8MXRKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510030201
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
v2:
 - add review tag
 - tweak commit message (David)
---
 hw/s390x/s390-pci-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index e8e41c8a9a..88852acf45 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -900,6 +900,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, errp);
+    kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
 }
 
 static void s390_pcihost_unrealize(DeviceState *dev)
-- 
2.51.0


