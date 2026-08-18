Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7427C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 20:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwQof-0007vf-Vg; Tue, 18 Aug 2026 16:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoT-0007tr-K1; Tue, 18 Aug 2026 16:53:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wwQoS-0000h6-3f; Tue, 18 Aug 2026 16:53:37 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IJW3Mh1293672; Tue, 18 Aug 2026 20:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6l220jUA7xuZkFNxwh+Cnu8Z8yiVPWP6UAbwQqil/
 K0=; b=T0REla9O3yvhdICYb5a1LsBxGNuCD4PJIOJF2YwLIl6zTd7PtAI+EGSqo
 hnzJFmqvvUIrcsOsFqzgyOnA3x/dGMhNlilPmiBQ2lnAve0ClmK+kcxeRp++dCPF
 D1mffedgF7uPiah9bk73gPgg6fG6GlZvTpoqiGA6vVAkvmfOXleE29z2ceJ3m1G7
 uLn3gEfCik/jkZ3k8oMWJ82Fl71nDBK41zg/HCrufEY72K5wnzi8S//ECpSP+hf1
 XhEb3EOXfejHyLToC4hAmphduPQsKbN12DTSVvLEI3GSeBvMoDKXC+CEdPNSRxWo
 3ZSzGCwoamfb/G9Co25umCaJP6PKQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frta884-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfO7M015919;
 Tue, 18 Aug 2026 20:53:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yd5df-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 20:53:31 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IKrUZk19464720
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 20:53:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C84458052;
 Tue, 18 Aug 2026 20:53:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B16A758054;
 Tue, 18 Aug 2026 20:53:28 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.136.182])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 20:53:28 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v1 0/7] s390x: Add support for virtio-net-pci boot device
Date: Tue, 18 Aug 2026 16:53:17 -0400
Message-ID: <20260818205324.580199-1-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a84c64c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=nu1vrW9ghEIse-_-r-UA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX7T0ACiuzFvoU
 OPYzsuZrpjKwzKuvoXW5BS4MN/r/FlyDc4RJOqDsF3gF+5vaYOM0DZ5ziT5aBxsueUVvmEOhAeK
 6MuFxhUf3/csBd4BgH2SemBUHv9yXzA=
X-Proofpoint-GUID: R1mLSrqmULi8Q92pfeNLfVS0HRFXXZOY
X-Proofpoint-ORIG-GUID: R1mLSrqmULi8Q92pfeNLfVS0HRFXXZOY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfXyUNfsV+MROKx
 wdUSXD+1txqrYCm3KwMgcsYxXbPZYSapZz0yd3Z20US/J47UzZuXQSacq7tVLXrrHGWGqYrS5LS
 T7ujc4/Y39eM6X98NUclBLPUh9hvUQgTNg00Wxbm1QwUgv402n5KSWbfYItL7Vx9daR55TEQdmH
 z7awax4Nxsq5HS3nldVdf2BqMOTBAaVLcEWSb0S0XWnV29ZpmZY35akduc5hB6T/Nak2XGKrzGB
 JpyYet1yUASLsNuT0tNy4Sz25yJCVVRV+WMv9xeyDFW1rsfXd3ebqcQewnf3vh1XS51jNh9Bxij
 qAeH9W6ttzHyArYZAOcUVd813mJH4c/6uK0jvm7rI7AmEZOOGRVnTug5t8vbto3HNa1u18a3Rhw
 TPOAgzQlZlvUYTovS/VTpDEzsyRBbP+IN+9Uc2FPtrPe1EA9XOsOevUgbk0wc+cwgaFGLfcZBob
 2cF2hYISqw3sqwvQ8jQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180150
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

This series enables network booting via virtio-net-pci on s390x.

Refactor virtio-net to separate virtio-ccw specific logic and
create generic virtio-net helpers, and add support for booting
from virtio-net-pci devices with proper endianness handling.
Add support for the loadparm property during network boot.

Add corresponding test coverage to verify correct network boot
functionality with virtio-net-pci devices.

Zhuoying Cai (7):
  pc-bios/s390-ccw: Split virtio-ccw and generic virtio net
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
 pc-bios/s390-ccw/netmain.c              | 64 +---------------------
 pc-bios/s390-ccw/virtio-ccw.c           | 62 +++++++++++++++++++++
 pc-bios/s390-ccw/virtio-ccw.h           |  1 +
 pc-bios/s390-ccw/virtio-net.c           | 69 +++++++++++++++++++-----
 pc-bios/s390-ccw/virtio-pci.c           | 43 +++++++++++++++
 pc-bios/s390-ccw/virtio-pci.h           |  2 +
 pc-bios/s390-ccw/virtio.c               | 27 +++++++---
 pc-bios/s390-ccw/virtio.h               |  5 ++
 tests/functional/s390x/test_pxelinux.py | 71 ++++++++++++++++++++-----
 tests/qtest/meson.build                 |  1 +
 tests/qtest/pxe-test.c                  |  1 +
 13 files changed, 254 insertions(+), 94 deletions(-)

-- 
2.55.0


