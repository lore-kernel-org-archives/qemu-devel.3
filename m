Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4A1C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 02:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr59W-0005jY-2W; Mon, 03 Aug 2026 22:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59G-0005dg-K9; Mon, 03 Aug 2026 22:44:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1wr59E-0005Bx-VR; Mon, 03 Aug 2026 22:44:58 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6741J2W03658654; Tue, 4 Aug 2026 02:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RvqNLQJvsKK6WbwRJUY16zLqLGKNNzI4bzXE2aknq
 RQ=; b=HIu1U5jX8618YhhVuQ3uyCYbBZ1jxp9XgOzYf6x5q1sPnCQsxuGk+1B3M
 dhRueD1F4fKcogtyMxL74fTsovJBN2H2guznAqFEMIpOwo6msTJhyTbrHcevA+Ee
 6bcyj6rOAGFaK7eWpAG84C+yaNCyaONu+6LVT5zKv93SRUkIwM4RoAYOXpjVf2GP
 LIIrwzfa41NSgFRAWTo76JU1f8q8MCA/Khelx98To5p5/i1+SrXzKtggbM40pVPr
 6J73DhxYMBdF/LYZyXz7wOizkONNYLZnC9wnHLWBJ9uZJhmEMi2MEJjdgQ+0pH9F
 wZRxwWuENIuutWJYPtklzlfXxEnzA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4urgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6742fVdJ022387;
 Tue, 4 Aug 2026 02:44:50 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg7vg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 02:44:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6742in8429360882
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Aug 2026 02:44:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4363758052;
 Tue,  4 Aug 2026 02:44:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C3FE58045;
 Tue,  4 Aug 2026 02:44:48 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.58])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Aug 2026 02:44:48 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v5 00/15] s390x/pci: Implement migration for emulated devices
Date: Mon,  3 Aug 2026 21:44:28 -0500
Message-Id: <20260804024443.56445-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfX6sku8FZguG36
 4rh5XY/5oU59PdeicXj2Y3i7xkRbk1D7GFaSdWlczoNiUN8jE5vjPnnt8vPKpaH74HVFzN8fTUX
 0YXfLEG6H9n9GhUgfOQQjsupgS+8DQw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDAxNiBTYWx0ZWRfXyRyTBfw+8fFO
 Nv6CIiY/rjPspjoORrH7dnwvwTPDoqUFVnXy07vlh+XMTkdLx4sTIUyJkyTNjjAyi0j1Q2rSGdH
 +MiSRmb1GwYWyaoA34ruf2H3wbjnaSoaXrqoTxNktC/CuP25cVCIfJbKkUevHy8xTC+A1Z037cd
 y0WfXXqJZMfJphCykkm9C4df8YIp6ftvLGS/sahjuakfixANQx4I8b89CIp2JyR7+epUvtsiUws
 gfT90VRz9pE5Cw6d8jiMq9JnnujWrJthx3yAdnMVkudD1oW16HdcWASfYwhXGg4lCDbQCnQCzD5
 dztn/JbBw/9R+6iNRKDdq9FRZABa+zA/a6+ZaSeIRSzK2ZJeA1vz3fgBWfQ/eBkWosHJnJJ4dYa
 JKIUj1rnyAQAZ8o0JRqN053Hl81Y0WJcgX5rtRt3p+aPJpVLt3f4Z8C0yq2EnuXhy6yln+Pc7Sv
 kDV7u5vrwN4i53bpx6w==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a715223 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=8Hgc_-vnOkY6PsbUFoQA:9
X-Proofpoint-ORIG-GUID: 5_hl2Q1IaVQXX6U-ToCJr6IWxXWBb83F
X-Proofpoint-GUID: 5_hl2Q1IaVQXX6U-ToCJr6IWxXWBb83F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040016
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kshk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Changes in v5:
 - patch 1:  Fix compile error.
 - patch 14: Improve the comment explaining pre_load/post_load(), swap order of calls to s390_set_passthrough_migration_blocker() and s390_pci_msix_init().

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

 hw/s390x/s390-pci-bus.c          | 340 ++++++++++++++++++++++++++-----
 hw/s390x/s390-pci-inst.c         | 120 ++++++-----
 hw/s390x/s390-pci-vfio.c         |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  42 ++--
 include/hw/s390x/s390-pci-inst.h |   3 +-
 6 files changed, 386 insertions(+), 127 deletions(-)

-- 
2.34.1


