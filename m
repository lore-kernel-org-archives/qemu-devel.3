Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907FCA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwAX-0008Af-PW; Wed, 30 Sep 2026 11:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAV-000899-Ue; Wed, 30 Sep 2026 11:24:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xBwAU-0001yr-1O; Wed, 30 Sep 2026 11:24:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5KKh3170646; Wed, 30 Sep 2026 15:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=AbDAO5eXNVXv/OF+dOuemX8rMU3wwulg36eO4d2Rr
 iY=; b=mc6RdzFg8V/uH7jdlaAA8Ik4i1I2jnGgHSb2EIN7Uh22YTxVK7lDMDS3M
 w9V7yJcsXQe1RfD87GwGl9jfX4Zj1ZCJQW04WVizMbeHqdMTX6IXjaWopTNAp4kZ
 zGiLI783Mabwlzo+qYoVc6nyoM6Mt0fPjMUaBkHnseDmBCwXGawEF5bhuR7aj0ZG
 f+5ktK0m0I/Uq493sW3YQypnXZu4RITZjH7swV3LMMdFZL5HNvmpfx4infxOspxp
 oVcilS70eJAjeMmV0LJ9/epZUorCTbqgnZYEIfdJLuJjSH6xSbHoB6QnqVe+pqh2
 h1BSO0WqNZ3S01VdQJLQ/HEprQTpg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5dtqq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE34AB3605823; Wed, 30 Sep 2026 15:24:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhq2et-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:24:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFOLwY19071648
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:24:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 765C85805A;
 Wed, 30 Sep 2026 15:24:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09D5358051;
 Wed, 30 Sep 2026 15:24:21 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:24:20 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 00/23] s390x queue
Date: Wed, 30 Sep 2026 11:23:57 -0400
Message-ID: <20260930152420.1956230-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXxkVu5xhUk1Nx
 l1kViyNuK8e4ANLk5RY+/Y5LtnJ64eB5BfcLD8IW8TC/GqYeMkES+O8hsoiSbfEU3w0fRO/DFNu
 OVtAQFqrWkUwAAwDnep9h+UHsJKSF0o=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abd29a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=3Vpc_HnPOIl22zd8MWgA:9
X-Proofpoint-GUID: ukwaF_rGViF6HyIC4tOMKtb2QPf6o9fK
X-Proofpoint-ORIG-GUID: ukwaF_rGViF6HyIC4tOMKtb2QPf6o9fK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX469yhDu2KqS4
 EhYrxmm4z8EZZ/jSJ9lScQj9+Rcj6ZJ61rEGmx8gZSIxJomBJpMwxxX6P2U93pJL+ciSAUSoKCf
 4ctGth74gWKe3apNvlTrFpuNxv6E+d7n8Ay8TZzrUIO3SsGv09IFd9XJ1XB7KG/Pa2E0AryFAyH
 Oz1urBWM2fyQ83vGDt22ZTwqDgWBlu2O03jE8bLP2ZeCBK5NeRFcxYTq351YEYrqtQ5iZbqF1fQ
 SSyauj2ZYl5rGnHtiRowDkJMyNPYvbTHmMqYjXzQrAgHf8kYvJySgi2L8FGHDF0xm1S64XV4z69
 o4ZjdRa7x5vDhCZU9ZkEcb+IYrvN8eLA1sUQ3SQn+ifQhVwPB1LQRemhO9wjGkxM2GgEftHuImn
 S99RQacq0Gf/3FQQjWgV5shN10chQwwjP70MJhWy6T+XJx/4pzSL2OKkLpulM19CMzxl9STt63a
 u0f79o/+3fWobj0tMZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

The following changes since commit 3876503faff51ce3a132dbbd0ab42c10f2269319:

  Merge tag 'target-misc-20260924' of https://github.com/philmd/qemu into staging (2026-09-24 13:30:19 -0700)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20260930

for you to fetch changes up to cf8299050666ee84ee400a3a0195be7598850e93:

  pc-bios/s390-ccw.img: update s390x bios (2026-09-30 09:09:14 -0400)

----------------------------------------------------------------
New s390x features for 11.2
 - enable boot via virtio-net-pci
 - PCI and SCLP fixes
 - hardening fixes throughout
 - regenerate s390-ccw.img


Eric Farman (10):
  virtio-ccw: Limit ISC to MAX_ISC
  virtio-ccw: Do not overwrite existing indicators
  virtio-ccw: Fix rc check in read configuration path
  vfio/ap: Clear error object pointer after non-fatal errors
  vfio/ccw: Clear error object pointer after non-fatal errors
  hw/intc/s390x: Fix payload to KVM_HAS_DEVICE_ATTR ioctl
  hw/intc/s390x: Fix check after g_try_realloc
  s390x/css: Use datastream pointer for checking no-data CCWs
  s390x/sclp: Reject short headers in PV case
  pc-bios/s390-ccw.img: update s390x bios

Janosch Frank (1):
  s390x: Expose pv attribute in QOM

Matthew Rosato (3):
  s390x/pci: Fix frame stepping in rpcit_service_call()
  s390x/pci: Use qemu_log_mask() for guest-triggered errors in
    reg_ioat()
  s390x/pci: Reject apertures beyond IOAT capacity in translation mode

Maximilian Immanuel Brandtner (1):
  s390x/sclpconsole: fix indentation for console_reset

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

 docs/system/s390x/protvirt.rst          |  11 +++
 hw/char/sclpconsole.c                   |  18 ++---
 hw/intc/s390_flic_kvm.c                 |   8 +-
 hw/s390x/css.c                          |  28 +++++--
 hw/s390x/s390-pci-inst.c                |  25 +++++-
 hw/s390x/s390-virtio-ccw.c              |  13 ++++
 hw/s390x/sclp.c                         |   6 ++
 hw/s390x/virtio-ccw.c                   |  29 ++++++-
 hw/vfio/ap.c                            |   4 +
 hw/vfio/ccw.c                           |   2 +
 hw/virtio/virtio-net-pci.c              |   1 +
 include/hw/s390x/s390-pci-bus.h         |   1 +
 pc-bios/s390-ccw.img                    | Bin 112408 -> 112408 bytes
 pc-bios/s390-ccw/main.c                 |   2 +
 pc-bios/s390-ccw/netmain.c              |  73 +++---------------
 pc-bios/s390-ccw/virtio-ccw.c           |  62 +++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h           |   1 +
 pc-bios/s390-ccw/virtio-net.c           |  66 ++++++++++++----
 pc-bios/s390-ccw/virtio-pci.c           |  20 +++++
 pc-bios/s390-ccw/virtio.c               |  27 +++++--
 pc-bios/s390-ccw/virtio.h               |   4 +
 tests/functional/s390x/test_pxelinux.py |  71 +++++++++++++++---
 tests/qtest/meson.build                 |   1 +
 tests/qtest/pxe-test.c                  |  96 +++++++++++++++++++++++-
 24 files changed, 448 insertions(+), 121 deletions(-)

-- 
2.55.0


