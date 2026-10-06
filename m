Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88B2CA5FF0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2026 00:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDst3-0004DG-Bb; Mon, 05 Oct 2026 20:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrY-0003xc-Us; Mon, 05 Oct 2026 20:17:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1xDsrW-0001Ep-A2; Mon, 05 Oct 2026 20:16:56 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZhUe1131377; Tue, 6 Oct 2026 00:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=PAqABZVEC1wjcMl4gPCVVZlg7n6SUuRmu8uHKDpc7
 E0=; b=eFnfOkAc7MiXZ4wDd6QAK3JveUAJIVn0fkEYeZt73n9zAivDKfd+oMB+E
 3xp22XOwOvUTrnKhj3TGhierWd9VFViF3I2TvzXPOSXaOc/BW0vk1/45Bj6iIJL6
 c40zSqVcOZQYXrO6LwrnochECiLNVVgF4ufAuo8A8Q34+Cq1mXN/WsEWlSFD/WlL
 ofqA65n4lX2U6DitRBGwubOLMQjGkX+neqHwcLb+w4pV5puHNUuvuvrcS/iZgZS7
 clkkr4TrJXvZ1oCrhV/N9y9pEYzIMoq55yprJraGYg4FNEcaZq4XQ0XKq6gizluw
 29QbtdrqwdoSiTRPWCBolUTSfgBTw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jmq7e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695M13Z83252046; Tue, 6 Oct 2026 00:16:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy7ghv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Oct 2026 00:16:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6960GlkP28508456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Oct 2026 00:16:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B65F5805F;
 Tue,  6 Oct 2026 00:16:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BA4D58059;
 Tue,  6 Oct 2026 00:16:46 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.ibm.com (unknown [9.61.249.221])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Oct 2026 00:16:46 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v12 00/17] s390x/pci: Implement migration for emulated devices
Date: Mon,  5 Oct 2026 19:16:26 -0500
Message-Id: <20261006001643.420929-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bpzR4KuCbqVFgGEHHy5h3EKoxsgK1iIv
X-Proofpoint-GUID: bpzR4KuCbqVFgGEHHy5h3EKoxsgK1iIv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX4l0/Ap9Ah+I7
 e7T4RGw/xLP2KYRPOohJjv3eMe1Ehf0Ot6nG9OMmJQBLdk2aIxu0WdRBBZpyR/qiS3ZrYjMMCAp
 cLuvXHvWVBsHGM6Wj8pq1PAq0fyS5q8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMCBTYWx0ZWRfX9A8ZQxMEFOeX
 fHvMdorstNb9H4OZBjEJaI1M84xCRekMrhNDhx4EbRItopFbt3EMEsOeC+x+PqU/qDIOUMmIGJj
 R3O7hiYAayax2+5GrziR6VXP7bvC0D1q8pwBwTbqNCKjEkcbVNSJdjeEI1YXAp40kg8/LFTuUob
 W09hzSVIRffBFi1gcUHl2tgV8uLGOmGDw0enT8tUM7n6zxxSnVBasK3TU0eUzJdtsKQOSgBHNYC
 Kc3OF04WS2Px6qQw0vmADnva5YwZRgGzVoo1JOSlVzuyR3G2sKAccsyp6ETYHhFeiTwrmSP21zE
 DMsYDIDXj23XXDZSFfcqyITigC1RugtresIA5j0O/5fp3Bg6F+9/pL7AElRKdqHNVK/cCy2a1Yh
 EUkzaCN3dd4F5OIqzY7veSBPeoU1vcTXRV7cJspjXr+gpCU5agRNuVn4PKv26i4odQ2b36Jvj0W
 ByBa6eOaDMSocF1kTbw==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac43df1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8 a=wcoRInvKOzgKvaFYn4kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060000
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

ATTENTION! This series is built to apply on top of https://gitlab.com/efarman/qemu/-/tree/s390-next.

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

Changes in v12:
 - patch 14: Add a message to an error path that didn't have it.
 - patch 15: New. Extract here an isolated change from the next patch to make it smaller.
 - patch 16 (formerly 15):
   - Simplify error handling on s390_pci_ioat_validate() failure,
   - Put an assert() with a comment into unreacheable branch.

Konstantin Shkolnyy (16):
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
  s390x/pci: Move ioat sanity checks into new function, add error
    message
  s390x/pci: Provide each zpci device with a unique stable bus "path"
  s390x/pci: Implement migration for emulated devices
  s390x/pci: Create function to contain fmb_timer start

Matthew Rosato (1):
  s390x/pci: implement IOMMU replay

 hw/s390x/s390-pci-bus.c          | 528 +++++++++++++++++++++++++++----
 hw/s390x/s390-pci-inst.c         | 174 +++++-----
 hw/s390x/s390-pci-vfio.c         |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  43 ++-
 include/hw/s390x/s390-pci-inst.h |   7 +-
 6 files changed, 611 insertions(+), 149 deletions(-)

-- 
2.34.1


