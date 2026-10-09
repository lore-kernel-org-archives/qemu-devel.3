Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F27CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFKc-0000NI-03; Fri, 09 Oct 2026 14:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKa-0000My-Kq; Fri, 09 Oct 2026 14:28:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKZ-0001de-3N; Fri, 09 Oct 2026 14:28:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HaA6s736955; Fri, 9 Oct 2026 18:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=cNUVxZuztjXjJq/C5n9mFQU94fvHTPxamPPTTIU3u
 ZQ=; b=pQLvurbXBpsZTPEIKqPKD+A8jMivMArRJyEtsBOSvx1mpNFAQAlRkJmks
 ysV8ZRDMTKpB3CD69S/u/fA9Hm1szAxU+0oUIT8BRiDHKNmI0uv1+yrzrCb20dQt
 ojZzkQFzEGXAR/OGvhWSwoAS7g1UiU6h8214WNhtbJePs/uUvFJSHde/DIQBh/fs
 NHCGDCG5AjZrJXcA5UIZ9VRy74HRKZKTGhKq7e6sHFPF4MLpBJyaJQCKur6xQ+K9
 UbUCyTPum7uGQ4/8oehEbJj+/shtT1+UlZAYPuvHGlqC5T03PySDxbo31Bf8z1dU
 9T5mosxjRa424EQw7w4MMMVAWmNKg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tdr87q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8OsJ1207063; Fri, 9 Oct 2026 18:28:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnm7n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699IRfdM30736964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:27:41 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D2535805C;
 Fri,  9 Oct 2026 18:28:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2153658054;
 Fri,  9 Oct 2026 18:28:26 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:25 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 00/19] s390x queue
Date: Fri,  9 Oct 2026 14:28:06 -0400
Message-ID: <20261009182825.148054-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=JL6uIMKb c=1 sm=1 tr=0 ts=6ac9324d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8 a=1o4XjkimgGyFC-mJATYA:9
X-Proofpoint-ORIG-GUID: L6P9U0mMllFTBVNiMYXEKd00Mom5jKMA
X-Proofpoint-GUID: L6P9U0mMllFTBVNiMYXEKd00Mom5jKMA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX3K+o7r6SE2NO
 Me1R9JFLLPoAELnMsWWJRiqJy3D7fUPRcQK3ah5w5BB4Sw5wKBY2N92iPgXomlsbryqnnexCa6J
 wALE68fY55Ego9fkhnUDNTic5WxjP/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX2qvreqX2p4TD
 gh20k5Deqc/iJH7jWMBLnm8TfWWue9YzfDuOv0FjKG8+srf6dz6ne79gpHocZpXMgVvjKUW1XOz
 OAP7pBGl1qSqNDR9lR4e6x2HzD+BBsDm2RzIW/u7MbRYyCGDr9PGY+cJrLeACGxNDcFslbgKUMn
 yXTdYvnEAzak5h/jjwFBpaAxQ3sk3mClcSprbybqC254tz6H0u2edkx5IDeiZ/TnbCzWz966aVk
 1hFiGCIIngdXnQvE402V4fcWHaegoe4tcYGb5knLXazKw2UmnuDF5qVBA+pvY5A9STOvVJAFy3k
 2J4gWpcbQGU1YDHjeJwHQCtBns+/iDN6sVorSKv4f/pSPhuDSMQNE/uO1aKUe0NC65SpA53CIHy
 NZcz/zbDwT2qQ86JJlE6mnnVNguztwJhFQRIjJTwmCkpZ6/BXqO/RoeOLDEHsdjDOvvm0EUWcA0
 X1uDNfjHTAdrWZFX2wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:

  Merge tag 'pbouvier/pr/plugins-20261005' of https://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20261009

for you to fetch changes up to 598482e3cbf449d76870730f796176da73863e13:

  s390x/pci: Reset a device in error state (2026-10-07 13:19:35 -0400)

----------------------------------------------------------------
New s390x features for 11.2
 - Enable migration of emulated zpci devices
 - Error recovery of passthrough zpci devices

----------------------------------------------------------------

Farhan Ali (2):
  s390x/pci: Add PCI error handling for vfio pci devices
  s390x/pci: Reset a device in error state

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

 hw/s390x/s390-pci-bus.c          | 549 +++++++++++++++++++++++++++----
 hw/s390x/s390-pci-inst.c         | 174 +++++-----
 hw/s390x/s390-pci-vfio-stubs.c   |   6 +
 hw/s390x/s390-pci-vfio.c         | 127 ++++++-
 hw/s390x/s390-virtio-ccw.c       |   4 +
 include/hw/s390x/s390-pci-bus.h  |  44 ++-
 include/hw/s390x/s390-pci-inst.h |   7 +-
 include/hw/s390x/s390-pci-vfio.h |   1 +
 8 files changed, 763 insertions(+), 149 deletions(-)

-- 
2.56.0


