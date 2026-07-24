Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E41C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn6IA-0007wa-1j; Thu, 23 Jul 2026 23:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6I8-0007tI-MI; Thu, 23 Jul 2026 23:09:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wn6I7-0008Sb-15; Thu, 23 Jul 2026 23:09:40 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLfvVH4080515; Fri, 24 Jul 2026 03:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=BkO+7wAwRclwywsMjwC8Y32sBx6GtQRHQt3HfPSHn
 ok=; b=qfO2S46L7VWSXsAkG9dVDMkljmmITF5WkJLJfvBFz8QeIrdeptVDXsptn
 /jkRkjFvxHx276XYmeuypFSPzeS3Z1V6+7HO7263kIgOZ8xTvieI+fwHoVqbY5RH
 rLuWaavgU2p1wsKg4ZQ58F6a1lZQo2wnUtEJ2CtKG/1tjv+zPzW3sndnB/po8KlM
 lGypOqw8jzJORR2SUjQoDI0yk9ienZOnfIBDjcFU5CiqcS64lPxqjzmYfEe0G+8r
 MMa5kp8y/vqdVWMZXx0nPBMrmikZ0kN3HkMeF43FhDStH/JIdq9KRCcXT6NN/TTg
 FRfkSWIBtVFjLxD7ofh0oo8+hN3hA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gj2he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O34h0t029526;
 Fri, 24 Jul 2026 03:09:33 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gpyb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 03:09:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66O39W0w25297474
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 03:09:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E557E58059;
 Fri, 24 Jul 2026 03:09:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53E9F58053;
 Fri, 24 Jul 2026 03:09:31 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.161])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 03:09:31 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v4 00/15] s390x/pci: Implement migration for emulated devices
Date: Thu, 23 Jul 2026 22:09:04 -0500
Message-Id: <20260724030919.123733-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfXzwj5y25SNBVD
 1iYs6sZMj9JKu9YKh0D2yU2hLYGILeJkIm9K7hVnppLbWUyOdv688Dtazv9vlzSS8PGqehfYB9t
 pZGL++sF6oP9gb+hEyeQ2+8vpJ33D9D9dsqNN8FOnIBSFOc64+D6UqeBC40oUveQlDYPt5ZPOhb
 0RVMV531kpHbHxUkpFmZvu7rUn529tPGr7iFqS6k6+Eww1aF8o7D7O7thyLMOw+Nmgn2CmWwIvp
 othfz85XNrtcSRNQICXuQB577mNBP1VC8xHx5Kd6DdY/JAhT0AhLPwcvzq0O0yLdXv2pLm19/UU
 YtLyq0T/j58sMYP6Je9hWoV1IqmSJvIHUb3hSx0RzxKhfF1QcckeAwwEndtiDV8pxIgjVCNmrbJ
 x76075c4W8yTxyoHD37TPBW6tKqNdOCoqBaYW/lobNXvKfvTHosVC7BAd1h8Q240gghzbrFgVZN
 h3tQEurGRAUxRSsDnHg==
X-Proofpoint-GUID: mLhHoiJ6SKf7cZCHohlkj2vR1p3ncdn5
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a62d76e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8Hgc_-vnOkY6PsbUFoQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAyMiBTYWx0ZWRfXwc10j0Ojf/WN
 qBITkertzBNc3VTkYP7o8Y5ol7JJU6A6a6epG5qSVy6Ku7esge3qs7ByHvCGu7pVU1EPiiRVMON
 n4G6am6IYO2ZC2NFrGWDZHE2pvsCZ/A=
X-Proofpoint-ORIG-GUID: mLhHoiJ6SKf7cZCHohlkj2vR1p3ncdn5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
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

Up until now QEMU marked any zPCI device as "unmigratable."

This patch series adds support for migrating emulated devices, which are
simpler to migrate. It leaves VFIO devices still unmigratable.

To enable migration, the device state needs to be saved/restored to/from
the migration stream.

There are 2 kinds of emulated devices - those that use the zPCI IOMMU page
table emulation in QEMU (e.g., Intel IGB NIC), and those that don't (virtio).
This is important to note for testing purposes.

This change was tested on IGB, virtio-net and virtio-blk devices by running
I/O on them while performing "virsh managedsave, virsh start" and also live
migration to another host and back.

Changes in v4:
 - patch 13: Improved the comment explaining S390PCIIOMMU, according to review
 comments.
 - patch 14: Moved the new x-zpci-emul-dev-migr-enabled property to the next
 QEMU version which was introduced after v3.

Konstantin Shkolnyy (14):
  s390x/pci: Create function to contain translation status check
  s390x/pci: Move iommu_mr from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move dm_mr from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move iotlb from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Remove a ptr to S390PCIBusDevice from S390PCIIOMMU
  s390x/pci: Move/rename enabled from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move dma_limit from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move g_iota from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move pba from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move pal from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Move max_dma_limit from S390PCIIOMMU to S390PCIBusDevice
  s390x/pci: Add a comment explaining S390PCIIOMMU purpose
  s390x/pci: Implement migration for emulated devices
  s390x/pci: Create function to contain fmb_timer start

Matthew Rosato (1):
  s390x/pci: implement IOMMU replay

 hw/s390x/s390-pci-bus.c          | 338 ++++++++++++++++++++++++++-----
 hw/s390x/s390-pci-inst.c         | 120 ++++++-----
 hw/s390x/s390-pci-vfio.c         |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  42 ++--
 include/hw/s390x/s390-pci-inst.h |   3 +-
 6 files changed, 384 insertions(+), 127 deletions(-)

-- 
2.34.1


