Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21071C5DF8A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNZH-0007O2-Kj; Tue, 18 Aug 2026 13:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZF-0007NC-DC; Tue, 18 Aug 2026 13:25:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wwNZD-00031m-Rj; Tue, 18 Aug 2026 13:25:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3gHU3582598; Tue, 18 Aug 2026 17:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=06I44+W7zp3D9cVhmVyBo492Aj/VT8veRm7WmK8R0
 DY=; b=fY8UyZD/uG8gnfDMkPJd2rvlvLBNX49A3MLQnpzA746Ur6s9mEbVYYiJA
 Zh+lczOEQnK/aRdEKHqgEh79mlrusckGjvckWlXln2J8TKRapW4N2BN63MgHKyNU
 9IlU1BYDgRl9z1AB5qBxCoLI0JnGx82Pdd6tohHaOcM34nTjkzLjhVn3m8EpVWxN
 otbgclQISku6CaFdU47M5sEbXw53iHXsS0OY0iA3i9AHde54yOn+FnSEys1/OOga
 THUQBDlEzyREl4FR93rj/zirRpALXFCOijcy+OwcgyEexQjVylYLkGATfGUA+s0O
 ALjhXFBaD9lIZmEJM7VSMd8lDGBYw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe9br2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IHDlrG030512;
 Tue, 18 Aug 2026 17:25:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh4ece-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 17:25:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IHOsBa28705348
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 17:24:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED3715805B;
 Tue, 18 Aug 2026 17:25:32 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5944158059;
 Tue, 18 Aug 2026 17:25:32 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.251.170])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 17:25:32 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v7 00/15] s390x/pci: Implement migration for emulated devices
Date: Tue, 18 Aug 2026 12:25:06 -0500
Message-Id: <20260818172521.223460-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX/8Z2w3OsR9kU
 2xPFWCqDrlv8lmKJ6BwtfyKrf7ZmM6Z+uQP7u6erXUXLkb3MRo8Qem2txKKNudYGvOVV1snha1u
 hXV+ZcJ9jg2dA7LkIHUMdlAbBhFiDjaoa0mW6dF4+V5t4G0EeJ7YiA/a+Y0vjXQgi68vki1kaiG
 ASf3Q9EtwT4kIJ97L1CeKoShwoupt+ogb5VEx+evrgT2GyasRFic56sBUqx2ZaK9Y4mse/XWoOT
 NJNxfqY8bwJl8zAooq6+UgVC2easeqPS/CVn0C/K2GMPAiLMlBW5NFJd+C6bo0M6jFDENMDoJbI
 PTGvgwUU9MaQmLpiYpRpO0fSUooXN8v87SD4Hay8KxNPYJ3vW1nPYhtM97FUKuHTaM5+SgCb/DJ
 cxe4kc/K+EOGpxbIDMToO/Gts1nZPwqVhQjI/uOMYbwR2An8uaa1Vr5mefFIt5TgltMb9j0jCsU
 8XFFxG0xjs1SAcBf1DQ==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a84958e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8Hgc_-vnOkY6PsbUFoQA:9
X-Proofpoint-ORIG-GUID: xjXZCDUS9Fx23nmtyKGRLJfp8Qk_d520
X-Proofpoint-GUID: xjXZCDUS9Fx23nmtyKGRLJfp8Qk_d520
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyNSBTYWx0ZWRfX3QqhXtPC0H3h
 8mlFD65FzkdsOxy+3OTv7nGVQAi1O/F5lhaz8EnCUCxGcd5uIk9VeCexSr7FXVPGl9Y+0m0lINs
 Fv14QC1lvwcExXOABMFYKX+5hfJX0QM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180125
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

Changes in v6:
 - patch 14:
   1. Remove unused parameter from s390_clear_emul_dev_migration_blocker().
   2. Rebase to current master branch.

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

 hw/s390x/s390-pci-bus.c          | 346 ++++++++++++++++++++++++++-----
 hw/s390x/s390-pci-inst.c         | 120 ++++++-----
 hw/s390x/s390-pci-vfio.c         |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  42 ++--
 include/hw/s390x/s390-pci-inst.h |   3 +-
 6 files changed, 392 insertions(+), 127 deletions(-)

-- 
2.34.1


