Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3205C982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 20:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8kJq-0005kU-3L; Mon, 21 Sep 2026 16:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJZ-0005e6-Ei; Mon, 21 Sep 2026 16:08:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x8kJX-0005Jl-C8; Mon, 21 Sep 2026 16:08:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LF8HWO4193480; Mon, 21 Sep 2026 20:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=OjwmN7reEsnkM1a6zNNf7Edq2G6P
 5rrn1Ksi6qpAjxA=; b=DM+VIvDqcrxqWoRNWRRBsbNJg0f8C+OdBpqC3Ao5P3Vq
 YuU1sP8F3EsC5IOOLdLmabe0T6mPAqgVJH8djuhI7pFVNQTtMVryQwQxaGdCDcD7
 6k9U5c1exVnnEqlEs9SSAtGPedYn/o4ESYiju4KwDsefavXkxoTQQRDOM/+Co/wa
 eu7F+iuLmCJVcKTORT0oFj4r2NkfKrP///W4/h7OpkkxitsOzfYiwA3HW0wt7zfA
 YjYtMp4ocTjcuqAUwZVXv8A/EVcwP1YAYAT8j3YlAMkwZoI0YRtchEXiKYzfp2lV
 aWe7q+3qOoZNUBBZdwptecQOlupPxPuC/CH9Fnk8hA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1jh5r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LJQhJ21431714; Mon, 21 Sep 2026 20:08:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vf01q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 20:08:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68LK8VSP17105494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Sep 2026 20:08:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E9BC58059;
 Mon, 21 Sep 2026 20:08:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E88CF58043;
 Mon, 21 Sep 2026 20:08:30 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.69.195]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 21 Sep 2026 20:08:30 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 00/33] s390x queue for 11.2
Date: Mon, 21 Sep 2026 16:07:57 -0400
Message-ID: <20260921200830.1302919-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qa5trnhyWDw1H65Fm2HmSE201C5me4Am
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab18ec1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=Rcyg4spMU6PcZBU5hLoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX2OdV3+rgBcgr
 6apHOvhAPMvBIZkODBJ175JetD1CK8wo2xmRKK7/tkHhvQA8rJbtHHwKZIo2atenkYWOo67Dv8S
 +1fEJ9GaBEah3Fxoa9b8xHghTEsVZLA=
X-Proofpoint-GUID: qa5trnhyWDw1H65Fm2HmSE201C5me4Am
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI5NCBTYWx0ZWRfX8y9dy8EThcEg
 lRnJSxtyV3J7Yoxlfztw9CSxtINhPqVE99rLbazc2eZkc98xXj9E6Pn4soSINLRKXKEINzt0sZh
 gePDG61z7nrUBTlRsrHuXHl5bjgsik4ze1IcbJQ61c1W3gzu5+itx7LXZCm1WGYgcCDE9TSoe2k
 y1v1LrJvz6vNRnTvje2HJlThT82ArIokiFr+pAb7r85HnkytDnGjwd6vOkzI2iHCSUAc4d2VFjk
 QOAJQErQzoQJShQCvYasYNX/krxNtgrNZYGr+OHqeIydfA84I+LN2u4+UndlZNcGOzx2WANHUc7
 7BNd+dm4HnVO+1/l2PeoJ+qzTcjP1WyVJDUjwh9EBoRwxaluWx8cYpU/+1BUDKgLGK/D6LfV8iR
 Od7QsP0QdCeqb2YkWTmVzOzwD1yUaoVFzoqhyfoY6A0jtZGi5tyAH63cc2EsiaVXqeY61t2g4RJ
 kKeyflE9cSWPHAt/tKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210294
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

The following changes since commit c1c18d1e640b64292859ce9f30f3c344edfb0294:

  Merge tag 'virtio-snd-migrate-pr-v2' of https://gitlab.com/epilys/qemu into staging (2026-09-19 10:41:53 -1000)

are available in the Git repository at:

  https://gitlab.com/efarman/qemu.git tags/s390x-20260921

for you to fetch changes up to 96bd689997443a15f259fa99a6a672eb1f65062c:

  pc-bios/s390-ccw.img: update s390x bios (2026-09-21 11:46:02 -0400)

----------------------------------------------------------------
New s390x features for 11.2
 - extend CPACF support
 - enable secure IPL for virtio-blk-pci
 - enable boot from virtio-scsi-pci
 - regenerate s390-ccw.img

----------------------------------------------------------------

Eric Farman (1):
  pc-bios/s390-ccw.img: update s390x bios

Harald Freudenberger (20):
  target/s390x: Fix missing privileged flag at PCKMO instruction
  target/s390x: Rework s390 cpacf implementations
  target/s390x: Move cpacf sha512 code into a new file
  target/s390x: Support cpacf sha256
  target/s390x: Add helper functions for copy memory to and from guest
  target/s390x: Adjust addressing mode checks for sha512 and sha256
  crypto: Add aes-helpers file to support some AES modes
  target/s390x: Support AES ECB for cpacf km instruction
  target/s390x: Support AES CBC for cpacf kmc instruction
  target/s390x: Support AES CTR for cpacf kmctr instruction
  target/s390x: Minimal AES XTS support for cpacf pcc instruction
  target/s390x: Support AES XTS for cpacf km instruction
  target/s390x: Base support for cpacf protected keys and pckmo
  target/s390x: Support protected key AES ECB for cpacf km instruction
  target/s390x: Support protected key AES CBC for cpacf kmc instruction
  target/s390x: Support protected key AES CTR for cpacf kmctr
    instruction
  target/s390x: Minimal protected key AES XTS support for cpacf pcc
    instruction
  target/s390x: Support protected key AES XTS for cpacf km instruction
  docs/s390: Document CPACF instructions support
  tests/tcg/s390x: Add tests for CPACF instructions

Jared Rossi (8):
  pc-bios/s390-ccw: Check if a PCI function is already enabled before
    trying to enable it
  hw/s390x/ipl: Fix incorrect PCI IPL block lengths
  pc-bios/s390-ccw: Use bus specific IPL_TYPE directly for scsi IPL
  s390x/ipl: Add PCI and bus fields to IplBlockQemuScsi
  pc-bios/s390-ccw: Abstract virtio_run() for generic use
  pc-bios/s390-ccw: Add support for virtio-scsi-pci IPL
  s390x: Find scsi-pci boot device and build IPLB
  tests/qtest: Add s390x PCI SCSI fallback test to cdrom-test.c

Joshua Daley (3):
  hw/s390x/ipl: Add secure boot support to PCI dev IPLB builder
  tests/functional/s390x/test_secure_ipl: Skip test if SIPL not
    supported by hypervisor
  tests/functional/s390x/test_secure_ipl: Add virtio-blk-pci boot dev
    case

Omar Elghoul (1):
  s390x/pci: fix DMA slot leak on I/O TLB entry replacement

 crypto/aes-helpers.c                      | 106 +++
 crypto/meson.build                        |   1 +
 docs/system/s390x/cpacf.rst               | 143 ++++
 docs/system/target-s390x.rst              |   1 +
 hw/s390x/ipl.c                            |  48 +-
 hw/s390x/ipl.h                            |   2 +
 hw/s390x/s390-pci-inst.c                  |   5 +-
 include/crypto/aes-helpers.h              | 109 +++
 include/hw/s390x/ipl/qipl.h               |  15 +-
 pc-bios/s390-ccw.img                      | Bin 112408 -> 112408 bytes
 pc-bios/s390-ccw/clp.c                    |   4 +
 pc-bios/s390-ccw/main.c                   |  19 +-
 pc-bios/s390-ccw/virtio-blkdev.c          |   1 -
 pc-bios/s390-ccw/virtio-ccw.c             |  17 -
 pc-bios/s390-ccw/virtio-ccw.h             |   1 -
 pc-bios/s390-ccw/virtio-pci.c             |  31 +-
 pc-bios/s390-ccw/virtio-scsi.c            |  18 +-
 pc-bios/s390-ccw/virtio.c                 |  21 +-
 target/s390x/gen-features.c               |  31 +
 target/s390x/tcg/cpacf-arch.h             | 251 ++++++
 target/s390x/tcg/cpacf.h                  |  63 ++
 target/s390x/tcg/cpacf_aes.c              | 986 ++++++++++++++++++++++
 target/s390x/tcg/cpacf_sha256.c           | 197 +++++
 target/s390x/tcg/cpacf_sha512.c           | 211 +++++
 target/s390x/tcg/crypto_helper.c          | 445 +++++-----
 target/s390x/tcg/crypto_helper.h          | 100 +++
 target/s390x/tcg/insn-data.h.inc          |   3 +-
 target/s390x/tcg/meson.build              |   3 +
 target/s390x/tcg/translate.c              |  16 +-
 tests/functional/s390x/test_secure_ipl.py | 157 +++-
 tests/qtest/cdrom-test.c                  |   8 +
 tests/tcg/s390x/cpacf-kdsa.c              |  58 ++
 tests/tcg/s390x/cpacf-kimd.c              | 166 ++++
 tests/tcg/s390x/cpacf-klmd.c              | 206 +++++
 tests/tcg/s390x/cpacf-km.c                | 590 +++++++++++++
 tests/tcg/s390x/cpacf-kmac.c              |  58 ++
 tests/tcg/s390x/cpacf-kmc.c               | 351 ++++++++
 tests/tcg/s390x/cpacf-kmctr.c             | 360 ++++++++
 tests/tcg/s390x/cpacf-pcc.c               | 245 ++++++
 tests/tcg/s390x/cpacf-pckmo.c             |  45 +
 tests/tcg/s390x/cpacf-prno.c              | 131 +++
 tests/tcg/s390x/cpacf.h                   | 570 +++++++++++++
 tests/tcg/s390x/meson.build               |  10 +
 43 files changed, 5487 insertions(+), 316 deletions(-)
 create mode 100644 crypto/aes-helpers.c
 create mode 100644 docs/system/s390x/cpacf.rst
 create mode 100644 include/crypto/aes-helpers.h
 create mode 100644 target/s390x/tcg/cpacf-arch.h
 create mode 100644 target/s390x/tcg/cpacf.h
 create mode 100644 target/s390x/tcg/cpacf_aes.c
 create mode 100644 target/s390x/tcg/cpacf_sha256.c
 create mode 100644 target/s390x/tcg/cpacf_sha512.c
 create mode 100644 target/s390x/tcg/crypto_helper.h
 create mode 100644 tests/tcg/s390x/cpacf-kdsa.c
 create mode 100644 tests/tcg/s390x/cpacf-kimd.c
 create mode 100644 tests/tcg/s390x/cpacf-klmd.c
 create mode 100644 tests/tcg/s390x/cpacf-km.c
 create mode 100644 tests/tcg/s390x/cpacf-kmac.c
 create mode 100644 tests/tcg/s390x/cpacf-kmc.c
 create mode 100644 tests/tcg/s390x/cpacf-kmctr.c
 create mode 100644 tests/tcg/s390x/cpacf-pcc.c
 create mode 100644 tests/tcg/s390x/cpacf-pckmo.c
 create mode 100644 tests/tcg/s390x/cpacf-prno.c
 create mode 100644 tests/tcg/s390x/cpacf.h

-- 
2.55.0


