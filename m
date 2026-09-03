Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C432FC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFV-0003yO-AX; Thu, 03 Sep 2026 12:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFO-0003vK-0n; Thu, 03 Sep 2026 12:25:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFM-0006Xj-Br; Thu, 03 Sep 2026 12:25:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3j8l3306561; Thu, 3 Sep 2026 16:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=LSjKS1E6tVwohFxlF
 wrrau07oDT4Bm5Q2sX9O21YrCk=; b=qMfhupBnhvQtyxVDEvjvShkIZFHYjRt4V
 Gk6LHg+U77sbG10zucXzd75R0LqhCwCd0usWLyxaMhaDgLzxc6yEq5uOXV28waLj
 U5HJqgjf0+EQ6Zmotog0astnXy3YUqQ4PYzV+AcGM3j5+aUI7b8RBt2/k8AHt/tL
 oZphROOXnv1eJIRjD6f3YPDSGpUWZ3cuJJZssLmEujGfiE0CDogmQXPFM1dli/U2
 L+NH0PAJaSvzxIk8oMod1FTe7eZ9IKHUvDa1PuWxd68E6Y1PwgL3x7fvHEdIaid4
 ln/jw/hdUGoBRbqfXC1qmIyeCDKcSyI1LGiLVKBkOpXgtbNMQUO+g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj5ksj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBhDT026230;
 Thu, 3 Sep 2026 16:25:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkgern-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:25:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GP1jB17498712
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:25:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29AF75805F;
 Thu,  3 Sep 2026 16:25:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8831858043;
 Thu,  3 Sep 2026 16:24:59 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:24:59 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 5/7] hw/virtio: Add "loadparm" property to virtio net PCI
 devices booting on s390x
Date: Thu,  3 Sep 2026 12:24:47 -0400
Message-ID: <20260903162449.2588271-6-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903162449.2588271-1-zycai@linux.ibm.com>
References: <20260903162449.2588271-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3-RyKybhfEHUQ75eaRMvO1WKd0AUXNNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX2BaF8fXpK5GH
 Q3jhkHi2K3HXEACkXy8Uf4tgMZCJvmHYJw6bZfZ9CICnP+clKk9twFGhOP9uz/9LUp81nCsbBZz
 cI2Mpzv45Kw/p6wzoRZ07nCzsT2VIfZJG4KI1dJGXD6acTFkL6pDp5LlRu36YazLxM2tf9DPK0l
 eRlron5BK2qNer+8mZ5ZQGnfpZGrrk6cbTHXSd9bTXkdTewPocm7vPTfFHIehLr4Urx74Zp1bqE
 LaQP74MuOGUgg1kHRrKLKSTVRU0G4rCN1Yj12O7cykKtWOgE04TkMTgZYURcXL4QP8lz9Gz38vr
 7/2Gj9fatVdC0AY3wZx+f95Y6A5B62b8vO875sOT1AsgtF0osu94a54tgQdMWMaFDpp3zXna5ms
 hzzE5yESpJfgMq7sY1FIM1Ea/1OFQN9D1sFKVReUxFEN2H4EQ2C3bHjLsPg7lO/12kcW9qq7kK/
 8lF8DnelLWZE4Uvi2Hw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a999f5f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LEpY8eO1VcgwfWkpOzsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfXySB+IpYWnjRl
 +Y5g+GUbRG404zewcgUPyUXDysLZMASQHHdLQKoZRlH/SdlDB2Ia23vXavrVqOa6ICmSavxzcm2
 vQgOhA62GeH/JlkKJfbkycq5aEFNRjU=
X-Proofpoint-ORIG-GUID: 3-RyKybhfEHUQ75eaRMvO1WKd0AUXNNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Add optional loadparm property to virtio-net-pci to allow boot entry
selection on s390x, consistent with virtio-blk-pci.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/virtio/virtio-net-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-net-pci.c b/hw/virtio/virtio-net-pci.c
index fd3e0303f5..893d1905a9 100644
--- a/hw/virtio/virtio-net-pci.c
+++ b/hw/virtio/virtio-net-pci.c
@@ -77,6 +77,7 @@ static void virtio_net_pci_class_init(ObjectClass *klass, const void *data)
     k->sriov_vf_user_creatable = true;
     set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
     device_class_set_props(dc, virtio_net_properties);
+    pci_qdev_property_add_specifics(dc);
     vpciklass->realize = virtio_net_pci_realize;
 }
 
-- 
2.55.0


