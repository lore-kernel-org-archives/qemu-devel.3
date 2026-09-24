Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8DFC98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9pR5-0003w5-PS; Thu, 24 Sep 2026 15:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR2-0003uv-Up; Thu, 24 Sep 2026 15:48:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x9pR0-00089j-If; Thu, 24 Sep 2026 15:48:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OJ5RNd3107018; Thu, 24 Sep 2026 19:48:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7bATsgDaXvvKn75XVyIKbh4SjyCTyURtpGkbRRWIO
 uM=; b=ToZS1ihsE7cBDn+ClrJPViyxUp1j75z1TWy98XUOFP9mtvOaDjrhLECjX
 puerS3MPQNKeS0fBEVq01T+8kCuADjHyeRgTkkPO1BVilXur3+ugRO+xn7JuiAxn
 MlaYF9OaiShG9VMjR1GhF4LeF8zhrhZe1UqmxgUO1UrT5ywMOgTssxSDWLnPfCf/
 o9YR6FJfaIPN29A2jnsTlxahQgNzg79kxYItMdSV99kq78J7XeVq3OZFYP6YrdgU
 xED+VoNtCFeiIkwWIU0XP0tAiR7ZXKH5rrTYhu9Ce3NNcApu50gH0ua1bayYIRC2
 YGAAcvyPHym/x0olKohe5GdvWVz0w==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvjfuq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIlX1w2559301; Thu, 24 Sep 2026 19:48:42 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1yfj6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 19:48:42 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68OJmfGa26346140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 19:48:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6998458059;
 Thu, 24 Sep 2026 19:48:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5D1E5805C;
 Thu, 24 Sep 2026 19:48:39 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.83.151])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 19:48:39 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
Subject: [PATCH v4 0/8] s390x: Add support for virtio-net-pci boot device
Date: Thu, 24 Sep 2026 15:48:29 -0400
Message-ID: <20260924194837.80732-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uTykMACSVjTvPqC-wnJuf3kCY7Vk1b7W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX+AfrCPWapc90
 07FMCh3hQFJI0yM62KwAMzAzgxNwpP1OdcsHQ3EQp4sghVplaWioM0Q2JeJqYO41vCOLmAWnQQy
 tJ0yeVUByk3upwXZazHzOQfVl0Mzqv4=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab57e9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=45pGdx3JMv3CgJBMhCMA:9
X-Proofpoint-GUID: uTykMACSVjTvPqC-wnJuf3kCY7Vk1b7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4MCBTYWx0ZWRfX0nG03rzPrHh0
 eHhrvowihXN2ZQpLpyChHv432zx1C6XKD+5r0TKkSwcq9W7PX2Gr/Smz823k3HmRwHLXtQ/HNQ1
 SLp1bxjI+l+TauCguw4sXsGawOCJtjxmDCXUIcQZ+KyA5azqsL5Ujxh7deYBMNt5Xxk+p9Eqrmr
 oM6qnzwg7V+VnAqACc22Hd3wRBkQIkRIQkJt6PTjPT9DqYUXAOStC1NIjSx6XQ7+tWMhN59oyLm
 46sCmsJ3kaXnenoZnZoRCSsNYu2Qbo5IsOSVKPtnMco9Nub1tmAG3QNZW++9nEpdPVDxRlKafxC
 0fdAnPMJ2OPpXVYmMfyW2B7ZEY9y484hBMtUYojvyd+GytjeXZ1WF5JFSB0CXBh4IMbDTilxwTx
 U42sQPqvr31B7XWwFiEwrDCEewsbrdS9TahUxz5Y8VT1LBBE1e4a0Otc+TaqzXB4VtIB/KcC5a6
 62BGAA0KS1/SKaXGRSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240080
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

changelog v3->v4

[PATCH v3 2/8] pc-bios/s390-ccw: Add dynamic net header size handling
- Fixed the UAPI path in the commit message
- Removed the commented-out num_buffers field from VirtioNetHdr
- Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
- Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

[PATCH v3 4/8] pc-bios/s390-ccw: Add support for virtio-net-pci IPL
- Resolved merge conflicts
- Added a comment in ipl_pci_device() clarifying that all PCI devices
  use the same shared setup
- Updated the comment in netmain() to clarify that PCI devices do not
  need specific network setup
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

[PATCH v3 5/8] hw/virtio: Add "loadparm" property to virtio net PCI
devices booting on s390x
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

[PATCH v3 6/8] tests/qtest: Check s390x boot device support in pxe-test.c
- Reworded the log message for strings found in the BIOS
- Removed the comment from s390_bios_has_net_ccw() that assumes
  virtio-net-ccw is present
- Tested-by: Joshua Daley <jdaley@linux.ibm.com>

[PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to pxe-test.c
- Added a comment clarifying that the presence of the string indicates
  virtio-net-pci support
- Tested-by: Joshua Daley <jdaley@linux.ibm.com>

[PATCH v3 8/8] tests/functional/s390x: Add tests for virtio net PCI in
test_pxelinux.py
- Added "_ccw" to the existing virtio-net-ccw test names
- Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

----------------------------------------------------------------------

This series enables network booting via virtio-net-pci on s390x.

Refactor virtio-net to separate virtio-ccw specific logic and add 
support for booting from virtio-net-pci devices with proper endianness
handling. Add support for the loadparm property during network boot.

Add corresponding test coverage to verify correct network boot
functionality with virtio-net-pci devices.

----------------------------------------------------------------------

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
 pc-bios/s390-ccw/main.c                 |  2 +
 pc-bios/s390-ccw/netmain.c              | 73 +++-----------------
 pc-bios/s390-ccw/virtio-ccw.c           | 62 +++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h           |  1 +
 pc-bios/s390-ccw/virtio-net.c           | 66 ++++++++++++++----
 pc-bios/s390-ccw/virtio-pci.c           | 18 +++++
 pc-bios/s390-ccw/virtio.c               | 27 ++++++--
 pc-bios/s390-ccw/virtio.h               |  4 ++
 tests/functional/s390x/test_pxelinux.py | 71 +++++++++++++++----
 tests/qtest/meson.build                 |  1 +
 tests/qtest/pxe-test.c                  | 92 ++++++++++++++++++++++++-
 12 files changed, 322 insertions(+), 96 deletions(-)

-- 
2.55.0


