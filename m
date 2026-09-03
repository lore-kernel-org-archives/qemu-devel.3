Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD60BC624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AFN-0003ux-R0; Thu, 03 Sep 2026 12:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFJ-0003sv-Vi; Thu, 03 Sep 2026 12:25:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x2AFG-0006TX-Cs; Thu, 03 Sep 2026 12:25:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G2TYZ3425648; Thu, 3 Sep 2026 16:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=v1Ripr9fsnkIe5Qj/Zxu4IqZfleCwAwGSo8Qtd7aC
 jc=; b=n7Oz9AlFdYemVh0eMZ/73sezHzEwTo9VVESxXjJrLZv0Gy1s0T3DKYXyu
 qcvzcxdseZTV6ZAOODYVNPvekmm47NgG4gfT96/chQZmXVfMQUcaqDRNx1n9c2oC
 llhZxCRbFk/21CMO2xjlxXR/fSTVo5Iusnbglt1wkvVQm949JBh3UT7aTeZLj2lj
 +3n4nmz5PdSdIZU/iWdLjt6PCZb/8mwGRgBGyOwzg9Lht4AyUuKYurGjljzhr2O0
 0dabhi3ofHtWzG24q/p+m2kcEbsBV5zLtz+xZZgFFObNa+Z+P09d8LwZWBL0nbTd
 iq7gDXlSHAB8ekK23ZyilMudVwlVg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq555x30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:24:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683GBkgN018205;
 Thu, 3 Sep 2026 16:24:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygr9n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 16:24:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 683GOqUb25952860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Sep 2026 16:24:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A199D58053;
 Thu,  3 Sep 2026 16:24:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14D3958043;
 Thu,  3 Sep 2026 16:24:51 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.31.144])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  3 Sep 2026 16:24:50 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, jdaley@linux.ibm.com,
 pbonzini@redhat.com
Subject: [PATCH v2 0/7] s390x: Add support for virtio-net-pci boot device
Date: Thu,  3 Sep 2026 12:24:42 -0400
Message-ID: <20260903162449.2588271-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX5I0jOcEzhBqt
 3UM34Mq+Q6qEg7LJI3rKqDrzpYSyX9W9ecV30fqDq/n1sSj57ja9kaqPYdN12S8VJx1l0i6+Sgd
 arLVJY+nfbEkw/ULJZNWn817MS3R1JrzdsKWgZAjOxb3I+iT/CM/Eik5UvvQBGUq8LXUNEFFCbs
 4wLci9HWE02pgw7GofXtcqv7eu72sxJy5NvkSVHOwkNqTT5FSUxIcqE985bYjBdOosO10Mfkh3l
 eQfEI30v3QPk862rbElbdtCdBBzacCjGQKTd2a3vEMreN0pERiRIiuzsGg2PdiuTo9MkCvBr0rj
 hH/oZDXFxDIX+ml7xu6EG8m0D4tEYYfMuHZO3Ar+gq93avb7dIG2RfdF38Ss+nYEBd80byQqNHd
 hnxj4VUkgXLdFDblGBzL7nZJAXQmwJLEhWTo34UoF1a55pK6MHNoTrNA/JKaRdtZxj6QR5/MnxQ
 XyZmWz8RnGkHJGAnlQw==
X-Proofpoint-ORIG-GUID: 19zhxaTRlVDsqO-i8SS1j18JjbXSWGT7
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a999f56 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=iIYZgLNloAHDBwNDlPYA:9
X-Proofpoint-GUID: 19zhxaTRlVDsqO-i8SS1j18JjbXSWGT7
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MCBTYWx0ZWRfX6rC0uT6gUZql
 hPXmWXBajcCjioi4Hbo55D3M1SU1TIwKXipfunKBwZVdNN0z4pR/lBT5jJrsYWoeWhvtWDEHuz3
 xROFXfCDW3Wvxx0Pegu4d4owKwE/d0U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030140
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

changlog v1->v2

pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
- Removed the virtio_net_setup() dispatcher; netmain.c now calls
  virtio_ccw_net_setup() directly
- Improved the error message to be CCW-specific

pc-bios/s390-ccw: Add dynamic net header size handling
- Defined VirtioNetHdrMrgRxbuf, which includes VirtioNetHdr and a
  num_buffers field
- Defined header size constants using the sizeof() each struct

pc-bios/s390-ccw: Introduce virtio_tswap helpers
- Edited the commit message to mention that only 16-bit helper function
  is used in this commit
- Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

pc-bios/s390-ccw: Add support for virtio-net-pci IPL
- Updated the commit message to change "adds" to "extends" when
  describing endianness handling
- Removed net specific setup/find for PCI device
- Checked for virtio initialization failures during network device
  initialization

hw/virtio: Add "loadparm" property to virtio net PCI devices booting on s390x
- Edited the commit message to avoid implying that PCI netboot will fail
  if a valid loadparm is not provided.

tests/qtest: Add s390x virtio net PCI test to pxe-test.c
tests/functional/s390x: Add tests for virtio net PCI in test_pxelinux.py
- Tested-by: Joshua Daley <jdaley@linux.ibm.com>

----------------------------------------------------------------------

This series enables network booting via virtio-net-pci on s390x.

Refactor virtio-net to separate virtio-ccw specific logic and add 
support for booting from virtio-net-pci devices with proper endianness
handling. Add support for the loadparm property during network boot.

Add corresponding test coverage to verify correct network boot
functionality with virtio-net-pci devices.

Zhuoying Cai (7):
  pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
  pc-bios/s390-ccw: Add dynamic net header size handling
  pc-bios/s390-ccw: Introduce virtio_tswap helpers
  pc-bios/s390-ccw: Add support for virtio-net-pci IPL
  hw/virtio: Add "loadparm" property to virtio net PCI devices booting
    on s390x
  tests/qtest: Add s390x virtio net PCI test to pxe-test.c
  tests/functional/s390x: Add tests for virtio net PCI in
    test_pxelinux.py

 hw/virtio/virtio-net-pci.c              |  1 +
 pc-bios/s390-ccw/main.c                 |  1 +
 pc-bios/s390-ccw/netmain.c              | 74 ++++---------------------
 pc-bios/s390-ccw/virtio-ccw.c           | 62 +++++++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h           |  1 +
 pc-bios/s390-ccw/virtio-net.c           | 67 ++++++++++++++++++----
 pc-bios/s390-ccw/virtio-pci.c           | 18 ++++++
 pc-bios/s390-ccw/virtio.c               | 27 +++++++--
 pc-bios/s390-ccw/virtio.h               |  4 ++
 tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++----
 tests/qtest/meson.build                 |  1 +
 tests/qtest/pxe-test.c                  |  1 +
 12 files changed, 234 insertions(+), 94 deletions(-)

-- 
2.55.0


