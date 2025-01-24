Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A04C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 20:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbQBB-0005yA-Ri; Fri, 24 Jan 2025 15:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tbQB9-0005xq-Tt; Fri, 24 Jan 2025 15:21:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tbQB8-0007VE-16; Fri, 24 Jan 2025 15:21:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OGVH5G021311;
 Fri, 24 Jan 2025 20:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=TouP20aMj1pSLfzBLhwhbtGMqfUr55jEByDOeR2nV
 o4=; b=p3j+3jqyJl1J8vpcjoOZNdc0WzXYnr2N0ke99CprHFmGx8dK4PtMOTG8o
 vdrjIM6qH4akNJAAKsqKW7P+oNP7TL+6O8+bKdYvePF1DWaXq4ji4IzZHTXrigym
 ti+ki7ZB/y+wjbryv8mp0GXE15URh3egOxjomWB+us6Gevhg7XjtNoCM10m9bsjK
 tkXcZ6crDOzt2rGw61H0j1PeVFl8htCa8wNgcNFRFmDIOw9ODsVCGj+Wg9iYhIaL
 3nhSYqXMS7EK18PK0eLcrfUJSu1FD/QvW9hv3Rx+5hLBAVuKNNGrTqOjLx72/eiH
 OseZXy/UQNQ4Tmks57OiuZolObRVQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c6jnkf9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 20:21:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIfuXA024241;
 Fri, 24 Jan 2025 20:21:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yne3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jan 2025 20:21:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50OKLGrD12386894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jan 2025 20:21:16 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C3B58065;
 Fri, 24 Jan 2025 20:21:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7217458052;
 Fri, 24 Jan 2025 20:21:15 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.77.196]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jan 2025 20:21:15 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 0/2] s390x/pci: relax I/O address translation requirement
Date: Fri, 24 Jan 2025 15:21:13 -0500
Message-ID: <20250124202115.349386-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gJNoFh9Rx2mTEKj_1VeedGN3UYCBnjKs
X-Proofpoint-ORIG-GUID: gJNoFh9Rx2mTEKj_1VeedGN3UYCBnjKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=892 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series introduces the concept of the relaxed translation requirement
for s390x guests in order to allow bypass of the guest IOMMU for more
efficient PCI passthrough.

With this series, QEMU can indicate to the guest that an IOMMU is not
strictly required for a zPCI device.  This would subsequently allow a
guest linux to use iommu.passthrough=1 and bypass their guest IOMMU for
PCI devices.

When this occurs, QEMU will note the behavior via an intercepted MPCIFC
instruction and will fill the host iommu with mappings of the entire
guest address space in response.

There is a kernel series that adds the relevant behavior needed to
exploit this new feature from within a s390x linux guest.  Most
recent version of that is at [1].

[1]: https://lore.kernel.org/linux-s390/20250124201717.348736-1-mjrosato@linux.ibm.com/

Changes for v3:
- use s390_get_memory_limit
- advertise full aperture for relaxed-translation-capable devices

Changes for v2:
- Add relax-translation property, fence for older machines
- Add a new MPCIFC failure case when direct-mapping requested but
  the relax-translation property is set to off.
- For direct mapping, use a memory alias to handle the SMDA offset and
  then just let vfio handle the pinning of memory.

Matthew Rosato (2):
  s390x/pci: add support for guests that request direct mapping
  s390x/pci: indicate QEMU supports relaxed translation for passthrough

 hw/s390x/s390-pci-bus.c         | 36 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-inst.c        | 13 ++++++++++--
 hw/s390x/s390-pci-vfio.c        | 20 +++++++++++++-----
 hw/s390x/s390-virtio-ccw.c      |  5 +++++
 include/hw/s390x/s390-pci-bus.h |  4 ++++
 include/hw/s390x/s390-pci-clp.h |  1 +
 6 files changed, 70 insertions(+), 9 deletions(-)

-- 
2.48.1


