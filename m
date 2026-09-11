Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E86C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x534s-0008J4-Ea; Fri, 11 Sep 2026 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534b-0007y1-Uf; Fri, 11 Sep 2026 11:21:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kshk@linux.ibm.com>)
 id 1x534V-0004jo-VL; Fri, 11 Sep 2026 11:21:53 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BF1tAA971927; Fri, 11 Sep 2026 15:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=bwSmlDH3sQi7yQLerCZ2ecfHC6bceZTIj895AnRzO
 T8=; b=KPwyZiAqGHqIoovBvo9K+T2Y3TIrf4SU7UqUaFbenIYKjRi6JFXWH4gCk
 2nR+oKGCiFzRV8jYuqLwTsLVW+soaP42ZjF7liyB7Ic3oka6aEYSZUw4OqDfocCj
 Bvt8jVNi3/yFkSkQN1+2Vojlnirg4sp8ccHf2h0/RmZxOnkYFuLLQ1NloZGfYPoy
 1kVV3reHXtfFDesy5zmpYlW5rEUHBbpoKdhhm7p3YaE/7ioS+vcZ2cmcY5/LU0+m
 IMH83RvjtpRSrzA6MxZ5q8Quv339ppsznGL/RfLw9e0zTnfSik7/ZzFD2dbKHTO7
 Z+1GJknlUpIy4MWLws8kn0XBdH7KA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qc916-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEo8nr1834075; Fri, 11 Sep 2026 15:21:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhq3fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 15:21:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BFLdDx42729776
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 15:21:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C244658064;
 Fri, 11 Sep 2026 15:21:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C92F5805D;
 Fri, 11 Sep 2026 15:21:39 +0000 (GMT)
Received: from WIN-DU0DFC9G5VV.atx-us.ibm.com (unknown [9.16.62.165])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 15:21:39 +0000 (GMT)
From: Konstantin Shkolnyy <kshk@linux.ibm.com>
To: mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Konstantin Shkolnyy <kshk@linux.ibm.com>
Subject: [PATCH v8 00/16] s390x/pci: Implement migration for emulated devices
Date: Fri, 11 Sep 2026 10:21:21 -0500
Message-Id: <20260911152137.676602-1-kshk@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: luM83Oy9XrjwDyfu1CjsLTX8cDJSjArz
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfX/F5bTVma+7Wm
 J1xoNq3ZqE5BswxPBfwC8tyn/b9IkthqgPSco1cnf4+kfN8gr1Wjm4+ogIpY/BTki/w8fAf0ANP
 0QM4bgF7FHE99hs7MT87IVWkIl1fddE=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa41c85 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=RHnMokx2QV9RFc-MFfwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxMCBTYWx0ZWRfXxGPstIcz5Off
 5v5j8PMPz03t8cKFVjzzJ0S7GoZlPNU5pez4ZEzjZeAdAJCassxUG2TLkLwZzcmXhZmlHWaKNKl
 mfPl4gihYEtBjuj6fVM5ILNXnYFI1uJg2nOFSK1fTaAXGY00L71rNPZtnnoq5cs8cYpNyhaWw8t
 FNnvbJmYglp6KikLRrLTKfre4o7zWnb1VNU2j/1OBJClisYyEcJeRj7DmJxKaldLFjXWciwS+mK
 4q5K4cwrPzGz1dANXfxJ4hpZbxZZfH7ZweUTM+6bFXNFo/LNzv7+VniCHQDPFUZPtZJkofWtq1E
 eXF1iwS9ZCEO8+1wc/YRFyMLNH/36rtIlCGwsNZHLtLQtTuc3K7l484XdVb2iDICeLv3mlRCpE6
 DWrncBeA41dbgnWOnPL1F68bpgBCdSsNr5uUynPAK2Pk/yauW9xYrGSMTluGeWGFUUSap+I6BaJ
 M0/N/NuD5DSD1paRgwg==
X-Proofpoint-GUID: luM83Oy9XrjwDyfu1CjsLTX8cDJSjArz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110210
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

Changes in v8:
 - patch 1: Improve s390_pci_ioat_replay().
 - patch 3..12: Change commit messages as asked by Matt Rosato.
 - patch 13: Clarify comment above S390PCIIOMMU.
 - patch 14: New.
 - patch 15 (formerly 14):
   - remove "Reviewed-by"
   - set .priority to MIG_PRI_IOMMU for the new s390_pci_device_vmstate;
   - add checks for bad values in the incoming migration stream;
   - make sure a zpci device with no PCI function still blocks migration;
   - move zpci blocker from TYPE_PCI_DEVICE plug/unplug() to TYPE_S390_PCI_DEVICE;
   - add proper cleanup on error paths of s390_pcihost_plug(TYPE_PCI_DEVICE);
   - migrate pending zPCI SEI events;
   - sync zpci_fn .uid and .fid to the incoming migrated values;
   - Don't migrate max_dma_limit and pci_unplug_request_processed;
   - few cosmetic non-functional changes.

Konstantin Shkolnyy (15):
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
  s390x/pci: Factor ioat sanity checks into a separate function
  s390x/pci: Implement migration for emulated devices
  s390x/pci: Create function to contain fmb_timer start

Matthew Rosato (1):
  s390x/pci: implement IOMMU replay

 hw/s390x/s390-pci-bus.c          | 462 +++++++++++++++++++++++++++----
 hw/s390x/s390-pci-inst.c         | 159 ++++++-----
 hw/s390x/s390-pci-vfio.c         |   4 +-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  47 +++-
 include/hw/s390x/s390-pci-inst.h |   7 +-
 6 files changed, 540 insertions(+), 143 deletions(-)

-- 
2.34.1


