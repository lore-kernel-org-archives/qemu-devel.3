Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7DDC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CSI-00072M-1X; Mon, 14 Sep 2026 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS4-0006yb-U1; Mon, 14 Sep 2026 15:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x6CS0-00046i-Uc; Mon, 14 Sep 2026 15:34:51 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJ1jtU2881717; Mon, 14 Sep 2026 19:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=BFNV0dLUqCrILITs9e7oU5Qgur8NFIhEXv+5tB838
 OM=; b=eicrdLZ4Y9VR1RvZJb3+ITMcQBN2i5HpWq8vF0Wk7DtWJnE0srMYqxmPP
 lAkCrxeW0OWiXEKGbsEEz+eSll82iZGn2qpDMwFpGD9yoak7ZMEzdv6bZldypsXc
 pX03p4YLpsAPknR9/ZQewRVJyxkLtFG7PHWAQEwDKL/CRTVzFvTS2WYqZKlTeshP
 JzpTp2G9B7MLhq4va4+/m7+g9B0BRh9jOMYSix0tCBR2o4gjLMt1gxtA0+PSlD4L
 JuiwDIjLMu7cFKecWdjVhpuMcM9PPqe3DrxYtR6t1AZH4hGZjhm4wfs6rEBv82Dg
 ZsYCBoJvku6X2Nx24vIrD/uMtwiAw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83km2n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EIoqps2764002; Mon, 14 Sep 2026 19:34:43 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgqryq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 19:34:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EJYggp12714528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 19:34:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 341BF5805B;
 Mon, 14 Sep 2026 19:34:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D2BC58059;
 Mon, 14 Sep 2026 19:34:40 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.78.15])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 19:34:40 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v3 0/8] s390x: Add support for virtio-net-pci boot device
Date: Mon, 14 Sep 2026 15:34:30 -0400
Message-ID: <20260914193438.526407-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX6MP0iCP6IgDe
 1jviox3568DWj7rkmAxcKBVfupmKDtNaed3TVar0uI3S2GgYL8Qkqyd5yoDxHtOJkARK4xDQhXv
 LiCKneODX8+JDA2mbSLdwGFd4qugscgJ8mCLUaQH43OHKSXZnCqqhVgpBWHGssbj+EiQ7qKNkpa
 0HVNMG3hY9zVeeWjRMzWWi56oFq9xHgLfy48Qjw/ryhaevJtSSyuc51L9LVvCAWs8fcUHWVD8lH
 lrJUzBJq9Y+60IxN8jc0Ak/Lua24OFveI+6hYuVNmgbbmwBNsBdgzLsypt72cXdIV4uBNm/MqTD
 icJQq2Eu32tFD+x7sXeMbNw0HzggR4HCuxYBWemcw+GDCcez2ToBTqZPvO0EJHS1rPBTW0bcl7V
 m8+bARl33yySSY30/bVUglDCEVk/zNnq9OGktgLBJSVFmYP+TBMjcmIvVo6qLnDoNOI+6Xj5TIv
 pOvY8VLdn3qnDVFTPpw==
X-Proofpoint-ORIG-GUID: 7kxrvu_KD4lMwXHDk0nC44K-lsKqqX60
X-Proofpoint-GUID: 7kxrvu_KD4lMwXHDk0nC44K-lsKqqX60
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI3OCBTYWx0ZWRfX8+tg/IJt8x/w
 OeffX7wwFBFSkxFr+7PwQhXopd6G7JPvZ0wHppvzei+Su+AQVdejXB8dcX/dtG9ec11KzNsKFHh
 ooz3XcDCKNSa6IJ6TU11X0t9tDxPNvo=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa84c54 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=SBNHMdAdBLmPPA6r004A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140278
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

changelog v2->v3

Added a new patch, "tests/qtest: Check s390x boot device support in
pxe-test.c", which gracefully skips the test when the network boot
device is not supported by the bios.

[PATCH v2 1/7] pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
- Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

[PATCH v2 2/7] pc-bios/s390-ccw: Add dynamic net header size handling
- Removed VIRTIO_NET_F_MRG_RXBUF_BIT, as it is never negotiated.
- Updated the commit message to note that the same structure mappings
  are replicated as defined in the UAPI.

Re: [PATCH v2 3/7] pc-bios/s390-ccw: Introduce virtio_tswap helpers
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

[PATCH v2 4/7] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
- Simplified virtio_pci_get_net_config().
- Removed cmd_vr_idx initialization for net devices.
- Added a comment indicating that byte swapping is required when other
  fields are used in the net config.
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

[PATCH v2 5/7] hw/virtio: Add "loadparm" property to virtio net PCI
devices booting on s390x
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
- Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>

----------------------------------------------------------------------

This series enables network booting via virtio-net-pci on s390x.

Refactor virtio-net to separate virtio-ccw specific logic and add 
support for booting from virtio-net-pci devices with proper endianness
handling. Add support for the loadparm property during network boot.

Add corresponding test coverage to verify correct network boot
functionality with virtio-net-pci devices.

----------------------------------------------------------------------

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

Zhuoying Cai (8):
  pc-bios/s390-ccw: Move CCW net setup to virtio-ccw
  pc-bios/s390-ccw: Add dynamic net header size handling
  pc-bios/s390-ccw: Introduce virtio_tswap helpers
  pc-bios/s390-ccw: Add support for virtio-net-pci IPL
  hw/virtio: Add "loadparm" property to virtio net PCI devices booting
    on s390x
  tests/qtest: Check s390x boot device support in pxe-test.c
  tests/qtest: Add s390x virtio net PCI test to pxe-test.c
  tests/functional/s390x: Add tests for virtio net PCI in
    test_pxelinux.py

 hw/virtio/virtio-net-pci.c              |  1 +
 pc-bios/s390-ccw/main.c                 |  1 +
 pc-bios/s390-ccw/netmain.c              | 74 +++-----------------
 pc-bios/s390-ccw/virtio-ccw.c           | 62 +++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h           |  1 +
 pc-bios/s390-ccw/virtio-net.c           | 65 ++++++++++++++----
 pc-bios/s390-ccw/virtio-pci.c           | 20 ++++++
 pc-bios/s390-ccw/virtio.c               | 27 ++++++--
 pc-bios/s390-ccw/virtio.h               |  4 ++
 tests/functional/s390x/test_pxelinux.py | 71 +++++++++++++++----
 tests/qtest/meson.build                 |  1 +
 tests/qtest/pxe-test.c                  | 91 ++++++++++++++++++++++++-
 12 files changed, 323 insertions(+), 95 deletions(-)

-- 
2.55.0


